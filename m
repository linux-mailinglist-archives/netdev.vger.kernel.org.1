Return-Path: <netdev+bounces-188782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1EAAED13
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEE507DC3
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C328ECC9;
	Wed,  7 May 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="IJe1RCwq"
X-Original-To: netdev@vger.kernel.org
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974728ECC8
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649794; cv=none; b=mjV31V9f/oSq/PhuC5nkD64r399uCn3pHPjs2ojd9f0GWRNbu0whPZGYNAf2eIFXW1bfOtalcHiPb3SXsZmF3B/C7C5WdtcH5OWB6cXL5DiJ+ErBCHPW0XZ3AWCP+dgPZTQQgGtn89W6WOkGdUvMZCcCDtAme4futxX8gP7CsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649794; c=relaxed/simple;
	bh=lErmMD09JAMSQHs3RZcyUjOb0lunF+UgnhCSp/t9rKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nq4GEJVB95giSa9ugINDLGWnP/AfQhM4Zif5UJIgqG2LfipPKyBYK6nzAmWPB9OvB1iDfdEZZ0Zua9yetyXjkTR6o8AnLiJ6LKkBnMa7W88+WXIT0LfnnIuIb142ZlNPKxk5VpaZ+bDbAPjRXvuXxxvvvGoYOP0B16T0d/olvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=IJe1RCwq; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [192.168.90.188] (unknown [94.110.49.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 7546E5FDF10;
	Wed,  7 May 2025 22:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1746649430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lErmMD09JAMSQHs3RZcyUjOb0lunF+UgnhCSp/t9rKc=;
	b=IJe1RCwq317fvU7jrQFzcwl1Rw7XtRgcNjfyYO90mJUu8H0cOaKyVNTvQ/NrMkkN1ylUsq
	m1da+0soQDab5cQ1eRYBGuMM+nSNBMCh1rOVdumvH8hSyPF6Bkvhw3y8gO7HjdTrTeaxcK
	H0TOrZcnUPZt097OuVZEO203CAWafHoK6eb3ydqb1eMTeRVB6DXaoeMalc2odEiSHq5TBf
	k6HEouO2tFQRRqZ8ODU8YOSZ2a2J7rZjpCGzJNdCq1PIghE0u7I8/5yGm1zokwVfGGeKhA
	PAvvRw/UtqZSOfoWOpn79WpbKBoYGCZJLnQlj0snbTRIRVY61PegZ2pBfm74Pw==
Message-ID: <4cdbc8804ad23a24a9aa3bb12667031b5bada3a6.camel@svanheule.net>
Subject: Re: [PATCH] regmap: remove MDIO support
From: Sander Vanheule <sander@svanheule.net>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn	
 <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>
Date: Wed, 07 May 2025 22:23:49 +0200
In-Reply-To: <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
	 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
	 <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
	 <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
	 <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Heiner,

On Wed, 2025-05-07 at 08:49 +0200, Heiner Kallweit wrote:
> On 07.05.2025 08:21, Mark Brown wrote:
> > On Wed, May 07, 2025 at 08:09:27AM +0200, Heiner Kallweit wrote:
> > > On 07.05.2025 02:50, Mark Brown wrote:
> > > > On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:
> >=20
> > > > > MDIO regmap support was added with 1f89d2fe1607 as only patch fro=
m a
> > > > > series. The rest of the series wasn't applied. Therefore MDIO reg=
map
> > > > > has never had a user.
> >=20
> > > > Is it causing trouble, or is this just a cleanup?
> >=20
> > > It's merely a cleanup. The only thing that otherwise would need
> >=20
> > If it's not getting in the way I'd rather leave it there in case someon=
e
> > wants it, that way I don't need to get CCed into some other series
> > again.
> >=20
> Understood. On the other hand is has been sitting idle for 4 yrs now.

How time flies...

The original series that this was part of was never fully merged. This was =
(in
part) due to some general regmap changes being required [1]. In the meantim=
e
someone else has submitted (nearly the same) changes that were merged into
regmap [2], so I could try resubmitting my patches. These have now been inc=
luded
downstream in OpenWrt for a few months too, where they are using the regmap=
 MDIO
support, but I understand that out-of-tree consumers aren't usually up for
consideration.

Best,
Sander

[1] https://lore.kernel.org/linux-gpio/cover.1623532208.git.sander@svanheul=
e.net/
[2] https://lore.kernel.org/lkml/20240408101803.43183-2-rf@opensource.cirru=
s.com/

