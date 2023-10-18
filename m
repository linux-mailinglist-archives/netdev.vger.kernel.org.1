Return-Path: <netdev+bounces-42189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B878D7CD905
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FD5281BC6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5B18B18;
	Wed, 18 Oct 2023 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNuXdEIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77215E8B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31682C433D9;
	Wed, 18 Oct 2023 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697624424;
	bh=abcaJaLEdDZuVGIJhG4m3B++7sbDPLq+MwLkRRMVbhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PNuXdEIv/pe1A6YHsEiDi5+5PJz8YVflFHYa1k+4JQzEjlLivmI2nJlfsc0jbLeuX
	 zZwBz8kziO92I05iAqEeudoz/CNq+94IoDNW8WczucMJKc3REAhgWzN5ala7yMzfiG
	 VGKLjloirYXW9Bj9NbhRfCFWWpPMiDG9bXT0qGrGnx6JwUBA04ErddYRx6agx6QtaE
	 TX2iFuR60HIwGte1naToK3cf60yoSLADjq20DS5KUosok2q2CZtcV48H94Ps7Gc17A
	 AB6bIp+VyQMXIQaFyseicpqDDnqba5LSyd/lIMA5+KqiemNIyXjLp7+QiVtaJ97HjI
	 MUWsg0rLftW5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F050C04E24;
	Wed, 18 Oct 2023 10:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] net: skb_find_text: Ignore patterns extending
 past 'to'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169762442412.8273.16759719638129839234.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 10:20:24 +0000
References: <20231017093906.26310-1-phil@nwl.cc>
In-Reply-To: <20231017093906.26310-1-phil@nwl.cc>
To: Phil Sutter <phil@nwl.cc>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, fw@strlen.de, pablo@netfilter.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Oct 2023 11:39:06 +0200 you wrote:
> Assume that caller's 'to' offset really represents an upper boundary for
> the pattern search, so patterns extending past this offset are to be
> rejected.
> 
> The old behaviour also was kind of inconsistent when it comes to
> fragmentation (or otherwise non-linear skbs): If the pattern started in
> between 'to' and 'from' offsets but extended to the next fragment, it
> was not found if 'to' offset was still within the current fragment.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: skb_find_text: Ignore patterns extending past 'to'
    https://git.kernel.org/netdev/net-next/c/c4eee56e14fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



