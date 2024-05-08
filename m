Return-Path: <netdev+bounces-94371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB58BF48D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08D2B20A5A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44A10A17;
	Wed,  8 May 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab/uynTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701EC133
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135429; cv=none; b=MKI7NjZCTZiPFabhjxXWwtNkx02Z5UMF+kNAUOEooH+hFVzy3AghqpoJmxBnQQU0iWTxUIzL13Ba1dUUS6yL2AG8+gNxRJ5AJvWGgOyLjqWJhUUnuXS9IqhhdBMWvCs/P8Gq8MVDQhwY6QB/MIljFeMnxUhz7IopjaBo6S7HMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135429; c=relaxed/simple;
	bh=IJ5QCQbtfXjycPxaGcmB+D33hTywG6o3hoSlgt1WQBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K2fzWgYDtM3HyeUHOVqn/KW5C3/fCfmpKR2eIrOz2EoJRpuvjRaGEQJLzivGVR9oYK+lecANMb6aNm9znPnIPK2gdFH/8hiqWgJOm8OdsS24cJuXpsBuxdIiTj+m9JL4pMwa+BP5KWD8jCpy/J6MneMJSDPRVMDBb8DNjoW1Dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab/uynTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EED30C3277B;
	Wed,  8 May 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135429;
	bh=IJ5QCQbtfXjycPxaGcmB+D33hTywG6o3hoSlgt1WQBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ab/uynTEgVX2uSfYHWokbQ0ajEaeAW4PkvrvtIdwkP3RuPVKKJ4/SQqHJnzmDhTGZ
	 98Q2pU7MGV43JtlUbgJa5VYY/371AMBJVLIMfBasDPStMzLAu+A2KzT14wQ2zg/KLt
	 +GDBpusmNE+0VGSZSCqFrXpH89xONPPzH64OlER+HF/JANUwY8LWEskzHrNR7OLGhX
	 tvmNt6pM/pSyjRd9UrHanER6F7R8zdWkuBxyiHkGtkXHz90/uKK7IrLmr/mHriDtdb
	 gQQi6dbyikvFJWfQ8Q3wqinZ1Bf8SCT2TlWkf1TeTtDMX179aWTS94XN45klLfHKkC
	 MpYSt4L7J3cuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DED9AC43617;
	Wed,  8 May 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates
 2024-05-06 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171513542890.13996.15011351702201996231.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 02:30:28 +0000
References: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  6 May 2024 10:08:21 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Paul adds support for additional E830 devices and adjusts naming for
> existing E830 devices.
> 
> Marcin commonizes a couple of TC setup calls to reduce duplicated code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ice: add additional E830 device ids
    https://git.kernel.org/netdev/net-next/c/4fd104018cb8
  - [net-next,2/4] ice: update E830 device ids and comments
    https://git.kernel.org/netdev/net-next/c/a8e682f03748
  - [net-next,3/4] ice: Deduplicate tc action setup
    https://git.kernel.org/netdev/net-next/c/c5e6bd977d7e
  - [net-next,4/4] ice: refactor struct ice_vsi_cfg_params to be inside of struct ice_vsi
    https://git.kernel.org/netdev/net-next/c/deea427ffc0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



