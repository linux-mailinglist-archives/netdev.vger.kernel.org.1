Return-Path: <netdev+bounces-197018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13620AD7605
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A4716A4C6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79329C343;
	Thu, 12 Jun 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYvpXpl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE129B8EA;
	Thu, 12 Jun 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741618; cv=none; b=qiQWphfs4aSYAvlC7TT8bYa2lmAYnDQarknf7nLQmo8IaMQgNNlCTbtfOt0b6lDa1Hcbr8uuS1H9oCEeFeWpG8nZ87yBgaYWJZ8g0SI4Db91/k3e41gzD5NBnB5si9e0qRMvrSyoH8PAiSLJhCD6miAxeTJXkKrNj7TnyGr/0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741618; c=relaxed/simple;
	bh=evw1ArLli+25obPWgrG5Cb7YcWqwAf7ZdQ2ZBuQN5Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Woe51lt0Ll/YHBCV0M54H4VGWUaJ1MV3plV2vCPbre4S6g3xwjIO8EjXaFxISNNzSeG7SQQDpZlqPNn5ZLAPF3Q/Asg3oL69bXl1yHPu9AflPDhHGgTmMjgrSYPkAhS9xXDwE/3AbQocNta8IpG2Zc7ZTob1P7DrwgASKLVeA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYvpXpl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188BBC4CEF4;
	Thu, 12 Jun 2025 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741617;
	bh=evw1ArLli+25obPWgrG5Cb7YcWqwAf7ZdQ2ZBuQN5Qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZYvpXpl0igDw7PPZP3gDFuCoCJachgfrNoihnfEwrX0p07CewVhdV6wHG7j5KQXuk
	 TLlxo6F5i1iq/U05xsV4U6H2My7f0P80/4SQw3PS4Din5qLHqI0hCzGKhILTgV5FoT
	 Af8g570/qgRILBWBkvHAw+xrvrHJF7PojvRUsmvyswZkeRXR2aGXSw1pXbgQgWUDBM
	 ozKZuJKr9Bvv7+jKCX9mQIMzFBDGsY82O0+EKqiNqzsTcuBrJGRX15g0LZSPV7xNk3
	 rURpvYE9uviKDmC5jvrRg3jSdMOayLw42dH5xOd5WPrmfYcCkDIrqD8TQrYPuBOtNJ
	 AAQpCSOUztp2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4C39EFFCF;
	Thu, 12 Jun 2025 15:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-06-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974164700.4177214.8234479173667456165.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:47 +0000
References: <20250611204944.1559356-1-luiz.dentz@gmail.com>
In-Reply-To: <20250611204944.1559356-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 16:49:44 -0400 you wrote:
> The following changes since commit 260388f79e94fb3026c419a208ece8358bb7b555:
> 
>   net/mdiobus: Fix potential out-of-bounds clause 45 read/write access (2025-06-11 12:49:03 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-11
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-06-11
    https://git.kernel.org/netdev/net/c/d5441acae780

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



