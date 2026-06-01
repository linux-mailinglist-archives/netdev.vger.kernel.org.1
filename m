Return-Path: <netdev+bounces-293811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DBcGCaoHWp+cwkAu9opvQ
	(envelope-from <netdev+bounces-293811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D0621EBF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24073147CB5
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E4371D1F;
	Mon,  1 Jun 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOB6pluO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509713DB30F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327510; cv=none; b=ValWhBwMOiBKeJVI5gUbUW/OdQuQHBwAcMu7Jru01lQ/54kdNf/PPIuovxBUz212JlJJF4Tu/Zhfk8pg1DhnmJ8+H4HN8gmqi5bEpb2409HzVxKjMGQ9TK48FNeUfZE/mCjdUtXaIrPN3mH6htrIXqqUBWi4ZSgohSBeWAiYazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327510; c=relaxed/simple;
	bh=rIK+8qwUbffbSCQ4JIm1hNQ6maO54VCXxjYbTZbIPiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oC887WuoyF+nk85/sz8pR5uAi6LnPsTngHBL/PWGfV8WcE0sdouNSwnwbxs6mB1mVc2w069Ar86mvUtS1sO5neXpwRCky8K86PGakHPM1U8gi9MnZlGTrlTxsSNYMBZyk+Om8dI3eJybFqjFDKn7rokWuFUAeMT1JXJLX7iBs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOB6pluO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so5127245e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327502; x=1780932302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUz34f8AUlG0gLWcG1NhLV3GhNlUwZnNfPkE4XwZzQc=;
        b=DOB6pluOxeUX3Ir9YBxALM0EsOMygFW7rGUFJXizr5Zne/n7FhcYDCDqQyTxE9BJQJ
         ZIH6gKBW4GX9o86Owfl9b0MdVVK0cL07IhmaxqDXVYIsUnSDRh76KO4DkgkrQFkG8+tO
         /o+Ft92NBPMgHm2Inuclpxq9coURT4OSXEiR6qY2qK70yAfgggwNpWKewt6hRxVqIjpo
         829iRiWITrNfcXob86qP9Ld6kuS5EGnqH5kbwMynQFVj8RMfX98ZXVf/b/F2xC0c77YT
         hnm8+uTFrOK/7oUWbr0i396s/qIZ3lJnVrENaPAcCvhWbHBQKnjcZCRzq2Ux9d42anc7
         qlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327502; x=1780932302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUz34f8AUlG0gLWcG1NhLV3GhNlUwZnNfPkE4XwZzQc=;
        b=SuG+cX23DDIsmUmz9zxHViyBBFbLO0K+bXPyKHB2uuM6891AkoTEj9G56ZeevfLOOR
         RfMZL5qr2u7l474UjWgwtXL9WPnPyUX/NTTkvK3skICUsFykyH0rYWZurc0Dm13+SSZm
         BfuTzoGba5lENvGn14jaxqCuTxFftluXJ2qwBktQTCYiHw8pTPhtOr4BNUt3/r7sR4gT
         sVMUBf1i8ip+/tbzqOEEdFtIFK4nwto9IHHE2KNxllF2xvDr6BmmeQhBfsF191ZJlHCl
         KY2nk5SL54ZmCiOJWaD/ofwJh6jeJqau4bcD5tCesDRmqE55amaA6+BETEVq6L2iTuYM
         uFlw==
X-Forwarded-Encrypted: i=1; AFNElJ93BvA1m5nNVoWqa+ppqB1NcrI8804YbyzvomTQd215gRHkVq53DA2sApTDuQEWqU0pamCRvuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+1FyLf53HN/IiuoBDNEtg460jseAx2KQtKOVBtqjxx33/OGq
	wAdVjkOv24FJ1I5FVci5r90Ky0yMd6CsI9SyBfmR5HuNpVuGJU5gs8yB
X-Gm-Gg: Acq92OFmzHuDW4fq8uO6HlEfLiG/3zrF2/15Lsvf5213Tx6U+MfyoAzZXKm52JjFnD0
	tg6TxnoyCm0R9boKaB9FNSgpXIDuujPJajESux77cO+7yDojMZQu7LIiT/+a4d3SopqvLOeN0gS
	9GHgYw4PyyyeJ1ahsd6SdiyhasE8Zm2tx2wFHZqlQY6JO0ECBlqVNDpucJAJWpY3ZmMB5I29QnO
	zTojg4aUA+8qbOblMVTUu92O5Br7YOwJWyEBDvvFmz3zPE0iPZI1eZscjFTIIFMICXJ4seA7fzn
	hLYRozuVIgTeQboywOX55d6C4N5hOlTO5Wj1EPMTOya9ySaP/P95KfpQNIGx6prMSVxUZHfAcwm
	nRnWV3LYPOsW5tIotdQsn59qbWwlGPhXnjd9YvK/94IDlVy2kpsvo8Qcnh2OmDbTj6fHRKye9MG
	OBk9ikl94J5UeDXKuQL9ywjVTRcqMbXlmuO3Gwr1Rf4R18T0H6ufnJxu/3iAUSE3YvuaPisvR+P
	+rlPgtoV5Peyn6p8zb4
X-Received: by 2002:a05:600c:8b01:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-490b06a6547mr10113085e9.25.1780327502267;
        Mon, 01 Jun 2026 08:25:02 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e26050sm26035e9.9.2026.06.01.08.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:25:01 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Mon, 01 Jun 2026 17:19:55 +0200
Subject: [PATCH net-next v9 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v9-1-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780327500; l=8207;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=rIK+8qwUbffbSCQ4JIm1hNQ6maO54VCXxjYbTZbIPiM=;
 b=6qpSaYGclTV5E2vuVNO0bzimLpsVJ9OfNNREUmK+pX2WBd99j/g2UZuDRt9WJUjIrkotZrfpL
 IcH/lNbJcXEA3l2xxyj/LSTlyfVlKmD+n6g4RFlpShxAsz/vS6ULcgl
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
	TAGGED_FROM(0.00)[bounces-293811-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,tipi-net.de:email,nabladev.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:url]
X-Rspamd-Queue-Id: AD8D0621EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the KSZ87xx short cable workaround.

This patch implements the KSZ87xx short cable erratum
described in Microchip document DS80000687C for KSZ87xx switches
and the following support article:

Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

KSZ87xx devices require a workaround for the Module 3 low-loss cable
condition, controlled through the switch TABLE_LINK_MD_V indirect
registers.

This change models the erratum handling as vendor-specific Clause 22 PHY
registers, virtualized by the KSZ8 DSA driver and accessed via
ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:

- A boolean “short-cable” preset, which applies a documented and
  conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
  value 0), and is the recommended interface for typical use cases.

- Separate LPF bandwidth and DSP EQ initial value controls intended for
  advanced or experimental tuning. These are orthogonal and independent,
  and override the corresponding settings without requiring any specific
  ordering.

The preset and tunables act as simple setters with no implicit state
machine or invalid combinations, keeping the API predictable and aligned
with the KISS principle.

The erratum affects the shared PHY analog front-end and therefore applies
globally to the switch.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 89 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 ++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f84b2e7d25d..4ec2d5d2a1bc 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -798,6 +798,40 @@ static int ksz879x_set_loopback(struct ksz_device *dev, u16 port, u16 val)
 			 stat3);
 }
 
+static int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
+{
+	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ init 0)
+	 * providing a conservative configuration for short or low-loss cables.
+	 */
+	u8 lpf_bw, eq_init;
+	int ret;
+
+	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
+	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
+
+	if (!ksz_is_ksz87xx(dev))
+		return -EOPNOTSUPP;
+
+	if (!enable) {
+		/* Restore default values (LPF 90 MHz, EQ init 15). */
+		lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+		eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
+	}
+
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, lpf_bw);
+	if (ret)
+		return ret;
+
+	dev->lpf_bw = lpf_bw;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, eq_init);
+	if (ret)
+		return ret;
+
+	dev->eq_init = eq_init;
+
+	return ret;
+}
+
 /**
  * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
  *		     Control register (Reg. 31).
@@ -1046,6 +1080,22 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 		if (ret)
 			return ret;
 
+		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = !!(dev->lpf_bw == KSZ87XX_PHY_LPF_62MHZ &&
+				dev->eq_init == KSZ87XX_DSP_EQ_INIT_LOW_LOSS);
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->lpf_bw;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->eq_init;
 		break;
 	default:
 		processed = false;
@@ -1272,6 +1322,41 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		ret = ksz87xx_apply_low_loss_preset(dev, !!val);
+		if (ret)
+			return ret;
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		/* Only accept LPF bandwidth bits [7:6] */
+		if (val & ~KSZ87XX_PHY_LPF_MASK)
+			return -EINVAL;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
+		if (ret)
+			return ret;
+		dev->lpf_bw = val;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		/* Only accept DSP EQ initial value bits [5:0] */
+		if (val & ~KSZ87XX_DSP_EQ_VALID_MASK)
+			return -EINVAL;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
+		if (ret)
+			return ret;
+		dev->eq_init = val;
+		break;
 	default:
 		break;
 	}
@@ -2070,6 +2155,10 @@ static int ksz8_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
+	/* Initialize KSZ87xx short-cable preset control */
+	dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
+	dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+
 	ret = ksz8_handle_global_errata(ds);
 	if (ret)
 		return ret;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..981ab441d9b7 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,10 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
+#define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +346,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +733,23 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Vendor-specific Clause 22 PHY registers (virtualized) */
+#define PHY_REG_KSZ87XX_SHORT_CABLE		0x1A
+#define PHY_REG_KSZ87XX_LPF_BW			0x1B
+#define PHY_REG_KSZ87XX_EQ_INIT			0x1C
+
+/* LPF bandwidth bits [7:6]: 00 = 90MHz (default), 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
+#define KSZ87XX_PHY_LPF_MASK     GENMASK(7, 6)
+#define KSZ87XX_PHY_LPF_90MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 0)
+#define KSZ87XX_PHY_LPF_62MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 1)
+#define KSZ87XX_PHY_LPF_55MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 2)
+#define KSZ87XX_PHY_LPF_44MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 3)
+
+/* Low-loss workaround DSP EQ INIT VALUE */
+#define KSZ87XX_DSP_EQ_VALID_MASK		GENMASK(5, 0)
+#define KSZ87XX_DSP_EQ_INIT_LOW_LOSS	0x00
+#define KSZ87XX_DSP_EQ_INIT_FACTORY		0x0F
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b67038cf1bd0..45613b9aeb1e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -222,6 +222,10 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	/* KSZ87xx low-loss tuning state */
+	u8 lpf_bw;		/* KSZ87XX_PHY_LPF_* */
+	u8 eq_init;		/* DSP EQ initial value */
 };
 
 /* List of supported models */

-- 
2.54.0


