Return-Path: <netdev+bounces-269308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dn+DiWQu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24E2C664C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2BF31BB22A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A52D8387;
	Thu, 19 Mar 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BVaVSQN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89E285CB9
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899576; cv=none; b=hLPYDG1nJfWLd2sZ59fqJm8EpbKH3T4WGAE6zpeEs+sLCUGhCCN27UJH70OV2JiAADTp1F241pEXzW+qpaSfWzUIHGXE41kdd2zluDlfOdnJoyuHLTKDN+lk1etJ4JgILLRxFEJ4K4+jGTAQd/wIB3OIb1zKJK+dGMonDmcq+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899576; c=relaxed/simple;
	bh=+Z4+hNeskPHLJq62/GqL2cKmCOLQV3mmTo4gx+qLSwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM4fpN33a9vmiMYK7+Je+lbreigNVZtQGfWNYu9h9HAZSIztAr0f2eGV1bU4xyNaqXWh2WoUI7iBYfQZtj8FAzj2UeexcfC6TS07ADdrtMmoK9t3VKTblIgs3jGIhtZMqPKOx6Ka369bpvTffeL4FBGaa3TdBGEAhlQ0nwa1Ce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BVaVSQN5; arc=none smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-467161c4ba7so406103b6e.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899574; x=1774504374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz3cigKIKwnEekHJyDzxNf418OUgUdaD2ltzJHw0Vmc=;
        b=A6JBWRqcYEt2dr4Oybu6s9ZgLFJqTI+heHCsq6x/wyPZEAOZIOtx8ALQpJQZM+1KXk
         3OdmfbkVp1bl81bSGDBcfWeNUCeTsEMdZNpuyqIhLYZyHG9Y868D1FT7tujXWNso4KFB
         1Z5VMlKn7qAZZAO67ykod21zDwfHnVXQCuz2SvBJwLj2SUxW53Dz7enI6x/DY+EjnLKc
         FYUst+cDnO4tYZo015LqknI3uz1ym7WB3zQHs+fbfvv/jWo5J2OETbUWJbkO+hRrRpOM
         vQY16EMuz07XzLvdS8g70Ip+oaPvuFrv5TQpB4p4DiarPDXPQ/b2QWKZ2OWd2Z60vTgz
         Pskw==
X-Gm-Message-State: AOJu0Ywhnn+Jm9mVA89YktdkiE0p3ywhkw88vrp6sMvwf0IBqFvVE/ep
	sZWZclpUtPJVtLHVQyjKp4HEhjFm/r/h1z9sB/C+Dn3X8u2XPlrx8HAQiYkOp3s58gBwanM+EQJ
	5dEs3akufhfQCdouqQ6Upc88jrUelWii5enzoHbjTGWd44qLCr0RKfXpQrprYGeVOjTPrBo7HeS
	TrNdm5uBEb9QRo3QP+go3iUrOTB+FPMCMU8AyOfuLUZTOIhxT8veDYsrybVP2Mpe2iiR7FZ387U
	SkOA8zUCw==
X-Gm-Gg: ATEYQzwTz4+rr05A9sVSdDa5p4MSECXUo5ZshJTLoQX0LKQKmctMF9rgMF7jGGNokNo
	8JbzBuGx2Fen4s4VHQPqwBJ8rQDvk5pMl8UIOYzHCe0HBhxayUFnoBMGoLzR2s4N3Lx1XiUeRPk
	7yVyXpMjdmOlxx7UtLxce3cTGIxKsM2csMeWJaVlX98ENeTm38bRO57qyPSaQr5ThxouT/CdX6p
	fmlIXxJEc5UvbfyZJPTPDt9xqhS6dc57foAuMnrf8Bua27Z7XOfaSdfrx3fnZuJKMl0fgbp6qS5
	QSoU1Wavk/Euq+0zgAC27b3rDtXFyVpybtO5Me0WkUys8wdRiJdlcDt/4dpM3jkdpmPgURAmvdz
	BPqIUxK2D7hD9qq85HIVJU2RNoa7sxxtlAX9XumnILPAeNDbdDzU5rcF9ijiHXkyc7sxAVdB0M1
	K8uYlktobc+hLLjS3VtcM0DrYgyvcBHlcsuY9+osvH81wzrCbk8deZEOwKDA==
X-Received: by 2002:a05:6808:1818:b0:467:f85:d81c with SMTP id 5614622812f47-467cd6e4653mr1314359b6e.20.1773899573533;
        Wed, 18 Mar 2026 22:52:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41bd2cec37asm671372fac.10.2026.03.18.22.52.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7986f771f69so47765607b3.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899572; x=1774504372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz3cigKIKwnEekHJyDzxNf418OUgUdaD2ltzJHw0Vmc=;
        b=BVaVSQN53T+VVHzJ2LQUzVc2lxzTKee6r3i6qtNmzpphgQrNc8oeO5LFs1ZU4Tiajd
         vphMdPY+LGgAQqX8Psmtz5go9Dqx4qR6UjoNu32Gs6NzHvUpyksrzwMYXeZDaOn548cl
         Xv4HKdwt9JJwsO8AY/m21BrYC75W5lF66MiIs=
X-Received: by 2002:a05:690e:1306:b0:64a:effb:1331 with SMTP id 956f58d0204a3-64e9ce76c87mr1812258d50.34.1773899572196;
        Wed, 18 Mar 2026 22:52:52 -0700 (PDT)
X-Received: by 2002:a05:690e:1306:b0:64a:effb:1331 with SMTP id 956f58d0204a3-64e9ce76c87mr1812236d50.34.1773899571571;
        Wed, 18 Mar 2026 22:52:51 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:51 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 06/10] bng_en: add HW stats infra and structured ethtool ops
Date: Thu, 19 Mar 2026 11:21:20 +0530
Message-ID: <20260319055124.1350670-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269308-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E24E2C664C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Implement the hardware-level statistics foundation and modern structured
ethtool operations.

1. Infrastructure: Add HWRM firmware wrappers (FUNC_QSTATS_EXT,
   PORT_QSTATS_EXT, and PORT_QSTATS) to query ring and port counters.
2. Structured ops: Implement .get_eth_phy_stats, .get_eth_mac_stats,
   .get_eth_ctrl_stats, .get_pause_stats, and .get_rmon_stats.

Stats are initially reported as 0; accumulation logic is added
in a subsequent patch.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 160 +++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 142 +++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   3 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 192 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  60 +++++-
 5 files changed, 546 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 01382ad784e3..2ae13f18e2d7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -42,6 +42,161 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static void bnge_get_eth_phy_stats(struct net_device *dev,
+				   struct ethtool_eth_phy_stats *phy_stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u64 *rx;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS_EXT))
+		return;
+
+	rx = bn->rx_port_stats_ext.sw_stats;
+	phy_stats->SymbolErrorDuringCarrier =
+		*(rx + BNGE_RX_STATS_EXT_OFFSET(rx_pcs_symbol_err));
+}
+
+static void bnge_get_eth_mac_stats(struct net_device *dev,
+				   struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u64 *rx, *tx;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return;
+
+	rx = bn->port_stats.sw_stats;
+	tx = bn->port_stats.sw_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+	mac_stats->FramesReceivedOK =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_good_frames);
+	mac_stats->FramesTransmittedOK =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_good_frames);
+	mac_stats->FrameCheckSequenceErrors =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_fcs_err_frames);
+	mac_stats->AlignmentErrors =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_align_err_frames);
+	mac_stats->OutOfRangeLengthField =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_oor_len_frames);
+	mac_stats->OctetsReceivedOK = BNGE_GET_RX_PORT_STATS64(rx, rx_bytes);
+	mac_stats->OctetsTransmittedOK = BNGE_GET_TX_PORT_STATS64(tx, tx_bytes);
+	mac_stats->MulticastFramesReceivedOK =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_mcast_frames);
+	mac_stats->BroadcastFramesReceivedOK =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_bcast_frames);
+	mac_stats->MulticastFramesXmittedOK =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_mcast_frames);
+	mac_stats->BroadcastFramesXmittedOK =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_bcast_frames);
+	mac_stats->FrameTooLongErrors =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames);
+}
+
+static void bnge_get_eth_ctrl_stats(struct net_device *dev,
+				    struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u64 *rx;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return;
+
+	rx = bn->port_stats.sw_stats;
+	ctrl_stats->MACControlFramesReceived =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_ctrl_frames);
+}
+
+static void bnge_get_pause_stats(struct net_device *dev,
+				 struct ethtool_pause_stats *pause_stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u64 *rx, *tx;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return;
+
+	rx = bn->port_stats.sw_stats;
+	tx = bn->port_stats.sw_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+	pause_stats->rx_pause_frames =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_pause_frames);
+	pause_stats->tx_pause_frames =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_pause_frames);
+}
+
+static const struct ethtool_rmon_hist_range bnge_rmon_ranges[] = {
+	{    0,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1518 },
+	{ 1519,  2047 },
+	{ 2048,  4095 },
+	{ 4096,  9216 },
+	{ 9217, 16383 },
+	{}
+};
+
+static void bnge_get_rmon_stats(struct net_device *dev,
+				struct ethtool_rmon_stats *rmon_stats,
+				const struct ethtool_rmon_hist_range **ranges)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	u64 *rx, *tx;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return;
+
+	rx = bn->port_stats.sw_stats;
+	tx = bn->port_stats.sw_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+	rmon_stats->jabbers = BNGE_GET_RX_PORT_STATS64(rx, rx_jbr_frames);
+	rmon_stats->oversize_pkts =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames);
+	rmon_stats->undersize_pkts =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_undrsz_frames);
+
+	rmon_stats->hist[0] = BNGE_GET_RX_PORT_STATS64(rx, rx_64b_frames);
+	rmon_stats->hist[1] = BNGE_GET_RX_PORT_STATS64(rx, rx_65b_127b_frames);
+	rmon_stats->hist[2] = BNGE_GET_RX_PORT_STATS64(rx, rx_128b_255b_frames);
+	rmon_stats->hist[3] = BNGE_GET_RX_PORT_STATS64(rx, rx_256b_511b_frames);
+	rmon_stats->hist[4] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_512b_1023b_frames);
+	rmon_stats->hist[5] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_1024b_1518b_frames);
+	rmon_stats->hist[6] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_1519b_2047b_frames);
+	rmon_stats->hist[7] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_2048b_4095b_frames);
+	rmon_stats->hist[8] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_4096b_9216b_frames);
+	rmon_stats->hist[9] =
+		BNGE_GET_RX_PORT_STATS64(rx, rx_9217b_16383b_frames);
+
+	rmon_stats->hist_tx[0] = BNGE_GET_TX_PORT_STATS64(tx, tx_64b_frames);
+	rmon_stats->hist_tx[1] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_65b_127b_frames);
+	rmon_stats->hist_tx[2] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_128b_255b_frames);
+	rmon_stats->hist_tx[3] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_256b_511b_frames);
+	rmon_stats->hist_tx[4] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_512b_1023b_frames);
+	rmon_stats->hist_tx[5] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_1024b_1518b_frames);
+	rmon_stats->hist_tx[6] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_1519b_2047b_frames);
+	rmon_stats->hist_tx[7] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_2048b_4095b_frames);
+	rmon_stats->hist_tx[8] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_4096b_9216b_frames);
+	rmon_stats->hist_tx[9] =
+		BNGE_GET_TX_PORT_STATS64(tx, tx_9217b_16383b_frames);
+
+	*ranges = bnge_rmon_ranges;
+}
+
 static void bnge_get_pauseparam(struct net_device *dev,
 				struct ethtool_pauseparam *epause)
 {
@@ -107,6 +262,11 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.nway_reset		= bnge_nway_reset,
 	.get_pauseparam		= bnge_get_pauseparam,
 	.set_pauseparam		= bnge_set_pauseparam,
+	.get_eth_phy_stats	= bnge_get_eth_phy_stats,
+	.get_eth_mac_stats	= bnge_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= bnge_get_eth_ctrl_stats,
+	.get_pause_stats	= bnge_get_pause_stats,
+	.get_rmon_stats		= bnge_get_rmon_stats,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 07ba66e3d3de..af681b17f280 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -14,6 +14,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
+#include "bnge_netdev.h"
 
 static const u16 bnge_async_events_arr[] = {
 	ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE,
@@ -610,6 +611,8 @@ int bnge_hwrm_func_qcaps(struct bnge_dev *bd)
 		bd->flags |= BNGE_EN_ROCE_V1;
 	if (flags & FUNC_QCAPS_RESP_FLAGS_ROCE_V2_SUPPORTED)
 		bd->flags |= BNGE_EN_ROCE_V2;
+	if (flags & FUNC_QCAPS_RESP_FLAGS_EXT_STATS_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_EXT_STATS_SUPPORTED;
 
 	pf->fw_fid = le16_to_cpu(resp->fid);
 	pf->port_id = le16_to_cpu(resp->port_id);
@@ -1490,3 +1493,142 @@ int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 
 	return bnge_hwrm_req_send(bd, req);
 }
+
+int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats)
+{
+	struct hwrm_func_qstats_ext_output *resp;
+	struct hwrm_func_qstats_ext_input *req;
+	__le64 *hw_masks;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_QSTATS_EXT);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	req->flags = FUNC_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc) {
+		hw_masks = &resp->rx_ucast_pkts;
+		bnge_copy_hw_masks(stats->hw_masks, hw_masks, stats->len / 8);
+	}
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags)
+{
+	struct hwrm_queue_pri2cos_qcfg_output *resp_qc;
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_queue_pri2cos_qcfg_input *req_qc;
+	struct hwrm_port_qstats_ext_output *resp_qs;
+	struct hwrm_port_qstats_ext_input *req_qs;
+	struct bnge_pf_info *pf = &bd->pf;
+	u32 tx_stat_size;
+	int rc;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS_EXT))
+		return 0;
+
+	if (flags && !(bd->fw_cap & BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED))
+		return -EOPNOTSUPP;
+
+	rc = bnge_hwrm_req_init(bd, req_qs, HWRM_PORT_QSTATS_EXT);
+	if (rc)
+		return rc;
+
+	req_qs->flags = flags;
+	req_qs->port_id = cpu_to_le16(pf->port_id);
+	req_qs->rx_stat_size = cpu_to_le16(sizeof(struct rx_port_stats_ext));
+	req_qs->rx_stat_host_addr =
+		cpu_to_le64(bn->rx_port_stats_ext.hw_stats_map);
+	tx_stat_size = bn->tx_port_stats_ext.hw_stats ?
+		       sizeof(struct tx_port_stats_ext) : 0;
+	req_qs->tx_stat_size = cpu_to_le16(tx_stat_size);
+	req_qs->tx_stat_host_addr =
+		cpu_to_le64(bn->tx_port_stats_ext.hw_stats_map);
+	resp_qs = bnge_hwrm_req_hold(bd, req_qs);
+	rc = bnge_hwrm_req_send(bd, req_qs);
+	if (!rc) {
+		bn->fw_rx_stats_ext_size =
+			le16_to_cpu(resp_qs->rx_stat_size) / 8;
+		bn->fw_tx_stats_ext_size = tx_stat_size ?
+			le16_to_cpu(resp_qs->tx_stat_size) / 8 : 0;
+	} else {
+		bn->fw_rx_stats_ext_size = 0;
+		bn->fw_tx_stats_ext_size = 0;
+	}
+	bnge_hwrm_req_drop(bd, req_qs);
+
+	if (flags)
+		return rc;
+
+	if (bn->fw_tx_stats_ext_size <=
+	    offsetof(struct tx_port_stats_ext, pfc_pri0_tx_duration_us) / 8) {
+		bn->pri2cos_valid = false;
+		return rc;
+	}
+
+	rc = bnge_hwrm_req_init(bd, req_qc, HWRM_QUEUE_PRI2COS_QCFG);
+	if (rc)
+		return rc;
+
+	req_qc->flags = cpu_to_le32(QUEUE_PRI2COS_QCFG_REQ_FLAGS_IVLAN);
+
+	resp_qc = bnge_hwrm_req_hold(bd, req_qc);
+	rc = bnge_hwrm_req_send(bd, req_qc);
+	if (!rc) {
+		u8 *pri2cos;
+		int i, j;
+
+		pri2cos = &resp_qc->pri0_cos_queue_id;
+		for (i = 0; i < 8; i++) {
+			u8 queue_id = pri2cos[i];
+			u8 queue_idx;
+
+			/* Per port queue IDs start from 0, 10, 20, etc */
+			queue_idx = queue_id % 10;
+			if (queue_idx >= BNGE_MAX_QUEUE) {
+				bn->pri2cos_valid = false;
+				rc = -EINVAL;
+				goto drop_req;
+			}
+			for (j = 0; j < bd->max_q; j++) {
+				if (bd->q_ids[j] == queue_id)
+					bn->pri2cos_idx[i] = queue_idx;
+			}
+		}
+		bn->pri2cos_valid = true;
+	}
+drop_req:
+	bnge_hwrm_req_drop(bd, req_qc);
+	return rc;
+}
+
+int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_port_qstats_input *req;
+	struct bnge_pf_info *pf = &bd->pf;
+	int rc;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return 0;
+
+	if (flags && !(bd->fw_cap & BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED))
+		return -EOPNOTSUPP;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_QSTATS);
+	if (rc)
+		return rc;
+
+	req->flags = flags;
+	req->port_id = cpu_to_le16(pf->port_id);
+	req->tx_stat_host_addr = cpu_to_le64(bn->port_stats.hw_stats_map +
+					     BNGE_TX_PORT_STATS_BYTE_OFFSET);
+	req->rx_stat_host_addr = cpu_to_le64(bn->port_stats.hw_stats_map);
+
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 86ca3ac2244b..3501de7a89b9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -62,4 +62,7 @@ int bnge_hwrm_phy_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause);
 int bnge_hwrm_set_pause(struct bnge_net *bn);
 int bnge_hwrm_shutdown_link(struct bnge_dev *bd);
+int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags);
+int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags);
+int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index af69d4d8bafb..9f62b5f19a2e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -39,6 +39,10 @@ static void bnge_free_stats_mem(struct bnge_net *bn,
 {
 	struct bnge_dev *bd = bn->bd;
 
+	kfree(stats->hw_masks);
+	stats->hw_masks = NULL;
+	kfree(stats->sw_stats);
+	stats->sw_stats = NULL;
 	if (stats->hw_stats) {
 		dma_free_coherent(bd->dev, stats->len, stats->hw_stats,
 				  stats->hw_stats_map);
@@ -47,7 +51,7 @@ static void bnge_free_stats_mem(struct bnge_net *bn,
 }
 
 static int bnge_alloc_stats_mem(struct bnge_net *bn,
-				struct bnge_stats_mem *stats)
+				struct bnge_stats_mem *stats, bool alloc_masks)
 {
 	struct bnge_dev *bd = bn->bd;
 
@@ -56,7 +60,20 @@ static int bnge_alloc_stats_mem(struct bnge_net *bn,
 	if (!stats->hw_stats)
 		return -ENOMEM;
 
+	stats->sw_stats = kzalloc(stats->len, GFP_KERNEL);
+	if (!stats->sw_stats)
+		goto stats_mem_err;
+
+	if (alloc_masks) {
+		stats->hw_masks = kzalloc(stats->len, GFP_KERNEL);
+		if (!stats->hw_masks)
+			goto stats_mem_err;
+	}
 	return 0;
+
+stats_mem_err:
+	bnge_free_stats_mem(bn, stats);
+	return -ENOMEM;
 }
 
 static void bnge_free_ring_stats(struct bnge_net *bn)
@@ -75,6 +92,107 @@ static void bnge_free_ring_stats(struct bnge_net *bn)
 	}
 }
 
+static void bnge_fill_masks(u64 *mask_arr, u64 mask, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		mask_arr[i] = mask;
+}
+
+void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		mask_arr[i] = le64_to_cpu(hw_mask_arr[i]);
+}
+
+static void bnge_init_stats(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->bnapi[0];
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_stats_mem *stats;
+	struct bnge_dev *bd = bn->bd;
+	__le64 *rx_stats, *tx_stats;
+	int rc, rx_count, tx_count;
+	u64 *rx_masks, *tx_masks;
+	u8 flags;
+
+	nqr = &bnapi->nq_ring;
+	stats = &nqr->stats;
+	rc = bnge_hwrm_func_qstat_ext(bd, stats);
+	if (rc) {
+		u64 mask = (1ULL << 48) - 1;
+
+		bnge_fill_masks(stats->hw_masks, mask, stats->len / 8);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		stats = &bn->port_stats;
+		rx_stats = stats->hw_stats;
+		rx_masks = stats->hw_masks;
+		rx_count = sizeof(struct rx_port_stats) / 8;
+		tx_stats = rx_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		tx_masks = rx_masks + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		tx_count = sizeof(struct tx_port_stats) / 8;
+
+		flags = PORT_QSTATS_REQ_FLAGS_COUNTER_MASK;
+		rc = bnge_hwrm_port_qstats(bd, flags);
+		if (rc) {
+			u64 mask = (1ULL << 40) - 1;
+
+			bnge_fill_masks(rx_masks, mask, rx_count);
+			bnge_fill_masks(tx_masks, mask, tx_count);
+		} else {
+			bnge_copy_hw_masks(rx_masks, rx_stats, rx_count);
+			bnge_copy_hw_masks(tx_masks, tx_stats, tx_count);
+			bnge_hwrm_port_qstats(bd, 0);
+		}
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		stats = &bn->rx_port_stats_ext;
+		rx_stats = stats->hw_stats;
+		rx_masks = stats->hw_masks;
+		rx_count = sizeof(struct rx_port_stats_ext) / 8;
+		stats = &bn->tx_port_stats_ext;
+		tx_stats = stats->hw_stats;
+		tx_masks = stats->hw_masks;
+		tx_count = sizeof(struct tx_port_stats_ext) / 8;
+
+		flags = PORT_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK;
+		rc = bnge_hwrm_port_qstats_ext(bd, flags);
+		if (rc) {
+			u64 mask = (1ULL << 40) - 1;
+
+			bnge_fill_masks(rx_masks, mask, rx_count);
+			if (tx_stats)
+				bnge_fill_masks(tx_masks, mask, tx_count);
+		} else {
+			bnge_copy_hw_masks(rx_masks, rx_stats, rx_count);
+			if (tx_stats)
+				bnge_copy_hw_masks(tx_masks, tx_stats,
+						   tx_count);
+			bnge_hwrm_port_qstats_ext(bd, 0);
+		}
+	}
+}
+
+static void bnge_free_port_ext_stats(struct bnge_net *bn)
+{
+	bn->flags &= ~BNGE_FLAG_PORT_STATS_EXT;
+	bnge_free_stats_mem(bn, &bn->rx_port_stats_ext);
+	bnge_free_stats_mem(bn, &bn->tx_port_stats_ext);
+}
+
+static void bnge_free_port_stats(struct bnge_net *bn)
+{
+	bn->flags &= ~BNGE_FLAG_PORT_STATS;
+	bnge_free_stats_mem(bn, &bn->port_stats);
+	bnge_free_port_ext_stats(bn);
+}
+
 static int bnge_alloc_ring_stats(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -88,12 +206,77 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
 
 		nqr->stats.len = size;
-		rc = bnge_alloc_stats_mem(bn, &nqr->stats);
+		rc = bnge_alloc_stats_mem(bn, &nqr->stats, !i);
 		if (rc)
 			goto err_free_ring_stats;
 
 		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
 	}
+
+	return 0;
+
+err_free_ring_stats:
+	bnge_free_ring_stats(bn);
+	return rc;
+}
+
+static void bnge_alloc_port_ext_stats(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	if (!(bd->fw_cap & BNGE_FW_CAP_EXT_STATS_SUPPORTED))
+		return;
+
+	if (!bn->rx_port_stats_ext.hw_stats) {
+		bn->rx_port_stats_ext.len = sizeof(struct rx_port_stats_ext);
+		rc = bnge_alloc_stats_mem(bn, &bn->rx_port_stats_ext, true);
+		/* Extended stats are optional */
+		if (rc)
+			return;
+	}
+
+	if (!bn->tx_port_stats_ext.hw_stats) {
+		bn->tx_port_stats_ext.len = sizeof(struct tx_port_stats_ext);
+		rc = bnge_alloc_stats_mem(bn, &bn->tx_port_stats_ext, true);
+		/* Extended stats are optional */
+		if (rc) {
+			bnge_free_port_ext_stats(bn);
+			return;
+		}
+	}
+	bn->flags |= BNGE_FLAG_PORT_STATS_EXT;
+}
+
+static int bnge_alloc_port_stats(struct bnge_net *bn)
+{
+	int rc;
+
+	if (!bn->port_stats.hw_stats) {
+		bn->port_stats.len = BNGE_PORT_STATS_SIZE;
+		rc = bnge_alloc_stats_mem(bn, &bn->port_stats, true);
+		if (rc)
+			return rc;
+
+		bn->flags |= BNGE_FLAG_PORT_STATS;
+	}
+
+	bnge_alloc_port_ext_stats(bn);
+	return 0;
+}
+
+static int bnge_alloc_stats(struct bnge_net *bn)
+{
+	int rc;
+
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		return rc;
+
+	rc = bnge_alloc_port_stats(bn);
+	if (rc)
+		goto err_free_ring_stats;
+
 	return 0;
 
 err_free_ring_stats:
@@ -934,6 +1117,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
 	bnge_free_ring_stats(bn);
+	bnge_free_port_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -1018,10 +1202,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
-	rc = bnge_alloc_ring_stats(bn);
+	rc = bnge_alloc_stats(bn);
 	if (rc)
 		goto err_free_core;
 
+	bnge_init_stats(bn);
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 5636eb371e24..74b08d492c53 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,41 @@ struct bnge_tpa_info {
 #define BNGE_NQ_HDL_IDX(hdl)	((hdl) & BNGE_NQ_HDL_IDX_MASK)
 #define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
 				 BNGE_NQ_HDL_TYPE_SHIFT)
+#define BNGE_GET_RING_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct ctx_hw_stats, counter) / 8))
+
+#define BNGE_GET_RX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct rx_port_stats, counter) / 8))
+
+#define BNGE_GET_TX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct tx_port_stats, counter) / 8))
+
+#define BNGE_PORT_STATS_SIZE				\
+	(sizeof(struct rx_port_stats) + sizeof(struct tx_port_stats) + 1024)
+
+#define BNGE_TX_PORT_STATS_BYTE_OFFSET			\
+	(sizeof(struct rx_port_stats) + 512)
+
+#define BNGE_RX_STATS_OFFSET(counter)			\
+	(offsetof(struct rx_port_stats, counter) / 8)
+
+#define BNGE_TX_STATS_OFFSET(counter)			\
+	((offsetof(struct tx_port_stats, counter) +	\
+	  BNGE_TX_PORT_STATS_BYTE_OFFSET) / 8)
+
+#define BNGE_RX_STATS_EXT_OFFSET(counter)		\
+	(offsetof(struct rx_port_stats_ext, counter) / 8)
+
+#define BNGE_TX_STATS_EXT_OFFSET(counter)		\
+	(offsetof(struct tx_port_stats_ext, counter) / 8)
+
+struct bnge_stats_mem {
+	u64		*sw_stats;
+	u64		*hw_masks;
+	void		*hw_stats;
+	dma_addr_t	hw_stats_map;
+	u32		len;
+};
 
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
@@ -231,6 +266,11 @@ enum bnge_net_state {
 
 #define BNGE_TIMER_INTERVAL	HZ
 
+enum bnge_net_flag {
+	BNGE_FLAG_PORT_STATS		= BIT(0),
+	BNGE_FLAG_PORT_STATS_EXT	= BIT(1),
+};
+
 enum bnge_sp_event {
 	BNGE_LINK_CHNG_SP_EVENT,
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
@@ -309,6 +349,17 @@ struct bnge_net {
 	unsigned long		sp_event;
 
 	struct bnge_ethtool_link_info	eth_link_info;
+
+	u64			flags;
+
+	struct bnge_stats_mem	port_stats;
+	struct bnge_stats_mem	rx_port_stats_ext;
+	struct bnge_stats_mem	tx_port_stats_ext;
+	u16			fw_rx_stats_ext_size;
+	u16			fw_tx_stats_ext_size;
+
+	u8			pri2cos_idx[8];
+	bool			pri2cos_valid;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -374,14 +425,6 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ_ARM |	\
 		    DB_RING_IDX(db, idx), (db)->doorbell)
 
-struct bnge_stats_mem {
-	u64		*sw_stats;
-	u64		*hw_masks;
-	void		*hw_stats;
-	dma_addr_t	hw_stats_map;
-	int		len;
-};
-
 struct nqe_cn {
 	__le16	type;
 	#define NQ_CN_TYPE_MASK			0x3fUL
@@ -588,4 +631,5 @@ u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
 int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 			 u16 prod, gfp_t gfp);
 void __bnge_queue_sp_work(struct bnge_net *bn);
+void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.1


