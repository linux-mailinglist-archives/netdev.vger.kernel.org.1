Return-Path: <netdev+bounces-279625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LTsGKqN5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687D426321
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AEBD30293CA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4803783C1;
	Mon, 20 Apr 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="VMbPPDfc"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3F3019D6;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651658; cv=none; b=mww0A96NtylLqg5VAozbh9Sny/WjlaXKxu41HOq2LaSM/azOUgwin7ppv7RA9oe5gYFlmJEyg1HFA6Jx4OS9RPLtNLbejlJRGo2w0BKmfZLwM2GGjSV/pwF7Rd3Xk1K/Y9khKnOfosNkiOpiW572hBBSMUySd/NJZVV/HDFn5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651658; c=relaxed/simple;
	bh=ePze4zJ1Uk9m0WMzKuVyeHySU7hMX6g5CuvVMBWSnck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2+eNSZd7p6x4ueAn92WumT6aQF56jtkMlRdTPMYJZsCePy95DtODFFi5i3SEiBSE8tl2JLu/bWP6HB91q0tkWhOwWsOYssA8WIsKEwe7POjh9I0p2rD2EC4fy52ZrRzP/0GCwbElYL1Z47zh+bd/sEDXL7iJd5V17usYy9jg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=VMbPPDfc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KFBo8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651616;
	bh=lCnJ0HzsmVanHdXoXYyB2eK67+h1t5JXKZg5w4gYH88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VMbPPDfcyyLs9JetwuNU5ifsUt2+8R6JLiZkDygoV/fNCXLfO3RAVbnH2y0wTU9Rz
	 AJ1xbPAd38hM8xuxuh+sAEkPZLQtC7XovTzyfZjiTOvGv6s7qQDiszPjVm+rFNuMpM
	 DGemU3QKlJ+It7Ia+orircl6gYXqVvYF6o38Srmg2OlHBXuTYyKmEaTPjt6LvxXP5f
	 2qkfuDjukvyGTnMiflhSc4T5frsZlSQ/b+JrfG/hyFNR796y30/QcgopcyqJbNRn5h
	 i4hlOekwiKGob3BIwarz3hzoe/2KJqQ3mwDTGzVKS1iLrKhE3joZ31k+uqSE/KHG3O
	 bkYCr55zRQ7wA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KFBo8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:15 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Date: Mon, 20 Apr 2026 10:19:57 +0800
Message-ID: <20260420021957.1756-10-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279625-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0687D426321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch add support for changing rx queues by ethtool. We can set rx
1, 2, 4, 8 by ethtool -L eth1 rx num.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6b574fc336d6..57087abe7d88 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6518,6 +6518,72 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	ch->max_rx = tp->HwSuppNumRxQueues ? tp->HwSuppNumRxQueues : 1;
+	ch->max_tx = tp->HwSuppNumTxQueues ? tp->HwSuppNumTxQueues : 1;
+	ch->max_other = 0;
+	ch->max_combined = 0;
+
+	ch->rx_count = tp->num_rx_rings;
+	ch->tx_count = tp->num_tx_rings;
+	ch->other_count = 0;
+	ch->combined_count = 0;
+}
+
+static int rtl8169_set_channels(struct net_device *dev,
+				struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	bool if_running = netif_running(dev);
+	int i;
+
+	if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
+		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (ch->rx_count == 0 || ch->tx_count == 0)
+		return -EINVAL;
+	if (ch->rx_count > tp->HwSuppNumRxQueues ||
+	    ch->tx_count > tp->HwSuppNumTxQueues)
+		return -EINVAL;
+	if (ch->other_count || ch->combined_count)
+		return -EINVAL;
+
+	if (ch->rx_count == tp->num_rx_rings &&
+	    ch->tx_count == tp->num_tx_rings)
+		return 0;
+
+	if (if_running)
+		rtl8169_close(dev);
+
+	tp->num_rx_rings = ch->rx_count;
+	tp->num_tx_rings = ch->tx_count;
+
+	tp->rss_enable = (tp->num_rx_rings > 1 && tp->rss_support);
+
+	for (i = 0; i < tp->HwSuppIndirTblEntries; i++) {
+		if (tp->rss_enable)
+			tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+		else
+			tp->rss_indir_tbl[i] = 0;
+	}
+
+	if (tp->rss_enable)
+		tp->InitRxDescType = RX_DESC_RING_TYPE_RSS;
+	else
+		tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
+
+	if (if_running)
+		return rtl_open(dev);
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6536,6 +6602,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
+	.set_channels		= rtl8169_set_channels,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0


