Return-Path: <netdev+bounces-220635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A124B4785E
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 02:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45DB3C7AE3
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DB34CF9;
	Sun,  7 Sep 2025 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1pzyZSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93135223;
	Sun,  7 Sep 2025 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757206297; cv=none; b=cCFUzB8mel8cgATrBj99nvm1yAnvkCnJTJdh9cTHasjtgC59TR7Sbgwh45JMSIl+8UbVWeraLGREkCFffidhPxiU/F7lfaxHRFyDO5X0Gf/De+tN1dybGVL4hsjdYqvRj7AM4TNlcRdv1UHJUtsQ/Qexe1HPKkVqpk1gn4zbrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757206297; c=relaxed/simple;
	bh=PTrTtM6k2vDgkB71HaQPoI3qKrDGpeD79mECOTUkwTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rsf98G8liVbrN+DOUgiY8YLUZcX7VcA1FYj6Gdk+6kJzE32cRYE5NioKQSW2PbZWixujtLVonYghzL5HLJNdSiFo0y8fTj6tJ6Xg7fApBP4cGpicE/kIkdezeVIW0k2wPP2ZiqBF7YRBzrECLrSTZ+5SFA5aFqQDWy89r/TVuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1pzyZSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06947C4CEE7;
	Sun,  7 Sep 2025 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757206297;
	bh=PTrTtM6k2vDgkB71HaQPoI3qKrDGpeD79mECOTUkwTw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L1pzyZSaVyJBHfZobD05Ig+VzdsSvwG5UrpLcr8KbCdLffarSsQs8Ym2l+CdtwH3/
	 yr4eY2QGymwy1G/7OIP8y+C9potFRAiyv7hR8gCaeyTkobpny1a5VjNqqc3zxghY/w
	 xhy6UDo1WKwiPIB0y+5XPdJFkGPae60xLrH9/Kr/x8V3Xas2Q8rNhomFNeD/VZV22H
	 x1kLlRIjyv/LBvMLaGF0/YmCpESq/7uQaunXnqe2ijvSXvWHHodqjPnBBZvtBDOtQn
	 GZ7eJVUDQs2YvnlZfk8XyzhFWDe95cB0MDt5cjC6knqy+ZqVcmkmQ5K82c6LMqAO1z
	 1nWwMV2bCtetQ==
Message-ID: <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options
 propagate SOCK_KEEPOPEN
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Krister Johansen
	 <kjlx@templeofstupid.com>, Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, 	mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Reaver	 <me@davidreaver.com>
Date: Sun, 07 Sep 2025 08:51:31 +0800
In-Reply-To: <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
	 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
> Hi Krister,
> 
> On 06/09/2025 02:43, Krister Johansen wrote:
> > Users reported a scenario where MPTCP connections that were
> > configured
> > with SO_KEEPALIVE prior to connect would fail to enable their
> > keepalives
> > if MTPCP fell back to TCP mode.
> > 
> > After investigating, this affects keepalives for any connection
> > where
> > sync_socket_options is called on a socket that is in the closed or
> > listening state.  Joins are handled properly. For connects,
> > sync_socket_options is called when the socket is still in the
> > closed
> > state.  The tcp_set_keepalive() function does not act on sockets
> > that
> > are closed or listening, hence keepalive is not immediately
> > enabled.
> > Since the SO_KEEPOPEN flag is absent, it is not enabled later in
> > the
> > connect sequence via tcp_finish_connect.  Setting the keepalive via
> > sockopt after connect does work, but would not address any
> > subsequently
> > created flows.
> > 
> > Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
> > the
> > subflow when calling sync_socket_options.
> > 
> > The fix was valdidated both by using tcpdump to observe keeplaive
> > packets not being sent before the fix, and being sent after the
> > fix.  It
> > was also possible to observe via ss that the keepalive timer was
> > not
> > enabled on these sockets before the fix, but was enabled
> > afterwards.
> 
> 
> Thank you for the fix! Indeed, the SOCK_KEEPOPEN flag was missing!
> This
> patch looks good to me as well:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
> @Netdev Maintainers: please apply this patch in 'net' directly. But I
> can always re-send it later if preferred.

nit:

I just noticed his patch breaks 'Reverse X-Mas Tree' order in
sync_socket_options(). If you think any changes are needed, please
update this when you re-send it.

Thanks,
-Geliang

> 
> Cheers,
> Matt

