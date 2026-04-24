Return-Path: <netdev+bounces-281067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOlQFGHx62nWTAAAu9opvQ
	(envelope-from <netdev+bounces-281067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:40:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD6463D81
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C4C303010A
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1D37D115;
	Fri, 24 Apr 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="jXiZTnWY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="6Gah3koJ"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf126.lhr1.oracleemaildelivery.com (acj35aaf126.lhr1.oracleemaildelivery.com [130.35.116.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73535AC29
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070321; cv=none; b=FRbShPjzFfc4nuZieajPdTQDdEzUObeDItCtnFTe0+SKNLlHlvGtVHAqxU31cmqrS+QtPnomSttI5hpfPEzdvEZbab990PlrAFT2BpVj+qxle6Hb65xxVDF63RSPfYSoYo6O4YDfnLWwJIFsZQ2r49AM3peuTFpfcp1CwXy13oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070321; c=relaxed/simple;
	bh=xUJwXvMkpWSDYRXgzCZLsd+EsgdoCgW8I52ZPmglP2Y=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=JkbzPQMw2qqg49SCGALTFV0CpOchy+4Jvb6qEoejKgfh3Qee4AWxHldcqezpIyLSkXR1VUii41r5DXQDZOMmQ5nqYRmyNtG79I3VXONU39GoyVrS1p29VcsCiEZFXG4wTrJ7ew4XCVeXAYWcbxPqmiJUX1Dv0khAl5ikhyWERJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=jXiZTnWY; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=6Gah3koJ; arc=none smtp.client-ip=130.35.116.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PuNCSuhDY3aqUFt5mHJ3ZpNiytDxGYxQFnYjsTy8j+M=;
 b=jXiZTnWYwDGQ7gZeSDBaYTeQocXetHQYnnQme7EA1hzK/HZ+0qOVmutX1s9PrFB+TIb+cFib1KUJ
   +s2iTQ04y7CEcdiWgqGRnerRPRv3yCImBicHqFk7LQ+2hU4HdwtQos+JGCM+cGYtoUtnQ3SLd0wE
   Yo592gtEGOJqX5graM22O8MAdlyuBD6gGQwEaJB8RaAd3C04HX7M2SGHRMyd1UWgpaNZk3/J/+cX
   Mep/3Bhzaie6foC0FNDJrRUTcwbZ2zSfRW8OEqRxr+NzKUxFqFPXMHP1fIWRruKhg3+d5HmNIzEy
   1UbaF/LxbbF9WPbXnVTc7AykFOyzI32HTMlhlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PuNCSuhDY3aqUFt5mHJ3ZpNiytDxGYxQFnYjsTy8j+M=;
 b=6Gah3koJuEV9uqe2DPZ1BnhNLS8s3c3xt7AMdVbF+XlkyCT6nQGzt03pKDt6O7p2oUXbPZaKcljZ
   V2GHm1mBvPttH0jpnHEihJih5SjDn+jSXXbIsckXNRdBU6Li4z8KFaxDmdJ/HE/VHmh4WLYJKXqO
   vRWoY7Y1lY7khHNlQAgQ4i45aXKCfG8Q54gEN6cGpTlO7rD3Kg5MqxYHZEHZnLjtqwVGU+WJhgYF
   1yrxQ3MH9mDw39/Ea7a6AO2KYBpx/DktQlOYTjCxQkYnjZ1xNrLoK+fVEWFTPfPp2RAWvD3TEfMU
   B3n5QnDjtQ2DnpX5eNmHcSkpBCHmMdBzkI3zkw==
Received: by omta-ad1-fd1-402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TE0001IRS8AB850@omta-ad1-fd1-402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 24 Apr 2026 22:38:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH net-next 0/3] net: macb: candidate fixes for silent TX
 stall on BCM2712/RP1
Date: Fri, 24 Apr 2026 23:38:30 +0100
Message-id: <cover.1777064117.git.lukasz@raczylo.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFzDiYTuS9jvqSCDQoXiqVnkU2yDl7DFh57yZB8VktRLO86c1eFyO5ekvNWCLwV
 PHyd9gw8WA5srfV/TRD60HPcqN0ckK5QcJL8GxoA66ySSfFo1PcOK2lmmEbtUZw5
 PiAmw5/lJh5no0aLuB1SPnuvKcHlQ2Gm6Cy97g5ocVN/a69uZW69m4pRsqFnUGLp
 DvzMrxjfu8rd+J9GyYMD7Cq0Y4N1mnotj19RrXunseXJyWXRxQj5zFaH01Ln95Ja
 UOq+zonMcrYjihIVuuCRABOhGMpd0ca4AQdA3DBzcQ/muCjmmQGFcSIkmCisx+Ot
 ICiewyf8d8fpB6ZsJGir6DwMwR61Hh42uctgnzcfrUHwfB6WwBzX+RlPo+I6k5Wv
 GzPWVXfSbdD6wStUq7S5mIYEEOLTHtEnCDMh0/HqxGZ4L766Y7vXjBrS4Bu0KA==
X-Rspamd-Queue-Id: A7CD6463D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-281067-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	NEURAL_HAM(-0.00)[-0.759];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raczylo.com:mid,launchpad.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi netdev, Nicolas, Claudiu, linux-rpi,

This series proposes three candidate fixes for the silent TX stall
observed on Raspberry Pi 5 (BCM2712 SoC, Cadence GEM via RP1 PCIe
south bridge).  The bug has been reported, with reproducers, at:

  * https://github.com/cilium/cilium/issues/43198
  * https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877

Cilium #43198 reports reproduction on linux-raspi 6.17.0-1004, and
explicitly notes reproduction with both Cilium/eBPF and
Calico/nftables dataplanes (i.e. not CNI-specific).  We observe the
same failure mode on kernel 6.18.24 built from raspberrypi/linux
rpi-6.18.y @ f2f68e79f16f, across a 24-node Raspberry Pi 5 fleet.
The 6.17/6.18 commonality and the two-CNI reproduction together
put the root cause below the packet-scheduling layer, in the macb
driver or the RP1 PCIe path.

Observed symptoms (our side, 6.18.24; consistent with the linked
reports):

  * queue->tx_tail stops advancing at a single second;
  * /sys/class/net/<iface>/statistics/tx_packets stops incrementing;
  * qdisc backlog grows past zero; netif_stop_subqueue() is called;
  * RX counters continue advancing; the MAC IRQ line continues to
    fire (RX completions are handled);
  * no kernel log line is produced for the duration of the stall;
  * dev_watchdog does not fire: macb_netdev_ops has no
    .ndo_tx_timeout, and our reading is that trans_start is kept
    fresh by successful xmit prior to the ring filling;
  * recovery on our side has required `ip link set <iface> down/up`
    via an out-of-band watchdog DaemonSet.

Reading the current driver we identified three plausible races
between driver and hardware, each of which could independently
produce the observed behaviour.  We did not determine which is the
actual root cause -- that likely requires either BCM2712/RP1
documentation we do not have, or dynamic tracing of the driver
during an in-situ stall.  The series therefore attempts to close
all three, with each commit message stating which specific race
that patch is targeting.

  Patch 1/3 -- flush PCIe posted write after TSTART doorbell.
  Writes to NCR are posted PCIe writes and may not reach the MAC
  before the driver returns.  If the TSTART doorbell is lost, no
  TX starts, no TCOMP arrives, and the ring goes quiescent.  A
  read-back of NCR after the write is a standard read-after-write
  PCIe flush.

  Patch 2/3 -- re-check ISR after IER re-enable in macb_tx_poll().
  An existing comment in macb_tx_poll() notes that completions
  raised while TCOMP is masked do not re-fire when IER is
  re-enabled, and mitigates the window with macb_tx_complete_pending(),
  which inspects driver-visible ring state only (after rmb()).  On
  PCIe-attached parts the descriptor DMA write that sets TX_USED
  can remain in flight when that check runs; the rmb() orders CPU
  writes but does not retire peripheral DMA.  Reading ISR directly
  after IER re-enable addresses this in two ways: (a) the MMIO read
  is an architected PCIe read barrier for prior DMA writes, so a
  subsequent macb_tx_complete_pending() sees up-to-date TX_USED
  state; (b) it directly observes a pending TCOMP bit if the
  hardware has one set.  Either signal reschedules NAPI.

  Patch 3/3 -- TX stall watchdog.  Defence-in-depth.  If patches
  1 and 2 close the races we identified, this patch performs a
  single spin_lock_irqsave/unlock and a branch per queue per
  second with no other effect.  If a further race remains that we
  have not identified, it invokes the driver's own existing
  macb_tx_restart(), which already verifies that TBQP is behind
  tx_head before re-asserting TSTART.  We include this patch
  because we have empirically observed multi-minute stalls on this
  hardware; we are willing to drop it if the preference is for
  1 and 2 to stand alone.

Status and testing:

  * Apply-tested against Linux net-next HEAD (this series is
    generated from it) and against raspberrypi/linux rpi-6.18.y @
    f2f68e79f16f (the fork our fleet runs): all three apply
    cleanly on net-next; the rpi fork carries an additional local
    `bool tx_pending` field on `struct macb_queue` that is not in
    mainline, so we maintain a small rebased patch 3 hunk for it.
  * Build-tested: the series compiles cleanly as part of our Talos
    image build pipeline on arm64.
  * Runtime-tested, early signal: ~4 h 20 min of post-patch uptime
    on the canary node, ~3 h 15 min on the slowest (last master to
    upgrade), ~95 node-hours cumulative across the 24-node fleet at
    the time this cover letter was written.  During that window the
    fleet-wide counts are zero RECOVER events, zero `[tx-stall]`
    partial markers (an out-of-band userspace detector that records
    even transient one-second freezes that recover before the
    3-second threshold), and zero ping-failure markers.  Pre-patch
    reference window (2026-04-24 14:00-18:10 UTC, when proper
    monitoring was in place) observed multiple stalls per hour at
    fleet level; at that rate we would expect on the order of 50
    stalls in 95 node-hours, actual is zero.  We will follow up
    with a 24 h and a 1-week data point as the same observability
    runs forward; the direction so far is consistent with patches
    1 and 2 closing the underlying race(s) and patch 3 correctly
    being a no-op on healthy hardware.

The series does not depend on any other in-flight work we are
aware of.  Happy to split, rebase, or drop individual patches on
feedback.  All three are independently revertable.

Lukasz Raczylo (3):
  net: macb: flush PCIe posted write after TSTART doorbell
  net: macb: re-check ISR after IER re-enable in macb_tx_poll
  net: macb: add TX stall watchdog as defence-in-depth safety net

 drivers/net/ethernet/cadence/macb.h      |  5 ++
 drivers/net/ethernet/cadence/macb_main.c | 99 +++++++++++++++++++++---
 2 files changed, 94 insertions(+), 10 deletions(-)

-- 
2.53.0


