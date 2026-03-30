Return-Path: <netdev+bounces-273286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGyKJqS4ymkk/gUAu9opvQ
	(envelope-from <netdev+bounces-273286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:53:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B135F86F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01E6300D310
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9736A014;
	Mon, 30 Mar 2026 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HT/utHUc"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC52F39CE
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893146; cv=none; b=Q7EI+IFySo0p57Ls+Tx5I1S7G6F3aICihlORGjgERPhlC8BP/DyY/kodrzXdnTOHj0iscdZrDacQcv8dGRpPtsEIlkF/FJmNpmZrY/Ml+BfNPsqqSon1amKC7Z4AQOm08Jn+XGYpe/U12dJe3HNqDN0yokqDJpEUmPuamRe4uRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893146; c=relaxed/simple;
	bh=om2f9Ho3FVaDIPkVBm2gmD78z2AueWy3dtjI7TD71iw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=r0KVoTbCol4pYYKv8JNCy+M6uhzSlK8UHNJhP5UZ90NVIeRe3thtSRpnJ6BaxPi9T23LshKZxBSCk73l6HueBUCZFH377eExtVdxUqj/Y2YRxvm7EzzYYfdYLwg8p1Fovqlu0iJYvkViFzXZ24nzLN9DgIt3I/G3uN1of0Y4j+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HT/utHUc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774893142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ZohPn0tEwclWEs73U7FxbLocJmGnnoEpSpxL5nBww=;
	b=HT/utHUc8lgdICl+7AKP2eUGWqGS87jeJCjNhlM/axXVP2uTR1zAEx7oxBP2d7gF9Ptfg5
	br7hixyyJVb0342CKYZWVHZXIS5gxQFeCl6mlfA2LaO6JAsv8xnFOD6/VmXRCnWIngNnRD
	ZEz3Dt9vAyTkqK/rpdquDTmF+EevXqY=
Date: Mon, 30 Mar 2026 17:52:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 net-next 5/5] net: pcs: pcs-mtk-lynxi: deprecate
 "mediatek,pnswap"
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, "Daniel
 Golle" <daniel@makrotopia.org>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "=?utf-8?B?QmriiJriiI9ybiBNb3Jr?="
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
In-Reply-To: <20260326215404.krh6v3mmnqdlndli@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
 <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
 <20260326215404.krh6v3mmnqdlndli@skbuf>
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
	TAGGED_FROM(0.00)[bounces-273286-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,bpi-r3:email]
X-Rspamd-Queue-Id: F25B135F86F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vladimir

Thanks for the patch and sorry for my delay...i was away this weekend so =
i was not able to test.

traffic works again (but there is only read now) and this is the result o=
f your debug prints:

root@bpi-r3:~# dmesg | grep SGMSYS_QPHY_WRAP_CTRL
[    2.706963] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, intending to write 0x500
[    9.134081] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, intending to write 0x500

R3/mt7986 has 2 MAC, and switch is on the first, so value will change, no=
t sure why this is different.

i have not found SGMSYS_QPHY_WRAP_CTRL or something related with polarity=
 in ethernet/mac-=20
(drivers/net/ethernet/mediatek/mtk_eth_soc.c)=20or switch-driver (drivers=
/net/dsa/mt7530{,-mdio}.c)
in case they manipulate this register too (of course they should not). Al=
so looked into the pcs-handling
in both drivers, but see nothing related to polarity. And looked for poss=
ible duplicate register const
definition (other name for 0xec).

regards Frank

Am 26. M=C3=A4rz 2026 um 22:54 schrieb "Vladimir Oltean" <vladimir.oltean=
@nxp.com>:
>=20
>=20Hi Frank,
>=20
>=20On Tue, Mar 24, 2026 at 06:36:44AM +0000, Frank Wunderlich wrote:
>=20
>=20>=20
>=20> Hi,
> >=20=20
>=20>  looks like this patch breaks BPI-R3 serdes between mt7986 SoC and =
mt7531 switch in 7.0 (6.19 is ok).
> >  in ethtool i see only tx on mac but no rx. if i revert this patch i =
can ping through dsa-ports again.
> >=20=20
>=20>  i did not completely understanding the code with the default-pol a=
s it is now splitted between rx and tx.
> >=20=20
>=20>  mt7986 and this board does not have mediatek,pnswap set, so the fi=
nal regmap_update_bits writes val=3D0,
> >  before there was only write to this register on invert mode...but i =
guess this should not break. Maybe some
> >  kind of timing issue between mac and switch?
> >=20=20
>=20>  maybe reverting this patch skips changes made here:
> >  bde1ae2d52ab 2026-01-19 net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF no=
de to PCS
> >=20=20
>=20>  I resend as last try was sending as html (option "always send as t=
ext" in webmailer seems to be ignored
> >  somehow, had to choose "unformatted" in this response too).
> >=20=20
>=20>  regards Frank
> >=20
>=20Sorry for the delay.
>=20
>=20If writing val=3D0 breaks the link, I'm curious
> (a) whether it still breaks if we don't write anything at all
> (b) what was the register value originally
>=20
>=20Could you please test the patch below and let me know what it prints,
> and whether traffic passes with it applied?
>=20
>=20-- >8 --
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-=
lynxi.c
> index c12f8087af9b..5c5f45b93b82 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -126,7 +126,7 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_l=
ynxi *mpcs,
>  {
>  struct fwnode_handle *fwnode =3D mpcs->fwnode, *pcs_fwnode;
>  unsigned int pol, default_pol =3D PHY_POL_NORMAL;
> - unsigned int val =3D 0;
> + unsigned int val =3D 0, tmp;
>  int ret;
>=20=20
>=20 if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
> @@ -153,8 +153,14 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_=
lynxi *mpcs,
>  if (pol =3D=3D PHY_POL_INVERT)
>  val |=3D SGMII_PN_SWAP_TX;
>=20=20
>=20- return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
> - SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
> + ret =3D regmap_read(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL, &tmp);
> + if (ret)
> + return ret;
> +
> + pr_err("SGMSYS_QPHY_WRAP_CTRL =3D 0x%x, intending to write 0x%lx\n",
> + tmp, (tmp & ~(SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX)) | val);
> +
> + return 0;
>  }
>=20=20
>=20 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned in=
t neg_mode,
> -- >8 --
>=20

regards=20Frank

