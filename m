Return-Path: <netdev+bounces-289847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICgiLMh2DWpAxwUAu9opvQ
	(envelope-from <netdev+bounces-289847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:54:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC258A360
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56FC1302DC00
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C273AEF27;
	Wed, 20 May 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVdK6q6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531931352A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266951; cv=none; b=GfKWRgBCfLedLM4afMw88CsK5Fz6/KFDCvri5E/zU7amRlJJE7PP+ROr/VAdQMivsrqFcvzW+tITSq18cC8x99dzJ+MkiWrkcVyTISeGT2PMN4MnfzKxAyzfz83TPsfHNK8rpyHYYBZzyv9txEPpWufkVHMUZ5lqRVIpvG/Xo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266951; c=relaxed/simple;
	bh=H6SGpdaC29K/Zk+eDG+MwjCPxUG2PoHybJvWUO/AYrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIIdVSa0qb8WLkHiYARDAmS+N8teHkEN3H3Z/Es2QdpCKdGI4S6KVvNODHCXf9DbURsId4kJf8WPFI5ssZIV9+ahD86b26LCObPVeXMT02cbCBHi0ZyRe5x0M4BV7j0TTEy0WeMA0EX664uaC7vzubyz5UQqG7IuZ6gdTVuNkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVdK6q6p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-452169ae568so2943905f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266949; x=1779871749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=winpt9D+ghSWBWpkDbNzEDvZl/T9vpO7PHVPp2ovBO0=;
        b=aVdK6q6pSP8XWIwvSZ1auMxv1ZOKTtxZuXhVLTsqNZsCaWU9fJgoauUaXYju707tsM
         EdfNelmYVDgErQDjM+gjyU9uR2bD2Q1qcaFYmyUfk7XH6R7tnBYkpzn1cplNrRFRJ642
         kQAm5ci2gMv2QskO/NPCaOxonhmPajVlAbt/NkHQNpZ7UR07DLUth7k6pjmziNfppQ+A
         1ijLeaBEDxrUrYg3YUdJvRHNPNQ/oNPPwI0uEk8zsGnSapwpMxyNaEI7+LIwK/EyLYtt
         74mlVJZcw9LlepIu/BAm9dlfRaGWEzh7U5gls+ADpKvXF60SVSdou/XHuuFla/1Y6JP7
         s1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266949; x=1779871749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=winpt9D+ghSWBWpkDbNzEDvZl/T9vpO7PHVPp2ovBO0=;
        b=K3DSGpz3xGOESl3h+HvmB9goBf8O9k/bXyY2ir4oIG3DUsniCneB8RZZH3zqGupdMf
         yJl1PUq2/D9v68g9bfitm/ZRQ9XeNpSVCX+EmHJJdM8fThbaXnAjx3o3+1sVViTBBsM+
         uHTeF9tUTVZ2pQfrAhnQjPqTJZ8Zni1bWyInn5omWT+357k4wDt8b87Gbv2F0zzLMfaQ
         TfW+4HRVN2L0Wnm3+GxR4ErGwDaby09MDeYZ3PbKf6NlA1e/La/84HlLDy0I8tCSfU7O
         x4tubNqzB9O0XWm93HhWhK1Xn1MeoEXh2Pjk4P2I6nFzJW9NinCzd/8jWmQBBQiu6gN+
         Kj8g==
X-Forwarded-Encrypted: i=1; AFNElJ9uILXXvUl2KwTElMlBIBtZaYhWFIN4E/Io24K3CBOtaHhnaHlHrfmNsjDFZbKrgnFCVkbi96s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGlS23azo2ji1RVwzVahl/6MicRZVDbMdoPG8pA8NlonOQRuu
	BTyXHckAIhL3CfqXkqK8IizYBfZ8NHYa23JZr6NJs9O7aj/re+bu5vZA
X-Gm-Gg: Acq92OGT6zj8jzblWAYmtdULCt96YS8NW5vyoKfnGTJREcbWJ/TdxdJhIEyo9/3kCGt
	3g7aoly+BohxujgFYIEBHNV6X39PNkw5FOtdb6lEEA9gYeP5pXen0n9WLVrmU+OKKGQZcchQ0Pe
	ciVh/L+MqJErM+S3++A879QG4mCIvbIW3TtdkodVdx2jqV/A6mM6l0zkxv0HnaiIktNYbHEe6Zu
	TVTm30CO3S8g03Mb4MrJWSxgiFQM1BBap/pTJ2/Wk65N3xIpdem/YVA+fsVunaKbigZmR7AiUSn
	At6BFRJMqTzmvoWkVnL/fkqkyfc9IJEw04jO26INWA4AKaiZ7/iEwl7gFgFFYNozq9GsHaG4Ww9
	gp/fJTlYGMOuKMPQ5kfyp9Pwl0Vgw3tdnXF2H4Byj7/0CfGkEa5NaKkIyF1GdBsyAzcUk7BeKKD
	+nClyIHv5oguvx3hBFp9kpI3s1jCWjF9MpsBaSgOUE0cREW8JYAO4bUE82K4TS3TFnRYbqLHVyD
	IwLrOupDw==
X-Received: by 2002:a5d:588c:0:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-45e5c5bbd6bmr37315849f8f.8.1779266948516;
        Wed, 20 May 2026 01:49:08 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm51244283f8f.9.2026.05.20.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:49:08 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Wed, 20 May 2026 10:48:56 +0200
Subject: [PATCH v6 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-ksz87xx_errata_low_loss_connections-v6-1-43f33d4aaf0f@exotec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266946; l=8023;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=H6SGpdaC29K/Zk+eDG+MwjCPxUG2PoHybJvWUO/AYrY=;
 b=z1HLvAITzAVXl3TMNS0BWs9GhiqVjo4lArqLu7kko6VkZNkMsA0vOhv7VKhMQ/YOr/jMtyRzc
 WMruFEemiCeC+ox5ximAQcrxDqGL1YcELKaBX4xPxZcMps04bFqSsUq
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289847-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AFC258A360
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
 drivers/net/dsa/microchip/ksz8.c       | 78 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 +++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..656a28c4dd52 100644
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
@@ -2096,11 +2141,44 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
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


