Return-Path: <netdev+bounces-167372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7535CA3A03E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B41E3B6BC8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E026A0FE;
	Tue, 18 Feb 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/2xNzw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CE26AA8F
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889432; cv=none; b=qwV2PzXam5W3+D3nJgYaSyUVCTLrUMDvXKJdA2E7lrbHrNCS8r53bqdn/dtbEKla/NVS3vlhS4YEaQAEmfigluyzkap0ugWajcZdgEK4yzKJlbUE90fvlUEsp4ukw7PEK8stNLVShftohZJVDanzPS0gtVF+0/k+80zT4BST690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889432; c=relaxed/simple;
	bh=LmtrYjD6Th35wCymIT2wd4L+fI0DTneob1fX71ep0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkG2SZD58nt09dVVWGjW5ZKajWLeUcMTkMNRTG35bIRhoFyDrWrZs0XhUQE1R5OAKjVbnxHNjl1z0Nb2RSv0cO5f1gQWMOEswdJ3j4EDSVUVptGGWYAuQA9Hwyv6ByHM1EOeWnQaWFRASTGFKxaFN4kPFpR/BnOQSZCAYAHI2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/2xNzw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6DDC4CEE2;
	Tue, 18 Feb 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889431;
	bh=LmtrYjD6Th35wCymIT2wd4L+fI0DTneob1fX71ep0qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A/2xNzw3iJTljWHHQ6WIoyMWy97XBn1jBwmnEpQRly5l94h4rLcwMeTGOYjMRO9Vv
	 z9Q6WImFZiPpNZnNETesgQzLJq342m4ifknXxyh5T8K3FE58ZKhc2crF80kd/76q/P
	 PjTv8XHFn2vGHRsGoiwzhMpvgZgXCIk3vW/Qg9gLkH9C/rH/HB3eWNSTnMXyD+P4sz
	 GXkoeQT8hJjtSF9FNv63gcwLh5EA5bA2cJMRG3d/DejcCoj5sLiNLvNuLpQdcGVuAS
	 hjpQtvqbIGd3Mreku4mwe7aVGkMDmfJcX5rMZpfU+iBrbPZdkrlyKp4RiTrsixeDc5
	 8brsvH0pL2jmw==
Date: Tue, 18 Feb 2025 06:37:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
Message-ID: <20250218063710.7e1ba2ab@kernel.org>
In-Reply-To: <874j0ro1pd.fsf@toke.dk>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
	<20250213074039.23200080@kernel.org>
	<87zfipom9q.fsf@toke.dk>
	<20250217095150.12cdec05@kernel.org>
	<874j0ro1pd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 13:51:42 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Hmm, and you don't see any value in being able to specify a permanent
> >> identifier for virtual devices? That bit was not just motivated
> >> reasoning on my part... :) =20
> >
> > I can't think of any :( Specifying an address is already possible. =20
>=20
> Right, but the address can be changed later. Setting the perm_addr makes
> it possible for a management daemon to set a unique identifier at device
> creation time which is guaranteed to persist through any renames and
> address changes that other utilities may perform. That seems like a
> useful robustness feature that comes at a relatively low cost (the patch
> is fairly small and uncomplicated)?
>=20
> > Permanent address is a property of the hardware platform.
> > Virtual devices OTOH are primarily used by containers,=20
> > which are ephemeral by design. At least that's my mental model. =20
>=20
> Sure, any device feature that comes from hardware is only going to fit
> virtual devices by analogy. But I don't think the analogy here is super
> far fetched (cf the above)? :)

I'm not sure how to answer this. It all sounds really speculative
and disconnected with how I see virtual devices being used.

