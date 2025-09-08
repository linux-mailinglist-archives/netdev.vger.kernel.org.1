Return-Path: <netdev+bounces-220940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E465B49808
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B63AAA8F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C6318149;
	Mon,  8 Sep 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="oTwcWaK2"
X-Original-To: netdev@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86F314A8C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355201; cv=pass; b=jF28fRTIDcBexDRbapRKHt1dnQdxwFU5I3hCvrW2V+POix890yKZWgwpgZlECVsShx+nRkTCGh9sT5c4OlIQOykIxf9P4yrVHrbyT8R0uV0LEc8wVeTWL/fO6IE/2GBTk6qh7hQwj095h8faQAY0+k1W3hpS+uv1AlKFml4jNhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355201; c=relaxed/simple;
	bh=P/J8Q5DYQYuStvC6Bc73MAqlu8BUvqjwHti8m+/JaQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khavtqoe1CEYI+HJWh6bjfHM1vjihQmx7K+zHxJCHbNcztVWReAw4BAlyGdFE1KBXlwPsy0B4K8QcwqMvBGYG2GVclh+0keNJdLtq89tL93Hs+s3LbwZVS9TbGLVGpK/Rxu6OL2/uClveqeSdyVk1gzUjL2YK3y/SbKYrSg9w7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=oTwcWaK2; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 77D56165D76
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 17:56:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (trex-blue-4.trex.outbound.svc.cluster.local [100.105.40.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1F99D1650D7
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 17:56:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757354179; a=rsa-sha256;
	cv=none;
	b=mJXJPboKY7aNClNghZMbXlvt0pTNjqaCHHH9ji+BwEW7h7SRi8AhqelB3o+unz0B0h5xjn
	BBAGoKMq8QH9Rijr32+/fyQYE22+/4USTwg9x/EnH9+nL44gWTsppZdOnYYThoEeEfGFJp
	q7W8SxLsaUDmu5O5lrQ/1UARdinvv7IbR1eEq4DzfkM9nD3L7nEISjg/KxH166XECEeUbM
	VE53YmbFtWftSupgGsjzjE1iyq3sWM9MnhnCHVNe/uviB40tZdUfUW5DX8lhDfy+jADRGA
	UhSsw9uh4uIROrFoqNlznt+mX1LAJVmlVjHrOEkhevtBttulKum1QQ6k9fi50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757354179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AjGVOBGP1+0JyYOyX6xCbtYcMOxH1qnoHVFbeUfubMo=;
	b=xoDNf5PyyUn+LP3msgWk83Ydq/I9kt9rDVf/o+4u9/6ainAgPjTT9L90tonJmQ/a90O6Nw
	dK3PGCFpb3AN2d8+a+Fxol/9JJJA2MSjmJ0TapCcgi8jSpqaLkZG6aBCejioHGx6kxRiWV
	m0Zl6KShqrFZBBsEqwdUeOoc9yqnRB3sX0aAm1Y4WNHWMz1FfjcL7Fm+lHEQhXLLiUUgHw
	FBG4pIZi/k0jxSSqlskU4bVao6XAKLDxUmN2+Hsu0KXob8zHO9jLkkyzuei0PfgGM+9mte
	RVltNWT8eeykEPtCIw5bJQccEWPUWR65Cd0FSm5KUGij8a/yfEPUIexAhT5Yuw==
ARC-Authentication-Results: i=1;
	rspamd-8499c4bbdc-bvmt7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Broad-Zesty: 22e3f38c59484ff3_1757354179330_3321411724
X-MC-Loop-Signature: 1757354179330:2572880004
X-MC-Ingress-Time: 1757354179330
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.40.229 (trex/7.1.3);
	Mon, 08 Sep 2025 17:56:19 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4cLF4f31pBzm7
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1757354178;
	bh=AjGVOBGP1+0JyYOyX6xCbtYcMOxH1qnoHVFbeUfubMo=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=oTwcWaK21N5kITtrVxD5p6EZojXyCi8T1Zfja/XVTHa987hjNMb8EDK6gIA3cm2/c
	 KUdFQ6eXXe9vgt9EduoqzVYEPmjgvzIl7ymoJ/nEpsZCQ1lbka+GfFASqtQK4srD7l
	 qSz0RwwyfCld76fhJ3hzpIbZijA4ecCbc/fvaPCJgZMrKStlFMcR8oq6M86lqHFfF/
	 3D7L/kEXbQkgdO652dsZ7g0hn9fxj9WQt6GIylRetxmJ/w47jIsvfA7T0T66WmRvB3
	 IbeOny7EgRBE1Sz1aLxfG1AjW+H1f6dFJ1dBr4EJi11c16T44PXAZOO/tetNLO5amg
	 QEyVg/NCHxmbQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0263
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Mon, 08 Sep 2025 10:56:16 -0700
Date: Mon, 8 Sep 2025 10:56:16 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Reaver <me@davidreaver.com>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Message-ID: <aL8YwEx1dxa93lpR@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
 <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
 <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>
 <aL8RoSniweGJgm3h@templeofstupid.com>
 <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org>
 <aL8WNpl8ExODg20q@templeofstupid.com>
 <575893ce-11a8-492f-ac8c-5995b3e90c76@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575893ce-11a8-492f-ac8c-5995b3e90c76@kernel.org>

On Mon, Sep 08, 2025 at 07:51:10PM +0200, Matthieu Baerts wrote:
> 8 Sept 2025 19:45:32 Krister Johansen <kjlx@templeofstupid.com>:
> 
> > On Mon, Sep 08, 2025 at 07:31:43PM +0200, Matthieu Baerts wrote:
> >> Hi Krister,
> >>
> >> On 08/09/2025 19:25, Krister Johansen wrote:
> >>> On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
> >>>> Hi Geliang,
> >>>>
> >>>> On 07/09/2025 02:51, Geliang Tang wrote:
> >>>>> Hi Matt,
> >>>>>
> >>>>> On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
> >>>>>> …
> >>>>>
> >>>>> nit:
> >>>>>
> >>>>> I just noticed his patch breaks 'Reverse X-Mas Tree' order in
> >>>>> sync_socket_options(). If you think any changes are needed, please
> >>>>> update this when you re-send it.
> >>>>
> >>>> Sure, I can do the modification and send it with other fixes we have.
> >>>
> >>> Thanks for the reviews, Geliang and Matt.  If you'd like me to fix the
> >>> formatting up and send a v2, I'm happy to do that as well.  Just let me
> >>> know.
> >>
> >> I was going to apply this diff:
> >>
> >>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> >>> index 13108e9f982b..2abe6f1e9940 100644
> >>> --- a/net/mptcp/sockopt.c
> >>> +++ b/net/mptcp/sockopt.c
> >>> @@ -1532,11 +1532,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> >>> {
> >>>         static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
> >>>         struct sock *sk = (struct sock *)msk;
> >>> -       int kaval = !!sock_flag(sk, SOCK_KEEPOPEN);
> >>> +       bool keep_open;
> >>>
> >>> +       keep_open = sock_flag(sk, SOCK_KEEPOPEN);
> >>>         if (ssk->sk_prot->keepalive)
> >>> -               ssk->sk_prot->keepalive(ssk, kaval);
> >>> -       sock_valbool_flag(ssk, SOCK_KEEPOPEN, kaval);
> >>> +               ssk->sk_prot->keepalive(ssk, keep_open);
> >>> +       sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
> >>>
> >>>         ssk->sk_priority = sk->sk_priority;
> >>>         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> >>
> >> (sock_flag() returns a bool, and 'keep_open' is maybe clearer)
> >>
> >> But up to you, I really don't mind if you prefer to send the v2 by
> >> yourself, just let me know.
> >
> > Thanks, I'll go ahead and amend as you suggest and then send a v2.
> 
> Great, thanks.
> 
> While at it, please use [PATCH net] as prefix.

Thanks, will do.  May I preserve the Reveiwed-By tags from the v1, or
would you like to review again?

-K

