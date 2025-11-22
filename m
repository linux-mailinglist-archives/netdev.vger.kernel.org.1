Return-Path: <netdev+bounces-240920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37469C7C125
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1BF83476A5
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD623E320;
	Sat, 22 Nov 2025 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOUQsn3s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D82BAF4;
	Sat, 22 Nov 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773911; cv=none; b=F0SQxGG0wkG+58l/ElQMFLNuH3Q2PK1ygkRODfKmVImfCMJcHZuG6oyDvpWVS+xY5fF9moda2SB9RTFbvbmBmBkfGxVFmzwLj1UwudXmBt2Qw1NjU/gx90hXx+wKVIfUt+l7Aku5YMvGsDfcUzn22rkUm/VTqx4hJReLIC2eknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773911; c=relaxed/simple;
	bh=t2tERroTEU2eQ/ybEp7YU9FDsZCacyXue4U+6rd9iws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkBrYWj6d0HWyRGl274N70wpSOY8w5OnVf07onQONwO3YANHDkiWnc2QYNkb9yH0/syzwR/QAe1J/m0D0CR8Xb1LSmYGgvOVEPndbwl7AdFcrFp1sFzCLR5rIlV7sZVnIVN7wALLzYA1McgkESJpc/TkrEL4ppogaMn/mBNcwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOUQsn3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365DBC4CEF1;
	Sat, 22 Nov 2025 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763773910;
	bh=t2tERroTEU2eQ/ybEp7YU9FDsZCacyXue4U+6rd9iws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gOUQsn3sdRuMUzLwhJy2dgIaL4ZzqgJ+1dLZLgXmuaG3LsB+JAdUQNTWJqM+QS6Eu
	 yAzZNhTGK8peslOVICb5lrYl8pdnZVIh9V1kDJzlR9iOxwKcXEL2Rz2kk/leFGge3u
	 ps6KabjGpcvgZziY6Yd70EdgBWRS2tiPvqrVvIJp9Plof4M9N9mOxRTifdUvsoukB5
	 HT9rtgoG8+T8TH1CmjFtmlchuadxKqhH8ibULFQqIt/9bLwXjFhqJlKqhdyfJe/3mQ
	 WEivxcb82NNHnQXctdP1dOqUCK42o1epFgKGicQoGfPdXRFSRKAMVNifa/jdmAZxHn
	 XvdfKXD3PQgLQ==
Message-ID: <5ceb8547df95c86d812744b07b0d8152f0503ed3.camel@kernel.org>
Subject: Re: [PATCH v21 08/23] cxl/sfc: Map cxl component regs
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Date: Fri, 21 Nov 2025 17:11:49 -0800
In-Reply-To: <69e5c565-3a19-4290-b0b5-9a0a749b5045@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <20251119192236.2527305-9-alejandro.lucero-palau@amd.com>
	 <93fdd5d5ded2260c612875943adab8fcfffc3064.camel@kernel.org>
	 <69e5c565-3a19-4290-b0b5-9a0a749b5045@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-21 at 11:01 +0000, Alejandro Lucero Palau wrote:
>=20
> On 11/21/25 06:54, PJ Waskiewicz wrote:
> > On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> > wrote:
> >=20
> > Hi Alejandro,
>=20
>=20
> Hi PJ,
>=20
>=20
> <snip>
>=20
>=20
> > > +	}
> > > +
> > > +	rc =3D cxl_map_component_regs(&cxl->cxlds.reg_map,
> > > +				=C2=A0=C2=A0=C2=A0 &cxl->cxlds.regs.component,
> > > +				=C2=A0=C2=A0=C2=A0 BIT(CXL_CM_CAP_CAP_ID_RAS));
> > I'm going to reiterate a previous concern here with this.=C2=A0 When al=
l
> > of
> > this was in the CXL core, the CXL core owned whatever BAR these
> > registers were in in its entirety.=C2=A0 Now with a Type2 device,
> > splitting
> > this out has implications.
>=20
>=20
> I have not forgotten your concern and as I said then, I will work on
> a=20
> follow-up for this once basic Type2 support patchset goes through.
>=20
> The client linked to this patchset is the sfc driver and we do not
> have=20
> this problem for the card supporting CXL. But I fully understand this
> is=20
> a problem for other more than potential Type2 API clients.
>=20
>=20
> > The cxl_map_component_regs() is going to try and map the register
> > map
> > you request as a reserved resource, which will fail if this Type2
> > driver has the BAR mapped (which basically all of these drivers
> > do).
> >=20
> > I think it's worth either a big comment or something explicit in
> > the
> > patch description that calls this limitation or restriction out.
> > Hardware designers will be caught off-guard if they design their
> > hardware where the CXL component regs are in a BAR shared by other
> > register maps in their devices.=C2=A0 If they land the CXL regs in the
> > middle of that BAR, they will have to do some serious gymnastics in
> > the
> > drivers to map pieces of their BAR to allow the kernel to map the
> > component regs.=C2=A0 OR...they can have some breadcrumbs to try and
> > design
> > the HW where the CXL component regs are at the very beginning or
> > very
> > end of their BAR.=C2=A0 That way drivers have an easier way to reserve =
a
> > subset of a contiguous BAR, and allow the kernel to grab the
> > remainder
> > for CXL access and management.
>=20
>=20
> I have thought about the proper solution for this and IMO implies to
> add=20
> a new argument where the client can specify the already mapped memory
> for getting the CXL regs available to the CXL core. It should not be
> too=20
> much complicated, but I prefer to leave it for a follow up. Not sure
> if=20
> you want something more complicated where the code can solve this=20
> without the driver's write awareness, but the call failing could be
> more=20
> chatty about this possibility so the user can know.

That would be a good addition.  Maybe something to indicate "hey, go
check if someone else already claimed ownership of this memory region"
instead of using a divining rod to find this in /proc/iomem on a hunch.
:)

>=20
>=20
> But I agree the current patchset should at least specifically comment
> on=20
> this in the code. I will do so in v22, but if there exists generic=20
> concern about this case not being supported in the current work, I'll
> be=20
> addressing this for such a next patchset version.

If you could capture this in either a comment or just the patch
description, I feel like there's enough paper-trail for people doing
this sort of design work should be informed.

I'd just hate to see all this work you're doing to make it in, and a
hardware designer somewhere not knowing the restrictions, and getting
irritated when their shiny new chip doesn't work with your code.  We
can at least help them with documentation.

Cheers,
-PJ

