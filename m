Return-Path: <netdev+bounces-91715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9B98B38AE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BDF1C235C5
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737E1F956;
	Fri, 26 Apr 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3CNOiYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07B147C68;
	Fri, 26 Apr 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138830; cv=none; b=gWdZUygZieKC8FoWbRz9VPtXslTpRq7AqwjEoxGmNGfG2rk3J5bcFYBXUiunZJP/CE82WZUSYFF8yjHLN8IHtOTgH5uXsa4LAe3igM79OPZWB62ose9AiBZjQq6iixOoNr15QixbUkzGHoI9TeGCAhjXph4S9TIRHC+qXsYQzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138830; c=relaxed/simple;
	bh=nhB4NXO7zHABhS8SCCe4ML2meuKkfAn6VxcxMgKGh/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UJ2ecDbs82FNq+wqVnpcYHqizdKX1iAh7VrsXxIZxYqVxrH1ksK7/MHwye2vTrbaHyH/AwaITJNrCHbzSe9cfTg7Ss+i6iELqFLmZfragveQEigLkr56GX5UlUDeJXMb3EaBSbUU035Yc77lhxMYXxuREey+lrjlRqOKXa8XdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3CNOiYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0982C116B1;
	Fri, 26 Apr 2024 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714138830;
	bh=nhB4NXO7zHABhS8SCCe4ML2meuKkfAn6VxcxMgKGh/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3CNOiYLwPHAd4497FuR8Mq8LAbLeZyEOOqX0MVFqC0Kv7xXrtNEG7hTQ8enkNsPH
	 iLS5LM46B34Oss/5gpz+NWY7QLTErT/xqToUJcwT4Jj7UYitoQxWLNBMkbnn8oKLzW
	 MCHm3rcksjbAPJbRNe2IAKLNh3SSyU3HNth1VaBkHkdC2F7EUz+oDKllDHwXGQWeAf
	 vmNd/LhWeu0Ob7VR7bCLKCfMd/AZUG6PMTfM+gjUNEtWMRVfR9GsH75RHERQUyKof9
	 PzS2qc/0nBSFj5csZ32YFITOQlhoIveyLzU4NEN9U650/U+ff/8Hd5/okM/B1r7YCs
	 awXXvE+XHu4/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD436DF3C9B;
	Fri, 26 Apr 2024 13:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/7] Implement reset reason mechanism to detect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171413882983.4140.2846723996331874537.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 13:40:29 +0000
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, atenart@kernel.org, horms@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Apr 2024 11:13:33 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In production, there are so many cases about why the RST skb is sent but
> we don't have a very convenient/fast method to detect the exact underlying
> reasons.
> 
> RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
> and active kind (like tcp_send_active_reset()). The former can be traced
> carefully 1) in TCP, with the help of drop reasons, which is based on
> Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
> RFC 8684. The latter is relatively independent, which should be
> implemented on our own, such as active reset reasons which can not be
> replace by skb drop reason or something like this.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/7] net: introduce rstreason to detect why the RST is sent
    https://git.kernel.org/netdev/net-next/c/5cb2cb3cb20c
  - [net-next,v9,2/7] rstreason: prepare for passive reset
    https://git.kernel.org/netdev/net-next/c/6be49deaa095
  - [net-next,v9,3/7] rstreason: prepare for active reset
    https://git.kernel.org/netdev/net-next/c/5691276b39da
  - [net-next,v9,4/7] tcp: support rstreason for passive reset
    https://git.kernel.org/netdev/net-next/c/120391ef9ca8
  - [net-next,v9,5/7] mptcp: support rstreason for passive reset
    https://git.kernel.org/netdev/net-next/c/3e140491dd80
  - [net-next,v9,6/7] mptcp: introducing a helper into active reset logic
    https://git.kernel.org/netdev/net-next/c/215d40248bde
  - [net-next,v9,7/7] rstreason: make it work in trace world
    https://git.kernel.org/netdev/net-next/c/b533fb9cf4f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



