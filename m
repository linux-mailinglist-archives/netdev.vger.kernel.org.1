Return-Path: <netdev+bounces-105854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA0913306
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669431F22C0B
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77314D708;
	Sat, 22 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCghPO1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FA14D283;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719052830; cv=none; b=onF4ppPOuAJQMIJSy+3rabOi36CXpw+GzfhNHOSxDlzH76LXxjPv9E/6AfqKOWe+GrHUISS+c5qYBsWsjyHiXjf++beQKfPXGeOObAtwLPCtAyv5BbjdNx3IQIFIctBzDL5qtgvaxm/ppw+Fge4WW1garQ3c1fncE8TuSVTntC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719052830; c=relaxed/simple;
	bh=mWJ94SzV2JikaOg+G2Vcy7tPZ0yWItKwK0O4bbaxP/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZ4XKUH/3dv3aIewn1H3ypCn7xKLjVc3tvucq2qbvS1mnYwIx5W0ma8vQcHlsLnVEVVvjtkwdhjpTFMReK1JilrnNjYueTINhqkTroP18qu6Ivaou8BE6JtwaH4+jbMYWyuptIvmlWiDw09UQM4Wi0bmyuo7lIZyHrTTyi4hCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCghPO1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65192C4AF0C;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719052829;
	bh=mWJ94SzV2JikaOg+G2Vcy7tPZ0yWItKwK0O4bbaxP/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WCghPO1RdIH2p/jgw6g1NkZ1PsatWklPtnQyAGrT9256GyjsuC0pIyYe3ZffTDNm/
	 br+t1tfR5hu8j+ESZnUH2mQho9xCxJfC2sZEcd1IyDydkx4rc/CVnGomMOXFSkchBW
	 XYYwZO3JBZ6FVrME5ad7RYZPaCWD8pW4zN3BYbJmPv1o+kgsWF4LiMHCZCMjYDx4+P
	 sq9f/W+wPlFdg0hNl9WrFL+wcv+iGafatxCmYSzQS/tsv73T2K093fTWSHU8nNZcAW
	 8UXxG8lzsZ9NAi+Ac0CK9HMX/bYwF4ZRckIFjGkfvmm1SCzMvo9uKHJWWaL9PEnuNI
	 7IUeva/3wSbnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B88DCF3B94;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xilinx: axienet: Enable multicast by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171905282937.9713.8828756778690498046.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 10:40:29 +0000
References: <20240620203943.813864-1-sean.anderson@linux.dev>
In-Reply-To: <20240620203943.813864-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org, michal.simek@amd.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 16:39:43 -0400 you wrote:
> We support multicast addresses, so enable it by default.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: xilinx: axienet: Enable multicast by default
    https://git.kernel.org/netdev/net-next/c/185d72112b95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



