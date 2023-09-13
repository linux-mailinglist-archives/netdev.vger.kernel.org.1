Return-Path: <netdev+bounces-33442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7B79DFEB
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1B281863
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807D15AE0;
	Wed, 13 Sep 2023 06:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40481C29
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46DEBC433C9;
	Wed, 13 Sep 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694586027;
	bh=rCiTY8NTWQIWgQZVKSBRrZ+ELWO1CETCVkk9PSjwHt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHqsdqq4u2qUGuDNEQSB+DLb92+LjFr/CaxYFN103ND2mFwn4mjiNirvrpn8aG8oG
	 PbWOGA1hTQ2oQ7Rh8vF+mdkNlnE4DGvUmp8E8ReMp90+ayDN+LYwqmmH2bYBhGUpBz
	 oVlHbk+MBLLyPFmuN6pDNAbLy6Hu1Upqkm+3oAnpl0+NeN5BMYMU/g3kcxgMNmjJfO
	 ZpUSPiIPv1cyWpApy0nLy08ePItfyqZYvdP6GUrRNMh3XlQyeEzRiEU5Oijx0V6ZOC
	 Qvet33ctJepAElzvICbw7uPeZXrtfEOC9tSzd7+y9EYHbNGD4FsuNhsYmInR+v1IJe
	 /npG4xKe04SFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BEBBE330A7;
	Wed, 13 Sep 2023 06:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/6] tcp: Fix bind() regression for v4-mapped-v6
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169458602717.26932.15402915651770766625.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 06:20:27 +0000
References: <20230911183700.60878-1-kuniyu@amazon.com>
In-Reply-To: <20230911183700.60878-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, joannelkoong@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 11:36:54 -0700 you wrote:
> Since bhash2 was introduced, bind() is broken in two cases related
> to v4-mapped-v6 address.
> 
> This series fixes the regression and adds test to cover the cases.
> 
> 
> Changes:
>   v2:
>     * Added patch 1 to factorise duplicated comparison (Eric Dumazet)
> 
> [...]

Here is the summary with links:
  - [v2,net,1/6] tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
    https://git.kernel.org/netdev/net/c/c6d277064b1d
  - [v2,net,2/6] tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
    https://git.kernel.org/netdev/net/c/aa99e5f87bd5
  - [v2,net,3/6] tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
    https://git.kernel.org/netdev/net/c/c48ef9c4aed3
  - [v2,net,4/6] selftest: tcp: Fix address length in bind_wildcard.c.
    https://git.kernel.org/netdev/net/c/0071d15517b4
  - [v2,net,5/6] selftest: tcp: Move expected_errno into each test case in bind_wildcard.c.
    https://git.kernel.org/netdev/net/c/2895d879dd41
  - [v2,net,6/6] selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.
    https://git.kernel.org/netdev/net/c/8637d8e8b653

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



