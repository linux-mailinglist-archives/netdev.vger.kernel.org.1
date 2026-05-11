Return-Path: <netdev+bounces-286725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF5KNJMAAmppnAEAu9opvQ
	(envelope-from <netdev+bounces-286725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAB511EBC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0074F30884EA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F47402B85;
	Mon, 11 May 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="lXQwuqDE"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C928373BFC;
	Mon, 11 May 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514626; cv=pass; b=UGLVSkhmeJ4nwqPRxIhZRKHU0fdn4/i+pW3h/xFlaAVnW22IlWz9+p2C6WGueFdfheMZhBd9H+WufiUhiO7oSC+4X0Y/YuQgIKfbM+kQa5LbS/hlFRBvFFKYmi9Y+bsyKxNlb9Q8gjrcuZJ5Fvv/UYiP8pydJp/gLzQkFZPUgb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514626; c=relaxed/simple;
	bh=Jev2YbVCoZFjEhOMq696YfzAJwCtgWiHcamd3Bfkrzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3znQPyVN82GHsGyig4FvitM4bNYAkriPAHOeiB5rBBjbFUCAsvDlLG/jsIOPzGPGKU97R4rWJwI+7AhPNVjRkCy9e4i2HUNKhIzmhEcyZjV+YMujgFrz7Jxs+OxbshjjenTy7obRlqksufuKUIkKvoTqlNpbN1Z9k7tBBau18g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=lXQwuqDE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1778514593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JtR96WeqT7mANZWYH5Oq/SrWkMVZMHEbjdysUv/IDO4KZwoDNDvREeBHkIj51zpAmurnQdC08F2XjOERSeMmOUucOa/EQHyhYMAf2nwLR+YpK/sv1eIXWC5lYuCs1C/2k61b9w7swjzlLd+nbhC4mkys+J5UDiJl5hYA2KK45lM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778514593; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XLRqHHn0hwJYYFSTUINWa18jofeRC1qm9JrrGQiF80s=; 
	b=gqVx98psmTKrKlqyPBaggNuqabHo96QX5RdambdyF9d0G93YbduIFF1ajBv0b3svQONPy+0P31NxXL9D6iwvqyjvpfc60hW7irJKOs0UMUGqOA7pOeSheMkBy6vNYmCxF9qNSTxRzBJQVJtmc+Nv6lHLNlNoEi8su71z/YDnZ/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778514593;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=XLRqHHn0hwJYYFSTUINWa18jofeRC1qm9JrrGQiF80s=;
	b=lXQwuqDEHkE93zSFEP0C/7F7bsb2cpIzNR+y4WCSN/TJXYD78zHt1AwDilCol32u
	q9O+paBosqN1PAeJoIvEVFQwsiR/ZgvPKnIjEBYTbSjRHj+sgQmEIbN79VCs8BT75sq
	9/iVOyqpkucv2LWwu2iJCgU5UqmYIJzriORdTJ7E=
Received: by mx.zohomail.com with SMTPS id 1778514590556214.59633215458769;
	Mon, 11 May 2026 08:49:50 -0700 (PDT)
Message-ID: <7d5bcbe907456e4ada4401251eb05c3d5378dcb0.camel@collabora.com>
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
Date: Mon, 11 May 2026 17:49:44 +0200
In-Reply-To: <27ca6b71-18df-4e47-9117-0e503f7e7d5f@lunn.ch>
References: 
	<20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
	 <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
	 <2c441d51f6a865ddb6e67b63cd26a651ed3ff058.camel@collabora.com>
	 <27ca6b71-18df-4e47-9117-0e503f7e7d5f@lunn.ch>
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
X-Rspamd-Queue-Id: ECBAB511EBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286725-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Andrew,

On Thu, 2026-05-07 at 23:43 +0200, Andrew Lunn wrote:
> > > > +static int an8801r_of_init_leds(struct phy_device *phydev, u8
> > > > *led_cfg)
> > > > +{
> > > > +	struct device *dev =3D &phydev->mdio.dev;
> > > > +	struct device_node *np =3D dev->of_node;
> > > > +	struct device_node *leds;
> > > > +	u32 function_enum_idx;
> > > > +	int ret;
> > > > +
> > > > +	if (!np)
> > > > +		return 0;
> > > > +
> > > > +	/* If devicetree is present, leds configuration is
> > > > required */
> > > > +	leds =3D of_get_child_by_name(np, "leds");
> > > > +	if (!leds)
> > > > +		return 0;
> > > > +
> > > > +	for_each_available_child_of_node_scoped(leds, led) {
> > > > +		u32 led_idx;
> > > > +
> > > > +		ret =3D of_property_read_u32(led, "reg",
> > > > &led_idx);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		if (led_idx >=3D AN8801R_NUM_LEDS) {
> > > > +			ret =3D -EINVAL;
> > > > +			goto out;
> > > > +		}
> > > > +
> > > > +		ret =3D of_property_read_u32(led, "function-
> > > > enumerator",
> > > > +					=C2=A0=C2=A0
> > > > &function_enum_idx);
> > > > +		if (ret)
> > > > +			function_enum_idx =3D
> > > > AN8801R_LED_FN_NONE;
> > > > +
> > >=20
> > > What is this doing? Is this documented in the binding?
> > The `function-enumerator` property is only documented in the led
> > common
> > dt-binding file. The an8801 dt-bindings inherits this property from
> > the
> > ethernet-phy dt-bindings.
> >=20
> > We aimed to have this PHY have its led behaviour (how many to
> > enable
> > and what their role shall be) configurable using devicetree and not
> > to
> > rely on a default configuration, hard-coded in the driver (like the
> > air_en8811h driver did) and also make use of the led hardware
> > offloading (for functions like 100/1000, activity blinking, and
> > others)
> > that this PHY is capable of.
>=20
> What other drivers do is leave the configuration with its reset
> default. They are often sensible. When the netdev trigger loads, it
> should ask the LED how it is configured, and the values in sysfs will
> reflect it. After that you can change it, via udev rules, etc.
When you say "reset default", do you mean the default PHY register
values, the ones that may have been set by the bootloader or by the
driver with a default hardcoded functional config?
>=20
> You have to be careful about what you put in DT. DT describes
> hardware, not configuration or policy. How the LED blinks is probably
> configuration, so it does not belong in DT.
I agree.
What I meant as configuration was only the leds node presence and the
led function properties, as the devicetree should describe what/how
many LED are connected to the PHY and they represent (or mean) for a
given board.
Parameters like off/on delay or trigger events are indeed not really
appropriate for devicetree and the AN8801 dt-bindings patch do not add
any such property.

And even, if technically the LEDs are reconfigurable with netdev or any
other LED trigger, the configuration is somehow hardware bound, because
the different colors of LEDs do kind-of bind a specific function to a
specific LED (amber vs green).

This is why the an8801r_of_init_leds function read those LED-related
properties (leds/led/function-enumerator) to set a default led config
behaviour (that can of course be overridden by an user with a led
trigger) rather than relying on bootloader or use a hardcoded led
register config in the driver.

What implementation would be preferred for this driver?

>=20
> > > > +static int an8801r_read_status(struct phy_device *phydev)
> > > > +{
> > > > +	int prev_speed, ret;
> > > > +	u32 val;
> > > > +
> > > > +	prev_speed =3D phydev->speed;
> > > > +
> > > > +	ret =3D genphy_read_status(phydev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (phydev->link && prev_speed !=3D phydev->speed) {
> > > > +		val =3D phydev->speed =3D=3D SPEED_1000 ?
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AN8801_BPBUS_LINK_MODE_1000 : 0;
> > > > +
> > > > +		return an8801_buckpbus_reg_rmw(phydev,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > AN8801_BPBUS_REG_LINK_MODE,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > AN8801_BPBUS_LINK_MODE_1000,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val);
> > > > +	};
> > >=20
> > > This is unusual. What is it doing? Please add a comment.
> > This call is to ensure that the PHY switches to the expected 1Gbps=20
> > speed when available.=C2=A0
>=20
> So this is an errata workaround? Please add this in a patch of its
> own, described the problem in the commit message, list the errata
> etc.
>=20
OK, I'll add this in a separate patch in v3.

Best regards,
Louis-Alexis

> =C2=A0=C2=A0=C2=A0=C2=A0 Andrew

