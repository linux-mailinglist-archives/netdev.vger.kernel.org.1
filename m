Return-Path: <netdev+bounces-204652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0122AFBA08
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515F216C9FE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821122D4DD;
	Mon,  7 Jul 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQLd0HQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D51C7009;
	Mon,  7 Jul 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910044; cv=none; b=lGF9hgBnjTRByO5WwPKMQMKBBNqzAjl5CFKvHF5WUCuaX4NUzlMT9GBNjitIY5OVNDFkyBEgB1sGGcrmwPZAArNsg/ozTfoYh9G7nM8Er2SLAL7TnLuzHJl+S5XDKGzqbwsh9BM6zKc48cyFNalZ2KTfH6NC86Hodl9htnVP4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910044; c=relaxed/simple;
	bh=IAJD16YaKd3JM9QbVlD6VK5fDsNro8r0MHN8Ya+MUaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kdukwn5Bye1PHT69EMtfvhnF/bVYZNmd0i+wfSazlc8by0+wVivYufkO3IyyRwt0tz57pK0JIJigDS10RaVNd9+e3VPGV6RjcpJ7LmR6oAE4+musQoNTVQ5nT0b06FDhPpJe7WGMeHlKeVB3Q3HZpxKpzuOx6oedGK+egmsl4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQLd0HQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B358C4CEF1;
	Mon,  7 Jul 2025 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910042;
	bh=IAJD16YaKd3JM9QbVlD6VK5fDsNro8r0MHN8Ya+MUaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQLd0HQB/bn2rwp5WuuIjWKVA9AwLRlZuOIQDs5BFcUoEJXnLbX89gwr/ataeGmUD
	 iT+eOenypPpf/A+qo7iRtWMtO2oEdPjZwH0y1c7PUY90Y1V09wFLYW70X+9+mIIczw
	 tlIhtlPtlHY8GEsoYUkuL82e0oNo8hAHB4LjmAL6Gv3ZellYfhZukXTnP/PSEZKA5w
	 ARfXyoc9Vpob6IzPpamtnNpCN+IB9m5tMw0a9QbtFJawcGyaRV4wLjXJnXjddHoDO/
	 lKHVQch/WGTgYeAKme8jNyiNPdwmRDNaymT51UQxJ0dJC206nCJYEN2bgQe7suIM8a
	 ERRiIzY0WUpyw==
Date: Mon, 7 Jul 2025 10:40:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
 kuni1840@gmail.com, willemb@google.com
Subject: Re: [ANN] netdev foundation
Message-ID: <20250707104041.17e26e4a@kernel.org>
In-Reply-To: <CAL+tcoBJmxE5+f8vZ=DbPRO=Bi84kEU=yrmqnuri30duva=HYg@mail.gmail.com>
References: <20250701103149.4fe7aff3@kernel.org>
	<20250702080732.23442b9e@kernel.org>
	<CAL+tcoBJmxE5+f8vZ=DbPRO=Bi84kEU=yrmqnuri30duva=HYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jul 2025 07:40:35 +0800 Jason Xing wrote:
> On Wed, Jul 2, 2025 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Tue, 1 Jul 2025 10:31:49 -0700 Jakub Kicinski wrote: =20
> > >  https://github.com/linux-netdev/foundation
> > >
> > > The README page provides more information about the scope, and
> > > the process. We don't want to repeat all that information - please
> > > refer to the README and feel free to comment or ask any questions her=
e.
> > >
> > > And please feel free to suggest projects! =20
> >
> > I see a number of people opened the link (or maybe like most Internet
> > traffic these days it's just AI scraping bots? :D) but no project
> > proposals were added, yet. =20
>=20
> I hope I didn't misunderstand what you said here. I keep thinking if
> there are other projects related to kernel development.

Project in this context means something we can fund, for example adding
a specific feature to a specific tool, like patchwork.

