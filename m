Return-Path: <netdev+bounces-289942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH3GBDmvDWrW1QUAu9opvQ
	(envelope-from <netdev+bounces-289942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:55:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A258E4CE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 815B830F35BD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100913DCD9A;
	Wed, 20 May 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="jHWswEbl"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDC39BFFA;
	Wed, 20 May 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281235; cv=pass; b=bdJYHOH0CWCoy3SAyjNOlfHFHu9UBzFYHan6sxj/zHeXAtXqLreuBEMy0CYgXV8JlZ3ST0ywzLb/2QQoZUYvTZX7mrw4Eynn7Bs+vtAdy8Hc0W2y3quwBehpVd1lqZLsNnlh4GFFe59Gi0xfxD0cfT22Yh8ysPCQfoT+sXBcEbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281235; c=relaxed/simple;
	bh=dTXcnPiwDtqWk2v4IuUn3hfvsZ/QJSIh+tZ0dccqi6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7fF3ezaOSsBDaCKCNYIWqhOP8a16mqaHq1ABRC+l9aeQkQVJVA6nEMjklg7qarBhpecjh4PfteG5dmQROomBHwsJGIazh9MR680s8+CLTa2WWEtq6Mzgt0R67V43mmUu9t3SBEveCLDJTn7+9D0hy3to/7rGqiKM0dGnGg1CWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=jHWswEbl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1779281190; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mo1rJIqCjsETSxeBlA/L09pa826Mm+LiDvydim+2eo2AYNHhOluWEbNed8kaEfd97DMvCEdkl4PZznAoVkEIYssHGSkEW2p63Ihq2lB7QLtGr+VwznZNwhvdSrYOS95uSkVBaoFihQujArEUKAVI3dHjTxYrhbt/Jg13Kq/ntBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779281190; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L6RTBcDwCUAggrkL6cocI+jcG+EHQ7is9sXnrTTyELw=; 
	b=aGduDpgjxZOUrVuepzUN475CJOp0FxUmYSlpVfaKvE77g6l6aPj2sYxvUlV3dcVtyExK0vio8C5SAbNvwGEdkUsIanPddG0+yreOB5/+5UeBzJsXj4tyUI5zL/JU4Hyh4CWKZvZhxHJNjK0cijAlo7xDeUIzGnt5WDCH52rY6+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779281190;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=L6RTBcDwCUAggrkL6cocI+jcG+EHQ7is9sXnrTTyELw=;
	b=jHWswEblvW1vK8XuhlZdi620omvMnhmjmsspqomaIrUxF6boKfMqcgaAawSVlJpk
	/OAJH3cZ8+sxHYSO6fHHRAOt5VDvAZPGJuQYUTDV+4srCmRMXTX9N/f8J2aozt6iJyC
	uIlWdFzbYc1wM3FSeLSZoRNviH8pHKE/ViT7MpFQ=
Received: by mx.zohomail.com with SMTPS id 1779281188633314.64127682579726;
	Wed, 20 May 2026 05:46:28 -0700 (PDT)
Message-ID: <d61f709524326a4f9943188fcabb5746a1b11e3d.camel@collabora.com>
Subject: Re: [PATCH net-next v3 5/6] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit	 <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, 	kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 20 May 2026 14:46:22 +0200
In-Reply-To: <e77b4028-c201-4dd4-9214-721bdf67e976@bootlin.com>
References: 
	<20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
	 <20260512-add-airoha-an8801-support-v3-5-1edb34e363ae@collabora.com>
	 <e77b4028-c201-4dd4-9214-721bdf67e976@bootlin.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289942-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C1A258E4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maxime,

On Tue, 2026-05-12 at 12:06 +0200, Maxime Chevallier wrote:
> Hi :)
>=20
> This looks good, I just have very minimal comments
>=20
> On 5/12/26 06:33, Louis-Alexis Eyraud wrote:
> > From: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> >=20
> > Introduce a driver for the Airoha AN8801R Series Gigabit Ethernet
> > PHY; this currently supports setting up PHY LEDs, 10/100M, 1000M
> > speeds, and Wake on LAN and PHY interrupts.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
>=20
> [...]
>=20
> > +static u32 an8801r_led_blink_ms_to_hw(unsigned long req_ms)
> > +{
> > +	u32 req_ns, regval;
> > +
> > +	if (req_ms > AN8801_MAX_PERIOD_MS)
> > +		req_ms =3D AN8801_MAX_PERIOD_MS;
> > +
> > +	req_ns =3D req_ms * 1000000;
>=20
> Use NSEC_PER_MSEC :)
I'll fix this in the next version.

>=20
> > +
> > +	/* Round to the nearest period unit... */
> > +	regval =3D req_ns + (AN8801_PERIOD_UNIT / 2);
> > +
> > +	/* ...and now divide by the full period */
> > +	regval >>=3D AN8801_PERIOD_SHIFT;
> > +
> > +	return regval;
> > +}
> > +
>=20
> [...]
>=20
> > +static int an8801r_led_hw_control_set(struct phy_device *phydev,
> > u8 index,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long rules)
> > +{
> > +	u16 on =3D 0, blink =3D 0;
> > +	int ret;
> > +
> > +	if (index >=3D AN8801R_NUM_LEDS)
> > +		return -EINVAL;
> > +
> > +	ret =3D an8801r_led_trig_to_hw(rules, &on, &blink);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > LED_ON_CTRL(index),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 LED_ON_EVT_MASK, on);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > LED_BLINK_CTRL(index),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 LED_BLINK_EVT_MASK, blink);
> > +
> > +	if (ret)
> > +		return ret;
>=20
> Extra newline before the if()
I'll fix this in the next version too.

>=20
> > +
> > +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > LED_ON_CTRL(index),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LED_ON_EN, on | blink ? LED_ON_EN :
> > 0);
> > +}
> > +
>=20
> [...]
>=20
> > +static int an8801r_rgmii_rxdelay(struct phy_device *phydev, bool
> > enable,
> > +				 u16 delay_steps)
> > +{
> > +	u32 reg_val;
> > +
> > +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> > +		return -EINVAL;
> > +
> > +	if (enable) {
> > +		reg_val =3D delay_steps & RGMII_DELAY_STEP_MASK;
> > +
> > +		 /* Set align bit to add extra offset for RX delay
> > */
> > +		reg_val |=3D RGMII_RXDELAY_ALIGN;
> > +
> > +		 /* Set force mode bit to enable RX delay
> > insertion */
> > +		reg_val |=3D RGMII_RXDELAY_FORCE_MODE;
> > +	} else {
> > +		reg_val =3D 0;
> > +	}
> > +
> > +	return an8801_buckpbus_reg_write(phydev,
> > AN8801_BPBUS_REG_RXDLY_STEP,
> > +					 reg_val);
> > +}
> > +
> > +static int an8801r_rgmii_txdelay(struct phy_device *phydev, bool
> > enable,
> > +				 u16 delay_steps)
> > +{
> > +	u32 reg_val;
> > +
> > +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> > +		return -EINVAL;
> > +
> > +	if (enable) {
> > +		reg_val =3D delay_steps & RGMII_DELAY_STEP_MASK;
>=20
> Is this bitwise and needed, as you have the check above ?
Indeed, it is not needed, so I'll remove this masking operation here
and in an8801r_rgmii_rxdelay too.

>=20
> > +
> > +		 /* Set force mode bit to enable TX delay
> > insertion */
> > +		reg_val |=3D RGMII_TXDELAY_FORCE_MODE;
> > +	} else {
> > +		reg_val =3D 0;
> > +	}
> > +
> > +	return an8801_buckpbus_reg_write(phydev,
> > AN8801_BPBUS_REG_TXDLY_STEP,
> > +					 reg_val);
> > +}
> > +
> > +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> > +{
> > +	bool enable_delay;
> > +	u16 delay_step;
> > +	int ret;
> > +
> > +	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
> > +	=C2=A0=C2=A0=C2=A0 phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_=
TXID) {
> > +		enable_delay =3D true;
> > +		delay_step =3D AN8801_RGMII_TXDELAY_DEFAULT;
> > +	} else {
> > +		enable_delay =3D false;
> > +		delay_step =3D RGMII_DELAY_NO_STEP;
> > +	}
> > +
> > +	ret =3D an8801r_rgmii_txdelay(phydev, enable_delay,
> > delay_step);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
> > +	=C2=A0=C2=A0=C2=A0 phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_=
RXID) {
> > +		enable_delay =3D true;
> > +		delay_step =3D AN8801_RGMII_RXDELAY_DEFAULT;
>=20
> Is it correct that AN8801_RGMII_RXDELAY_DEFAULT expands to=20
> RGMII_DELAY_NO_STEP ? feels strange, but it may simply be how the HW
> is=20
> made :)
As I replied in an earlier comment ([1]), for the inserted RX delay,
when the RGMII_RXDELAY_ALIGN bit is set, the "no step" value is then
the closest setting to the 2ns value.

I'll improve the AN8801_RGMII_RXDELAY_DEFAULT comment to say that it
corresponds to the 1.992ns delay value when the align bit is set and -
0.008ns otherwise.

[1]:https://lore.kernel.org/linux-mediatek/199e674cfdbccad104db761964611b1d=
6352f9f3.camel@collabora.com/

Best regards,
Louis-Alexis
>=20
> Thanks,
>=20
> Maxime

