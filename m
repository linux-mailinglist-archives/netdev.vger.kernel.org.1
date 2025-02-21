Return-Path: <netdev+bounces-168369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B2A3EAAC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5D77A5A82
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E11DB124;
	Fri, 21 Feb 2025 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF3BW8Zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53531D9A5F;
	Fri, 21 Feb 2025 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104214; cv=none; b=c1N25lxs0HiLVbmtWLRbo/BaGp++igTaYhTAAO8Kde3fOIEiqFvYt2DGLTNxih4HrfqMMsJqxKl8/SnkTpku339iLTAfFQ41F6pLjnsQp9CFPKVHUd/P4+93VUNvh35VJHDNHqVURN1XnTNlsSQ4xUPLtAyXPpXngVMHAgINtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104214; c=relaxed/simple;
	bh=IIZUhe4iqiKE9td0sdnXsAYcdEj5Wq5rgkzqXAp2Gfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GUGZ0hrCzSfwVw59nqE3bAX/w0x3jSxtEBZOiAXj9nbs7zfLgaThQhD/Wgakudy2/JsXaZ5VhxRduR3nDHaodxmbD83ndRQqq2IBWM+ul0cYBnNwbikY6YGdp83AUXe98nwbZAl/G/c0zHPqA0eV/7F1XJceCdY+9na16GycfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF3BW8Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AABC4CEE8;
	Fri, 21 Feb 2025 02:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104214;
	bh=IIZUhe4iqiKE9td0sdnXsAYcdEj5Wq5rgkzqXAp2Gfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HF3BW8ZhHh6fHsWG+NqTt3xEhjZlxjF+f8Wo7ui89XUWw5tzxafHCO03osgZiicIS
	 1iUAHsPpxjuSZ1Cf1G/6xOwJ6Tyw2xs0I5Kqu3e1cdvc3xxkw0qjgBZQSJTh10UUP/
	 ztaFTZiEjOFp0YUBkzr89NBXlrDzGKVs514xSwdDlzI7e1DttorFz+9NPAqzoc9kHl
	 YbSKrUKxaBX3bGyXJaeOoI/cjNcrmnpcTDfv22LU26oiok3xoabArdyC+tvBpC48Lx
	 UTKyPzOV8/F0dJ18BUsAqrk1/+YlasOB2lkCkOQ7az1ahzBCWdl+W87yK+x3R3b7qa
	 1QJ9rln0IMD8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF23806641;
	Fri, 21 Feb 2025 02:17:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next v2] octeontx2: hide unused label
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010424499.1545236.3393470473825318769.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:24 +0000
References: <20250219162239.1376865-1-arnd@kernel.org>
In-Reply-To: <20250219162239.1376865-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, arnd@arndb.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sumang@marvell.com,
 saikrishnag@marvell.com, ndabilpuram@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 17:21:14 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch introduces a build-time warning when CONFIG_DCB
> is disabled:
> 
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: In function 'otx2_probe':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:3217:1: error: label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c: In function 'otx2vf_probe':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:740:1: error: label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2: hide unused label
    https://git.kernel.org/netdev/net-next/c/ca57d1c56f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



