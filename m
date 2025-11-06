Return-Path: <netdev+bounces-236422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A96FC3BFF4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4CF1899D22
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451B3264A8D;
	Thu,  6 Nov 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap8p4VUe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4282475D0;
	Thu,  6 Nov 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442434; cv=none; b=sZ73XVLIL0EaQZ+7EbV9quDDV0MgZjySFIB6U1RkOAeWIt8MnfMlr8vDXlJ4JMMxTdbvoBwo1y3PZ/XfCvkxfNSDH80yMdeZ4xwINvVReJBK5VGUpWFHNT5tU15ENE9Cz5XREJ08/TBxmHKOoQvr//Iwxma1gR/CJrO78O90+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442434; c=relaxed/simple;
	bh=75nwJcYh3ayxAyBri9fPkZT2hlnuHFYolgbEPXEoNEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qCgj1bKRlrvEonZFP7c5BhLi1IgaJJejIABxp2/KVyBgLZEXyNE46LCVsZm1zB2/hNcuvXZhb1mWlnFzjhIKYnNQIuDbz6RzLAO91xUsD9jDg0bDmnR/B4xTpwDLKSur6OjAymP/qiZ3jX/ELt1huCuHS45DqtgzoEmDT4X6zNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap8p4VUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875C6C4CEFB;
	Thu,  6 Nov 2025 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442432;
	bh=75nwJcYh3ayxAyBri9fPkZT2hlnuHFYolgbEPXEoNEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ap8p4VUej9qNBy6kcMV2rDhoURxA8Y/snR1cLEr1eoAnXJBLTeuXNlarBYgU09rBY
	 QSQXNZwZmALj67EKc86XN5A/sAn6Y8d6QWqAv0csqATaBfzlQkkw04etWoQ9pQBZhx
	 MAqfK85gjZWiL63OG7X6ATBa1dgNgsw1VQbDBPnCc3pzmT05KEW8tFbMytJHZ45C9P
	 LGW3aV53Wi5q5hSR2tjEEwe2OyG5EBp0hgRgNMh4KxcnKbOcS+Vge2/jW1ExU7rp4M
	 66SqDZFq9dIzuPGXjmTzdv9cmvXLAWR9Ww5O9xyj8Iu2Al22tZsPq2V+f23Z7+PXQc
	 AdCiNU8Fmd48A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8D39EF945;
	Thu,  6 Nov 2025 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: microchip: Fix reserved multicast
 address
 table programming
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244240551.248343.15383684088656662475.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 15:20:05 +0000
References: <20251105033741.6455-1-Tristram.Ha@microchip.com>
In-Reply-To: <20251105033741.6455-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, arun.ramadoss@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, linux@rempel-privat.de, lukma@nabladev.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Nov 2025 19:37:41 -0800 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ9477/KSZ9897 and LAN937X families of switches use a reserved multicast
> address table for some specific forwarding with some multicast addresses,
> like the one used in STP.  The hardware assumes the host port is the last
> port in KSZ9897 family and port 5 in LAN937X family.  Most of the time
> this assumption is correct but not in other cases like KSZ9477.
> Originally the function just setups the first entry, but the others still
> need update, especially for one common multicast address that is used by
> PTP operation.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: microchip: Fix reserved multicast address table programming
    https://git.kernel.org/netdev/net/c/96baf482ca1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



