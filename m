Return-Path: <netdev+bounces-29236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9B782401
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BFE280D1B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 06:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73441869;
	Mon, 21 Aug 2023 06:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365A1389
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F203CC433C9;
	Mon, 21 Aug 2023 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692600623;
	bh=Xarka6BOjfzdYYYwsYm0Lkc3K6ha42oDm55WVIZOBgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAT80IHdO69U1UXgi+d6vs/EeFc0LD5lj83z3kAxZbxZ1QsjKnlF9D9Kjkd0bnu8+
	 d+j8e6eCHenwhgoaOkZXVyubiLgddWc1k59ERVCzv25bYuwFKjgH05CIP487JyOo6Z
	 hK/tty9mDophqXe4fSqo449wTqVUA45uOjdZLWpbPV8rkH9ZIrU8tKFvJI6x+FVFn2
	 VwOVhK+GuJKe9YdwMDuvcDY+eu+VpdfQroHk9YN0xEmeriFcVQGwcxw9Uzu81p+Zyu
	 rabJWccIOxtVBgik0X7De8HNBPPCCdnN0Q+u4JXKgsLuhXKmzTl8sXoR6ONtF+/DeY
	 ksv5eVKuRmkLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D78F5E4EAF9;
	Mon, 21 Aug 2023 06:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 06:50:22 +0000
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 09:55:37 +0800 you wrote:
> Fix some kernel-doc comments to silence the warnings:
> 
> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'
> 
> [...]

Here is the summary with links:
  - [net-next] pds_core: Fix some kernel-doc comments
    https://git.kernel.org/netdev/net-next/c/cb39c35783f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



