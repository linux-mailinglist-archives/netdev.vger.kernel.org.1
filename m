Return-Path: <netdev+bounces-154985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB7A008FC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B818848C2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988C1FA15D;
	Fri,  3 Jan 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtKjHgru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7F1F9F70;
	Fri,  3 Jan 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905614; cv=none; b=JlH6q1xmf43CrjZjXZ1Woe5s5cUfEQVHxs5n5IgbU6PiqnbORjiOzMR8ZYn6lW3d/7xAiwhWrNJrs/IJyqHlJVLRr/jLMT2XN4Nfpk0JaHo65c6KIF9acS3jVlNq/MUVJs5UF4AUd+u8pQtvIBVOw+9zbF+pVS1jTfBr9GtDeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905614; c=relaxed/simple;
	bh=odP2BkPztbf1tMUCZCw5XXafrdKd+ljA9eJbV3FSjCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gA4OMh7Vg8i7+8lMRzL54UnWxpac0tMoxvsMh5QnNJZxpNAMgQ7lwfX1Upz4K3ExOOw4Mw1wIuqjSRbdL+uPg7RCCkhg5VFJqewm/oLVSr3+FDRae1aClpczycX9DO4qG+2IWmif9NbceFuZ9ghf7ub1u6piIcNBIEuJSquV5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtKjHgru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED47EC4CECE;
	Fri,  3 Jan 2025 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735905613;
	bh=odP2BkPztbf1tMUCZCw5XXafrdKd+ljA9eJbV3FSjCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GtKjHgruS3HUX318rvH9uI9GGrpAvNn0h+oIhuhTAPHYdLRPaO/sCbmdCktGSQ1RH
	 IMVmqsk8ahwLOaT7QAzxu0WLmLJKaL6z3BNHHx6VehO/IWYDhWz7co/STr6+VXjnrQ
	 +sIbHX5U4LHqJl+vpMjLto/fRcW+qgh5CgdhEVcEeTpMJX713v5gb/HuqF+h5AksCd
	 na4UMesohNhcZQZRx86ev15kSlxhG8Lp69TKqesVb/03RdtRygb9UdyqPPGFvy+0i5
	 KYiqNVHXyhtW5X2hyKA/7fdqKiOSsIdOBPffPjaypKenMHHtrcONUuBf4VYpLWk/At
	 iXkUwlLoz5rWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE270380A964;
	Fri,  3 Jan 2025 12:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] IEP clock module bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173590563352.2193961.16212593963664558130.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 12:00:33 +0000
References: <20241223151550.237680-1-m-malladi@ti.com>
In-Reply-To: <20241223151550.237680-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: u.kleine-koenig@baylibre.com, robh@kernel.org,
 matthias.schiffer@ew.tq-group.com, jan.kiszka@siemens.com,
 dan.carpenter@linaro.org, javier.carrasco.cruz@gmail.com,
 diogo.ivo@siemens.com, jacob.e.keller@intel.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 23 Dec 2024 20:45:48 +0530 you wrote:
> Hi All,
> This series has some bug fixes for IEP module needed by PPS and
> timesync operations.
> 
> Patch 1/2 fixes firmware load sequence to run all the firmwares
> when either of the ethernet interfaces is up. Move all the code
> common for firmware bringup under common functions.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net: ti: icssg-prueth: Fix firmware load sequence.
    https://git.kernel.org/netdev/net/c/9facce84f406
  - [net,v5,2/2] net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init
    https://git.kernel.org/netdev/net/c/9b115361248d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



