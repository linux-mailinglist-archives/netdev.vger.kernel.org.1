Return-Path: <netdev+bounces-263167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOV1I0TSpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F321EF4AA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB08931DE38A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3433D6D7;
	Tue,  3 Mar 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jpTsYwy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skQIJ9Mk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52432AABD;
	Tue,  3 Mar 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538531; cv=none; b=al92yiEWWN/UZy06qYGU8DW09BCDXGyhhSlq7QHOOmulnwtTCzF+qWH+WYDy9yjaX0QeTZckOPdyxFuO6yIMvK4KaW9aDIIUeuas3thmwr5P1hB7rOJWiKY4BFtmDw0e43y0/bsrN1cMTjVLxkZHJeNAWsKQfP3EEdWTQsm9MC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538531; c=relaxed/simple;
	bh=ms0yTxZZ22uQq6JR0RNMCsyZW9R2i3QOBVEyUxtk2Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l9EA/ACrZXN38F/Gn4NcK0zUZiTD2WlKqQuTog6F0m6V7yWIGsEpMl812tohvjXbcBXoXanVWwKxAuNUPJB91TL9sOnnPKrxClZRyfsd8sjn4ZhBE/fQdWBo/ODr8rqFjeXNl6j7qR6ZQIYedsMWb6vD0Q74WBBEM+k1qX4Dx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jpTsYwy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skQIJ9Mk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772538527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fNmxI84i6rN7UI6Lm6Ye2tLnuTRfdFcNY4oX0NfZYqM=;
	b=3jpTsYwyr1avrfMhLu/wnrudSxTgoUb8701FZyP3++T2D/UHc8gTytz3DWR6E0ocVIo8Oo
	gaL740pd3aFw5iwZr+DKpI0X1FuVi0AB5XprwFfzyvpaMT1ZBiUmhlQeybPFq+tx0fIqhj
	tPL94Dd1jis1ce1STydGYgNY2SOOmXK7LeR+GmKLCaKYaAdKLBS9NTWvSlDvPjM0kF2q+Q
	/0P/liWxJDD9GCPO+dusi8m4CvNntrKMRy1WItp4aX32ayyHx8ZGL2Ax9m4z4R+X4Awpwb
	+5nsPzPq3t+odGGCMbmuer646ljx1aKJDCxdiyPSgSgt9MUVbXdCIMsgS9y0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772538527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fNmxI84i6rN7UI6Lm6Ye2tLnuTRfdFcNY4oX0NfZYqM=;
	b=skQIJ9MkdQd6NRX0PAOd9ulOaqTxfuFNLakR5lWIbVrtWsrK7irPwKpYt/VOYTkJC3wuO6
	GJz8mRL5EkVRaxAg==
Date: Tue, 03 Mar 2026 12:48:44 +0100
Subject: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJvKpmkC/23P0QrCIBQG4FcZXmfo0aV01XtEhHOuDgxXaraIv
 XsyClZ0efj5/p/zJNEFdJFsqycJLmPEwZdDripiz8afHMW23AQY1ExzQfHUHDFcjylSboxS1qp
 G2oYUcAmuw3Eu2xO899S7MZFDSc4Y0xAe80rmc/4urJeFmVNOtd10lolaSIBdj/6WwuBxXLdur
 sqw4ABfHArnxgrFlDbKyH9cfPiGAfteF4WD68pDVjZa1798mqYXeUEO0TABAAA=
X-Change-ID: 20250813-igb_irq_ts-1aa77cc7b4cb
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=ms0yTxZZ22uQq6JR0RNMCsyZW9R2i3QOBVEyUxtk2Yo=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBppsqfWAqkR7FsbPyrKzfVmBuAWaXMWm541oQRh
 4LJdY9ieT2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaabKnwAKCRDBk9HyqkZz
 gj9nD/9aZQv0h2OoW+kXMwTIZDZ30rMMcOHI67+pBS4yvvv8EybEAhlz74z98jogm0qEpr7tR2O
 G4ytM11IhGtOAwyj/mF8o8ksYbvpuiUYU0KbEs0UB0VE1xLZzkVPEtSjScsgALWvX7YezKxryom
 11zIqWLuy62Gnfr+Snicgb9zyrpfLW4M4axo2hClECt0nnWm+pve2E6dfVLXlTa/gkiljWY/q3/
 fKsEoKspqstFFgG4GspuD2ytV6wyl1X3bfAe2JnpH+RXzoGB1K81kVR//lcUxHyQciNF7iZTLOI
 oazruba8zHB4+EXUnom81ic93zRvGi9t4HbIxiJ/CUue3qcTpG9pzo3VbvG7xk9rpXZRVOrARI/
 +DLPg3Hh+ke1R9N/GT309d1Yhef8zCjnkQK1MRByaocorbzgo7lHEfcwnLnrWmBLELo/eeszYbJ
 rq5NmimjsJeuopqCE7im9uIAvej7NC4Z2eCUCefk/FtV3UaeSDaEtee987rH+vx0Hz3JxnrBtPm
 1FLTdHtR2fZjeZLRok4yLNPEwzr8QPOv6r+OlRK6N07NL7/zCdt2iIWutERdm9qBwJKSTaZ63Zh
 LASZlR99lpMLJbhyOAn7BQI/3EthLn1cOVMW6bWE94sVt7BDAtJLTkwlOTO+kUvUgXWubXmOTnc
 q6pvmfaUqoecfEg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Rspamd-Queue-Id: E3F321EF4AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263167-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,intel.com,linutronix.de,molgen.mpg.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid]
X-Rspamd-Action: no action

Retrieve Tx timestamp from system BH instead of regular system workqueue.

The current implementation uses schedule_work() which is executed by the
system work queue and kworkers to retrieve Tx timestamps. This increases
latency and can lead to timeouts in case of heavy system load. i210 is
often used in industrial systems, where timestamp timeouts can be fatal.

Therefore, switch to the system BH workqueues which are executed directly
at the end of the IRQ handler.

Tested on Intel i210 and i350 with ptp4l.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v4:
- Use BH workqueue (tasklet) instead of doing timestamping in IRQ path (Jakub Kicinski)
- Link to v3: https://patch.msgid.link/20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de

Changes in v3:
- Switch back to IRQ, but for i210 only
- Keep kworker for all other NICs like i350 (Miroslav)
- Link to v2: https://lore.kernel.org/r/20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de

Changes in v2:
- Switch from IRQ to PTP aux worker due to NTP performance regression (Miroslav)
- Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ee99fd8fd513..9fd29fedb9f5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6572,7 +6572,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 			adapter->ptp_tx_skb = skb_get(skb);
 			adapter->ptp_tx_start = jiffies;
 			if (adapter->hw.mac.type == e1000_82576)
-				schedule_work(&adapter->ptp_tx_work);
+				queue_work(system_bh_wq, &adapter->ptp_tx_work);
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
@@ -7076,7 +7076,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		queue_work(system_bh_wq, &adapter->ptp_tx_work);
 	}
 
 	if (tsicr & TSINTR_TT0)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index bd85d02ecadd..7b44f9090631 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -832,7 +832,7 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		igb_ptp_tx_hwtstamp(adapter);
 	else
 		/* reschedule to check later */
-		schedule_work(&adapter->ptp_tx_work);
+		queue_work(system_bh_wq, &adapter->ptp_tx_work);
 }
 
 static void igb_ptp_overflow_check(struct work_struct *work)

---
base-commit: a0e8c9a5060fbdb72fca767164467a3cf2b8fc30
change-id: 20250813-igb_irq_ts-1aa77cc7b4cb

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>


