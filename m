Return-Path: <netdev+bounces-267874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mysVKjTytWl87QAAu9opvQ
	(envelope-from <netdev+bounces-267874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612028F886
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4F93067427
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545238424A;
	Sat, 14 Mar 2026 23:41:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC033CEA9
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531697; cv=none; b=r2f00Za0l3A0tVndoFYkKR5/45DCTLo13uTfBacWd0/+ykDX2Pt78HI5DHB15p/05y4ENrFWUVMuXk6VS/YBtwrjijCJsFxD4qmAs+J7ysm2QourjCWzovKwTACHu+wI1JvtJUIaGvbM85SFOT2/Me77o8sbynD4Npd6VsED5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531697; c=relaxed/simple;
	bh=ln0JKYSPlLKndnaxJu9eHeXCEbf733ZdJjQ4gstrnYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2vQvF/rJE51bRAZnCU3J332M/zv2wWSTj1RpJhsQPKps3IMW5PhfUYwqve/1LndgqjXNprlUUKDFz55yFHv5XAYd8cjD+XImtC1KEg1BbTpHVNp/OUSB0WM+LkrlhWvxid5l+YfGoXzQgNLdjV890tR2XWMNOg7jnP8k+PkHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w1Ybr-000000003r4-1KkR;
	Sat, 14 Mar 2026 23:41:31 +0000
Date: Sat, 14 Mar 2026 23:41:28 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC v2 3/3] net: dsa: initial support for MT7628 embedded switch
Message-ID: <abXyKK4wxiBySHI2@makrotopia.org>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314150845.653866-4-joey@tinyisr.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267874-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 0612028F886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 05:08:45PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch.

Thank you for working on this, MT7628 (especially in "IoT" mode with 3
UARTs and MMC bus exposed instead of the additional switch ports)
still has it's special niche somewhere in between ESP32 and "proper"
Linux-running SoCs ;)

> 
> The switch has 5 built-in 100Mbps ports (ports 0-4) and 2x 1Gbps ports.
> One of the 1Gbps ports (port 6) is internally attached to the SoCs CPU
> MAC and serves as the CPU port. The other 1Gbps port (port 5) requires
> an external MAC to function.

I thought port 5 is a dead-end on MT76x8. Afaik it was only used on
Ralink Rt3052 for RGMII/xMII with this switch IP, and not wired to
any external pins nor to an internal MAC on all other SoCs which came
after.

> 
> The switch hardware has a very limited 16 entry VLAN table. Configuring
> VLANs is the only way to control switch forwarding. Currently 7 entries
> are used by tag_8021q to isolate the ports. Double tag feature is
> enabled to force the switch to append the VLAN tag even if the incoming
> packet is already tagged, this simulates VLAN-unaware functionality and
> simplifies the tagger implementation.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

> +config NET_DSA_MT7628
> +	tristate "MT7628 Embedded ethernet switch support"
> +	select NET_DSA_TAG_MT7628
> +	select MEDIATEK_FE_SOC_PHY
> +	help
> +	  This enables support for the switch in the MT7628 SoC.

And potentially many others (Rt3052, Rt3050, Rt3352, Rt5350).
As support for the Rt5350 is present in mtk_eth_soc at least that
sounds like it would be worth mentioning (or even naming the driver
and tagger interely after rt3050 which is the origin of that IP
block).

> +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	int ret;
> +	u32 val;
> +
> +	ret =
> +	    regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,

Unnecessary linebreak.

> +				     !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				     5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret =
> +	    regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,

Here as well.

> +				     (val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				     5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> +		return -ETIMEDOUT;
> +	}
> +	return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
> +}
> +
> +static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum,
> +			    u16 dat)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	ret =
> +	    regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,

Here as well.

> +				     !(val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				     5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_WT_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret =
> +	    regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,

And here as well.

> [...]
> +static void esw_set_vlan_id(struct mt7628_esw *esw, unsigned int vlan,
> +			    unsigned int vid)
> +{
> +	unsigned int s = MT7628_ESW_VLANI_VID_S * (vlan % 2);
> +
> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_VLANI(vlan / 2),
> +			   MT7628_ESW_VLANI_VID_M << s,
> +			   (vid & MT7628_ESW_VLANI_VID_M) << s);

Please add helper macros for those registers and field in them

> +}
> +
> +static void esw_set_pvid(struct mt7628_esw *esw, unsigned int port,
> +			 unsigned int pvid)
> +{
> +	unsigned int s = MT7628_ESW_PVIDC_PVID_S * (port % 2);
> +
> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_PVIDC(port / 2),
> +			   MT7628_ESW_PVIDC_PVID_M << s,
> +			   (pvid & MT7628_ESW_PVIDC_PVID_M) << s);

and those as well

> +}
> +
> +static void esw_set_vmsc(struct mt7628_esw *esw, unsigned int vlan,
> +			 unsigned int msc)
> +{
> +	unsigned int s = MT7628_ESW_VMSC_MSC_S * (vlan % 4);
> +
> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_VMSC(vlan / 4),
> +			   MT7628_ESW_VMSC_MSC_M << s,
> +			   (msc & MT7628_ESW_VMSC_MSC_M) << s);

those too

> +}
> +
> +static void esw_set_vub(struct mt7628_esw *esw, unsigned int vlan,
> +			unsigned int msc)
> +{
> +	unsigned int s = MT7628_ESW_VUB_S * (vlan % 4);
> +
> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_VUB(vlan / 4),
> +			   MT7628_ESW_VUB_M << s,
> +			   (msc & MT7628_ESW_VUB_M) << s);

and those.

> [...]
> +static void mt7628_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_100 | MAC_10;
> +	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);

This looks a bit wrong.
Aren't all 5 PHYs internal? PHY_INTERFACE_INTERNAL would be best to
describe them then. And doesn't the CPU port (6) connect with 1000M,
if so it should have MAC_1000 set as well (as neither the Ethernet
driver nor the DSA driver do anything to configure the interface that
is purely cosmetic, but still)

Iff you want to support port 5 on Rt3052 (which will also require
setting the correct interface mode in .mac_config) I'd expect something
like this:

config->mac_capabilities = MAC_100 | MAC_10;

switch (port) {
case 0...4:
	__set_bit(PHY_INTERFACE_INTERNAL, config->supported_interfaces);
	break;
case 5:
	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
	__set_bit(PHY_INTERFACE_MODE_REVMII, config->supported_interfaces);
	__set_bit(PHY_INTERFACE_MODE_RMII, config->supported_interfaces);
	__set_bit(PHY_INTERFACE_MODE_RGMII, config->supported_interfaces);
	config->mac_capabilities |= MAC_1000;
	break;
case 6:
	__set_bit(PHY_INTERFACE_INTERNAL, config->supported_interfaces);
	config->mac_capabilities |= MAC_1000;
	break;
default:
	return;
}

If you don't want to deal with port 5 you should skip it here as well.


Cheers


Daniel

