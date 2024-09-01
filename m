Return-Path: <netdev+bounces-124052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F939967B6F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596E71C21516
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF5183CB7;
	Sun,  1 Sep 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf26N+xf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93626AE8
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211233; cv=none; b=F/keOFKeiyhs+GfA4+i1OWrOWGr6snTiNnWZPjsE2RRdawD20yQUE91cZoFu7A+hs6vWOYHujx6Q820efk6mtokdzR7YiLjP+LpQR6rxhGumYtqxdPlt/F4ddpTfsRB8ihPitXrVzfvOJi8etkM0+rGQfnfnh93OwbbKJKWpVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211233; c=relaxed/simple;
	bh=7MZdETR+RcuZvd9PA3dxx59UMzmfai+/xMkNVuobVE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e0yWUIG728gdprMyOQBw1OLlF8frO4wTYJL4mD0N/iYiZ3jgrK9yqe+/R3yWVy0WBv7Aj46X5Q0KMfxOudjK3N5RfMrz6SP/rkErIDKfpCu48vzxv3A682mb79O/CmyrRrgQWkuRyq9JxbyEPk4/0XDqeMiHLLlSC5zi/GuCskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf26N+xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D4C4CEC3;
	Sun,  1 Sep 2024 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725211233;
	bh=7MZdETR+RcuZvd9PA3dxx59UMzmfai+/xMkNVuobVE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tf26N+xfM24S48qGmkAj+JwXOx452rR3yNMcAUpW9ATJJ7ln1mIB8to9DqSlFAPyg
	 jng47Ezk2fW7pf5LjlDp4yZqf0Lv9y5bDzM9xts0eq5eeRNCPRJgeU8FJd/T7b4M3n
	 o8MuBmtK1jg1sVZ4JapYZVZrteZibnnVbI9VGoAt9ur2xdz3PPtEKkSZONwhq8eGRS
	 3B10Zgl4kEgIFYyz58sPKWfMEH7X/HK+ln0+9sm1dSqxu1nN+tBnXA36OkWxeTUsfl
	 aNLDQbwTOMc4t0iDLKi4y6sqTzH+3SIUIXVOCq6LWb2c7+zoYCdLCQiTDsjFS/vX1n
	 w6A4LUnewPs3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6C3822C86;
	Sun,  1 Sep 2024 17:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2,0/3] octeontx2-af: update CPT block for CN10KB and
 CN10KA B0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172521123399.3369914.16589380550370525656.git-patchwork-notify@kernel.org>
Date: Sun, 01 Sep 2024 17:20:33 +0000
References: <20240829080935.371281-1-schalla@marvell.com>
In-Reply-To: <20240829080935.371281-1-schalla@marvell.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
 lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
 ndabilpuram@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 13:39:32 +0530 you wrote:
> This commit addresses two key updates for the CN10KB and CN10KA B0:
> 
> 1. The number of FLT interrupt vectors has been reduced to 2 on CN10KB.
> The code is updated to reflect this change across the CN10K series.
> 2. The maximum CPT credits that RX can use are now configurable through
> a hardware CSR on CN10KA B0. This patch sets the default value to optimize
> peak performance, aligning it with other chip versions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] octeontx2-af: use dynamic interrupt vectors for CN10K
    https://git.kernel.org/netdev/net-next/c/4ebe78e15b95
  - [net-next,v2,2/3] octeontx2-af: avoid RXC register access for CN10KB
    https://git.kernel.org/netdev/net-next/c/1652623291c5
  - [net-next,v2,3/3] octeontx2-af: configure default CPT credits for CN10KA B0
    https://git.kernel.org/netdev/net-next/c/5da8de8cb3e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



