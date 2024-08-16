Return-Path: <netdev+bounces-119286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BDC9550F6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE401C217CD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349E1C37A1;
	Fri, 16 Aug 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HheiApU1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3C1C0DC5
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833632; cv=none; b=uJRCYVeBFXGlkrZuPC/sUvMGyrVKHy6B6MhYqOIQWXG0/VVUQgNPmpUiJ4QKLQwiWP6LQVUcIbR4NMZVdEWBRHfV1E6fwtxsF+hQO7bxi6gngknyyKZ76tZIjsAHh57W7tM4BdRoA7Q+RrQJuUfjaLZOMGMqS4X1/2lo5U1a8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833632; c=relaxed/simple;
	bh=ZWN+DPHrM7G0K8JwSJyvrokQWuSq013pLwkdcbmVbJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Thn6tEtCYmoGTL8ls1lj/ljFr8aTiwREAR38FrvUEr3CqYVs4HUP8mqR/NjsF7CXzLM9qwyeDNuYFHUbkxhwr3RjTp6Bsosx/fj7hDVQt26gts2fo3pyxn/pB/mn7W2jZMHpgP1MDz5R/61IjBHfqeLrC6X7RtajT7o89BYoHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HheiApU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DEC4AF0B;
	Fri, 16 Aug 2024 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723833632;
	bh=ZWN+DPHrM7G0K8JwSJyvrokQWuSq013pLwkdcbmVbJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HheiApU1700tab2KeFIwJt3yFTQCYbHgQ7dX6R/d4ae14gdKxdncA+EJmGERA5ml8
	 ENg96qedGe96KbsYb+/XiZ6Fpyua8g5qNzrHaz3YQtCDrnNx/v1vE6+BSyq8VuZpnR
	 WfZZBmVpeHyfMEdQKtO2EZbOERKQlEoTE4ZSwLOIJ8T2PiK3uq+wYJqTwKZpmKbjsD
	 p9u2j16lHinW8DqL7X7G67odtrxdhbG3J9G5gpQf+Qai8BBYZzGtMcUX9oz8jU6kx3
	 YJXK/Bko6k+EWD+XLeS1DPA2nzHEL/IIM9VHn9IMJY1GU4GKgZtfDuOi75YDiH6L3l
	 gvMmhp+ArgQ3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7A638232A9;
	Fri, 16 Aug 2024 18:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13][pull request] ice: iavf: add support for TC
 U32 filters on VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172383363176.3600965.17023382705941762147.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 18:40:31 +0000
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ahmed.zaki@intel.com,
 madhu.chittim@intel.com, horms@kernel.org, hkelam@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 13 Aug 2024 15:22:35 -0700 you wrote:
> Ahmed Zaki says:
> 
> The Intel Ethernet 800 Series is designed with a pipeline that has
> an on-chip programmable capability called Dynamic Device Personalization
> (DDP). A DDP package is loaded by the driver during probe time. The DDP
> package programs functionality in both the parser and switching blocks in
> the pipeline, allowing dynamic support for new and existing protocols.
> Once the pipeline is configured, the driver can identify the protocol and
> apply any HW action in different stages, for example, direct packets to
> desired hardware queues (flow director), queue groups or drop.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] ice: add parser create and destroy skeleton
    https://git.kernel.org/netdev/net-next/c/86ff3d79a0ee
  - [net-next,v2,02/13] ice: parse and init various DDP parser sections
    https://git.kernel.org/netdev/net-next/c/75b4a938a947
  - [net-next,v2,03/13] ice: add debugging functions for the parser sections
    https://git.kernel.org/netdev/net-next/c/68add288189a
  - [net-next,v2,04/13] ice: add parser internal helper functions
    https://git.kernel.org/netdev/net-next/c/4851f12c8d8a
  - [net-next,v2,05/13] ice: add parser execution main loop
    https://git.kernel.org/netdev/net-next/c/9a4c07aaa0f5
  - [net-next,v2,06/13] ice: support turning on/off the parser's double vlan mode
    https://git.kernel.org/netdev/net-next/c/b2687653fe69
  - [net-next,v2,07/13] ice: add UDP tunnels support to the parser
    https://git.kernel.org/netdev/net-next/c/80a480075911
  - [net-next,v2,08/13] ice: add API for parser profile initialization
    https://git.kernel.org/netdev/net-next/c/e312b3a1e209
  - [net-next,v2,09/13] virtchnl: support raw packet in protocol header
    https://git.kernel.org/netdev/net-next/c/fb4dae4ca315
  - [net-next,v2,10/13] ice: add method to disable FDIR SWAP option
    https://git.kernel.org/netdev/net-next/c/f217c187ea2e
  - [net-next,v2,11/13] ice: enable FDIR filters from raw binary patterns for VFs
    https://git.kernel.org/netdev/net-next/c/99f419df8a5c
  - [net-next,v2,12/13] iavf: refactor add/del FDIR filters
    https://git.kernel.org/netdev/net-next/c/995617dccc89
  - [net-next,v2,13/13] iavf: add support for offloading tc U32 cls filters
    https://git.kernel.org/netdev/net-next/c/623122ac1c40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



