Return-Path: <netdev+bounces-114095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFFC940EDF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618F61F21A44
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992981946CF;
	Tue, 30 Jul 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ojL5roqi"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA5208DA;
	Tue, 30 Jul 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334885; cv=none; b=KKhJPzfbL43oezjDXX5t0vtulawWwvOQy/NrQB24v4NLYEw5MXUrFBU+IMgo16ItriMcL+mahGfO2D7oieeZkMgkJBhxNtI7C6ShiU+REDP0SfHHvVZ6gBnv06kRi8QX7t2f2oAn2/SlE3TJ+EuuN0REvh7Y91qq/er6C8jy/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334885; c=relaxed/simple;
	bh=sigOodIwPpXh2GORua4anHt2mZuJyZQiPY6Q7DtWd1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEgYfAG3hftjSnR4lQZ1KmO+a7T2bncJotPivccLVwfGXlmH3O1SWq5xar1XgwsTu9j25BQglb45stkw1xnj40oEPcuZPlPfxL2yE+xePHwIdV/hLhRDepBRnyfklDU6qjn/krZpyVrEMf7ChXwPsuiONA8L4P7RIOI7ZqaE8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ojL5roqi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB1FEC0007;
	Tue, 30 Jul 2024 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722334879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5kn09ALVaJhj3KhtoBp125Gu0c31/xl+c9wLd5pJUs=;
	b=ojL5roqiNFaq9F9YYiRfX1PvtZaA2DVCS356nzWiYbI5G93c9w2elzwxWglqQW+Cv0olkb
	6Xsw/kn2ITWaEklfimWUUSRVEyv7FekzLz6+vuC2WtWzQlUAHBUGT/8ZZ3/fCxs7Y2dFSd
	tdFjeW2g/uczQvG8hFolCIEVWdYaPXPHRTaKzzKFnwrl6wFd8FOjU9MjnQl52MF9t1GCAY
	sDfgm5kwULPXE2r41KjLAlKjw41nF2amibrf7EtnVyS+Pq9799W6ptFAX0Wdws5nUuAJk9
	D7dd/6ho6F5vCtekIXf2QldHLuoebtQtUuf6i1Gb9oknfsJ6TlLhitNYykVZbQ==
Message-ID: <b4c98268-e436-46d5-8906-2fdaf6e89fed@arinc9.com>
Date: Tue, 30 Jul 2024 13:21:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: Add EN7581 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722325265.git.lorenzo@kernel.org>
 <04a0f38a37e2a38438cdcd8d23ee4d80048e39da.1722325265.git.lorenzo@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <04a0f38a37e2a38438cdcd8d23ee4d80048e39da.1722325265.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 30/07/2024 10:46, Lorenzo Bianconi wrote:
> Introduce support for the DSA built-in switch available on the EN7581
> development board. EN7581 support is similar to MT7988 one except
> it requires to set MT7530_FORCE_MODE bit in MT753X_PMCR_P register
> for on cpu port.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/dsa/mt7530-mmio.c |  1 +
>   drivers/net/dsa/mt7530.c      | 38 +++++++++++++++++++++++++++++++----
>   drivers/net/dsa/mt7530.h      | 16 ++++++++++-----
>   3 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index b74a230a3f13..10dc49961f15 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -11,6 +11,7 @@
>   #include "mt7530.h"
>   
>   static const struct of_device_id mt7988_of_match[] = {
> +	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
>   	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
>   	{ /* sentinel */ },
>   };
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index ec18e68bf3a8..8adc4561c5b2 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1152,7 +1152,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
>   	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port that
>   	 * is affine to the inbound user port.
>   	 */
> -	if (priv->id == ID_MT7531 || priv->id == ID_MT7988)
> +	if (priv->id == ID_MT7531 || priv->id == ID_MT7988 ||
> +	    priv->id == ID_EN7581)
>   		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
>   
>   	/* CPU port gets connected to all user ports of
> @@ -2207,7 +2208,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
>   		return priv->irq ? : -EINVAL;
>   	}
>   
> -	if (priv->id == ID_MT7988)
> +	if (priv->id == ID_MT7988 || priv->id == ID_EN7581)
>   		priv->irq_domain = irq_domain_add_linear(np, MT7530_NUM_PHYS,
>   							 &mt7988_irq_domain_ops,
>   							 priv);
> @@ -2766,7 +2767,7 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
>   {
>   	switch (port) {
>   	/* Ports which are connected to switch PHYs. There is no MII pinout. */
> -	case 0 ... 3:
> +	case 0 ... 4:

Please create a new function, such as en7581_mac_port_get_caps().

>   		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
>   			  config->supported_interfaces);
>   
> @@ -2850,6 +2851,23 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>   	}
>   }
>   
> +static void
> +en7581_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
> +		  phy_interface_t interface)
> +{
> +	/* BIT(31-27): reserved
> +	 * BIT(26): TX_CRC_EN: enable(0)/disable(1) CRC insertion
> +	 * BIT(25): RX_CRC_EN: enable(0)/disable(1) CRC insertion
> +	 * Since the bits above have a different meaning with respect to the
> +	 * one described in mt7530.h, set default values.
> +	 */
> +	mt7530_clear(ds->priv, MT753X_PMCR_P(port), MT7531_FORCE_MODE_MASK);
> +	if (dsa_is_cpu_port(ds, port)) {
> +		/* enable MT7530_FORCE_MODE on cpu port */
> +		mt7530_set(ds->priv, MT753X_PMCR_P(port), MT7530_FORCE_MODE);
> +	}
> +}

This seems to undo "Clear link settings and enable force mode to force link
down on all ports until they're enabled later." on mt7531_setup_common()
and redo it only for the CPU port. It should be so that force mode is
enabled on all ports. You could position the diff below as a patch before
this patch. It introduces the MT753X_FORCE_MODE() macro to choose the
correct constant for the switch model.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ec18e68bf3a8..4915264c460f 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2438,8 +2438,10 @@ mt7530_setup(struct dsa_switch *ds)
  		/* Clear link settings and enable force mode to force link down
  		 * on all ports until they're enabled later.
  		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   MT7530_FORCE_MODE, MT7530_FORCE_MODE);
+		mt7530_rmw(priv, MT753X_PMCR_P(i),
+			   PMCR_LINK_SETTINGS_MASK |
+				   MT753X_FORCE_MODE(priv->id),
+			   MT753X_FORCE_MODE(priv->id));
  
  		/* Disable forwarding by default on all ports */
  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
@@ -2550,8 +2552,10 @@ mt7531_setup_common(struct dsa_switch *ds)
  		/* Clear link settings and enable force mode to force link down
  		 * on all ports until they're enabled later.
  		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   MT7531_FORCE_MODE_MASK, MT7531_FORCE_MODE_MASK);
+		mt7530_rmw(priv, MT753X_PMCR_P(i),
+			   PMCR_LINK_SETTINGS_MASK |
+				   MT753X_FORCE_MODE(priv->id),
+			   MT753X_FORCE_MODE(priv->id));
  
  		/* Disable forwarding by default on all ports */
  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 28592123070b..d47d1ce511ba 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -355,6 +355,10 @@ enum mt7530_vlan_port_acc_frm {
  					 MT7531_FORCE_MODE_TX_FC | \
  					 MT7531_FORCE_MODE_EEE100 | \
  					 MT7531_FORCE_MODE_EEE1G)
+#define  MT753X_FORCE_MODE(id)		((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_FORCE_MODE_MASK : \
+					 MT7530_FORCE_MODE)
  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_MAC_TX_EN | PMCR_MAC_RX_EN | \
  					 PMCR_FORCE_EEE1G | \
  					 PMCR_FORCE_EEE100 | \

> +
>   static struct phylink_pcs *
>   mt753x_phylink_mac_select_pcs(struct phylink_config *config,
>   			      phy_interface_t interface)
> @@ -2880,7 +2898,8 @@ mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
>   
>   	priv = ds->priv;
>   
> -	if ((port == 5 || port == 6) && priv->info->mac_port_config)
> +	if ((port == 5 || port == 6 || priv->id == ID_EN7581) &&
> +	    priv->info->mac_port_config)
>   		priv->info->mac_port_config(ds, port, mode, state->interface);
>   
>   	/* Are we connected to external phy */
> @@ -3220,6 +3239,17 @@ const struct mt753x_info mt753x_table[] = {
>   		.phy_write_c45 = mt7531_ind_c45_phy_write,
>   		.mac_port_get_caps = mt7988_mac_port_get_caps,
>   	},
> +	[ID_EN7581] = {
> +		.id = ID_EN7581,
> +		.pcs_ops = &mt7530_pcs_ops,
> +		.sw_setup = mt7988_setup,
> +		.phy_read_c22 = mt7531_ind_c22_phy_read,
> +		.phy_write_c22 = mt7531_ind_c22_phy_write,
> +		.phy_read_c45 = mt7531_ind_c45_phy_read,
> +		.phy_write_c45 = mt7531_ind_c45_phy_write,
> +		.mac_port_get_caps = mt7988_mac_port_get_caps,
> +		.mac_port_config = en7581_mac_config,
> +	},

Let me lend a hand; you can apply this diff on top of this patch.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b18b98a53a7d..f5766d8ae360 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2768,6 +2768,28 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
  
  static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
  				     struct phylink_config *config)
+{
+	switch (port) {
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 0 ... 3:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+		break;
+
+	/* Port 6 is connected to SoC's XGMII MAC. There is no MII pinout. */
+	case 6:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10000FD;
+		break;
+	}
+}
+
+static void en7581_mac_port_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
  {
  	switch (port) {
  	/* Ports which are connected to switch PHYs. There is no MII pinout. */
@@ -2855,23 +2877,6 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
  	}
  }
  
-static void
-en7581_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
-		  phy_interface_t interface)
-{
-	/* BIT(31-27): reserved
-	 * BIT(26): TX_CRC_EN: enable(0)/disable(1) CRC insertion
-	 * BIT(25): RX_CRC_EN: enable(0)/disable(1) CRC insertion
-	 * Since the bits above have a different meaning with respect to the
-	 * one described in mt7530.h, set default values.
-	 */
-	mt7530_clear(ds->priv, MT753X_PMCR_P(port), MT7531_FORCE_MODE_MASK);
-	if (dsa_is_cpu_port(ds, port)) {
-		/* enable MT7530_FORCE_MODE on cpu port */
-		mt7530_set(ds->priv, MT753X_PMCR_P(port), MT7530_FORCE_MODE);
-	}
-}
-
  static struct phylink_pcs *
  mt753x_phylink_mac_select_pcs(struct phylink_config *config,
  			      phy_interface_t interface)
@@ -2902,8 +2907,7 @@ mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
  
  	priv = ds->priv;
  
-	if ((port == 5 || port == 6 || priv->id == ID_EN7581) &&
-	    priv->info->mac_port_config)
+	if ((port == 5 || port == 6) && priv->info->mac_port_config)
  		priv->info->mac_port_config(ds, port, mode, state->interface);
  
  	/* Are we connected to external phy */
@@ -3251,8 +3255,7 @@ const struct mt753x_info mt753x_table[] = {
  		.phy_write_c22 = mt7531_ind_c22_phy_write,
  		.phy_read_c45 = mt7531_ind_c45_phy_read,
  		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.mac_port_get_caps = mt7988_mac_port_get_caps,
-		.mac_port_config = en7581_mac_config,
+		.mac_port_get_caps = en7581_mac_port_get_caps,
  	},
  };
  EXPORT_SYMBOL_GPL(mt753x_table);

I don't know this hardware so please make sure the comments on
en7581_mac_port_get_caps() are correct. I didn't compile this so please
make sure it works.

By the way, is this supposed to be AN7581? There's EN7580 but no EN7581 on
the Airoha website.

https://www.airoha.com/products/y1cQz8EpjIKhbK61

Arınç

