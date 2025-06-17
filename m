Return-Path: <netdev+bounces-198837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A0ADDFAC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C59189B9D9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04E29A9F5;
	Tue, 17 Jun 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4a7GVyq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0028C2D1;
	Tue, 17 Jun 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203028; cv=none; b=V96MHK/VLUiPoUPWRjT7YU+vqYMmecR0HGmGPV83c9A6tw8Cxpjx+r0IaTWH0WMVKABZUL0yBz5mSTRWoyOLg1hODbB2jsBFOljJP1q0BdCsnwUdQ4XvR/X4qxbDIXX0QR9M+ZwIS/fpX873EI3BPJKmQvUFJp4rgVkMUZ8Ors4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203028; c=relaxed/simple;
	bh=h7uRpo1qewWYveGSzv0LBvul9IHdQyYQNCRNh3R0DjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvpPjAvYMZTmi3PTWIGaSHofyR9e+bXEwWEME6w/rQ8+9o3sE2bgzzkNpKf83bA9yHAMIwbEi1C/U3vpDhtvaJ0dWHvHbeYepQ4cV+XheeuCB8qwhP3dDR2nkjwnGkpU7ISdKJ1rE10eQm11oZUIhdOm4nR7Zvh9BbKUVm5Tau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4a7GVyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358CDC4CEE3;
	Tue, 17 Jun 2025 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203028;
	bh=h7uRpo1qewWYveGSzv0LBvul9IHdQyYQNCRNh3R0DjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y4a7GVyqTmLRdTkBwAgWLexEnA21Nad1j4iSf5uWhT9rylzy5ma04L9OpR1QJiGs4
	 M5N41FBDk2xsyx2ZtLRsYFJb9CEaepQpLQrmOnWOoNXTyFuICV78x30Dd7g3uaEYWt
	 ayhYEAVmHXlYcsbJXIPDm3sSEtglb42nXXd3ouuPA3dB15M9ogPAnyzOg7Ae04B/dS
	 R2/QKm268jUwZ18wwxrCKubgIb9Aaqd4zLh8bIkZjw4Gh0xZK+48U7DQ/+ilHMdpcl
	 DEW9GxZdjYqo7Zqz/rKX68Zzmj5KGbrxa3YAVy3L4vyw6NROtLVVWqsInaFNGUU6Z1
	 liJkiiSE3wgqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6E38111DD;
	Tue, 17 Jun 2025 23:30:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Link NAPI instances to queues and IRQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020305650.3735715.11500418526187029243.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:56 +0000
References: <20250616032226.7318-1-justinlai0215@realtek.com>
In-Reply-To: <20250616032226.7318-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, jdamato@fastly.com,
 pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 11:22:24 +0800 you wrote:
> This patch series introduces netdev-genl support to rtase, enabling
> user-space applications to query the relationships between IRQs,
> queues, and NAPI instances.
> 
> v1 -> v2:
> - Use netif_napi_add_config() to support persistent NAPI configuration.
> - Use enum netdev_queue_type instead of driver-specific values.
> - Rename ring_type to type.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] rtase: Link IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/9f611bfd1011
  - [net-next,v2,2/2] rtase: Link queues to NAPI instances
    https://git.kernel.org/netdev/net-next/c/8d672a3e51ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



