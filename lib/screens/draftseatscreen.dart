import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// TOP-LEVEL CONSTANTS
// ─────────────────────────────────────────────
const double kSeatSize = 52;
const double kSeatGap = 8;

// ─────────────────────────────────────────────
// ENUMS & CONSTANTS
// ─────────────────────────────────────────────
enum SeatStatus { available, selected, booked }

class SeatColors {
  static const available = Color(0xFF22C55E);
  static const selected = Color(0xFFF59E0B);
  static const booked = Color(0xFFEF4444);
  // driver color kept if needed elsewhere, but driver row removed
  static const driver = Color(0xFF6366F1);
}

// ─────────────────────────────────────────────
// SEAT PLAN SCREEN
// ─────────────────────────────────────────────
class SeatPlanScreen extends StatefulWidget {
  const SeatPlanScreen({super.key});

  @override
  State<SeatPlanScreen> createState() => _SeatPlanScreenState();
}

class _SeatPlanScreenState extends State<SeatPlanScreen> {
  int totalSeats = 40;
  int seatColumn = 5; // fixed to 4 (or change as desired)
  final Set<int> selected = {};
  final Set<int> booked = {3, 7, 12, 18, 21, 25};

  void toggleSeat(int no) {
    if (booked.contains(no)) return;
    setState(() {
      selected.contains(no) ? selected.remove(no) : selected.add(no);
    });
  }

  ({int left, int right}) get splitConfig => switch (seatColumn) {
    3 => (left: 1, right: 2),
    4 => (left: 2, right: 2),
    5 => (left: 2, right: 3),
    _ => (left: 2, right: 2),
  };

  double get aisleGap => seatColumn == 5 ? 20 : 32;

  SeatStatus statusOf(int no) {
    if (booked.contains(no)) return SeatStatus.booked;
    if (selected.contains(no)) return SeatStatus.selected;
    return SeatStatus.available;
  }

  // ── Simplified Seat Widget (flat, no shadow) ──
  Widget _buildSeat(int no, {bool ghost = false}) {
    if (ghost || no > totalSeats) {
      return SizedBox(width: kSeatSize, height: kSeatSize);
    }

    final status = statusOf(no);
    final Color bg;

    switch (status) {
      case SeatStatus.available:
        bg = SeatColors.available;
      case SeatStatus.selected:
        bg = SeatColors.selected;
      case SeatStatus.booked:
        bg = SeatColors.booked;
    }

    return _SimpleSeat(
      seatNo: no,
      color: bg,
      isBooked: status == SeatStatus.booked,
      onTap: () => toggleSeat(no),
    );
  }

  // ── Row Builder ──
  Widget _buildRow(int startSeat, int count) {
    final (:left, :right) = splitConfig;
    final leftCount = count < left ? count : left;
    final rightCount = count - leftCount < 0 ? 0 : count - leftCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left group
        Row(
          children: List.generate(left, (i) {
            final seatNo = startSeat + i;
            return Padding(
              padding: EdgeInsets.only(right: i < left - 1 ? kSeatGap : 0),
              child: _buildSeat(seatNo, ghost: i >= leftCount),
            );
          }),
        ),
        // Aisle
        SizedBox(
          width: aisleGap,
          child: Center(
            child: Container(
              width: 2,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        // Right group
        Row(
          children: List.generate(right, (i) {
            final seatNo = startSeat + leftCount + i;
            return Padding(
              padding: EdgeInsets.only(left: i > 0 ? kSeatGap : 0),
              child: _buildSeat(seatNo, ghost: i >= rightCount),
            );
          }),
        ),
      ],
    );
  }

  // ── Full Grid ──
  List<Widget> _buildGrid() {
    final normalRows = totalSeats ~/ seatColumn;
    final lastRowSeats = totalSeats % seatColumn;
    final rows = <Widget>[];

    for (int i = 0; i < normalRows; i++) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _buildRow(i * seatColumn + 1, seatColumn),
        ),
      );
    }

    if (lastRowSeats > 0) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _buildRow(normalRows * seatColumn + 1, lastRowSeats),
        ),
      );
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    // selectedList is no longer used (confirm removed), but kept for potential future use
    // final selectedList = selected.toList()..sort();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── AppBar Area ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  children: [
                    const Text('🚌', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    const Text(
                      'Seat Plan',
                      style: TextStyle(
                        color: Color(0xFFF8FAFC),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    if (selected.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF59E0B).withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          '${selected.length} selected',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Bus Card (driver row removed) ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.09),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Driver row removed entirely
                        // Just the seat grid directly
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: _buildGrid()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Legend ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    _LegendDot(color: SeatColors.available, label: 'Available'),
                    SizedBox(width: 16),
                    _LegendDot(color: SeatColors.selected, label: 'Selected'),
                    SizedBox(width: 16),
                    _LegendDot(color: SeatColors.booked, label: 'Booked'),
                  ],
                ),
              ),

              const SizedBox(height: 20), // consistent bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SIMPLE FLAT SEAT (no shadows)
// ─────────────────────────────────────────────
class _SimpleSeat extends StatefulWidget {
  final int seatNo;
  final Color color;
  final bool isBooked;
  final VoidCallback onTap;

  const _SimpleSeat({
    required this.seatNo,
    required this.color,
    required this.isBooked,
    required this.onTap,
  });

  @override
  State<_SimpleSeat> createState() => _SimpleSeatState();
}

class _SimpleSeatState extends State<_SimpleSeat> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isBooked
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.isBooked
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
      onTapCancel: widget.isBooked
          ? null
          : () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: Container(
          width: kSeatSize,
          height: kSeatSize,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(widget.isBooked ? 0.6 : 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '${widget.seatNo}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LEGEND DOT (unchanged)
// ─────────────────────────────────────────────
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
