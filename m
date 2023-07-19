Return-Path: <netdev+bounces-18991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A19759431
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BE28184E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D638E14275;
	Wed, 19 Jul 2023 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6E134C6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EAF6C433D9;
	Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766221;
	bh=TQnotEzT45fytfUHWkANemNoKil6DWSpk4y142ROpog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLWfvm0KIOWDdv64OIVGEKOu2umskc7+ZXSLLeAwJEOLxN2j5PixNVPHtBgNHMYOh
	 7MV3VF3VbeimMIR1kZd4wc0ez55NlsSpj3MVKrw88VAAKAROfVrtGkUoya03Wc/mNE
	 6EnsFyGcup0TeQk/TBpbGR1f+psRNuSp90g9AxNrWE5Vrx3bDFcQe7ranYM0NNxDW8
	 2F6QKToAxMkHYuC0N0AljOr4AC9AqCR8D6pLldxB9eAoZuklp9Dq2DNNq8aSS2/HYI
	 rsMo2g3fVpAb3MRGXXZUBAXkPpX40m0sWT2acGxsmwG9zqJntDJ5LfV6Z6OS6QkaeW
	 CNOBW+PadzR4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDDF0E22AE4;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] drivers:net: fix return value check in
 ocelot_fdma_receive_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976622090.17456.1429286800608558144.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:30:20 +0000
References: <20230717144652.23408-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144652.23408-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 22:46:52 +0800 you wrote:
> ocelot_fdma_receive_skb should return false if an unexpected
> value is returned by pskb_trim.
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/mscc/ocelot_fdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/1] drivers:net: fix return value check in ocelot_fdma_receive_skb
    https://git.kernel.org/netdev/net/c/bce5603365d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



