Return-Path: <netdev+bounces-170071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E5A4731C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE33A7114
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8660DCF;
	Thu, 27 Feb 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu8hy/MU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633E2BB15
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623957; cv=none; b=Zs25sRDWIi4QUhfk9eKatOhAIq1pgD3A0eMbt12mW1TCxxrUWI4/j2nsxI1EQ+A13kUyTmd2w1YIW2QhMg5MX+MW+fxfF7LHNMC/K2OmNUCOxILE/xa0gVZGCZq/2OL1wRj7Kw2Mz3WUY50oacG2EqI5auJrpclA4DtivtJ/DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623957; c=relaxed/simple;
	bh=s2LQ9NDtlDzqJgbYQvI5TM0qHmfu9hEHcEnOOAz9vjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEpUUOEYuFNdtepNtVL7MpbF42lQxhohtrW4JPx1XG25Kv+jh9JOwdbQeEgPzrZpwac03RpLmDk/Nsnf3B/SjeDCOTZcC85Dfpk7nqudAiFVVGl9C29MAzGX7d3kFWpGgB0jCXOzWMKJLxnsyF79EWBPkodubLSBOxM2Aj6upTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu8hy/MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B005C4CED6;
	Thu, 27 Feb 2025 02:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740623954;
	bh=s2LQ9NDtlDzqJgbYQvI5TM0qHmfu9hEHcEnOOAz9vjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hu8hy/MUqal5Ut8Swvty8PdlnMryaAreK7sZGhV9JUGkS2z8dF5PRwCBZc1nzAp6w
	 9oBagsr8/kjTyu9h+dwNZlYBU7kDi5Xni1letH8Ga01M1sMoficEi3+h9194ZsnY9n
	 MuNQimagi9t5n7bTdlIGRzcJLpKGpIaI+mK0OX8x+i+sFdP8wcYmCzkQGRscRMR+dm
	 gAzZYBBH4YK3JEhGiwHutp+o0Dv283JsVHw1bVXXGmB6Jti3tKh1Nr3DGQ7DJPnA9r
	 ybpRvYw36TrsvLIj8QwWzi4XQBwm0seQZWSGd7Fcha/rio17YPSqc9nImVR8JMJ4fm
	 8VfxCNmu4gLuQ==
Date: Wed, 26 Feb 2025 18:39:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
Message-ID: <20250226183913.3666973e@kernel.org>
In-Reply-To: <d26ea97a-1ef8-aee0-d9fb-7ba80ddcdcb0@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com>
	<20250220165401.6d9bfc8c@kernel.org>
	<c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
	<20250221144408.784cc642@kernel.org>
	<2a7ed528-ed5d-d995-f7fe-12e3319aba27@redhat.com>
	<d26ea97a-1ef8-aee0-d9fb-7ba80ddcdcb0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 20:14:43 +0100 (CET) Pablo Martin Medrano wrote:
> > On Fri, 21 Feb 2025, Jakub Kicinski wrote:
> > > Hm. Wouldn't we ideally specify the flow length in bytes? Instead of
> > > giving all machines 1 sec, ask to transfer ${TDB number of bytes} and
> > > on fast machines it will complete in 1 sec, on slower machines take
> > > longer but have a good chance of still growing the windows?
> 
> Testing in my development machine, the equivalent to 1 second worth of
> packages is around 1000000000, changing -l 1 to -l -1000000000 resulted
> in the same time and the same test behaviour.

Seems like a lot! If I'm looking right it's 1G. Could you try 128M?

> To force the failure I generate load using stress-ng --sock <n> with
> increasing values of n. The values for n needed for the test to fail are
> higher with the 'fixed number of packages' approach.
> 
> Testing in the original 'slow system' it increases the time of each
> iteration to about 10 seconds, and it does not fail in the same
> circumstances.
> 
> But I have some concerns about this approach instead of the xfail on
> slow:
> 
> - If I generate load in the slow system, the "number of packages"
>   approach also fails, so it is not clear how many packages to set.

I wouldn't worry too much about testing overloaded systems.

> - The test maybe slower in slower systems where it previously worked
>   fine.

I think that's still preferable than effectively ignoring failures?

> - The generation of packages and the time for the tcp window to adapt
>   increase linearly? Isn't there the possibility that in future _faster_
>   systems the test fails because the netperf session goes too fast?

I don't know this test well but I think it tries to hit a big TSO
packet, of fixed size. So the difficulty of that will only go down
with the system speed.

