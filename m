Return-Path: <netdev+bounces-242482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEAFC909FA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D73A8DFF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F829A9FA;
	Fri, 28 Nov 2025 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmH0Tk/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C80276058;
	Fri, 28 Nov 2025 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296610; cv=none; b=WHKB0IdODVVkh7dSD6vPfnHyiqxx/CaDCdd09dKH/iq3i8ftybi8zegf2IGLQbeekWQnuZoSrCTlLa7Qgm28IiNHWfYuEr5UvfKMGqj4qM4gkothb7y7CNBJaMM1KFFXopz7CFiIKQxyRCl59OJ3Ak8/J92hc85Jwb4hc1kvyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296610; c=relaxed/simple;
	bh=cVqdiLZvXfpByFSQClvvNIc/RzgtFe65UKuBikGVKYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eyp5cfnxE49nHk+ZecxAzAfOhTUGdsSBnmVtcEyvTdAiQ1qCkBGe5LxmQ16zrCfRH9XyDBlsJTeItfwE7ANjsfY+oGmZxdpHvDwcZcC7cUEg5Zri9pYeqgxcSrBVg74KaNChXevMtVoFNN7oqZ1gIg9nMhoXsHhTB4NI++/FaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmH0Tk/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A0FC16AAE;
	Fri, 28 Nov 2025 02:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296610;
	bh=cVqdiLZvXfpByFSQClvvNIc/RzgtFe65UKuBikGVKYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NmH0Tk/qJYlZZdbRavG4rL3idrq8j7Z7uPF/UPm6oyEMxENCxVjjFOnGflmN5QDSs
	 k/cccdTYv4DDPoRZS786oKMpmO05/vnOhqvaepCjlMDmgy/l7pl/YlwvLAivlhORKU
	 j0e3p711Rp/zlU02/Bwqy//qxQf9AS3gs7c1EOtqshBj9PsEPDrk5qZlgHkzJIhjMp
	 MIys+C4RZUrNLD0oAFdmLMMmpd6G5ZnuXSX1j6dbwHSP9xPbwiN19bgXA6FMjGDC8O
	 wAkwyQ5ohPdDx/Xm5HqTIf7aL/rApuuVpK1b7zKkkOQHu7m1v8nZ41H2klR6gFUYsi
	 kKq1n1UfQOeYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B588D3808204;
	Fri, 28 Nov 2025 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: thunder: convert to use .get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429643228.114872.16293714452908215238.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:32 +0000
References: <20251126-gxring_cavium-v1-1-a066c0c9e0c6@debian.org>
In-Reply-To: <20251126-gxring_cavium-v1-1-a066c0c9e0c6@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 02:54:40 -0800 you wrote:
> Convert the Cavium Thunder NIC VF driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc solely for handling
> ETHTOOL_GRXRINGS command. This simplifies the code by removing the
> switch statement and replacing it with a direct return of the queue
> count.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> [...]

Here is the summary with links:
  - [net-next] net: thunder: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/73880e66b79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



