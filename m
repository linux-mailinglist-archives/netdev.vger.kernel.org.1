Return-Path: <netdev+bounces-305328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JdcNF3y4TGq3ogEAu9opvQ
	(envelope-from <netdev+bounces-305328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:27:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3450719156
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:27:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=ZihbO5xu;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305328-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42D130D5F9B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122433F8C2;
	Tue,  7 Jul 2026 08:21:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259631716E;
	Tue,  7 Jul 2026 08:21:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412507; cv=none; b=ZzMovGUbrsMOPRUkL7KINPn4M3tacsIBS8gkwfkDR6b9bM7UxKyKunmMiaQL8QtXBa/zH3X+hlRauRsUIYhkUkHWQuCXVtMjAqq2kVE5yRm4Gh9/2jPNETyy+/sSTNyR5iW//vqy51LRANugkiS+G7btIoaeQLtjiyl6oMOMIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412507; c=relaxed/simple;
	bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPCsv7xkkbpoOKamrwX9irQeKB4GbpEFlX0tezhwq4br2Z1b3ihQpRk3rdvHe4oUgsj4T+Lx8AZJEyuzBk1VfQ+9w+0eX/qHm/QOEECDidhq+5hC/lH9btDU6c4uwvkOcbhY6zMhIpGo+g6De+j4CORqoAZFsEJk7P67LU7kMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZihbO5xu; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412501;
	bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZihbO5xuWnROe/iFMijiFg5AjBA6+EHIH98vWSA/uGkwwcBxz+ewy2BZDHac9uAMs
	 9LT0BUKmMU+2554CstLQnCo9B7g9VPk/JN6YSwA5BVC8D9wLWEPvZruLGOmsRRorxH
	 DlMunPqiuHl7OdWU9s/I9NiSV0CNRYTQRqRp4QQ+SHNY2VF9Y/cnTJRY3XfGTsa2FD
	 8FhZNg0mjmQ0etpb9A8uAz/IsJV96Fu9kY+baUo2wT8GCO6isDOSOe9KT6Rpg8L7io
	 x3ivOZ67/M2ErE0ot3s73aIX5Lc3rPdNJxmj4NgZqGWBR/Jjte7PRItjXpKgVEAhJz
	 gBOMV97e0lafw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A4B317E0FD0;
	Tue, 07 Jul 2026 10:21:40 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 07 Jul 2026 10:21:23 +0200
Subject: [PATCH net-next 5/6] net: stmmac: mediatek: add support for TX
 deallocation adjustment feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk, 
 kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=3068;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
 b=rYDH1k4qqZavWOEuPdvowUc/+WZvhIhsF7JkDbjG/He606di+QhEkFX8U4MRI7ZTScJ3JTE1m
 TvJs9RvLmHUBfzahx6b4AyEUmD4/uTI3RRcUyL6RNmbW1pWOovvYZiq
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305328-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:biao.huang@mediatek.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:kernel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:louisalexis.eyraud@collabora.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,foss.st.com];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3450719156

The MT8189 SoC has in the Ethernet control 0 register from the
peripheral configuration (pericfg) additional bits to adjust the TX
deallocation.

In preparation of MT8189 SoC support, add its definition, use in the
set_delay_v2 callback, and a support flag in the platform data.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 25 ++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index bcc0baef3f71..6b0a42b5839f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -37,7 +37,8 @@
 #define ETH_FINE_DLY_RXC	BIT(0)
 
 /* Peri Configuration register for mt8189 */
-#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
+#define MT8189_CTRL0_TXC_OUT_OP			BIT(20)
+#define MT8189_CTRL0_DLY_GTXC_STAGE_FINE	GENMASK(11, 6)
 
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_BASE	0xFD0
@@ -103,6 +104,7 @@ struct mediatek_dwmac_variant {
 	u32 peri_eth_ctrl_offset;
 	u8 dma_bit_mask;
 	bool use_out_op;
+	bool use_stage_fine;
 };
 
 /* list of clocks required for mac */
@@ -326,9 +328,12 @@ static void delay_stage2ps_v2(struct mediatek_dwmac_plat_data *plat)
 
 static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 {
-	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
 	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
+	u32 gtxc_delay_mask = 0;
+	u32 gtxc_delay_val = 0;
+	u32 rmii_delay_val = 0;
+	u32 delay_val = 0;
 
 	delay_ps2stage_v2(plat);
 
@@ -402,6 +407,9 @@ static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES, mac_delay->tx_delay);
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv);
 
+		if (plat->variant->use_stage_fine)
+			gtxc_delay_val |= MT8189_CTRL0_DLY_GTXC_STAGE_FINE;
+
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
@@ -412,12 +420,17 @@ static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 		return -EINVAL;
 	}
 
+	gtxc_delay_mask = MT8195_RGMII_TXC_PHASE_CTRL |
+			  MT8195_DLY_GTXC_INV |
+			  MT8195_DLY_GTXC_ENABLE |
+			  MT8195_DLY_GTXC_STAGES;
+
+	if (plat->variant->use_stage_fine)
+		gtxc_delay_mask |= MT8189_CTRL0_DLY_GTXC_STAGE_FINE;
+
 	regmap_update_bits(plat->peri_regmap,
 			   reg_offset + MT8195_PERI_ETH_CTRL0,
-			   MT8195_RGMII_TXC_PHASE_CTRL |
-			   MT8195_DLY_GTXC_INV |
-			   MT8195_DLY_GTXC_ENABLE |
-			   MT8195_DLY_GTXC_STAGES,
+			   gtxc_delay_mask,
 			   gtxc_delay_val);
 	regmap_write(plat->peri_regmap,
 		     reg_offset + MT8195_PERI_ETH_CTRL1,

-- 
2.55.0


