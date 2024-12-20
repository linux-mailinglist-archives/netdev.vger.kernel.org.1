Return-Path: <netdev+bounces-153815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B09F9C54
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FAA169260
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F98222568;
	Fri, 20 Dec 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8pE/Z/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AC198845;
	Fri, 20 Dec 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731412; cv=none; b=rTJ8y5PKGO2Z0stYlD8x9myq92X1gW0rlvuDP44T82WiHT06F8AP2y9W/sV8awD8xsWvpUJ537ku1RfIATy+bap0aUyfG5EkoEUbQAs/nQbIX1SE34c+jRIbHiuliRVaZOT5G6PEpv1I/+HxGorH+03MXd/DpI+Z9NhXO0p1CXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731412; c=relaxed/simple;
	bh=JZA0zmSw1CNzYJ3pU3WUzcazIgj+CiiiwyxocV0dIBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MhYLqmV3IaHzR35NE2NYl9gf598JM0Utu+1H90+oqhPy+dwPxR3SpZWeFenIS8BB6jMD05+pI+u6r4WSNZwSN47+9cNvuy9HeS5iyb2wWfQ6vSTYUpHy2cZshmZQvzmXtVN9diob7jmb3fabdB5zzjmdpfkdore0xjMYu7GISBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8pE/Z/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11717C4CECD;
	Fri, 20 Dec 2024 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734731412;
	bh=JZA0zmSw1CNzYJ3pU3WUzcazIgj+CiiiwyxocV0dIBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f8pE/Z/yP+AyPi/SOxX731s3G/MjkGfZB8wGx9Xo7my1mo4ZeccVZeLCua6ftyv2G
	 o6hLouAFNZk4h+hK1gaD73hK4OFcKVt+Batl9KGR3Sucl8scyrB3pEHbhlXYwRpGZZ
	 W0ztAv0PwjQGYax4gwupTub6GUxdM0tAXZxCcfvNX9m1ljU9PE8ytYz8QpvR0e5/4u
	 2wOOI5ram7snIltNvPt3stITFw8xGvPj23UgnkCnx+ibNw53tjn1QoTCwEaaGEUrmX
	 c9XJ2Cbvv3KlOgVYliElQxETMj5YsJKTCkaTl6u7Llhc+CRQ8ZZeFa9LGZZdJtlYG3
	 /w2weXp+wYisw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D763806656;
	Fri, 20 Dec 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: Do not execute PTP driver code
 for unsupported switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473142901.3030742.8395151277064990661.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:50:29 +0000
References: <20241218020240.70601-1-Tristram.Ha@microchip.com>
In-Reply-To: <20241218020240.70601-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, arun.ramadoss@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:02:40 -0800 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The PTP driver code only works for certain KSZ switches like KSZ9477,
> KSZ9567, LAN937X and their varieties.  This code is enabled by kernel
> configuration CONFIG_NET_DSA_MICROCHIP_KSZ_PTP.  As the DSA driver is
> common to work with all KSZ switches this PTP code is not appropriate
> for other unsupported switches.  The ptp_capable indication is added to
> the chip data structure to signal whether to execute those code.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: microchip: Do not execute PTP driver code for unsupported switches
    https://git.kernel.org/netdev/net-next/c/6ed3472173c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



