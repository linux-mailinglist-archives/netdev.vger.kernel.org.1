Return-Path: <netdev+bounces-262095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBH9DqOZomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:30:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F081C1084
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D09D31343DD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480636C5B8;
	Sat, 28 Feb 2026 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PCVBOn8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA136CE0D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263696; cv=none; b=oR1UCKrbEHlkvgXUYH8CI7KyhBMb+QbeeF+M6mcz3cS/CbNqnZAcpo8pQeh5pFN1NmwCyOz22nSSwKi8JKyAvLHEGRli345vknSl6PeEs9k7213JxEYm+LWG70cnPpSHytXnnMNVp2x9m/KyuPvI5EVsxxV4cCwQz0WqwnVQf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263696; c=relaxed/simple;
	bh=RI2O/lNGf1FHG8lBBdNR6Rg/0jZYOOT3Qiqv5EhsqVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahq8AUvAGuiAFfpLkiAQvUOhMw1RMcOHfnTkaDRjgmVGv0YdiGGqak/D2QMhyzla4xWY9NZGURvwefK7yCOhjDXmkpFzJCzrZk8X1D+yeCI/aGlchT8/ADhlM001g1a4woJBLMNAJqs3A1D9uB3vtCG2mbst8Sa5gJL2QZGHjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PCVBOn8R; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-126ea4e9694so2441073c88.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263694; x=1772868494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=jS/lAOUeiJNymjorK0q/ql2PPRBAvvEja8+X0mc8BMqdQC8NQokltDyxeF4tmO/JL4
         fw4SfQgNLC3dsylEZbBcl1lYHzIyZrdJ/T3/FUzsCZkFaEB0oqmLbc/S1HNFfd6Z/FR/
         kjYNcc8TDqaaRHUq7yy6gOpJx8z3CKVTcNW4f0NwxFFGLu7jGYJaBar8PpiXn81VELKc
         JrHnjSEcSKAbWGFx3qm7iGE3B2Uy3ji5hpqNf6P1q+MoWsV8ut+VOD503F9x871eO1np
         JHedmX16jZ180qaUbSP2fk2/Zk80tsrQoj/eDQEr/6vG4VKL4JWTNuZCleLLzUfMsos+
         qrvQ==
X-Gm-Message-State: AOJu0YyfRRxnaSZ0HSAH0iHlyJstdvDzE9XyalcH2df0+NAA5OJKUmfm
	hlPxqdUH+T2FXthDeFBkxnamJrEC9sRSoJR3R3NC8hs/t2dIaxs7dwQioyABTz3MHh92zMPKXlc
	hw9sxHOSiutj+IQjVRXq9ETx218YO23FELOA9enadMux0owj1jzCrd0ZHX/S8iR4WNQ/++DDLCj
	8OpuV4O5Wh+4Mrw5UjIyCxi5/MyA6tlgVrVjTIrZbHgLix4sdltZBnnPPIKTP09vuZ679CKbdAJ
	3J8qWQoLnJL0oOzBg==
X-Gm-Gg: ATEYQzw1QJoy4h/1i6pX8yMgo2G6jrNxAsVVjaoFtGbq4KZ77TTv7rNMTPTQffAy6Dw
	j08MYy31arGeU/BCERjvcxRwmy1jobpPAb7em4CRwkbqEylIjLd7XGOkfM1M/pXevNiXkoPuqS0
	hdLQVVBtbysIs09rxj7HckgxiFIomHPH370ooWaGTk/VDXQ1ilTnAIwAZBB5mg+Fy++JlhE5oaU
	XAccydh83l33D7SP20dBxeVkS0Aoj+v4pTLP5q75kOuXXsHEgIipFZ9kg7PuWbwG7nSR3sgQDXC
	ehTnT5Vefx7MQCRzVurleQ3ZmxP31zyFzCTa0hOoCROaiA3wKCKZO/KX4oh6hhmhFxhSEgo1HUP
	V5oQxEZnZ85RFrPJ+AQsapro3HzafDk+fWkiloQ+2GLm14F5YHZt1aKE5IV9eiD1YtqMgTG+XnP
	+ZQltyGnY/wY4qL/vLt24qdABlNViTfdZe3UFrdtNI5taiGM++F/aUbFk8ZUBEyH7LHw==
X-Received: by 2002:a05:7022:2205:b0:124:abaa:7fd5 with SMTP id a92af1059eb24-1278fd32629mr2425664c88.38.1772263694364;
        Fri, 27 Feb 2026 23:28:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12789a3074bsm1054364c88.8.2026.02.27.23.28.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:28:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8272825e843so1957105b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263692; x=1772868492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=PCVBOn8RhI8t3B+m43G6qLb8fJWa/TFB1RFU5guDOi9vxO+NlTSIIdLjSBuxTb4HU6
         bV+HlX3vxl/emC2+ttC8SusWyFw4epKDFlgyFwVUEZFwi/QHA+MGf7dMiuWPVTBqJS5u
         YG9bUvpVVmq7Fd3k8D+nw5l3m5YHv5mJqf1Fo=
X-Received: by 2002:a05:6a00:288f:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-8274d958acfmr5163731b3a.23.1772263692657;
        Fri, 27 Feb 2026 23:28:12 -0800 (PST)
X-Received: by 2002:a05:6a00:288f:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-8274d958acfmr5163709b3a.23.1772263692179;
        Fri, 27 Feb 2026 23:28:12 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:28:11 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v3 4/8] bng_en: implement ethtool pauseparam operations
Date: Sat, 28 Feb 2026 12:57:11 +0530
Message-ID: <20260228072715.1632280-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86F081C1084
X-Rspamd-Action: no action

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index e4d3041db0a..01382ad784e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -42,6 +42,62 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static void bnge_get_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE) {
+		epause->autoneg = 0;
+		epause->rx_pause = 0;
+		epause->tx_pause = 0;
+		return;
+	}
+
+	epause->autoneg = !!(bn->eth_link_info.autoneg &
+			     BNGE_AUTONEG_FLOW_CTRL);
+	epause->rx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_RX);
+	epause->tx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_TX);
+}
+
+static int bnge_set_pauseparam(struct net_device *dev,
+			       struct ethtool_pauseparam *epause)
+{
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+
+	if (epause->autoneg) {
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED))
+			return -EINVAL;
+
+		elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+	} else {
+		if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+			elink_info->force_link_chng = true;
+		elink_info->autoneg &= ~BNGE_AUTONEG_FLOW_CTRL;
+	}
+
+	elink_info->req_flow_ctrl = 0;
+	if (epause->rx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_RX;
+	if (epause->tx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_TX;
+
+	if (netif_running(dev))
+		return bnge_hwrm_set_pause(bn);
+
+	return 0;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -49,6 +105,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
-- 
2.47.3


