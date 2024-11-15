Return-Path: <netdev+bounces-145211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F889CDB30
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FC7B2233A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E318CBEC;
	Fri, 15 Nov 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BI3udTYo"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDF16D9DF
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661918; cv=none; b=fjMhE3kAZjsFZi8Oq8v06e+MIcKK0kcOEkKQYU0PSZKL/CQQ8z54PmdhPxVvklUeRjPprKKCQd8jjNoz7ZOaClnu7LZYhpPbLFXfjE82M/0RX/Dxk+wuH+I5IL8FXl+mSfvNKwkC/oHM0nt//GlQ8LOmixcAfnFGvdZqi4c1azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661918; c=relaxed/simple;
	bh=7Ms/oSsLBt4A/SAgl6a+ZEkdg5DN23LDyDRzJws+kV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFoMdujqikr/ckAMvmbPehqewu5Qvsl1MWX2l3YS7Nvug6YbsF13qcx7UMidUkdQKw1rnVnuwCunxe3mkXJzrwR0wHYzdaG1ekNteJ+aYHhe5hXseYS5BPdAKYFrQWFdlY5uyfZmnxyc3JmUPLGYnslkAkF+1LEwlOoSiNZSfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BI3udTYo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63A3D240004;
	Fri, 15 Nov 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731661908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4yS7PvAWO1lhOSRuh6v2F8FYNMDf6jYfnIVbQHGkQE=;
	b=BI3udTYoCxC16OnIvQRBef3LOCA2pUrq+V8mtWrobeXkZblL6JLa3GOg1RMdkZ5pjXltR7
	k/eyj0uG7h3pJZUDEGoVVwHz1MnOsgXZnCi+kAbeHMA4JSzB9WyCMGMS5RrUAWsW4Yoin5
	kxIB1/JUbGxkiQXRmPDZK5SBXdByqWyJpKkDw/YfwUejVIKe66XP+GaWZ+aAIvLya900tb
	uHTZOQjyNIqahvtveR+/3VlLY47da06dDSFt8hsM5CpqJ1DGE7WezFifSqTvqXqhQdNFL3
	g/pR6GDW/uwmzLGzVLbI5QheSa0vORuTO2dm2TqXe8AO1iN4BXSvUVcZnyaOyA==
Date: Fri, 15 Nov 2024 10:11:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <20241115101145.063db234@kmaincent-XPS-13-7390>
In-Reply-To: <ZzZbqll+zj8o+Umc@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
	<20241113161602.2d36080c@kmaincent-XPS-13-7390>
	<ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
	<ZzZbqll+zj8o+Umc@shell.armlinux.org.uk>
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

On Thu, 14 Nov 2024 20:20:58 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Nov 13, 2024 at 03:57:56PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote: =20
> > > You simply need to install python python-yaml and maybe others python
> > > subpackages.
> > > Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" =
on
> > > the board.
> > >=20
> > > Then run the ynl commands. =20
> >=20
> > Thanks... fairly unweildly but at least it's functional. However,
> > running the first, I immediately find a problem:
> >=20
> > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
> >=20
> > One would expect this to only return results for eth0 ? I get: =20
>=20
> Here's the nlmon packet capture for the ynl request:
>=20
>         0x0000:  0004 0338 0000 0000 0000 0000 0000 0010  ...8............
>         0x0010:  2400 0000 1500 0503 f9d3 0000 0000 0000  $...............
>         0x0020:  1901 0000 1000 0180 0900 0200 6574 6832  ............eth2
>         0x0030:  0000 0000                                ....
>=20
> Length: 0x00000024
> Family ID: 0x0015 (ethtool)
> Flags: 0x0305 (Return all matching, Specify tree root, ack, request)
> Sequence: 0x0000d3f9
> Port ID: 0x00000000
> Command: 0x19
> Family Version: 0x01
>=20
> Then 16 bytes of data that does contain the interface name given to
> YNL. I haven't parsed that, it seems to require manual effort to do
> so as wireshark is unable to do so.
>=20
> I'd be guessing to draw any conclusions from this without deeper
> analysis.

Ok thanks, I will take a look at it

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

