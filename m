Return-Path: <netdev+bounces-106976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55133918568
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5347AB2B25A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC7187575;
	Wed, 26 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE1RajlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50018756E;
	Wed, 26 Jun 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414031; cv=none; b=S8H143sgeBWpAjlv7CIE6LMb4tRbTM1JPU53E2/RyDOmhjTqafw2Z9y0425sUE3+Fo+DSWO3QrgeYerx36LPotNTxyEUU9qpr+A7irq/x2IZ3z/uoiFZSSdXvENF+1ECII7VuHKOZyGF2+pLyy6a1AaHucoy0eYGfq8wXoQq1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414031; c=relaxed/simple;
	bh=9WRrbIy9JlyjG2ZzkBX/7adK5Uag7KwzEA5ZPUTJGpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FU2Vd4FFs4BtIkNGOArsSbJXx9cl8ZQq3omoE3tY6mR7IZGQVjSDLgAEMQwW0aWp1rUrLcBaZJs/zg+cXC1llsW43b7L5CBOZeRL2X0/483hZyFr0r/nXUkH03I4pUKpXFe5P4c1sDvZQM7GLa6inVw4W+ZGDv/YGZF+2PTbI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE1RajlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DDF8C32782;
	Wed, 26 Jun 2024 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414030;
	bh=9WRrbIy9JlyjG2ZzkBX/7adK5Uag7KwzEA5ZPUTJGpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kE1RajlHjN7Z6iNQmDboi0vOTYhBVkQ83DNrJdbjAciaJp3KldgEdJdFNFDni2oib
	 KyrJlutyzJIRv/p6Xp9IWTj12lPg+wcGwYR3CiV1BOjejIvZwiuP5UM+pbthVR8oiI
	 9//CJQfCW5TLHWINjM+MThNuWQnyEgWkkd6aWUc7R8JmSoe6Yvmgu5RGvYwWDjLOhN
	 4XdNLpsk+tuBtjr7IT793rY8LeSljQiOtnZdhlO/nIVhBZAhqXa2HLgWQqO7GxT20C
	 GOgAuz0Fd0c0Ynbn4Cq35aE8FuF/hWp5r3cr+4drCil/SAzKYu3ncqduFyhbr/7c2g
	 j9G4y0JvWA6XQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CFD8DE8DF4;
	Wed, 26 Jun 2024 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FN912 compositions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171941403044.22170.12755733092861289820.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 15:00:30 +0000
References: <20240625102236.69539-1-dnlplm@gmail.com>
In-Reply-To: <20240625102236.69539-1-dnlplm@gmail.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: bjorn@mork.no, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 12:22:36 +0200 you wrote:
> Add the following Telit FN912 compositions:
> 
> 0x3000: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
> T:  Bus=03 Lev=01 Prnt=03 Port=07 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
> D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=3000 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN912
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
  - [net,1/1] net: usb: qmi_wwan: add Telit FN912 compositions
    https://git.kernel.org/netdev/net/c/77453e2b015b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



