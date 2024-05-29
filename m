Return-Path: <netdev+bounces-98853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39F8D2B36
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531ED1F254DF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45415B121;
	Wed, 29 May 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyeTHUDI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A615B10D
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716951422; cv=none; b=GGMi7GPVtlzq7k3d+O8ddGMxVhK1/vjSu9aJoa6AeUT1StGo02mdMV2MINn1yO05sg2MObJE3JGcaIbUvDao193X5pOhnQdXbDrzoH1s5IM20dmOYXZ111bHCy6J7xwxpMS6+XCicUgSJqpb9lALXZ/ctwlSjC1Ug+XeofY0oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716951422; c=relaxed/simple;
	bh=t1eelw1p9q943XoXMxfHPRLqcXbAy73e090pBQ15hLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOqU+fUgETr9pXYCsTFEaLAuSFQP6BuWhkiKB/uWx338MupgjnxHKSrQ3vkAJl1ByImNpWmHUy+JxzG4Z6swQvAFowh0YdDcgbmrvU5YU5C1FFfSzJj5s6g0ZFYXzBJNjwYHd/5R/cwhdqH1y2w5EWG7VLmkS6gRjBS9wr7ot4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyeTHUDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91C1C4AF07;
	Wed, 29 May 2024 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716951421;
	bh=t1eelw1p9q943XoXMxfHPRLqcXbAy73e090pBQ15hLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GyeTHUDIB61Mbxi1lsxrD/OHwQs0cSwIMFlrqWb424gMiYCRiI2kDqI/xrhWyoXYV
	 bltFI89rj6KuwwxEGcxAk0w2zJxzSwHda+f/AIK5uNpYWbpHsSSm8KZdAkEhV/IiEi
	 FjS04xdIKUGv7gbTiuZfOX+/AhyUiTFEqJ1oB9fimSPc2+Ug1UrdoO6y+/SNeM1FgC
	 klLLkQ0qlylFVXy0MYPY2cfq9ZE7Fdzm1+AA9epV9OsQj14uYaFPyWjocCEywSU+Z1
	 sWLL/pGjPvYI/AXqJvBMwLN1NOOA/bNcPhmaYBGbpKqFehN9ahMUPc5ZdLVP8ddH1L
	 teEmukgtBHakA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD190CF21F2;
	Wed, 29 May 2024 02:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: disable interrupt source RxOverflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171695142190.13406.17918214341074928670.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 02:57:01 +0000
References: <9b2054b2-0548-4f48-bf91-b646572093b4@gmail.com>
In-Reply-To: <9b2054b2-0548-4f48-bf91-b646572093b4@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 May 2024 21:16:56 +0200 you wrote:
> Vendor driver calls this bit RxDescUnavail. All we do in the interrupt
> handler in this case is scheduling NAPI. If we should be out of
> RX descriptors, then NAPI is scheduled anyway. Therefore remove this
> interrupt source. Tested on RTL8168h.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: disable interrupt source RxOverflow
    https://git.kernel.org/netdev/net-next/c/6994520a3328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



