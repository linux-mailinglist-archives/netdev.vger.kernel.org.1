Return-Path: <netdev+bounces-123809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB544966960
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768151F243CA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19461BA281;
	Fri, 30 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh71pGo0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E91DA22
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045260; cv=none; b=W9Sh0YMoXwMUKIfAkRnlDq6merpAB76bxnCWY8yYul51hjoKq46QP5A8FwGEVbFfQcS4+BFZA1j6IVAL+lfgAyfaP4NitLGR1dIY+SYDKUVnEcjrRBWisNQ3aUDQTLwtORCQmTdxhtEGt5FMQ+8kW5kPGooQngmLC1mayp776i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045260; c=relaxed/simple;
	bh=wGhBMBgM0ROt6ktM3GMH2VAMYqx4ySKxfA5iIFGOMnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5zaw6oO+5IOlWb55bfTODue4W4A3g6NskSpEn/6vIGUbBJl2Li+4AkSp4MedhKa/L10XG8STI/wF+AhiendRILBV4wfsQeZlkl2hdHhBvelp8pigd0qoSSDLShLMPZ/Hha0jXYZqZYzN0vZto0tsLjsASfFbmjeSY87jxTJWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh71pGo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39FEC4CEC2;
	Fri, 30 Aug 2024 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725045260;
	bh=wGhBMBgM0ROt6ktM3GMH2VAMYqx4ySKxfA5iIFGOMnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fh71pGo0uOIsf7HRT0sPNEkWLzYikwDWdmqnrGx7mnrKLFUkL6Sidd5bluyulcB1O
	 jWmx3z3ssVpnAoW3UVfTTpiWKBbSA8kuG96Gq1/4dtGqHMbDmRh6TrVBPckikNEmpA
	 EbtqnQpKb1ay0vMSlFYJ1AHzof3VZ/0MtGds0rtAjOGKCbItPktDI/Raf2lT+IdK0+
	 ay72xAGbKKotXkaVYDfAmqdvtdP9+W4o/kdvRH3EI8tB2/x5nzTy16xIWQ8agPuyE+
	 YxYjqs7tFKz7xWsk2Wn/pyCSmFEnxE0iDCDf8Z0y3gSGghHJ8CKLruEIRvkVHXkKfe
	 +H3mOwsNENHNw==
Date: Fri, 30 Aug 2024 12:14:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240830121418.39f3e6f8@kernel.org>
In-Reply-To: <58730142-2064-46cb-bc84-0060ea73c4a0@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
	<20240829182019.105962f6@kernel.org>
	<58730142-2064-46cb-bc84-0060ea73c4a0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2024 17:43:08 +0200 Paolo Abeni wrote:
> Please allow me to put a few high level questions together, to both=20
> underline them as most critical, and keep the thread focused.
>=20
> On 8/30/24 03:20, Jakub Kicinski wrote:
>  > This 'binding' has the same meaning as 'binding' in TCP ZC? :( =20
>=20
> I hope we can agree that good naming is difficult. I thought we agreed=20
> on such naming in the past week=E2=80=99s discussion. The term 'binding' =
is=20
> already used in the networking stack in many places to identify=20
> different things (i.e. device tree, socket, netfilter.. ). The name=20
> prefix avoids any ambiguity and I think this a good name, but if you=20
> have any better suggestions, this change should be trivial.

Ack. Maybe we can cut down the number of ambiguous nouns elsewhere:

maybe call net_shaper_info -> net_shaper ?

maybe net_shaper_data -> net_shaper_hierarchy ?

>  > I've been wondering if we shouldn't move this lock
>  > directly into net_device and combine it with the RSS lock.
>  > Create a "per-netdev" lock, instead of having multiple disparate
>  > mutexes which are hard to allocate? =20
>=20
> The above looks like a quite unrelated refactor and one I think it will=20
> not be worthy. The complexity of locking code in this series is very=20
> limited, and self-encapsulated. Different locks for different things=20
> increases scalability. Possibly we will not see much contention on the=20
> same device, but some years ago we did not think there would be much=20
> contention on RTNL...

We need to do this, anyway. Let me do it myself, then.

> Additionally, if we use a per _network device_ lock, future expansion of=
=20
> the core to support devlink objects will be more difficult.

You parse out the binding you can store a pointer to the right mutex.

> [about separate handle from shaper_info arguments]
>  > Wouldn't it be convenient to store the handle in the "info"
>  > object? AFAIU the handle is forever for an info, so no risk of it
>  > being out of sync=E2=80=A6 =20
>=20
> Was that way a couple of iterations ago. Jiri explicitly asked for the=20
> separation, I asked for confirmation and nobody objected.

Could you link to that? I must have not read it.
You can keep it wrapped in a struct *_handle, that's fine.
But it can live inside the shaper object.

> Which if the 2 options is acceptable from both of you?
>=20
> [about queue limit and channel reconf]
>  > we probably want to trim the queue shapers on channel reconfig,
>  > then, too? :( =20
>=20
> what about exposing to the drivers an helper alike:
>=20
> 	net_shaper_notify_delete(binding, handle);
>=20
> that tells the core the shaper at the given handle just went away in the=
=20
> H/W? The driver will call it in the queue deletion helper, and such=20
> helper could be later on used more generically, i.e. for vf/devlink port=
=20
> deletion.

We can either prevent disabling queues which have shapers attached,=20
or auto-removing the shapers. No preference on that. But put the
callback in the core, please, netif_set_real_num_rx_queues() ?
Why not?

>  > It's not just for introspection, it's also for the core to do
>  > error checking. =20
>=20
> Actually, in the previous discussions it was never mentioned to use=20
> capabilities to fully centralize the error checking.
>=20
> This really looks like another feature, and can easily be added in a=20
> second time (say, a follow-up series), with no functionality loss.
>=20
> I (or anybody else) can=E2=80=99t keep adding new features at every itera=
tion.=20
> At some point we need to draw a line, and we should agree that the scope=
=20
> of this activity has already expanded a lot in the past year. I would=20
> like to draw such a line here.

I can help you. Just tell me which parts you want me to take care of.

