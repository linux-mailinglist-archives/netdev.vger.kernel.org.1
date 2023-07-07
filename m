Return-Path: <netdev+bounces-15989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4531474ACBD
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A7F28169C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C53D8836;
	Fri,  7 Jul 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EB8BFC
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBB3CC433CB;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688718020;
	bh=CYPQTK9RqFo15OCT/irZBM7Z3etVErPytur4jALsHXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZY2HYIiH8fz7sYdDlbcVe3cdtfDPrW9QE3kwj20aeuOJCvYe0IKzCmcu/ITnY5nuU
	 qtFdx8sX/c4ovK2hw/4CjYwWEWJYe5dSzCg6E1nvKL7HfQwCGtXtLEb7RAwI5+ZNwv
	 UtFIgKaBowqr8Vdo5QODCnO+b8i8c1WFKHWrEDSqn+Br0uQv6p9296REMHXWeEm00g
	 BO+FRQmxvyXA3Ki/YaUL7q18z7ct0J+kyv9tHby/UXtCopL0NqjOlXvusUUS8NP4tC
	 cjeELo1mgXr+ufsfXQMipSs5nFTq2T03qpYUdH7TeNiu5bAv08RGRmCF4cRZ41hThN
	 hFIPOlvOCOtfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCB14C74001;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ionic: remove WARN_ON to prevent panic_on_warn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168871802076.22009.8016386041301793215.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 08:20:20 +0000
References: <20230706182006.48745-1-shannon.nelson@amd.com>
In-Reply-To: <20230706182006.48745-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jacob.e.keller@intel.com, brett.creeley@amd.com, drivers@pensando.io,
 nitya.sunkad@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jul 2023 11:20:06 -0700 you wrote:
> From: Nitya Sunkad <nitya.sunkad@amd.com>
> 
> Remove unnecessary early code development check and the WARN_ON
> that it uses.  The irq alloc and free paths have long been
> cleaned up and this check shouldn't have stuck around so long.
> 
> Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
> Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] ionic: remove WARN_ON to prevent panic_on_warn
    https://git.kernel.org/netdev/net/c/abfb2a58a537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



