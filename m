Return-Path: <netdev+bounces-133034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF564994540
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A07281602
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC9192B91;
	Tue,  8 Oct 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CJJ54ngw"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8813AA45;
	Tue,  8 Oct 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382986; cv=none; b=EK/IzgHeakJqLvow89wA4+FCkNOapaQao27/AsAwmZJ7CtVsfQL+/RJsJ02OUBq7YCO7WHafWOjTv6RTp6w265wGFFzIIMg+e5+TWzB1a/gzjKeDKfMxH+9mSs1re5bn5yenpLkWN10TFlF62IH3P4KAn/4fUMGNyJCdqOBU7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382986; c=relaxed/simple;
	bh=BFzMvSREEOum8MgZFnWfpoN7ulQ/dV9nEUsqkTYXgV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j08JCT4/No+OOMApHbEzOAKVPprqOlcT9AvQdD5WA+ECrUjXG5dpopsqlx0K/azF95fScr3TugjguTpF4wSvFjlNQ+F51umq+yx8W8yYrRvVcDSH0sI5IKf7eWBV45xS9Yr8YdoaUaeXSesVohiC2MfE4uVS5/cZOv9XzpDe3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CJJ54ngw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35792FF80D;
	Tue,  8 Oct 2024 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728382982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIbHxWMCVw9IFtJ8fRNey20NVfyWWoKwUnEtUaybiYI=;
	b=CJJ54ngwZcL7URuTbYdbrVlqR2wUbuEXMnBFiod1qQ/EQd5RYWr/VjvFv7hRRMTuHn78St
	rNozbHvUwssWLtOKDUfRL7lXdFxb6xRiPb1cS+0wVAyhWeODQspxHOYvHAzJhIt3W7iu7/
	QkNbHu8hXSjPJiWwveYb2IWN4KX2xhEHVGhmFym2Q/DBCulgbOKLKy/2JZNX5V+y3yGxhz
	SIOjsT9oORETkutfLM/JvZI8ixavFo1RiVtQPp/XpNTXFkRlS9t9adh5nbwMD3qoqOoYjD
	Czg4i8gdTFrsEZlOM8xtPu8kkqKB6h9c0afqXD+GYN13FhE88p+dEJbRtZNQjw==
Date: Tue, 8 Oct 2024 12:23:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <20241008122300.37c77493@kmaincent-XPS-13-7390>
In-Reply-To: <ZwPr2chTq4sX_I_b@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
	<ZwDcHCr1aXeGWXIh@pengutronix.de>
	<20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
	<ZwPr2chTq4sX_I_b@pengutronix.de>
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

On Mon, 7 Oct 2024 16:10:33 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> >=20
> > Currently the priority is managed by the PSE controller so the port is =
the
> > only information needed. The user interface is ethtool, and I don't see=
 why
> > he would need such things like controller id or power domain id. Instea=
d,
> > it could be managed by the PSE core depending on the power domains
> > described in the devicetree. The user only wants to know if he can allo=
w a
> > specific power budget on a Ethernet port and configure port priority in
> > case of over power-budget event. =20
>=20
> Budget is important but different topic. If user do not know how much
> the budget is, there is nothing usable user can configure. Imagine you
> do not know how much money can spend and the only way to find it out is
> by baying things.

Yes I agree, but I thought this could be done at the driver level specified=
 in
the power limit ranges for now.
I don't really know the Power Domain API but I don't think it can currently
support what you are expecting for PSE. Maybe through the regulator API, or
something specific to PSE API.
Maybe we should define the power domain PSE concept as it seems something P=
SE
specific.

> But, budget is the secondary topic withing context of this patch set.
> The primer topic here is the prioritization, so the information user
> need to know it the context: do A has higher prio in relation to B? Do A
> and B actually in the same domain?
>=20
>=20
> > I don't have hardware with several PSE controllers. Is there already su=
ch
> > hardware existing in the market? =20
>=20
> Please correct me if i'm wrong, but in case of pd692x0 based devices,
> every manager (for example PD69208M) is own power domain. There are
> following limiting factors:
>                           PI 1
>                    L4    /
> 		 PD69208M - PI 2
>               L3 //      \
>  L1      L2     //        PI 3
> PSU =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>                 \\        PI 4
>                  \\      /
> 		 PD69208M - PI 5
>                          \
> 			  PI 6
>=20
> L1 - limits defined by Power Supply Unit
> L2 - Limits defined by main supply rail ob PCB
> L3 - Limits defined by rail attached to one specific manager
> L4 - Limits defined by manager. In case of PD69208M it is Max 0.627A
> (for all or per port?)

Should the rail really have an impact on power limit? I am not a hardware
designer but having limit defined by the rails seems the best way to create
magic smoke.
Don't know how you find this 0.627A value but it seems a bit low. Port curr=
ent
limit is 1300mA according to the datasheet.

I first though that hardware should support all ports being powered at the =
same
time. Indeed this might not be the case be and there is a command to config=
ure
the power bank (PD69208M) power limit.
=20
> Assuming PSU provides enough budget to covert Max supported current for
> every manager, then the limiting factor is actual manager. It means,
> setting prio for PI 4 in relation to PI 1 makes no real sense, because
> it is in different power domain.

In fact it does for our case as the PD692x0 consider all the ports in the s=
ame
power domain. There is no mention of port priority per PD69208M.
We can only get PD69208M events and status.

> User will not understand why devices fail to provide enough power by
> attaching two device to one domain and not failing by attaching to
> different domains. Except we provide this information to the user space.

What you are explaining seems neat on the paper but I don't know the best w=
ay
to implement it. It needs more brainstorming.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

