Return-Path: <netdev+bounces-211836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA9B1BD86
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4617A6A4F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A626A0DD;
	Tue,  5 Aug 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdXt4uj9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7789524F
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437793; cv=none; b=YnId/aOnWoxi+DkoAAgPzyj2sdHqgu6cdvV0YhSqdxV5KEd30FM7IH5e96tPKZICC1lxShkPklkvE3LayNdtL2dw2srExaWh2JsbLF4TP0QN3o/7BOZr/TTwbwvgyFYwwnL7tUOViDvn5SgKfqIF0gjyR+J8sdZnbGvMKmr/VD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437793; c=relaxed/simple;
	bh=bSZU2q8jz8ffEhpv7GHe2zykfBOOmzyqjhoX4vJaARQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XBlVhctssbcDBKpE2ZzGPRVQ7dwiOsNzdWPKmbZjDoesuGUDxBuf6PmRGxo9lwDylHprjoMxpIBhFHATBxRe19VHsEZYeiINEJC3yIidMrVTKQgHF8UZHJf0as1XpBMUx6J+sfQ7H8XF9m00/3TCfnnroas9clZP/leVesNwjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdXt4uj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7302FC4CEF0;
	Tue,  5 Aug 2025 23:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754437792;
	bh=bSZU2q8jz8ffEhpv7GHe2zykfBOOmzyqjhoX4vJaARQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jdXt4uj9TjKA9/leesBLd0nZnfeR2cSB+leUO+708M5ApcU9l8AcdC3neei48KlsK
	 QzsPLsnGMOzlchGAKs2p/frwNcCVcn3l8Q1NYeVV7FFxv4mJxC1OZLb3EHVsgWWzMi
	 NFx6fE3ioVO2Smgdho/1cyqv+lGM+9R2tU0kkmRXdJfnr3luJI9+QZt9wyQe98ZCUg
	 3vVb3+j17kAv+SuJsV3+v6chJAg55flYX6tP8uKvpiBQVnQLfwX/jXqmqOJts67czL
	 XI7qJeq1UAmja6Cy7HvCGG5ADddl8EtL3BWIrJnG1DA4gX/sUSWLKhDgFjIRuJ0ep2
	 J2qShqfyli2WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB7383BF63;
	Tue,  5 Aug 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: Xfail nexthop test on slow
 machines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175443780651.2205590.13469597711317035634.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 23:50:06 +0000
References: <20250804114320.193203-1-idosch@nvidia.com>
In-Reply-To: <20250804114320.193203-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Aug 2025 14:43:20 +0300 you wrote:
> A lot of test cases in the file are related to the idle and unbalanced
> timers of resilient nexthop groups and these tests are reported to be
> flaky on slow machines running debug kernels.
> 
> Rather than marking a lot of individual tests with xfail_on_slow(),
> simply mark all the tests. Note that the test is stable on non-debug
> machines and that with debug kernels we are mainly interested in the
> output of various sanitizers in order to determine pass / fail.
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: Xfail nexthop test on slow machines
    https://git.kernel.org/netdev/net/c/8d22aea8af0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



