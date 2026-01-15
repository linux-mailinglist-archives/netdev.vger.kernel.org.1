Return-Path: <netdev+bounces-249993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538DD222D7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26B4305BC1B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802E26CE2D;
	Thu, 15 Jan 2026 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWNjWBYQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39B283FD9
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445119; cv=none; b=reViYgQIIzfnQ1r1aSeKCq0IfUbHF0ApbGJsjRh5kbMXjRgZquNiQ7cbGbw6s4L39sexCoKusu0jGoedz/KH9s8yxmbT/CYF50l1ytNPm8T8ZP82NLjLVHsoy3vHBuXlcF0fjSREuPm9XfptCjceM8fzGUIo8QuelwDaBnAltsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445119; c=relaxed/simple;
	bh=FyYtlOLn2WmoBeGCZCwdnfekhJBHi+NNevlSx7+iXxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb/V1BGZU7TRQSStqvxmSLJ9o2XsX3bQApVlHp8sRN4lHMp6lTtXzOtMzEN4/MZ+XE0M1FbBqkaB+l1l5GjxtpY8ZnDwMiX9nta4pH29SI9g58GU5EmAaCBjX9/I8C6p8YKt7cAPCTv5ekpPEijRwC0VGtX+yHQhvEeed7BOR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWNjWBYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF622C16AAE;
	Thu, 15 Jan 2026 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768445118;
	bh=FyYtlOLn2WmoBeGCZCwdnfekhJBHi+NNevlSx7+iXxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWNjWBYQokOvEPcgdNqId7u7aq1CaBXulRsYXHmPGBY8JcPcc48OgYtd9zo++abvm
	 vWX1yQv73rSVfh/NTLFem3xgop+DN6pQRo/hnyTUUnoO6Wy7QriZy8eKTHErw4ZxN9
	 Io+j0B+NzGstVX3PQgm4hfZMMBUAQt7MzRfyIM1XwZBo0568OXTTzFiGQFYyG0EivY
	 89XNoZCPyMx0dH6uH2rqyqqR5dbyaPu2Zj7zrymfBl0fkSJU8zMaFajNW7SwrVIt+P
	 KXxvY4itq05IOScD831jhsqKK62FG2eAv3oN7dlzyCOH1v1Ogl/Zxwp/dALIzEdPgq
	 QNgQIeaxMlfKA==
Date: Wed, 14 Jan 2026 18:45:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] amt.sh flaking
Message-ID: <20260114184517.281a816b@kernel.org>
In-Reply-To: <CAMArcTX97OGA7HXwUQk3MPdhrJo_LfNzi73XDZEKZyBbUEtwHA@mail.gmail.com>
References: <20260105180712.46da1eb4@kernel.org>
	<CAMArcTWF12MQDVQw3dbJB==CMZ8Gd-4c-cu7PCV76EK3oVvFXw@mail.gmail.com>
	<CAMArcTX97OGA7HXwUQk3MPdhrJo_LfNzi73XDZEKZyBbUEtwHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 20:55:29 +0900 Taehee Yoo wrote:
> > > TAP version 13
> > > 1..1
> > > # timeout set to 3600
> > > # selftests: net: amt.sh
> > > # 0.26 [+0.26] TEST: amt discovery                                   =
              [ OK ]
> > > # 15.27 [+15.01] 2026/01/05 19:33:27 socat[4075] W exiting on signal =
15
> > > # 15.28 [+0.01] TEST: IPv4 amt multicast forwarding                  =
               [FAIL]
> > > # 17.30 [+2.02] TEST: IPv6 amt multicast forwarding                  =
               [ OK ]
> > > # 17.30 [+0.00] TEST: IPv4 amt traffic forwarding torture            =
   ..........  [ OK ]
> > > # 19.48 [+2.18] TEST: IPv6 amt traffic forwarding torture            =
   ..........  [ OK ]
> > > # 26.71 [+7.22] Some tests failed.
> > > not ok 1 selftests: net: amt.sh # exit=3D1
> > >
> > > FWIW the new setup is based on Fedora 43 with:
>=20
> Hi Jakub, Sorry for the late reply.
>=20
> The root cause is that the source sends packets before the connection
> between the gateway and the relay is established. At that moment,
> packets cannot reach the listener.
> To fix this issue, the source needs to wait until the connection is
> established. However, the current AMT module does not notify its
> status to userspace. As a temporary workaround, I will send a patch
> that adds a 5-second sleep just before =E2=80=9CIPv4 AMT multicast forwar=
ding.=E2=80=9D
> After that, I will work on adding status notifications to the AMT module
> and to iproute2.

Sounds great. I don't think that a single sleep 5 in this test would=20
be a big deal but of course having a notification is better if you have
cycles to implement that. Thanks for looking into it!

