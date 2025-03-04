Return-Path: <netdev+bounces-171466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE4A4D095
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74183A49E7
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EBA42AB0;
	Tue,  4 Mar 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRTUUvqA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262118D;
	Tue,  4 Mar 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050748; cv=none; b=QR/U/dHPaNXMtekJHMWqIg/W2SLPQjVA/CrUSSNSFRI1zluJ6wHPKnZ2/aZ4M7HT7Hf/PCvpU/hKGvMytSpBXx+oxExvcXEa9SxWhMEPZ5mZTahoJBYjCTuw5OcILbZp7dCIlwOAVeirYyrH08V5rDoQMEMszpfEyuGKW2t0xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050748; c=relaxed/simple;
	bh=fK13RTG60oM901lJvnBTBZkzA80AD4Iv7WCKf0MnMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRzAp1j01HsRua8tcK6JxtAkb6EeUfmnkA26iauHaovqWpms31Z2v2KF5pT0KwiPD8+UQ3Wcc9POxqxCUS/sWWVEfkJGqNgK9fpG4fu/hnQbrjWszPXhViLtes5aheU7l10IsCHixqQSA+U3QsvVCJMTrq1wqta/A32bNfXq0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRTUUvqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D2C4CEE8;
	Tue,  4 Mar 2025 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741050747;
	bh=fK13RTG60oM901lJvnBTBZkzA80AD4Iv7WCKf0MnMS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRTUUvqA1l8IpLboZkNJjdTiZy0XVlD/1AXeO2mpKzKOBBvAiXJbwG2wexUJJ1GYW
	 Ax0ipHfrkQTZVySvEzdWfsWYu/bsbmSUYaXc0IeT+0CLrJbyqsct+O6R353hngfHje
	 GiYFWqDtzAgMtdByEMSs9MUBv+dS8Kv5WYuJJoVA1grqoI1Q/Kq/qXHDuEgAXL4bBu
	 32sYjsxfKIQU90pGBRaa0dAOTrJqVpqm6ETwGmE8rkAS5pVNhY0MTsntQHOQGDQM93
	 cPqmDkjAJE3bJNBbHr6d4tHPD2qVg7HUmnjAZEutt/UG+z1wwEjvcRBOdaza3FdyXc
	 90rDlnH+7nK5w==
Date: Mon, 3 Mar 2025 17:12:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250303171226.4fb78c99@kernel.org>
In-Reply-To: <20250303144051.2503fb43@kmaincent-XPS-13-7390>
References: <20250224134522.1cc36aa3@kernel.org>
	<20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
	<20250225174752.5dbf65e2@kernel.org>
	<Z76t0VotFL7ji41M@pengutronix.de>
	<Z76vfyv5XoMKmyH_@pengutronix.de>
	<20250226184257.7d2187aa@kernel.org>
	<Z8AW6S2xmzGZ0y9B@pengutronix.de>
	<20250227155727.7bdc069f@kmaincent-XPS-13-7390>
	<Z8CVimyMj261wc7w@pengutronix.de>
	<20250227192640.20df155d@kmaincent-XPS-13-7390>
	<Z8ME-90Xg46-pNhA@pengutronix.de>
	<20250303144051.2503fb43@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 14:40:51 +0100 Kory Maincent wrote:
> > Ok, I assume we are talking about different things. I mean - not port
> > specific configurations and diagnostic, will have different interface.
> >=20
> > BUDGET_EVAL_STRAT is port specific. HP and Cisco implement it as port
> > specific. PD692x0 Protocol manual describe it as port specific too:
> > 3.3.6 Set BT Port Parameters
> >  Bits [3..0]=E2=80=94BT port PM mode
> >   0x0: The port power that is used for power management purposes is
> >        dynamic (Iport x Vmain).
> >   0x1: The port power that is used for power management purposes is port
> >        TPPL_BT.
> >   0x2: The port power that is used for power management purposes is
> >        dynamic for non LLDP/CDP/Autoclass ports and TPPL_BT for
> > LLDP/CDP/Autoclass ports. 0xF: Do not change settings. =20
>=20
> I don't really understand how that can be port specific when the power bu=
dget is
> per PD69208 manager. Maybe I am missing information here.

+1

> > So, I assume, critical components are missing anyway. =20
>=20
> As we are not supporting the budget method configured by the user in this
> series, I agreed we should not add any uAPI related to it that could be b=
roken
> or confusing later.
>=20
> I will remove it and send v6.

v6 sounds like a good idea.

