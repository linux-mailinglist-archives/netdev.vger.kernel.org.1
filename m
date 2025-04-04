Return-Path: <netdev+bounces-179326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F376BA7BFE8
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C221D189C054
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8541B043E;
	Fri,  4 Apr 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skqEiIyR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D631624C9
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778180; cv=none; b=t1SNOCSfGDNWjQ6vBsxvdba1OPTwRO6oBwXfrEThTyQOYznAu9UfQbvJr0y9I02Tz64zTB8/EZXZE5x+5hTxoucr7Zcakj9upvUAxR3ox3jCKpKMq8JGvtrgfrVzEHqGMUp6d7Qi4vIP6UsCqGopmBwbeiK2fP5qw65DWEQnGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778180; c=relaxed/simple;
	bh=LJ2o2wUMs9OMeqy7PKgjwsrzltLbYiPy8WwR292x8Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeUMZnASNJSGQWwFe9GJImdN8OM4EDcjCgDPEInUJ6su/ANBrXr7646XRv7w22eH7DVPjjDQh2BzJRgaDm+nSEvkq12YNJ/QW5AS/dgYmq3ZyOcfn73hynhLpACl9bxgEvK3K3BucaujbvJbh35Fwk3TXLEiT026ezK1Xpfav5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skqEiIyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBFBC4CEDD;
	Fri,  4 Apr 2025 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778180;
	bh=LJ2o2wUMs9OMeqy7PKgjwsrzltLbYiPy8WwR292x8Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skqEiIyR903VGNG+eHuxqeL0yPq6rGYtZbf0ifns5QgpR4ya95FrnpcxgM2AD/uYw
	 OWp7jFOP4T8t2h3pvuRUnqIyo6PSCkgdZd7RUwtVDiTwIf+tgQyitJ5hA//L/AaZLw
	 dQmc7KZki49umGdi/0YcaEOcG8eNaWv2i+6E5zcDO40VzvhP2zIBP4fsiAquZdpI0O
	 C3cNcArnbRfe91HgDp9jlWEc/yeEDgLJ2i2H0J+VDYv5wRXV3nrV3+uxfGIRbsdT/v
	 K0bI9Sk0fT4oZrOOxr0rKMkY8/DvmmRjp8U/i+mbPJS5vYLOR1fJhk6oBK0rUabw1n
	 LO+QtKEidmohw==
Date: Fri, 4 Apr 2025 07:49:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 gnault@redhat.com, stfomichev@gmail.com
Subject: Re: [PATCH net 0/2] ipv6: Multipath routing fixes
Message-ID: <20250404074938.218ac944@kernel.org>
In-Reply-To: <174377763303.3283451.9282505899516359075.git-patchwork-notify@kernel.org>
References: <20250402114224.293392-1-idosch@nvidia.com>
	<174377763303.3283451.9282505899516359075.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Apr 2025 14:40:33 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Wed, 2 Apr 2025 14:42:22 +0300 you wrote:
> > This patchset contains two fixes for IPv6 multipath routing. See the
> > commit messages for more details.
> > 
> > Ido Schimmel (2):
> >   ipv6: Start path selection from the first nexthop
> >   ipv6: Do not consider link down nexthops in path selection
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [net,1/2] ipv6: Start path selection from the first nexthop
>     https://git.kernel.org/netdev/net/c/4d0ab3a6885e
>   - [net,2/2] ipv6: Do not consider link down nexthops in path selection
>     https://git.kernel.org/netdev/net/c/8b8e0dd35716
> 
> You are awesome, thank you!

Ugh, rushed this it seems.
Sorry, Willem.

