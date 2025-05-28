Return-Path: <netdev+bounces-193880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA83AC625E
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F4B17F1CE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616F212B3D;
	Wed, 28 May 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB1dnonr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F9A31;
	Wed, 28 May 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414996; cv=none; b=g/Bk0nXRhcmg6+yyliFjBct57a8lbi5FYsWY290L+Vt2iTTW6DEGOUNJTb61sjqrko2LpUy/FIrtLehWdXDB6XE+zJ7y/HV98ifF5MjA6gbKQThvk85T+0GnZuKWE6UJbRGBXjiJr6hl4it3L2BeTQOGGPLDk/GbrsrGBKxGwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414996; c=relaxed/simple;
	bh=x2kV5iqMNM1itgW9iiLCsBN9iFFDIIu5P6cEF5rxFvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i5cEQYnE3UPxgNlXzWWbsbk/sAEEyH1jFHJsWvYFjzjYIjY29oFfwZn1P7PwGvS0D5UvBD+1JMOV0evPmBZ/jIjmtc2uHT5r5Wd5ludjqoTmQMcSiE00p9e/lLxneC35UFvH+Vw6ep9cxkQXiWiwMdyniHYQySA5XI5MeWeHZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB1dnonr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC2DC4CEE7;
	Wed, 28 May 2025 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414995;
	bh=x2kV5iqMNM1itgW9iiLCsBN9iFFDIIu5P6cEF5rxFvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dB1dnonrXdXI2cvravKdxfJwwLhn8BYTD26P2sxXBO3xYR1Sh76xOIkYsqViUo6JQ
	 1l36r7PzmPRldmwBBcTU6AWsumIn06NDnlvBsp+LGl0s2zTH5Gp+iuiCPk+xbg9VXh
	 SHsUqpfSjes5EdZyxIauuh445yTi4uKF48AcFjW9tyrflaBxgc3cgs2ye9ewdh69+b
	 1aQZfGkzNBhZid2BwXbcnVYNdKTCfaQTSFxdlMVrg/+Q2eTwPn0/p4t2pYZ3xc1fAf
	 5OSaaoq61+hxHuiy20padgH96F0UTvz4AhZqoPitdYvWdUh6Y0zddO9zestQyBY79/
	 Urpgm6q7Harsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6F39F1DE4;
	Wed, 28 May 2025 06:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patchv2] octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841502975.1929742.10423717483312041089.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 06:50:29 +0000
References: <20250522115842.1499666-1-hkelam@marvell.com>
In-Reply-To: <20250522115842.1499666-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 17:28:42 +0530 you wrote:
> This patch addresses below issues,
> 
> 1. Active traffic on the leaf node must be stopped before its send queue
>    is reassigned to the parent. This patch resolves the issue by marking
>    the node as 'Inner'.
> 
> 2. During a system reboot, the interface receives TC_HTB_LEAF_DEL
>    and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
>    In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
>    is reassigned to the parent, the current logic still attempts to update
>    the real number of queues, leadning to below warnings
> 
> [...]

Here is the summary with links:
  - [net,Patchv2] octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback
    https://git.kernel.org/netdev/net/c/67af4ec948e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



