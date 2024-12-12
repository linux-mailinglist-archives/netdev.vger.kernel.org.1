Return-Path: <netdev+bounces-151290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6819EDE7D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9B71889214
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047A18660A;
	Thu, 12 Dec 2024 04:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkCK66kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47E185B4C;
	Thu, 12 Dec 2024 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977818; cv=none; b=lWD92yev0MPBF5/Ij/dZlFyq4adSvjIzqrVZrPdRk9Lol77I9Bkbz15saZRwbrlDuz23P8TVTZ8kIm4cabflbyidq2lA4jx5i86G6IDOQRxX+QFIR/FEUYC/85KMmvDMjOJRt7W3p741vZPTZ81q/orxZBqqaP9FJ/99wQXa2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977818; c=relaxed/simple;
	bh=5VBjx/lX667bAnSiAtj+Oneow/Zgypuh0hePuWhqJGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WSsP5k+j83fBRKqg1GUwSkXWLkdF+BJxLRYQP3TFjsKJYJaDaMjOS5OVGwGm+Y52FY54b2R2f/RMicC+8/Euo/Dp6KZ5hFRI7iNxM9Vyq9G22RehD3xGHSXAa5FGCe8hSbzRn5Y9ipeS6rTr7fxu+8AClTfG1TEZNF4UN45asAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkCK66kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59452C4CED0;
	Thu, 12 Dec 2024 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977817;
	bh=5VBjx/lX667bAnSiAtj+Oneow/Zgypuh0hePuWhqJGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkCK66kfusKXcJfqOmGqyMgSL7TE2+l7F8dICM197UUnDwFLRYqjF8DhYj7BUfrS9
	 4E3AGw3Xaz/BtsUW5DqcGIupex/T0tlvg0i/ZoKX3U84MXaA0F6sJM5tJ1CmkUNMhB
	 Vknind/64gLI7hcaQhUqJR65L8lDhVBmdpIGM87IXrxZ3VuW6V14SkBlevKdQO7Eix
	 yAt/kjvDtwRnHKKHjFA0thd9lcNhDEmgzs3aKatGtf1kTGYvDw/xhDWSXl/KqXsW1M
	 y9MG53gXfkNgJJthA9rm/aff1mkqnqWMY0KyXoG6UgJjR5dKh/yFDOtsyN5cqAOjcu
	 KOO1rWewN5klw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF20380A959;
	Thu, 12 Dec 2024 04:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FE910C04 compositions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397783326.1847197.13350019898244798941.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:33 +0000
References: <20241209151821.3688829-1-dnlplm@gmail.com>
In-Reply-To: <20241209151821.3688829-1-dnlplm@gmail.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Dec 2024 16:18:21 +0100 you wrote:
> Add the following Telit FE910C04 compositions:
> 
> 0x10c0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
> T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 13 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10c0 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE910
> S:  SerialNumber=f71b8b32
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
  - [net,1/1] net: usb: qmi_wwan: add Telit FE910C04 compositions
    https://git.kernel.org/netdev/net/c/3b58b53a2659

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



