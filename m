Return-Path: <netdev+bounces-152831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2117F9F5DB9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8A5164C84
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211214EC55;
	Wed, 18 Dec 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA/2wcBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4514C59C;
	Wed, 18 Dec 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495016; cv=none; b=aQEkH78VJ8K7A9BHKhuoABVVlon65V6C5+xtopnNL1tNHilNw6ahRoruuH8OD/0Sm3jzzeNYW52voXKqb8MbhN3sETzTl289YWMm1VNSvF4/22KuN8JXQEAZ18Xoa1ezr8VRSyIaSGms5rpq5uUp4r6kexGPWVzZkYn27B4mXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495016; c=relaxed/simple;
	bh=SSoUXPmEJohvEeMvRelhBNetdjvWJ0JEJcf6dssRex4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mbZomjH7ePcAKPb6mRhQuZ9VAsdI1x6SbGMz4OfyO//3yKiIHOrCvnH6/Vjd9DyBthagtNNNErCsbT4mVbP5S84k8pWCbHpaAnL4KAJpFUE5e1uroKGvql+L6XdIbfUkruxVf6q5a+f6VJr/C9yeISmVoEvAhm+1ePDn0CBKiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA/2wcBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C918C4CEDD;
	Wed, 18 Dec 2024 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734495016;
	bh=SSoUXPmEJohvEeMvRelhBNetdjvWJ0JEJcf6dssRex4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RA/2wcBMhscuaO+uHLW4kJQJRFiVXQcX/0Nd29okzCm/eqXEWgcM0B3Nf+hVqvA15
	 ncYTc66wJmqEzBL+mm9LLD6C8KdQLsVyZADCF4wucIaGtG6ZbhEqnOHPrueSwpubeI
	 eqNZ9patPydhlJvqB6CwOZLtqP/gSs+3y5wUknzX3yy0T5mnDV9lgCAmsC6fde7v4z
	 B+SweB3jewrwe3ga8WoOgfMu5oJFYhfBHGj3QnJ2hzAm9OtF1xlxgdrOM0grJJu2yu
	 acrF3vRXu6zUGv/jyHGUexbSRdNlpbeKBapuBeUY3h1w18oDkbt2Ezq777B9YXgDd0
	 GF+1aRSaEtpNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCF3806657;
	Wed, 18 Dec 2024 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V8 net-next 0/7] Support some features for the HIBMCGE driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449503400.1173615.8949453426330063771.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 04:10:34 +0000
References: <20241216040532.1566229-1-shaojijie@huawei.com>
In-Reply-To: <20241216040532.1566229-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 gregkh@linuxfoundation.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com,
 xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hkelam@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 12:05:25 +0800 you wrote:
> In this patch series, The HIBMCGE driver implements some functions
> such as dump register, unicast MAC address filtering, debugfs and reset.
> 
> ---
> ChangeLog:
> v7 -> v8:
>   - Use kernel public helper "str_true_false" instead of self-defined,
>     suggested by Jakub.
>   v7: https://lore.kernel.org/all/20241212142334.1024136-1-shaojijie@huawei.com/
> v6 -> v7:
>   - Optimize the wrapper name, suggested by Jakub.
>   - Delete table_overflow to simplify the code, suggested by Jakub.
>   v6: https://lore.kernel.org/all/20241210134855.2864577-1-shaojijie@huawei.com/
> v5 -> v6:
>   - Drop debugfs_create_devm_dir() helper, suggested by Greg KH.
>   v5: https://lore.kernel.org/all/20241206111629.3521865-1-shaojijie@huawei.com/
> v4 -> v5:
>   - Add debugfs_create_devm_dir() helper, suggested by Jakub.
>   - Simplify reset logic by optimizing rtnl lock, suggested by Jakub.
>   v4: https://lore.kernel.org/all/20241203150131.3139399-1-shaojijie@huawei.com/
> v3 -> v4:
>   - Support auto-neg pause, suggested by Andrew.
>   v3: https://lore.kernel.org/all/20241111145558.1965325-1-shaojijie@huawei.com/
> v2 -> v3:
>   -  Not not dump in ethtool statistics which can be accessed via standard APIs,
>      suggested by Jakub. The relevant patche is removed from this patch series,
>      and the statistically relevant patches will be sent separately.
>   v2: https://lore.kernel.org/all/20241026115740.633503-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Remove debugfs file 'dev_specs' because the dump register
>     does the same thing, suggested by Andrew.
>   - Move 'tx timeout cnt' from debugfs to ethtool -S, suggested by Andrew.
>   - Ignore the error code of the debugfs initialization failure, suggested by Andrew.
>   - Add a new patch for debugfs file 'irq_info', suggested by Andrew.
>   - Add somme comments for filtering, suggested by Andrew.
>   - Not pass back ASCII text in dump register, suggested by Andrew.
>   v1: https://lore.kernel.org/all/20241023134213.3359092-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V8,net-next,1/7] net: hibmcge: Add debugfs supported in this module
    https://git.kernel.org/netdev/net-next/c/86331b510260
  - [V8,net-next,2/7] net: hibmcge: Add irq_info file to debugfs
    https://git.kernel.org/netdev/net-next/c/df491c419bcb
  - [V8,net-next,3/7] net: hibmcge: Add unicast frame filter supported in this module
    https://git.kernel.org/netdev/net-next/c/37b367d60d0f
  - [V8,net-next,4/7] net: hibmcge: Add register dump supported in this module
    https://git.kernel.org/netdev/net-next/c/51574da8dce3
  - [V8,net-next,5/7] net: hibmcge: Add pauseparam supported in this module
    https://git.kernel.org/netdev/net-next/c/3a03763f3876
  - [V8,net-next,6/7] net: hibmcge: Add reset supported in this module
    https://git.kernel.org/netdev/net-next/c/3f5a61f6d504
  - [V8,net-next,7/7] net: hibmcge: Add nway_reset supported in this module
    https://git.kernel.org/netdev/net-next/c/adb42b1e0ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



