Return-Path: <netdev+bounces-305288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IzeCCOaTGqtmwEAu9opvQ
	(envelope-from <netdev+bounces-305288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D63717E07
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:18:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305288-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305288-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78939303583E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F4376A09;
	Tue,  7 Jul 2026 06:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE7226CF6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404966; cv=none; b=k8JyuoSRRMkst+lj6Hh5axnkq7KL+YD/ep6Fcs+vvMNEdBtmer6BGT04/mUdxBo4gKueT0ctpo2EOk3ES6q4Qo8a9NUGx8I4J4+AUvGTME0LD5i75jsC0ZMmBbPjiqKBM93br7mhg3w/cX6J1ZpeYWDCR9sXRfrll1YKURHYKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404966; c=relaxed/simple;
	bh=fSkH3s+IoIx7W32YMC/h8FPXxFOZoCgqGIRbLsds3HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6AXCnFDAKwKbRwlVhWzXtVNSVvoDQ+DfXmTiDgDl06dtFPTFB+2D2xlOK5yBKeyCTiz7RuvnL21XkoFcppm8FYeO7XTKMv7Edwgxj4F1bmnbvE45kZfxQqxS6YjA0J078o3kIJpmOsVg7zrrzGe683QxtfItyhCmrJ22cWlQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
X-QQ-mid: esmtpsz10t1783404917tc0e9bbf8
X-QQ-Originating-IP: s+hn0JJIoMyHJwH7HDZuZ5ED3wxpBm9lA3ymTj0DnMc=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 14:15:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14636461010994805736
EX-QQ-RecipientCnt: 22
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v10 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Tue,  7 Jul 2026 14:14:54 +0800
Message-Id: <20260707061455.39564-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260707061455.39564-1-jiawenwu@trustnetic.com>
References: <20260707061455.39564-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MkyMzdXM6uJmgB7UTm8oT6IphPDrpBXE2V3TfHXMw16iPkTQqoph/rNI
	0XjWOrQK+yeNTvAZpfY/Ize0OLAxEBMnuCd6LGCBU7l2x0OST+OkDLoMWBrMjRIZQ/FDfYl
	+Yg80dVujWr4Z1AgGjU3W4A5x8swHj2gtGiPOXng/lLOOGeePzFiH0OrAh9+jxh7kHkQp2O
	til7enKcl/Qfgz436zOZkXEvzw3a0D0ZySTVMmRmQgdwb9za60NLi9eDjTApuus0KZcTlii
	FqTehgggISrqNq4sl6wd3BEl6+ntsJ27R2olVdQmpfMcVL7RrkLi+N40NhvEDPpfFD7ovmI
	+Dd6oD++8GzaSXgweNI7m+zCArtaZ5oVFiK1aVVoaQnlAaMbXNGFzL3HLVHbJdYU66dY4Wf
	MkjN8eR4D72ecJ1uEMndITm+Hcggn/uQad+W5a92814Vl6TSsPVi7a5/jOjQtmveIx4zsUx
	1IRB5bFQfyj8IfFI1HoengdQXTtMKx08R2j/amsgFdel6byATka/4XwNNshpBKWU++ewAQ5
	2MtMxuAUaaje3iNaJvAnLUZbbtaGBVJcVdWhgGu8b1WtFh4L2ZzKCI5WRx6YpMafcbTlBii
	2alJQJO6Q7bXIn86Vu0ZWxOv072HBw8PhZRsRJqhOwxIiOly8zwf8oyhgxn/xIHUV3Aer9b
	WovMn7zvblIWIQXudds6mQaIZS0CZKYaCGFIBVaHXzkwSyFxDo4kw+yMNtPheq/zon+3yS5
	z3G42c0KEDUAuE7lfx3aHyxorbvcITOBU7lYMaawl0jhePcFAIY0mRDTdO6WiQ8i0NOL5W+
	ZAROslmG52C5zVjm7ailR3pApEX97HW7vp8wQxE8xL5r2WCr/861GrFOTLwHPciE1xCVAX9
	Ur41z5bxN4lrrX4GUgDj0Oij27wGnVIJB3CWi6vYCt957Cy+z1DMfAtea0NPtsAt/uC44fC
	470+WQwRVkahtpKT6FolfbGRDRVJpvTzMo7gJmJZhKv1/zQXiLl7JgUnMY3Xmvz6Ti4N/Fs
	3H077ucu2TTb04RXXfoN2LuQA/Q5Z0xvS28BFYXjU/bgoORoOXRkXchn1KKcgL4iz3nMCBL
	zSV06scpC7pmb/l9ATjzJ+FVzZ5Y3hfBg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305288-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:shaojijie@huawei.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,huawei.com,baylibre.com,kylinos.cn,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,trustnetic.com:from_mime,trustnetic.com:email,trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70D63717E07

Function wx_soft_quiesce() provide a lightweight shutdown path during
PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
status.

Waiting for the service task to complete may unnecessarily delay PCIe
error recovery, especially if the work item is already blocked by the
hardware failure that triggered AER. So the service task is not
explicitly cancelled in quiesce path. As a measure to block the service
task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is added at
the entry of relevant work item.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 ++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 21 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +++++++
 5 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index c8a4822d3819..a65312c8078f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3383,5 +3383,23 @@ void wx_service_timer(struct timer_list *t)
 }
 EXPORT_SYMBOL(wx_service_timer);
 
+void wx_soft_quiesce(struct wx *wx)
+{
+	if (!netif_running(wx->netdev) ||
+	    test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	pci_clear_master(wx->pdev);
+	netif_tx_stop_all_queues(wx->netdev);
+	netif_carrier_off(wx->netdev);
+	netif_tx_disable(wx->netdev);
+	wx_napi_disable_all(wx);
+	wx_ptp_quiesce(wx);
+
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	timer_delete_sync(&wx->service_timer);
+}
+EXPORT_SYMBOL(wx_soft_quiesce);
+
 MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..11bd79985e17 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -41,5 +41,6 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
+void wx_soft_quiesce(struct wx *wx);
 
 #endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 44f3e6505246..a25eb6aed566 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -321,6 +321,9 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
 	int ts_done;
 
+	if (!test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return HZ;
+
 	ts_done = wx_ptp_tx_hwtstamp_work(wx);
 
 	wx_ptp_overflow_check(wx);
@@ -842,6 +845,24 @@ void wx_ptp_stop(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_ptp_stop);
 
+void wx_ptp_quiesce(struct wx *wx)
+{
+	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return;
+
+	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
+	if (wx->ptp_clock)
+		ptp_cancel_worker_sync(wx->ptp_clock);
+
+	if (wx->ptp_tx_skb) {
+		dev_kfree_skb_any(wx->ptp_tx_skb);
+		wx->ptp_tx_skb = NULL;
+	}
+	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+}
+EXPORT_SYMBOL(wx_ptp_quiesce);
+
 /**
  * wx_ptp_rx_hwtstamp - utility function which checks for RX time stamp
  * @wx: pointer to wx struct
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
index 50db90a6e3ee..ad2f824875d5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -10,6 +10,7 @@ void wx_ptp_reset(struct wx *wx);
 void wx_ptp_init(struct wx *wx);
 void wx_ptp_suspend(struct wx *wx);
 void wx_ptp_stop(struct wx *wx);
+void wx_ptp_quiesce(struct wx *wx);
 void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb);
 int wx_hwtstamp_get(struct net_device *dev,
 		    struct kernel_hwtstamp_config *cfg);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a8773712cff8..a7bde03a98fe 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -94,6 +94,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 {
 	int err;
 
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
 		return;
 
@@ -107,6 +111,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 
 static void txgbe_link_config_subtask(struct wx *wx)
 {
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
 		return;
 
-- 
2.51.0


