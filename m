Return-Path: <netdev+bounces-55499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E42380B0E1
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55406281B04
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C7184;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+n/QDnM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4E628
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F891C433CC;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702081229;
	bh=9QTbyhHxnjxUS8mDK0v9LhPk8RQqv5D9wzPUvOZy6Wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k+n/QDnMAD+I2D+JxxnVM36kQSOjv9EwZi/WCLoQDrG3rQ4APJ2hn1FlO6jbgZvgo
	 agNN46+fzBXk38N+PKTtRFm4XXQC90bMTYKIyqnejev7gOc7CGrPnbhnSfz8XnKCc3
	 JFEknYp8rEI6aXGGRlSy+S1IdlRBi9UbohNNfe4swf77CDaNDoouhK40RBnyoFa2ii
	 Th14siC1hrLqgXvICKda/aW3j677s7YTXvVEZ8MWzu7ro7ba6SAgKQK7PUiEXq9Ek8
	 DRuqd2uTZvADyGMIvYyKHs/ofN+jf5jzDEESpv0KRQaaDrZywC2nGUOsLCZn30trZU
	 tcIKGFDMKGScw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F6DCC595D0;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: initialise control mbox tasks before using
 APIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208122925.21357.2124967308969408526.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 00:20:29 +0000
References: <20231206135228.2591659-1-srasheed@marvell.com>
In-Reply-To: <20231206135228.2591659-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, vburru@marvell.com,
 sedara@marvell.com, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Dec 2023 05:52:27 -0800 you wrote:
> Initialise various workqueue tasks and queue interrupt poll task
> before the first invocation of any control net APIs. Since
> octep_ctrl_net_get_info was called before the control net receive
> work task was initialised or even the interrupt poll task was
> queued, the function call wasn't returning actual firmware
> info queried from Octeon.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: initialise control mbox tasks before using APIs
    https://git.kernel.org/netdev/net/c/a1664b991ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



