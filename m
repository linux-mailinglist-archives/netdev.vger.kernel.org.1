Return-Path: <netdev+bounces-102204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27118901E1E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6FE1F2281A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381A74064;
	Mon, 10 Jun 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F7v86O19"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF7335A7;
	Mon, 10 Jun 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011571; cv=none; b=eckhxiPyY3btO8/1xIWwZbFi4bVeNRUaLDnb0y6ndXOa16VZjVST3CkEciRTlDnNgr14XCqXpowir+P/O3iHDBmAhEdzT+Mpy7czL2dpfsmc556fwG/KDvD3jxv/3Sf1M/yD/tDHxLdOri6pmDrOyNc9svV6L1nM8HQPSdHpHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011571; c=relaxed/simple;
	bh=3z/wCMzo000cWjGkOKkDvzYB+nRA0ZJj5v7KXtRWU7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG5w8eiDIt5xlB6bqU5DsTi6vjQzAucOx5Z8gTlrgSUyU9N7D4o2e8Bze8OCiaG1+N+JYRx7Xue+H/xuuTWtGpYTNgp+L4yjvDioAqzdjJyvY02VKUo67YH9LAsBdwl4HYQ8/ispX8t9ywroX9CtxCgYjC8bE9rVptVJklX3nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F7v86O19; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03F461C000D;
	Mon, 10 Jun 2024 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718011560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eytCldcOr0ZAkk3Ut2yG/8HucBDVZ65zXES9P1bpuOo=;
	b=F7v86O19KfamSoyyQR4SuCBgLKUbgTE1YyLhz7eU0oEXQMIimTD1Vts65B0JWY4P5pv/nN
	pFYXgnNX+5KKMJhd532lAsMkM0I6lqRGOPADXDqFwzpJLfI9F4aGPRoxteC9WVCvjsCpkW
	aBUGzH/zTWaTkiEk3Fk7g/Xn4KITiYb7Gk7jTK/zrxMap0aFHXYBu6laMX0wWY+fuEFtQ1
	ftaG6ER1p74ip9WmVcnyD1uYfq7vJ4xlDHcK5r9w24xMQOJ6vuIaUmbE7sZPAjhGQSMouV
	1AzhhQb/WB5Ggr4Hpv2LB+KoPprBE8OqP2MX0VUkyw/axJSpwgvegEuklwgNwA==
Date: Mon, 10 Jun 2024 11:25:59 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <20240610112559.57806b8c@kmaincent-XPS-13-7390>
In-Reply-To: <ZmaMGWMOvILHy8Iu@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
	<20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
	<ZmaMGWMOvILHy8Iu@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleksij,

On Mon, 10 Jun 2024 07:16:09 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi K=C3=B6ry,
>=20
> Thank you for your work.
>=20
> On Fri, Jun 07, 2024 at 09:30:19AM +0200, Kory Maincent wrote:
> > From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com> =20
>=20
> ...
>=20
> >  /**
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > index 8733a3117902..ef65ad4612d2 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -752,6 +752,47 @@ enum ethtool_module_power_mode {
> >  	ETHTOOL_MODULE_POWER_MODE_HIGH,
> >  };
> > =20
> > +/* C33 PSE extended state */
> > +enum ethtool_c33_pse_ext_state {
> > +	ETHTOOL_C33_PSE_EXT_STATE_UNKNOWN =3D 1, =20
>=20
> I assume, In case the state is unknown, better to set it to 0 and not
> report it to the user space in the first place. Do we really need it?

The pd692x0 report this for the unknown state: "Port is not mapped to physi=
cal
port, port is in unknown state, or PD692x0 fails to communicate with PD69208
device allocated for this port."
Also it has a status for open port (not connected) state.
(ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OPEN)
Do you prefer to use the same error for both state?
=20
> > +	ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
> > +	ETHTOOL_C33_PSE_EXT_STATE_CLASSIFICATION_FAILURE,
> > +	ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE,
> > +	ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
> > +	ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
> > +	ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED, =20
>=20
> What is the difference between POWER_BUDGET_EXCEEDED and
> STATE_CURRENT_ISSUE->CRT_OVERLOAD? If there is some difference, it
> should be commented.

Current overload seems to be describing the "Overload current detection ran=
ge
(Icut)" As described in the IEEE standard.
Not sure If budget exceeded should use the same error.

> Please provide comments describing how all of this states and substates
> should be used.

The enum errors I wrote is a bit subjective and are taken from the PD692x0
port status list. Go ahead to purpose any change, I have tried to make
categories that make sense but I might have made wrong choice.

> >  /**
> >   * enum ethtool_pse_types - Types of PSE controller.
> >   * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
> > diff --git a/include/uapi/linux/ethtool_netlink.h
> > b/include/uapi/linux/ethtool_netlink.h index b49b804b9495..ccbe8294dfd5
> > 100644 --- a/include/uapi/linux/ethtool_netlink.h
> > +++ b/include/uapi/linux/ethtool_netlink.h
> > @@ -915,6 +915,10 @@ enum {
> >  	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
> >  	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
> >  	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
> > +	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
> > +	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
> > +	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u8 */
> > +	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u8 */ =20
>=20
> Please, increase the size to u32 for state and substate.

Ack,

> >  	/* add new constants above here */
> >  	__ETHTOOL_A_PSE_CNT,
> > diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> > index 2c981d443f27..3d74cfe7765b 100644
> > --- a/net/ethtool/pse-pd.c
> > +++ b/net/ethtool/pse-pd.c
> > @@ -86,7 +86,14 @@ static int pse_reply_size(const struct ethnl_req_info
> > *req_base, len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STAT=
E */
> >  	if (st->c33_pw_status > 0)
> >  		len +=3D nla_total_size(sizeof(u32)); /*
> > _C33_PSE_PW_D_STATUS */ -
> > +	if (st->c33_pw_class > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
> > +	if (st->c33_actual_pw > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW
> > */
> > +	if (st->c33_ext_state_info.c33_pse_ext_state)
> > +		len +=3D nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_STATE */
> > +	if (st->c33_ext_state_info.__c33_pse_ext_substate)
> > +		len +=3D nla_total_size(sizeof(u8)); /*
> > _C33_PSE_EXT_SUBSTATE */ =20
>=20
> Substate can be properly decoded only if state is not zero.

Indeed, thanks for spotting that mistake.
=20
> Please update Documentation/networking/ethtool-netlink.rst

Oh right, indeed. Forgot to add the netlink docs.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

