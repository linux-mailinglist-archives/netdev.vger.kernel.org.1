Return-Path: <netdev+bounces-284354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOBAD47Y+WmbEgMAu9opvQ
	(envelope-from <netdev+bounces-284354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B034CCE78
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40DBE3029A75
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1903914FE;
	Tue,  5 May 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMO57CxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5A381B02
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981338; cv=none; b=FVHVy5/tg/EFhmb84tSnkdnS/BMF9INAVL/Fvv9fYlwOJeIY/NqsHYAyYk9c4tnTKS+8tRpFmRtoYKSGZtvqax8cALUL4tdTPLbYoIq7UHU8WEfCBWaE8HtpyR7VeoJZnjQwfhnTxI9H0cBqsrqeqsos/aJSj7nY+Ig0Ll/v1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981338; c=relaxed/simple;
	bh=0DBYZ0OHc96PubhDLfpSi/6exkt0TeIh+xxJ/cwExT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUxXVKuMrToJ674VJIeSMww+Lm3vi0Ys/jSspS1DfI+X2Xqlr2i3mhKd/JVaDNXjpx0CUgqTGRXKyEl/f67SHcsWIeIpMn2zmikx2Snnd6lDu7DsgQO/z2Eerx7OKaM45kPnV8YLBIWmiUL8J/gMiAOCEomaP3chdDvo54+tXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMO57CxF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso43247515e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777981335; x=1778586135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW58Mnrr7EFtwPBQY9NqzeHFutqbTyM7rMgnNzRPTkY=;
        b=BMO57CxFuyKwjuVOofh6sI7nZMw71GPNWpw0wFE6ypeJF0/0hhXHoVrvhgQhS2M4Yy
         h/IdLyde87a1be8PFrnGqeeicDR2sl+3A0bk85I51Dyy25wpWCX02eEIfXB9ExRRZoUK
         AwOKzs1XKzbkmvBem6E2IDKaZKURepzLsl6ujeGlkewlAwe0FJIFHrP0Vr4RelnevgY8
         c/cTXEBSx2ILLHe6bU6MzbRUloPcbA10KC3aBTJQW2CZ9DTBSaTCDbOIz4a1rAsVfewx
         exVDcVTuda2qafLelxPBkKNytBv3Kryq4Op7nZOcQHgsb8Gj80FyyB4GMejx1hhoKPG6
         R9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981335; x=1778586135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RW58Mnrr7EFtwPBQY9NqzeHFutqbTyM7rMgnNzRPTkY=;
        b=fFNkC+1CfZmnZn9pu8IPEvEqf1LbotRLCLgefbw2MsXyzU4ez2iQSVDFnVPTnWdojW
         j456lvTWlSfTh6nogCX/3xpo4iR3TaaXXrDjrMFY3WdkjfiI/r9iw7BI0poPxeux3Gee
         LKHbN9PivnvGzDaHFYdFESZmyyaL4/u26i9RIPz5HDGKIzdSSuAu7nv4x2sq8XK2vgmR
         hEd5Gwd7MltNP/af0PZtHokAPiD0z9o45jVLEmzDU9+9pSBFE70yU4zADNx+XQPPP77S
         H8qhKlCXGLvTdPHFq33wI8XUW7i2wP8OreIUlQz1KH46ceR486q8ggGPWUEgOOyi1vRy
         Fw3g==
X-Forwarded-Encrypted: i=1; AFNElJ8eItWXFc9XTh6EEdB9M4S41/xXgXsypDm1vUSvzS1NBRK1UR/1I6mfugtPNK9bt1Rkb9Htc7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPw12MkRqSu9pGx98zz3kK1SXL7Drr4e3FV0e1EwQ3LV5s++t
	Ensi78IeKUK4f4bQjMVwKROXCDt6aFsz9HCPqIH+Al1khWOhUi6hMCEJ
X-Gm-Gg: AeBDietCALBb6oKCDXkBxDRYXvzEr4FN5f4sA+OfuSSJC3s2r0qklNpdpb3ScUbaPCw
	qEbE1//cv6jLTzl4k4u1djUeZPK3CULig0FgUa7PgLVZyqegFTp0xO3MT/SLkNGhC9NQDBakt96
	WN4VhzpCaYxHwGqFYT8gJ7TFnJ26dBgKOUlQxuzqh/enRBAbKnZ2X+pt3nx+RvHKSLlC+sjAvj7
	I8OK3fUQBWt2E5+NPpD++ied88vK6ZEa2H6zdetYCGk2LEzAaRvnU0Fyh1I0yh54LCWTw3BfGqx
	I0NKhVIna24tpTv5SqSzSp5KCYhbvSZ+SdQNVNYrygF6ZndgY5FYMSB5E87a2BDroawU567yt8O
	SoC274cXrgWuDeHLwAdJqMjXD9m6w8Zr0jG0XaVDpM6ab2ZZNjmaH68Z71cDpq14uPa9SbMiqbl
	Weu5KzEZ3R2GST4aQA6xqapgdIUU3i8xvhrrYSkWUSbwysiS5VP63ua+tzyrlXvdujENzb6vsDX
	Sss2m8pkBGtqVyJLh/9qaMgJ2sl2Sie
X-Received: by 2002:a05:600c:a30a:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48d18cef14dmr29090035e9.28.1777981335228;
        Tue, 05 May 2026 04:42:15 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8434-6628-bc01-577d-da52-626d-d378.rev.sfr.net. [2a02:8434:6628:bc01:577d:da52:626d:d378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm616575105e9.1.2026.05.05.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:42:14 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 05 May 2026 13:42:10 +0200
Subject: [PATCH v5 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-ksz87xx_errata_low_loss_connections-v5-1-da4002b21c42@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981333; l=7914;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=0DBYZ0OHc96PubhDLfpSi/6exkt0TeIh+xxJ/cwExT0=;
 b=xEYsXFV81GdeuHZkY/KVZIIrpVaxU7LclQupkEk96HaGoCH0TwCi1J1ThauveCV0lZN/Djyqg
 k62UkBJkGzwCqKa4SfzTjkoljmlz7l7N3ex4dQVITGfK2EERE1b8EGA
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Queue-Id: E8B034CCE78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284354-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,exotec.com:mid,exotec.com:email]

Implement the "Module 3: Equalizer fix for short cables" erratum from
Microchip document DS80000687C for KSZ87xx switches.

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

Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 73 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 24 ++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..62fc59c3da7e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1058,6 +1058,22 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
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
@@ -1271,6 +1287,35 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		ret = ksz87xx_apply_low_loss_preset(dev, !!val);
+		if (ret)
+			return ret;
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		/* Only accept LPF bandwidth bits [7:6] */
+		if (val & ~KSZ87XX_LPF_VALID_MASK)
+			return -EINVAL;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
+		if (ret)
+			return ret;
+		dev->lpf_bw = val;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
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
@@ -2096,11 +2141,39 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
+{
+	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ init 0) */
+	/* providing a conservative configuration for short or low-loss cables. */
+	u8 lpf_bw, eq_init;
+	int ret;
+
+	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
+	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
+
+	if (!ksz_is_ksz87xx(dev))
+		return -EOPNOTSUPP;
+	if (!enable)
+		return 0;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, lpf_bw);
+	if (ret)
+		return ret;
+	dev->lpf_bw = lpf_bw;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, eq_init);
+	if (ret)
+		return ret;
+	dev->eq_init = eq_init;
+
+	return ret;
+}
+
 int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
 	dev->phy_port_cnt = dev->info->port_cnt - 1;
 	dev->port_mask = (BIT(dev->phy_port_cnt) - 1) | dev->info->cpu_ports;
+	dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+	dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
 
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 0f2cd1474b44..5cf7bd90af0f 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -66,5 +66,6 @@ int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 u32 ksz8463_get_port_addr(int port, int offset);
 int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
+int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..cd41214f874e 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,13 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
+#define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
+
+#define KSZ87XX_DSP_EQ_VALID_MASK	GENMASK(5, 0)
+#define KSZ87XX_LPF_VALID_MASK		GENMASK(7, 6)
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +349,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +736,21 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Vendor-specific Clause 22 PHY registers (virtualized) */
+#define PHY_REG_KSZ87XX_SHORT_CABLE		0x1A
+#define PHY_REG_KSZ87XX_LPF_BW			0x1B
+#define PHY_REG_KSZ87XX_EQ_INIT			0x1C
+
+/* LPF bandwidth bits [7:6]: 00 = 90MHz (default), 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
+#define KSZ87XX_PHY_LPF_90MHZ          0x00
+#define KSZ87XX_PHY_LPF_62MHZ          0x40
+#define KSZ87XX_PHY_LPF_55MHZ          0x80
+#define KSZ87XX_PHY_LPF_44MHZ          0xC0
+
+/* Low-loss workaround DSP EQ INIT VALUE */
+#define KSZ87XX_DSP_EQ_INIT_LOW_LOSS	0x00
+#define KSZ87XX_DSP_EQ_INIT_FACTORY		0x0F
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..482e79cf6ae6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -219,6 +219,10 @@ struct ksz_device {
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


