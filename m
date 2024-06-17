Return-Path: <netdev+bounces-104088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665B90B207
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A16A1F24314
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A81B3748;
	Mon, 17 Jun 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iH888Rte"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6D1B373F;
	Mon, 17 Jun 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632045; cv=none; b=USi4tefy+hPFc5sQoR/P/MvqDYuLJPcS2xuM1FkEtmpKOSGV3zVzEQyOWw/AaU3JtnrrvE6dX1sf71AvVp2L3ABAmzV+jtHbFEoIYPUBlqgNNTkrQgu9Y4noZ4Y30f+3nekUX22kx4r9dpMXA9snsKqf5ofjZcZo4SzToZshKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632045; c=relaxed/simple;
	bh=Q1MqyZViCQ3zFLD85qT5W6U7jIiUXXBFXnrRPTGCDY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgsBpSDTbbvdGYCY0x21lnmFPWVdhro0Xqy/DCSIBUrPsB6IyDTujTBQccKRYnduis9FoZJ/3vVmRXdOFs3PTU9kB7MeHYpxZZZy79YRr1efFSNQ2TwRSAyFb93VFKCqSqXbKWhbAEV91v8y+hcKrjvvYPRyemiHyvtthRjGAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iH888Rte; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA97E40005;
	Mon, 17 Jun 2024 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718632034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3eG3gjTS+KA8nozT06bKgqA1twnhhiyTXAxxkY8Fls=;
	b=iH888RteCyf7T4qhopuOBfWYVQ2dKTZh33uY1HYpIjZOdmAWm7pfvQB4nNkeYi2zd0cXMv
	KzeHHxSTn7WjJULD7HVZUymgsRK+pixMw62A+uYehFdrfrfs07XhaYis6Ew7CQEleeAEze
	aw1WsmoY/snAC4X44OE9stAaOBDhDWeIK5IKIduS+1DlblKYYUlfcV7Om4b3vwpZaO/qHk
	7c/L6v3x6lnUV0EfEXA0qc4l5XkmxJXrVO2MoeUBmBndRJ+6TSln3gfQuSRautkIGhE0hQ
	Mc0Cb9S+XTjdrAVr4RbKYG2sdI/auOjwb/c4fcHNg4v4dFafze6t9t8hHKVRrA==
Date: Mon, 17 Jun 2024 15:47:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <20240617154712.76fa490a@kmaincent-XPS-13-7390>
In-Reply-To: <Zm15fP1Sudot33H5@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
	<Zm15fP1Sudot33H5@pengutronix.de>
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

Thanks for your complete reviews.

On Sat, 15 Jun 2024 13:22:36 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi K=C3=B6ry,
>=20
> Overall, it looks good. Some fields need clarification, so don't be
> surprised if I critique things I proposed myself. There are still
> aspects I don't fully understand :)

Me neither, lets continue dig this up together.

Figured out we could also base our substate according to 33.8 tables values.

> On Fri, Jun 14, 2024 at 04:33:17PM +0200, Kory Maincent wrote:
>  [...] =20
>=20
> > +/**
> > + * enum ethtool_c33_pse_ext_substate_class_num_events - class_num_even=
ts
> > states
> > + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> > + *
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_CLASS_NUM_EVENTS_CLASS_ERROR: Illegal
> > class
> > + *
> > + * class_num_events is variable indicating the number of classification
> > events
> > + * performed by the PSE. A variable that is set in an
> > implementation-dependent
> > + * manner.
> > + */
> > +enum ethtool_c33_pse_ext_substate_class_num_events {
> > +	ETHTOOL_C33_PSE_EXT_SUBSTATE_CLASS_NUM_EVENTS_CLASS_ERROR =3D 1,
> > +}; =20
>=20
> I'm still not 100% sure by this name. class_num_events seems to be more
> PSE side configuration variable. The pd692x0 0x43 value says "Illegal
> class" without providing additional information. If I see it correctly,
> typical classification will end with POWER_NOT_AVAILABLE if we will
> detect not supported class. Something other should fail to detect an
> illegal class.
>=20
> According to 33.2.4.7
> State diagrams we have CLASSIFICATION_EVAL function which evaluates
> results of classification.
> In case of class_num_events =3D 1, we have only tpdc_timer. In case of
> error, will we get some timer related error?
>=20
> In case of class_num_events =3D 2, if i see it correctly, PSE is doing
> double classification and if results do not match, PSE will go to faul
> state. See CLASS_EV2->(mr_pd_class_detected !=3D temp_var) case.
>=20
> Is it what we have here?

Mmh not really indeed, maybe we can put it in error_condition substate?

> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_UNDERLOAD:
> > Underload
> > + *	state =20
>=20
> pd692x0 documentation says, underload condition is related to Iport < Imi=
n.
> Sofar, I was not able to find Imin in the final IEEE 802.3 2022 spec.
>=20
> There are some historical traces:
> https://www.ieee802.org/3/af/public/mar01/darshan_3_0301.pdf
>=20
> Instead, underload condition seems to be part of Maintain Power Signature
> (MPS) monitoring. See 33.2.9 PSE power removal and 33.2.9.1.2 PSE DC MPS
> component requirements.
>=20
> Probably, it should go to the ETHTOOL_C33_PSE_EXT_SUBSTATE_MPS

Ok.
=20
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE:
> > Configuration
> > + *	change
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP: O=
ver
> > + *	temperature detected
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONNECTION_OPEN: Port=
 is
> > + *	not connected =20
>=20
> This seems to reflect DETECT_EVAL->(signature =3D open_circuit) case. So,
> it is probably not vendor specific error condition?
>=20
> The difference between open and underload is probably:
> - open: Iport =3D 0, detection state
> - underload: Iport < Imin (or Ihold?), Iport can be 0. related to powered=
/MPS
>   state.

Should I put it under MPS substate then?

> > +enum ethtool_c33_pse_ext_substate_option_detect_ted {
> > +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS =3D 1,
> > +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_IMPROPER_CAP_DET, =20
>=20
> The pd692x0 0x25 may be reported in two cases:
> Fail due to out-of-range capacitor value or
> Fail due to detected short value
>=20
> On one side, this seems to be related to MONITOR_INRUSH function.
> "33.2.7.5 Output current in POWER_UP mode
>=20
> The PSE shall limit the maximum current sourced at the PI during
> POWER_UP. The maximum inrush current sourced by the PSE shall not exceed =
the
> PSE inrush template in Figure 33=E2=80=9313."
>=20
> On other side, pd692x0 documentation is using 0x1C or 0x25 or 0xA7
> values together with "INVALID SIG" description. In this case, this
> values are related to signature detection stage, not power up or
> tinrush_timer stage. In this case, i assume:
> 0x25 and 0xa7 refers to Table 33=E2=80=936 or Table 145=E2=80=938 Invalid=
 PD detection
> signature electrical characteristics.
>=20
> Not sure about 0x1c - Non-802.3AF/AT powered device. Is it something
> between Table 33=E2=80=935 and Table 33=E2=80=936?=20
>=20
> CCing UNGLinuxDriver@microchip.com
>=20
> May be you will need to contact Microchip directly. Usually it helps :)

Lets keep it like that for now?

> > +enum ethtool_c33_pse_ext_substate_pd_dll_power_type {
> > +
> > ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE =
=3D 1,
> > +}; =20
>=20
> Here i was potentially wrong. LLDP stage is after power up, and this
> values was probably set on early stage of signature detection. How can
> we detect a device which is not conform to the 802.3AF/AT standard? Is
> it something pre-802.3AF/AT, micorosemi specific vendor specific signatur=
e?

Don't really know.
=20
> > +/**
> > + * enum ethtool_c33_pse_ext_substate_power_not_available -
> > power_not_available
> > + *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
> > + *
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED: =
Power
> > + *	budget exceeded
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC: Power
> > + *	Management-Static =20
>=20
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL: Po=
wer
> > + *	Management-Static-ovl =20
>=20
> Here we need some comment updates. Here is my understanding, taken out
> of thin air:
> 0x20 - We have per controller limit, but no limit per port is configured,
>        in this case, if PD classification request more power then
>        allowed by per controller budget, we will get this error.
>        AllPortsPower + NewPortPower > ControllerMaxPower
> 0x3c - We have per port limit configured and it is over the controller
>        budget.
>        AllPortsMaxPower + NewPortMaxPower > ControllerMaxPower
> 0x3D - PD Class requesting more power that the Port configured port limit.
>        PDClassPower > PortMaxPower
>=20
> How about:
>  *
> @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_CONTROLLER_BUDGET_EXCEE=
DED:
> Power
>  *   budget exceeded for the controller
>  *
> @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_POWER_LIMIT_EXCEED=
S_CONTROLLER_BUDGET:
> Configured
>  *   port power limit exceeded controller power budget
>  *
> @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT=
_LIMIT:
> Power
>  *   request from PD exceeds port limit

Yes seems right.
=20
> > + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT: Power
> > + * denied due to Hardware power limit =20
>=20
> Not sure i understand this one correctly. Is it something like - all prev=
ious
> errors can be solved by proper configuration, but on this one we can't do
> anything. The HW is the limit. Correct? :)

Suppose so. ;)
=20
> > +	if (st->c33_pw_class > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
> > +	if (st->c33_actual_pw > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW
> > */
> > +	if (st->c33_ext_state_info.c33_pse_ext_state > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_STATE
> > */
> > +	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0)
> > +		len +=3D nla_total_size(sizeof(u32)); /*
> > _C33_PSE_EXT_SUBSTATE */ =20
>=20
> Hm, we still may include __c33_pse_ext_substate even if c33_pse_ext_state=
 =3D=3D
> 0.

Right indeed. Will fix it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

