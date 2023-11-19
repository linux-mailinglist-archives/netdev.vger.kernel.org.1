Return-Path: <netdev+bounces-49063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68747F08C3
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A3280A6B
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A73199B9;
	Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nub3qUki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED199B0
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A27CC433C9;
	Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700424624;
	bh=HRD1g/Jg79BVdEVmw3D4m9NCyvHQqfhE4tHAafr4fOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nub3qUkigHguAg7eC2AAhWhFyQGOUkJYFA8zUnNTQZkonTbOr8q/NIZrVHHPKpZ++
	 f7XLd8uxgstUvX+5nvjL4hxqrMHhDg0CVyZbF2stJj8BTj+IXQoIzYZUtF6u3VV6wd
	 6og49FuA75kX6etW0XuvMl92WFDvECUfsl5TSsGB1mbfodx1vIUFXUuqN1RcxezA05
	 FrCOlyr94U2h1FsNlmsH64Hc+RDNRLy4ZcFCaqJP5yNLR3h274IuZap6Sfxih+eKc3
	 17wEGCixXzv9i4eGda8Sre0ixuAhTuBk1qDvZHBA/Edwi5SYkeierOmlG21M0zT4vj
	 1ENzDW+pI3Qqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4BDFE000A4;
	Sun, 19 Nov 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: Fix memory leak during interface down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042462393.21508.8737738082545699896.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 20:10:23 +0000
References: <20231117104018.3435212-1-sumang@marvell.com>
In-Reply-To: <20231117104018.3435212-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 16:10:18 +0530 you wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Updated fixes tag
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: Fix memory leak during interface down
    https://git.kernel.org/netdev/net/c/5f228d7c8a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



