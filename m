Return-Path: <netdev+bounces-59484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D581B04F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDED7B21612
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC9168BF;
	Thu, 21 Dec 2023 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn959ot1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7310C12B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE83C433C9;
	Thu, 21 Dec 2023 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703147423;
	bh=/ouw4DmiG7pALsjWDBM3Q2Vnl5OJuXgw9zhU5cpgb8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pn959ot1cgC66UB8DbtS7U7XkuuPcD4E/7Q2OzR6g9wXPiCbNxx0r2nar7HRk17PQ
	 6qJCftRJXua/PerHjBh2RN1w739zUTMxnty9TswjfXvN1wg3DtdCUD0hdcqlCiKj19
	 mywQD91810kTVUEblMv66e3RA2n5XC81FIcSI/9LuLmzlbFbeNEyyED5O5ZW/4BiZy
	 jLbwjtXmyWFu5Cx9tLzl8yyZFs2hXJL+ifMQhn933FlLC0ovCyTYALPm0aw9M+Q6Eb
	 3BYUkTvpSdgVHNMJHwy54al6MzXmUIOP9hBMFlaZn5/XPU4+7nCLFFZmrmNW7hD7bA
	 KS6In/F2o5Kjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4602FDD4EE4;
	Thu, 21 Dec 2023 08:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/ipv6: Revert remove expired routes with a
 separated list of routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170314742328.1371.5514613141172312086.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 08:30:23 +0000
References: <20231219030243.25687-1-dsahern@kernel.org>
In-Reply-To: <20231219030243.25687-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, thinker.li@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Dec 2023 20:02:43 -0700 you wrote:
> This reverts commit 3dec89b14d37ee635e772636dad3f09f78f1ab87.
> 
> The commit has some race conditions given how expires is managed on a
> fib6_info in relation to gc start, adding the entry to the gc list and
> setting the timer value leading to UAF. Revert the commit and try again
> in a later release.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/ipv6: Revert remove expired routes with a separated list of routes
    https://git.kernel.org/netdev/net/c/dade3f6a1e4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



