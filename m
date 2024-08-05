Return-Path: <netdev+bounces-115921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3C948665
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C9D1C2229F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013616F84A;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVCqiGxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2316EC0B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902057; cv=none; b=VNhgShJoiV5BN+nz9aTUG4HucmS5cXWKwxd454U60hUzixTbkbHLvhFp9g2/TECcs7b2wI0zKX01wsZRO4R0XHCi0rmf9QqUyNp1jH81kHsxwcAcWp0nIeQrQLtxBjEnk0Sml9ZoQjQ9v6nNtdTdnyipkzYWplzYMLyptr+t+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902057; c=relaxed/simple;
	bh=dvH6/QudHLzD5qiK/eFsE9fqoFYLkJMF9CXnIXjBJew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dn/960efmZu+TFz+TRsSxLjEwXLhiFHJxZ2fsoULo2fuZoo6XiXxRodfc3P/dLOFLNXnrXcYkWjATWZ31StdnktVNdGj3+6m4XK9qUd0P2UUty4UGLKs6qopqJz4ly4/vjF6LE17L7+aak2mseySexpD2fP3N+PdqE2GLjr864E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVCqiGxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36565C4AF0E;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902057;
	bh=dvH6/QudHLzD5qiK/eFsE9fqoFYLkJMF9CXnIXjBJew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVCqiGxAh3hkMdUJ4cq0dcwCGR3cX49hzxJjhq5/zlM1MLuBw9OkxrwTuZDCZYDLk
	 6rnEuT78HIz2cgcueTnDYMW9w/6oOnkxLssqC834WDFbSqbMR0T4CJvD/mGUcJbwHi
	 woKXJgY47SuxDKOOx/4EazW3O87SiCgL8jNwWrNsuU8/CJ5lGq+EW3YDqXWZ6D+yyp
	 ZcJCIEtsi9OaXpCXKU8dE0FAlyYXnlGd3rqoEQKA/3mQBdBMTBVoNlC0w9CPZzQ70i
	 DBRW+fhu5tDVWmtxHiBVcqH5WPiCvrrKHsinTS0vttehcbB57QmJo0FMH5RVHAeY/3
	 S2AFHfsoF0/Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D110C43140;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: constify 'struct net' parameter of socket
 lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172290205718.12421.6044942659385972337.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:54:17 +0000
References: <20240802134029.3748005-1-edumazet@google.com>
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, tom@herbertland.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Aug 2024 13:40:24 +0000 you wrote:
> We should keep const qualifiers whenever possible.
> 
> This series should remove the need for Tom patch in :
> 
> Link: https://lore.kernel.org/netdev/20240731172332.683815-2-tom@herbertland.com/
> 
> Eric Dumazet (5):
>   inet: constify inet_sk_bound_dev_eq() net parameter
>   inet: constify 'struct net' parameter of various lookup helpers
>   udp: constify 'struct net' parameter of socket lookups
>   inet6: constify 'struct net' parameter of various lookup helpers
>   ipv6: udp: constify 'struct net' parameter of socket lookups
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] inet: constify inet_sk_bound_dev_eq() net parameter
    https://git.kernel.org/netdev/net-next/c/a2dc7bee4f77
  - [net-next,2/5] inet: constify 'struct net' parameter of various lookup helpers
    https://git.kernel.org/netdev/net-next/c/d4433e8b405a
  - [net-next,3/5] udp: constify 'struct net' parameter of socket lookups
    https://git.kernel.org/netdev/net-next/c/b9abcbb1239c
  - [net-next,4/5] inet6: constify 'struct net' parameter of various lookup helpers
    https://git.kernel.org/netdev/net-next/c/10b2a44ccb0c
  - [net-next,5/5] ipv6: udp: constify 'struct net' parameter of socket lookups
    https://git.kernel.org/netdev/net-next/c/87d973e8ddee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



