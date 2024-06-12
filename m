Return-Path: <netdev+bounces-102991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE540905E31
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DAB21532
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D950A80;
	Wed, 12 Jun 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FirdQbVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920FA34
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229632; cv=none; b=bg7WE8rreVyIxADcEdH0ZHaeiRp+PtSYjgSnaf9bHmPxZsgZ6/8xYtUAe/croJrv6ekyT86wtRpkyBvEl+GGSyyKfF/+Vh4Z8qXv31Q8i/Kem71Ubb95zSGzkb10Cl9vDcEG2D+iIKdvRchK/Up8FASmVYpXzTgcJP0DOYvCdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229632; c=relaxed/simple;
	bh=8tkDbPZYr6D9XgpIMaTqID1yfezPjjI7bc2oTqnoBQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rKeXhvgnTgB+A56ATD7efikakj8L0sdfNn/E1OGJVs7KPrV7X+akOwdQbEzKc9KP3av9yZeJRzrUQAKVQxo9+P6pejlNYoEz4ypniUiy6VIQMXCthu+MjgGGPMtBv4tiJrKyZ4w5sExit9fc7H6k1v4Z1HWmRL6ueGQM2OAvsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FirdQbVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D49ACC32786;
	Wed, 12 Jun 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718229630;
	bh=8tkDbPZYr6D9XgpIMaTqID1yfezPjjI7bc2oTqnoBQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FirdQbVcayj6x/NIfeDzOBpm5W/KzR5LKTDLB1ltDupKx54SjroaqtoTXRPPSKD2k
	 LEzbNR3yTF9WENds/DW0s1As1P0oZrziTFQkx3mBKdAVD5HxkFN0WMtMh0fe940kwp
	 Opad0PxOjDhYlHmOTQjRMAyPXZPtnTuzKVAbn6ENK30k/lnjLKViVWotS84KRmM5Lc
	 tRb++PGIEhdGk5adWCxFaEJQO1hJCVqTpLiXJ7J+1cyVCOeCSdEiuiQDe5bFTkCbk0
	 te36PA9zaopYVSiSbntuTirxL7+jHOCYSDjjxjkZqppOpmVarg1tUR4u742ReanNbC
	 qxhW2M0XZg9eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C29C0C43616;
	Wed, 12 Jun 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: flow dissector: allow explicit passing
 of netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171822963079.31898.17243541144080148140.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 22:00:30 +0000
References: <20240608221057.16070-1-fw@strlen.de>
In-Reply-To: <20240608221057.16070-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pablo@netfilter.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Jun 2024 00:10:38 +0200 you wrote:
> Change since last version:
>  fix kdoc comment warning reported by kbuild robot, no other changes,
>  thus retaining RvB tags from Eric and Willem.
>  v1: https://lore.kernel.org/netdev/20240607083205.3000-1-fw@strlen.de/
> 
> Years ago flow dissector gained ability to delegate flow dissection
> to a bpf program, scoped per netns.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: add and use skb_get_hash_net
    https://git.kernel.org/netdev/net-next/c/b975d3ee5962
  - [net-next,v2,2/2] net: add and use __skb_get_hash_symmetric_net
    https://git.kernel.org/netdev/net-next/c/d1dab4f71d37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



