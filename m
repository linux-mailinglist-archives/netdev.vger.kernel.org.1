Return-Path: <netdev+bounces-226774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBBBA5127
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FBE3B962D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8649924A066;
	Fri, 26 Sep 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll+HzMvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4971E0E1F;
	Fri, 26 Sep 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918924; cv=none; b=p4a1ZJADKXtD1gY8GeCLNBF1d48h44UizM0+MHlM0VFsTPs+K7/Ov1q/f+Y9IulJcgxTFqGZlg4MCG8Gt48gbdpB+/biObQEhfYvNoCc4YJnPCSt+TrlhnwHjlY18JCGe0Vqv/gkbQW2ReoUZD6rod4kXihy99chBA2j8nwj4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918924; c=relaxed/simple;
	bh=y4mlIzaH/FizPV54WfsnY2tn4w4vk6ZVQ7B7V7ozj+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIGU81qBRj/ogYaw/lV9O7h/SxZMecEbhZPoLfHKOU0Sg6adPwqCiefRH1Ip1EdVfZXtCA8dr+doggkXAdVJt9Jaayx9DaP+wTVYeIE6pyYTlZXCQaNqAmey+0folNK+gp7qZYlObkhTiHPwq9zb/icuHhioJIPWMRFhtogdDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll+HzMvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F2FC4CEF4;
	Fri, 26 Sep 2025 20:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918923;
	bh=y4mlIzaH/FizPV54WfsnY2tn4w4vk6ZVQ7B7V7ozj+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ll+HzMvsnlS96XZAmSYCUs9G8i5X7gUnA6j68Yw1VprxZl2Bjk2xkjQfIRi0PlO5/
	 dXXZx3C46GO9hsp0DKwxUhJcJ6yIY2fdAsoj11mtC993FAjFA0Bz4TYiTHenYK2DtR
	 pVzilq7wxxfIFOCj8DSwxBqlj5J0lULu3mZ/M/IGy7HexSJcmU6RwH71jPobTGSVWM
	 7unrjgMMF/h57qSxz5pXA5gGwQZEiD0UzOwj+eAPVD0Bk0/mOFz4Z5WT+HOtJZCVm3
	 q80pRVaaQdq9TeNBZXJ6Z0AScLujxanl66vsPXF2Rd1SsujH/0mSEWSDBw1nvZwHmZ
	 iGr742//3GWNg==
Date: Fri, 26 Sep 2025 13:35:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: wan: framer: Add version sysfs attribute for
 the Lantiq PEF2256 framer
Message-ID: <20250926133522.1b551382@kernel.org>
In-Reply-To: <f229764d-7dc5-4dfb-84d5-1dacec7edb86@csgroup.eu>
References: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
	<20250924164811.3952a2d7@kernel.org>
	<f229764d-7dc5-4dfb-84d5-1dacec7edb86@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 09:06:13 +0200 Christophe Leroy wrote:
> Le 25/09/2025 =C3=A0 01:48, Jakub Kicinski a =C3=A9crit=C2=A0:
> > On Wed, 24 Sep 2025 17:06:47 +0200 Christophe Leroy wrote: =20
> >> Lantiq PEF2256 framer has some little differences in behaviour
> >> depending on its version.
> >>
> >> Add a sysfs attribute to allow user applications to know the
> >> version. =20
> >=20
> > Outsider question perhaps but what is the version of?
> > It sounds like a HW revision but point releases for ASICs are quite
> > uncommon. So I suspect it's some SW/FW version? =20
>=20
> The datasheet of the component just calls it 'version'.
>=20
> Among all registers there is a register called 'version status register'=
=20
> which contains a single field named 'Version Number of chip'. This field=
=20
> is an 8 bits value and the documentation tells that value 0x00 is=20
> version 1.2, value 0x10 is version 2.1, etc...
>=20
> > We generally recommend using devlink dev info for reporting all sort
> > of versions... =20
>=20
> Ok, I'll look at devlink. Based on the above, what type of=20
> DEVLINK_INFO_VERSION_GENERIC_XXXX would you use here ?

That all sounds very mysterious. Maybe let's stick with sysfs if=20
we don't really know the details and where to put the value..

