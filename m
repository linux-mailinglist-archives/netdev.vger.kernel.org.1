Return-Path: <netdev+bounces-121926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D803B95F4BE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167F61C2120F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2CB192D76;
	Mon, 26 Aug 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2NZI2pV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718318D638;
	Mon, 26 Aug 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684942; cv=none; b=P/y6G5JLJYQ13JV9OFLthHt3l7RvOq/x0TF39WZ4owf2JENcWsto1nwuQgIc7gfe4aIo0RS8wBXOp+tCDHV6am/DyZwXlll/K4YgPcWhSmb6v4/tL5gqa++4G5sJoHs+EoT4ib50feTWznypZYz6nXYkon4gyniXEPKYKcRpZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684942; c=relaxed/simple;
	bh=1FcWwVmq5wSunT5cmUVeAwOQUJR8rsIt/3WQGn6zDpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDCebxRQufk+MMGxjPD+n9aUHP++OEc4R0DyLOrWyRuNdxwmwqaCMWwVZ746cqcypDoDot0tv+JP1D1ofoEncQqdNVcJJ9aCeNwqKqp5Er6VFQI+eO4+ueNzlifaXkP3ikiLZcLEWT4ybgMSpdLZRefg4L8frzYQlfU20/HRBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2NZI2pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC5C4FF64;
	Mon, 26 Aug 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684941;
	bh=1FcWwVmq5wSunT5cmUVeAwOQUJR8rsIt/3WQGn6zDpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2NZI2pVGyNE72plXR7hlNROMm3N2/0rTa26L/M4UkwzEbKd1IpFZ8Xj6MJh4tDL1
	 rXHS8BQxL2EifJ4qEcgnd4C5WQB90ouh3RvOyRfpyzcTnR258xIAZawTLVz6wWBfF3
	 RsdcUdEkpH0CsbRJXXRf7x9HvIroIx+T8afNouLAzfyqgY+xusbe6m10WPXdjVz8b0
	 /Yh7UOaj+umBjkgaNiO6CdmDZDUDggBJI9q42dnu3o1nrsDicrUxfToHf+k7zF8X09
	 0Net8ZIE5YkcRFU2Mp0WJsq+rpW8RAFQ53ird/XZyAv96D/85/NpEkpVyKpR5kw/d+
	 tl8ZIt5w+/Crg==
Date: Mon, 26 Aug 2024 08:09:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
Message-ID: <20240826080900.57210004@kernel.org>
In-Reply-To: <a1b025a9-4fa0-42d8-9ad7-5a3888574b3f@nvidia.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
	<20240821150700.1760518-3-aleksander.lobakin@intel.com>
	<CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
	<a1b025a9-4fa0-42d8-9ad7-5a3888574b3f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Aug 2024 11:19:49 +0300 Gal Pressman wrote:
> On 21/08/2024 18:43, Eric Dumazet wrote:
> > On Wed, Aug 21, 2024 at 5:07=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote: =20
> >>
> >> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> >> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> >> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> >> Remove this bit waste.
> >>
> >> It wasn't needed to rename the flag instead of removing it as
> >> netdev features are not uAPI/ABI. Ethtool passes their names
> >> and values separately with no fixed positions and the userspace
> >> Ethtool code doesn't have any hardcoded feature names/bits, so
> >> that new Ethtool will work on older kernels and vice versa. =20
> >=20
> > This is only true for recent enough ethtool (>=3D 3.4)
> >=20
> > You might refine the changelog to not claim this "was not needed".
> >=20
> > Back in 2011 (and linux-2.6.39) , this was needed for sure.
> >=20
> > I am not sure we have a documented requirement about ethtool versions.
> >  =20
>=20
> This is a nice history lesson, so before the features infrastructure the
> feature bits were considered as "ABI"?
>=20
> I couldn't find a point in time where they were actually defined in the
> uapi files?

Keep in mind that include/uapi was introduced around v3.7, before=20
that IIUC everything under include/linux that wasn't protected by
ifdef __KERNEL__ was uAPI. So all of include/linux/netdev_features.h

