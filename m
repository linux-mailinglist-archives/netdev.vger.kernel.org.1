Return-Path: <netdev+bounces-288086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKoKAENIBmo3hwIAu9opvQ
	(envelope-from <netdev+bounces-288086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D8654758E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FDFD30778E1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B13D1AB3;
	Thu, 14 May 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="ml3z/PcQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="ap3AfDvQ"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf84.lhr1.oracleemaildelivery.com (acj35aaf84.lhr1.oracleemaildelivery.com [130.35.116.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E33D0BEC
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795703; cv=none; b=KRxixHV9NF5H8vEiLCzRjjOYohrl6YRVRypXKnMHcLuxYcqUxzANi5utdPHd8BoKfmwubqOFS8aFqwLFcbdnvPB8K5qIsc79VTYbtE7SUlz9QwLmnSfQS62kA1UE5zjkMh4gv+rN13i0gk7ie6OVSnFPNqvf5KJUbrf3U1j10bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795703; c=relaxed/simple;
	bh=PipobQV8GzD2uy/Yc+uPejUYe/8lnLIqddXK5EZzE2U=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=QQ2kUpTsDWeNCIBhHjxFA/Eyv3qwnvtR0yXFBuRmgJ61+Atd+1fMFbyE8e65qvhlCTV+kQjuhI4nlW0+yxKNcBOcaKUxPZedf7BvdQd+IQH3hYkmJoQXljiSakbpzRvv7wjvf/oD9GpNRDRAX0SuJKkeTswTteWmUW3IMnJk+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=ml3z/PcQ; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=ap3AfDvQ; arc=none smtp.client-ip=130.35.116.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Y0VxplqXo7KwodoVFRokARH6ngjpKYSLboSPOiip+Ho=;
 b=ml3z/PcQnNB4+KyGkzr1ppRyY3b9eav4IITiORcVyUbEBuJLyg3VzgJ0nnWS2jM/tVq3nQGXI2o5
   NDblxyQD+wIqt3ltMlMPma1VElnnG33NPnfSvNMDtHwWngPR5F0m5bU/YI7v4UqgjWHzT4qESAi0
   +CL0n0F520tHoV7BT/BRZMwbQMm/VBB/PkwLVyQEFk9LJwWAJN347UBuEe7ulsJSYPDfH56RfUyo
   oinoRrG4Bk2sv6nA27Pv6MRQ23YZ7VidNE5OfF4BcGnMwutIo4fAxhC57B2l74qjyBm3WKBmNCPj
   7dHoeCmZgc1BZ71cxUnScwxehXCuqLjpy0Hkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Y0VxplqXo7KwodoVFRokARH6ngjpKYSLboSPOiip+Ho=;
 b=ap3AfDvQK0ifwzn3mk7eTU0hX3PEvu4PiZFXtGcyCWRpfGHDE/zfvJSQqEwaDGpjtM2U23RXUSlW
   p30gjMofu2mBDaTD3vpeBmIL9wo50xHMTGDtm0UFhIKXLl2y44B7gYmeZMcv7xe6Ma/IxRG3Eit8
   N6qmOYWRD6EYwuBdPk8SQ4+YPDieTgPAIiupk+jxf96iN/ET0dpAvY/h6/zj1OoEMLGu+82vC/J8
   7qQZh9bBSTbuo+k+I7QdfHxpjY/W45Mr4eaGvHz/folmOLuLEiNemN6/uQykmuO9zNiYQhSOJPe6
   s9ZwEunv7ZrMCKePiToXEFSNQf3PVsd/OxARdQ==
Received: by omta-ad1-fd2-1402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF10AG1DRJO5X10@omta-ad1-fd2-1402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Thu, 14 May 2026 21:55:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH net-next v2 0/3] net: macb: candidate fixes for silent TX stall
 on BCM2712/RP1
Date: Thu, 14 May 2026 22:54:56 +0100
Message-id: <20260514215459.36109-1-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <cover.1777064117.git.lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHf+Z0YX8zBMsksb6gSGL9ZV3VCbo9am2PhbSO1iipMaVnbSZPP4U7YWpbXzRHK
 g669lhZ1JQctwueluqllYAuNG1sS6Qw9c21Imo7/Z9nzjSa7t8SqcmtIFar5g3Yt
 Ij2hVqHRCB2nMgUSHQ3gY3zHeT3V1SgwQNHusr0dJUtl2EhQinx8QYlYPTk/q6no
 oyDsV03BDzjEK5FjIyLSTz7+N+bxcmLT+l8v/vOhfNXL0p4tENJlCsYXr59fbx7U
 41VPRtTBo2tfpT5HelozDOGZCc0pKxJwRfrh7r4D0BUmtS7DBjRQYPHzJzO1zYwR
 w6o60TG8TnWe2blKyBDH7YXmaBVFkrRrlu8tnPNTetSr7cbJEoxNkqAPVQBw6zjB
 puIc5+PgMJZ1nG78bMRJ32zb5hXU2K4/enF+ab+/61lN0jOg3U/URBOZr8hwFyo=
X-Rspamd-Queue-Id: 18D8654758E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.778];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raczylo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi netdev, Théo, Andrea, linux-rpi,

v2 of the silent TX stall series.  The v1 RFC sits at:

  https://lore.kernel.org/netdev/cover.1777064117.git.lukasz@raczylo.com/T/

Reframing first.  The v1 cover claimed "zero events post-patch";
that was true at the user-space watchdog visibility level only.
A dmesg sweep prompted by Andrea's review -- with patch 3's warn
made unconditional, per his ask -- revealed kernel-level evidence
that patches 1 and 2 are partial at best.  Patch 3 is empirically
the load-bearing fix on this platform: it caught and recovered a
real lost-TCOMP stall on pi-data-02 at 2026-05-05T13:24:09Z
(queue 0, tail=259564431 head=259564433 after ~260M TX, HW
ETHS tx_frames counter advancing through the event while driver
tx_tail did not) without user-space involvement.

So the v2 narrative reads:

  * Patch 1 (PCIe posted-write flush) and patch 2 (PCIe read
    barrier before descriptor check) close two specific
    candidate races in the TSTART / TX_USED paths.  Plausible
    and well-motivated, but I cannot prove either fires in
    isolation on this hardware -- my 1 Hz trace shows TX
    freezes, not which mechanism caused them.

  * Patch 3 (TX stall watchdog) is the safety net that
    empirically does the recovery work.  13 days of production
    runtime on 24 nodes since 2026-05-02 in the same form
    (anchored against the rpi-6.18.y vendor fork, in
    raspberrypi/linux#7340 -- merged 2026-05-08 after review
    feedback from pelwell that this v2 incorporates).

The v1 cover's "zero stalls in 95 node-hours of post-patch
uptime" framing was misleading.  Apologies for that.

## What changed in v2

Patch 1 (PCIe posted-write flush after TSTART doorbell):
  * Gates the readback behind a new MACB_CAPS_PCIE_POSTED_WRITES
    capability, set only on raspberrypi_rp1_config.  v1
    applied the readback to every macb variant; SoC-integrated
    parts (Atmel, Microchip, SiFive, Xilinx) have no posted-write
    fabric and were paying the readback latency for no benefit.
  * Commit message notes that the readback also flushes the
    preceding macb_tx_lpi_wake() NCR write on the same path --
    not just TSTART -- since it functions as a PCIe read barrier
    for all prior posted writes by the same requester.

Patch 2 (PCIe read barrier before TX completion descriptor check):
  * Dropped the ISR read.  v1 read ISR in macb_tx_poll() with
    `queue_readl(queue, ISR) & MACB_BIT(TCOMP)`; that's
    destructive on RP1 silicon (MACB_CAPS_ISR_CLEAR_ON_WRITE
    is not set on raspberrypi_rp1_config; the existing handler
    assumes read-clear semantics and processes every bit
    returned from queue_readl(queue, ISR) in one pass).  v1's
    masked-and-discarded read silently consumed any other bit
    set in ISR at that instant -- RCOMP being the worst case
    (RX completion never scheduled until the line re-asserts).
  * v2 substitutes `(void)queue_readl(queue, IMR)` -- IMR is
    the read-only interrupt mask mirror, no side effects, still
    flushes prior peripheral DMA writes via PCIe completion
    ordering.  Loses the "directly sample latched TCOMP" half
    of v1's claim; keeps the PCIe-barrier half, which is the
    half that addresses the documented race in the existing
    macb_tx_complete_pending() rmb() comment.

Patch 3 (TX stall watchdog):
  * Tail movement is tracked via a `bool tx_stall_tail_moved`
    set by macb_tx_complete() under tx_ptr_lock when tail
    advances, and cleared by the watchdog tick on the same lock.
    v1 snapshotted tx_tail and compared between ticks; while
    that worked correctly given tx_tail is free-running u32,
    the bool form is unambiguously cleaner, doesn't depend on
    counter behaviour, and is what pelwell asked for when he
    reviewed the same series on the rpi side
    (raspberrypi/linux#7340).
  * netif_carrier_ok() gate added at the top of the watchdog
    tick.  Eliminates the boot-time false positive seen in v1
    where, between macb_open() and link-autoneg-completion,
    queue->tx_head can advance from kernel-queued packets while
    tx_tail stays at 0 (no TCOMPs yet), tripping the snapshot
    check.  Observed 6 such fires during a 2026-05-02 fleet
    rolling reboot.
  * netdev_warn_once -> netdev_warn_ratelimited.  v1's
    netdev_warn_once made operational accounting impossible
    after the first fire on a given netdev; ratelimited keeps
    bounded log noise but lets operators count events.  Andrea
    asked for this directly.

Patches 1 and 3 are independently revertable.  Patch 2 v2 is a
two-line readback before an existing check; trivially revertable
in isolation, semantically dependent on the existing
macb_tx_complete_pending() recovery path that it strengthens.

## What I haven't done

  * TSO+SG-off canary.  rtheobald (cilium#43198 #4188846955)
    and the launchpad #2133877 commenter (#34) both report
    TSO+SG-off *together* mask the stall; my matrix has TSO+GSO
    tested off, not TSO+SG.  Happy to canary-test this on one
    node if reviewers want the data point before deciding which
    of patches 1/2 the SG path actually exercises.

  * Per-patch isolation testing.  All three deployed
    simultaneously on the 24-node fleet; I cannot independently
    prove patch 1 or patch 2 does anything on its own.  Patch 3
    has direct production evidence (lost-TCOMP recovery
    described above).  If reviewers want a bisection-style
    canary I can stagger one-patch / two-patch / three-patch
    nodes for >=1 week each.

## Status and testing

  * Mainline-anchored:  v2 builds clean against current net-next
    HEAD, applies cleanly.  Boot-tested and brief-sanity in a
    canary build before this send.
  * raspberrypi/linux rpi-6.18.y anchored equivalents:  in
    production on 24 nodes since 2026-05-02 (now 13 days); in
    raspberrypi/linux master since 2026-05-08 (6 days).
  * The v2 patch 2 IMR-barrier form was rolled to all 24 Pi
    nodes earlier today (2026-05-14, ~14:00 UTC) as a
    vendor-fork-anchored update.  ~120 cumulative node-hours
    of runtime since: zero mid-runtime TX stalls; zero user-space
    watchdog RECOVER events.  Cover-letter-thread reply with
    detail accompanies this series.

The series does not depend on any other in-flight work.  Happy
to split, rebase, drop, or restructure on feedback.

Lukasz Raczylo (3):
  net: macb: flush PCIe posted write after TSTART doorbell (PCIe-only)
  net: macb: insert PCIe read barrier before TX completion descriptor
    check
  net: macb: add TX stall watchdog to recover from lost TCOMP interrupts

 drivers/net/ethernet/cadence/macb.h      | 14 ++++
 drivers/net/ethernet/cadence/macb_main.c | 95 ++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

-- 
2.54.0


