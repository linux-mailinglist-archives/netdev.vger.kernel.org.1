Return-Path: <netdev+bounces-66157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F383D910
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B211C234DD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003B13AEC;
	Fri, 26 Jan 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="QIJn82Kw"
X-Original-To: netdev@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9313AEE
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267437; cv=none; b=lsjaEjwEJPXmLvBgByq57vuWVy+zXZb9p2cf9xKNbF7ZvvdimPlYNShKFe3q6NjT/hT1l/pFhDdcOr98o76ES3bpZwnqB4iZl2fyHasbJTcCIOaX19pzPthd0RTHuxPequJRIkzB5/9cpOU6HG+J8QUW1RLt875TlnU/Zvn5EAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267437; c=relaxed/simple;
	bh=ZefzHrkmA6CvTAXsd+UX1LtpW836TGX+jIzZRvuBZpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQLqvVBb4RiPvUOzNfnTg/GwL8bkxqD03ONGWAatd43JA2vM37KC92TQRS3eVqQwOtYXR6owpZw6lSo9Pkqz5gTECl9UdMd3O3DhQnX4mXquefA4W26SMNm0pwtKhgd85JVI1wqqp0b6J/MKw5P9silZSEuKjuQ9s/ORDLOk1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=QIJn82Kw; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6809118CB7A;
	Fri, 26 Jan 2024 12:10:29 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706267429; bh=ZefzHrkmA6CvTAXsd+UX1LtpW836TGX+jIzZRvuBZpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIJn82KwV9wFEFW+w3FRkZAwihxFLz/j1c7jCHOJPIIFC43+tWycI0/Rg7YG83YOk
	 ysP4LPASClBQewXJ96AGPJTZVgLsCRRR52RwjiX5GZ8SRggQVSabj7ceEwnMcgLaCW
	 9uNOUwV6oXarUS75N/vfzpI5ZPUHc1YWaohYpRzUSp7bwbPaJmBAYRW3uNFGbS2t5y
	 cewGKlhx37XSkOMyawhLkt/3ct21NXUdSbIGx/Km+wBzQ1PYeWLDBNM986o6zEJxkV
	 vKSvllWTnFPrZRCZhXBWy8v31nyC3fT/izsJ2e9YNrToJurVrwzZsHpENpSRkO79HY
	 uapspukGG1BYA==
Date: Fri, 26 Jan 2024 12:10:28 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Marc Haber <mh+netdev@zugschlus.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <20240126121028.2463aa68@meshulam.tesarici.cz>
In-Reply-To: <ZbOPXAFfWujlk20q@torres.zugschlus.de>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
	<8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
	<ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
	<229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
	<99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
	<20240126085122.21e0a8a2@meshulam.tesarici.cz>
	<ZbOPXAFfWujlk20q@torres.zugschlus.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 11:54:20 +0100
Marc Haber <mh+netdev@zugschlus.de> wrote:

> On Fri, Jan 26, 2024 at 08:51:22AM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Thu, 25 Jan 2024 12:00:46 -0800
> > Florian Fainelli <f.fainelli@gmail.com> wrote: =20
> > > Did not Petr try to address the same problem essentially:
> > >=20
> > > https://lore.kernel.org/netdev/20240105091556.15516-1-petr@tesarici.c=
z/
> > >=20
> > > this was not deemed the proper solution and I don't think one has bee=
n=20
> > > posted since then, but it looks about your issue here Marc. =20
> >=20
> > Yes, it looks like the same issue I ran into on my NanoPi. I'm sorry
> > I've been busy with other things lately, so I could not test and submit
> > my changes. =20
>=20
> Is it worth trying your patch from the message cited above, knowing that
> is not the final solution?

Depends. It solves the deadlock (at least for me); my NanoPi has been
running stable for over a month with this patch. But it also introduces
a new spinlock, which usually reduces performance.

In any case, you can give it a try to verify that you hit the same
issue.

> > I hope I can find some time for this bug again during the coming weekend
> > (it's not for my day job). It's motivating to know that I'm not the
> > only affected person on the planet. ;-) =20
>=20
> I am ready to test if you want me to ;-)

Then you may want to start by verifying that it is indeed the same
issue. Try the linked patch.

Thank you!

Petr T

