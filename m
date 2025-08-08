Return-Path: <netdev+bounces-212279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE4B1EE9A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11583B4A38
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C126560A;
	Fri,  8 Aug 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4a3Fg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A891361;
	Fri,  8 Aug 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679596; cv=none; b=FrOB8npA3Eo09LlgO26ht8lmzME3oFMeX3uHyYHMZxaLG4ciEWCUnM0IG9V0h9+6ySX5dPneAvnOtznDCasXGxb3fWUZAXguwCu4IdyDGoH/5zmRQQEtMlQa/ZZXO5vvFpe8QfHUcSufxtx3N0830YFRy3lmYxirIXYLCMMuwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679596; c=relaxed/simple;
	bh=rAxVSLUTQE9LbX6DT1fMVpo7DSeMHBXhc6iMkiT4U9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gu5n3UBBBf1vYz42qg4EorGUwKb7hAeQiLyM8o/qlCrR6Ng+/TkSKLvGCycQEmEONyI8awKHGtYTL53oEpJToglXBPVZP6c4NgjjSvtx/97ENY405zDBVchwZ7qmkJmSbZZZvCCZrSCCVz4eVq6DZG9qqMXs94XJAMU0CfL8ImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD4a3Fg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC39C4CEED;
	Fri,  8 Aug 2025 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754679596;
	bh=rAxVSLUTQE9LbX6DT1fMVpo7DSeMHBXhc6iMkiT4U9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lD4a3Fg6ggfQnvzMsJHsKZvjFPpBisUrTN4f30AEfeYab2bsHrBcufiZl9U4p/n8Z
	 r3uWJIdX35HG8xWELe//9PqbTGjqaTLLDjUImV1Ds6+tlRfVBfN7ACI+chlsKjA8/m
	 UiECiGJUYwKEA7QkIsptJlPf7igKScTQSEiPGsZVjfnv4dm6oItwMri63BH2A0oJq4
	 QfgjUDkYUlrk7oMR2xeGOHiEtwi4t1CaERw8RN7CsqRNLD970isR5JBYlJxrc/5i/t
	 WC51l5wcDxVu8A5801U/462FcaVn6z+6neG7dFJQUiGM0Q1n4M82CouLpM3fFgFJYX
	 DS+nk7M1BudxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE05383BF5A;
	Fri,  8 Aug 2025 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/3] There are some bugfix for hibmcge ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175467960950.234714.166503573353288765.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 19:00:09 +0000
References: <20250806102758.3632674-1-shaojijie@huawei.com>
In-Reply-To: <20250806102758.3632674-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Aug 2025 18:27:55 +0800 you wrote:
> This patch set is intended to fix several issues for hibmcge driver:
> 1. Holding the rtnl_lock in pci_error_handlers->reset_prepare()
>    may lead to a deadlock issue.
>    2. A division by zero issue caused by debugfs when the port is down.
>    3. A probabilistic false positive issue with np_link_fail.
> 
> 
> [...]

Here is the summary with links:
  - [V3,net,1/3] net: hibmcge: fix rtnl deadlock issue
    https://git.kernel.org/netdev/net/c/c875503a9b90
  - [V3,net,2/3] net: hibmcge: fix the division by zero issue
    https://git.kernel.org/netdev/net/c/7004b26f0b64
  - [V3,net,3/3] net: hibmcge: fix the np_link_fail error reporting issue
    https://git.kernel.org/netdev/net/c/62c50180ffda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



