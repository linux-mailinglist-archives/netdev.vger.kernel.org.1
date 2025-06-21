Return-Path: <netdev+bounces-199976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF866AE29A9
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C4C3A8E1F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDD770FE;
	Sat, 21 Jun 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm5lqK56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AF1A285;
	Sat, 21 Jun 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517981; cv=none; b=SHIE39f2ZK63zPB/covjyhaVRDZknWGcTDIOHqkeWc/DZxg6YfS5eHO442wjBOY5jmErCuz2vxytLHQn/C2cT20AYHSl7FruIBWcIktiTOP424JHFH2cbXdWmFrPtZNJKohwawpFMn7lEUeAnsSKe4X6fPN+URS5q0FVLaYsQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517981; c=relaxed/simple;
	bh=WaLizQgql2nLcEHIJUXeW2T7zBzGVp1VY2hbKzdMvVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b17CuCyGnOfSvcJpQ7A9BJEbWVwD+oGCO1EHzDyQmet9jR2mEApv3c1M8nbygaDslgDTIOlAtcv5yWuGkdnpL8NIA6NjNiPGNYlQOUNq1laJ19iFENDYbfJIuzQWnV/oNntEtbeAI9VMD37wf+6w655V9l117aGBXgLIymwqs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm5lqK56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9894CC4CEE7;
	Sat, 21 Jun 2025 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517980;
	bh=WaLizQgql2nLcEHIJUXeW2T7zBzGVp1VY2hbKzdMvVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lm5lqK56N3FXKi+uf2Dv5Pcu/+vCaLzb/mbYP+c4LjDN7GIpiqVPZAwe1xGoYGUEd
	 Aoj5quq7MgKGRGTBYzk4+QU52ujop+taQsJlLmGdb5DQu4SimslMbq/tiEBYzdSPaG
	 sXEfR7w0tOiI+CT11gyjrj4Mk73lIO0/9Hdg7koHRUJNyke5mANWUA+FoucXItP7zZ
	 7ypwLZJUU5sA3CIRenLxKayQpWzw481pTMhHGeiaOjiQpkFIFItri+t0mLKPMg5DJM
	 tbj9XTp+/vipd7y/Pdv/Fjh+CC7vR5I0FdTYXn5yEUAS3nS0HkWAyDYiAbKl3Xpr6a
	 XfriiSj2UZjUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CAA38111DD;
	Sat, 21 Jun 2025 15:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add SIMCom 8230C composition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051800827.1877807.14040034751571912650.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:00:08 +0000
References: <tencent_21D781FAA4969FEACA6ABB460362B52C9409@qq.com>
In-Reply-To: <tencent_21D781FAA4969FEACA6ABB460362B52C9409@qq.com>
To: dataonline <dataonline@foxmail.com>
Cc: bjorn@mork.no, kuba@kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, xiaowei.li@simcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 10:27:02 +0800 you wrote:
> From: Xiaowei Li <xiaowei.li@simcom.com>
> 
> Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.
> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
> T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1e0e ProdID=9071 Rev= 5.15
> S:  Manufacturer=SIMCOM
> S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
> S:  SerialNumber=0123456789ABCDEF
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
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
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=none
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add SIMCom 8230C composition
    https://git.kernel.org/netdev/net/c/0b39b055b5b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



