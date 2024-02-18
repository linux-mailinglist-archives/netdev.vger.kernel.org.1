Return-Path: <netdev+bounces-72779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA8859921
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE041C20BD3
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2B6F53E;
	Sun, 18 Feb 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9yBWufz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9041DFC6
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285824; cv=none; b=t5f/0YT1Sfl058dkl20edSNpeXRCvCYrRsl8WOiKMsB/XsalsPe9rPIeRHmsZY9qvClbvXoALAaal8T+R3zWnH2AZvSu3d3/hktQ+EAwcmIdUJrGYxGKcxHSP/WRkT6HGBi+pOUAUwiba1mDbm0YPPo6fA2/2rO4InYUYNKFSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285824; c=relaxed/simple;
	bh=Ftl6JVM2YUjhhD+GhbZFt/6u1IA+d49C+cY0bQ++IiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sy3tBT3GcGybylhiYA1/7wzv9ehO5OGbKy+ZIEFWHv7/NNcrS2EEUHVa1CuerXpg4WW/Ljpaknmv1KT9ak7enITyvs+AbMQaGBZucE+nRVZJggMA0zWXcdKTu+cT/PI9JUqwlRItGfsSa8GU9BfSxPah8n/JVeq5LbBOvNwyfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9yBWufz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6BA3C43390;
	Sun, 18 Feb 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708285823;
	bh=Ftl6JVM2YUjhhD+GhbZFt/6u1IA+d49C+cY0bQ++IiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s9yBWufzvokozXRKSOAlDR+bc+xgceVNxN+3JscTvdOpU93IHoAri5UlqPQf/eXdM
	 E/Al7xodeVV46Q0ETP0Cc3tdfM7a/tw2qSydY1z7jlFvgwIegddlMk+N0g1viP2OCs
	 cGdNlylvuqj/qPUgbaTu6pnNgXLn6ygRlQ9Itwll+zDUPxE0N4WU2JXJVzkL4dMvGM
	 z6Mc9DXHv7i4LhwMCotOKxRDo3K3AnGHP9++9QEIeDZINnOiimfMmm/5OEkAhCpmIh
	 83OTFb0Ew1WJTswDx+mJ43HmMmAbfa0EyhBvl419eXq5s/Ry62sswEoIGkPaHUk0MK
	 6dBja7plp+PMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C9FAD8C97D;
	Sun, 18 Feb 2024 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: Remove ena_select_queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170828582357.19979.1305056638749819407.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 19:50:23 +0000
References: <20240215223104.3060289-1-kheib@redhat.com>
In-Reply-To: <20240215223104.3060289-1-kheib@redhat.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 shayagr@amazon.com, darinzon@amazon.com, akiyano@amazon.com,
 ndagan@amazon.com, saeedb@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 17:31:04 -0500 you wrote:
> Avoid the following warnings by removing the ena_select_queue() function
> and rely on the net core to do the queue selection, The issue happen
> when an skb received from an interface with more queues than ena is
> forwarded to the ena interface.
> 
> [ 1176.159959] eth0 selects TX queue 11, but real number of TX queues is 8
> [ 1176.863976] eth0 selects TX queue 14, but real number of TX queues is 8
> [ 1180.767877] eth0 selects TX queue 14, but real number of TX queues is 8
> [ 1188.703742] eth0 selects TX queue 14, but real number of TX queues is 8
> 
> [...]

Here is the summary with links:
  - [net-next] net: ena: Remove ena_select_queue
    https://git.kernel.org/netdev/net-next/c/78e886ba2b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



