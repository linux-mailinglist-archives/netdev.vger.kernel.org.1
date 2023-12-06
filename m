Return-Path: <netdev+bounces-54547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7378076FA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F051B20B61
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055F6ABBC;
	Wed,  6 Dec 2023 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf3guVuf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140826A32D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91D24C433C7;
	Wed,  6 Dec 2023 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885025;
	bh=zbXM14EN3sqsrCBofarpNNfTES8vUEuOP71ZWwp2E2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yf3guVufWK5xJaNR4soEjxiHYEmHik47RNa1QaZ6MoyCaEbkm8b3UvEpMDvy4v9w5
	 VP4xpy/6R2/D3XmRDdaRM+JH+t9goxqEY5D/WwG0qMnt6bYoY5Q5V9EPxBIRFJ4an3
	 A4yzud+k1ZToTs33bRwWCho0h5nYilj2/HHnvHHkyHpXX6G6Zg0oQ0Q4wXv7sGXVvf
	 wPRBsj9bQ1tVA0OXJyMnx98S0AWpQQVsapO5M+wYyUX+YfRt4EQbaI988DJhbag0V/
	 PyTa36KRdbUg7IT4y/d1dtVaBMRxrR/BTKySHzjxPNLI2RNEIJ4VdYRQP6if5ew2+W
	 c20JN3RCQW/Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75BDEDD4EEE;
	Wed,  6 Dec 2023 17:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ss: prevent "Process" column from being printed unless
 requested
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170188502547.4762.12538306262617961469.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 17:50:25 +0000
References: <20231206111444.191173-1-qde@naccy.de>
In-Reply-To: <20231206111444.191173-1-qde@naccy.de>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 6 Dec 2023 12:14:44 +0100 you wrote:
> Commit 5883c6eba517 ("ss: show header for --processes/-p") added
> "Process" to the list of columns printed by ss. However, the "Process"
> header is now printed even if --processes/-p is not used.
> 
> This change aims to fix this by moving the COL_PROC column ID to the same
> index as the corresponding column structure in the columns array, and
> enabling it if --processes/-p is used.
> 
> [...]

Here is the summary with links:
  - ss: prevent "Process" column from being printed unless requested
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=1607bf531fd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



