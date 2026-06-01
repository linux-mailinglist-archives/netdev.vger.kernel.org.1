Return-Path: <netdev+bounces-293713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHQLBml0HWp8bAkAu9opvQ
	(envelope-from <netdev+bounces-293713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6871861EBBF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B177F300BC8D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3D36A37F;
	Mon,  1 Jun 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbcK9ryq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14081374E46
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314902; cv=none; b=XlaPMWUJkAfMwEMY62P2lqCyOkTvzzy3M9JkrV18juZt7fjUCFnclACpbmToeWLt/liIMMbYzeSl47APsyaB8RV4irMgx/VpqwAnlXRfE1ONCd83Afplbch/prAjQ+kJKn9gVEtHPWBcrVGQ94limjPdxKBrvNJhCWiAdPoKlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314902; c=relaxed/simple;
	bh=Tu4FNa6kgf7cLgHKjrxiYsyzSpQdRdNBBC/3eIfUIJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxZU/0dqJlNRSZ8svl9Rb8J4U5GAks7DfqDI6GyxDzJwf3OqxG5b98/unDxQnZOsfBwQdDoJzBPZz033op5o5rdOyI9WauFfP70jkaz8bl08EBYQ6Sobe+YeqpwrRRzB4x2MQr70uRXsB2Nkia978IDaHvHRK2y1w7blXjQTIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbcK9ryq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490a765d410so15102355e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314884; x=1780919684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wS3u9JAWCCtJAD5b759FtzMVcsYv3WpkvZULsXjkNRQ=;
        b=MbcK9ryqn4ACCXjiTuTojRjNQRLTTPwtoQuRMyBkfEYPOAJIV35nptHQxioFh/UwLc
         M3Tn33UWLRW4Fz1Ko94KO8ozRBub0HaoXVR3/+yR5qcEzj9HYU1D/Ku6n5rE7AspD36T
         o6drHqWLcGJFcqUAO4KDCUt7h8AMMCprmvjptWqDZ6uWnbbEz6HUei8L47/RQPu59NjJ
         fUJBlvopeZxx3cmAM1yKzKiSmbAfHxxXhJgkGiFbfsjWs/zEDblEqSxfjnsUHfuWf/K4
         Wdm2jxdG0f055W2R9rN0KfW2RGeQVuDphAKB1hyAG0+OeWd+dSS9GC4xRzRlkTNjB5FR
         kiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314884; x=1780919684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wS3u9JAWCCtJAD5b759FtzMVcsYv3WpkvZULsXjkNRQ=;
        b=iQUQnQCV6Hnbm5lToiOKEfkHoyhesjhoAqh8EbHLA1NJRuv+xFXxjAQYXVAcKNdDdJ
         fkjhuIYL0i2sObXcgf2zc+qDgJ9PGeuCF7IuCiNdLKt9oNMgB3jMyIG03qSv3atmJeeM
         U54GXdy/ivHCYrlGuegkjO65avvnvbJYjlF7a6oRllOh2YfXjENkHU4Zs+bhcRykVMnn
         F09lBB0LaCN2lWbsXz1eBAUUeU0c1Iv5OzsJ0hXsbkLnBapMS61pRG/gTCBRxoau3JlI
         iHu2jIqqWP9riu9CR7eckIUZ0XanMk9i4TResaVkPMSB7PbBAsNt03zoc5tA09pKbn9N
         ZQdg==
X-Forwarded-Encrypted: i=1; AFNElJ80XTVaF/hMUls3strVKgN1FyaeyYDeo4SYe14IkSgGjR/Ua1s6+HbGhvqu6mWuRnkVIhUnSKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODBW40BOuGYYwNAuJZpSlrUI+HQ7iHWR8k/rcYA7ACqoo7z7U
	0g88SGn4nzD4/RbOMk8h0Jofv8jjHafiVuQ3w2A9xlZeopb8Mz8OrCtP
X-Gm-Gg: Acq92OG/Jo1yIz1UjvBUoSI7a6DNcycWw9kIysW3XAaBpDAOH5TE4BoNoMJOfINCxOs
	TSvvPvVVYgANwdHd2cClsVDj0DOGGNcgdTgndkhVrx1QfiPXoZGdNm7ECeMeDiHK74wFkLIbigb
	SOeOs7l9r3dF/ctAEAQlSDJ3NmeeoNkUfrrOJVESYDCgHdVQsIJ8P2o6h1j2QNJeq5x4hHQXCSg
	G1kgmGGrRDC3kSG4LQD2KKtRI6/hf9YM7JgWIAwlCEC6Ghq5rSWEdvU43dxC3p/kLRJdYwYMNR1
	UkHzIg26DgH9mu7Tw2AgNIyM+2ijljT6Wn6L0Cu9TuzjjtdswZNOMn2lKQGk45i3YVhwba8xpFJ
	bw171xftG0oHiQHoTZNYHOSyh0IK76hkl26dtkZjM3b5b0m5Q7e++CEP88Bp22Qd+m1r7fcbiAU
	25EBGLWJ4HgpvtenfVmnLaiYpYbxRfGv1yiBEa7ng7PVgf1yGLJotrohnEai+K2JVCsCWVreLJH
	tbNyIIe3267RQ/W9v1q
X-Received: by 2002:a05:600d:644e:20b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490a296b260mr148872025e9.28.1780314884313;
        Mon, 01 Jun 2026 04:54:44 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c121d63sm74376765e9.29.2026.06.01.04.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:54:43 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Mon, 01 Jun 2026 13:54:14 +0200
Subject: [PATCH net-next v8 3/3] net: phy: micrel: expose KSZ87xx low-loss
 cable tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v8-3-cfa102cf62c0@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
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
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314877; l=3427;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=Tu4FNa6kgf7cLgHKjrxiYsyzSpQdRdNBBC/3eIfUIJs=;
 b=5YgGHs8nNpXaLP4gMbeFIv/1q5ep4+istH4HSSrnQH+7TR+wJeQ6LOb+Nls/Tpf59hB+Wa8uQ
 RtY9JggFvMIBTDjmr8wz4qPt+J2If6g58tm2TbQhMxdS+zbg7SGiQ8k
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293713-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,exotec.com:mid,exotec.com:email]
X-Rspamd-Queue-Id: 6871861EBBF
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

Reviewed-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e211a523c258..bb8f3054e257 100644
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
@@ -6961,6 +7013,8 @@ static struct phy_driver ksphy_driver[] = {
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


