Return-Path: <netdev+bounces-140580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A89B7159
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18C31F215A7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F401EEE9;
	Thu, 31 Oct 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDPTCTm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F01DFE3;
	Thu, 31 Oct 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335825; cv=none; b=LYX3waCkDRo2yoptGvQ6fphZ1q6hmb/z42o5i5WRkhYboM99YgLLtknok2OyVng7mnqccKAEgrY9eTkv/d3ahG7NUebkFb3HppYxq40t88xAsz6g6WXKiyj8IHSuKMBijpqGc9Ii03FE4dzBe1UjTrqIsbcxepZHW5N8NO6gbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335825; c=relaxed/simple;
	bh=oPb3umXAu1S6gNSQh9F+7GQM/K9WJL7NWaGfsN7d7Rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ECEvWtlu9jwnO05aAEq4eDg9hQe5SHXlPXcG1cdKkGMbmFAYE5rql/cl922FlksDBEsTs8kD7atj2usvbufbJtFStm3MdGfZm0ZAGUqTuaVAx9Qit6WEVP3zd6d7QWiFO6B69YHG1RWe4KazCDow88v3FpVR2jMaAZM1jzYkRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDPTCTm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35824C4CECE;
	Thu, 31 Oct 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730335825;
	bh=oPb3umXAu1S6gNSQh9F+7GQM/K9WJL7NWaGfsN7d7Rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JDPTCTm7okaSdQ9RfYiXLxUxuL71w/sxOgyuTZ+TSBnuUO5nlmBTT9r0c5EFC6bo0
	 3i8nCcbfmCF+juEHDiQ3y4H5pgmbKjnVe3JXIMaU/5Ar8LN6QahbJuN45AHcfaze0S
	 E/+XBWEcCg/l5A/r0D+o6KoOotBXt4t/Nzr7wVBckEMtdXMgXs//0QRpC5lUJj5blV
	 1ArROkMocFAN0VtbQVFXT4lR3UGJ1jurpxknbog3QbytN057tip1rAXtkuG/PJWvxT
	 QtzSKzCUDevtgSY8ChT0PysO/QkL2Hzh9bq0CzvHKqh0s0X0gW6YNUXngd2dA1omnY
	 lf0LptG4UXEag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAA380AC22;
	Thu, 31 Oct 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/6] Mirroring to DSA CPU port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033583301.1508155.7472482430009726181.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 00:50:33 +0000
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 petrm@nvidia.com, idosch@nvidia.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 vladbu@nvidia.com, horms@kernel.org, ansuelsmth@gmail.com,
 arun.ramadoss@microchip.com, arinc.unal@arinc9.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 16:52:45 +0300 you wrote:
> Users of the NXP LS1028A SoC (drivers/net/dsa/ocelot L2 switch inside)
> have requested to mirror packets from the ingress of a switch port to
> software. Both port-based and flow-based mirroring is required.
> 
> The simplest way I could come up with was to set up tc mirred actions
> towards a dummy net_device, and make the offloading of that be accepted
> by the driver. Currently, the pattern in drivers is to reject mirred
> towards ports they don't know about, but I'm now permitting that,
> precisely by mirroring "to the CPU".
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/6] net: sched: propagate "skip_sw" flag to struct flow_cls_common_offload
    https://git.kernel.org/netdev/net-next/c/2748697225c3
  - [v3,net-next,2/6] net: dsa: clean up dsa_user_add_cls_matchall()
    https://git.kernel.org/netdev/net-next/c/a0af7162ccb5
  - [v3,net-next,3/6] net: dsa: use "extack" as argument to flow_action_basic_hw_stats_check()
    https://git.kernel.org/netdev/net-next/c/c11ace14d9db
  - [v3,net-next,4/6] net: dsa: add more extack messages in dsa_user_add_cls_matchall_mirred()
    https://git.kernel.org/netdev/net-next/c/4cc4394a897e
  - [v3,net-next,5/6] net: dsa: allow matchall mirroring rules towards the CPU
    https://git.kernel.org/netdev/net-next/c/3535d70df9c8
  - [v3,net-next,6/6] net: mscc: ocelot: allow tc-flower mirred action towards foreign interfaces
    https://git.kernel.org/netdev/net-next/c/49a09073cb23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



