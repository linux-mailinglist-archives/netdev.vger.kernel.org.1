Return-Path: <netdev+bounces-222190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A26B536CD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD24174B72
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD931578A;
	Thu, 11 Sep 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC9lKxEE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A5322DAD;
	Thu, 11 Sep 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602804; cv=none; b=SSwhV6kqdpf3+R2vk1vicD/B8vCb3puZmKGMuKJsnECEbwOFsE0DFumhawu9hTmYnsXJJjZGLxQ8p+S8ruS/UfVbtaArvoGpCZMpO9ioeQB0ARILlAXk19iftcq3/DvJAmGd3YpKZHDqKxBbGPAeAgN3CJmvWCTdXZrsLJuFY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602804; c=relaxed/simple;
	bh=1E1cqC5r3mV4aDOiVcQQ97fkxUwbFiA7fMztwzGI/Ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPHZVjQny5V7+2Te5fXY94Y8jUVeMFikyCdgx1SK+P4cRl0MTgZkAzJUa912zT5gOCYL2PCXFvyNJpU1YYFFSWBMxpofn5YPuUWd9KWiPVvCFN16m7mFjiK2dM/ox+FPNtMiqwIZasYq2HN1MmI82E8RVgMYQFvghYPuf0LRN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC9lKxEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF8C4CEF0;
	Thu, 11 Sep 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602804;
	bh=1E1cqC5r3mV4aDOiVcQQ97fkxUwbFiA7fMztwzGI/Ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oC9lKxEEQOwppv+V+Mq2yG4+KEut1F/qQXumaJbfUMDl65htG16/WTAyeKHAXRY5G
	 uvn79Av7KtrtNPW7RanNbo2mps7WRxo+tfrYyGcvZCCLuaj9RY6/O+rC+EUKAiG+jI
	 mZs7WsAZKnJptuTCNGGnKJQa1l3ieggyzoXLbJN9oZRFVEyrk/oKg07gAPx6zdd4vE
	 0UZIE+ZTe/BjoWxQC6XJOJeV3h7swGtZBmPxZhw0NM2fpanEru1RFkmzCdKqm1IGvl
	 qcYuBDpDdQbFZQfjyKNoybvLI6GcqOw1EH+TSPrI6PENJWCmBnF1GzbIL+YURe2tnS
	 18s+38klgzfhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4A517383BF6C;
	Thu, 11 Sep 2025 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: usb: asix: ax88772: drop phylink use in
 PM
 to avoid MDIO runtime PM wakeups"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175760280699.2209403.2224152727971942532.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 15:00:06 +0000
References: 
 <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
In-Reply-To: 
 <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, o.rempel@pengutronix.de,
 linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
 hubert.wisniewski.25632@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Sep 2025 16:33:31 +0200 you wrote:
> This reverts commit 5537a4679403 ("net: usb: asix: ax88772: drop
> phylink use in PM to avoid MDIO runtime PM wakeups"), it breaks
> operation of asix ethernet usb dongle after system suspend-resume
> cycle.
> 
> Link: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com/
> Fixes: 5537a4679403 ("net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"
    https://git.kernel.org/netdev/net/c/63a796558bc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



