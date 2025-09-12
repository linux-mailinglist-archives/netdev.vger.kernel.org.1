Return-Path: <netdev+bounces-222359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FDB53F7B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF281B26527
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB14C6E;
	Fri, 12 Sep 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4KBt6D2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947281ACA;
	Fri, 12 Sep 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757636272; cv=none; b=WycDuhYNjSDLLZI/tGK7ZAb1+6RnxJHKBgNQYNkMnAxsT0jj0H3L6EJ2TiV62VGzFc6VkrFHRdwa+VcpKkRUUjabb63IUSlrvq3to31/qCJU48Ito7KA8Nuc0I4vvIsVLv4cDGqxCIaVvUZyMexDOLnxLcQT+O5KSVLJAemH/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757636272; c=relaxed/simple;
	bh=DNAaszBerFJ+PyZv9j52FnEQJyyHkVAX4kFYN/3vj9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7BvFBXZxy0uG3eG/NbhzRrkJQY7Nj/wGyYQlVSHb+rKo9ks6e4td4oCCZwr3UMF2TjoTFJTFk9WxKr5rDxZ//fR3XQKugoNljNmrysd3uBWakVfIjCuqML8IU03clMkMGnGOUZqdVd2dm5aTL+rJFLp8SqokxvsEhdVj7+eAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4KBt6D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807CEC4CEF0;
	Fri, 12 Sep 2025 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757636271;
	bh=DNAaszBerFJ+PyZv9j52FnEQJyyHkVAX4kFYN/3vj9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G4KBt6D2JPbMJgwp3sNI6ccIVbdSjkL4rqzADWILEBwpladiBPBM2PKGrKiPDeI+k
	 S4Maz1Z+hf/p47I9lDd2PQJp/ocuS+us0npUghSfHz4VjEfONaFirvLb9C5+XVxxuk
	 qj+c/wdHMFFv2xk/9bObiwqy1OMMiqsnLUbHQv7O1+VVRNEP2TbCwIbWkVgRqz35gg
	 1ruL+m8gSStj7xOJu2rNZZu31rvWgSybZdIYwV+N/fbM9C8E6IYKau4hRy6Im/cvoW
	 o/N6CnjZeaG6ykndaIiGJG+1lLC6RzZXNIkMW25UYyVp3tFNP4EeCnBnkJCBaYAGly
	 5dLEbRypBerLg==
Date: Thu, 11 Sep 2025 17:17:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250911171749.02e9fd99@kernel.org>
In-Reply-To: <20250911235547.477460e4@wsk>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
	<20250827082512.438fd68a@kernel.org>
	<20250907183854.06771a13@wsk>
	<20250908180535.4a6490bf@kernel.org>
	<20250910231552.13a5d963@wsk>
	<20250910172251.072a8d36@kernel.org>
	<20250911235547.477460e4@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 23:55:47 +0200 =C5=81ukasz Majewski wrote:
> > > Ok. No adjustments needed then. Good :)   =20
> >=20
> > No, you were talking about build_skb() which is Rx.
> > This is the patch that adds Tx. Tx is wrong. =20
>=20
> The same approach is taken in fec_main.c (@ fec_enet_txq_submit_skb()
> function).

FWIW I'm 99% sure we were once investigating a bug in FEC related to
modifying timestamped packets, leading to crashes. Maybe there is more.

> > > could be replaced just with mtip_switch_tx(napi->dev);
> > > as TX via napi->dev shall be forward to both ports if required.
> > >=20
> > > I will check if this can be done in such a way.   =20
> >=20
> > Not napi->dev. You have to attribute sent packets to the right netdev. =
=20
>=20
> And then we do have some issue to solve. To be more specific -
> fec_main.c to avoid starvation just from fec_enet_rx_napi() calls
> fec_enet_tx() with only one net device (which it supports).
>=20
> I wanted to mimic such behaviour with L2 switch driver (at
> mtip_rx_napi()), but then the question - which network device (from
> available two) shall be assigned?
>=20
> The net device passed to mtip_switch_tx() is only relevant for
> "housekeeping/statistical data" as in fact we just provide another
> descriptor to the HW to be sent.
>=20
> Maybe I shall extract the net device pointer from the skb structure?

Exactly :)

> > > You mean a separate SW queues for each devices? This is not
> > > supported in the MTIP L2 switch driver. Maybe such high level SW
> > > queues management is available in the upper layers?   =20
> >=20
> > Not possible, each netdev has it's own private qdisc tree. =20
>=20
> Please correct me if I'm wrong, but aren't packets from those queues
> end up with calling ->ndo_start_xmit() function?

Right. I think I'm lost, why does this matter?

> > I think I explained this enough times. Next version is v20.
> > If it's not significantly better than this one, I'm going to have=20
> > to ask you to stop posting this driver. =20
>=20
> I don't know how to reply to this comment, really.=20
>=20
> I've spent many hours of my spare time to upstream this driver.
> I'm just disappointed (and maybe I will not say more because of high
> level of my frustration).

I believe mlxsw has fewer DMA queues than ports. But TBH I'm not sure
how they handle the congestion. In your case since you only have two
ports (at most) I think you can trivially just always stop and start
both.

