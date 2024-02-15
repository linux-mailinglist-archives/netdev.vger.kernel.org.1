Return-Path: <netdev+bounces-72020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE9856332
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8EE1C21C01
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E8812CD80;
	Thu, 15 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Fl+8D1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C973EA86
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000229; cv=none; b=erC0GiF5c+6DX1oxshOOBSX89DFTSSTBowB72adU7wvSDSfZ4wVqV6PisLmAOPo8kdJm+DM7o/nshS+gSP3XZHpgggODYRQUmcNp32ZJ2S6itotfmV2ESStjkOJPEhlYrWIvKOz70Ip5DqZ0r09Es4/ISkyMwklmoAn8nQ9k+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000229; c=relaxed/simple;
	bh=cAR0auQAm5///UiI+Gy8apskhhJ/ii9dDolbnJteFR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QlhmxXbC7S/DUGzQhkES3a8dd3Rd0O/Rw1h98vQT0dPuYR7uFgVryYVRWOc+MHvcNlUneW765H9jwp7yz4nTPGGBYBmEt1xiFXM8ZErDm6lJCWUmqZ4tNGl0MnRVbclgGAt7M6PRqEJbeClvBDx1AJeI0tBfvoS6kLnTIKfOMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Fl+8D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0DD4C43390;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000228;
	bh=cAR0auQAm5///UiI+Gy8apskhhJ/ii9dDolbnJteFR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h/Fl+8D11DgijIKTxyTC/VgBo9EVjL8YQXTIkDtUQWSGXL/b618f1rFvL3OMY00VB
	 HkhaFGsIkxIIY3221qmMxLhqvWNHbRw1lzTumgKYVSG7uTIpHS9Ndi+CLURtsyROWs
	 Am32/9bUKQufbpI1bHem8mJQDt/IismSWm4s+7kyELnF3YrYmRWV+sFXj2i0KNHGhA
	 pzd66jKza1u3JiFyECfaLeyL4NkE0XSdINNuFU3YkX+PAVgggeyxGPKBH181qtkKIG
	 pGPSOoLM3830D5w+RffIkVfzMY0xQK/0Qz9YklR95sKTjjD9bZnixy0ks5TnAP3y67
	 u+FfZPpfew/KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87656D8C97D;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: Remove unlikely() from IS_ERR() condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800022854.10978.8131872573482174754.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:30:28 +0000
References: <20240213161502.2297048-1-kheib@redhat.com>
In-Reply-To: <20240213161502.2297048-1-kheib@redhat.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 shayagr@amazon.com, darinzon@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 11:15:02 -0500 you wrote:
> IS_ERR() is already using unlikely internally.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ena: Remove unlikely() from IS_ERR() condition
    https://git.kernel.org/netdev/net-next/c/e8d8acad5a85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



