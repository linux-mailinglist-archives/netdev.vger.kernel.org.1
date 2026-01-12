Return-Path: <netdev+bounces-249181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1209D15595
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91D75301B12E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2531AF09;
	Mon, 12 Jan 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neSLd5kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EF2F49FD;
	Mon, 12 Jan 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251625; cv=none; b=aOvMvyG39SzexwZ5Lc+bZzWwKFGnstULT3z84vspuAz858rl14nci3B1Ri/pocrdZvcuBinli13RuSwrCarmYnakLA87P0f/VOv1/e95ck+QtGaF6ygCsmrLsk3Fm8Z9/6LN3sKxZETnQhFg5cCmiHNSYAxTTxlmD9FkPZ2Lmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251625; c=relaxed/simple;
	bh=fxntyZDKwAr1NS/5LQRCWHoyFlbp632aDyhSQQ1Tr94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u+El2W8TEcFXEYQDzKbFaNGQoH3HboEj0cQY9rFIS6KXog7qr6v2c2bea6vgZNAKoeBToW72BAqNPtKSf6G1A4GHy1m6U2QgoKhJ8llx1pAk45cKSGkzg6fdfDy78Wh770rS0D6JXUeYWvgT/i9T+Z/CJDpaHy7JC6O0jfd8FMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neSLd5kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB95C116D0;
	Mon, 12 Jan 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251622;
	bh=fxntyZDKwAr1NS/5LQRCWHoyFlbp632aDyhSQQ1Tr94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=neSLd5khzODlZk22TLBWbY1iNDVuEdtRGc8RQZA8gMoE8EFtQQNSkVYiUVfS3q5EW
	 tSyoPBISumcU6vNwVSnY1ulTpMWZEW90bQU3OO7y2MaFq5slEgXVk+vGb50axln3FN
	 l3DGh85/epGRAiIMy/EA+uRz/spsGjXlDMsg/8Ek3lw9Sx2a2kMI2Xrf93Y06IScVk
	 du+b28bXyUUfhuasMyezyoW8/fdtwal/6mpZAo+qh0IHPg0vLhHQqUuSAoupGmIWkI
	 r8KZHPgYexvcaGrRmTkISFjhBG8m+vaxYRjby+KT4GGOtH95Rysd+Ph9nSI4zcJn66
	 rz7lYoYPUjxnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F37A5380CFD5;
	Mon, 12 Jan 2026 20:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-01-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825141653.1092878.14076029591226241236.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:56:56 +0000
References: <20260109211949.236218-1-luiz.dentz@gmail.com>
In-Reply-To: <20260109211949.236218-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 16:19:49 -0500 you wrote:
> The following changes since commit 872ac785e7680dac9ec7f8c5ccd4f667f49d6997:
> 
>   ipv4: ip_tunnel: spread netdev_lockdep_set_classes() (2026-01-08 18:02:35 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-01-09
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-01-09
    https://git.kernel.org/netdev/net/c/c8a49a2f9117

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



