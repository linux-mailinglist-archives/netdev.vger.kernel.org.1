Return-Path: <netdev+bounces-270893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO2kK240wmmUaAQAu9opvQ
	(envelope-from <netdev+bounces-270893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:51:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F53037BE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E8331243DB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2043BF68D;
	Tue, 24 Mar 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mi/pWe7r"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844B3BED28
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334223; cv=none; b=juE/Oz/UYw/jcKe/yqjujau7t8ij57xk3j/iABwVyKYbi7TV6g5VAm7TjsyYtBtx4ad/jGwzB1rQuCGHWqVrkpFQWWuRjtv2+fZBmBw4KBOxZhSLV0N8P6v/S+DvzDGTn9LpY3YKva/12QZtx834RTsnatRKBy+4aFRdVLMKXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334223; c=relaxed/simple;
	bh=W8wdtUaweC4uy4bqFRHPty8+AHaXujJf4nvn1qtTk0s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=USooh1/a8DudtfeXwZNk1gFgF+GuBXrKyyy+QdPMHYmIjWAktEpnyjfnANwsU9dkMXO8iKyocv+thkPTdGbQw8ZkSU0gue5ReV/lCUuEevr4n1+b+fLCWeb9W0jFYR6qxc+kS4+B9F2GccESbeZVR8sTJCqx+uLk5Q7wswY4RIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mi/pWe7r; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774334209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eikiYueo5xkJjyhkjm2EvOyg6k6D9e96SdESD93i13U=;
	b=Mi/pWe7rSDhs+xCXOsJqaBmGSq30+Zu+uWM71H4I7yR7SO3HqwryfXshur/vq9Sb0f/jDM
	8TwCh1c/6tEa/y+Pgx0FF0M9lUZAZuFLorcbf+7aUkULmIjIowUn424wK3DFhHFnyNu38N
	NXWQh7akaNbpA1ZY7DWdpY81bc3qhp8=
Date: Tue, 24 Mar 2026 06:36:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 net-next 5/5] net: pcs: pcs-mtk-lynxi: deprecate
 "mediatek,pnswap"
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, "Daniel
 Golle" <daniel@makrotopia.org>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "=?utf-8?B?QmrDuHJuIE1vcms=?="
 <bjorn@mork.no>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Eric Woudstra"
 <ericwouds@gmail.com>, "Alexander Couzens" <lynxis@fe80.eu>, "Chester A.
 Unal" <chester.a.unal@arinc9.com>, "DENG Qingfang" <dqfext@gmail.com>,
 "Sean Wang" <sean.wang@mediatek.com>, "Felix Fietkau" <nbd@nbd.name>
In-Reply-To: <20260119091220.1493761-6-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270893-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank.wunderlich@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,nxp.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 0F1F53037BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

looks like this patch breaks BPI-R3 serdes between mt7986 SoC and mt7531 =
switch in 7.0 (6.19 is ok).
in ethtool i see only tx on mac but no rx. if i revert this patch i can p=
ing through dsa-ports again.

i did not completely understanding the code with the default-pol as it is=
 now splitted between rx and tx.

mt7986 and this board does not have mediatek,pnswap set, so the final  re=
gmap_update_bits writes val=3D0,
before there was only write to this register on invert mode...but i guess=
 this should not break. Maybe some
kind of timing issue between mac and switch?

maybe reverting this patch skips changes made here:
bde1ae2d52ab 2026-01-19 net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to=
 PCS

I resend as last try was sending as html (option "always send as text" in=
 webmailer seems to be ignored
somehow, had to choose "unformatted" in this response too).

regards Frank

Am 19. Januar 2026 um 10:12 schrieb "Vladimir Oltean" <vladimir.oltean@nx=
p.com mailto:vladimir.oltean@nxp.com?to=3D%22Vladimir%20Oltean%22%20%3Cvl=
adimir.oltean%40nxp.com%3E >:
>=20
>=20Prefer the new "rx-polarity" and "tx-polarity" properties, which in t=
his
> case have the advantage that polarity inversion can be specified per
> direction (and per protocol, although this isn't useful here).
>=20
>=20We use the vendor specific ones as fallback if the standard descripti=
on
> doesn't exist.
>=20
>=20Daniel, referring to the Mediatek SDK, clarifies that the combined
> SGMII_PN_SWAP_TX_RX register field should be split like this: bit 0 is
> TX and bit 1 is RX:
> https://lore.kernel.org/linux-phy/aSW--slbJWpXK0nv@makrotopia.org/
>=20
>=20Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v3->v4: none
> v2->v3: s/GENERIC_PHY_COMMON_PROPS/PHY_COMMON_PROPS/
> v1->v2: patch is new
>=20
>=20 drivers/net/pcs/Kconfig | 1 +
>  drivers/net/pcs/pcs-mtk-lynxi.c | 50 +++++++++++++++++++++++++++++----
>  2 files changed, 45 insertions(+), 6 deletions(-)
>=20
>=20diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index ecbc3530e780..e417fd66f660 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -20,6 +20,7 @@ config PCS_LYNX
>=20=20
>=20 config PCS_MTK_LYNXI
>  tristate
> + select PHY_COMMON_PROPS
>  select REGMAP
>  help
>  This module provides helpers to phylink for managing the LynxI PCS
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-=
lynxi.c
> index 7f719da5812e..74dbce205f71 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -11,6 +11,7 @@
>  #include <linux/mdio.h>
>  #include <linux/of.h>
>  #include <linux/pcs/pcs-mtk-lynxi.h>
> +#include <linux/phy/phy-common-props.h>
>  #include <linux/phylink.h>
>  #include <linux/regmap.h>
>=20=20
>=20@@ -62,8 +63,9 @@
>=20=20
>=20 /* Register to QPHY wrapper control */
>  #define SGMSYS_QPHY_WRAP_CTRL 0xec
> -#define SGMII_PN_SWAP_MASK GENMASK(1, 0)
> -#define SGMII_PN_SWAP_TX_RX (BIT(0) | BIT(1))
> +#define SGMII_PN_SWAP_RX BIT(1)
> +#define SGMII_PN_SWAP_TX BIT(0)
> +
>=20=20
>=20 /* struct mtk_pcs_lynxi - This structure holds each sgmii regmap and=
associated
>  * data
> @@ -121,6 +123,42 @@ static void mtk_pcs_lynxi_get_state(struct phylink=
_pcs *pcs,
>  FIELD_GET(SGMII_LPA, adv));
>  }
>=20=20
>=20+static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
> + phy_interface_t interface)
> +{
> + struct fwnode_handle *fwnode =3D mpcs->fwnode, *pcs_fwnode;
> + unsigned int pol, default_pol =3D PHY_POL_NORMAL;
> + unsigned int val =3D 0;
> + int ret;
> +
> + if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
> + default_pol =3D PHY_POL_INVERT;
> +
> + pcs_fwnode =3D fwnode_get_named_child_node(fwnode, "pcs");
> +
> + ret =3D phy_get_rx_polarity(pcs_fwnode, phy_modes(interface),
> + BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
> + default_pol, &pol);
> + if (ret) {
> + fwnode_handle_put(pcs_fwnode);
> + return ret;
> + }
> + if (pol =3D=3D PHY_POL_INVERT)
> + val |=3D SGMII_PN_SWAP_RX;
> +
> + ret =3D phy_get_tx_polarity(pcs_fwnode, phy_modes(interface),
> + BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
> + default_pol, &pol);
> + fwnode_handle_put(pcs_fwnode);
> + if (ret)
> + return ret;
> + if (pol =3D=3D PHY_POL_INVERT)
> + val |=3D SGMII_PN_SWAP_TX;
> +
> + return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
> + SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
> +}
> +
>  static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int =
neg_mode,
>  phy_interface_t interface,
>  const unsigned long *advertising,
> @@ -130,6 +168,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs =
*pcs, unsigned int neg_mode,
>  bool mode_changed =3D false, changed;
>  unsigned int rgc3, sgm_mode, bmcr;
>  int advertise, link_timer;
> + int ret;
>=20=20
>=20 advertise =3D phylink_mii_c22_pcs_encode_advertisement(interface,
>  advertising);
> @@ -169,10 +208,9 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs=
 *pcs, unsigned int neg_mode,
>  regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
>  SGMII_SW_RESET);
>=20=20
>=20- if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
> - regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
> - SGMII_PN_SWAP_MASK,
> - SGMII_PN_SWAP_TX_RX);
> + ret =3D mtk_pcs_config_polarity(mpcs, interface);
> + if (ret)
> + return ret;
>=20=20
>=20 if (interface =3D=3D PHY_INTERFACE_MODE_2500BASEX)
>  rgc3 =3D SGMII_PHY_SPEED_3_125G;
> --=20
>=202.34.1
>=20

regards=20Frank

