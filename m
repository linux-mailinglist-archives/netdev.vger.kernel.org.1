Return-Path: <netdev+bounces-102784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B0904942
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 05:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45610B23235
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973A3612D;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxOXp9+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AF2E414
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161238; cv=none; b=jZunk8sesmUJur0OaW28/XNP/dvTEnMfD+op7iOAcNAHf1HB8hw6d5Lh7BjDRVtj0JegK9jZHkiqNlAj/p4dXI/79J5jHGuRfqnwo7akCaP7Dsa/1JAO8zToFYdFkRwroCuteRTI293Tikd3ggjDsBh4+2MMiA+/XE7vjJKgDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161238; c=relaxed/simple;
	bh=PDRdxTetbqY13GvpNXoNeNoUL91m9DT4VDzEHyOT64Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hss+iz000ZVXwLiNmjsHpU3L6PsTWPC23kie5GMGzANFGX4bhWftdYgu7chNDJ9n3a5xRcVOd8o6WOVZ4mSPJbcg/n/gcIFdeBWt2PA2oo9UpbpGHWdet0ZvpXQG4hvA1KHLWBsF5w1LDxds87vhh2h6JiqtNZGlaS6uR6cqrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxOXp9+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D4D3C4AF1C;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161238;
	bh=PDRdxTetbqY13GvpNXoNeNoUL91m9DT4VDzEHyOT64Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HxOXp9+zlQMaZ+1y39bDM694p4q3WHHCxrrBUlF1fuufOyMtAxJrE+EqMwZV0bWfH
	 jn64RP2EJo6OBJhuIwfegHM4TDvfj0M/3OpGMbFqxjGEPsVaC8pzyX11C81NIJv/sw
	 0ZXDQvNcMooW0qFY3LyVBEZuYCc05KdLR8DDgoUA0vNSuInk3ZGoUjP7vcpqTut2++
	 Wv8uEsOterlB90WLjtUrmxkk2ot7JlpEf0P+U3MQfGIEQoVPS/PzlvqL3X3JPkl/ph
	 lP/qE3GJtn1I7el8U6EZ/InjmOEKv3Zv0Cl8wkAmWJMelebQr2e17fc2BdQLIoWgNU
	 ijr8FtOJ9G2IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E9F7C43614;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: core: Unify dstats with tstats and
 lstats, implement generic dstats collection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816123844.11889.2514477223763333882.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 03:00:38 +0000
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
In-Reply-To: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Jun 2024 18:25:23 +0800 you wrote:
> The struct pcpu_dstats ("dstats") has a few variations from the other
> two stats types (struct pcpu_sw_netstats and struct pcpu_lstats), and
> doesn't have generic helpers for collecting the per-cpu stats into a
> struct rtnl_link_stats64.
> 
> This change unifies dstats with the other types, adds a collection
> implementation to the core, and updates the single driver (vrf) to use
> this generic implementation.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: core,vrf: Change pcpu_dstat fields to u64_stats_t
    https://git.kernel.org/netdev/net-next/c/fa59dc2f6fc6
  - [net-next,v3,2/3] net: core: Implement dstats-type stats collections
    https://git.kernel.org/netdev/net-next/c/94b601bc4f85
  - [net-next,v3,3/3] net: vrf: move to generic dstat helpers
    https://git.kernel.org/netdev/net-next/c/2202576d4631

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



