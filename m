Return-Path: <netdev+bounces-91489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA78B2D2F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 00:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647971F2235D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089656CDC1;
	Thu, 25 Apr 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suQptEpZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61022599
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084831; cv=none; b=IK0wGIQq9bLUbb3W2TckJng9dckZXl/oOyR5Tuxm/hjNIhgTnqnYHdWufxq2BKVedki0flYicjdVuHQ6CW1MBTkQpT2Pc/13ZhK6i4ayVCXVIoFbvG+4r3/4elhKQoPnFLWwb5G1epCTtIadn3kIHxi3XnaHp+HXplIBIEcN92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084831; c=relaxed/simple;
	bh=Yy5iYpXK6C+III7zx8oWJ8sUBUqte1EM5YRdbaU3/C0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UP+k8tBtbNwXIeM8OcPfDlVek9PBelSgq7V1UADfmghAx9smy/2qjuYWxyrLpwf0m3QFUgaqTiFwrMYGNGRzf4yjql3sSzFeuyk5cf+OZoeJU2Ixdc5Y5Jzv98n845XKq+36e8zyBBMdXc/u5Wfy36QRlRgVIn19EGYhBnkAsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suQptEpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E15C2BBFC;
	Thu, 25 Apr 2024 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714084831;
	bh=Yy5iYpXK6C+III7zx8oWJ8sUBUqte1EM5YRdbaU3/C0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suQptEpZX4lR17/PAwBKp710V7NpCX9LxSCpDpw03e9Uetblua594f5UaAR71Bdqi
	 h2tgDQGCEnhOVbPGn6L7CeyWviU9NPlH3xJAa47JjW9GmUYdrs609HvmI4kpIR9Qxn
	 v+sGJWT0qnP8ChGidoZGbujDLkoXlDaRaa1x4p15KArMpY6FbW1ZwANDnUmyyIXk9M
	 dJfe5WsZfFGUwl4QKQ9cN2VKqrLtKgIZQazaZIYeN8+K7ZxS/dKU4M3Pck00ONb0NG
	 2uzs9Yd3dgLxuE1/CKlncEX6FrkBuy7nJnnOTvGXuPzu6thhGoxAJiwfxh+4/+kSrg
	 TzESlF45cCiWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4213FC595C5;
	Thu, 25 Apr 2024 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add two more call_rcu_hurry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171408483126.30037.2645129333935579072.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 22:40:31 +0000
References: <20240423205408.39632-1-edumazet@google.com>
In-Reply-To: <20240423205408.39632-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 joel@joelfernandes.org, paulmck@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 20:54:08 +0000 you wrote:
> I had failures with pmtu.sh selftests lately,
> with netns dismantles firing ref_tracking alerts [1].
> 
> After much debugging, I found that some queued
> rcu callbacks were delayed by minutes, because
> of CONFIG_RCU_LAZY=y option.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add two more call_rcu_hurry()
    https://git.kernel.org/netdev/net-next/c/c4e86b4363ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



