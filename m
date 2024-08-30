Return-Path: <netdev+bounces-123805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCD96690C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5031C238BA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0AA1BC9ED;
	Fri, 30 Aug 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfOLEil3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17E1BC9E1
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043229; cv=none; b=EyfFPX6q3m/har2LgTaqkTN47whYGzTVJCV8Bd3Loq+30MSjmFRsTy2/MP5/5Sjk2Zib/oHYnkj1q/+1tDw8DV0RCG7UiRQxKUBRPznRkGjQjA/fch5D0Cz6Q/Zga/pUs2whmX4jouiteEyLqCymxIzkqfU3zY3aDjOQsH7SdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043229; c=relaxed/simple;
	bh=DIdCsAjMGbaZ3f82y7lX5HLcyyCqED/BZq0Xdamlwrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PztS7CUe4lPU5xtshtXjapYM8Tu6Prz98QURrQkGpj6n6cRsrhlnXU4GwSQp4QoC83WXUik15tP2IBJbw0SRRI6q7CV0hDh+v7BUVBH6ioS53TnWS8qhWytkkx6UydjViMtZ2r9PsxnbafJ0tQlQnsYrIG6RZB5AGlGOBE8LPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfOLEil3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E2EC4CEC4;
	Fri, 30 Aug 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043228;
	bh=DIdCsAjMGbaZ3f82y7lX5HLcyyCqED/BZq0Xdamlwrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YfOLEil32AtThy51yLmlRwlI6IqOzxjlYHKhAFXOPg2Bjtd/6gFLF7vke6qOEM76c
	 mRxKWteApNRHoxv+0i+ZVennAn45TM9H3xClBNNpojwxZiVUAJXTpKJb1Bf581dTR6
	 P9o1cCddSs02BL2j8qt/6+WlKX2ys3ZLHOaiX4+QGHZbtXvAGlI1Z49fFump6igVos
	 pSAlfPqzQe7790gs/V09qC5oDzDZHgG8Kpm2Tn3nstYdpnEIDc5rbch7navmbL1MmZ
	 RGJSqK7l7CNxjCEcOfHdC0UiNdUG67ol8e3ooeZG8yIZpABfkYrJLt+utwHRlxFv2u
	 cJ27KaVIsgafA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 669BB3809A81;
	Fri, 30 Aug 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3]  icmp: avoid possible side-channels attacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504323041.2682525.16725338216073545525.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:40:30 +0000
References: <20240829144641.3880376-1-edumazet@google.com>
In-Reply-To: <20240829144641.3880376-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, w@1wt.eu, keyu.man@email.ucr.edu, hawk@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 14:46:38 +0000 you wrote:
> Keyu Man reminded us that linux ICMP rate limiting was still allowing
> side-channels attacks.
> 
> Quoting the fine document [1]:
> 
> 4.4 Private Source Port Scan Method
> ...
>  We can then use the same global ICMP rate limit as a side
>  channel to infer if such an ICMP message has been triggered. At
>  first glance, this method can work but at a low speed of one port
>  per second, due to the per-IP rate limit on ICMP messages.
>  Surprisingly, after we analyze the source code of the ICMP rate
>  limit implementation, we find that the global rate limit is checked
>  prior to the per-IP rate limit. This means that even if the per-IP
>  rate limit may eventually determine that no ICMP reply should be
>  sent, a packet is still subjected to the global rate limit check and one
>  token is deducted. Ironically, such a decision is consciously made
>  by Linux developers to avoid invoking the expensive check of the
>  per-IP rate limit [ 22], involving a search process to locate the per-IP
>  data structure.
>  This effectively means that the per-IP rate limit can be disre-
>  garded for the purpose of our side channel based scan, as it only
>  determines if the final ICMP reply is generated but has nothing to
>  do with the global rate limit counter decrement. As a result, we can
>  continue to use roughly the same scan method as efficient as before,
>  achieving 1,000 ports per second
> ...
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] icmp: change the order of rate limits
    https://git.kernel.org/netdev/net-next/c/8c2bd38b95f7
  - [v2,net-next,2/3] icmp: move icmp_global.credit and icmp_global.stamp to per netns storage
    https://git.kernel.org/netdev/net-next/c/b056b4cd9178
  - [v2,net-next,3/3] icmp: icmp_msgs_per_sec and icmp_msgs_burst sysctls become per netns
    https://git.kernel.org/netdev/net-next/c/f17bf505ff89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



