Return-Path: <netdev+bounces-42079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD87CD16C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173FE28146E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F1193;
	Wed, 18 Oct 2023 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLGJs1jl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA94630
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A18B5C433C9;
	Wed, 18 Oct 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697589622;
	bh=oSQbRF4OP4QhhdUhVVIYIq7V/k8xhzaHn6bU0DsDZnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fLGJs1jl4LRgfIV4pJ6LCmRSJWrKul1B7VItLK6s0rWMPTrQqebf4VzfU+zZWBkoT
	 7IW+cdOSvs47HP/T8mI8kCLfQDD6KV2pR2RSfy4pF9fG07vOglsS+SO3RFqGTmE5vg
	 CLCKv6NglE80WyUtTyNZnQ/Qe1m9I7ZPuafDcdhXKOOYaDf4SXzJJ4qowaeENGgXKY
	 /0HzP+pAMtjPmDXQJ1OgxGlW3tqeqlowlWF99OeZ/jHLcoaGmrX0Oi0X8u4b8auvOq
	 dYZLbTPJDsdTDFLmFzKEiXND0qEHo/XpmuBTwzaM28MlfTtF36gHTZ+wZs4jJTXHNQ
	 GapvZmQPpHbiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87233C04E24;
	Wed, 18 Oct 2023 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix excessive TLP and RACK timeouts from HZ rounding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169758962254.9987.492571478078988197.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 00:40:22 +0000
References: <20231015174700.2206872-1-ncardwell.sw@gmail.com>
In-Reply-To: <20231015174700.2206872-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Oct 2023 13:47:00 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> We discovered from packet traces of slow loss recovery on kernels with
> the default HZ=250 setting (and min_rtt < 1ms) that after reordering,
> when receiving a SACKed sequence range, the RACK reordering timer was
> firing after about 16ms rather than the desired value of roughly
> min_rtt/4 + 2ms. The problem is largely due to the RACK reorder timer
> calculation adding in TCP_TIMEOUT_MIN, which is 2 jiffies. On kernels
> with HZ=250, this is 2*4ms = 8ms. The TLP timer calculation has the
> exact same issue.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix excessive TLP and RACK timeouts from HZ rounding
    https://git.kernel.org/netdev/net/c/1c2709cfff1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



