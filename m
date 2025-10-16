Return-Path: <netdev+bounces-230242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E52BE5B81
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E5AD4F3B01
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5E2E7BAE;
	Thu, 16 Oct 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8aKYWoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868092E5B11;
	Thu, 16 Oct 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655035; cv=none; b=cI8fo1ZVBV/glSZuomlZqr+BC8x28YiKgC+Yh9LZeg2z5zzuGGJJCetPetIs8yMI20hqI/BGqLZ89il14tJ7IdDjkFUwawUGLQFSqSyVZGQ1kNIkvyu0ZYNajlkrSvwSb50XH4g12yx2P5qtiOm1N10UxfudX/cmxW69yTvX3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655035; c=relaxed/simple;
	bh=vP3gId2KhmEatsBRHSFXOI6Zu3QBC3IFITCWJbmO2IE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKjacDxxRzwCkFFcDITNxHfbnOA7SErRkXb+Wxc1YUz5xHciw/PPJHVkGRPyZsPczqozpmtj8nXmETvYekNL9ZHH5t1BNkhDR3YCh+oP4GoruzH6WIdmJDQtQL+bDfxjzIdjYzlLPDEDV7ZzeTkEaa6Ri69TrWgmyG76Re0G134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8aKYWoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFE0C4CEF1;
	Thu, 16 Oct 2025 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655035;
	bh=vP3gId2KhmEatsBRHSFXOI6Zu3QBC3IFITCWJbmO2IE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G8aKYWoq+Y/Pwtblr3++AsR+8V4P54Ckwch9/ongQoxaJg5h/2lU1q7jYOqBKtZ6n
	 9d5IE9u8BvIQEe9/ygFQKwvplACP+qt9uF3CXbT2Rn8WhHofbq0L6+12wMFlHty/qb
	 rWyS8XzXkBtm/OM1y8PLhK5Mjb+mJLcILk+0FIr3GFYmZfdrWrzcRQGSRA0ff8ssSj
	 A3l0YJ9s7tMLcI8IrA0ghXN+6m8DMGDlJa/U0zRXqktZ2buIj4H1Bxw7+MH9I1WS8q
	 zJlVRXTPuAcLgtbod87Dg6LSs5fjbYDOlmpHjqslUxLtVcIrSotiHMgqsuPZH7Jxr0
	 G57Z1hLw0AWBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02A39D0C23;
	Thu, 16 Oct 2025 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Octeontx2-af: Fix pci_alloc_irq_vectors() return value
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065501949.1934842.16850687793023920091.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:19 +0000
References: <20251015090117.1557870-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251015090117.1557870-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nmani@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, error27@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 02:01:17 -0700 you wrote:
> In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
> be negative and that check is sufficient.
> 
> 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
>         if (err < 0 || err != nvec) {
>         	...
> 	}
> 
> [...]

Here is the summary with links:
  - [v2] Octeontx2-af: Fix pci_alloc_irq_vectors() return value check
    https://git.kernel.org/netdev/net-next/c/e1048520750d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



