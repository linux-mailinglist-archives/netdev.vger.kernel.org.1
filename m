Return-Path: <netdev+bounces-116294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA5949DE0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F96287168
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077715D5AB;
	Wed,  7 Aug 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYJuhRt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890B2119
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998427; cv=none; b=masBZd267SGpUFtxBWiCk3K9/AjjYQnoPviMlrXwx9usbe8LDutJoy2AP2Y8lTzpxhL1MUd2Z2uC2BC2nbnQOmd+cRZUOqRNXnr21gutmMlUAMtJv8tFFYq8mD41AEW9i2Jk32H7GDs+Lw0S/uV5fc3XJCIK0tHo3sw5M94/Bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998427; c=relaxed/simple;
	bh=ytNDJX5PR60Lfass8mInAit+MDHY879dL4z58OvAl4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WExzm19y6CdGMmUZM5FTcXseVv4euowTbGNlpXmo+oK6mRvDdWik7CJ5yBpFdX5+dbPTa/XvtvOf4zqmeB08bzFKOoq+qvEw0sAvXeh7epCaOxhyADCwkTk4XnNJu+sh0/Lw/1fLefoOKECCJPhhySlKpbwtv+dy9+poTDb6BQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYJuhRt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D62C32786;
	Wed,  7 Aug 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722998426;
	bh=ytNDJX5PR60Lfass8mInAit+MDHY879dL4z58OvAl4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYJuhRt2NyosIXMxrUWI8Nf7BIBfpvmanf38TIhyx7NakJMmdaKexzIWNGmgzrD/9
	 rNxMz0rS2aMgehaLA5H95YxFbNAZTI1rJCBDcNXDG8+hdhGo/KaQLzPFjdriBYw4Ke
	 SfNBrKh3e8WkakoHvdUWSzLcsJl7gg10zBEKqk3CnLQETzMeE4WnShViIBzGXDhTlb
	 51kjYv8xX76BPZYkc6eDhs5S51WVHiUmyhw/MvTooQOyWskngg7G1uQ4OVOGLq1HPD
	 oLHoaPge6Bwyp+3NlqrcCONtZA9/jwFYZqWcQOY/z8xOfEiR0tigafd+zOE3FM6B+K
	 n4cu65/9hGeEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2E39EFA73;
	Wed,  7 Aug 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add MeiG Smart SRM825L
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172299842576.1823320.14435202283236413882.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 02:40:25 +0000
References: <D1EB81385E405DFE+20240803074656.567061-1-yt@radxa.com>
In-Reply-To: <D1EB81385E405DFE+20240803074656.567061-1-yt@radxa.com>
To: ZHANG Yuntian <yt@radxa.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Aug 2024 15:46:51 +0800 you wrote:
> Add support for MeiG Smart SRM825L which is based on Qualcomm 315 chip.
> 
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2dee ProdID=4d22 Rev= 4.14
> S:  Manufacturer=MEIG
> S:  Product=LTE-A Module
> S:  SerialNumber=6f345e48
> C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=896mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add MeiG Smart SRM825L
    https://git.kernel.org/netdev/net/c/1ca645a2f74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



