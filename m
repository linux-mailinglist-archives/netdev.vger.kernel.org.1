Return-Path: <netdev+bounces-269306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCwoLy+Pu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A612C6594
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A089302A193
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0C397E99;
	Thu, 19 Mar 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D5jl+Hpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395EF2BE7AB
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899564; cv=none; b=YYgI0YCPDCtA9VxVpeCsHwAp2iMFkD3e6mAp6cD3IvyMWfSY1d/aDk7EejCJHiDy6DtxJsuv9WOu00zqQU8GKirfUvG6+DSc3ZohvdoIegGGqsra4SQSg1EMGdrUnv7n6sjy4qvEYNumFQAvXnoLpc8agvrWGduocOkgQo2FCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899564; c=relaxed/simple;
	bh=cwbyj1ooo9Qz7huYKrO/pQhap2OaZVcpI54mpWxp6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADPkFEN+zRq6LyUS3/qQs37Aad1We+EpipyauCZwuOJx0VnpIj6VWCQo0N4g52JxTb4Muk0pd1r+ktI8HRQ2eevCtx5yLWH84tbpUhUDVN7JvMn7ugmQJzEU2ovPOXM8IbT1RStnDpDmqy3rMAsc3uQR0eglLQ6uOrRWnNjU4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D5jl+Hpn; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-40974bf7781so1173912fac.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899561; x=1774504361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN4rJh4Zci2AFuVsQwX5cXgl6r8zy06083cabZMtsqc=;
        b=bHd5zaYsjD/bgD8DVuUGetNcxXuI7mWN+ZOwTA9iK8fwdY3e5/fLrkvNnP2EQzZxCp
         GbSk/+iDSH6VO8boE9geo3SDZm3/p4zDnYoL7a9M5linfb2K7GSm1fJW6KJWRiDES1Ov
         fC0zRqpSsq6xQEJvdL15DXdEkzvQb0pNwzg0CvtJlsC0IVysBsFaPIQpjtrt4trOhXWs
         b0WL1DbZ0fTuZQR8065SAGukpQ0TcvF4s+T4NBw/YmLuMzKFjmE3tV3szdGAqPfT4c9G
         /JeIBPadnIrtoM4a5qwXr3957mbXrmJ89nzQcIyVbAhbfSQxbEfMJ1tfOKV1zXlTgz3D
         D1Ow==
X-Gm-Message-State: AOJu0YzIzyJu54r3ke/IvU3S5KT1I29hPRV8AdHSodasBdX3u+UAIhrR
	MFHKaSlF9oajyO+ZkE22nnfFtW8SiZhrax3wqo/oCnsuxV37/eoMrwGxjgClmvZ7oBsBft/8Cwz
	h2AcJljsAK+zB52AFrsDf2w1CGL1ASw+ogHWKwfePseB8tu9UJ6ngu4bnyg0QrI/FTB2+U0hWRC
	J12Ri0BiMLotXV6DEALWId9NglPYE6bZrKOfkR8ovuEHrdi29hXZjTRoMKGE40AMMqkFbPKn9hw
	sIxrtgeZA==
X-Gm-Gg: ATEYQzxtG+V69tgh51bShWt1dqzr8w7UqUS12oxfN1fdZjNxPWB9K9hRyxckkoHjFya
	lAmqKoitn8ZaWeRnLxqTdrIj4MonPkyQNgfN6SOD76NFiJm3Czk67La5ZYxS90Cs6ao4fZ/1dnh
	WYgyeOBlc+lzxKX/VCozpY6WlQ5gDVUwaiDXKAjISke/OzsoeBc9qEWrfS942LN58Xks0RWqME1
	U9e4+ganJjEC3/yb190wZHsfBWQZ2YOFXyHJHwOCzuUmcAEY3tQpII66bk1VsWOgtlEzU7kmu/5
	4cb19CGRqGelacKLOiRQUpCOifWubW/CIwaU95Zq3SEa72xDDLwYmBCJO+ndVIf+4D+S1EuxuRG
	m12rGWiZPvEw9L3AEpjAbTOY//kit1KVokvYW3oonaxqOtCO9gKI6joqXiQKNdMwgo3zz80IFSU
	H+uZ+eq0+5XzrwLV3tZ3f63EXtsrcF9NQlt8j40VXVX1MvoeJaZbb7uasBBQ==
X-Received: by 2002:a05:6871:338c:b0:417:b858:3c11 with SMTP id 586e51a60fabf-41befc56fe9mr1620695fac.5.1773899560911;
        Wed, 18 Mar 2026 22:52:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41bd28b977dsm669267fac.4.2026.03.18.22.52.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca2fce827so2404253d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899560; x=1774504360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN4rJh4Zci2AFuVsQwX5cXgl6r8zy06083cabZMtsqc=;
        b=D5jl+HpnHW83Dk4G4xK/uuosGVPRlzgLsWlyonsE9Z9sAqJHWNscmdrjiHm7AljF0k
         58rKI5u0aMPS6qcrDSjTvfOwoEj8OXV0QtOvPuVAtpYPy4xNeQquC7ChU1szAKS5XW1P
         76XrJlcgfLDkt/Htz0rGhJ6UEps+UIBARewxw=
X-Received: by 2002:a53:d8ce:0:b0:64c:9a6c:8326 with SMTP id 956f58d0204a3-64e9cce665emr1660346d50.19.1773899559932;
        Wed, 18 Mar 2026 22:52:39 -0700 (PDT)
X-Received: by 2002:a53:d8ce:0:b0:64c:9a6c:8326 with SMTP id 956f58d0204a3-64e9cce665emr1660336d50.19.1773899559487;
        Wed, 18 Mar 2026 22:52:39 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:39 -0700 (PDT)
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
Subject: [PATCH net-next v8 04/10] bng_en: implement ethtool pauseparam operations
Date: Thu, 19 Mar 2026 11:21:18 +0530
Message-ID: <20260319055124.1350670-5-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269306-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 39A612C6594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index e4d3041db0af..01382ad784e3 100644
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
2.47.1


