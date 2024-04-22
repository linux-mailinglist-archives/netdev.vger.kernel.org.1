Return-Path: <netdev+bounces-89972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C288C8AC62E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C53A282FC7
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4474DA13;
	Mon, 22 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJlhhTkL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CF4D599;
	Mon, 22 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772828; cv=none; b=lpx3MNDGRq7rFZNCddJqLMshI4qNHhCReAzej8+AEU8Z2eRaob+olJh0lRNbUO56Fo1x3Mq2xYmvfmjglDN7e0pnU7yyxxQga8j5sHGePhS6lGZUONQHM2mrzNjFho0QzLDy8DCOVGVWEaoTfdR34Zb9wPbk6kia46s38/ZwV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772828; c=relaxed/simple;
	bh=DIJSir2e9d7gAvs2+NXv5bOOT63Gd84ASBtFZmOPwg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SruJKBSEXJs2oSq3iCBRx4Zgelhraq+ODzi5hO3BZlz9y9DKTjV78i2OtTYQwwZIGWkT+SLDn3fXnHnb2xIWAmBTxCiWE1x7kEe/vufeNXSSNpTh8NNEUhWNBcZ6Iz2cfrgWQas6zzJwJ/SEx+vAQPS36fJGfsd8DokfMtqP7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJlhhTkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34CADC3277B;
	Mon, 22 Apr 2024 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713772828;
	bh=DIJSir2e9d7gAvs2+NXv5bOOT63Gd84ASBtFZmOPwg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QJlhhTkLUK2mxI08mYXViMtCrh8oYmZ3HcLOYmO206M+5SnwvgwV6yOke7QPKZdY6
	 fKBhmVDX8Si9hALbaqFFqaclQXPLc4wIN9YHtmG+RxfegBtO/LQc4ASa1J7scSj5Lp
	 bbvseqn09W3+Ry9ko9Kg80sDiyWoIqluRXiuQXb8rxvtQMk4mNG3x/0DeNadfq4+2C
	 7CXDSx2tjBV5cffGEHudgL1jZw1mtNqPTr+vRnAENXVOcH+3fqoglgahAl7+gmXqWW
	 xRQiCkzwqycAgWv1romkDwJsrvwcrF2iMIaQI602rd08lQrKV2/UN236VuOflSymD3
	 TgU5p5q/eLP2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21A01C433A2;
	Mon, 22 Apr 2024 08:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FN920C04 compositions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171377282813.8584.10156649860787123159.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 08:00:28 +0000
References: <20240418111207.4138126-1-dnlplm@gmail.com>
In-Reply-To: <20240418111207.4138126-1-dnlplm@gmail.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: bjorn@mork.no, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 13:12:07 +0200 you wrote:
> Add the following Telit FN920C04 compositions:
> 
> 0x10a0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
> T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10a0 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN920
> S:  SerialNumber=92c4c4d8
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: usb: qmi_wwan: add Telit FN920C04 compositions
    https://git.kernel.org/netdev/net/c/0b8fe5bd7324

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



