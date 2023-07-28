Return-Path: <netdev+bounces-22136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F6476626C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CF1282612
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2D3D61;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57921FDF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 661EDC433C9;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515023;
	bh=x4QQ4p1Ebd5vZQq4UPLo5lP0T3ZtqaiNlrSfm4u1hec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iVtFExw4s9yO6Gnbh4FbM3C0BdIjaBWJMhLQtGpMrx1f9Zc8UQ0lt+yh04JHIo7K0
	 TrRqqGfLUnxOLHIwMpDCAzLJCxpkspp1MdTAuvXq5uc9c8EbdC7Joc5ez8ZxH6B28M
	 OOxNS/yOsBxDKD802lWX75ZdHrVPDIFp/2Sjr0HdK18H/1SwuBP15ktr/TqyaM0+xe
	 UQFNXPSQEjZGNZZjKFQZ2eJB4m24m7P9UUh/ZRcbbr9tAtAnRlhKc7o0n9/5lYCMHm
	 K7YJ+THLEjJAFcQ/lZxuwkl1YDm2pZ+JWSH7kTs1BCnkpRYLybjPeDDAbtVQouBMgq
	 euEBLVsRNVNmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44AA4C64459;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: dsa: fix value check in bcm_sf2_sw_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051502327.18144.14328558908415752627.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:30:23 +0000
References: <20230726170506.16547-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230726170506.16547-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 01:05:06 +0800 you wrote:
> in bcm_sf2_sw_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> 
> [...]

Here is the summary with links:
  - [1/1] net: dsa: fix value check in bcm_sf2_sw_probe()
    https://git.kernel.org/netdev/net/c/dadc5b86cc94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



