Return-Path: <netdev+bounces-242649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01119C936F2
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F16C94E121C
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C371DED40;
	Sat, 29 Nov 2025 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipDH2/ar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A961891A9
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764384534; cv=none; b=pVWFypEn+/5Ac7o13rJmlji+VtOO89zA7+CllNH66GLLYKzQ7361zUIFqkBfAOgfPa5H1uON75H++WJsMXoqz8jokiNzhqIRc+6PTb96ZRPfq6CA4hHBmnFZoQnMY8a/f43HVmpBpOp0HBydBEa71S+xAzdtx+DaL+dn0veXp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764384534; c=relaxed/simple;
	bh=/enZJ3f1Xj+OcCbUp/ebQOy2ec39G9qi6aMo7DqvXzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGChYWyHRxtiSdiPjhnveDtPnRmFKNCFuYSRS7j3IThGP/fjN/jlke60MH2xZ8fDqeu8r8Si5+gphWnqQRIHc+aGTpbHaI5ZDSxfNMaTTYJV+YdBoA538t+fJpSMrvVurrqE7Dotlg75EOyHmPflAR+6SzaqKxoR3Yn7QHm8rL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipDH2/ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11BDC4CEF1;
	Sat, 29 Nov 2025 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764384534;
	bh=/enZJ3f1Xj+OcCbUp/ebQOy2ec39G9qi6aMo7DqvXzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ipDH2/arN7XL9Qq6UL21XUqMvbTZp1rqjJgXXW75p6yksT3yhS30VYjZy+JkbY5ue
	 XEkdLKASN+jcEbaU8hdrMmzUoZmDoGWXO0artnxYwFHY9PaIYdkryibMFx2gAVVN6m
	 lGp+biCN18f0ekjWjB+86pR5WZnhstMceCyXJdenWwtAxzrvvlslm/1C39NFbMDWrC
	 2XvTbLtEcU+IgB1YJ2WbuQqrz6h9LU4sV9fJpPeomfne/f47NikrQnl0pePmgFC5nK
	 SMe+3ajQBbMNXCIzYxDXChl+E+onoORxqs9PN5Bt0wepttsnWeMVTD2PvRGxAzIaSd
	 e032W1rf7Ywow==
Date: Fri, 28 Nov 2025 18:48:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas
 =?UTF-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
Message-ID: <20251128184852.7ceb3e72@kernel.org>
In-Reply-To: <87cy51bxe1.fsf@toke.dk>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
	<aSiYGOyPk+KeXAhn@pop-os.localdomain>
	<87o6onb7ii.fsf@toke.dk>
	<20251128095041.29df1d22@kernel.org>
	<87cy51bxe1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2025 23:33:26 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > On Thu, 27 Nov 2025 20:27:49 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te: =20
> >> Yeah; how about I follow up with a selftest after this has been merged
> >> into both the kernel and iproute2? =20
> >
> > Why is iproute2 a blocker? Because you're not sure if the "API" won't
> > change or because you're worried about NIPA or.. ? =20
>=20
> No, just that the patch that adds the new qdisc to iproute2 needs to be
> merged before the selftests can use them. Which they won't be until the
> kernel patches are merged, so we'll have to follow up with the selftests
> once that has happened. IIUC, at least :)

You can add a URL to the branch with the pending iproute2 changes
when you post the selftests and we'll pull them in NIPA, or post=20
the patches at the same time (just not in one thread).

