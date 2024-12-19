Return-Path: <netdev+bounces-153192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D79F7253
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15291883BA6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A5198A02;
	Thu, 19 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdErusBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A12BAEC;
	Thu, 19 Dec 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573014; cv=none; b=m13ZsOdOowVSSsgWh63VIfyQa1O3XoI1efzbkav3ty7wk81eMej5kyJyqHMDEcx8bBMAYJIPgH92pub105BjxuYvXTZqF88LhkawE1hZ42n1X+RmtgWuzyPXVrEH5fc7mxf290CoLL071UM/kIHb8DV6M6NKKvpRuUjt1vk7PrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573014; c=relaxed/simple;
	bh=zMBQmY/5wLsiuHbJygP8IuW8W70GFbmV5bOkquQmnIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c8De33gYddnxU2hjfiOQPstkhdaJ4vXG8A0fQ/+i6TpFum/6C7xY8RBZwonlprXAoBq7N8uUFBk/HI+I30xQ/5asZwV5AJnouaHG5pq7WAViX31pi/pm9pawFf2kKcgXj7ObSEdm/l9hYhuWzyiPgm+NUIUZEtFBASmOzfbrukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdErusBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AA3C4CECD;
	Thu, 19 Dec 2024 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573013;
	bh=zMBQmY/5wLsiuHbJygP8IuW8W70GFbmV5bOkquQmnIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MdErusBH6WIVh9bXu+inevs9CPaeyNZ0qAWB/EQgDICsXrL65p7eGMe9Ox/9Z9bAm
	 ZRq6B2PLq1o/+SaRxMJQGX1l8rrAA/do+ZTGv02giZcIxbuDm3Z5u1wRxD75dMwta9
	 liDJ3ccVTrJEgekDaHiyjHT5Y4PY/Gedvfja9JwQmAqEgsMbnDAYIuHkHu4U69cnbF
	 AOi78pV056s5PMLiBYe7JTQNfXs6okV9kR27C6D0OEych6eSAIqVxO5KpSj2rKDjbY
	 DcMeFoP0xMDiW4/p6YexxC3EcDd3LXGYjs/jBPX8Hx6aZO2uOu00nYT0zCRDs1VjBk
	 gQ48vRimAqPTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF573805DB1;
	Thu, 19 Dec 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add Quectel RG255C
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457303075.1788421.10127494372094401337.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 01:50:30 +0000
References: <tencent_17DDD787B48E8A5AB8379ED69E23A0CD9309@qq.com>
In-Reply-To: <tencent_17DDD787B48E8A5AB8379ED69E23A0CD9309@qq.com>
To: Martin Hou <martin.hou@foxmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 11:06:18 +0800 you wrote:
> Add support for Quectel RG255C which is based on Qualcomm SDX35 chip.
> The composition is DM / NMEA / AT / QMI.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0316 Rev= 5.15
> S:  Manufacturer=Quectel
> S:  Product=RG255C-CN
> S:  SerialNumber=c68192c1
> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add Quectel RG255C
    https://git.kernel.org/netdev/net/c/5c964c8a97c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



