Return-Path: <netdev+bounces-156416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F863A06536
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B49188A001
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212D202C40;
	Wed,  8 Jan 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBdkJBhv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AF20127F;
	Wed,  8 Jan 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364020; cv=none; b=MkaH5b0AKAFdD97u/39GsMA9TWBNIuGf97vRnjInlIFhqUKkigmZWxrajw8BIcXzxj+/0+M/3027+JbLMAjbzbriHtxdH66KMbApDqEXybJbDj82+s+yMmUjDhEjLn6cfOVSdsf8VH+ZHymIfvRN/S2pSvVOeWzyG9+tzLAkI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364020; c=relaxed/simple;
	bh=E7NezZZ6kG0xSzYv8ZQJERZZZAAC+iuu3aqZ6cthL38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8rGOPbcZ4NSTB46TERxjk1nXvibFKJhjqZjhJ5MsOXenkRBLb+az9Z4Ny2X5DlWxSQQVqQ8ML/8qqJYs5Vuj/UsCq4BBnEcrAuDGwyrSVlnIpSRn08SENjit849aKKKSZDQ9FrNmrn1Cx2VSzYtlHMsClkh9mFr1Jz21F5d8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBdkJBhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314B3C4CEDF;
	Wed,  8 Jan 2025 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364018;
	bh=E7NezZZ6kG0xSzYv8ZQJERZZZAAC+iuu3aqZ6cthL38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sBdkJBhvgwrUtAXLixiSNJg8WkqVPh2x818aQn7So11G2IBsxZFR/dGU7QmxQTucF
	 mfWMF7/WUnXjISuQ6FiA8CcHmQW9f6WPuJ1Ez3W7lVdx1vSEHOFwZi5J8ahSdygbS0
	 1lsrpSEig+I4Kc/X1nVJ6lTg5OqTkztFjGyf+bk6/kGB8uttEpPeGOHBP2TsgYccDi
	 bm0lc5eX781JnlVCZhzRUADPhY6h3PvoflQ8OPUgiP4ih0fTb1BgswTwEqRfTM3Dsz
	 D0xH7sC0q27fKzI65uEthYYoMLMwNxSc3J5i0EdRaTn92cnXLjRWTerw8HVgmh5Ye/
	 2fyJgkydAo36A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCC380A965;
	Wed,  8 Jan 2025 19:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/7] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173636403949.752119.2386728515065295072.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:20:39 +0000
References: <20250106143642.539698-1-shaojijie@huawei.com>
In-Reply-To: <20250106143642.539698-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michal.swiatkowski@linux.intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Jan 2025 22:36:35 +0800 you wrote:
> There's a series of bugfix that's been accepted:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=d80a3091308491455b6501b1c4b68698c4a7cd24
> 
> However, The series is making the driver poke into IOMMU internals instead of
> implementing appropriate IOMMU workarounds. After discussion, the series was reverted:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568
> 
> [...]

Here is the summary with links:
  - [V3,net,1/7] net: hns3: fixed reset failure issues caused by the incorrect reset type
    https://git.kernel.org/netdev/net/c/5a4b584c6769
  - [V3,net,2/7] net: hns3: fix missing features due to dev->features configuration too early
    https://git.kernel.org/netdev/net/c/ac1e2836fe29
  - [V3,net,3/7] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
    https://git.kernel.org/netdev/net/c/5191a8d3c2ab
  - [V3,net,4/7] net: hns3: don't auto enable misc vector
    https://git.kernel.org/netdev/net/c/98b1e3b27734
  - [V3,net,5/7] net: hns3: initialize reset_timer before hclgevf_misc_irq_init()
    https://git.kernel.org/netdev/net/c/247fd1e33e1c
  - [V3,net,6/7] net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue
    https://git.kernel.org/netdev/net/c/7997ddd46c54
  - [V3,net,7/7] net: hns3: fix kernel crash when 1588 is sent on HIP08 devices
    https://git.kernel.org/netdev/net/c/9741e72b2286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



