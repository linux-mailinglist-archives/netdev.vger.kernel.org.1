Return-Path: <netdev+bounces-227267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B1BAAEBD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E07D4E0685
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF351FE471;
	Tue, 30 Sep 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2d+73AK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653A1F0E39;
	Tue, 30 Sep 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197042; cv=none; b=Jws9YHEb4+yR/Vg8+9LD8Vvhij/yxXU6T+MUzN5pQcMqyWc8Ez73esMAoVwYd6jL+wq01LSYTm25OkDsPDYSNE/t2o/cPA6s9Sf9mWc/FupCvpmbRFZ7NgNs7rlsa/4M1Omv/NlSQVpHCbwRCQQ4Ut4oI6o6FTy8y32DbdJ1iZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197042; c=relaxed/simple;
	bh=fmcYjWJAnGdhbsMUxYEUP6vCOJjyb2KhW72GCar/ySs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJrYtKRQ6hl5c/acXdwai31hYQJzySBPN4n2rb+1pzgoU+rHUelnjdhqE/nCezQa6uMXfyzgESohGh4qoLa7W9sATN+TTkakm9gS7YWDZTkCm8hLoacv9AbMC5QeLpRwZV6+GfSkef1Anj4BfnPP9xxsdIjIgpg9IR0jVBt/xH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2d+73AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8F6C4CEF4;
	Tue, 30 Sep 2025 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197042;
	bh=fmcYjWJAnGdhbsMUxYEUP6vCOJjyb2KhW72GCar/ySs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2d+73AKmrnqDc7leXgfFj8Ctj5ugwep7vPk45YGtVuyDgqU2H/TyHTucnswLXSq2
	 Wkjv07XWjUdSg/DBJ56ecR4SRsYSfNGm67CWRMgIaQX+rWDhBy62n1peZyw2ZFWn3a
	 tOHo8qlPPBsN/mnWLSIdrjLzQBkUqJQhPgCbJ4LccSzWKOfMYdBAIxgY2UAJ2USNXA
	 Lhrer1U2Pwa/D1szx7USSgVbnWT2HPoVkWCkmFnTgT5z4f8gPOVfeEVhS3nWXdWfMG
	 USbIerc7boAKmG9Q2iIYUtSF6dD2jYOzWSHoExc6KgGteHuEHt1E17ovQMzeY4w2oX
	 26aCfJqcn8kDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFB39D0C1A;
	Tue, 30 Sep 2025 01:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: Convert open-coded register
 polling
 to helper macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919703549.1783832.10169355846256119327.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:35 +0000
References: <20250927081036.10611-1-0x1207@gmail.com>
In-Reply-To: <20250927081036.10611-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, xfr@outlook.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 16:10:36 +0800 you wrote:
> Drop the open-coded register polling routines.
> Use readl_poll_timeout_atomic() in atomic state.
> 
> Also adjust the delay time to 10us which seems more reasonable.
> 
> Tested on NXP i.MX8MP and ROCKCHIP RK3588 boards,
> the break condition was met right after the first polling,
> no delay involved at all.
> So the 10us delay should be long enough for most cases.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: Convert open-coded register polling to helper macro
    https://git.kernel.org/netdev/net-next/c/9dd4e022bfff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



