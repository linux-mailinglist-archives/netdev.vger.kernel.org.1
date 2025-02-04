Return-Path: <netdev+bounces-162648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E64A277A7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FA83A2854
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14362215F6E;
	Tue,  4 Feb 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUh67j57"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3307166F32
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688187; cv=none; b=nDauQt3QnEOl7MtKVD8D0LVOKf+C/DoCq34c3mlV9kCtGXITePi8hoxS39xdwbfTYWu8mJSF9SA3svp5Ez1q5sJarDdVG0X5QVGv4PCocdV8Z4BVdUJA21zZsUNvv9Vtc4wLD0jGztcf3xflXft5XDQ0qvNinCtbEsN3VW2jZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688187; c=relaxed/simple;
	bh=RbW9uTsECJUOJdA3NhnGD1StxHzPu7bZnVlVN/v257s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHn9oMTzFv1xVBIMTHmND77A+mXISrne6sAduk+rkzRXLGySlCu0AI+sJZd3gRe1k2wPwp9o7WrkZWSaDZzcLHca7c9Pa259SMWjUuu/EaAoCAC1DFqczPQPofoQO9miiwNkBbkJfIhspTdHzeeugyf4cKe9wLcoMf5jwVBPAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUh67j57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04129C4CEDF;
	Tue,  4 Feb 2025 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688186;
	bh=RbW9uTsECJUOJdA3NhnGD1StxHzPu7bZnVlVN/v257s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUh67j57pd/7V+YR3jKwxSH/1xVbiE8W2RVZEvBbpWyzssw3v9FWGSinCn+wqJzip
	 PQpG3Fx10FKaWt05aeKroB+npqpbi5a25i9bZ82jeaNk7eY3HwF9bQw5HIzDEUdvs9
	 Kt13VQH4FMmqkJgLWpVAQoccdUxgvpLZWVeBxlwzkwTUeztxiHLTkl2WS9YZYY0iUs
	 Y5Dl8ob6qPwOsevZ76Wr0I+TslfJcjDZ4ylKhYHpLMHB4AU58ea92vZFHrGSeEFI9e
	 hdv3Z+lL2Ra6k49PQvF8G5CW6obTszL7Bh+Gnto8aLmMaEkWcEn74sqzYiz7ZOfYqL
	 F/lbEKvK8RtMg==
Date: Tue, 4 Feb 2025 08:56:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Message-ID: <20250204085624.39b0dc69@kernel.org>
In-Reply-To: <871pweymzr.fsf@toke.dk>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
	<20250203143958.6172c5cd@kernel.org>
	<871pweymzr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Feb 2025 12:20:56 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > netdevsim is not for user space testing. We have gone down the path
> > of supporting random features in it already, and then wasted time trying
> > to maintain them thru various devlink related perturbations, just to
> > find out that the features weren't actually used any more.
> >
> > NetworkManager can do the HW testing using virtme-ng. =20
>=20
> Sorry if I'm being dense, but how would that work? What device type
> would one create inside a virtme-ng environment that would have a
> perm_addr set?

virtme-ng is just a qemu wrapper. Qemu supports a bunch of emulated HW.

> > If you want to go down the netdevsim path you must provide a meaningful=
=20
> > in-tree test, but let's be clear that we will 100% delete both the test
> > and the netdevsim functionality if it causes any issues. =20
>=20
> Can certainly add a test case, sure! Any preference for where to put it?
> Somewhere in selftests/net, I guess, but where? rtnetlink.sh and
> bpf_offload.py seem to be the only files currently doing anything with
> netdevsim. I could add a case to the former?

No preference, just an emphasis on _meaningful_.

Kernel supports loading OOT modules, too. I really don't want us
to be in the business of carrying test harnesses for random pieces
of user space code.

