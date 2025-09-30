Return-Path: <netdev+bounces-227240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5ABAADB2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A33E179A43
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B02A8C1;
	Tue, 30 Sep 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA+Ow+JK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBF10785
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195250; cv=none; b=NRCEpNFwFN4br8q4IYv7hGBNRbZoSioQi/K4jb06qX3hd3gbY5g8KxWmDz1mYYPmgMDXPYKjJOUylkNTAtwBLABVeNuXkqm6gVLQW6V2Hdey39dpa6cjYK9L/IKPGjyshGI8mneEuEc0cS/d7AMZ9hUtOrlgN00pr1LLP+jt4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195250; c=relaxed/simple;
	bh=cKBaJIAcN6T1kUaIMUR+S1WQ/Qur8HurlBeaW8c51dQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPWw0WztHslTqtorb+01Ef1LNpFnkPCev4EDXhTz6nI9nuVlStuUVet1wgBu+YDp5zGrrvUC75UBn4UB1HOiZUFPdhuVJQjqMT3Nx9zMjZWg8aoDpvfriKawnNiGPnETpsdEspp5c+4VbVH1fO8MOiKV6nryiZ4f8KF6RJ8lw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA+Ow+JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516C9C4CEF4;
	Tue, 30 Sep 2025 01:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195250;
	bh=cKBaJIAcN6T1kUaIMUR+S1WQ/Qur8HurlBeaW8c51dQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tA+Ow+JK8eEBM9kp1g6/OX3WjBbxZm21LLmF1RoatGkKIgc+XYycSNzayZzKH45ZU
	 jMBE1YNtcvZtS6T0skpGdPVwnk+KQWi4AxZFzu8zvauSE3zR5o7RjuIvmE7l730ByN
	 /A7DFBRozqPG3E0saUw3MbyE5JrbxZ5LrUjucv9YcgdUM/693Nye8FXG3DEwGv2/Ox
	 aP5YOJtJ+cqatxHQVaKKdO7AZV6Df/rPRkGUOmHDRAAUcd5F34/ufLa+4qEhX+iWRK
	 HWyK5NnwsRyqHKCUog4yLTb1nPMvKsXsG1O106dYrqQIUbUHxF3G++mzHkeSFNtcqY
	 M2aSYNTBTjxZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2A39D0C1A;
	Tue, 30 Sep 2025 01:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] net: wangxun: support to configure RSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919524349.1775912.1062421533630070266.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:43 +0000
References: <20250926023843.34340-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250926023843.34340-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aleksander.lobakin@intel.com, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Sep 2025 10:38:39 +0800 you wrote:
> Implement ethtool ops for RSS configuration, and support multiple RSS
> for multiple pools.
> 
> Kselftest output:
> ---
> TAP version 13
> 1..12
> ok 1 rss_api.test_rxfh_nl_set_fail
> ok 2 rss_api.test_rxfh_nl_set_indir
> not ok 3 rss_api.test_rxfh_nl_set_indir_ctx
> ok 4 rss_api.test_rxfh_indir_ntf
> not ok 5 rss_api.test_rxfh_indir_ctx_ntf
> ok 6 rss_api.test_rxfh_nl_set_key
> ok 7 rss_api.test_rxfh_fields
> not ok 8 rss_api.test_rxfh_fields_set
> not ok 9 rss_api.test_rxfh_fields_set_xfrm
> ok 10 rss_api.test_rxfh_fields_ntf
> not ok 11 rss_api.test_rss_ctx_add
> not ok 12 rss_api.test_rss_ctx_ntf
> # Totals: pass:6 fail:6 xfail:0 xpass:0 skip:0 error:0
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] net: libwx: support separate RSS configuration for every pool
    https://git.kernel.org/netdev/net-next/c/1be6db049799
  - [net-next,v6,2/4] net: libwx: move rss_field to struct wx
    https://git.kernel.org/netdev/net-next/c/58f244b25688
  - [net-next,v6,3/4] net: wangxun: add RSS reta and rxfh fields support
    https://git.kernel.org/netdev/net-next/c/2556f80a6abc
  - [net-next,v6,4/4] net: libwx: restrict change user-set RSS configuration
    https://git.kernel.org/netdev/net-next/c/2a251b85ce91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



