Return-Path: <netdev+bounces-15659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E174913A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814AB280F52
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ADC156C2;
	Wed,  5 Jul 2023 23:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66756154AC
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2577C433CD;
	Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688598024;
	bh=dmhwZA3FcpfgoYkFfK0f8ZtZqryqQgsRp0crWis6QbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NqytIV+i2Y1Mb4sTJ1R7sBGsVT1PgQkczXX6gi/AYTubNeHdwSGFJ31WPHoDBw1rQ
	 gnwqa07At6SoXEqar8mS4ipJRSUZgee4S53d6fPcUUpnknNxTTt/YZ6mUd7BQOaovA
	 r+KJo9njiudLdukssL5l4c5HQ0mZyaxNngdu3r/xgpnbybI1L3K+hcdd2cfbtrmy9C
	 m1caFfOz8kB//TjnuKireidE8dZgR8DE2AKB9VaUbD11T8GIx40boljBb/gCvdHK+2
	 s9HCtZJPzKh88Y+heVvZNh0DuT7b7oBcXfbEdaiAIx+xFSzgMmWnnP9DMa89nVAtnr
	 wk9PLTvsO7row==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA50AC691EF;
	Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: coredump: fix building with coredump disabled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <168859802475.24898.14279072242552303522.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 23:00:24 +0000
References: <20230703113112.380663-1-arnd@kernel.org>
In-Reply-To: <20230703113112.380663-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, chris.lu@mediatek.com,
 sean.wang@mediatek.com, jing.cai@mediatek.com, abhishekpandit@chromium.org,
 mmandlik@google.com, arnd@arndb.de, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 brian.gix@intel.com, pav@iki.fi, iulia.tanasescu@nxp.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Jul 2023 13:30:48 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The btmtk driver uses an IS_ENABLED() check to conditionally compile
> the coredump support, but this fails to build because the hdev->dump
> member is in an #ifdef:
> 
> drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
> drivers/bluetooth/btmtk.c:386:30: error: 'struct hci_dev' has no member named 'dump'
>   386 |   schedule_delayed_work(&hdev->dump.dump_timeout,
>       |                              ^~
> 
> [...]

Here is the summary with links:
  - Bluetooth: coredump: fix building with coredump disabled
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ca03ff0da3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



