Return-Path: <netdev+bounces-206946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF82B04D6F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B424A5B9B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B9C1ADFFB;
	Tue, 15 Jul 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="livtGBF1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7A1A83F8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542986; cv=none; b=axkiyKMBjVzATSTnYMzP+Hm67q7Ii9xxObm5GRoEh+vh0znmzTIoLDuPsYc2C/bMqWWwxFUBHvMiLCGlEiGFQNtn62PqJMXInfgeKHfT1J4ccJVj+f544fXzsWh7ncROzfOwxt3zPpoN1/Yt0BX5sGnAXsOyAv29qBSaXhXWtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542986; c=relaxed/simple;
	bh=kGI84bC7v2aDNaAH5a3lXj6BnsPJoIiEWnoYXhxtYug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sxkeffjl4VVToW/J22TPWOBQNOIt7LKZKRlG77dZcyNivIswTkrK3aYZYoaG1s8nxO7Xv9HFznVZoq4oR+Snv0qOWuscPfXsWvo20hemd49LWFbHX0qpVm/NkW4yFXIXVH/spOdcIdufObRAFOMpHKlWnvdYk4Mpdspfyd9ZRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=livtGBF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF52C4CEED;
	Tue, 15 Jul 2025 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752542986;
	bh=kGI84bC7v2aDNaAH5a3lXj6BnsPJoIiEWnoYXhxtYug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=livtGBF1RiUYH0ZPTXpDpdkZj6ALRXfUOfr9x4rFiGrIYme7Pc2LHEssX9owDaN34
	 dk4gmo2HtLsofluKW/ha2A3+rHUbukYs5XGTyQsuDj5r8w1gchqmwampkde39pURYf
	 8IzTXNTEzTqdSiClkSHCmfv7JhmHy4U+gerD0pSgxKIMK37JTmeBCIyaOLJNYKW6ln
	 FWWcB5GaD3nZPIiBs8BTAVLnsRKmLC76kyZzfneKA+P83vjPGciyc1zlA4mLa22lTT
	 Xi/YU1A3iJ8v2Q0ElJpjds03dtZstraxTZgi+fXL8vGxSMni4tMLhQeGSW6h4pGtBr
	 LLo8IoCxgyJdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7A383B276;
	Tue, 15 Jul 2025 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10] Add support to set NAPI threaded for
 individual
 NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254300702.4049503.1740890343849051326.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 01:30:07 +0000
References: <20250710211203.3979655-1-skhawaja@google.com>
In-Reply-To: <20250710211203.3979655-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, willemb@google.com,
 jdamato@fastly.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 21:12:03 +0000 you wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> NAPI polling on all of the NAPI contexts under that device. Allow
> enabling threaded NAPI polling at individual NAPI level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a NAPI
> context.
> 
> [...]

Here is the summary with links:
  - [net-next,v10] Add support to set NAPI threaded for individual NAPI
    https://git.kernel.org/netdev/net-next/c/2677010e7793

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



