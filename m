Return-Path: <netdev+bounces-229837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A89BE1257
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C88D19A56A2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3CE1C5D77;
	Thu, 16 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvfkfAf5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAB20322;
	Thu, 16 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576430; cv=none; b=pT4NeyQFOag0uXmAWZmIfzKW97lKMxWHdZD5o1U/DX403P48GdwzGhr2SWfZ35pWLAswAzFujtB3WtCwsiau8NKrbppbebxzjvmanQy6NCZ9dcU8YQgORNA7ptFxXCboX9dd6r1uee57KeTLuNxwZ4o4UKfuSZzt25m9JmHR9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576430; c=relaxed/simple;
	bh=Ik8aIuKUMfuZH3qbBcQ8N1NbTvwJaLiUhd31QH0CPF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bfovYFT1vd4WuNxiie1UtcHcx4imUau1DUUQoOVVPbQgXR1yu0DbHI7dMbR7bdg0b4lnz31LGyJGfMc9n8eIypLrWMpXjU9rha3HtPmr1XoSew4syXgc/+vLO6zILYGq0dgv3kxR1X6AW6i2n5F/DZKmV9hm5mqtSyLUMxaPw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvfkfAf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A665C4CEF8;
	Thu, 16 Oct 2025 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760576430;
	bh=Ik8aIuKUMfuZH3qbBcQ8N1NbTvwJaLiUhd31QH0CPF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rvfkfAf59/UgphYfysr5J0587v/W/U0QoRxHKOW5L13gI9lrO8TGNHyY+TqfoWMa1
	 SNL70DKe7NRKb83JLE5a4Awpikj0WZyrpmovHJFZ7AMeNQb7eNb2pPg4hytjbtTwHL
	 5nsuMU5yVWWq9D4mk1c2qJbz12ReSyzBjpCn4t/2ZXh/9P3HsJjrzPhesL289ZRva0
	 AEU3SXFcEYmpE/hCQUaomFROsQ3rSvwIhhUZHydLvNi5z/H6IXRWIMT6S6lsmKDG6N
	 URHO12sNqls+tPwYfLiRgDKF+36TmLv9x0KWBTefSRiSrOtTsad3QC7qeSZSgLZENL
	 LwFafd6GAQNNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A1380DBE9;
	Thu, 16 Oct 2025 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Preserve PSE PD692x0 configuration across
 reboots
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057641475.1117105.7388328544884653333.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 01:00:14 +0000
References: 
 <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
In-Reply-To: 
 <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 thomas.petazzoni@bootlin.com, kernel@pengutronix.de,
 dentproject@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 16:05:30 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Previously, the driver would always reconfigure the PSE hardware on
> probe, causing a port matrix reflash that resulted in temporary power
> loss to all connected devices. This change maintains power continuity
> by preserving existing configuration when the PSE has been previously
> initialized.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
    https://git.kernel.org/netdev/net-next/c/f197902cd21a
  - [net-next,v2,2/3] net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
    https://git.kernel.org/netdev/net-next/c/6fa1f8b64a47
  - [net-next,v2,3/3] net: pse-pd: pd692x0: Preserve PSE configuration across reboots
    https://git.kernel.org/netdev/net-next/c/8f3d044b34fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



