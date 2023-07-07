Return-Path: <netdev+bounces-15947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B69674A8DA
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84783280F2F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBA1852;
	Fri,  7 Jul 2023 02:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FF1114
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B6EEC433C8;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=NMaIG04L/6+E/2sKovqZRj+7rHyfA4XB+GfHgtsEzmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=azrHxF6Er9dz5uac8BGKksDnLEYAXRN1rbS3CZfh/slM4DqIfuqkZPsGz/jakca6h
	 fyj1EzFyhw2LsOEd5sNkGxrN9UnU0b+/zgbgR4ms3fZs+TjlOx78XFZrfhjfuRR8+b
	 HVdG9oz/Dy+vMOocfKwfexB/mwnfSch7lRIwypBRXT60XK5uZod3ToOKdFlWe6wWR5
	 7XhxjJyKo2teWX6gAptH6I2Hevk8StAp4yvnJYdmc7FI6DwrU/3H3WuPdalSW0CqzH
	 QQwtcEJ8MtmkW2SHpi0DZW1zZYwBVgU+n8gqZz0NdgKb3KEHKcPj5qwmC5zOQgylSX
	 QRuvwTxabhjMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 679CBC73FEA;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: fix init command fail with enabled
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642442.27656.11954856306543851735.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
In-Reply-To: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
To: Deren Wu <Deren.Wu@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, kvalo@kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sean.wang@mediatek.com, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, quan.zhou@mediatek.com, stable@vger.kernel.org,
 leon.yen@mediatek.com, deren.wu@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Jul 2023 23:26:38 +0800 you wrote:
> From: Quan Zhou <quan.zhou@mediatek.com>
> 
> For some cases as below, we may encounter the unpreditable chip stats
> in driver probe()
> * The system reboot flow do not work properly, such as kernel oops while
>   rebooting, and then the driver do not go back to default status at
>   this moment.
> * Similar to the flow above. If the device was enabled in BIOS or UEFI,
>   the system may switch to Linux without driver fully shutdown.
> 
> [...]

Here is the summary with links:
  - [v2] wifi: mt76: mt7921e: fix init command fail with enabled device
    https://git.kernel.org/netdev/net/c/525c469e5de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



