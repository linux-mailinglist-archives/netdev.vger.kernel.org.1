Return-Path: <netdev+bounces-47201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E17E8C5C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C7F1C204F9
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34851D524;
	Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBZFJzcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D761CFB6
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B01EC433CA;
	Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699732318;
	bh=E1tQyCqMl32KOMn+s1uC72GC67R6UlVPaP/XKC05Z64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBZFJzcwfIRtJaSJdUT9oBGipMInwM26YtLFNrGBRPRK/b9gZRvHjidZoOrBxR8IQ
	 PkirNHeM3j9ArzSPqPFWBpbhfgZzrtt9BuxDdDiT+NvQi9BPpCdeKO+t+h9EC1cFzj
	 uETugurYIK7GDZhB7FGy+zUg3CVHY2X/JmI9lnQ8rtgkO7yoSX1zsgzSe4h3HsuRKx
	 n0JJKwkLKxfhs4jv1eHkq86rIDMnWzhYDVg2x0aJrbZCmF8dIvgaEr8imD46gR8BI5
	 9Bb+SjzNBJvGBQmgZqMj5RlnMqsDqoFCv4hgOGu+mR/3eeEYHpPN4/PSz7uF/J19Za
	 nUjaXBDBf5pHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E734CC691EF;
	Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix error cleanup on failing
 pruss_request_mem_region
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169973231793.11806.1960922852884307805.git-patchwork-notify@kernel.org>
Date: Sat, 11 Nov 2023 19:51:57 +0000
References: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
In-Reply-To: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
 baocheng.su@siemens.com, wojciech.drewek@intel.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 17:13:08 +0100 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We were just continuing in this case, surely not desired.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix error cleanup on failing pruss_request_mem_region
    https://git.kernel.org/netdev/net/c/2bd5b559a1f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



