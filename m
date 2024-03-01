Return-Path: <netdev+bounces-76474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1C86DE26
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7541F1F21B79
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B873F6A8AB;
	Fri,  1 Mar 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm1w20hZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959396A8AA
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285099; cv=none; b=U1uIvKAp92SQrWjZuMCjFlJWDa6x7O2TUfmbxzb4RE0ItjUjzVIh+4pDgUnTndjqSeYrCtYtHznQXxNPqZ/VkcuZx+RRzxE4LkKMruHs2meRURNTNOFbF/1lMOd0AzjXJ3lU4/Mu1r/2XHxMi6S4qqoPscp+Hij0vm2VIulg7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285099; c=relaxed/simple;
	bh=7ocGF7YaNqhYAXKabO8jk2gdE+btCUUfqUT7b+Niemw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kE6iYoaZE0blGHLAkb6qNNxkoPhN6cP5pv707prB5co972MpKC5FF4Up6ubI7mcXbUEWKgvHoyt1qIj28WqZL0WnQMGCWFaSnD+7RAZP7xFqKMQ0itZ2Mi7GzBtZ7+0joh1O9oM7+UlwV9jr6ZamBtt0rC6TNp3grjiYnlN/Dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm1w20hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5FFC433C7;
	Fri,  1 Mar 2024 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709285099;
	bh=7ocGF7YaNqhYAXKabO8jk2gdE+btCUUfqUT7b+Niemw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sm1w20hZM6z0/1FLMuREBTG2laS0RaHcWO/0f8slVNSSUVFaB55zcLGvX53Du2QGl
	 HH9G4q98Fvef9SCbOC2PaeM/o/XYcEE+W5GX8Xu5Hc0sJNtpVVUA9RaCBNPPSl8mLZ
	 aliFWY+rH36wAuLDOwLR3g++Mtj79xr1sixCCsZNK/K4UQFrv+/hXEofyarO9piugQ
	 mGizyPirhfVO00izVyI3TbHjD1gPO/NbPZ6Y93AOT814rxmr57G6GFvyfjhbqsRqcp
	 GRQ2WIop9j6fHvxTcsyyPgcNxst1oHAz4mvwyoJvTwo+W1Y/uVM10X1dH6kl4FBEMi
	 FXrKflUnZZKsA==
Date: Fri, 1 Mar 2024 10:24:53 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>, Eric Woudstra
 <ericwouds@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org, Alexander Couzens
 <lynxis@fe80.eu>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes
 mode for rtl822x/8251b PHYs
Message-ID: <20240301102453.33ed68a2@dellmb>
In-Reply-To: <ZeCyAGiZZAFbVxAi@makrotopia.org>
References: <20240227075151.793496-1-ericwouds@gmail.com>
	<20240227075151.793496-2-ericwouds@gmail.com>
	<Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
	<20240229135010.74e4304a@dellmb>
	<ZeCyAGiZZAFbVxAi@makrotopia.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 16:34:08 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> On Thu, Feb 29, 2024 at 01:50:10PM +0100, Marek Beh=C3=BAn wrote:
> > On Tue, 27 Feb 2024 10:36:05 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > > +	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> > > > +	if (ret < 0)
> > > > +		return ret;   =20
> > >=20
> > > It would be nice to know what this is doing. =20
> >=20
> > No documentation for this from Realtek, I guess this was just taken
> > from SDK originally. =20
>=20
> There is an additional datasheet for RTL8226B/RTL8221B called
> "SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
> setup interface and rate adapter mode, and also the sequence to
> disable (H)SGMII in-band-status are described.
>=20
> However, there is no documentation about the meaning of registers
> and bits, it's literally just magic numbers and pseudo-code.

Thanks, Daniel.

Eric, can you mention this in the code in a comment?

Marek

