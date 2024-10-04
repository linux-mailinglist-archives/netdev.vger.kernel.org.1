Return-Path: <netdev+bounces-132196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40F990E95
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE102805D3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3C2281E6;
	Fri,  4 Oct 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6w+0H2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB92281DE;
	Fri,  4 Oct 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066634; cv=none; b=CrH637E4Vo1yFawMPZMZFqqQnceFalq0/i2VfscTabit8R/JEtWFBwE0YOrorK2GD+K/h4/LnM2J91uVsuD+uO85hriCTqrYjX/Y45QrFK8Jai2VXXTaSMm88dWBczVbk53aJaJk2uDOJ05UJa47jRrKCSKM2OLmj9+7ZkXWViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066634; c=relaxed/simple;
	bh=xasM00lynAo+BSi/xT1aQHH+uZC3jhuQiZ/pR7PgChI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zv/BVwEed9DsPBzep6+meXSr4qqtDznk6I5YiRVb2FS7xMk+dTzWJLIFtc2TLgZ6+7ewBReiPcmU47p3DbFellJ/em3zwnLR0ksjObVuKvhktNwd/DBefQNul/zwP5fFlX5n/SKWaRm2J4gk1e6fp9klaFf+dkWjx3TEHmwYp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6w+0H2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E12C4CED0;
	Fri,  4 Oct 2024 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066634;
	bh=xasM00lynAo+BSi/xT1aQHH+uZC3jhuQiZ/pR7PgChI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6w+0H2WUpldTKAfCDdPEjhii4+U5Kena9EE0MOcMOWL6A0avyV3GImYQz1vxDhVT
	 G38x70nY5/FOvyLSLCwkyDTklXSSCP/Tr0vcvNNoXyRmD15M6xeX0KwtC1DiWo0/n4
	 H3XUt+m/PtU6NeoqT17PBHg0mabgvDUQ0YWcTN6ZD3gWC0KyIneEIkBP++m8fENN2a
	 w3L5vyPkq/yqouJqwNo03Lrcf9L5qBux5dwyrrp+AbGL7S2uFbcQfN9EogoolPuDam
	 9B2I8KIhjv+Wu3gFMQTWLet0m6aqWujB2+MZ2iqOmrSJMhI//T+HpDh69htmGGqeHF
	 0DJjEu0Etzh6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB62239F76FF;
	Fri,  4 Oct 2024 18:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: Adding support for Jumbo Frames up to
 10240 Bytes in SAMA5D2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806663775.2691890.6191095154643853918.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 18:30:37 +0000
References: <20241003171941.8814-1-olek2@wp.pl>
In-Reply-To: <20241003171941.8814-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 19:19:41 +0200 you wrote:
> As per the SAMA5D2 device specification it supports Jumbo frames.
> But the suggested flag and length of bytes it supports was not updated
> in this driver config_structure.
> The maximum jumbo frames the device supports:
> 10240 bytes as per the device spec.
> 
> While changing the MTU value greater than 1500, it threw error:
> sudo ifconfig eth1 mtu 9000
> SIOCSIFMTU: Invalid argument
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: Adding support for Jumbo Frames up to 10240 Bytes in SAMA5D2
    https://git.kernel.org/netdev/net-next/c/8389cdb5c192

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



