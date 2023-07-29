Return-Path: <netdev+bounces-22494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288B767B5B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB560281B8E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218467C;
	Sat, 29 Jul 2023 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B680F
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FD0FC43397;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595421;
	bh=CVzgXC9UpTonax/nwPWiGfiV6h5o15XXPC6HjaOqWWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BenFgr7yjuXMeXiJSqyItEXG5e5B3wVff6y76IIWPdN07SlSuFoK8VZzl6X3F9liF
	 ry+SE1qDcUMvHTUWk+mBxmrc+EcKgX6cAjcHyjWaYOygKt9JHgmysZFgz0lKK15BiA
	 vBkffYIKw2ZHGKsqliSQCOpySlkzBGIkp0czrAjU15nxCeostI3YZ+WDPqSfX8EDYx
	 RScESqoApXNiEOahMsSnW+Jgp6Zyp01psnesqUu2BwdLkf7LekL47LyXdXm7lGAxOC
	 vqsHipoB/8khRHtuUr+mg4iftd35kK/OYodbv3OYp5SkGOZgO3CrVq5vIB6j9hZwo4
	 SJ26cnZt4u8pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C9AFE21ECE;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: bcmasp: Clean up redundant dev_err_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059542117.13127.947669820837097657.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:50:21 +0000
References: <20230727115551.2655840-1-chenjiahao16@huawei.com>
In-Reply-To: <20230727115551.2655840-1-chenjiahao16@huawei.com>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 19:55:51 +0800 you wrote:
> Refering to platform_get_irq()'s definition, the return value has
> already been checked, error message also been printed via
> dev_err_probe() if ret < 0. Calling dev_err_probe() one more time
> outside platform_get_irq() is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> [...]

Here is the summary with links:
  - [-next] net: bcmasp: Clean up redundant dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/c88c157d25d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



