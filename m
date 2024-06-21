Return-Path: <netdev+bounces-105617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9406D912055
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D6B1C21121
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AB16E873;
	Fri, 21 Jun 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af/e2FBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CB16E862;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961631; cv=none; b=SLYYOYiuq8ShqhyXVqLeI1/IzizH3yYdjp+uyMgIZ5kvCteBeTDcRRxZZCzwaNY5PTDPXu38IXuwhfjWxFlEelFUu1fOstCOiKrUCEokWfQLZehBO5E6Oe++dfISZOZvIbOCumNlc++eXZdKPDfd/hDzK4tVKlI4S9iCLjy1jXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961631; c=relaxed/simple;
	bh=g0c2J8l1AVStje0/uF5fYXZ83d8hO/iWIMUtbgnpBzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjlbfjR4fYkePuKAMefe3NBpHuxwwKeVnJ5Cvh87In9hhFW/3ZkIqCNSCOjjM+P6LhBzILVIICyfm4rj2tjWEvcpYa5Chq8zsx02RXN4Z/TN0WkyKu27nb37hgQhP0sK8pbhskKvM+Zzshpz0mrEBbpqBcpywGiKBQvdIH29PbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af/e2FBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76288C4AF0E;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961631;
	bh=g0c2J8l1AVStje0/uF5fYXZ83d8hO/iWIMUtbgnpBzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Af/e2FBoCd4iKnJA/V4ujshU+Dye1OPShjCsIkjMTsjZeUiXe3N02y5AdSzeMiCTE
	 NcRqHYoho4ZEsX3GhEKj/ZE+HQ4e5+UWuwE52hpuZUe6k912fYqC080K/LXdiQCc43
	 TRc7uyMKpr/AEf61Z2TAgGHzMmwpFGt4f+C7lyI+k+3W5MzHkNC2a2sCN4LnNpqWfn
	 kIGU27UGZZ+QfgxrPuskTbBLrjJb/PFBQ5nTHUiDkEDLW+LqLKkvxsVHE9R6YhcHdp
	 Pg+HrP3TVergb+m79qPwDFbi6QdBwyfSI3wV5F9woNfZbUm4TNNv4V4KH8XTWURGPl
	 a9YOQk//NHu/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 658B1CF3B9B;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: dsa: ksz_common: Allow only up to two HSR HW
 offloaded ports for KSZ9477
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896163141.20195.5158269251673335777.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:20:31 +0000
References: <20240619145809.1252915-1-lukma@denx.de>
In-Reply-To: <20240619145809.1252915-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: olteanv@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 o.rempel@pengutronix.de, Tristram.Ha@microchip.com, bigeasy@linutronix.de,
 horms@kernel.org, dan.carpenter@linaro.org, ricardo@marliere.net,
 casper.casan@gmail.com, linux-kernel@vger.kernel.org,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jun 2024 16:58:09 +0200 you wrote:
> The KSZ9477 allows HSR in-HW offloading for any of two selected ports.
> This patch adds check if one tries to use more than two ports with
> HSR offloading enabled.
> 
> The problem is with RedBox configuration (HSR-SAN) - when configuring:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 interlink lan3 \
> 	supervision 45 version 1
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: dsa: ksz_common: Allow only up to two HSR HW offloaded ports for KSZ9477
    https://git.kernel.org/netdev/net-next/c/dcec8d291da8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



