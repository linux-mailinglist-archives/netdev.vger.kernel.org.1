Return-Path: <netdev+bounces-75662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8F86AD9C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4A28F596
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8B149E0C;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzzUon/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55140149E01
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119832; cv=none; b=EYS830Kh4rBDAhA9ODZ/CbInbRbfty20VJhF+tigp2UKRwnQM6ieN1M1uGIgy4nRwqiiMevcO1ogV5HEFXshHRUcocnCh7xHTxUJuQrrzhi2NuWJKpVAWCTh13/Cp4LeDSxm2gas18z9gOUh6a3sYnaLPiwkzUW3CEI5aR58WVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119832; c=relaxed/simple;
	bh=dExqIoBq9OUXPmisyTjHXVaNhd4OMse1HCeHa7BuDkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ctc2yn2JljUQqWRGuWDviXX6iCF2EJ04W1zRbJzlAF3ErwMQq91JjErpBVCwKnyYal433+aW5WDYcixaOMMmJ4FehjRoLqmHLeuBqjI3Iab2Tj7TKB6zV5iBfceKd0HTgxechDE4MBL+TKHObFlqslk0XHLeCe2Q7f7/XiP/92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzzUon/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01033C43399;
	Wed, 28 Feb 2024 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119832;
	bh=dExqIoBq9OUXPmisyTjHXVaNhd4OMse1HCeHa7BuDkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tzzUon/l8O55u8gLyHwy1hOvwKy6tyI4eMQA+1tD38KiizLJoKE4aWddPGa5NSxIJ
	 fEvuwkIEJYnlJvta4W4u9WKJTRO3mccT0nUviAixPA0CN/MNNcFmIHV3mLxK930tFs
	 VAOd4HGg2JdxU2yZVT8V6EUsqzYwDYblifYmnXjn/ozEmkk8TcwQo9ubEwQL62Pebt
	 oE9sU6tPVrfY2Lj0YY3HVmw07XW/zRymqZ46zUzCOk1e5t4MI35Z7LYX00TNWtLD4P
	 nnQFIvRVbcPSIOWdMN7XfpaHxbZ19QJ2/GZ3kNGjfwtZXCgIxA5+fJUQhL0ErObSRz
	 oaGOH7+tE47eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE067D88FAF;
	Wed, 28 Feb 2024 11:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] stmmac: Clear variable when destroying workqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911983190.5841.7484242460715131155.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:30:31 +0000
References: <20240226164231.145848-1-j.raczynski@samsung.com>
In-Reply-To: <20240226164231.145848-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 17:42:32 +0100 you wrote:
> Currently when suspending driver and stopping workqueue it is checked whether
> workqueue is not NULL and if so, it is destroyed.
> Function destroy_workqueue() does drain queue and does clear variable, but
> it does not set workqueue variable to NULL. This can cause kernel/module
> panic if code attempts to clear workqueue that was not initialized.
> 
> This scenario is possible when resuming suspended driver in stmmac_resume(),
> because there is no handling for failed stmmac_hw_setup(),
> which can fail and return if DMA engine has failed to initialize,
> and workqueue is initialized after DMA engine.
> Should DMA engine fail to initialize, resume will proceed normally,
> but interface won't work and TX queue will eventually timeout,
> causing 'Reset adapter' error.
> This then does destroy workqueue during reset process.
> And since workqueue is initialized after DMA engine and can be skipped,
> it will cause kernel/module panic.
> 
> [...]

Here is the summary with links:
  - [net,v2] stmmac: Clear variable when destroying workqueue
    https://git.kernel.org/netdev/net/c/8af411bbba1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



