Return-Path: <netdev+bounces-148064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D39E0416
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE3F16755D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB60202F82;
	Mon,  2 Dec 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlHuTmne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25665202F76;
	Mon,  2 Dec 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147709; cv=none; b=BecTTyIbl7tiyMBfnNlumDHVS+zfrI9BOOKvRlqjl/cqSi5DMUNReikq/HE7GN+FtTzTj+3pa1/+9kaBu1vTw+obqHeBFdDnXdxliopS6UMxf6uHI8DU1jgFUcAa2qv0nBElhLxXuRBPmKWIlzFT44sCy2nEI7FoV495DVBlWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147709; c=relaxed/simple;
	bh=xut7OUUID/Q9cjzSJft1L87TP1R4M5N3NP7bDtFkrl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3dU6++TzrVYYu6sGVf0U5BMMj7nF1SO7kLzYG69oGZ2udnP71m26A9I5T+quDpPkCmBqd8LP0yZ9cq5iOg7Zrl0gBuLIDSabdb6uaL/ax0EMicMZW4YpvvSlkLIeI2Ixy9luLqWLPRqx9N2zYYwK71YZy1k5qKL2JlM8/7ASqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlHuTmne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFA6C4CED2;
	Mon,  2 Dec 2024 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733147708;
	bh=xut7OUUID/Q9cjzSJft1L87TP1R4M5N3NP7bDtFkrl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlHuTmneF12Rddhipx72cqJ1/DynicaIYk9fIG5qG9jcyrKkXOQdEemPDjM77IyKo
	 8/uoZVKlXtF3v5GzPkl6XD3Y4UNfztGaRi5n2B2ijNToVnBBikXVJeucu4WDggS6i0
	 XjWDR4ghQgyvE38Vw9cSfaS9OGtmg1uaZJqetZ74jtPHSkyQ0yJUUObOjclJ+SNcWf
	 8vfxJtfzkHdY0lGy6rdpA0NmCFNKjF53z9LD5P9dtP7Bqz6iLagqAaEcN4iUnEa5az
	 8mS4IbDLACtktFdHot4YAubRrNosmXDF94mS4Zh3mc5Avm30zIu44C4QggJDuc8Je7
	 Nd8nYOEwuRv7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D273806656;
	Mon,  2 Dec 2024 13:55:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix SDP MAC link credits configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173314772276.3602614.7515557662440108055.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 13:55:22 +0000
References: <20241126114431.3639-1-gakula@marvell.com>
In-Reply-To: <20241126114431.3639-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, sgoutham@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Nov 2024 17:14:31 +0530 you wrote:
> Current driver allows only packet size < 512B as SDP_LINK_CREDIT
> register is set to default value.
> This patch fixes this issue by configure the register with
> maximum HW supported value to allow packet size > 512B.
> 
> Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix SDP MAC link credits configuration
    https://git.kernel.org/netdev/net/c/28866d6e84b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



