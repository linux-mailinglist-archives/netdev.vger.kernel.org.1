Return-Path: <netdev+bounces-223316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F10B58B4D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B303AAAC6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E16208994;
	Tue, 16 Sep 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ1HUDdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0E1DFDA1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986815; cv=none; b=SPwdoaE+tT+zamvGPYN1l88KXn9S+A2z2YgHCYwP7HUxyIjZnzSnTLEF2Z1mCP3/eWo5Z5jEzmKF13kZB1d0tUdAFJ0dVbuUKymeKFH1+aFa4iCrhZTBBlEY3ZAjUBir5Bk+IWc9hmK56l7fm3rWoFAjizz7p08V57IoW0dMsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986815; c=relaxed/simple;
	bh=Gbm9YicGUAbudUqd6AzoHVa4wFaDUZY3tBs9f3hkC1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pD5SrS/k0O8W5qzG1ZOg7fe8CfDe03CDSFLSaRiKEcNBHqooMuNrK7pfpyQCFLlAMD2hpsdAr2HCTeDwzXau0lubd3BLOsWuGXxaKKeYlg1SPu3kHYLrNK/lMxosFanJsszaoC+pyo9jNnQHS32zlh7FrTTkg9d8s4NWvQQwXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ1HUDdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0A6C4CEF5;
	Tue, 16 Sep 2025 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986815;
	bh=Gbm9YicGUAbudUqd6AzoHVa4wFaDUZY3tBs9f3hkC1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZ1HUDdoKQJTnU71beM5UJYBKMLaUxzCUWJ0lHm8bygf2j5nuKNIV2Oj+1Nhh0+ok
	 axIpCtq/vaVSq/pnIKXbCREzjhW4YIdxhqiH+HxOWN3gnv49EmzPMphYZo9yufeQV1
	 39zd9I1N/CNH0eVDyBo/nMP1A/W6ZTLzBrc3sOuSbDHPzFSldxgZAz1JZROuoZ22Gr
	 O24DsiA0JFZniQ/SsB06lbe8GbujIlebePYr0Knvlh0T++kI896lXIVh7uh+hV8ATo
	 hDMVvxDb5DJqHaYT15OcGMV8VyhNlOZl2jTeM3WbLRMXVuvkbfkD0rb17TMzEERQMT
	 yDkGVd8TCfQXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A239D0C17;
	Tue, 16 Sep 2025 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/2 net-next] microchip: lan865x: Minor improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798681674.561918.11758177227251425679.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:40:16 +0000
References: <20250912140332.35395-1-wahrenst@gmx.net>
In-Reply-To: <20250912140332.35395-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 16:03:30 +0200 you wrote:
> Recently I setup a custom i.MX93 board which contains a LAN8651 chip.
> These minor improvements were considered as helpful.
> 
> The series has been tested with the mentioned i.MX93 board.
> 
> Changes in V2:
> - add Andrew's RB to Patch #1
> - implement fetching of MAC from NVMEM in a generic helper,
>   so lan865x doesn't need any modifications (Patch #2)
> 
> [...]

Here is the summary with links:
  - [V2,1/2,net-next] microchip: lan865x: Enable MAC address validation
    https://git.kernel.org/netdev/net-next/c/c5b7509d3a47
  - [V2,2/2,net-next] ethernet: Extend device_get_mac_address() to use NVMEM
    https://git.kernel.org/netdev/net-next/c/d2d3f529e7b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



