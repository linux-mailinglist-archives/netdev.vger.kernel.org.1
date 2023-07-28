Return-Path: <netdev+bounces-22102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73657660EC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BD3282572
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69432714D;
	Fri, 28 Jul 2023 00:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C8A55
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 729BCC43391;
	Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690505422;
	bh=uyE1GuGyotxu5uZ+CiGivf0Z7+Sg9bi4jahpZlLPd1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=av6nueV+4Wrg70+X53kYQdEPusecMVf66Ikg92jEATh6HK14T6FJEiMBvYtZIywyU
	 9WToTHp3+HZU0tECTjwMh1cg+1wMea57zn+FNdpEe0AdeM4YyNua6Y46uxsCgpqch5
	 T+2KMK0tsFTTMCn98cp5sfZXggG4pf/x8pXOkfGilT3ctsTpsPvOWnvLAJSXBjAabj
	 9hqAAWWGDBmLlkJgndJFLIk7Scm3QxEZqd7j6Wm3MrRpzl2yL3szrHGYIIuWYwne5X
	 azI37uVdqsPk1tR1AHCvMMhVmyubOZm6/IIfdUK2Df5OVlCiQhGGt3G6SIFNi2s+O6
	 k0T/jSDwbvy+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CFAC4166F;
	Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove unused declaration dev_restart()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050542239.6763.13063250287982847828.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:50:22 +0000
References: <20230726143715.24700-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143715.24700-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:37:15 +0800 you wrote:
> This is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/netdevice.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove unused declaration dev_restart()
    https://git.kernel.org/netdev/net-next/c/d0358c1a37db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



