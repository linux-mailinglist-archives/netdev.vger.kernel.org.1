Return-Path: <netdev+bounces-37528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0F7B5C86
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8B53281BF8
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62224208A4;
	Mon,  2 Oct 2023 21:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52109200D4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B30C433CC;
	Mon,  2 Oct 2023 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696282822;
	bh=/RcyHCaty3bNIksxLoRHK7sZ8f942Nw2QPMzd6ZJ/aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kAdvqJILjhsviKB5/v13qYtrv2xDJAHjlsY9xcGScH09KoJ3mXH76IPrbzak6cZKd
	 ax1kes6vi08WXN94BKR2oyV2UApaJ2G5I4yQqUAQ/dEkzJWn2wLM3YVSBJTsVjTlet
	 079iWZLyLFX9xFANutBRQROkLyF1TgiAqHe36+9TRDeKFB8vBCLMGNwdahWCmYEMDj
	 yDf2l9ZTxbCr8t2TGqbsHbUtcbum4eqZ53WOyFlTCM3FjphTFtuERcFeZgVDvFxZZ8
	 Y8RRS026FpwBShXHiINnT2bBbSqY+0Ve4FkQfDsakgLYXJqFNsxebrMP8jaa+ij9Yo
	 vUEJO2/DGiK0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC77BE632D3;
	Mon,  2 Oct 2023 21:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] Add a security policy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169628282270.10123.13802099192753922649.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 21:40:22 +0000
References: <20230929230629.66868-1-stephen@networkplumber.org>
In-Reply-To: <20230929230629.66868-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 29 Sep 2023 16:06:29 -0700 you wrote:
> Iproute2 security policy is minimal since the security
> domain is controlled by the kernel. But it should be documented
> before some new security related bug arises at some future time.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  SECURITY.md | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 SECURITY.md

Here is the summary with links:
  - [iproute2] Add a security policy
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=015d8e7fb877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



