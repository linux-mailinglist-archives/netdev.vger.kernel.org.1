Return-Path: <netdev+bounces-127174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D127974769
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB202817D8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9C125DB;
	Wed, 11 Sep 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upZpSiaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670D1EB46;
	Wed, 11 Sep 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014669; cv=none; b=sKMPcB714JMd/9oiVbys0MOGam0AD2uqc7Al2a6e40xsmg75jWotFZaqFqvAiNdLqJcFmgUZL0gOkQ1izDh0IUFEcjDcPcjo5CKLARRepYEE0RHuq3avDnikm9i9khZjmpgGCEsh1ypT4VIy1ff8fZXvRb5hjrRcNa/zZ5kXKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014669; c=relaxed/simple;
	bh=Z8Y1o4USv4zU13o7Hk4ZltRPpoaxe1EAHR2t4Z2JbWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Euc/vlkbX2TLkKyreUSqkdeY89X01VqkOv14p6I74zqXqn7MJNSqYvh9ZhnNXlWylS2lku4gpSpLa2K3RkMp51dOIhrqU39/n/gV9kA5WltEd9VNun0VfKU4M0FQnmDXLzyqqy6Q2X5Yewtzc2sQ4yCUvx7hzxBpELijxDP0SrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upZpSiaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA700C4CEC3;
	Wed, 11 Sep 2024 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014669;
	bh=Z8Y1o4USv4zU13o7Hk4ZltRPpoaxe1EAHR2t4Z2JbWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=upZpSiaFs6zRP/GuKngaDysGKRE1qIazioYelEJHDOHQz6fU2BHM/iLo0eK3NQ6+V
	 PVmQM3D+fX77ARHPhuCdPdgQufd+jTngOkgF74sSFM8D/9DnBJ+1NkbD+hzYhgUasf
	 lZmm2MSX0b4FIlJgztRYYMqwODIyzflwhbOLLU/gZ+20TvSU2evmesWXc7f2aIw0/4
	 sFBpZMVDi1TbEU9JViuC9J753ubo917g5zziETH6R/1yxV6R5h5AyiORfPokkNmB3l
	 zWIjZpffnFt/Y6WBxTL8hdZ96ziSiIiQB35yJ5MzdZ25BxjjLOjVZJRpHvzv98QgLz
	 jLfwpHCD045vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A573822FA4;
	Wed, 11 Sep 2024 00:31:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: dsa: microchip: update tag_ksz masks for
 KSZ9477 family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601466999.440312.11137610546994338908.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 00:31:09 +0000
References: <20240909134301.75448-1-vtpieter@gmail.com>
In-Reply-To: <20240909134301.75448-1-vtpieter@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pieter.van.trappen@cern.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 15:42:59 +0200 you wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Remove magic number 7 by introducing a GENMASK macro instead.
> Remove magic number 0x80 by using the BIT macro instead.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
    https://git.kernel.org/netdev/net-next/c/3f464b193d40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



