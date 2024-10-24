Return-Path: <netdev+bounces-138577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7149AE307
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E755C280FCF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC01C8FC6;
	Thu, 24 Oct 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGKs66lM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F91C82F4
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767025; cv=none; b=VNIwangDkIYhSDK1v7XLt2vQgoCH0SsHX4sIpnBPjlyb0uTwKRgYVCESISyqJxhgPepnD4rxNK+sDUovLoEa4hF820EsFDwaCd8B/rPm4XoqtZRtzHVP/rmbjfS7Sjocsn+QAH2rYGd8hQXmh4HR0HX/p06h7bt8uUOsUcvYsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767025; c=relaxed/simple;
	bh=ae5oqCS/Dat3JS9DvbR1//fYbMMopVPi9X77OtswDeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sAv7QgowEBEuB68y8fxwF+SEvto8rHYXdozP7C+pQTbDXS3mPwqvn/cdUWv+xIXXO7WOLl7BzRq3DYPOjYVUxWOgxchHiADTKOP7vg/jHEknF12mjl0Jws37JY6kkPVCUrV6vMFOLUjPCeyypZWr23vbHJNteDT2861dtLxr1jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGKs66lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F115C4CEE6;
	Thu, 24 Oct 2024 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767024;
	bh=ae5oqCS/Dat3JS9DvbR1//fYbMMopVPi9X77OtswDeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SGKs66lMDULodoXoVHiO+jxp7BlCVZQRDncPXITCXdmAamKdv5L4Pz0JdX6qewFSf
	 kK+/v4AO3t0UCwgD7VYilT5cMpgqjwj/fLLDhJow/g/Fob53eqhuUXLg0u0MN2Bw6J
	 lfDUwyWiVuGG0RR+6Pg1Z2HEJ32gvRGfrop86mVZyYAC+GILQuKL/8gl2IcW+fE2ZV
	 VAXIrcnAKyYdPVaVLYrFJM2I9Z3774KIZXsPNWjavWUx5JWo8vmLKwrTGlc31luLsp
	 xZypLDNru7jPvPZj5Ken6FGWD59qzrS6ejbgVVuNePNpT75pNJTagUnTQx9zxhW7s3
	 KYbzXA1pfcd7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713F8380DBDC;
	Thu, 24 Oct 2024 10:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976703127.2195383.9582722307810853577.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 10:50:31 +0000
References: <ZxLKp5YZDy-OM0-e@arcor.de>
In-Reply-To: <ZxLKp5YZDy-OM0-e@arcor.de>
To: Reinhard Speyerer <rspmn@arcor.de>
Cc: bjorn@mork.no, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 22:52:55 +0200 you wrote:
> Add Fibocom FG132 0x0112 composition:
> 
> T:  Bus=03 Lev=02 Prnt=06 Port=01 Cnt=02 Dev#= 10 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=0112 Rev= 5.15
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom Module
> S:  SerialNumber=xxxxxxxx
> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
    https://git.kernel.org/netdev/net/c/64761c980cbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



