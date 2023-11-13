Return-Path: <netdev+bounces-47309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE07E9928
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A61A280C4D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09315E95;
	Mon, 13 Nov 2023 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjBb3sQQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6431A587
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7B14C433C7;
	Mon, 13 Nov 2023 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699868308;
	bh=U4t+9g3AWgJvV8hcFy83sDq5KYyDYw3cn+Q6uLyPbxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TjBb3sQQpA1Nl319mYdQppRCerLPZYE5OjBamuXQAleoBKU+bkYRaHlB8jPik3NNF
	 jvNLND3erOLA2AcIdhXw/RsTPGgbqak7h4WjCpOK2mwwvMQDzOxVU1gZoU6mTxldil
	 r7lqzQxHTBFENoCQ8hcFKGDus+9F54iF6wzyF0NR38OOahGmVRQhjI7Z83gS1TBXoR
	 i2w6VTcefuocN/YWX1ybLFoOD/xPvCeEEqUHpPN7SF4wQL10et4pjG8j1pZH3mFhEE
	 wDR910SspmJDSaXP+xYwlTPxwpghsunQyrBhLUCegJQQgZyBMCTK5WLw/qbz3YOdA4
	 E7kmN0VhClJZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E3A3E00088;
	Mon, 13 Nov 2023 09:38:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/7] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169986830857.24663.16656088717775298434.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 09:38:28 +0000
References: <20231110093713.1895949-1-shaojijie@huawei.com>
In-Reply-To: <20231110093713.1895949-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 17:37:06 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - net: hns3: fix add VLAN fail issue, net: hns3: fix VF reset fail issue
>     are modified suggested by Paolo
>   v1: https://lore.kernel.org/all/20231028025917.314305-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/7] net: hns3: fix add VLAN fail issue
    https://git.kernel.org/netdev/net/c/472a2ff63efb
  - [V2,net,2/7] net: hns3: add barrier in vf mailbox reply process
    https://git.kernel.org/netdev/net/c/ac92c0a9a060
  - [V2,net,3/7] net: hns3: fix incorrect capability bit display for copper port
    https://git.kernel.org/netdev/net/c/75b247b57d8b
  - [V2,net,4/7] net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
    https://git.kernel.org/netdev/net/c/53aba458f238
  - [V2,net,5/7] net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()
    https://git.kernel.org/netdev/net/c/dbd2f3b20c6a
  - [V2,net,6/7] net: hns3: fix VF reset fail issue
    https://git.kernel.org/netdev/net/c/65e98bb56fa3
  - [V2,net,7/7] net: hns3: fix VF wrong speed and duplex issue
    https://git.kernel.org/netdev/net/c/dff655e82faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



