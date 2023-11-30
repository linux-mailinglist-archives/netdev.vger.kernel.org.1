Return-Path: <netdev+bounces-52375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C97FE83A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4245B20C9B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFA156E7;
	Thu, 30 Nov 2023 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLV+23At"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1E13FF6
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3652C433C9;
	Thu, 30 Nov 2023 04:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701318025;
	bh=9rSEnLreXmXS5PwATBLKyDpYoRjzUTRYijJkuzT9bmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QLV+23At1wYPmTtjcagLzPYDvbo0sXedrkQS1Yp9x3WTtpMrv2Z/lgJ703xP+1oM3
	 n5NCQU+OZeMDhg/oam2l9K8CYjeUHp/9IzkdWH67Y/Jwfcq7nfVn9NqY4DF5lAlPEh
	 ZyWjcqfSd2KXpGYekE7Zfv7isdKRFsGNU2Xc90ttNYwH3bvR6lGT1sp+sa3t5mPX5A
	 MBGM+py18132ktGwxqiPHcBUy1eIKH229yxmxJiFrp3sC7zBR0xP/kBWj3IA0WN2eH
	 qL+Qn+7BXRNknmF3rLbluYrwqI1b4Km5VYXZB50L7b+S0OaWadTI8kPkKhf7kgpiiL
	 tEWPEyFI9M+Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 970A7E00090;
	Thu, 30 Nov 2023 04:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix memory leak on msix entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131802561.31156.4356058735654465294.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:20:25 +0000
References: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 17:59:28 +0800 you wrote:
> Since pci_free_irq_vectors() set pdev->msix_enabled as 0 in the
> calling of pci_msix_shutdown(), wx->msix_entries is never freed.
> Reordering the lines to fix the memory leak.
> 
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix memory leak on msix entry
    https://git.kernel.org/netdev/net/c/91fdb30ddfdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



