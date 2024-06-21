Return-Path: <netdev+bounces-105756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173A912ABB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216C0B25A50
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181115F410;
	Fri, 21 Jun 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QqjtxC2N"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46016757F8
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985382; cv=none; b=ZwXwVszUgjkgGLYxCWPTLhwEQLp3Yt7bJqQotulYR6jwKODvA6rx4FUsZ+/RazCodg2ctctBRhrS6Lhnzkl8ukrioxdnT9TtHPVhADRuz7eFg9l5Jxn3plGzn4ktE8djU6poI/yVVQnE1bIlw8EcEcq7FROR9fDACxss3mgJ4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985382; c=relaxed/simple;
	bh=v2aDx0Meuktibg/bvRQGVSmDgSM31PSGi9BvRGYDrig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbJBn4MJbVo0GLBYRWkO6AosrXLRzSe6Trd4jmZmKDdXUHs3A2hhwEOO2dcHnPELyQ3l8P53e+t95YVLwmNxRXSDIMRPONlxpw0dCHUJXstbtuODKoZYNQbmguqxmQOUgkhouN9L2ZuIBQmmwW6w2/Fegt0I8B1i0ZrBXaB1N88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QqjtxC2N; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22A70C0003;
	Fri, 21 Jun 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718985378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOfPf03Et+Ghs5D73+diZnj6QyjTJx87cyhLFrRVGlM=;
	b=QqjtxC2NQEq3vQm89Dz8Ca8wrJBa9MEEBSOio5gq99CG30Ncy1Mg+xC0DLZNnKkaEUcm9G
	1ACCfSgjUPLaFk9GVvHlfFY1zXLuDJALbKX5KsHDO1ykp8K79ZDnleDZTHT9cpSck/y2WU
	Sr/G1UDl0dob6u5Lzu1cXjczf6brS2EEwGVHIF3K+q+/gjNT63BSjqnZT6X08H4/g5t2ek
	uSM/dxmt0u+DNsMbYv8q5aPz586cclhixpi/PrFgRHr3dNZQ7xc9CiTAah/alVwLQ0n2g8
	mWYbsIP41EmURxnZnVwMPB47lzE0v9TMn6d6Tah4nLysd2UkCAIO/ZB36Q+cCw==
Date: Fri, 21 Jun 2024 17:56:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Netlink specs, help dealing with nested array
Message-ID: <20240621175617.496f85a5@kmaincent-XPS-13-7390>
In-Reply-To: <CAD4GDZworgYs12TArypDvTCqU7_FB7V-+vxhe3VbpQVEHSdutQ@mail.gmail.com>
References: <20240621161543.42617bef@kmaincent-XPS-13-7390>
	<20240621081906.0466c431@kernel.org>
	<CAD4GDZworgYs12TArypDvTCqU7_FB7V-+vxhe3VbpQVEHSdutQ@mail.gmail.com>
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

On Fri, 21 Jun 2024 16:27:57 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> On Fri, 21 Jun 2024 at 16:19, Jakub Kicinski <kuba@kernel.org> wrote:
>  [...] =20
>  [...] =20
> >
> > You're (correctly) formatting your data as a basic multi-attr.
> > Instead of:
> >
> > +        name: c33-pse-pw-limit-ranges
> > +        name-prefix: ethtool-a-
> > +        type: indexed-array
> > +        sub-type: nest
> > +        nested-attributes: c33-pse-pw-limit
> >
> > use:
> >
> > +        name: c33-pse-pw-limit-ranges
> > +        name-prefix: ethtool-a-
> > +        type: nest
> > +        multi-attr: true
> > +        nested-attributes: c33-pse-pw-limit =20
>=20
> Ah yes, I was "fixing" things in the wrong direction. Sorry for the confu=
sion.

Thanks Donald and Jakub!
It is working better with the right netlink specs.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

