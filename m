Return-Path: <netdev+bounces-83221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B420C891651
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B7C1C22F2A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690E50A72;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpURVzf2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3F4D9E4;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705831; cv=none; b=qd2iPnhxGTm7Ef1Mt9mcsPaXMR3t72CWJT7fcIuDyfHBk/hhDz1+ozdlQ06dISKDJM/xgTzBEX5pjjeDd8lz0bi4vrhtsjmGhTgSMidxp254UchefesM67hCXIc7T0xUKP7Cd536iwZQp/T/5QWQPhv45JWwh6+SuUfB/zEvd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705831; c=relaxed/simple;
	bh=2rRdkz47cqYTeL1U6l+teCPoMHd8pgrqQtj2K4BJCJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGLRgdkSe3ApHF982vYqOlSSB59FhkfbWBwsKzqIIst5Cs9TkCIdBeqH5aGveTGrO0cbN2XAaO3aZ+AJ9Ro6YUkEd0G0b/qTqqzt2aNpDRMEiuA5mcnch1YzhX4R2ckrqb+jpU2PmpVnZ8yKca7hjJMMmx0vYU6z2tgQyk0pt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpURVzf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42F25C43394;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711705831;
	bh=2rRdkz47cqYTeL1U6l+teCPoMHd8pgrqQtj2K4BJCJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BpURVzf2whtdThobM14Y0UE2sXO8VEioZzyYJfyj+yPssP3LttmmJu+5577bwZsPs
	 KgxV87tC1t7bHqbYzP4AGOIy41YEcC+t4qYy/oo2g+Oa6AZ/RpBRa3k9BVkgowFbGi
	 2nb+5f60B4KxqchodFay0UJcVJ0S8EUCWroInuUw8Ykx0yc8EHWl2IJE+r6asrAaOm
	 qr5c7Ho1MW71me2COcOTbinNkAYg3kcWExrP+HAayaio/Dm8UF7k7aJD8cjQepJBvX
	 tvkWUAowQhn3oSr5XYPXuLsRW0zODTEe2Fv0BPu/sUdnXf1CExnCX1FRC3++6BUfCY
	 kRnE0LMxS3Y+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B189D2D0EB;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,RESEND] net/smc: make smc_hash_sk/smc_unhash_sk
 static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171170583117.24694.14035587476923647131.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 09:50:31 +0000
References: <20240326072952.2717904-1-shaozhengchao@huawei.com>
In-Reply-To: <20240326072952.2717904-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Mar 2024 15:29:52 +0800 you wrote:
> smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
> static and remove the output symbol. They can be called under the path
> .prot->hash()/unhash().
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND] net/smc: make smc_hash_sk/smc_unhash_sk static
    https://git.kernel.org/netdev/net-next/c/af398bd0cb21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



