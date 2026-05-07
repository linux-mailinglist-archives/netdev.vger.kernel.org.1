Return-Path: <netdev+bounces-285367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOCHL+uo/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3304C4EAB5E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7088E30C09DB
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C33B2FC9;
	Thu,  7 May 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="fOdineQx"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EE31715F;
	Thu,  7 May 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165582; cv=pass; b=qN3sZJP8djz+1mPzGDfjJFZwbnoDde/eBJ8W1OeT2OG3d7lbJJ9NLn7K4qF64f3AAL6xDPfMiTNiF7fnhFU8OennslbyFX3nrRPL1AA+E6F8rtPdhdQVXCVSxdaseBK8n/uhmBVQu7OktKRo1qx6hio9EQY0E4lxJtvvScc/lyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165582; c=relaxed/simple;
	bh=j5a4eQdwTuHiYaO1bzwW5AlyiL1sg8LGVa9SISVvtmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKWd75P8P+kFmZBYQLo6KBK0uSnUT9/GFJhzhFMDBEcdDjOia9ErANJbIFsWqswMzhz/Ow0zdSiEwXDiqBsglBE1fVIAwVILR4abR/nByh/8N2pFsXbQ6hBMOY9uD6RUSWyaj43n9HlJhoe5mzNWWYthJF+lfzLWrXd1IdEkaRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=fOdineQx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1778165549; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gnoQamEnOtplYB0I+IAslgQbn8pbGYB69jQehTFsGfodQdyEq9N8s+8IaNQKwXL/NDNsawSM/Z24cn1OYsoIL42X1HyPLDQRnaqTCp8EbXe1KuvMvk5LtH+mEi7GRXP3W5KPsCWtActawG/STVReMfEy/yqHt7lFbvRLBwzGCUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778165549; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mD80HyVHazAI7zY5u5ppiXiv/kRQLmFGurqGNhp1Zzg=; 
	b=AhxTDMRqMIdHYGdQlIxOWo/w5Yz5yPQybWfRB7KQ1G+XgIQR5AJA3uWTDk39YfBwadzwFfM+oo75B9ALzq5a14hn5rLGvoIvrTx3fI+FWIlw96uB17G4kVkwssUehgccD4OFIVq/EeR8ESEfE98d1Z0/BybHWz4mqdIF6H4BYTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778165549;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=mD80HyVHazAI7zY5u5ppiXiv/kRQLmFGurqGNhp1Zzg=;
	b=fOdineQxBdsWNaByWoVgw199d+7PDlanFfm3mIwEsyWRlUH/RmGfoI/q97LzGnFF
	Pmgf2QzTPK0zhkSxGjMMGx7TbjLzXoS0N7L2tSBhWBqurBEKHhmumI2uDwqlYmkXsm6
	ki/LIERCJEAVU8uJ1GOsXQbZSpcwpdfMack/cvjY=
Received: by mx.zohomail.com with SMTPS id 1778165548105701.1379238259724;
	Thu, 7 May 2026 07:52:28 -0700 (PDT)
Message-ID: <2c441d51f6a865ddb6e67b63cd26a651ed3ff058.camel@collabora.com>
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Heiner Kallweit	
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, 	kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 16:52:22 +0200
In-Reply-To: <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
References: 
	<20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
	 <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 3304C4EAB5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Andrew,

On Thu, 2026-03-26 at 13:47 +0100, Andrew Lunn wrote:
> > +static int an8801r_led_blink_set(struct phy_device *phydev, u8
> > index,
> > +				 unsigned long *delay_on,
> > +				 unsigned long *delay_off)
> > +{
>=20
> ...
>=20
> > +	ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > LED_ON_CTRL(index),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 LED_ON_EN, blink ? LED_ON_EN : 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
>=20
> Just
>=20
>=20
> 	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> LED_ON_CTRL(index),
> 			=C2=A0=C2=A0=C2=A0=C2=A0 LED_ON_EN, blink ? LED_ON_EN : 0);
>=20
> > +		if (!led_trigger)
> > +			continue;
> > +
> > +		ret =3D an8801r_led_hw_control_set(phydev, led_id,
> > led_trigger);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	return 0;
> > +}
>=20
>=20
> Please take a look at all your functions. Can the last error check be
> removed and just use return ret, etc.
I'll fix this in the next version.

>=20
> > +static int an8801r_of_init_leds(struct phy_device *phydev, u8
> > *led_cfg)
> > +{
> > +	struct device *dev =3D &phydev->mdio.dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct device_node *leds;
> > +	u32 function_enum_idx;
> > +	int ret;
> > +
> > +	if (!np)
> > +		return 0;
> > +
> > +	/* If devicetree is present, leds configuration is
> > required */
> > +	leds =3D of_get_child_by_name(np, "leds");
> > +	if (!leds)
> > +		return 0;
> > +
> > +	for_each_available_child_of_node_scoped(leds, led) {
> > +		u32 led_idx;
> > +
> > +		ret =3D of_property_read_u32(led, "reg", &led_idx);
> > +		if (ret)
> > +			goto out;
> > +
> > +		if (led_idx >=3D AN8801R_NUM_LEDS) {
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		ret =3D of_property_read_u32(led, "function-
> > enumerator",
> > +					=C2=A0=C2=A0 &function_enum_idx);
> > +		if (ret)
> > +			function_enum_idx =3D AN8801R_LED_FN_NONE;
> > +
>=20
> What is this doing? Is this documented in the binding?
The `function-enumerator` property is only documented in the led common
dt-binding file. The an8801 dt-bindings inherits this property from the
ethernet-phy dt-bindings.

We aimed to have this PHY have its led behaviour (how many to enable
and what their role shall be) configurable using devicetree and not to
rely on a default configuration, hard-coded in the driver (like the
air_en8811h driver did) and also make use of the led hardware
offloading (for functions like 100/1000, activity blinking, and others)
that this PHY is capable of.

From the available property list for the led node, this one seems to be
appropriate to distinguish between the possible LAN functions, that=20
would mean that a specific LED has either a link or RX/Tx activity=20
role.=C2=A0That is why we used it but we could be wrong.

The an8801 dt-bindings (in patch 1) misses the possible values and
should improved in that regard and I'll fix them in next version if
this implementation seems acceptable to you.
>=20
> > +		if (function_enum_idx >=3D AN8801R_LED_FN_MAX) {
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		led_cfg[led_idx] =3D function_enum_idx;
> > +	}
> > +out:
> > +	of_node_put(leds);
> > +	return ret;
> > +}
>=20
> > +static int an8801r_read_status(struct phy_device *phydev)
> > +{
> > +	int prev_speed, ret;
> > +	u32 val;
> > +
> > +	prev_speed =3D phydev->speed;
> > +
> > +	ret =3D genphy_read_status(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (phydev->link && prev_speed !=3D phydev->speed) {
> > +		val =3D phydev->speed =3D=3D SPEED_1000 ?
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AN8801_BPBUS_LINK_MODE_1000 : 0;
> > +
> > +		return an8801_buckpbus_reg_rmw(phydev,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > AN8801_BPBUS_REG_LINK_MODE,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > AN8801_BPBUS_LINK_MODE_1000,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val);
> > +	};
>=20
> This is unusual. What is it doing? Please add a comment.
This call is to ensure that the PHY switches to the expected 1Gbps=20
speed when available.=C2=A0
I'll confirm it and add a comment in v3.

Best regards,
Louis-Alexis
>=20
> 	Andrew

