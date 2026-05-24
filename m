Return-Path: <netdev+bounces-291161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLzZAoHXEmom4gYAu9opvQ
	(envelope-from <netdev+bounces-291161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473005C21D9
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536093013799
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D5391E55;
	Sun, 24 May 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/cQo0jX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4B029B79B
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619500; cv=none; b=uqT3IozFbMdQrtZzgoHgVQ0XQjqpZQWZWCpxMY9fLhxoqMQcEF7kT/9nnFmWQLwTVhJpBkQzyZv4946bDPIRRa4iXjQYhZ4NFjv7yTmxGy5Mxqizqo7ZJNTFvBvpQ5V2ejgLvFO9swE8n41ubcgyOyCLj8+9fwNa8gn8L1q4xuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619500; c=relaxed/simple;
	bh=R0YcoyCM3cB+fPEBMl3+P/amDiK/k9Nbz39/MrAIn28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxT7wyvmH9GxUJbx8tHWUTCCJ8iuCI9JQMer3r+cHAVEnf2dQVrUcupt8MHJFr0bv4mpo5jUNkGpoJR0FzpBS4bxJMaYSkSPcY8KOtGN4NIHlrxkFZogoC6+HKGmfU2ZscNs3qXC+fa+f1FbmGt0v7aKgWVI0d/uP8uqvFdre1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/cQo0jX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso5067016f8f.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779619494; x=1780224294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65RWI5unXcapVvUdFUIqa1siyn6oOE01r03j8xlWPns=;
        b=s/cQo0jX4Q212BQve5VK/90iBds9qN5WwwimKdu+dluggCVhfqfYtlWAcbFokX+rWc
         M2+uJHlAlcpf38sVnDNwAotWJjw26/BQVihW3rQiDufq8vVa5xAdN9xm4znV3dzWUcJb
         uytvTXpAWAXB6ow2lzfsGyrVXGwXOAhaZ/gfAM4yx0E3MLkRtLLNQJa0bFe3vrA3UUN7
         cnP4BZdbPX/c31p4/1TQF0R9dP+55QDe0p/URVn9BGtrcO8I7vdxQDNAlPltKepeZeVi
         BO4NeuhKt3GNHU22074Q+6x0YC3zZPFDgH3WgTZ13w0ByDt2S/aGsrI3LHTX/JORAnvp
         yYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779619494; x=1780224294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=65RWI5unXcapVvUdFUIqa1siyn6oOE01r03j8xlWPns=;
        b=jL9GPFGENBo8Ck9VrjT/SU0cNy7l0ScWJVnxVF966GKLiq/UnuyFkpRAvO1TuKDGHt
         2Pdq5bgr42+/xB1/z6tZvISo9y44cKlCLAjdDhXra8oU3pX9LTr/Eis4EbDcpmzOHThO
         AzkA0xE7aQ0BANgTBS/EvlLI5eFWRkYdOoxZRdhl+0RngB1q64zrFWNPtvzwc+VW0yMP
         2Hgq3tkZj0TtKtxP2zKxjxbgK9bzRgtwFloAFVplMO11pZheqIAy9bGhFpw73V+6E/yb
         loDAauVqestDq1/8m/x7q5+h1fqFWdmXVa69O7rsoPbil52SHOArIUXDE1oEzmK52QXa
         Br+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+FOYWA+KfzCvxTSd6M14P0wil0yPSRQK6vZo38qxJ9aJZ7zlXHny23TBWl0r/xeZdIIcRwfp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHH1yAVueR83YWcxmxdA60N1InLlZiQSLtIkumUglL7GTULCd
	AbQkAfx8p8tTbP/eBAf1aoC4/SB9tohYSjhdGDCWXXKMMh7pq96IVMs0
X-Gm-Gg: Acq92OECwgESQNLclDYYavTBHkJGkGtpb2m4bt+zd/NG8W3uAt+vdTxOtBePdTO7poP
	e2Ev1vnDVvrekkhONfVOtZp9riDKayTqIQkDjTZRQC5Z8PNq8ypv938Lgn9w5sSjDX9EOG71qrd
	5Cie4yBH2O1v0QFgLI/gthEc37wMbHYiVrw33blLY4nAEh9pSE5SR0QuXCBD3WnFgy0AhE5y4WY
	yE7cBKJ0ZRkSh30l9gW4RBOL0PVrrCXZCj8NpCiFIlvk8ZjXZyakZQBe2HUqnX2Bhj+HtK0ioPk
	Dc/dGZrnJEM4HN+m9D0lM3deErsWeq+lYqBQJzCq9kGoM5WG41StWiMsI6UQBE5QEy3wd2AkLNH
	RHLFfy1pgd+7y9U42zM56x0B5sKy5BPMI7o37lODK+a8BkS+EK0mihTRBprzsum51n/FGih7C27
	qMHSPmbnPHuHtCf0u6ehDyGiEznnGM7a56xnR3FbSxrxno6FDhvd6QmcrX/gmtdhaQplHJsolQg
	1QAaCFUotkVIISZZoqy
X-Received: by 2002:a05:600c:3b02:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-490425aa70fmr170767525e9.8.1779619494470;
        Sun, 24 May 2026 03:44:54 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb0c131d7300e352009073da06b6.ipv6.abo.wanadoo.fr. [2a01:cb0c:131d:7300:e352:90:73da:6b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm258967105e9.7.2026.05.24.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:44:54 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Sun, 24 May 2026 12:44:24 +0200
Subject: [PATCH net-next v7 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779619492; l=7230;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=R0YcoyCM3cB+fPEBMl3+P/amDiK/k9Nbz39/MrAIn28=;
 b=8imlxrE8KTBvq56L22UQFyEPNhGuG969EK8dsW36ZQmF9OT9VscMv8+gsCdySBY5jllMLQODT
 AwbSOHj0NpNBli977uKi4VuIbGkR9NKYXqWwMVFFz7I+oysze6efnV/
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
	TAGGED_FROM(0.00)[bounces-291161-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 473005C21D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/dsa/microchip/ksz8.c       | 76 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 +++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f84b2e7d25d..715b4463538e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -798,6 +798,37 @@ static int ksz879x_set_loopback(struct ksz_device *dev, u16 port, u16 val)
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
+	if (!enable)
+		return 0;
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
@@ -1046,6 +1077,22 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
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
@@ -1272,6 +1319,35 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
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


