Return-Path: <netdev+bounces-289849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH8UMaN4DWqfxwUAu9opvQ
	(envelope-from <netdev+bounces-289849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 414CE58A548
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B6530EB13E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3713B4EA5;
	Wed, 20 May 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V66aSMa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAC33C183
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266953; cv=none; b=KLASivDOI76MI/wz63NGoXpThQK3z0eXtlLit4tNQO4KOFmu7N4og+vug0bj/bbDKbyWrjsoKLNFKdAFNBlPXBegH6sV4I5Tk+bzg49n0G48O9nVXHegw6xcA8Ps68twFtQaCLh2F8j2zMXSmQb7M6EnjG9XHJeurDAfoRteMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266953; c=relaxed/simple;
	bh=hLquf2FXjFMX5gDHDJVCQehd9khx7qm22bITTcuq5Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BN+QW0eENLGPczDw+vQ+8NFOAEQLq4woz2tVszDSQn5dVwir6MQi5PF8P+p/4E0mgR/mD726B1oYTjckKXQdMNYlMPWOi0tYzL7/ZrS4j7CQsU3+2s6uDiSr9kQA/7TZRi39AN56nFs8JhYO170ZqI4GA/rqgXXgYNz/P55nxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V66aSMa2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44e5624c053so2730455f8f.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266950; x=1779871750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+LElh/p4H7Jl1wglSsGBgLSISpuoKZ91ueSbuYJV04=;
        b=V66aSMa2ffQLDmr4NUxe4t91JgwAG2SMkaVm3LMPzLCjdcVpsCSe2n+jN/PfGaziXU
         puITKL2OmhgWZKE7z0h+TN0yD5maYg2r5deD+LfrpGePmhDPy/fZVbXaXBHhlIzma6SI
         phUEGd1nY+Lbvx4VllZn6lERQRsdWPjtXcTS0FVrpGa8WAElRrxARfzp+8L1wrr+/aZ+
         2RON1awj8fXc/c+4Z+xlQrk7xkJfBqaTlBvvsN7SgEFNSlyVyQQXJaPLGhyhCo/gYj7n
         pWNvJyd2seu6caUyBIYTCcSg29jNUyRFJ/Up30YkUpKNzKviGlQYUYhSch6wHIfkn08l
         VIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266950; x=1779871750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+LElh/p4H7Jl1wglSsGBgLSISpuoKZ91ueSbuYJV04=;
        b=Bd3VjdFag1NPboUkULEfYUvsCGqRzWXPSlyq9DUfg9FbMudecTyZxOwkrqxz+fy8yv
         ef2mmOThzUqTL1tSdMhJUkXKI4puA/SmGYJ2uo4O9VriR7npS4Mr+rp4plEp3NF2PudY
         SJz8T2RngovkOC7M+bnNZXWMFfYjgvyKHnprK31LNFqJm3eqycilCWJaiBg+e38m/YZo
         D3mAUiL1xdx10qmWJ/h2YjYrEVCBUW+L/xTqzpyxnhAUFJYstydmJIbkpJhIBj68O2YX
         q8SpMMpHoc96ljfwk1y7TM7LEWE6mLeP4rmOWE08Zciq9yo5tl+RU6N219qEKQr9Ffjn
         osvw==
X-Forwarded-Encrypted: i=1; AFNElJ8XVEV92StE85vBLZ649IROoEqO2WL2CHKGcNK50IDk3lC+TNgK+67k+3X3nsryLPdVrUalD18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfBWrZLdb05oZId5zIPwUOMIOYbJoLDKXfizy+A5om8HMmJlLn
	vAgy7DIoMgKz1HBDhYm9GlYDxAt75DSxpHd7xq+zDmc9Km8TJvEXli0o
X-Gm-Gg: Acq92OGHMctEQdXw567xzDiUgPGrrtcP1D8KCPWrc4k0kV0fcPbCIu2G26wSAuXYefW
	38H45m2K5Racs7Ps+Nr7iBxlxvLL4PIwx9+xItq9XlnEbHWr443jf0xmgsK4dRoOX8lVrrQViJ5
	VymBd0AszGo3nCqzRZ4IwVKtEKDQ712IP9QIlqiz45WUkc7/g4bXb8xoGTTcPEvXQiSICqTBjbH
	qI/w6f507bL9Mxw32E6f2T3zUY/OxohtZ+gRJDsM/eiovgHOcgJ1WdmSNIYzI9OtznZI+LBO4LZ
	Xxy3v70FISefcGzU8Kev+ak+OMnXa0WmcjigDVsgPfRH+NClLf1UNm7+c9iyW4OglKLnFVcRCTL
	Mz2lxaG0GiS2WmoR056gnPcWQjgQOvQ0Mnz6aWrZOWtOWqdz0rOT0S6QSHDtP97PeWkLC0gN7Dv
	A8CTQl1cWwB0hZQJaG20xLD1C69HKt/ro6X4d4aMNoeewJ7Xcaa9n3fNS28o4fQiXJd+Zp/Xq7+
	/hD4zJWog==
X-Received: by 2002:a05:6000:2489:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-45e5c58fe72mr35661001f8f.4.1779266950168;
        Wed, 20 May 2026 01:49:10 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm51244283f8f.9.2026.05.20.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:49:09 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Wed, 20 May 2026 10:48:58 +0200
Subject: [PATCH v6 3/3] net: phy: micrel: expose KSZ87xx low-loss cable
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ksz87xx_errata_low_loss_connections-v6-3-43f33d4aaf0f@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266946; l=3380;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=hLquf2FXjFMX5gDHDJVCQehd9khx7qm22bITTcuq5Mk=;
 b=cK4F35M8B0Cw0K9VbWlMCM/PYKwoXdxSE1gp9f8kEryPtpA5EG3yWedCT00iVzwV/zfGOPYjf
 yie7gI25W0OB2xE7yQ3Pko6XUj/xosLmM5Lxd7cJFx8N7706HJO4osH
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289849-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,exotec.com:mid,exotec.com:email]
X-Rspamd-Queue-Id: 414CE58A548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the KSZ87xx low-loss cable PHY tunables in the Micrel
PHY driver by implementing get_tunable and set_tunable callbacks.

These callbacks expose vendor-specific PHY tunables used to control the
KSZ87xx embedded PHY receiver behavior when operating with short or
low-loss Ethernet cables. The tunables provide:

- a boolean short-cable preset applying known good settings;
- an integer LPF bandwidth control;
- an integer DSP EQ initial value control.

The Micrel PHY driver forwards these tunables via standard phy_read() /
phy_write() operations, which are virtualized by the KSZ8 DSA driver and
translated into the appropriate indirect switch register accesses.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c6b011a9d636..da91ef992361 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -287,6 +287,12 @@
 /* PHY Control 2 / PHY Control (if no PHY Control 1) */
 #define MII_KSZPHY_CTRL_2			0x1f
 #define MII_KSZPHY_CTRL				MII_KSZPHY_CTRL_2
+
+/* Vendor-specific Clause 22 register, virtualized by KSZ87xx embedded PHYs DSA driver */
+#define MII_KSZ87XX_SHORT_CABLE			0x1a
+#define MII_KSZ87XX_LPF_BW				0x1b
+#define MII_KSZ87XX_EQ_INIT				0x1c
+
 /* bitmap of PHY register to set interrupt mode */
 #define KSZ8081_CTRL2_HP_MDIX			BIT(15)
 #define KSZ8081_CTRL2_MDI_MDI_X_SELECT		BIT(14)
@@ -940,6 +946,52 @@ static int ksz8795_match_phy_device(struct phy_device *phydev,
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+static int ksz8795_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	int ret;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		ret = phy_read(phydev, MII_KSZ87XX_SHORT_CABLE);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_LPF_BW:
+		ret = phy_read(phydev, MII_KSZ87XX_LPF_BW);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		ret = phy_read(phydev, MII_KSZ87XX_EQ_INIT);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ksz8795_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	u8 val = *(const u8 *)data;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		return phy_write(phydev, MII_KSZ87XX_SHORT_CABLE, val);
+	case ETHTOOL_PHY_LPF_BW:
+		return phy_write(phydev, MII_KSZ87XX_LPF_BW, val);
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		return phy_write(phydev, MII_KSZ87XX_EQ_INIT, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -6809,6 +6861,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz8795_get_tunable,
+	.set_tunable	= ksz8795_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.54.0


