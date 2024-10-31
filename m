Return-Path: <netdev+bounces-140679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568529B78CE
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22C3B20EE4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051E19924F;
	Thu, 31 Oct 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7kOt/u8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA689198E83;
	Thu, 31 Oct 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371226; cv=none; b=SLEjx8AYX0bt2IPpY3o7X48+sch9mfVItrbOpQqnp7vnivkzHrR8Hg3VZXDF6LccxAEgC/B9kWfSsb7mIVaLFbqhnBgz3wf6Thz5gRBd7cS0Vj7lCZr4AXHSmSwf4WHCCWQAeWpwKvcZP7zxGpQe7YNL50MVhQUFnfAKhjZbbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371226; c=relaxed/simple;
	bh=YLQ4UN5KY9nH6YRowLB7t4pE4jbaZEG6sqtB2Cq7H5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G821E6mUNdPy2LmMCSSXb2q+nWgUnOCVvjipcr83RmX5auObWRcRGgcvvpkdZPDmhyqIWKYDa2g3IhTsDKpNrwokgtGzfjiK9T21C6AZxjMZZEdeSmtjCpTMIOwiqLx0uFSAhvVE1dGHQm4hB4qtOapdLF5G/Zska6FinAG589Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7kOt/u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF58C4CEC3;
	Thu, 31 Oct 2024 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730371225;
	bh=YLQ4UN5KY9nH6YRowLB7t4pE4jbaZEG6sqtB2Cq7H5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N7kOt/u8hT13Bd5zghXZUh/ki7NeFEcEy0oMr8L3Ph6b56YOS053MIP0o///G/sqo
	 GX6879JFtHKHEeH2wTDW6aoiTpg3rS1dBgmDy6sXT4wFCn5aJ4vWnEZTzPmnbWyd/Z
	 Ujj8swLYRLEhGOQYvy8ySGPRHCPn2J5OZqwZz1PXDVU3jZx4oQDSZf73qyRJ1AXBt8
	 yGZRlxX+C+kKldGvhrGn/4/55E0+X3aeMxhsmw8T3myfmtZUY1hN4HvdqJclVw2UKw
	 /O9bCvKr1r9xvcPIwlhgQ9TnAiwXGURVheIw//vL5l6rLe+CtWU8e9uOeMvWH1EIKg
	 nrbEE74UnnqfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105E380AC02;
	Thu, 31 Oct 2024 10:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/9] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173037123325.1922651.13719151078657706845.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 10:40:33 +0000
References: <20241025092938.2912958-1-shaojijie@huawei.com>
In-Reply-To: <20241025092938.2912958-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, salil.mehta@huawei.com, liuyonglong@huawei.com,
 wangpeiyang1@huawei.com, chenhao418@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Oct 2024 17:29:29 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v2 -> v3:
>   - Rewrite the commit logs of net: hns3: add sync command to sync io-pgtable' to
>     add more verbose explanation, suggested Paolo.
>   - Add fixes tag for hardware issue, suggested Paolo and Simon Horman.
> v2: https://lore.kernel.org/all/20241018101059.1718375-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Pass IRQF_NO_AUTOEN to request_irq(), suggested by Jakub.
>   - Rewrite the commit logs of 'net: hns3: default enable tx bounce buffer when smmu enabled'
>     and 'net: hns3: add sync command to sync io-pgtable'.
> v1: https://lore.kernel.org/all/20241011094521.3008298-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V3,net,1/9] net: hns3: default enable tx bounce buffer when smmu enabled
    https://git.kernel.org/netdev/net/c/e6ab19443b36
  - [V3,net,2/9] net: hns3: add sync command to sync io-pgtable
    https://git.kernel.org/netdev/net/c/f2c14899caba
  - [V3,net,3/9] net: hns3: fixed reset failure issues caused by the incorrect reset type
    https://git.kernel.org/netdev/net/c/3e0f7cc887b7
  - [V3,net,4/9] net: hns3: fix missing features due to dev->features configuration too early
    https://git.kernel.org/netdev/net/c/662ecfc46690
  - [V3,net,5/9] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
    https://git.kernel.org/netdev/net/c/2758f18a83ef
  - [V3,net,6/9] net: hns3: don't auto enable misc vector
    https://git.kernel.org/netdev/net/c/5f62009ff108
  - [V3,net,7/9] net: hns3: initialize reset_timer before hclgevf_misc_irq_init()
    https://git.kernel.org/netdev/net/c/d1c2e2961ab4
  - [V3,net,8/9] net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue
    https://git.kernel.org/netdev/net/c/3e22b7de34cb
  - [V3,net,9/9] net: hns3: fix kernel crash when 1588 is sent on HIP08 devices
    https://git.kernel.org/netdev/net/c/2cf246143519

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



