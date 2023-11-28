Return-Path: <netdev+bounces-51666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B257FB9EC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814161C20F6E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DFA4F8B1;
	Tue, 28 Nov 2023 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiST5xq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AA19460
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5108C433C9;
	Tue, 28 Nov 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701173425;
	bh=WbgXbzRlSrdjtRqBuZssoIa9RXznAJ6Nw5UymFlbnpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fiST5xq5cXzDeinXn/TIKsSh2OjG4ODY0f2xSvgiHIOcRT5qPDNOB5EDvqNyX7NVJ
	 YfZEmIufdxgMCH0Eurb5YoE9gP6qY6HCnlXaxpFR3hwEKw3komgKIpbQ5DhecUslA7
	 Pzy6+zuL76XfP3CGEguQc7yAa80jLyG5RvOrWcH53M8HpmlY5Diguvg7EYLZXaYj8T
	 q8avcsf5jr2pS+kw37BVtoIJNoghT01XxNrFEhNTbpTbWFSnKXunj4aYcPSoRNkVDu
	 2EfU7wzlqw0CtG3HposZOu5j9GGR5TCubNCQhMKOUfI92AndsZIoWeFiEH8aIm5sza
	 1+Twj441EIGKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD410DFAA83;
	Tue, 28 Nov 2023 12:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] r8169: prevent potential deadlock in rtl8169_close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170117342577.12571.3727946583275294042.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 12:10:25 +0000
References: <12395867-1d17-4cac-aa7d-c691938fcddf@gmail.com>
In-Reply-To: <12395867-1d17-4cac-aa7d-c691938fcddf@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Nov 2023 23:01:02 +0100 you wrote:
> ndo_stop() is RTNL-protected by net core, and the worker function takes
> RTNL as well. Therefore we will deadlock when trying to execute a
> pending work synchronously. To fix this execute any pending work
> asynchronously. This will do no harm because netif_running() is false
> in ndo_stop(), and therefore the work function is effectively a no-op.
> However we have to ensure that no task is running or pending after
> rtl_remove_one(), therefore add a call to cancel_work_sync().
> 
> [...]

Here is the summary with links:
  - [v2,net] r8169: prevent potential deadlock in rtl8169_close
    https://git.kernel.org/netdev/net/c/91d3d149978b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



