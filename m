Return-Path: <netdev+bounces-28999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50117815F7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E47B281DD8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA563F;
	Sat, 19 Aug 2023 00:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FF365
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3EE0C433C7;
	Sat, 19 Aug 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692403822;
	bh=uyaGsmMY8cTTPeWr2Hgb8UyQc+Hm3udIUMoRvcScZAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0iNqCviGhLgVLzqY444PGMTGi/dNDODsUHQiGPPVPNstY82FWFMwbMbUEbNkPNkX
	 8Hki62NHHyh93lI92WqVQ0WMFvXrSokTLd7wLqMnlPKBNNpypnuPxMyfurXTUG0RGe
	 QzJZYWClUU6zH6vRp4whlznU8OIK+4SY2/weEypmtsZrn0PR/Wq4RvuHOO7U2MpEtB
	 B9np2h0tCUV7G21OHdbBK4dtrBGvfLA55gxjMddforMtYd42n0OVj+MHGquKReNktD
	 +Z/ZPGNk0cJc6n0r27Pv8x34E/C4lwJn9powbYmQ17NpYKk9gACOVvVzbDHm0drEQD
	 GX5XwJOSoUWIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9BB7E93B34;
	Sat, 19 Aug 2023 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sky2: Remove redundant NULL check for
 debugfs_create_dir
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169240382182.13403.14021398893166146263.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 00:10:21 +0000
References: <20230817073017.350002-1-ruanjinjie@huawei.com>
In-Reply-To: <20230817073017.350002-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, mlindner@marvell.com, stephen@networkplumber.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 15:30:17 +0800 you wrote:
> Since debugfs_create_dir() returns ERR_PTR, IS_ERR() is enough to
> check whether the directory is successfully created. So remove the
> redundant NULL check.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/marvell/sky2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] sky2: Remove redundant NULL check for debugfs_create_dir
    https://git.kernel.org/netdev/net-next/c/ee09e9deefac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



