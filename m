Return-Path: <netdev+bounces-247228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE1CF6092
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DB9E30096A5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41282D3ECF;
	Mon,  5 Jan 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiZWTuMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA1258CDF;
	Mon,  5 Jan 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657136; cv=none; b=fOrZnec73cIJz83xavdadn5TzLzTnMkrf7Vxbwpg2kV5Zcp6kHGdeSiUeNpcMKk2Dwp86Y/IFECURwGHetzZkiw3TifRClOHn8+Fu8x0PJtpJBH+xMuhxfBWb9JK7UHf0qL1gbioUmZgHi9tQVk2ASOAfSbg4VflQPmLEuxd+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657136; c=relaxed/simple;
	bh=InpbSg5WWbxh5upejxkSWh/I98qw75NJ/xF/DcqG+3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk9mU5pgHuAllQtN9ptk8FhrTCpoGodDEg44WDreS4fnIrvSa5+m/Hd76PtFRxZpM+9DBNOi9tYVgDZfEoqsJUWrThwu+bHclb3heHnf8usfoR8cZDx999rF2b0lOPG6C6j4HbabhvIZuWPjkloBvc1GORFh4wUv4bIE4B9i4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiZWTuMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE295C116D0;
	Mon,  5 Jan 2026 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767657136;
	bh=InpbSg5WWbxh5upejxkSWh/I98qw75NJ/xF/DcqG+3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NiZWTuMhGxKS1KoQT+iLsHi6rYxwLIAf7kW8wTub3Juior/7OEeNCS7zWG9Vee33P
	 3xKqQjhN8bEiop6+NEGy3CQQ7T2F2o/PYgPdm6gvp3rNSK13hzbyetuHyqeg+9BV12
	 4SR4n7YcsCnW63nzlsyU4EFyncqrW9kOxt66BbV/MjHD8aajkPKg6h3c09dG/d+s+t
	 THg2HO8vOE6xXVhBgP0TSjZINgXfOglT5ohPy9Tc57PARexqb+ORhFhyyJo20igejS
	 C9DmSfrSwGr4ddUK26iq3wAFpbnKsZUXT9+8crOt0YzDeRUdREFE3E0YN9iCq4GeVi
	 dz4ggSgw4g9Cg==
Date: Mon, 5 Jan 2026 15:52:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3] net: sfp: add SMBus I2C block support
Message-ID: <20260105155215.6e6e1456@kernel.org>
In-Reply-To: <aVvxSa2volDcLPZE@shell.armlinux.org.uk>
References: <20260105161242.578487-1-jelonek.jonas@gmail.com>
	<aVvmu1YtiO9cXUw0@shell.armlinux.org.uk>
	<3c774e4d-b7a6-44e3-99f3-876f5ccb1ca3@gmail.com>
	<aVvxSa2volDcLPZE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 17:13:45 +0000 Russell King (Oracle) wrote:
> > > This seems to be almost useless information. While base-commit exists
> > > in the net-next tree, commit ae039dad1e17867fce9182b6b36ac3b1926b254a
> > > doesn't exist in either net-next nor net trees.
> > >
> > > My guess is you applied Maxime's patch locally, and that is the
> > > commit ID of that patch. =20
> >=20
> > This was supposed to be the stable patch-id obtained with=C2=A0
> > 'git patch-id --stable'. =20
>=20
> Hmm, didn't know about that... but in this context, I wonder how
> useful it is. As a maintainer, given that patches submitted don't
> specify their patch-id, tracking down which patch is the
> pre-requisit would be a mammoth task [...]

+1, please wait for any pre-requisites to be in the tree before posting.
If you'd like to get early reviews send as RFC. Note that net gets
merged into net-next every Thu (in case the dependency is cross-tree
this is an extra wait).

