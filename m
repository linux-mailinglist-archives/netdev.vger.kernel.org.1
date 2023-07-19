Return-Path: <netdev+bounces-18804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A7758B2F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F11C20E91
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2517D0;
	Wed, 19 Jul 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665C1FC6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70763C43391;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689732622;
	bh=GZrsVklu6wW9LRIDBIigNtrV62SEsXbQ+xxiZOxft5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FIb0s6XXYq/T55KzIt+Av0wBEgHCjwPJAodcts8fRWJ6J1jZQlNGPkMQ1tiKO550I
	 xFyhtK8xnKYn/XakGD5CBsTPo0I2nXhjALNanhNdzHENLOUM0ANe3usMv+BTjJtAEt
	 vtE0WTDDk5w7gifeqCH4SMDAZp5zfq3WiAu84Rh79RrX8vtSLpWdWR1LR1QkwgbGTa
	 pDNfcbZE/UuKWCwUcSnnP0eLPRh6sVJ+/wtlaKRyYke1BW3+M4+Xv0gxDOEU7rdu0W
	 GHWh9+Y6WPmZv8dy2n2CsUClZTnhEf85MNfMIVA1uq1IfW8hBv6HzjPO+JtpjWndbD
	 Q9KUAIcKtF3fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44377E22AE5;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] Remove unnecessary (void*) conversions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973262227.24960.1211431370018888838.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717030937.53818-1-yunchuan@nfschina.com>
In-Reply-To: <20230717030937.53818-1-yunchuan@nfschina.com>
To: yunchuan <yunchuan@nfschina.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 irusskikh@marvell.com, rmody@marvell.com, skalluru@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, yisen.zhuang@huawei.com,
 salil.mehta@huawei.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, steve.glendinning@shawell.net,
 iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, mostrows@earthlink.net, xeb@mail.ru,
 uttenthaler@ems-wuensche.com, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 11:09:37 +0800 you wrote:
> Remove (void*) conversions under "drivers/net" directory.
> 
> Changes in v3:
> 	change the author name to my full name "Wu Yunchuan".
> 	improve the commit message to be more clearly.
> 
> Changes in v2:
>         move declarations to be reverse xmas tree.
>         compile it in net and net-next branch.
>         remove some error patches in v1.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] net: atlantic: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/f15fbe46f5ed
  - [net-next,v3,2/9] net: ppp: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/89c04d6c49c3
  - [net-next,v3,3/9] net: hns3: remove unnecessary (void*) conversions.
    https://git.kernel.org/netdev/net-next/c/14fbcad00fe5
  - [net-next,v3,4/9] net: hns: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/406eb9cf6f6f
  - [net-next,v3,5/9] ice: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/c59cc2679acc
  - [net-next,v3,6/9] ethernet: smsc: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/099090c6effc
  - [net-next,v3,7/9] net: mdio: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/04115debedce
  - [net-next,v3,8/9] can: ems_pci: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/9235e3bcc613
  - [net-next,v3,9/9] net: bna: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/1d5123efdb91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



