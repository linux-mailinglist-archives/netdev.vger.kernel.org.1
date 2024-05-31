Return-Path: <netdev+bounces-99859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D688D6C0B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1510A1C24661
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DCB80626;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUbVZVtl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB57FBA3;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192880; cv=none; b=REesIQ45iUaUrJFgv/AQdlX9xUjDO8f9dB03g3xUmKmvXm2tu+6RLvbvPLbY1jVQ6O0A9M2065Wqbih++E4fzfWIHmnnX+qfR1M4gQeuA5bZD+KClCQJMfPzpiEFFUPQ3bGQ3qkh1BW3IFZpQaSzlc/VhDFr4YALR2gP3p/oamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192880; c=relaxed/simple;
	bh=B1nhFH9+b0a+qouNiXXD1ckeyEaSZT846aH+eLgErzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pG8avWtUUxyTw6b+RGyjblquNW1YWSgE3+Ag/yfCawpWf9aT6C+t58f8ByM3Hjsg4hupFCPUbBIPEWW44g5iFQAZE5lUBaV3t6re4EJeAwaTJe1GeyPCUJilX/zyosxXkH/RK8DEMcdBSdqFg0H5h38cbKo7Ds9duSjwwP40UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUbVZVtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB2BC32781;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717192880;
	bh=B1nhFH9+b0a+qouNiXXD1ckeyEaSZT846aH+eLgErzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUbVZVtly5k+Sre85Z14ywMcotB/PYbX+PvvqBiuEOF3Ee9MMJV3ylyi12g30g+A2
	 vyEevpfaf2/b1HcNUKiuqh7nBt0u6mX0jRQWyBXJTZ+Rb0/4cCwWtjFwMzgRHh9gH6
	 QG2dbs2Zb+0qGF+WF+WSEQ7pLqj9deWRD22awPRO/hvgHEhdOsFBDuQpmBSXsFc7UT
	 Rdk0jdvNIZaQy3U7JMoosAcvgfA0B2YLzQ12OjbtBAOmdq4FOUENtjW6C4J4Ai0RQG
	 Sp4p+0Zj4BjobA4YmSEEvFD/zP8xI24KAunMq3cX+/1p8DgHa5zTWxMr57Y5V1NhpL
	 vNyfl2EGtiDiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E470BDEA715;
	Fri, 31 May 2024 22:01:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171719287993.16477.7035773556534341448.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 22:01:19 +0000
References: <1717119511-3401-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1717119511-3401-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 18:38:31 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The driver should return RMII interface when XMII is running in RMII mode.
> 
> Fixes: 0ab7f6bf1675 ("net: dsa: microchip: ksz9477: use common xmii function")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Acked-by: Jerry Ray <jerry.ray@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [v1,net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
    https://git.kernel.org/bpf/bpf/c/278d65ccdadb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



