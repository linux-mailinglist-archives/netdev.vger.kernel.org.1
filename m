Return-Path: <netdev+bounces-86844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C448A068C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F32928AEAF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631E13BAD8;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJo1Hhl9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA413BAD1
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805030; cv=none; b=lA5sSLRCpCngvVmpdyGajouzMm0a2XX2p8zQVYT35C8njO7ugRlwH1e8ln/n5MPLpZLjCQY2W4oje2rkyzj8Ra54mjH2BgOmOARLFiYFcwZX7S7F4BUDtJEYnp8ef8xpFY17SEJxqLPjGLRP+nKbOvVIQOLrUOqoUJrtcy2+774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805030; c=relaxed/simple;
	bh=JEDtdDOfWKKA+OAtLSRZPSwuFfYmhVRinzSXVBGilyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hD1/a3zfjnfRz1dcxybAJ27R2O6F0yjnAOA17PFAYlMmMpjQ2kcgHjd55fOJLoQsjoS/ICn42FWisZWq5kCMEJFQuB8F4byMHsM3HK8aRvuBliUTvrQGv+vgDU7/3V6ptSitIV6d4LMmz7yymU6F7wGn6k62C6D1U6Zk/ZICpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJo1Hhl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E334C43394;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712805030;
	bh=JEDtdDOfWKKA+OAtLSRZPSwuFfYmhVRinzSXVBGilyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJo1Hhl9Gpb93WsuOcfTIUUPS512MG49OuyMoPbHj1UMlAGkwWgWg1JD+dzmRv0sa
	 qlLGOAqXH4Jy+gZmjzcwAKxX5hGPvJRU+jvDXZsggljh1WEPO41T8GWnKmzbAoH/Kx
	 tUY63NLjO/RkkgHQ6HbjdlkTifEusZggaGwzG1t58ly3EFWBrPBr2+Uf6qAaTi2zvj
	 SUk4VMztoaycaulhPv6R+CLh++TKPFZCioiJH9VNOaGwl26+PWDf/6qTlZZF0A//mC
	 k7OkB1x9y+2UR2FDLLdZDVrpftALfb9KWsjn2txrYt3zGhtqwPSB6oHK51BeoPWScW
	 jYLjE0xxCFGug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 131B3D6030E;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] bnxt_en: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280503007.8263.15652807316392607299.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:10:30 +0000
References: <20240409215431.41424-1-michael.chan@broadcom.com>
In-Reply-To: <20240409215431.41424-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 14:54:24 -0700 you wrote:
> The first patch prevents a driver crash when RSS contexts are
> configred in ifdown state.  Patches 2 to 6 are improvements for
> managing MSIX for the aux device (for RoCE).  The existing
> scheme statically carves out the MSIX vectors for RoCE even if
> the RoCE driver is not loaded.  The new scheme adds flexibility
> and allows the L2 driver to use the RoCE MSIX vectors if needed
> when they are unused by the RoCE driver.  The last patch updates
> the MODULE_DESCRIPTION().
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] bnxt_en: Skip ethtool RSS context configuration in ifdown state
    https://git.kernel.org/netdev/net-next/c/17b0dfa1f35b
  - [net-next,2/7] bnxt_en: Remove a redundant NULL check in bnxt_register_dev()
    https://git.kernel.org/netdev/net-next/c/43226dccd1bd
  - [net-next,3/7] bnxt_en: Remove unneeded MSIX base structure fields and code
    https://git.kernel.org/netdev/net-next/c/b58f5a9c7034
  - [net-next,4/7] bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit functions
    https://git.kernel.org/netdev/net-next/c/194fad5b2781
  - [net-next,5/7] bnxt_en: Change MSIX/NQs allocation policy
    https://git.kernel.org/netdev/net-next/c/2e4592dc9bee
  - [net-next,6/7] bnxt_en: Utilize ulp client resources if RoCE is not registered
    https://git.kernel.org/netdev/net-next/c/d630624ebd70
  - [net-next,7/7] bnxt_en: Update MODULE_DESCRIPTION
    https://git.kernel.org/netdev/net-next/c/008ce0fd3903

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



