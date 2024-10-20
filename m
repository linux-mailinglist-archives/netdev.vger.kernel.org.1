Return-Path: <netdev+bounces-137287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B69A54A8
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE4282A15
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9E198A22;
	Sun, 20 Oct 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eImLbvUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B1198A10
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435842; cv=none; b=sEIg3EIqsGJPmirtdRtrx5AzJoCXVNRGO/OTAVEgsPva5T7XpnHPZ9tkGdnxWll9pyl9/R7krNPUhyM82jKeNULesfDxrePZ9AGOZtMnZKY1Cti6KNdmKXBwy/k+xCaXyOqeviznQGjDI53usdBq2AgLDn1tm7ZeQuc8Qcyqz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435842; c=relaxed/simple;
	bh=mD9G/5aoaxeT58ACTgYo7CoTZO/1fgNpzJmg5zrgz4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QrMuZrv2dT14VETpp6t6L45D8eB0O/kEcmjIaA2Dur+Qri0G0M2SD9ERoq4GL0KCvASmgzdxFIhTACUEq2KOJJyRvelU5itX0Px1OkqaA9/GYHow6kq3AVXv5u7Xjbni/joCZbxGGHYifheQRQ07oRgdh1VeAc/LdRuvDEnqhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eImLbvUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A27C4CEC7;
	Sun, 20 Oct 2024 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435841;
	bh=mD9G/5aoaxeT58ACTgYo7CoTZO/1fgNpzJmg5zrgz4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eImLbvUo1B4ItnS5StmivF/FjmSIebCZNRWKo5BeLtCgR4hLj33klz+l7UDvzuCrQ
	 Hpp+ULSVwNJ0ID6+VJTUzq1nzRT2tISzvBBd1Y88xK2Sl27rzOpc/516CvnzrhSGw9
	 zYL/9apd2yZImfzDWq4DtN/TmgK+FiE4h/CZghgVfRRwY0JQP3Ju1QhXkel8xkZWqx
	 QFg0r/xcfHRAQqjDqr2bn4dK6ApLJnRogD2AdXgBXtl3yctqwu+/5dcV3J8D8gCQlz
	 QYfQMzQt9mjpfH89+fJ1UDQDqyWJTl0RQwjdKwEMdgtSTXNoLOlILVoKM5U1edZVu5
	 n2KopCLYKclZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC43805CC0;
	Sun, 20 Oct 2024 14:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: replace ptp_lock with irqsave variant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584749.3593495.10567241785577650329.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:47 +0000
References: <20241016195234.2622004-1-vadfed@meta.com>
In-Reply-To: <20241016195234.2622004-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: michael.chan@broadcom.com, edwin.peer@broadcom.com,
 pavan.chebbi@broadcom.com, kuba@kernel.org, vadim.fedorenko@linux.dev,
 andrew+netdev@lunn.ch, pabeni@redhat.com, netdev@vger.kernel.org,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 12:52:34 -0700 you wrote:
> In netpoll configuration the completion processing can happen in hard
> irq context which will break with spin_lock_bh() for fullfilling RX
> timestamp in case of all packets timestamping. Replace it with
> spin_lock_irqsave() variant.
> 
> Fixes: 7f5515d19cd7 ("bnxt_en: Get the RX packet timestamp")
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: replace ptp_lock with irqsave variant
    https://git.kernel.org/netdev/net/c/4ab3e4983bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



