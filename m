Return-Path: <netdev+bounces-140063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0599B524C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8641F23FED
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13B1FBF50;
	Tue, 29 Oct 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF8/aj4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7DDDBE;
	Tue, 29 Oct 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228427; cv=none; b=TiJbJfFRk4PVQlyujAwhoQIbheqP5knRa6auMLuLWpOY+b15Xnx9ZCm39MHxELS+ZlJxj5RKspY3qf+jG6LWmrt5ZlyZ699U/X+3D0b9Lasi1kBSaCHEnsUAcPndHbpu1iOwzh2hTNMre3AiJqyPwLtZTLWt2YA3+er+3mAnCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228427; c=relaxed/simple;
	bh=y4blAUiLkKNBuzymZwHaU201Y8f7DqejWNtvVRzItxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADtZyyFe3n204uuc/Y2DXb1UPRJXk0wMhz/UBYIXT2C23YImmLF5ecSPPRpkbp6kBOduArUFGMdjx4HilM8n0e/6lR2qTNBCdQyKMWfBNYMzKl8KmKB/VyY7O0TobxPQUP+TP0t/ccBP9GpkOQ8OT04h96Cw5fH/0wzwIrzqbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF8/aj4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C560C4CECD;
	Tue, 29 Oct 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228427;
	bh=y4blAUiLkKNBuzymZwHaU201Y8f7DqejWNtvVRzItxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DF8/aj4AVYFgFEB4m+1kTZCFWcoXSeUGt6Ve7viDSuDosfW8WKqj3x+vyZKHkAnNw
	 EuUcjcRbsplovPSjrJhVskS0OBZT62oDJYB9Gtc0y2TK1vTJqARy1yJeiETs/RUb4a
	 sHKtv7mm8caPUxfQk74P2HBPa0zYaluttv37FsoOpTJyJDklMDweouo8Ulu+gK/Sdj
	 Oc7kqBBcT0OoS0LY5oi0cE07l3CXW8rfln4tz2qDZY06uUOnaChyeQIIzpLDfZZLH1
	 i6yWmWjAIR018FpRCikRAbK2lqvVi2riXGOhy9CRcilsN/CPMTO0d9ijsL1hREjbu6
	 NizeVJxluPTRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC7F7380AC08;
	Tue, 29 Oct 2024 19:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add Quectel RG650V
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022843477.790671.16218877187194108195.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 19:00:34 +0000
References: <20241024151113.53203-1-benoit.monin@gmx.fr>
In-Reply-To: <20241024151113.53203-1-benoit.monin@gmx.fr>
To: =?utf-8?b?QmVub8OudCBNb25pbiA8YmVub2l0Lm1vbmluQGdteC5mcj4=?=@codeaurora.org
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 17:11:13 +0200 you wrote:
> Add support for Quectel RG650V which is based on Qualcomm SDX65 chip.
> The composition is DIAG / NMEA / AT / AT / QMI.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0122 Rev=05.15
> S:  Manufacturer=Quectel
> S:  Product=RG650V-EU
> S:  SerialNumber=xxxxxxx
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=9ms
> Signed-off-by: Benoît Monin <benoit.monin@gmx.fr>
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add Quectel RG650V
    https://git.kernel.org/netdev/net/c/6b3f18a76be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



