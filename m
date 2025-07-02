Return-Path: <netdev+bounces-203067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8156AF0738
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EBE7A4B49
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B78F5C;
	Wed,  2 Jul 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dol2VaEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9C611E;
	Wed,  2 Jul 2025 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415583; cv=none; b=Mt8DKA4QkNNlUf2L0Ptm5QUc7qDTT9lQDLx7FD2M2zW6xyMl8fST5R/LMF9ZMbMxzCejM0gdyQC1M1gD0BFy8qX+q2NfCm6jSwhV1dRTxOoNbOdzOxhCHPEzXyUd3Aegbv/mW6ROQhiKPANR3UVLckSmdzy2v8+DORTaWYDuyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415583; c=relaxed/simple;
	bh=4DaWXPHuR88RaLcmPll2/wduEqRs83p/WfrwXFl1YNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aTYsidNCOg8kG0oSekrkV5Ltcz3ut4h/v553QKF3ZbN9qIsB9pCx6FTVqYgl05EFZ8KEzFTtr38XORLeUmiK+UbG7qnwmv9XGi7C+fborrlCkNaws6qcYYYtHApw68RZV97nsqauJxWeasRiW5Lom6hppQH+cAikjkwaCB2V3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dol2VaEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B207DC4CEEB;
	Wed,  2 Jul 2025 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415583;
	bh=4DaWXPHuR88RaLcmPll2/wduEqRs83p/WfrwXFl1YNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dol2VaEa9NrRUPqszDVzPaQCEXXbzfMIz6L6cVL458UL/YaEu9NiRSvCSqNi8ocyy
	 TBJ57U6HvVDSJZUgEbSoWGK9kf/rMzlQb1w/pG1v8sRmiUHVFsN8AbzA+/FHv2rRos
	 kZlZry+J18C+fUDCW17t3SM6jeD/Qb1mhIr9WJHXbSqeQ9i1ukhsTgyOO/YbY9LSn9
	 S5/7ffwDA2KZCyvAD8XEw4MXQnBtRVG2QgE8Vj93jESMGssthk7iK6BQOg7N799/ru
	 xqi0YAc9fSXHw+aDePnhOhbi5Q16ODA2qiLcpXFUKHN1FCxsRnYS7HnZRVMgEzoLfh
	 t6wx3UIB1EfmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4A383BA06;
	Wed,  2 Jul 2025 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sfc: siena: eliminate xdp_rxq_info_valid
 using
 XDP base API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141560850.155437.10463020454884868658.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:20:08 +0000
References: <20250628051033.51133-1-wangfushuai@baidu.com>
In-Reply-To: <20250628051033.51133-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 13:10:33 +0800 you wrote:
> Commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sfc: siena: eliminate xdp_rxq_info_valid using XDP base API
    https://git.kernel.org/netdev/net-next/c/ca899622c528

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



