Return-Path: <netdev+bounces-214138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F1B2858D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8536C604A7D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB0304BD7;
	Fri, 15 Aug 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpzCQqI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB088304984;
	Fri, 15 Aug 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281340; cv=none; b=URXCiBy0SqS4qfdfwgSr88PCgHUb8h32kt93//vR0V6qOdFHvk3aa8FdyfUMBHhsHidY0h1mppY2r6ejsnnxOQNvm42j5y8caSqpoz8PbfXeQgXnDE/wh4iRHpY3BMEXMhvbj3T8SRF0Jyqmmu075JjfJq63Im4EkWo7F6H+aQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281340; c=relaxed/simple;
	bh=48uoOdANQeZGLqjpGNW8+lagWQ5FOKsTITA3Xpi113I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZE1yW0s6s9eAzU7cbaWYz/ccWGqKw13IXgXTrrUzNJlJy8xXtJ9POpDb1ztbHuFX15mqmg6la6lgtQhXLb5VxGTBkATag2mpFwAYhl7MQBgLafEQVOgFFb0oLM2F6Q6fqmtGy4wGZGDBc3YREAQoUnhmsQT36n4/2P+d0C224U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpzCQqI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602A6C4CEEB;
	Fri, 15 Aug 2025 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281340;
	bh=48uoOdANQeZGLqjpGNW8+lagWQ5FOKsTITA3Xpi113I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HpzCQqI+vjSXm9/5UhWaBJIZDNAZlzlVmxCiJ7n5yLX9k0qJyeaydUJNoqQOVdQli
	 6dZk2X9z862t9qYy6uX7Myfj94UdsmX5ctBz4820B/bNTWCf1lF3migfbMTbw8v1W+
	 mjhIVHF7PC8Ilw4C23/7Uy0BRJME2M5gMQVKMla0sB02Yb+W9otwWX2P08Jj0yvnl5
	 G1qyujFbCVbzLPTDrLenRsY3nq4ryFHM3nCyndKjU76G1CT9GRIM9GtHoT4mLUMM/5
	 9Fda8te4k9aPc1EY39NOlZdGZc9b3WYfLL3bh6+VFOR0XT2jfkgpaGq0X9lqY3trkB
	 o2M/y8mhj1nKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4F39D0C3D;
	Fri, 15 Aug 2025 18:09:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-08-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528135149.1165776.14097753317071823549.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 18:09:11 +0000
References: <20250815142229.253052-1-luiz.dentz@gmail.com>
In-Reply-To: <20250815142229.253052-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 10:22:29 -0400 you wrote:
> The following changes since commit 065c31f2c6915b38f45b1c817b31f41f62eaa774:
> 
>   rtase: Fix Rx descriptor CRC error bit definition (2025-08-14 17:53:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-15
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-08-15
    https://git.kernel.org/netdev/net/c/79116acb75e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



