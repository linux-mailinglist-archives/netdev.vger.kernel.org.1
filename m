Return-Path: <netdev+bounces-293041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GgaJtZFGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:52:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70C5FED31
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7265C306E09F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D73B2FDB;
	Fri, 29 May 2026 07:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8053B38AD
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041134; cv=none; b=r1eOgcFRSDKKpPUUwNGsCZEmCs14IeLQ3/NIlev1Um6MkXuJD3j0vEODGwR5xIm887KioFyuqnKfMxGmHH6vnvcJOPuGos6P9xoRzk9ODN9LiVVKl78nzHEoA7fFG7A81zssuIRQ/M34V7cLXAthKxNBUC26FrwwCMAiUafwf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041134; c=relaxed/simple;
	bh=JNn1FhL1JnGFQApymCIorirn/ir4/Xa8GJY9JlV+Ws8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbX2YIokius8Sj3x7xxNh48/pYzHP8yDSXorpa0RhWcEWfdRHKVXL209upA3AX52jqzE6y52bpgYZm4/sWRtAY03A09+rS63Wb7JurQpvQbLaQR1xJp4ThqZSmzM4fBlViKsaUoMf7oVvY2fJSksZbUlp0MGszGya/CrYefIjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1780041121t66ecb4a0
X-QQ-Originating-IP: h3DecYWpa4w37ALOpKJxtBL5agFYVJ64SEJoM54ZCTM=
Received: from localhost.localdomain ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 15:52:00 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12666183395884800205
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 3/3] net: libwx: support vf hardware statistics
Date: Fri, 29 May 2026 15:51:47 +0800
Message-Id: <20260529075147.88398-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260529075147.88398-1-mengyuanlou@net-swift.com>
References: <20260529075147.88398-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Oc3CTdOSw7sf9KzowWIPZCqlm/PLadsPd0Twe1No9Rj0SNAmaxVs80x0
	nxgIjeqOLKSA7Jc4flnfsMl2FmQ/uug1iJvBt0PF7ZlZEd+0QPr37CR4dgS3L8Lrr+Ry8Pr
	zcsCb8sVMFSBcSF9cO6yDOHGPR47EUk9kksJtQd78Pz2cqV3UPRuLr02zTwDbILLDvg2G3T
	IaF6x7zqJ8Nt/lHPEi1WxO3UI9YMNsgtgAJq653X2nXUisBmp6DOxhP/gcQNhmqN1bC/Ofn
	bINBWi/+3gx4zI94IpqJKxxgaWzK9TzstJ/vrKou6+Vk5cAjkufFNxwnhx2O75jWO/W2ptG
	B57SUorR5xeUii4YXVZIA818c2Nci7qDsBQyZkjUrDu0K7qlUqc2IFj/tEpHXfM6fC4C3G7
	iPm6QngEu/r8FOSEN2j/XUQN3voEeCbgywMEh2V+/JtcH9lHmu93FTPvjcRX6BZaq//PdMo
	IsR6jDZe4gp/BRgAvzDh+fPVo+2eh+k7MbTabU2n0LWX/2PWBE66D/+haEXAhYr1eMeW25T
	YlmHBtRXDKFazfMPr+aNgBhlrFHwwYwqunJHAzJ0nZumCVz1HWqZj99IV2156K40MGAKVbP
	ms7T5z8Xm5+erwDkjwhNl3OnGIeAWFwk7lECoZfa9mqtp1xakcoTCurJCXDdTqv8ePfiUfq
	IYsFcS9xtT9jJja6aUB8u13RWWgVfkgmnhEmITnaVkYWm1iYc26XHTfKj5BknPUkWXMr6Pv
	RrCO4TPmDN0LOjz+Rqym+SG8cC3JqU/kHNyHP8ThOL2mMFGPCLe7GVEaRPREGkX5Oog+dqx
	ah2Z4SzpLG0ZPKi+R/1MgEeBLmDvyVYIxibb/xPyucRUB4xsq3E+NG83TJ8fzdOtMSF7vC3
	12XwDwKXpMDhgPQ3AXSd3lVmK8Hi08w0J1c7LHA0AdVSsYUdHM8ATXjNkyVJMvuvjbb5xQw
	XbMpropT0aqHlJNv+/o2i2OckPYtBKsY2n4Sz/srg36MJdzr8IrMyXK39SpGY4rmRR77c4H
	WWf5EDxEImz2K7zJkXX6yODyOf2Dvr0RqmpfwDFbSsOZ42otoy09DaSon5s4TUJcBtP4T2M
	73ZIzjSWOejZdKRUgQkJ2+C15k+wukL1ZvgwGZyktieouH00JVqLOsI6UzrusjmOlfCG/m9
	vx+r2sn/oLdp6a4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293041-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:mid,net-swift.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C70C5FED31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support to show hardware statistics for ethtool -S ethx.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 31 +++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 +++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  3 ++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 30c6ef6103ac..a12e1205ce80 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
+static const struct wx_stats wx_gstrings_stats_vf[] = {
+	WX_STAT("non_eop_descs", non_eop_descs),
+};
+
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_match", stats.fdirmatch),
 	WX_STAT("fdir_miss", stats.fdirmiss),
@@ -69,7 +73,9 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
 #define WX_QUEUE_STATS_LEN ( \
 		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_GLOBAL_STATS_LEN (wx->pdev->is_virtfn ? \
+		ARRAY_SIZE(wx_gstrings_stats_vf) : \
+		ARRAY_SIZE(wx_gstrings_stats))
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
 #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
@@ -101,7 +107,10 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+			if (wx->pdev->is_virtfn)
+				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
+			else
+				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
@@ -135,9 +144,15 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 	wx_update_stats(wx);
 
 	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
-		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
-		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		if (wx->pdev->is_virtfn) {
+			p = (char *)wx + wx_gstrings_stats_vf[i].stat_offset;
+			data[i] = (wx_gstrings_stats_vf[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		} else {
+			p = (char *)wx + wx_gstrings_stats[i].stat_offset;
+			data[i] = (wx_gstrings_stats[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
 	}
 
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
@@ -219,9 +234,10 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = WX_STATS_LEN;
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
@@ -851,6 +867,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..ce172b6deb80 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2917,6 +2917,9 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	if (wx->pdev->is_virtfn)
+		goto skip_hw_stats;
+
 	wx_update_xoff_rx_lfc(wx);
 
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
@@ -2956,6 +2959,7 @@ void wx_update_stats(struct wx *wx)
 		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
 					    &wx->last_stats.qmprc[i]);
 
+skip_hw_stats:
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..ee0b10c71b56 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -336,6 +337,7 @@ void wxvf_down(struct wx *wx)
 	netif_tx_disable(netdev);
 	netif_carrier_off(netdev);
 	wx_napi_disable_all(wx);
+	wx_update_stats(wx);
 	wx_reset_vf(wx);
 
 	wx_clean_all_tx_rings(wx);
@@ -409,6 +411,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
-- 
2.30.1


