Return-Path: <netdev+bounces-25087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D6772EAD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD10B2814BC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2716421;
	Mon,  7 Aug 2023 19:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B81640B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F81C433C8;
	Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691436624;
	bh=/7v3mZhFIHfUVk3LqO4HMIjd7CSdrFevRfSSYLZKDrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FGlkkv/GSmFsdGvPrl7nQV/NfnCxpS7oKt68rTpGg/7EBgNZTBp0QL7URCElpNIQ4
	 rH2prj9DAAv6uujPcZNxH6+fT+5XpnEpy/FFRfigPOxrH918WlnXztNk0aMdOUOmpU
	 7plyprFkBM9/nyU6guMnYvoGHvgZuOb+JSZygfqhdZjuGU+rmvMDM+l+hdzpCyH4Y+
	 drUwrb+x4Ru55XrKdlXpM4tHR/+hm7IUm15XDTXSofzKYT3CnhdWG7uK/YJAJDrk43
	 r7ULPj0+P7bqTdsc0k6UENeckScEvnUbfzkb3nCGew/mDZC+9s0SnH8awXNCCgNA+R
	 l+my92yRCgT6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5DE9E505D5;
	Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "riscv: dts: allwinner: d1: Add CAN
 controller nodes"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169143662467.21933.9656894159328024751.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 19:30:24 +0000
References: <20230807074222.1576119-2-mkl@pengutronix.de>
In-Reply-To: <20230807074222.1576119-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, jernej.skrabec@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  7 Aug 2023 09:42:22 +0200 you wrote:
> It turned out the dtsi changes were not quite ready, revert them for
> now.
> 
> This reverts commit 6ea1ad888f5900953a21853e709fa499fdfcb317.
> 
> Link: https://lore.kernel.org/all/2690764.mvXUDI8C0e@jernej-laptop
> Suggested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
> Link: https://lore.kernel.org/all/20230807-riscv-allwinner-d1-revert-can-controller-nodes-v1-1-eb3f70b435d9@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "riscv: dts: allwinner: d1: Add CAN controller nodes"
    https://git.kernel.org/netdev/net-next/c/84059a0ef5c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



