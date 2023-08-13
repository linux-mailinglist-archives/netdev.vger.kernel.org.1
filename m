Return-Path: <netdev+bounces-27111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E677A636
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F7E280FA3
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03B63DA;
	Sun, 13 Aug 2023 11:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C55250
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65777C433C9;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926222;
	bh=8vSQAsTDYEi/UdL5LqIV8Ft5zjJ6BQPG24xPN6gW07A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZKXDqMW/sBKkS+4a+wz3d8bF1yk7aOzMrzQx3wlad7fEF7GEWkCzxVpXSJN+maAyu
	 Fdg3WlCBQRfrQXv9iHPV/6ekZ7qplaWVGaRNCHI+K2cgS0VLYDQkhicoHFlaTkt8wq
	 hG7oQZWufIOM7h7jml1F+qE4mZ3UPGAaeRYkekFMjnQ/5NY6jOJd248rI9eheNakIA
	 TJwxDPQVS3eRmxJy8g3FBdv1Ly0kANNy2hp70O6CdAgY/6C25oGmolHBf+CYEhhAiJ
	 UQ8hr7kfJOw4kM5TQpUfIN4TUr01oirnyGLAyseT24h9Vse00IDcWyMnRbYcV56Fgm
	 lmLQmXpzRcZIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4641CE1CF31;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: e1000: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192622228.28684.15222274340017010414.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811105005.7692-1-yuehaibing@huawei.com>
In-Reply-To: <20230811105005.7692-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 18:50:05 +0800 you wrote:
> Commit 675ad47375c7 ("e1000: Use netdev_<level>, pr_<level> and dev_<level>")
> declared but never implemented e1000_get_hw_dev_name().
> Commit 1532ecea1deb ("e1000: drop dead pcie code from e1000")
> removed e1000_check_mng_mode()/e1000_blink_led_start() but not the declarations.
> Commit c46b59b241ec ("e1000: Remove unused function e1000_mta_set.")
> removed e1000_mta_set() but not its declaration.
> 
> [...]

Here is the summary with links:
  - [net-next] net: e1000: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/2045b3938ffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



