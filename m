Return-Path: <netdev+bounces-200078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D7AE30F5
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 19:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD499167B2E
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244CF78F34;
	Sun, 22 Jun 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4vcBrof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694610F9;
	Sun, 22 Jun 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612779; cv=none; b=CYEDhKZhXRb5MjspjQgMVeb29r7CV4RYWmjXUmswb4sLqCYIoHrk8IfrRcsg7S+ZHqEn5LkDi4mMqx1L6qbfhPR+j/GvKtbQfAch/Tlftw9HxzhteViqPoD8kCsz5tzx1pvwrGtXxmGWV4KboXfYo8gZdH5Et0IwfUbBfvnCeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612779; c=relaxed/simple;
	bh=DhUBToUiO8IYn3QsRRMe4296nqZat204Vprnj3Dn1GY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RlxSubWNuyOLPWwVyxtCcZopbHGZVUD/QdqersoxmLVsLYm+zzwfzplOgWvDjVdStoa5Zc8wODorDhBjwaa4oHg6Ln7Eqp84yIOWbXsx8WYCyRsGg0jIGjxLI+3+nGMJvmpI40oS6ofR7eSNEBCMMYFuRTZ1wxQal2RgCLGyU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4vcBrof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63843C4CEE3;
	Sun, 22 Jun 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750612778;
	bh=DhUBToUiO8IYn3QsRRMe4296nqZat204Vprnj3Dn1GY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4vcBrofQZGf7RLusNy5mj+Q1tjEFNcadxA8/1lDcKMyaq53v04XeifuoZAXFfvfl
	 DtL20kIU/h8n7v5x44p6BJ7RhoL6Hzm/K5Hl2m1TMCm6ITjf55a2aA/IedSCDmL6+p
	 fnZ55TXcU/DvWl1+YvJkj3q1+W69jjbNTBsTBEpDB8F43JA75R5YeEIQq4IMkx9hqg
	 kASHT6tePBzB+EeR9M7mcTTyOGemkf9WyEPrqqX9JNZ+aO0fzvQp+D638pKnyLYVg4
	 O4mihMbgQmHO35DTY3C4iXxp/gvtRjNjv9OiG5iEYwVSH9qsygCiapn4EpralQ1Ooh
	 r/+MrlL1eudNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCA39FEB77;
	Sun, 22 Jun 2025 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Fix typo in marvell octeontx2 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175061280575.2107856.15260195031590480396.git-patchwork-notify@kernel.org>
Date: Sun, 22 Jun 2025 17:20:05 +0000
References: <20250621103204.168461-1-faisalbukhari523@gmail.com>
In-Reply-To: <20250621103204.168461-1-faisalbukhari523@gmail.com>
To: Faisal Bukhari <faisalbukhari523@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Jun 2025 16:02:04 +0530 you wrote:
> Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
> Fixes a spelling mistake: "funcionality" → "functionality".
> 
> Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
> ---
>  .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Fix typo in marvell octeontx2 documentation
    https://git.kernel.org/netdev/net/c/302251f1fdfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



