Return-Path: <netdev+bounces-192144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBCABEA36
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA137AF2BC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395222C355;
	Wed, 21 May 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY44Mlvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39225221DB9
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797012; cv=none; b=Ll4vSRXL8UgTnzYPQXdG2srvDxRKO38J8UyYnqhYmQzjZjyrs576EEnlxERzQhCGdWJ3obyDFNXvcqNFcyrkqHrOGu6xQll8q5koDxIMLmo0gJyNtvPk7g3IKOKKtMsNiz4zrFnnjoV3oVbk4E7nDZgUYmY4rlk5ZWXRaXz2AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797012; c=relaxed/simple;
	bh=33+WmoEU7h7lPC8fRGjHXqTnc7VV4IV1C6jZUepaItg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cw3q9B5e3KONB0HRNO8VTUr9zA4CuZX2XlRjb3oUDnqMGT2gGqJAHx5P5/mOJblXOntpb81tJZ2+xc4+VuwioLrXiT+KD8psY5foR6WEIp2InExrTU0yjN+frAE/G4BcESbm9ea/qShzBJnf9lC3aagFcWOqXTjBBxQOE0u4ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY44Mlvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979D5C4CEE9;
	Wed, 21 May 2025 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747797011;
	bh=33+WmoEU7h7lPC8fRGjHXqTnc7VV4IV1C6jZUepaItg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dY44MlviCkMxExFJc9FznJeSWqKd3fa6YZNJyRDz6BTWY8zqbmwymlq5Abl//mF14
	 6hhe06V38XbBjiQiuZ1qT6NknifQqRMp3uQqe/5AfzALVMGlFVfzsongWgv3dX426J
	 LMv41bgbbwzIWlp/l7r9GWcc5FLgf0NDjcCsNXpfHH1eTUuL3hF7n8O9F/rzaA8YS8
	 uhDDb7YXYwWgEaN8xqIkV3Ykh5r6fJr42QHRkKWKvorAKCJxRF3e3YEBSuCWS4tTTU
	 8Jd/xLscvHfVWNDHUJ2aC1ZBxwzz97jWlLTYmhjODN4uB+k16UTqFW5U+ACTKD56Py
	 0mahHSVW9R1Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC69380CEEF;
	Wed, 21 May 2025 03:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/7] ipv6: Follow up for RTNL-free RTM_NEWROUTE
 series.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779704723.1552321.11898808693711363948.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 03:10:47 +0000
References: <20250516022759.44392-1-kuniyu@amazon.com>
In-Reply-To: <20250516022759.44392-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 19:27:16 -0700 you wrote:
> Patch 1 removes rcu_read_lock() in fib6_get_table().
> Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
>  was short-term fix and is no longer used.
> Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
> Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.
> 
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/7] ipv6: Remove rcu_read_lock() in fib6_get_table().
    https://git.kernel.org/netdev/net-next/c/f1a8d107d91d
  - [v2,net-next,2/7] inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
    https://git.kernel.org/netdev/net-next/c/f0a56c17e64b
  - [v2,net-next,3/7] ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
    https://git.kernel.org/netdev/net-next/c/8e5f1bb81274
  - [v2,net-next,4/7] Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
    https://git.kernel.org/netdev/net-next/c/cefe6e131cc4
  - [v2,net-next,5/7] Revert "ipv6: Factorise ip6_route_multipath_add()."
    https://git.kernel.org/netdev/net-next/c/5e4a8cc7beb8
  - [v2,net-next,6/7] ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
    https://git.kernel.org/netdev/net-next/c/d465bd07d16e
  - [v2,net-next,7/7] ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
    https://git.kernel.org/netdev/net-next/c/002dba13c824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



