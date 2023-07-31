Return-Path: <netdev+bounces-22950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1408476A28F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8011C20CAB
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587871DDFC;
	Mon, 31 Jul 2023 21:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342121DDE3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 940F9C433CA;
	Mon, 31 Jul 2023 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690838423;
	bh=jhk0RIsZqxgxYS5cQkGXe5ZY41d1Y14T9VCbQAgv2GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qaqYO26JD/M2iOaweWJVvZYIDxiP5AdOckznzOXITelIvtymRj0no7XT7qTbD/zfb
	 vQdm4h6IHnhNVyU3CeiIadK7jL1+l2913elnQj9VOcGZ1RDaNDQssGjYqFJCTWcSpR
	 ZdQ6iQd6oB0MsxLSzlR9zBsBqSRRPm2w/6p7waEc8p6sNwgRQ9W9/35LZbBVedBHY6
	 4sElhVsg2WTefIL49mHupCPP6QZzKnrzS20pVYgIEVtwt9JDu4Yw05eKhd9SOwMTjJ
	 OiBS7TUdL+X7GfzYaKkExSHjpVxcZvomXR82tr8hAf1cam3x2DI2Vb1bcjM+3nkAr4
	 1/Dr+7RJvTIyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66503E96AC0;
	Mon, 31 Jul 2023 21:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add Quectel EM05GV2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083842341.26809.6870887146087627896.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:20:23 +0000
References: <AM0PR04MB57648219DE893EE04FA6CC759701A@AM0PR04MB5764.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB57648219DE893EE04FA6CC759701A@AM0PR04MB5764.eurprd04.prod.outlook.com>
To: Martin Kohn <m.kohn@welotec.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 20:00:43 +0000 you wrote:
> Add support for Quectel EM05GV2 (G=global) with vendor ID
> 0x2c7c and product ID 0x030e
> 
> Enabling DTR on this modem was necessary to ensure stable operation.
> Patch for usb: serial: option: is also in progress.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=030e Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add Quectel EM05GV2
    https://git.kernel.org/netdev/net/c/d4480c9bb925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



