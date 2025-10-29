Return-Path: <netdev+bounces-233770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D0C180D1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68064FC01C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3C199E94;
	Wed, 29 Oct 2025 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8hSh2qv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378C86323;
	Wed, 29 Oct 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705033; cv=none; b=EpyVqsrVtPvFqdQjWUUDG105wJdXQDcWo/hQUOSU3a96tcsQq0mx6V/SqeZOa+b2/YMoSa7OyjLOmmm8mKkGKXP9HFINRSqUFIfXxhkkk6BtQC7Lm6q+IsPfOTdWstM3Z5uG2QNfecXJSjSDvqMeiUzcBFKNI4beWRRFQHrtrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705033; c=relaxed/simple;
	bh=CVpJtmL1FdG28qO/fDboA1mMwi/59287bA8TQeWmj+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=He59YK1QkYWQN5kB2DLXia3sUir5SAGRIl8pNzh9oApsp+VtnDxFL1mRCzKq1SiMGGJAIeYsuesiJ/zhCISQtKx4R6JJSFNEJPdjKD5MXrHIv/3lt/NTG72vmmva2JwuDgomeVo/zjL/Rxm+N5lOeCjrpcqZPP3d+qtva6Aq9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8hSh2qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D93DC4CEE7;
	Wed, 29 Oct 2025 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761705032;
	bh=CVpJtmL1FdG28qO/fDboA1mMwi/59287bA8TQeWmj+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e8hSh2qvvhN+MTPjiT3RTfr/Pmn3KTUKXUUoeFFiHoBqtYFOhSD2fYE3fzeUa9R6F
	 PmYyPVefsj1VZXN9ZO1Xhmx3bnUjEFA6UrcIPlYaboMDxHo29+2M1RdH7XxBVvGro7
	 xnnPF3xaG+Y9XmrmOJDPl7/LE2f4nOqlvLjOOCWOVf7SQzE83R9b60J8Lvq3iqifqp
	 MyjN97/+orrZMvqM5UseWiPOhCanvEfQLTOexTtwZulGVcUlJjX/rsBXCegBGtLuDQ
	 8yJmQinKZPk4PJ/FPLH/M7u9aIOJ5XZLK7JYItAHywYx9TBKwCuTR7uYaduYW3XPha
	 iM9PHDCaqPL8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE739FEB75;
	Wed, 29 Oct 2025 02:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/3] bug fixes for the hibmcge ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170500975.2468647.13996100995604445036.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 02:30:09 +0000
References: <20251025014642.265259-1-shaojijie@huawei.com>
In-Reply-To: <20251025014642.265259-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jacob.e.keller@intel.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 09:46:39 +0800 you wrote:
> This patch set is intended to fix several issues for hibmcge driver:
> 1. Patch1 fixes the issue where buf avl irq is disabled after irq_handle.
> 2. Patch2 eliminates the error logs in scenarios without phy.
> 3. Patch3 fixes the issue where the network port becomes unusable
>    after a PCIe RAS event.
> 
> 
> [...]

Here is the summary with links:
  - [V2,net,1/3] net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
    https://git.kernel.org/netdev/net/c/12d2303db892
  - [V2,net,2/3] net: hibmcge: remove unnecessary check for np_link_fail in scenarios without phy.
    https://git.kernel.org/netdev/net/c/71eb8d1e0756
  - [V2,net,3/3] net: hibmcge: fix the inappropriate netif_device_detach()
    https://git.kernel.org/netdev/net/c/7e2958aee59c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



