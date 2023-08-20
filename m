Return-Path: <netdev+bounces-29151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FD781D4F
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 12:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49FF1C2032A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77615AC;
	Sun, 20 Aug 2023 10:06:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA610F1
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 10:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 344D1C433C7;
	Sun, 20 Aug 2023 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692526000;
	bh=Ciy/RyX0njnAdvkTZfUIYAJg14ECsoJSonV2REdZ59k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6PeLunbguULiDrEAn8DXJV/thWXNnK2xVdSTmTmnJv6/2e3ySEyjeh+pDIRfPgyt
	 CRChx4AByB2DQjGMVWw5ps36w71JC0rK/qFrozjWL9kKnuSbZgHHSLsjolSXtv/+lN
	 KObd/Ywt7DxxNoClhd7rf1um53wo1EohCb2Dg4TT4KAzkcxJWV1/REgRxpjtKaJGqj
	 iZvTqZ87o3Fg6qV5t6POFFKF1xM2z7lh7zVqFFUgDUA0nYsgE8JSHPDeXI7ALUL8iU
	 18voTWuASYAqHzrqw93708Gzfefsdj7gDHTCsYz0p7/6QXWdmVWM1dVcvIhWvwtcX3
	 ktFCpZhNqdUkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CAB7E93B34;
	Sun, 20 Aug 2023 10:06:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: Fix return value check for
 fixed_phy_register()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169252600011.16180.10039530798927663368.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 10:06:40 +0000
References: <20230818051221.3634844-1-ruanjinjie@huawei.com>
In-Reply-To: <20230818051221.3634844-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 opendmb@gmail.com, florian.fainelli@broadcom.com, pgynther@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:12:19 +0800 you wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> Changes in v3:
> - Drop the error fix patch for fixed_phy_get_gpiod().
> - Split the error code update code into another patch set as suggested.
> - Update the commit title and message.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: bgmac: Fix return value check for fixed_phy_register()
    https://git.kernel.org/netdev/net/c/23a14488ea58
  - [net,v3,2/2] net: bcmgenet: Fix return value check for fixed_phy_register()
    https://git.kernel.org/netdev/net/c/32bbe64a1386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



