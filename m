Return-Path: <netdev+bounces-26600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C4377851A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E5281EA9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A368811;
	Fri, 11 Aug 2023 01:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90C7F1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E753C433C9;
	Fri, 11 Aug 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691718620;
	bh=MIuozqkZQPdiui0wTMozc3wjugn42WVwN3d9+STl/i4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rhTZYmUxy1H4JR81XSecjJ4XqjLUmD10Y//zgD8ah7WAOLREvfwRf4zrMkH6H/UHi
	 aBOk8D9034rLQmPzbPNeci8dqFcOwy4GWWoKotB4eW0eKvk4m7pDucwhlPfczzeeVP
	 ug78dyg2awWuBK/S3aaw4N1IdwcX2Jv/M5O2rQwgaFhwVSc4X0aTqkbZG8QLBRPoOv
	 lCF/x9qUS5n2yuy4ErRwhQ4xQK9Ph8HHA24UNUdfSmI3fr6KkwMsk8joaShNcdVJXa
	 dv4ZOfBpIMCBcxphOvIa4zUuDNaxnUaoK+9v9tQ6jxtKZ9TrwcD1IACTFgavGGfxi9
	 eH37vVig7XJDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8601CC39562;
	Fri, 11 Aug 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: caif: Remove unused declaration
 cfsrvl_ctrlcmd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169171862054.26303.8151661131363401658.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 01:50:20 +0000
References: <20230809134943.37844-1-yuehaibing@huawei.com>
In-Reply-To: <20230809134943.37844-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 21:49:43 +0800 you wrote:
> Commit 43e369210108 ("caif: Move refcount from service layer to sock and dev.")
> declared but never implemented this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/caif/cfsrvl.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net: caif: Remove unused declaration cfsrvl_ctrlcmd()
    https://git.kernel.org/netdev/net-next/c/4a8d287909c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



