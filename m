Return-Path: <netdev+bounces-236132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4BC38BD2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BCA4ECEDD
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF223183A;
	Thu,  6 Nov 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwSp6s/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743022DF99;
	Thu,  6 Nov 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393840; cv=none; b=lV9PxvbBkwyaZnIS8VOgrkK7o1UOU7tVd8aeSuLGemjO6WezCjzjrf45dUMwJCYWZ6ZkqZog4hwkdCp7jDuOzymEjqiPiDYltdanjP+6S/WNtY1qm7t8qSTtdOM+e7UF1MUNnN6lWVPsGOfUTtnNo0V9VTT21XRHkTBVSrdGguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393840; c=relaxed/simple;
	bh=+CpauvWxUAeAbBhY+KwbWJbUc6znqf2/3SzfMYIefwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lzPpU+wLWUWK6ZeqPfuvOvvnh+/0YVXbSyWDblGOQLJuGP+zFj7jb5jcIqYMQc0XpHoqzmLa9PGsQzXazqdRiMPGzhPvc2/YigC/cx36iK+qSxfNi2xLXUdv0vimgBUTCXH59DfZPOu3XhzVyyALcVWK7pcpXkjxij0pwEyVrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwSp6s/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6027C4CEF5;
	Thu,  6 Nov 2025 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393839;
	bh=+CpauvWxUAeAbBhY+KwbWJbUc6znqf2/3SzfMYIefwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EwSp6s/6wOxA1uHgV1DR6JWi96a4zq1ccibOac6TTlMwCaUz2igewx3Yil6dzZ3M5
	 kXpB2knPh29JsckxMa+XyoaaKD0EadM2l9WvuZ6Qro8Ru+/PNHjx57LwkxMI33Yl1g
	 q05HvVhSmthDtQ2I6ilNjNy+6P4C2Fz/8CNlX8gkOne7adLNDvQZjAoXrkedHgyk+r
	 6tiqvOD7CWS09VY4YxxWeN/uaq/ia7M+hK2NBs8I+ognqNbPGDY4187eOkS7fsCVJr
	 3v56ssQ94JTiE7olV8Q3RQLtu7hjsHyf73TpGkCNsGRwznzcGq9FtkorLD1SnB4Amb
	 /qRaLJB8dghJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAA380AAF5;
	Thu,  6 Nov 2025 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix fdb hash size
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239381274.3828781.8725039572661781707.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 01:50:12 +0000
References: <20251104104415.3110537-1-m-malladi@ti.com>
In-Reply-To: <20251104104415.3110537-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: h-mittal1@ti.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Nov 2025 16:14:15 +0530 you wrote:
> The ICSSG driver does the initial FDB configuration which
> includes setting the control registers. Other run time
> management like learning is managed by the PRU's. The default
> FDB hash size used by the firmware is 512 slots, which is
> currently missing in the current driver. Update the driver
> FDB config to include FDB hash size as well.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix fdb hash size configuration
    https://git.kernel.org/netdev/net/c/ae4789affd1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



