Return-Path: <netdev+bounces-15054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E34C74572C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C8280CAE
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DA1C2F;
	Mon,  3 Jul 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9117E2
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D8AFC433BA;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=IDyrYN95SXj1vj5H8+99NRXrwYhAd4YqqT6rjHrzBzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jIvBKF68lNDdsxJFYLJWp/TaGRB2sGdcJieVCjrfMC9aP6NDE4W1roPjuFJC/nmYn
	 YjVm8Rk3VVflCjzhx05Z2W0LgqCNbaMW++Ia2c6mjyrYPdYHStAR7RVDnPbvbnhU+e
	 xySNqAYyI3+YYCFX7c41OmiNLSFfUdnT+25z2yjHotTKq5jlGAViac1ejw76vUPsU+
	 UAxjWk9BYBAi/bqKO2R8b1/16A6Oz5x+CmfnunifQ2EuPYXne44O/4V98b+IIX9yuH
	 b20fLrafvn/R8rkMnwlMaZq4FzvEfknM2rGEy6DNIrTKmtP5kyx0QBUys3Yv/sw3wr
	 nzzf3MO7x6pyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61FDBC64458;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] wireguard fixes for 6.4.2/6.5-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242239.9798.17170383038567184871.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230703012723.800199-1-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jul 2023 03:27:03 +0200 you wrote:
> Hi Jakub,
> 
> Sorry to send these patches during the merge window, but they're net
> fixes, not netdev enhancements, and while I'd ordinarily wait anyway,
> I just got a first bug report for one of these fixes, which I originally
> had thought was mostly unlikely. So please apply the following three
> patches to net:
> 
> [...]

Here is the summary with links:
  - [net,1/3] wireguard: queueing: use saner cpu selection wrapping
    https://git.kernel.org/netdev/net/c/7387943fa355
  - [net,2/3] wireguard: netlink: send staged packets when setting initial private key
    https://git.kernel.org/netdev/net/c/f58d0a9b4c6a
  - [net,3/3] wireguard: timers: move to using timer_delete_sync
    https://git.kernel.org/netdev/net/c/326534e837c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



