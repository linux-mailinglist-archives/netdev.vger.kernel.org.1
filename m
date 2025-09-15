Return-Path: <netdev+bounces-223254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA8B58821
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E400B2A1D4A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24280214236;
	Mon, 15 Sep 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or69T9sA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004542566
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978406; cv=none; b=B48uWKvMZe/1VEEvkI654TgaaK+Y0wD5XdV+bfl2avEX//MrXFEPTTeLrAUjK1w084sfEu4ZGRSScgwOt6VypuG8MJffWsUUeogfMb4yJsLP8Lcdx3AuRkIhbBj/vHg6Fz+L94fB4v7Ur/fKxrGYpSYDEWXCdY2lrU18LnYWPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978406; c=relaxed/simple;
	bh=FZxVssu1CUggbLI3qyO65CcZIfFjJ+gG1o+Rc59NlL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMtdKhXwVo9Hq9V+uwxkxA7AW566AONTz5VDsTPxV5nP9+AS+/sSEjkMGnHehSYY2x7+ifCWEfkHBdAMVjCGZkSuobbUTinLpugZk1JLJY/p9akPWsSc8VvLuG2QzEPKuHHBxMsmKnJWV0zo8nR68Ph7QEEWa6FYStasZz6pMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or69T9sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89615C4CEF1;
	Mon, 15 Sep 2025 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978405;
	bh=FZxVssu1CUggbLI3qyO65CcZIfFjJ+gG1o+Rc59NlL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=or69T9sAy7O73pRUb2kK37SchBV6TLjjIQv6/8T1AJdFd5ry6Xanv9ugCx2/+WpkC
	 5G5RJU9KEX9S4ATKUZveppClfqgHuxXD3FflANsEVOpWv1txFwy1FfrM+v1dPT6BhD
	 kXXvCXPBMsYsqvDNr1F9RVze6ZZrAhL4pFCog3hHs92hsCyifxYEShJK6lD6Jp+6sy
	 eDho9K182IIyNQ+QZ+0qQKKDrftcBp7XuJdGWcYSJx8oprjUC0nrnbOY4RHD39Kbj5
	 835Iz6Cztrvpvx7lMKsa5zWLocDqwbk/Fzc6CS+V6Vxs8/g4cK3ylwxAN6GbDbvk/z
	 eOhwbhdfOOzcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDC39D0C18;
	Mon, 15 Sep 2025 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: Adapt tc police action
 tests
 for Gb rounding changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175797840700.158095.11873406828281486126.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 23:20:07 +0000
References: <20250912154616.67489-1-victor@mojatatu.com>
In-Reply-To: <20250912154616.67489-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 jay.vosburgh@canonical.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 12:46:16 -0300 you wrote:
> For the tc police action, iproute2 rounds up mtu and burst sizes to a
> higher order representation. For example, if the user specifies the default
> mtu for a police action instance (4294967295 bytes), iproute2 will output
> it as 4096Mb when this action instance is dumped. After Jay's changes [1],
> iproute2 will round up to Gb, so 4096Mb becomes 4Gb. With that in mind,
> fix police's tc test output so that it works both with the current
> iproute2 version and Jay's.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: Adapt tc police action tests for Gb rounding changes
    https://git.kernel.org/netdev/net-next/c/b7df2e7eaef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



