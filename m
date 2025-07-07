Return-Path: <netdev+bounces-204649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EFCAFB9B4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62ED3BBFC1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A60288CB7;
	Mon,  7 Jul 2025 17:15:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AF91DE89B;
	Mon,  7 Jul 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908521; cv=none; b=CgfIu0TJyg7WWrn62vp+YHZs8OMn33AFT45W+zFB4bcKE3F4Q25MsHZ7oFiF0zuaBNf7db4gjYkdZTwuw7P2OZ0FzXqL0BbptNw+PWgwrc/b6MpISUBdZAZZA1rpGuna9+CX/Ip0YS1L9mmbVLERPnhw/61d3GaCMB/d3iyCuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908521; c=relaxed/simple;
	bh=ZSCK7w44JmsX0Wyn5E85NYbQ0N5E71LQIaQGd0NzzGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ8+XJuRK6HbHHnxdj4KmyWs8ZQ8mN/cfRaXZr0f0iPxTTE4cUT0NTnUPsJgLZ78RbKQ/2jEiBcD6i9mL9JJrrftQUw7gvwaKrvW8YnCO/L7kaLS576dIsaGfE9sUuM0gtkAvHrVCmxZ6+YnlepNZMijqzQtsCiZjODK5oCA9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259CC168F;
	Mon,  7 Jul 2025 10:15:06 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E195F3F66E;
	Mon,  7 Jul 2025 10:15:15 -0700 (PDT)
Date: Mon, 7 Jul 2025 18:15:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Message-ID: <20250707181513.6efc6558@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com>
References: <20250628054438.2864220-1-wens@kernel.org>
	<20250705083600.2916bf0c@minigeek.lan>
	<CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
	<e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
	<20250706002223.128ff760@minigeek.lan>
	<CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Jul 2025 21:14:09 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> On Sun, Jul 6, 2025 at 7:23=E2=80=AFAM Andre Przywara <andre.przywara@arm=
.com> wrote:
> >
> > On Sat, 5 Jul 2025 17:53:17 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Hi Andrew,
> > =20
> > > > So it's really whatever Allwinner wants to call it. I would rather =
have
> > > > the names follow the datasheet than us making some scheme up. =20
> > >
> > > Are the datasheets publicly available? =20
> >
> > We collect them in the sunxi wiki (see the links below), but just to
> > make sure:
> > I am not disputing that GMAC is the name mentioned in the A523 manual,
> > and would have probably been the right name to use originally - even
> > though it's not very consistent, as the same IP is called EMAC in the
> > older SoCs' manuals. I am also not against renaming identifiers or even
> > (internal) DT labels. But the problem here is that the renaming affects
> > the DT compatible string and the pinctrl function name, both of which
> > are used as an interface between the devicetree and its users, which is
> > not only the Linux kernel, but also U-Boot and other OSes like the BSDs=
. =20
>=20
> I reiterate my position: they are not stable until they actually hit a
> release. This provides some time to fix mistakes before they are set in
> stone.
>=20
> > In this particular case we would probably get away with it, because
> > it's indeed very early in the development cycle for this SoC, but for
> > instance the "emac0" function name is already used in some U-Boot
> > patch series on the list:
> > https://lore.kernel.org/linux-sunxi/20250323113544.7933-18-andre.przywa=
ra@arm.com/
> >
> > If we REALLY need to rename this, it wouldn't be the end of the world,
> > but would create some churn on the U-Boot side.
> >
> > I just wanted to point out that any changes to the DT bindings have
> > some impact to other projects, even if they are proposed as a coherent
> > series on the Linux side. Hence my question if this is really necessary=
. =20
>=20
> For the compatible string, I can live with having a comment in the binding
> stating the name used in the datasheet for reference.

For the compatible string going with a fallback name, I can live with
renaming it ;-)

> For the pinctrl stuff, which is the contentious bit here, I thought the
> whole idea of the newer pinctrl bindings is that the driver uses
> "allwinner,pinmux" instead of "function". I think having both being valid
> is confusing, and likely to cause conflicts later on. If we're going to
> use the hardware register values in the device tree, I'd really like them
> to be the only source of truth. The commit message for the binding also
> sort of suggests that "allwinner,pinmux" is the part that matters.

Yes, it should be, but it turns out to be convenient for U-Boot to
continue using the old method - until someone writes a driver for the new
schema. And a function name is still mandatory, it's just mostly for
reference now (so would indeed be fine to rename).

So if you really insist on this: please go ahead and merge it, so that
the 6.16 release contains the new name.

But please note my silent protest about those cosmetic name changes in the
DT realm, which establishes an interface reaching beyond just the Linux
kernel. When it comes to new boards, the U-Boot DT sync process is rather
slow, so I really am eager to cherry-pick -rc1 DTs already, instead of
waiting another 7 weeks - which bites me in this case. It's not merged
yet, so is fine in this case, but I would really like to avoid similar
hiccups in the future.

Cheers,
Andre.

