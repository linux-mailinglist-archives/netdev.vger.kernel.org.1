Return-Path: <netdev+bounces-180471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BFA81647
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C82B4C32D4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B952417D4;
	Tue,  8 Apr 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYm7jurA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF823ED56
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142880; cv=none; b=gYqn31VrqNXBF75UzYG3ezZiQJoMfgsdcqfnZAmKCu77OG7UUZ/1m1piVXz2pL3k9fNz9deSRMlCyvNmS6iUjYRtUQHywPOgz/YkMx0909wk5BsynRwaD0vWo92vuKuIRoHUCPdsQhXjwFuLBjBLUovCl0n36yjx82BuCfHqkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142880; c=relaxed/simple;
	bh=BqjZhChsfu3nhDBN/EGusiViXUFVIAwCvDCBN0FMt3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ss0OGeY59zhMGMIzpXUKIPKVuPyggOE2dm57O6Vq+zMxdz3NK5mwIhUbzXnMOiP1ugw5wHxlkjXYOoF8I6+0+7njNrAdp000rlXEmQotyii7YeWnv2BHP2Ca25KXSYkJFa4sV0PdxKNkl5UMLNGBkgolcObjc3g7jAxfzHrOOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYm7jurA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6951C4CEE5;
	Tue,  8 Apr 2025 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142879;
	bh=BqjZhChsfu3nhDBN/EGusiViXUFVIAwCvDCBN0FMt3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYm7jurALzrUfAKstswiqh1pLs5LnN1GJlMQUj/+5ivpetibbeRv5HyF5IoTFp8On
	 O8KcWU6D2YNimBOghPS+r5EEMwR3rP7XayRuCjEdyMxhfQ2vv/LBCNpXhAWray2IVo
	 eW0vVe8hPPm/3rqgUaZW9Hne7uQKVlFt7gxkiVRjKSMUFK2lrUWPljgOs7U99usu1h
	 k/7r/lC70yYhCuorgW0Sg8ShMFJ+HH8TE3DLoec9CvnfxQad51TxA8LoBaDycdOIbQ
	 OXueAoYUcs1AgurkpbbhRGQN4IKsmebwtGxEH8dxJUEmMGhWK1cAZ5eCKOdKECO4Xd
	 9Hn2EhvTidNTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716C238111D4;
	Tue,  8 Apr 2025 20:08:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] rps: misc changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174414291729.2113367.8617608333010956990.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 20:08:37 +0000
References: <20250407163602.170356-1-edumazet@google.com>
In-Reply-To: <20250407163602.170356-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Apr 2025 16:35:58 +0000 you wrote:
> Minor changes in rps:
> 
> skb_flow_limit() is probably unused these days,
> and data-races are quite theoretical.
> 
> Eric Dumazet (4):
>   net: rps: change skb_flow_limit() hash function
>   net: rps: annotate data-races around (struct sd_flow_limit)->count
>   net: add data-race annotations in softnet_seq_show()
>   net: rps: remove kfree_rcu_mightsleep() use
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: rps: change skb_flow_limit() hash function
    https://git.kernel.org/netdev/net-next/c/c3025e94daa9
  - [net-next,2/4] net: rps: annotate data-races around (struct sd_flow_limit)->count
    https://git.kernel.org/netdev/net-next/c/7b6f0a852da3
  - [net-next,3/4] net: add data-race annotations in softnet_seq_show()
    https://git.kernel.org/netdev/net-next/c/22d046a778e4
  - [net-next,4/4] net: rps: remove kfree_rcu_mightsleep() use
    https://git.kernel.org/netdev/net-next/c/0a7de4a8f898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



