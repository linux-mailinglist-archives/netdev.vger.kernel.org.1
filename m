Return-Path: <netdev+bounces-210258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3FB12803
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF571CC5B7C
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC02145C14;
	Sat, 26 Jul 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbEwmnps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077B1114;
	Sat, 26 Jul 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489798; cv=none; b=RN3CS81o3/TooyLsnMKSciYeUZe89+lp435UdX52+Ze11362HTxICbom7RrbUe5gQYiVXzfrHnqOzbEF4CxeZMStzLXVnNqCogoIWtF/moL5BMyaU2H71mXs4pKCk0/lzEHihT9LiuxleugxWvkuqW44O9Ol9dVbdjF1iudUDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489798; c=relaxed/simple;
	bh=NOJkgA/xg0hvzdFVQOsWFDknTDsOYw7xp8xVeLj21KY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nJp557SnOfRbIU4IXr3Gyyd3O1kfddEcdAJbV2962dfmPmgPlAUwyOV5St+OFD+mq3/1ZFww8qY/zW4vYkIQkNVEyFzLKJ5bcAfOPO6taqnQ2l/J7VADcr6iI6ekpoGLHIXySV+DnEvyXbRkXvCDapaX+imIvr7kCOkls5P+yAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbEwmnps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D8C4CEE7;
	Sat, 26 Jul 2025 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489797;
	bh=NOJkgA/xg0hvzdFVQOsWFDknTDsOYw7xp8xVeLj21KY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CbEwmnpsCFxq4aOGQ5HFjoddrpap5DH7AmvtbheXqi1dORwxMq27ELQ5YX6veo0S0
	 VYGgUHrlgDtqiu2vmqRxhG104H4zIUedrhXtD0GGDkQ4uZKjCxOEbDaaPNvF94hbeQ
	 VAYS3no6+1DeKbcls3r0gF9IXYd7xxvx9g4ePAD6it1jFGV6afdmr4OJz30cHBfTDY
	 hjg+wotKSjCJ8hRPjrQboOBp+GZJYUvX9Z1QsgCx7mRxTe+zX92RuJJvKW/y+3ZkLP
	 gc6vAfUZTZZfVR4vdYbnlnRf5We79J66uLNIg0JN8YhhAap+ZJl+jL85Ms6fn9bTLu
	 lyowdIBV8ufxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE1383BF4E;
	Sat, 26 Jul 2025 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] net: dsa: microchip: Add KSZ8463 switch
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348981450.3458768.3255711833889964972.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 00:30:14 +0000
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
In-Reply-To: <20250725001753.6330-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, marex@denx.de,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tristram.ha@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 17:17:47 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> This series of patches is to add KSZ8463 switch support to the KSZ DSA
> driver.
> 
> v6
> - Set use_single_read and use_single_write so that 64-bit access works
> - Change register values for big-endian system if necessary
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
    https://git.kernel.org/netdev/net-next/c/ba37d556eaf7
  - [net-next,v6,2/6] net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
    https://git.kernel.org/netdev/net-next/c/84c47bfc5b3b
  - [net-next,v6,3/6] net: dsa: microchip: Use different registers for KSZ8463
    https://git.kernel.org/netdev/net-next/c/15b8d3e38607
  - [net-next,v6,4/6] net: dsa: microchip: Write switch MAC address differently for KSZ8463
    https://git.kernel.org/netdev/net-next/c/5bcdb1373a6c
  - [net-next,v6,5/6] net: dsa: microchip: Setup fiber ports for KSZ8463
    https://git.kernel.org/netdev/net-next/c/006983e59755
  - [net-next,v6,6/6] net: dsa: microchip: Disable PTP function of KSZ8463
    https://git.kernel.org/netdev/net-next/c/620e2392db23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



