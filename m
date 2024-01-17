Return-Path: <netdev+bounces-63888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22D82FEAE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D180B26AD8
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD41C05;
	Wed, 17 Jan 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3iz3ywp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9587491
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456825; cv=none; b=IJSalWOClgIeKCI0/0fwKPH1T7pxz1/gkuazNKCRR0WFSAP3FyyofWtvuU4INEspczeDMD86qyshjBtBmXoW+h/05onIeddURlFIrbOEFGYhQmyoJ6rjHZE/n55YCRcQBx64ra8Fmz8CMnuRJVD0jSjcUdp+Kia7EVLEypJmwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456825; c=relaxed/simple;
	bh=txRq6YANOsTkSmngmhXwTpwHW0RobWuxiEOpBu7fick=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VB5byygRQHQUm72vyI1Dz2YJiEQtPheOHJd1Q9Dhnjmnk+++3bkBa8OE0HPeGY6EquNT7MQAyflp+twjHfzvbV9mYLMVADifp+bgq5NOuuGkiVcqprZ3QyNzb7bXfjarmP9aiKnkXqLhNPlW9R8VjWnTp/T/iv+45IcqVa48WjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3iz3ywp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79716C433C7;
	Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705456824;
	bh=txRq6YANOsTkSmngmhXwTpwHW0RobWuxiEOpBu7fick=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3iz3ywpCQeLvQGN9G5DzvDyivFlxAtRsKF6e/VXPm2MQmvK53qVbanzN2PVWtE6M
	 3ZYfpcjJh6aAEaNL5n47uirJItRz+8EfdqzwNwN/LXEMOhO5+Ckgf0qn0RT0wpYC12
	 2Gx6YcO7OZduk8gCiamVSfwQjBliLLflrcdNoktqrtkP8mWHvndCXadfglXBG0q0gm
	 8mowwWuEtVC06w5Zmmfvh1vNAVZB2C+xHK2oXcRv22u3hy9hiwy1BTl3SawsJZMYry
	 uJgZfz1djlJ4kGnJcIP/zkQlYir093xk62gAi2L7bwzu16CUMeW2MbUHmtD2ckrGA5
	 LJTXL+44BZf0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 582A0D8C985;
	Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rtnetlink: use setup_ns in bonding test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170545682435.28743.16266298970149259484.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 02:00:24 +0000
References: <20240115135922.3662648-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240115135922.3662648-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, phil@nwl.cc, dsahern@kernel.org, jiri@resnulli.us,
 liuhangbin@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jan 2024 14:59:22 +0100 you wrote:
> This is a follow-up of commit a159cbe81d3b ("selftests: rtnetlink: check
> enslaving iface in a bond") after the merge of net-next into net.
> 
> The goal is to follow the new convention,
> see commit d3b6b1116127 ("selftests/net: convert rtnetlink.sh to run it in
> unique namespace") for more details.
> 
> [...]

Here is the summary with links:
  - [net] selftests: rtnetlink: use setup_ns in bonding test
    https://git.kernel.org/netdev/net/c/e9ce7ededf14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



