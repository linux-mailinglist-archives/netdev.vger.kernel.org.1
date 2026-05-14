Return-Path: <netdev+bounces-288084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOoSK1ZHBmo3hwIAu9opvQ
	(envelope-from <netdev+bounces-288084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:06:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBE6547557
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6EB8302BE3C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07D3CD8B5;
	Thu, 14 May 2026 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="XHmWM63h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="FWKEPpYh"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf118.lhr1.oracleemaildelivery.com (acj35aaf118.lhr1.oracleemaildelivery.com [130.35.116.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95163AA1AE
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795496; cv=none; b=fTd7BBlH74fTY47suvl2fzXNcloy0Dax6QNLMR95RHf/C7s8S8QQuLr2/ZZ4JesVu6C+Sg9cOvWOs7LOR429+7cOL3tkrfFph9HZ+fjZJJRYkIKvbXbVuexBpLoY4gFuVlizI0d/3reSbEarrNpWoa7spWhYQSSCiaGv1G5/byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795496; c=relaxed/simple;
	bh=v1WbssdjlAYsj76P2Oqd446UGI6DiRZfUFIUbs26B6s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=lbvSa/yn7Efp+a2RuUhj4oq2pcv5H2gBtO2Z2NETxSDIjCgS3YtVXt5NMpf/HCpNeBiGaLNS1NHU1sFY/r6ajS/nrEsLZBgDHwpWvkrwveR+6pB5aQo0eduZegjvZOkzWUga2qBm1ss1CqI6oQy6C4mYytyo0Ug0EukyfX49E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=XHmWM63h; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=FWKEPpYh; arc=none smtp.client-ip=130.35.116.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=zytAQkalIZDBrKG7HNFd87+dd8k5KjA5x/4SFOlRADY=;
 b=XHmWM63hH6hB+UBuhkN2ds52BvtS6l86qvWJ9dOSsewHmikzKF+l8VHoJqU3geua7eZqYg70TFUk
   JGQMSq8cDCI+cKcVUIxOVItnFpiWKUrvRjUa2LSiCoJxfGWRv2VVTP+zuRV2iPBiEnJG0EpF/5YZ
   InF743UuRfYKKaE7vdJZPSmPS6u6XN4NH4DrQKpEP0gN1Mw8B4jVZ8BpdqwINImKUQIaKGgW3sTJ
   A5jTqZkecaD5TpHjHh/+DEbdfjzY2wslp3wtehyDVOqSBJL5FjIQjWmgVlv7TRxQtnoV9cJZ82wS
   WJh0Py+LR7bbpBYALW4i308AjPUjHhKs3x3J6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=zytAQkalIZDBrKG7HNFd87+dd8k5KjA5x/4SFOlRADY=;
 b=FWKEPpYhq/jV3cLX6gcy3eicc2IpZJrlpwJsXytaUdK+hwu71/8SQKQcHU8IcbR79uYWtpgnAImR
   GhM9vYC4RYCCQlYPloAFDpELlZWLD3SfiiLe4mOhBxeJ8IH6VB0CNruDue/VE5MKXeS9pfOYiBUH
   OP1dtSb/B/DXFPoQx9JpNWSvd7V8NPOX6HtU52/3IqdABQHVNZvpjaJj3+ehNHnDncjmadswpbbG
   FnLRlayOQ7OYSS4hjlIWKJkRrBbRIP4z+iJZWApfc3mInfv3Q/kEQT9Xg1SlAeUjtZsNHsKcmzR5
   K2i2M1ewcjRoFAN/Ka1ItuKSf1BEjnnwk+wQeQ==
Received: by omta-ad3-fd1-1402-uk-london-1.omtaad3.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF1045N4RDVCD30@omta-ad3-fd1-1402-uk-london-1.omtaad3.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Thu, 14 May 2026 21:51:31 +0000 (GMT)
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
Subject: Re: [RFC PATCH net-next 0/3] net: macb: candidate fixes for silent TX
 stall on BCM2712/RP1
Date: Thu, 14 May 2026 22:51:29 +0100
Message-id: <20260514215129.33559-1-lukasz@raczylo.com>
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
 AAF8Kp2gGUnFKGIyrDw9wVbSVsYvduq9aPUjTQJs1LwRIXNFCb2jTFY/DkgZ45l6
 wryQXW8fC4CLX28S2PcOVvYYdB9UgtQ5lsLmEHEwKO6RNntQn7Srzpk8vxq1PVyS
 1R+VXqQ+bItSKBnwvG3MKMM+sBcNzwx7qffTT5njUIAX+dsS4sKz75EBpD4eCbp6
 1Y++QvO6AmWoakYKiq2ewMs0gYfpuXJWLPISqiS7s9Xx9Nk+JGOJbzQ1DsoKgyXx
 aZXJBo10Vmm2QOwP88qE778sG9xPIDdkrg2CXsEIqjyNKs/vVaeW9PWNFcdq57x1
 P8Ibk9dSPSh2zUwDCaHPfIwWjoF4cVz2ghtW1/Yk7nimLdVOYZAqr9V4RUFz2apA
 Pr8UaevSnLT6ySM7n1t0oNiCplj2oMvI4nYtvOEMjIjUDdUFJQGifq8h3CKpv08=
X-Rspamd-Queue-Id: 4DBE6547557
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288084-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.931];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,raczylo.com:mid]
X-Rspamd-Action: no action

Andrea, Théo --

Thanks both.  Replying to multiple points in one mail since they
intersect.

First a correction to the v1 cover: the "zero events post-patch"
claim was true only at the user-space watchdog visibility level.
With patch 3's warn made unconditional (which is what Andrea's
review re-tested with on v6.19.10), kernel-level evidence on my
side now matches what Andrea saw -- patches 1 and 2 are partial,
patch 3 is empirically the load-bearing fix on this platform.
The v2 cover acknowledges this and reframes.


## Andrea -- patches 1 and 3

Concrete data from a dmesg sweep across the 24-node fleet
(macb-v2 image, 2026-05-02 to 2026-05-05, 6.18.24 + this series
with netdev_warn_once swapped to netdev_warn):

  * 1 mid-runtime real stall, pi-data-02 2026-05-05T13:24:09Z,
    queue 0, tail=259564431 head=259564433 (2 stuck descriptors
    after ~260M TX).  HW ETHS tx_frames counter advanced through
    the event (~1535 fps mid-stall); driver tx_tail did not.
    Patch 3 watchdog re-kicked TSTART; user-space watchdog
    logged zero RECOVER events for that window -- kernel-level
    recovery completed before user-space noticed.  Consistent
    with the lost-TCOMP pattern.

  * 6 boot-time false positives during the 2026-05-02 rolling
    reboot, all tail=0 head=5-7.  Patch 3 v1 has a real bug:
    tx_stall_last_tail is initialised to tx_tail (=0) at
    macb_open(), first tick fires at +1000 ms; if autoneg
    hasn't completed by then, tail is still 0 from no-TCOMPs
    while head moves from kernel-queued packets, false stall
    fires.  v2 fixes this (details below).


## Théo -- the four questions on the cover

Welcome to macb maintenance.  Quick answers; raw 1 Hz traces,
dmesg dumps, and event logs available on request for any of
these.

  1. Tx-only or Tx+Rx broken?

     Tx-only at the MAC counter level.  Per-node 1 Hz trace
     captures the same signature on every wedge:
     /sys/class/net/end0/statistics/tx_packets freezes at a
     single second, rx_packets continues to grow, MAC IRQ
     counter (on the assigned CPU) continues to advance,
     NET_RX softirq counter continues to advance.  The
     "broken Tx & Rx" reports (lexfrei et al on cilium#43198)
     are the user-space symptom: TX dead -> TCP can't ACK ->
     nothing comes back -> looks bidirectionally dead from
     applications.  At the MAC counters the asymmetry is
     unambiguous.

  2. Recovery: link down/up vs module reload vs power cycle?

     On any system that's still otherwise responsive, link
     down/up suffices and is the lightest known recovery.  My
     user-space watchdog has run that primitive on 24 nodes
     for ~3 weeks; ~6-10 s wedge-to-Ready, every time.
     `modprobe -r macb && modprobe macb` (rtheobald) is a
     heavier-weight equivalent of the same thing -- works but
     unnecessary if link-toggle alone fixes the silicon state.
     "Power cycle only" (lexfrei) was on Ubuntu raspi 6.17 with
     the ondemand governor + frequent RCU stalls preceding the
     wedge (per launchpad bug body's "KEY OBSERVATION" section);
     my read is that case escalated past clean NIC freeze into
     kernel-wide unresponsiveness, so a NIC-level recovery
     couldn't reach it.

  3. TSO / SG / EEE disabling helped some reporters?

     Mixed picture, with one gap in my matrix.

     Tested fleet-wide since 2026-04-24 as baseline before this
     series:
       * EEE off (--set-eee end0 eee off + advertise 0x0)
       * TSO off (-K tso off)
       * GSO off (-K gso off)
       * RX/TX rings 4096/2048 (default 512)
       * IRQ affinity moved off CPU0 to CPU3
       * CPU governor schedutil (default) -- earlier tested
         performance, no change
       * qdisc fq -> pfifo_fast

     With all of those, the stall still fires.  Pre-patch
     fleet rate was multiple per hour with these knobs already
     applied.

     Untested by me: TSO + SG (scatter-gather, NETIF_F_SG) off
     *together*.  That is the specific combination rtheobald
     (cilium#43198 comment 4188846955) and the launchpad
     commenter (#34) report as masking the stall -- "must be
     both, not just one".  I tested TSO + GSO, not TSO + SG.

     Both patch 1 (PCIe-fabric race on TSTART) and patch 2
     (peripheral DMA retirement race on TX_USED) are
     consistent with descriptor-fragment-path interactions
     that SG-off would mask, so the workaround being real
     isn't surprising.  Closing the race rather than masking
     it should still be the right thing for mainline.  Happy
     to canary-test TSO+SG-off on one node if you want the
     data point before v2 review.

  4. cdns,*-max-pipe DT props -- lead dead?

     Yes, dead, per the commenter who pursued it (launchpad
     #2133877 comment #30, April 2026): they patched mainline
     6.18.18 to add the device_property_read calls for
     cdns,ar2r-max-pipe / cdns,aw2w-max-pipe / cdns,use-aw2b-fill
     *and* added those properties to bcm2712-rpi-5-b.dts; ran
     a few hours; their own follow-up: "this is a dud" -- node
     hung anyway.

     For reference, my build (raspberrypi/linux rpi-6.18.y @
     f2f68e79f16f) has the driver-side reads present but the
     DTS does not set the properties, so the AMP register
     defaults are in effect on my fleet and the bug still
     fires.  Two independent confirmations the DT props are
     not the fix.


## My own audit -- two issues v2 fixes

Worth disclosing before someone else catches them.

  * Patch 2 (v1) reads ISR in macb_tx_poll(), masks off
    everything except TCOMP, and discards the rest.
    raspberrypi_rp1_config does not set
    MACB_CAPS_ISR_CLEAR_ON_WRITE -- the driver assumes
    read-clear ISR semantics on RP1, and macb_interrupt()
    relies on processing every bit it reads in one pass for
    that case to be correct.  My v1 patch breaks that contract:
    any RCOMP / ROVR / TXUBR / etc. set in ISR at the moment of
    my read is silently consumed and never processed.  RCOMP
    being lost is the worst case (RX completion never scheduled
    until something else asserts the line).  Race window is
    ~200-500 ns per macb_tx_poll completion; significant at
    moderate-to-heavy RX load on a level-triggered IRQ where
    the consumed bit drops the line before GIC delivery.

    v2 patch 2 drops the ISR read entirely and substitutes
    (void)queue_readl(queue, IMR).  IMR is the read-only mask
    mirror, no side effects, still flushes prior peripheral
    DMA writes via PCIe ordering.  Loses the "directly sample
    latched TCOMP" half of v1's claim; keeps the PCIe-barrier
    half (which is the half that actually addresses the
    documented race in the existing macb_tx_complete_pending()
    rmb() comment).

  * Patch 3 (v1) boot-time false positive described above to
    Andrea.  v2 fixes:

      - netif_carrier_ok() gate -- no carrier, no completion is
        possible, don't fire.

      - tracks tail movement via a bool tx_stall_tail_moved set
        by macb_tx_complete() under tx_ptr_lock when tail
        advances, cleared by the watchdog tick on the same
        lock.  Form suggested by pelwell when he reviewed the
        same series anchored against rpi-6.18.y at
        raspberrypi/linux#7340 (merged 2026-05-08); 13 days of
        fleet runtime in this form since 2026-05-02 across 24
        nodes.  Folded into mainline v2 patch 3 directly rather
        than carried as a fix-up.

      - netdev_warn_once -> netdev_warn_ratelimited per
        Andrea's ask -- operator visibility doesn't disappear
        after the first fire.


## v2 follows

Sending [PATCH net-next v2 0/3] threaded under the v1 cover
shortly.  Plan to drop "RFC" from the subject prefix (~3 weeks
production runtime + the rpi in-tree merge tip the balance
toward a regular PATCH); happy to revert to RFC if you'd
prefer the iterative-review cadence.

Tested-on context for v2:
  * mainline-anchored:  builds clean against current net-next
    HEAD, applies cleanly.  Boot-tested in a canary build of
    my Talos image before this reply.
  * rpi-6.18.y-anchored equivalents:  in production on 24 nodes
    since 2026-05-02; in raspberrypi/linux master tip since
    2026-05-08.
  * The v2 patch 2 IMR-barrier form (the one that fixes the
    destructive ISR-read regression described above) was rolled
    to all 24 Pi nodes earlier today (2026-05-14, ~14:00 UTC) as
    a vendor-fork-anchored update.  ~120 cumulative node-hours
    of runtime since:  zero mid-runtime TX stalls; zero user-space
    watchdog RECOVER events; the 5 dmesg "TX stall detected" lines
    are all boot-time false positives of the form `tail=0 head=N`
    that the new `netif_carrier_ok()` gate in patch 3 eliminates.
    Pre-patch baseline rate (~0.5 stall/node-hour at fleet level)
    would have predicted on the order of 60 mid-runtime stalls in
    that window; observed is 0.

Thanks again to both for the review.

--
Lukasz Raczylo

