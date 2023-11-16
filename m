Return-Path: <netdev+bounces-48501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBF7EEA09
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B6C280EC9
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588B1EB3F;
	Thu, 16 Nov 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMH11yl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24E42C0B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0F93C433CD;
	Thu, 16 Nov 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700178024;
	bh=/P/4CC0wnVRZums8c53Xj1W78Fo8SQj3dLK+owiPa0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMH11yl0x56ro8rHlTZm7+8stIP7BgeMHpt3jFUlKTT4Me7WIH79NNRrLJr062xB1
	 B7DYvK0sl46MZRKAU8HQ0A0h93FjPtoHCmYpbGDmcD5m3FYElVKhODdw3MeQ6RltqO
	 XamUchu0yyV0F0zvLsYFgjvQdtvnVZMn5L6r5iOeqY9i44dVs7tXIwfjpXji55D5Qm
	 6o4duz5lkt2UYWesQpa174M/HIGS8NCiYvXHHkcAH5Rlr4PQLuusICVhaAsePz3C7Q
	 zG8TL8tz1oLTbWkwppczsth/gfYavkQ02YDhUdMrBRuf1SN0hSQ/Z65Wz9vVItGvUe
	 PdDPBosEadKdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC66BC395F0;
	Thu, 16 Nov 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: change reaction to ICMP messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017802483.19305.4105945454875753103.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 23:40:24 +0000
References: <20231114172341.1306769-1-edumazet@google.com>
In-Reply-To: <20231114172341.1306769-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, ycheng@google.com, morleyd@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 17:23:39 +0000 you wrote:
> ICMP[v6] messages received for a socket in TCP_SYN_SENT currently abort
> the connection attempt, in violation of standards.
> 
> This series changes our stack to adhere to RFC 6069 and RFC 1122 (4.2.3.9)
> 
> Eric Dumazet (2):
>   tcp: use tp->total_rto to track number of linear timeouts in SYN_SENT
>     state
>   tcp: no longer abort SYN_SENT when receiving some ICMP
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: use tp->total_rto to track number of linear timeouts in SYN_SENT state
    https://git.kernel.org/netdev/net-next/c/14dd92d0a117
  - [net-next,2/2] tcp: no longer abort SYN_SENT when receiving some ICMP
    https://git.kernel.org/netdev/net-next/c/0a8de364ff7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



