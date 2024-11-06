Return-Path: <netdev+bounces-142410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E227C9BEF3D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEE71C21E40
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47A1F9EA4;
	Wed,  6 Nov 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRFx/r8L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A851F9ABF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900421; cv=none; b=YjmyNZvUlfGCvT3UnF1WvENL/7IOPurUID2A+5ipFm/4sZfMe10KuRe60xYKZuePa8zaroOxQNx9HKFkp2KcwzOUnpLyuCo4VYmycEkqK7yvo1AYjhH3VoxJ6gS3h/P4UtVIGW0XEA/wa20o1U8rCOhaCY3FShsFkgQ7h7/RWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900421; c=relaxed/simple;
	bh=daJBRrQdzw5jx3LNuSRSRIFmWQTqnJphNZuRRmdjSB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W0/0EKr4eJSp7ttqUeukuyRZnbE0yGNVXzm1xwAuM6lOY70TJDiC1wBBYxmdzuqGb/FSoCqUzG5fKxYJ2ldHMMOYZk/2bOG+jb4V2/2uCzdSM3wSUbx5moWYVT4nQmqcjIbUZV7dN3aqcAZ/oYcCBx0TlDe/6ys9nMI4l6sOoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRFx/r8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC86C4CED5;
	Wed,  6 Nov 2024 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730900420;
	bh=daJBRrQdzw5jx3LNuSRSRIFmWQTqnJphNZuRRmdjSB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRFx/r8Li/xLdGFu4gFzZJbiAf/YaZ82XKwLG6+OFEBG7MQMgvt1bkeeLNUXwBZ6/
	 sQd4ccQmmGBCpcUsSikp38PJolEFkGu+W0rfI7QpAMRwyvlvxuNmSZT1TLcmJK4DBp
	 Adrbelk+oxGZsp0GzYaotEkhcDyF2ApARXwYmbniIPziv67TFPnGMB0VN1xtVvPLma
	 DQ6Oy9J4m5lb89MFKlYWm6lsU3iaoYITYSRw78g8jA6jozZaJ6no4orVHbV95I3esV
	 To9FgURLj8ZK+QZdBLs8Oe/ANDoyo+O/mm5hV3chPnjsj4nFngJBo7ICHrV4iVAj9Y
	 ADCz0CoeK0fJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0403809A80;
	Wed,  6 Nov 2024 13:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool v2] netlink: settings: Fix for wrong auto-negotiation
 state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173090042976.1261699.14378170271893542574.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 13:40:29 +0000
References: <20241103223408.26274-1-mohan.prasad@microchip.com>
In-Reply-To: <20241103223408.26274-1-mohan.prasad@microchip.com>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: f.pfitzner@pengutronix.de, mkubecek@suse.cz, netdev@vger.kernel.org,
 kory.maincent@bootlin.com, davem@davemloft.net, kuba@kernel.org,
 andrew@lunn.ch, Anbazhagan.Sakthivel@microchip.com, Nisar.Sayed@microchip.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Mon, 4 Nov 2024 04:04:07 +0530 you wrote:
> Auto-negotiation state in json format showed the
> opposite state due to wrong comparison.
> Fix for returning the correct auto-neg state implemented.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
> Changes in v2:
>     Used simpler comparison statement for checking
> auto-negotiation.
> Link to v1:https://patchwork.kernel.org/project/netdevbpf/patch/20241016035848.292603-1-mohan.prasad@microchip.com/
> 
> [...]

Here is the summary with links:
  - [ethtool,v2] netlink: settings: Fix for wrong auto-negotiation state
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=9b2f6b94132d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



