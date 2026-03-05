Return-Path: <netdev+bounces-264274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM7qCB1bqWkL6AAAu9opvQ
	(envelope-from <netdev+bounces-264274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:29:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525020FB8A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F043007AE1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306637BE7A;
	Thu,  5 Mar 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fb75O7pH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8JamC783"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487421B1BF;
	Thu,  5 Mar 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706367; cv=none; b=L+BY6fzOmF64TTJCtYi/DbhT7DHFPp16HbLfuufhVHPy7zc5nfU7RrSTTpsyZrf901VzuexP57tq/SKFUeXppx5NVqWjdtUBOvDoG4/iYz6AC7iBdvlyIvbx5wpR+VThH0g6DBOBjFYj1dBqIB9tiOvTYJROyIQ/+mr6xcdkQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706367; c=relaxed/simple;
	bh=RgkN74Z5fNV4bzo2sabqZd7YQa4GKy2pwPJ9Gy5jLJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ijETKo91Picf33qR+NpnRWozOwenXnRahapIN6v+cUzESUvByJdqxED1mtCzexsLRKA+ykYB70BQBbtipfqJbS5CUxQ3uClpYvpndB2F3rr/ULWahpzuqoWprA0mIK2DSEt21SLWFdtVu1rI8aGPfg8WN+mixIatuPtmDKOPiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fb75O7pH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8JamC783; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772706363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jcB4Qc4RSpTJkK3766CPxby/vsOqv2xo6x9Nr5FoRkY=;
	b=Fb75O7pHkhNIEquJGMiB8NIOlYp0st3symelN/S73GSyNVdvlr2mYRhyFfQgt9h9iaMixl
	vYqAPwZoc8+FLbs+EfgUsZMRzmbaOml82X6s1yUfiH4owJ5VLY8tGacCfVydExMwdGLtuV
	e2x6FN8XUlaIAkEz8bcBB6HwesJ8ffeDK4eLnrZ9l/sNGs3RGCC7qCbQw1LgifyLFeZmPV
	nY6hcJ+04wsXLC3VtusBzIDDuzLM/lOE9N+d09FnEW0bUvTXEaEOlKacQ8MCHFrcYQ7Q5f
	UrMparniEo3JPX1jR6icT7hoQcsTZSdD6xn8OZjNn2JOOK/dUMWheFsp0AIAuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772706363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jcB4Qc4RSpTJkK3766CPxby/vsOqv2xo6x9Nr5FoRkY=;
	b=8JamC7832A7gp1mCt56f1OTKzbQTZDI5EHeROyYPMTNLLWyWtB65TYomzSAXbsRqdZQCif
	Ah4o3h6CcM0nfpAQ==
Date: Thu, 05 Mar 2026 11:25:53 +0100
Subject: [PATCH iwl-next v5] igb: Retrieve Tx timestamp from BH workqueue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-igb_irq_ts-v5-1-d3b96828ab5b@linutronix.de>
X-B4-Tracking: v=1; b=H4sIADBaqWkC/23Q0WoDIRAF0F8JPtego67Sp/xHKEEnbjIQ3Fa3Z
 kPYf68sDc2WPA7DuZeZOysxUyzsfXNnOVYqNKQ2mLcNw7NPp8jp2GYGAoxwUnE6hQPlr8NYuPT
 eWkQbNAbWwGeOPU1L2J7R9cJTnEb20TZnKuOQb0tLlcv+N9A8B1bJJXfY9SiUURpgd6H0PeYh0
 bQ9xiWqwhMHWHFoXHpUVljnrdevuHrwToBYt6vGIfbtINTBOfOK6z+uxOobVTeOwUfbS7Cik//
 5PM8/NDK+gG8BAAA=
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6087; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=RgkN74Z5fNV4bzo2sabqZd7YQa4GKy2pwPJ9Gy5jLJg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBpqVo7/Bhgf5Oj2cRlPlV6xF009jxJJmurp6+c9
 FlGt/doKfyJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaalaOwAKCRDBk9HyqkZz
 goA4D/9Akp2Gubw9YdaaN140Jmy8tLi4LAmBmo50qceDm4MrWDbREahVadTXK/Mf/9IcnPpBYly
 lcGnsva/PJTsXQSyVgK01rS7IgcnKd3TD3bfs86DeaNYGOLz0g79uJJPf+0R3LCHRR/198Vd4r1
 fRmmG2BsweCK3QfUhzbgpOWsbfI2VeYEjc5VLEJowXKk7c1/5oOH3zzgIDOrz285h0GzVwGSJip
 MMA8Xb8imJMVKUzlIMgi43kBn7hN2mVaYJQlfWawkWNBuI3lH9FEL6ufkHWqeX9voPVrs4plieu
 GVjQ/jFGT0IFs8dSoS/myAoAuW2Yn3iAe/mvYqaO7W4xByTXZHxUrzHVgQXKbWDvwF5VIhrTt/f
 rFvPoCOVL5LDq/7YCPwVTdE2ZggGW74+Y4unSHO+quXavFaFQNOeGyr0jIn0cOs7nj6s3ox2Y9S
 w0vH3Cl/HLbcmhfNeB6Mz1M+aYktpKCzV7KChNhX3tnLi2QwfTKPRA2/rOFf0PI3hUFcQw6EVZx
 HNUZLwmYVwNzU9PWRyCqgGMdrg2oeqsNM5EgBurH8gJiDvwXcvNatQoJ6MaTZAJG8xC92CHTft3
 JPNP8TiimlUQiA2fW13LernU0n3bMs2Q3u7fFLXwoj+tpj6nQsVKLwXJRInFK2Kv3v2xiVkej13
 Xw4QFTot3VJ+OPg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Rspamd-Queue-Id: 7525020FB8A
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
	TAGGED_FROM(0.00)[bounces-264274-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,intel.com,linutronix.de,molgen.mpg.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:email,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

Retrieve Tx timestamp from system BH instead of regular system workqueue.

The current implementation uses schedule_work() which is executed by the
system work queue and kworkers to retrieve Tx timestamps. This increases
latency and can lead to timeouts in case of heavy system load. i210 is
often used in industrial systems, where timestamp timeouts can be fatal.

Therefore, switch to the system BH workqueues which are executed in softirq
context shortly after the IRQ handler returns.

Tested between Intel i210 and i350 with ptp4l gPTP profile:

|ptp4l[30.405]: rms    4 max    7 freq +12825 +/-   3 delay   247 +/-   0
|ptp4l[31.406]: rms    2 max    3 freq +12829 +/-   3 delay   248 +/-   0
|ptp4l[32.406]: rms    3 max    3 freq +12827 +/-   3 delay   248 +/-   0
|ptp4l[33.406]: rms    2 max    3 freq +12827 +/-   3 delay   248 +/-   0
|ptp4l[34.407]: rms    3 max    6 freq +12825 +/-   4 delay   248 +/-   0
|ptp4l[35.407]: rms    3 max    6 freq +12822 +/-   4 delay   246 +/-   0
|ptp4l[36.407]: rms    7 max   10 freq +12812 +/-   5 delay   248 +/-   0
|ptp4l[37.408]: rms    5 max    8 freq +12808 +/-   3 delay   248 +/-   0

Furthermore, Miroslav Lichvar tested with ntpperf and chrony on Intel i350:

Without the patch:

|               |          responses            |        response time (ns)
|rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
|150000   15000   0.00%   0.00%   0.00% 100.00%    +4188  +36475 +193328  16179
|157500   15750   0.02%   0.00%   0.02%  99.96%    +6373  +42969 +683894  22682
|165375   16384   0.03%   0.00%   0.00%  99.97%    +7911  +43960 +692471  24454
|173643   16384   0.06%   0.00%   0.00%  99.94%    +8323  +45627 +707240  28452
|182325   16384   0.06%   0.00%   0.00%  99.94%    +8404  +47292 +722524  26936
|191441   16384   0.00%   0.00%   0.00% 100.00%    +8930  +51738 +223727  14272
|201013   16384   0.05%   0.00%   0.00%  99.95%    +9634  +53696 +776445  23783
|211063   16384   0.00%   0.00%   0.00% 100.00%   +14393  +54558 +329546  20473
|221616   16384   2.59%   0.00%   0.05%  97.36%   +23924 +321205 +518192  21838
|232696   16384   7.00%   0.00%   0.10%  92.90%   +33396 +337709 +575661  21017
|244330   16384  10.82%   0.00%   0.15%  89.03%   +34188 +340248 +556237  20880
|
|With the patch:
|150000   15000   5.11%   0.00%   0.00%  94.88%    +4426 +460642 +640884  83746
|157500   15750  11.54%   0.00%   0.26%  88.20%   +14434 +543656 +738355  30349
|165375   16384  15.61%   0.00%   0.31%  84.08%   +35822 +515304 +833859  25596
|173643   16384  19.58%   0.00%   0.37%  80.05%   +20762 +568962 +900100  28118
|182325   16384  23.46%   0.00%   0.42%  76.13%   +41829 +547974 +804170  27890
|191441   16384  27.23%   0.00%   0.46%  72.31%   +15182 +557920 +798212  28868
|201013   16384  30.51%   0.00%   0.49%  69.00%   +15980 +560764 +805576  29979
|211063   16384   0.06%   0.00%   0.00%  99.94%   +12668  +80487 +410555  62182
|221616   16384   2.94%   0.00%   0.05%  97.00%   +21587 +342769 +517566  23359
|232696   16384   6.94%   0.00%   0.10%  92.96%   +16581 +336068 +484574  18453
|244330   16384  11.45%   0.00%   0.14%  88.41%   +23608 +345023 +564130  19177

There are some minor differences at lower rates, but no performance
regressions at higher ones.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v5:
- Adjust changelog wording (Aleksandr Loktionov)
- Include measurement numbers in changelog (Paul Menzel)
- Link to v4: https://patch.msgid.link/20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de

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
base-commit: ad3dfa80be765757f612da04318248f6d20e4f71
change-id: 20250813-igb_irq_ts-1aa77cc7b4cb

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>


