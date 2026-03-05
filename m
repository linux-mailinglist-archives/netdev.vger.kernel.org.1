Return-Path: <netdev+bounces-264530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBaxMJPiqWl1HAEAu9opvQ
	(envelope-from <netdev+bounces-264530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:07:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46370217FBB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA0D3303E776
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7F3043DD;
	Thu,  5 Mar 2026 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gYWawKEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB33ED5A2
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740884; cv=none; b=KKn869thgZE+17tc5zxpdb3IlS89KWbLhMC2H+mEd3UI4Upz+JIpTEQmUuk56YpNNuOyGgb1zMJT9potXl4iNQ9yq2Hl5a1BKJdwbDzLTNTi1LGcsnAvmmfU/Q9b75TOZvK4dGdI9EiRSz6LJOIOlC8ufEPKJjcGWuPFl6VBo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740884; c=relaxed/simple;
	bh=RI2O/lNGf1FHG8lBBdNR6Rg/0jZYOOT3Qiqv5EhsqVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVoCg5xvRLgBvHVM9GTH2TuHsuiYAZb4Me773TPtMtxi9hgO1/KUL1WgG+qYVbDxY1r2zIxTE6NftuA4UwiFC9J+nid6bWb2LXvuRFunwMbp+Bc986PTNlnfzjh0YWyLoNUgtnH8is4f7u45UDFfVuDN8h4+SFyvayu8IFPBcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gYWawKEb; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-899ee87355dso67220886d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740882; x=1773345682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=RPdL9jp3rW3xk7IdasEG2eZDzyJkLaxh1I7f4YXvC9UOiUib31KBRdX6IVzH1uTkcc
         RdtXoPHihvlpmA+Q0juWvJAcMe4AbIZJIKJwOLfYbPXIhIrycwnq1+IFMa1J3ti2qxCN
         985+2o5T0J11MVVcLRfqTStArJgQTjdtaAIkLk2tRVjwiIl3volma3W7Jhmz0QmxvzTc
         ye91P0MMpuAf9cR+8eyLUvccJsJQ7+oNDA1LNZZbLHTwSGp+wY4BUMwNsG54Kviiotmh
         kYzffrfjLL7aluQYzeeVxsXGadvJzKoWPwEunCcbBSkYheFz5gxD3+QJQv9wp0xFa6Xz
         0X2A==
X-Gm-Message-State: AOJu0Yzeo46HG3vvKOlHu0QKMhWpB5nOCLR5BZiNs9coG3I5mEfsousv
	CLf/8+ZSSB+lnTWxH1E8dMUJ7cTc4zUXW23egDrBuDf8kakslrb2eBuVbZ6opC0VYy08v6Ncakt
	gNlLqNEO3eGwrhOIlva3b9+red2Vh+H2X0OA63YlOAHpJVTV3blnQh2diex5Aak9+52AIlPF55J
	VW4wD9QIjLXo5zXek5BIiSrTZw14+rB/KA60Mm03OKDXVIev/0U/uzpjJN3neeeKDdn/Nst1Nau
	f2XpihKUi2dgG84EA==
X-Gm-Gg: ATEYQzyYDTzoh74srVLXVA+kwE8HFwi84MnWEYcRjhNkfNhB3DmACUX8p1jt64+uQtY
	o5V+T2ddcQR6UL7O575dhAjnZuhK9DSRiEuOFvqh2G1MsDiCDhqHvOJESR1mtcyM5nhSRhmFt3X
	fr1a4g80PK89CsGYDwRlql6XjvbeoPaW81FsMIYF17jaReNiCh2lB6b3ao2sBVggttLwv1Zv8dn
	eKaXTvmY2hBvD4KVSaHaLK40G4rJvAzH/P9h7QJ5SaWTpZ6ZJuqM1Q+5OSBBTbWvZgP/vSw5gCU
	xX7hc46NWc99qSqxrw8JhE4+OrQBqVCo1gDsHlm7YKQeSNOftEeUwOjH6GYK0QZHChNn2d6xj3y
	bfrz6jH6lyS3/lE4u4P9BYHhcWgMdkm1wkkOGWEiC7Ruus4Dj/DAOjU/SaGA6XzdbLdylTXNTJw
	xjyBnZYQaksTlbGif1H1eTXz3Df8rWMCpn7F3RjZG4rLXq2xlFs0qIU+4uYgrv4j8=
X-Received: by 2002:a05:6214:29c3:b0:899:e971:9691 with SMTP id 6a1803df08f44-89a1997a073mr102604416d6.1.1772740881966;
        Thu, 05 Mar 2026 12:01:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899c73640b0sm23604386d6.28.2026.03.05.12.01.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae57228f64so47557335ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740881; x=1773345681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=gYWawKEbxClQFNUTubkPGIN4Yhrye6D7pO87h6A6MquEe5vTWp4Tbt9CJHYEEiXJSZ
         LoRatfflz8/iRjphbL9y9XtDPn6z+qn4Iw7TIYu/pFfCqjqfl5lhYr/xCMJdRckNRwyX
         fmrT876p1XWUFs7Fs+xtDSJXDOum8whaMSmFs=
X-Received: by 2002:a17:902:e549:b0:2ae:4f15:1ab6 with SMTP id d9443c01a7336-2ae6aa42655mr65590975ad.15.1772740880491;
        Thu, 05 Mar 2026 12:01:20 -0800 (PST)
X-Received: by 2002:a17:902:e549:b0:2ae:4f15:1ab6 with SMTP id d9443c01a7336-2ae6aa42655mr65590485ad.15.1772740879677;
        Thu, 05 Mar 2026 12:01:19 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:19 -0800 (PST)
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
Subject: [PATCH net-next v4 04/10] bng_en: implement ethtool pauseparam operations
Date: Fri,  6 Mar 2026 01:30:11 +0530
Message-ID: <20260305200018.111728-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 46370217FBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264530-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
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


