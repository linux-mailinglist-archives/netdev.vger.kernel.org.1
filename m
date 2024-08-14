Return-Path: <netdev+bounces-118283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4655951264
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FF31C20936
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B6383B2;
	Wed, 14 Aug 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4w2hxSA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F5381C6;
	Wed, 14 Aug 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602634; cv=none; b=DJHWYZbkDrIZ0m2OosgCdCKPMchZLcieGneeP+sKoCNakdraDUgcJ/DFBLqXZ5nqP1+6kt38bL+nTwSEnp2zrSLNhpi1fTvhmKHG9Vlf2VY58/s8+AIQcFk+ucGhmse5Uags2jpGFCicIAsc86bxZY02ZttYMiBGCT3s7dYSvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602634; c=relaxed/simple;
	bh=owxpWgIwhEZQy4ebyDR/76qUBaw+dRdCCu6Aywg6FRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E62OAJgfqMRzk+AAI0hyXM+YoFEllEzElLSQSoxvcaUpXVdokovmJYSpHdmjgqAi4Vdfge0I6FGSz7BcHvUstQOOySBQjPoyUv02XEdnG7tAW+KE1TQj0PAMgiVUUsh+hxAV/V3IQUCjizKmmh1Kc4iwMbriFHuJ01IbP8wgWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4w2hxSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A88AC32782;
	Wed, 14 Aug 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723602634;
	bh=owxpWgIwhEZQy4ebyDR/76qUBaw+dRdCCu6Aywg6FRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L4w2hxSAbTvd2CPLGVMwe1T332pJgMqNKVu2jC7A/HiVy2UXZlxSyHujK2fd0NT66
	 MG80kLDp8V+kQRVklGKYPV4hLoOBGv+XWibc603KjyzoCbpW0BTdGzWjHJGpaO0rrP
	 cW/blh1dpJkT+u68E4Y9jJGe7Ovv3mLGUTOHo/blLXkBiwa+dAxUYQcjyGHJvO+2u9
	 sqMo18z9PWX/iSZ1Q0tzDLpXLlynjYZkOAFO/QuIvNpggpy2d45PBcFgVdzWvM8CsH
	 CK0NLZu4sSnpBwUNyfFR+BQh9fqB6EppWFL+r6Nw2HE3fPLpUNgmlD6Sp8ToiClSgR
	 zRiSleVghjc5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF113823327;
	Wed, 14 Aug 2024 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 1/2] net: fec: Move `fec_ptp_read()` to the top of
 the file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172360263324.1842448.13885436119657830097.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 02:30:33 +0000
References: <20240812094713.2883476-1-csokas.bence@prolan.hu>
In-Reply-To: <20240812094713.2883476-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1Pg==?=@codeaurora.org
Cc: kuba@kernel.org, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, Frank.li@nxp.com,
 wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 11:47:13 +0200 you wrote:
> This function is used in `fec_ptp_enable_pps()` through
> struct cyclecounter read(). Moving the declaration makes
> it clearer, what's happening.
> 
> Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
> Suggested-by: Frank Li <Frank.li@nxp.com>
> Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] net: fec: Move `fec_ptp_read()` to the top of the file
    https://git.kernel.org/netdev/net-next/c/4374a1fe580a
  - [v3,net-next,2/2] net: fec: Remove duplicated code
    https://git.kernel.org/netdev/net-next/c/713ebaed68d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



