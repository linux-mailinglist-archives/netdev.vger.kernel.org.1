Return-Path: <netdev+bounces-274377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO1gCCgEzml+kQYAu9opvQ
	(envelope-from <netdev+bounces-274377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D13842F7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE5DB304135A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 05:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBE352C51;
	Thu,  2 Apr 2026 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0/pktxt"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE712FE582
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109053; cv=none; b=BM4eZpf7oBBOeQkNpn6wRczMmp4GDOJQ3T8g6V/4nblo6b8g9oLzrBA6OJG5MKizsCWxN6eXspRQz3YXjIbIonxneyf/Mp0uxoCaWsTL98cvetg/PDz6SIsC8TALTwu3geK1aPY+Gozi4WLI/dASJfgoXthhamW1iIdtXDeHmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109053; c=relaxed/simple;
	bh=HBQBkDwJxeVCMUVrUn68E5qKSQ0UstcHwEs1oNJboiM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SsRJjYwjSWufM7DZUoKu/mmox0yp9XHjVmDJrrLPcrxyGpZVdYoEZ9qd0QVZgGfC18ZGNywVMvFe8J+VFpuo0YJRnJJfLTMrhmi+j/UkloZ+ZUmdkbU9aT1yBZS/LtJKJmX6+CayJbaUeb5yfonh8pAikVXB/i/8VRtlOYGxTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0/pktxt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775109039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2IxQXDTDghIiyuotp3O84vD+rLQkEIhubPuL16ueno=;
	b=K0/pktxteFCz4rfz1V6ek6NdCs1QO9Re6Gv5UDhf8sz8XK+V59QPpgEvkm74cswxBJHXHs
	pv8fd/vJIIqkQ8XUFPwhNHmbffCFCKQtkgsH4C/1PMElEP0dI/5xtJVWTEzMH3LCgYiBhd
	/kgc/b5ujgIDPiSnz6qRw+AE59z5xpE=
Date: Thu, 02 Apr 2026 05:50:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <4dbc3dabfdbc3bdf6b8d411e62a27fa8988e3388@linux.dev>
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
In-Reply-To: <20260330190443.bol5vjfqqitz7kuo@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
 <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
 <20260326215404.krh6v3mmnqdlndli@skbuf>
 <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev>
 <20260330190443.bol5vjfqqitz7kuo@skbuf>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274377-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,linux.dev:dkim,linux.dev:mid,0.0.0.0:email,0.230.104.96:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.1:email]
X-Rspamd-Queue-Id: 278D13842F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

i tried using these properties in sgmiisys0 node (which should be mapped =
to mac0 and the mt7530 switch) without success [1].

it looks like these properties are not read somewhere.

the flow is

mtk_probe (eth driver)

if (MTK_HAS_CAPS(eth->soc->caps, MTK_SGMII)) {
	err =3D mtk_sgmii_init(eth);

and there calling mtk_pcs_lynxi_create with the sgmiisys-node (for each m=
ac, so imho mac0=3Dsgmiisys0)
but handling the sgmiisys only as syscon, not a "real" pcs node [2].

but your new code calls phy_get_tx_polarity and should read out this prop=
erties, but from subnode "pcs", so next try was

&sgmiisys0 {
	pcs {
		rx-polarity =3D <PHY_POL_NORMAL>;
		tx-polarity =3D <PHY_POL_INVERT>;
	};
};

which results in completely strange behaviour (looks like sgmiisys1 is ma=
pped to mac0, but based on code in mtk_sgmii_init 0=3D0 should be right):

[    2.765218] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, will write 0x500
[    9.143849] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, will write 0x501

but nevertheless i tried changing sgmiisys0 to sgmiisys1 and got the dame=
 result as before

[    2.713644] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, will write 0x500
[    9.061509] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, will write 0x500

i can only change the second serdes with sgmiisys0, but not the first.

mapping between mac and sgmiisys in dts in mt7986a.dtsi [3] are like this=
:

eth: ethernet@15100000 {
	compatible =3D "mediatek,mt7986-eth";
	mediatek,sgmiisys =3D <&sgmiisys0>, <&sgmiisys1>;
	...
};

&eth {
	status =3D "okay";

	gmac0: mac@0 {
		compatible =3D "mediatek,eth-mac";
	...
	};

	gmac1: mac@1 {
		compatible =3D "mediatek,eth-mac";
	...
	};
};

maybe it is time to revive the PCS framework discussion ([4]-[6])?

[1] https://github.com/frank-w/BPI-Router-Linux/commit/4846a7bb352fe59111=
36cba33813f099bac035fd
[2] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/net/ethernet=
/mediatek/mtk_eth_soc.c#L5001
[3] https://elixir.bootlin.com/linux/v7.0-rc4/source/arch/arm64/boot/dts/=
mediatek/mt7986a.dtsi#L528

[4] * https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134=
.3588011-4-sean.anderson@linux.dev/ (v6)
> pcs-framework itself had not yet got a response from netdev maintainer =
(only other parts)
[5] * https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250=
.3789083-4-ansuelsmth@gmail.com/ (v4)
> discussion: https://lore.kernel.org/netdev/20250511201250.3789083-1-ans=
uelsmth@gmail.com/
[6] * https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3=
bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
> discussion: https://patchwork.kernel.org/project/netdevbpf/patch/8aa905=
080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/

Am 30. M=C3=A4rz 2026 um 21:04 schrieb "Vladimir Oltean" <vladimir.oltean=
@nxp.com mailto:vladimir.oltean@nxp.com?to=3D%22Vladimir%20Oltean%22%20%3=
Cvladimir.oltean%40nxp.com%3E >:
>=20
>=20Hi Frank,
>=20
>=20On Mon, Mar 30, 2026 at 05:52:17PM +0000, Frank Wunderlich wrote:
>=20
>=20>=20
>=20> Hi Vladimir
> >=20=20
>=20>  Thanks for the patch and sorry for my delay...i was away this week=
end so i was not able to test.
> >=20=20
>=20>  traffic works again (but there is only read now) and this is the r=
esult of your debug prints:
> >=20=20
>=20>  root@bpi-r3:~# mailto:root@bpi-r3:~#  dmesg | grep SGMSYS_QPHY_WRA=
P_CTRL
> >  [ 2.706963] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, intending to write 0x50=
0
> >  [ 9.134081] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, intending to write 0x50=
0
> >=20=20
>=20>  R3/mt7986 has 2 MAC, and switch is on the first, so value will cha=
nge, not sure why this is different.
> >=20=20
>=20>  i have not found SGMSYS_QPHY_WRAP_CTRL or something related with p=
olarity in ethernet/mac-
> >  (drivers/net/ethernet/mediatek/mtk_eth_soc.c) or switch-driver (driv=
ers/net/dsa/mt7530{,-mdio}.c)
> >  in case they manipulate this register too (of course they should not=
). Also looked into the pcs-handling
> >  in both drivers, but see nothing related to polarity. And looked for=
 possible duplicate register const
> >  definition (other name for 0xec).
> >=20
>=20This result means that your default QPHY_WRAP_CTRL register value has
> the SGMII_PN_SWAP_TX bit set. Whether that comes from U-Boot or hardwar=
e
> default or otherwise, it doesn't really matter. Curious that the
> SGMII_SW_RESET doesn't clear TX inversion, though. I guess you wouldn't
> have documentation that would suggest this setting is sticky?
>=20
>=20In Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml,
> it is not specified what happens when the "mediatek,pnswap" property is
> missing. I thought the most logical thing would be for the lane
> polarities to not be swapped - because how would you describe normal
> lane polarities otherwise? My bad for thinking the original vendor
> bindings were more sane than they were.
>=20
>=20The only way to describe the polarities that this SGMSYS block needs =
on
> a particular board is to use the newly introduced 'rx-polarity =3D
> <PHY_POL_NORMAL>' and 'tx-polarity =3D <PHY_POL_INVERT>'. Which I stron=
gly
> recommend you to do, even if the attached patch should restore
> functionality with your current device tree.
>=20

regards=20Frank

