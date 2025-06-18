Return-Path: <netdev+bounces-198853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB933ADE0BA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAF61785AE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B1922FA;
	Wed, 18 Jun 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouLCo4yw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073A3A1DB;
	Wed, 18 Jun 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210840; cv=none; b=ZBI73Mdo3xdMY1Myc5NjoQm6gZZNqUvQlbRi6RfQYWd8MG1lwJb7fQORAw+nZubwLiT6lpOUurjJBEhSOtc1QlXGK5GCwq3mXAguNZ9OqAOSCrA8mHUZvkRjvdwnqqwUNTHJzG/pXEoaBOKCwE7+0oMEPD2hhgIAsPMNBkyKXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210840; c=relaxed/simple;
	bh=oVI16x2/FtAROcV7OsmmjED9sjLpxlYCzbKyqsxl814=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GuWj4ugGNwCoeZD8uwkx8EDrgmSs5Gb+c5jETP+qc/OaubyXm8CyimmxRyUziF7AuPOxIhFdfD+gfhm9oGNFUcEHmUruqL5vrARE3FGAhbK3GRSJ7U4yDW2b6yPH9boSztNBMYWaaiKtBaoK6Pe2aHWiC09VlsZw79zNjv0yEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouLCo4yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09BBC4CEE3;
	Wed, 18 Jun 2025 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210840;
	bh=oVI16x2/FtAROcV7OsmmjED9sjLpxlYCzbKyqsxl814=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ouLCo4yw4jp3rBKePUYVHasSmTOHOqs7Mib/rMreHGnIlmR9s/XcSJUyBZxHm25cR
	 TWcie5xMPqDLfLmiD93gKF7NOfOi4sGZxy0AYXilRQJI5GvFqUCvX1V00MPv3Q4lyY
	 41YM984WOynFUBZNBakronJ+BwBQ42nqs4WY2Sy668PkCgflCz9nGO49P2Wyj/Fz20
	 r6wN/OhWXjR88+cQHJuQ+AfgG0DJBj/8Wh6JPCATNoRDpQVMAmobBRHnmWdObZLjnh
	 GlDd0VULZ5VyQ8RkyylmXbbvt6tHWxEt6zn1whLKHQcAWbERPp5BLN3W79/UjZlKEz
	 I0+oveNmnvn7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4C38111DD;
	Wed, 18 Jun 2025 01:41:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] gve: Fix various typos and improve code comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021086849.3761578.16887973997581697428.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:08 +0000
References: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com,
 hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
 bcf@google.com, linux-kernel@vger.kernel.org, ziweixiao@google.com,
 joshwash@google.com, willemb@google.com, pkaligineedi@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Jun 2025 22:45:00 -0700 you wrote:
> - Correct spelling and improves the clarity of comments
>    "confiugration" -> "configuration"
>    "spilt" -> "split"
>    "It if is 0" -> "If it is 0"
>    "DQ" -> "DQO" (correct abbreviation)
> - Clarify BIT(0) flag usage in gve_get_priv_flags()
> - Replaced hardcoded array size with GVE_NUM_PTYPES
>   for clarity and maintainability.
> 
> [...]

Here is the summary with links:
  - [1/2] gve: Fix various typos and improve code comments
    https://git.kernel.org/netdev/net-next/c/b52a93bbaa51
  - [2/2] gve: Return error for unknown admin queue command
    https://git.kernel.org/netdev/net-next/c/b11344f63fdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



