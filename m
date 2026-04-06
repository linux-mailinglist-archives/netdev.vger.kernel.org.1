Return-Path: <netdev+bounces-275687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIP2Ol7202k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3D3A5FFF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C86DB301151F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5A392803;
	Mon,  6 Apr 2026 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FXJh00I+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BF39151D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498721; cv=none; b=oEn15GfcsEeHOsO4iHfRgke3kyz8uuCpmdjDMImYEVRTUdlCWSnCoCGhxxs0sCQ6dNOD1b8AaJGwLjLEwriRacBzg10kUuAXYPmm2jON23ChHd2FHkgyry4pNj0tXhdeuaNFTFjuTm7gCeS+HrUmWJ0l6YXzlYtmWKRd4xsGLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498721; c=relaxed/simple;
	bh=wlbhBmmcU5vccLBMkzSDxzOKZsBV8R9a8i1WZeDoby8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWzZp43KMpNOHTSLBmwcrgjTssaPWfdURf0sitvoAKwtovo8QkpvZlYvaV/Ggq0+bfIuXF77I4x6gIY3ksjTgwtBx/VjmJRgRw3yta0oIf594aSGNGKz5v5eb9tG6MA1V6Rky9/U4tO4bCIm6zjDb2YE4gVSedADFafKwqLE4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FXJh00I+; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2c15849aa2cso5286268eec.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498719; x=1776103519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUyZiVTNKsqn9jj8gYUSvfoN+c8WD4aQmQkycQsfN1o=;
        b=srtzYeW5Wv4MGGiQwKCfVw/smhikJEfN71rZIkmCe0Q6hVcuC+YfeekNs98iptpxAi
         0d4tad7gYTW/BIX6ulUHYx2m2FN/kx3IjIUVkFE7+7cL9Wtswql/YM1y35sem7X6t2rz
         6i5Uh/210BxVxewmVQALgCsW4KpY56kMfSQvqmwFp2t2LAIaxPmaElURea5YChRHR+HD
         vznF40daNREVJ+e787gUEL3fqVvn9LyHTMnAf/v/F+qPLUdnUGOaS8w0gfOo+ThUYUAi
         9oA1DhZCbHidfGmLHgs5fOIKGX+G5tprUD9oTIz9AoUHJAqkRnGdC8XRB3S77HALjHOU
         98hw==
X-Gm-Message-State: AOJu0YwRvgVEpuBngHW+CR3stLPVH+RwjL9GasECWU8hfXstwXLJd4kH
	qVTeYa9iIlYaEylF5WkAOLFklvNDrLqAUH3v5BJQubgkAypeS8oBGcGPRcSUBA074Qbl8lJV9g6
	W1l/XEoJPeKq11AtbD8RDhEdZcsGhhEpSxzdzwi/LyHUuWDrAIGsZuHzbxT2gwtfZQ2K8ZbuffR
	4SeQhUjsIh7UyM3pNhv2QWejkpHd4PWsXmZVqLOF6A52H5UXzg6Ch//qgM2xP5HPkGdkdW32p0L
	eVrYl8Q2g+iqP8XGg==
X-Gm-Gg: AeBDieuvpns+hb+B4uBhDoYoGhJhtKkz92iwiw5gXwTBJIKndNyVGL/IXJZ6W57jFa0
	NndR3LEaAN4hZp5ef7frwv8FWpCBvhuO2Y8Zsfwm6VFw41y3ZzikUMt15OEIeuR3/eNuWnvcnq2
	3Uq5l7U1RyexIZSTkEl4Bdt+uXeMwscq4888MyljbyYPu1T80lhAdjjgVHCS6THIRJYBD6toJKR
	EzM+FZymhH79Ix898F871cLSrPlK7Q7N85wRKqu34up7nITN6D5HU81FH8w03wEZzLGVBrE2Y6O
	q6eflU2C+kqfqPOvtCHccJ7DeB7MretgSpnxuWVop7H4PAI7+zD/cktDchf/or28IBk9qbIFodl
	dLHgTwIyCjEwGRzCoTLUrAiON+z+DSJ9/BAgPhumusW31rzOjx0BzWDgbopLYDYoPO73rWXOnNn
	OTqNkazaswt5YfBzeIbauL8jVQE9+lm6JXUo9Gp5AdHk7RxFp4akCamzXJQNdce+8=
X-Received: by 2002:a05:7301:1688:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2cbf99ec075mr6471182eec.2.1775498718869;
        Mon, 06 Apr 2026 11:05:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca7be0b59asm982348eec.19.2026.04.06.11.05.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24308165dso109174565ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498717; x=1776103517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUyZiVTNKsqn9jj8gYUSvfoN+c8WD4aQmQkycQsfN1o=;
        b=FXJh00I+KgAOYNYQ4R9h/U9V7yywjZjtzcUJbfAB/65i3bgdJZcSNT8mZQMRgIH2JN
         HPmFJHRw9R0xTpuaEzaJw1BlEC+GxlX7N79Sis+BwneCIdju9bpWohGjG4YLOsrC8++F
         FiXDC6p8DxgAB+0QoOzWiyXcdeO+a+7d1atTE=
X-Received: by 2002:a17:902:f611:b0:2b2:470d:6d0d with SMTP id d9443c01a7336-2b281706f78mr148607205ad.9.1775498717151;
        Mon, 06 Apr 2026 11:05:17 -0700 (PDT)
X-Received: by 2002:a17:902:f611:b0:2b2:470d:6d0d with SMTP id d9443c01a7336-2b281706f78mr148606715ad.9.1775498716433;
        Mon, 06 Apr 2026 11:05:16 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:15 -0700 (PDT)
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
Subject: [PATCH net-next v12 04/10] bng_en: implement ethtool pauseparam operations
Date: Mon,  6 Apr 2026 23:34:14 +0530
Message-ID: <20260406180420.279470-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275687-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03B3D3A5FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 6bb74a84ea03..424bf2d6721c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -46,6 +46,67 @@ static void bnge_get_drvinfo(struct net_device *dev,
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
+	struct bnge_ethtool_link_info old_elink_info, *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+	old_elink_info = *elink_info;
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
+	if (netif_running(dev)) {
+		rc = bnge_hwrm_set_pause(bn);
+		if (rc)
+			*elink_info = old_elink_info;
+	}
+
+	return rc;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -53,6 +114,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
-- 
2.47.3


