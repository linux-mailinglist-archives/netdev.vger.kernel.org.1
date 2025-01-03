Return-Path: <netdev+bounces-154878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EC2A002E3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D60816315F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667FB1AF0CD;
	Fri,  3 Jan 2025 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6HVlqH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE78195B33;
	Fri,  3 Jan 2025 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872620; cv=none; b=EYTunfnT3VvEBo2rBhTNr2OY+U91HqX+qoIAeyBOVNcGuQ+/h+efIqa9S/SiREQM4ZfoEnpv1mha75dGSeTRDs8tjLw7XGqS7MklVrU8GlB0wBjv7RIb/UA2yJnoUZcI6CA2vLsIl+Sav2oP3ooGO/X8tDO1ljW7nhBslSliCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872620; c=relaxed/simple;
	bh=ibbTYrcRNYNasPaUk170k1nqQRurGGHWYZyQiXqBZSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSzBFAbfmkxy2u0+Xs1LSF53c50pNBa9ppOGY7Vyx6LJyNNJEHAKR0tztKAsH7bV09L7Ce8KZqPT5maNLiQOiK91mCJECz/qWT09PA4z+SlsSptHt3YHjSu0YwUiEC9QTnb28YQmQUscIprPNAgOURljw06v82JH7fp3NjxAztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6HVlqH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA517C4CED0;
	Fri,  3 Jan 2025 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872619;
	bh=ibbTYrcRNYNasPaUk170k1nqQRurGGHWYZyQiXqBZSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K6HVlqH1MXAZLDoFgiNnRduK0pntDWhOw8k5HOJp25+61frhSEk0PNpS39CLal3AB
	 fi0Y/f9eMErdyO6khckxorsEp4WJjiQN1hrslrl9MV0i89dX2gM//aWuGgDlVFKtXc
	 dQzN1j/uX2uDhCrG6G01uj/a6UV3JT+LBBKiIzgEkVq8OJfBnCLdwN1hH52rl1INOr
	 BUr2BhxeGDRuw9T55kuNcM3386b2VY4Ej+BHuStDJrAFxiZU7iTcWj2iVyNzAeCyLn
	 VWUFQk/lm25jYuoEGJKPNj1ODux886XL/66DsD/LxpwNM+/Ec/4+RNIfIlnGAq2QEG
	 PExR9YGdc5UeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6D380A964;
	Fri,  3 Jan 2025 02:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: wwan: iosm: Properly check for valid exec stage in
 ipc_mmio_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587264000.2091902.2245452495445092796.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:50:40 +0000
References: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
In-Reply-To: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: m.chetan.kumar@intel.com, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Dec 2024 17:46:58 +0100 you wrote:
> ipc_mmio_init() used the post-decrement operator in its loop continuing
> condition of "retries" counter being "> 0", which meant that when this
> condition caused loop exit "retries" counter reached -1.
> 
> But the later valid exec stage failure check only tests for "retries"
> counter being exactly zero, so it didn't trigger in this case (but
> would wrongly trigger if the code reaches a valid exec stage in the
> very last loop iteration).
> 
> [...]

Here is the summary with links:
  - [1/2] net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()
    https://git.kernel.org/netdev/net/c/a7af435df0e0
  - [2/2] net: wwan: iosm: Fix hibernation by re-binding the driver around it
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



