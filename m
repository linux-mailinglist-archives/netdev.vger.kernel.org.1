Return-Path: <netdev+bounces-207302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05CB06A34
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B29C1A60021
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278132D8363;
	Tue, 15 Jul 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0DOPHr6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEB2D7803;
	Tue, 15 Jul 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623999; cv=none; b=BvC2uiwMq46Tbs8HNQy2aw2UhUvLei1wLNPy1+DtkV2XeZa/UjZICHxFhFlcZhcmbrFz6KS0XgZoasQte9yuys6cQjIlMnlTbdRxDd67ZsdTJ0wKySitJ6oEYh94vhSFdrjGavIlP3FUEvjpwN1RZaOUhYP5+zan9hKN4WFE14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623999; c=relaxed/simple;
	bh=tgH2czOnoOGUkpLM1SSPMTlXXL7+hEPthxtMRn2obwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFa4vafMbGPKOs0Wufhsc/OTda3H5PqoIlDoWWTXJO9jKwhAaP1Tr9Y1t/x0Wj2+WVoLIXtmO2KqxMkhLgOgLelH4uhccLvOFE1+F0FXU6xHvAYMnzKF6xoJIN5ix4vWrsZ1Xsb+/+wK5jUKlC/bbA6f5rl2NSHO7KzFRXBIuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0DOPHr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75922C4CEF7;
	Tue, 15 Jul 2025 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752623998;
	bh=tgH2czOnoOGUkpLM1SSPMTlXXL7+hEPthxtMRn2obwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C0DOPHr6P2unBF70Ne/wpCcQh5JAv/ZikFizLbhF+jZFpU3qnUGxPINjSd2hqJjv6
	 G+A8B+D7pVBI3s9fiMUZQczkdEVDuFc/9M8ap0xWvbJKrp3Kqx1CMpuTzE5mAsxuWs
	 pGWRqSYgUK/LeQz2rpgwROmOKrCuzV8BqBVY3sb8jIDZej07Q9wbWRTIzN5BcamNsu
	 GpSAvXgwyYgZDBemehV7UlTVNVjKp347BXvoKeLv6eOIT4gicC8fZ3tpe02jzt6jLU
	 0Kze8KXUod3tqnWMPkedu17HUPOgtfn2c1nqeq77iWK9BCqsYLFw7Sfjf2p0FCb2q4
	 HpzEGajP9b16Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C26383BA30;
	Wed, 16 Jul 2025 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net-next 00/10] net: hns3: use seq_file for debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262401900.621373.9648094414037251084.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 00:00:19 +0000
References: <20250714061037.2616413-1-shaojijie@huawei.com>
In-Reply-To: <20250714061037.2616413-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, arnd@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 14:10:27 +0800 you wrote:
> Arnd reported that there are two build warning for on-stasck
> buffer oversize. As Arnd's suggestion, using seq file way
> to avoid the stack buffer or kmalloc buffer allocating.
> 
> ---
> ChangeLog:
> v2 -> v3:
>   - Merge patch (11/11) into the previous two, suggested by Simon Horman
>   v2: https://lore.kernel.org/all/20250711061725.225585-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
>   - Remove unnecessary cast, suggested by Andrew Lunn
>   v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V3,net-next,01/10] net: hns3: remove tx spare info from debugfs.
    https://git.kernel.org/netdev/net-next/c/277ed0cc9d73
  - [V3,net-next,02/10] net: hns3: clean up the build warning in debugfs by use seq file
    https://git.kernel.org/netdev/net-next/c/c557c1832626
  - [V3,net-next,03/10] net: hns3: use seq_file for files in queue/ in debugfs
    https://git.kernel.org/netdev/net-next/c/eced3d1c41db
  - [V3,net-next,04/10] net: hns3: use seq_file for files in common/ of hns3 layer
    https://git.kernel.org/netdev/net-next/c/2b65524d106e
  - [V3,net-next,05/10] net: hns3: use seq_file for files in tm/ in debugfs
    https://git.kernel.org/netdev/net-next/c/08a6476e2875
  - [V3,net-next,06/10] net: hns3: use seq_file for files in mac_list/ in debugfs
    https://git.kernel.org/netdev/net-next/c/00f9ea261d9c
  - [V3,net-next,07/10] net: hns3: use seq_file for files in reg/ in debugfs
    https://git.kernel.org/netdev/net-next/c/2363145ad86e
  - [V3,net-next,08/10] net: hns3: use seq_file for files in fd/ in debugfs
    https://git.kernel.org/netdev/net-next/c/3945d94c9f4b
  - [V3,net-next,09/10] net: hns3: use seq_file for files in common/ of hclge layer
    https://git.kernel.org/netdev/net-next/c/9e1545b48818
  - [V3,net-next,10/10] net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in debugfs
    https://git.kernel.org/netdev/net-next/c/b0aabb3b1efb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



