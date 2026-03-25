Return-Path: <netdev+bounces-271601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFqUFYj4w2nPvAQAu9opvQ
	(envelope-from <netdev+bounces-271601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB93275AF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A24E325AC86
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD293F2102;
	Wed, 25 Mar 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="Vi4bPuUN"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C682225403;
	Wed, 25 Mar 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449894; cv=pass; b=ce0LRPO6wA0HL05nWFbqS+87DC6fw+QGLSdNxohbeDimM69kPEBnX8Qf4LCve7YvEgflEK5URu8ee4yfxYttVAmMDgQE94ZC/W1wzF1Lzaf7fRcKlv/mEhvd/+1iK+hHS0t/a2Gtxq731Hy9yE+9JV7uvnpCI4z06G+pjTzDRN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449894; c=relaxed/simple;
	bh=Gc7FcksWMiQVBDEzy4Q2dW4tjWnIHwPS6XvhUaiHv48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dM3nfwlELwkDGentGstr9gdo/9ZZW3QOEff5CY7SQUVFlZmNG2khDOlZBDrTjRQIAD3VX7i0sOrRuHLPl+TnjwUyqxF5Twa5wKFNa9IU60xlxs4nbec5zrBtFLLup0q9ikKm9GYWIgwYZTaQnwBFKSk0Tw0s5t07JP53BfUC2J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=Vi4bPuUN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1774449856; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fNRVGybp0b0ccTPEK93XLei9ra26a+WiK5T3HjYSwdjw0QX2kcQrJL0nSD+JukDDmVHNZ4wXzGSKKRA4TbVjiMMf+FpU6Z7wJEcRf9/gcFm2uqJYFF+GMKth/GCo4drecmKMtffXva2gnCvQ8qzqrgnDMWHFi3Yk8sVqGjanHSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774449856; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xLWt4Q3M25ZHux2mJmZzU06JtrlUU7M4bRigJUnf5rs=; 
	b=RJaCrtontfYAy5AIPGGtIE0x/ZruFSWKTnFPC4hGog+3QdLh2VMMTCAsyBLDHg0Hn4ks3rt20LBfGmaoqqcbER2JS8KEddB8PxlJxK+rT24ImJ3c3d+cWsynoAU8YT9yGWnccKig9UQbwCH50tcFZlqeC5S/g3oH0D6RINF2zbo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774449856;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=xLWt4Q3M25ZHux2mJmZzU06JtrlUU7M4bRigJUnf5rs=;
	b=Vi4bPuUNNPi2QNEocePGBUXkNmGOhjpUsr3LEaJfvQ9sirNaFJNUiAxsQ1kUTJHA
	wuEr/oz/5n8No780ciaNqvzLiNaeWEsECL0yo68RjQbKQvQ3Hf/qKGD7sy0wvg3Irlb
	ot9LTVnFpcSlZOQ7WXHBnTi3EWtG67rJU7T+YBG0=
Received: by mx.zohomail.com with SMTPS id 1774449855209698.9967635371158;
	Wed, 25 Mar 2026 07:44:15 -0700 (PDT)
Message-ID: <d2b284b8786fdf241a328bb4497c037b1d517c25.camel@collabora.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, kevin-kw.huang@airoha.com,
 macpaul.lin@mediatek.com, matthias.bgg@gmail.com, 	kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 25 Mar 2026 15:44:09 +0100
In-Reply-To: <aaheilkwpQ90xMmR@shell.armlinux.org.uk>
References: 
	<20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
	 <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
	 <aaheilkwpQ90xMmR@shell.armlinux.org.uk>
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
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:mid]
X-Rspamd-Queue-Id: DFCB93275AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

On Wed, 2026-03-04 at 16:32 +0000, Russell King (Oracle) wrote:
> On Wed, Mar 04, 2026 at 10:35:29AM +0100, Louis-Alexis Eyraud wrote:
> > +static void an8801r_get_wol(struct phy_device *phydev,
> > +			=C2=A0=C2=A0=C2=A0 struct ethtool_wolinfo *wol)
> > +{
> > +	u32 reg_val;
> > +
> > +	air_buckpbus_reg_read(phydev,
> > AN8801_BPBUS_REG_WAKEUP_CTL1, &reg_val);
> > +
> > +	wol->supported =3D WAKE_MAGIC;
> > +
> > +	if (reg_val & AN8801_WOL_WAKE_MAGIC_EN)
> > +		wol->wolopts |=3D WAKE_MAGIC;
> > +	else
> > +		wol->wolopts &=3D ~WAKE_MAGIC;
>=20
> Please only support WoL if you know that the PHY has been wired up in
> such a way to allow it to actually wake the system. The PHY itself
> merely supporting WoL is insufficient.
>=20
> Please look at my recent change to realtek_main.c in commit
> b826bf795564 ("net: phy: realtek: fix RTL8211F wake-on-lan support")
> to see a possible way to achieve this.
>=20
First, sorry for the delay, and thank you for pointing out this commit.

It indeed showed me what the WoL implementation for this PHY driver was
missing, not only for the get_wol/set_wol but also elsewhere in the
driver.

So for v2, I've reworked in a similar way the get_wol/set_wol, the
interrupt handling (to process differently the magic packet and the
link change interrupts) and also added custom probe, suspend and resume
callbacks (to be able to disable link change interrupt during suspend
time and enable it again after resume if the user has enabled the WoL
setting, like you did for RTL8211F).

I had a bit of trouble make it work right. At first I could not read
properly the PHY buckpbus registers in the suspend callback, and adding
a delay at resume time was needed as a workaround to make the WoL
behaviour work consistently. But in the end I found out it was the
Ethernet interface pinctrl config for sleep state in my board
devicetree that caused me those issues.
It works fine now without any workaround.

> > +static int an8801r_config_init(struct phy_device *phydev)
> > +{
> > +	u8 led_default_function[AN8801R_NUM_LEDS] =3D { 0 };
> > +	int prev_page, ret;
> > +
> > +	ret =3D an8801r_of_init_leds(phydev, led_default_function);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Disable Low Power Mode (LPM) */
> > +	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > AN8801_REG_PHY_INTERNAL0,
> > +			=C2=A0=C2=A0=C2=A0 FIELD_PREP(AN8801_PHY_INTFUNC_MASK,
> > 0x1e));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > AN8801_REG_PHY_INTERNAL1,
> > +			=C2=A0=C2=A0=C2=A0 FIELD_PREP(AN8801_PHY_INTFUNC_MASK,
> > 0x2));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Disable EEE by default */
> > +	ret =3D phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
> > 0);
> > +	if (ret)
> > +		return ret;
>=20
> Are you sure this is safe, e.g. over a suspend/resume, and doesn't
> cause the hardware vs software state to desync?=20
While reworking PHY WoL support, I've tested removing this EEE
disabling done during driver initial config and I did not notice any
particular issue, especially during suspend/resume sequences.=C2=A0Still
unsure why the downstream driver disabled it in first place.

The EEE support seems working fine too from what ethtool reports on my
board, so I'll remove the lines from v2.
>=20
> > +
> > +	prev_page =3D phy_select_page(phydev,
> > AIR_PHY_PAGE_EXTENDED_1);
> > +	if (prev_page < 0)
> > +		return prev_page;
>=20
> No, this is buggy. Please read the phy_select_page() documentation to
> find out why.
>=20
> > +
> > +	/* Set the PHY to perform auto-downshift after 3 auto-
> > negotiation
> > +	 * attempts
> > +	 */
> > +	__phy_write(phydev, AN8801_EXT_REG_PHY,
> > +		=C2=A0=C2=A0=C2=A0 FIELD_PREP(AN8801_EXT_PHY_CTRL1, 0x1d) |
> > +		=C2=A0=C2=A0=C2=A0 FIELD_PREP(AN8801_EXT_PHY_DOWNSHIFT_CTL, 1) |
> > +		=C2=A0=C2=A0=C2=A0 AN8801_EXT_PHY_DOWNSHIFT_EN);
> > +
> > +	ret =3D phy_restore_page(phydev, prev_page, ret);
> > +	if (ret)
> > +		return ret;
>=20
> However, the bug could've been avoided by using the appropriate
> accessor:
>=20
> 	ret =3D phy_write_paged(phydev, AIR_PHY_PAGE_EXTENDED_1,
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AN8801_EXT_REG_PHY,
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AN8801_EXT_PHY_CTRL1, 0x1d)
> |
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> FIELD_PREP(AN8801_EXT_PHY_DOWNSHIFT_CTL, 1) |
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AN8801_EXT_PHY_DOWNSHIFT_EN);
> 	if (ret < 0)
> 		return ret;
thanks for catching this bug.
I've replaced for v2 the __phy_write call by phy_write_paged cas you
suggested.
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
> > +	if (!phydev->link)
> > +		return 0;
> > +
> > +	if (prev_speed !=3D phydev->speed) {
>=20
> Maybe:
>=20
> 	if (phydev->link && prev_speed !=3D phydev->speed) {
>=20
> ?
Ack.

Thanks again for the review.

Regards,
Louis-Alexis
>=20
> Thanks.

