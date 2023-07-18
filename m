Return-Path: <netdev+bounces-18478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D843C75755C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154191C209B5
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C46ABC;
	Tue, 18 Jul 2023 07:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D395687
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A99B9C433C9;
	Tue, 18 Jul 2023 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689665421;
	bh=xzOmKto7mgO+DlV+di9AkQ9xlJrPz55vXFRIK3ZVaiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J2e5bb3cg+8AsHGFbDMkr0AmGb9YH7g04aIn57I8NwEzphndujN4F8LsJc/A54C2T
	 jhZNr+S8d8C30nunJerrQ/yWvBMFjllrEeIMV4oYvR0j3Apkc/p6iEupVea/VKiEsW
	 AyXYO5pJ3nHNSrNxXyD9QTPdJhO9g3cLacq1c9+j8g+C5MY9F7LB9CYkr57BDkFljI
	 iGJGOWT0UjCDddE8a13pNxwbpku/AgfqS1vEJeNXygDlZ5GWUKWCGjau0y2mR+5ctK
	 1P3hD2C229T09P4t6kXh9xB2C6MaG6m6B2y0HaoA5whGFnTnS6MhKUQGXwCdBhsdp4
	 wFnbXkvMN9DQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B526E22AE5;
	Tue, 18 Jul 2023 07:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ftgmac100: support getting MAC address from NVMEM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168966542156.17873.5200310716380528956.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 07:30:21 +0000
References: <20230713095743.30517-1-fercerpav@gmail.com>
In-Reply-To: <20230713095743.30517-1-fercerpav@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, windhl@126.com,
 geoff@infradead.org, leon@kernel.org, rentao.bupt@gmail.com,
 wsa+renesas@sang-engineering.com, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Jul 2023 12:57:43 +0300 you wrote:
> Make use of of_get_ethdev_address() to support reading MAC address not
> only from the usual DT nodes but also from an NVMEM provider (e.g. using
> a dedicated area in an FRU EEPROM).
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Here is the summary with links:
  - net: ftgmac100: support getting MAC address from NVMEM
    https://git.kernel.org/netdev/net-next/c/2cee73cef253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



