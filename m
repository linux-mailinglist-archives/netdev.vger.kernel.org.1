Return-Path: <netdev+bounces-130064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87924987F1F
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84131C225E0
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7E17C98C;
	Fri, 27 Sep 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of5tmNRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0215DBA3;
	Fri, 27 Sep 2024 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420781; cv=none; b=dAS0XHF0LWRGd2t7jM4if8LLCeEtNs7nsl+5/0EvhDWpqnp4akX0hJW+TD6dp13d7YEYxC+xOb2NFGaWjfgatLvvPy2a2rnuwIZ+E/oH27A10qDZmEEz/2UC/6jMejOfIHi8rYUqH3n0jyHqZz59oVBoUsC2boMkP/cbsqNY68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420781; c=relaxed/simple;
	bh=oFQtzGziY/6iXsdxTYP56etstVrlcox6WGvjzC6eQp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jaW3np1MQOClJvvdQa/OCsMcNQlU+GXBkr2MRTuRGrtclSNMZksJGdZDS//ND20HXXOanUDSnZ5cicaQSTMxhTtd6/GUdaXRsaaW87wL0n6T2h8OLQBDIZEAJD05dOWE7xbRE2ssMUsESGE4hQQk90ufW/MX8qKtjHVF9/+I2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of5tmNRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94761C4CEC4;
	Fri, 27 Sep 2024 07:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727420781;
	bh=oFQtzGziY/6iXsdxTYP56etstVrlcox6WGvjzC6eQp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=of5tmNRiaM/+0729yFI16xvmWHjqtvORCSDTISfT/foc/cJMBcizvfT2Ttf+6ZYdG
	 yPz61qcKPc/1PehS25vrMnxETH+MtaUZb0UAdazqVmCwWSHmTPpKhl9IySaE6WueOz
	 EDXqW1DtwJP426jhjZ0NuCOLEK/NPEZh96dUAAbtqAPBFHGwH0Xvk29RFfzegIuMrn
	 efZ3zAwf/uYqruiywtobXqdWMrg3AuZLcsHHjsGk9Ru0MPA1uJxUwcdJDoV+49vfdX
	 Wmyzus+BLm/EjjfHAR14bddPCr0NI9MbWx8jnHKhV4PnBuTTFahzyTaRiBA5CNKYFS
	 830mpB5bKR7AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5D3809A80;
	Fri, 27 Sep 2024 07:06:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.12-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172742078429.1792128.10518479788559834309.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 07:06:24 +0000
References: <20240926151325.43239-1-pabeni@redhat.com>
In-Reply-To: <20240926151325.43239-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 26 Sep 2024 17:13:25 +0200 you wrote:
> Hi Linus!
> 
> It looks like that most people are still traveling: both the ML volume
> and the processing capacity are low.
> 
> The following changes since commit 9410645520e9b820069761f3450ef6661418e279:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.12-rc1
    https://git.kernel.org/netdev/net/c/62a0e2fa40c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



