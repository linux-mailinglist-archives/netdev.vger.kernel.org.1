Return-Path: <netdev+bounces-187261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A186AA5FC7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20427B3BAB
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA41F1932;
	Thu,  1 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR8rwqV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140F1F1513;
	Thu,  1 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109193; cv=none; b=Q1foWc7G5mmR+Ke+kgJ6CcLdUro62nMpKlQvoslEJclCfZCKzQ5/iqiD8tnN/9FVYOsh7Ikb+P0sseJkJ2H9DlMDquzHfW+RVda2Kw/Km2e/WFfKJ8lqIk16L8k5DaJY5435SFtAPt7+Rna/6i7IbTwKkmz0niWx/zg6OQjDxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109193; c=relaxed/simple;
	bh=pO2NnunOSN24JmQF/ksUCdUUhbN9haI8sI7qfylU7EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRwEmdIKRwOapggnDjUdKXUXtWWjVaHJhBdOdcglhxqRo1EkJ8Ba1uQ3zegrUyPVC/9HagKgu05DLlAnJZNBSUUyPee2rMdy5yoBHEPsORsV3j9bO40dDPuVUesiHVUHzhkIMArm/4bqC/P5oDIU+c2gwDmfq+Q9xhdD1SqOAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR8rwqV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DCEC4CEE3;
	Thu,  1 May 2025 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109192;
	bh=pO2NnunOSN24JmQF/ksUCdUUhbN9haI8sI7qfylU7EI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SR8rwqV90xEGm+J2b5ZD0xjJ6RIDE4pBO/oqrRODgwLI0MHgAw0WDUPo1eEcuYa/2
	 NRf5l1fKSRiT7NAZwLruwJIJKphSBavHsgDooTwHWzxukz5+i92moR2GbL8NSAY5y9
	 s5j8mcAbXCVfrs0NjoX9B/2MKjNMa5Uc34UeQZ8mtfz6Eta8rsYcRWXGbdmRr9THQP
	 g2KaAgixnlUVoQDK1iR6wK8Ka4skWpzTcB6uqwPZc1U42/BuwiycvSIPixgZqYDljx
	 HqOHcOlRqB459VEh5KsT+bfLQMlF09IK+rMd6wyyRcNjrQdwabOm4K4yI2foGnKTaG
	 t05Jy3fk8WuVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7A3822D59;
	Thu,  1 May 2025 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: fec: ERR007885 Workaround for conventional TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610923200.2992896.532106335830602410.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:20:32 +0000
References: <20250429090826.3101258-1-mattiasbarthel@gmail.com>
In-Reply-To: <20250429090826.3101258-1-mattiasbarthel@gmail.com>
To: None <mattiasbarthel@gmail.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, troy.kisky@boundarydevices.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mattias.barthel@atlascopco.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 11:08:26 +0200 you wrote:
> From: Mattias Barthel <mattias.barthel@atlascopco.com>
> 
> Activate TX hang workaround also in
> fec_enet_txq_submit_skb() when TSO is not enabled.
> 
> Errata: ERR007885
> 
> [...]

Here is the summary with links:
  - [net,v1] net: fec: ERR007885 Workaround for conventional TX
    https://git.kernel.org/netdev/net/c/a179aad12bad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



