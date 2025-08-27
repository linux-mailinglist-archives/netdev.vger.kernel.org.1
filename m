Return-Path: <netdev+bounces-217114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C87B37661
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759583AFD3B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB41E7C2D;
	Wed, 27 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3sOgdvg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207661E1C02
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256409; cv=none; b=B0owfxZtVPgFTDZzkc7ybCZj67OdXcTtulZmItnly7bvoitHq7dD/T1he16/ZYKslIyH+lBPM9/eQr3ttj61MZq/9BExiVyE5nsZVFkRhg1dSh4O1rxPfGJJDWr+XfV7bKXC42Ph4simqB3QQqwVo7KLKXcnI2qcvYEnzHsU/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256409; c=relaxed/simple;
	bh=XfN84snU1gJ6AHS+8pEr2gWBXJb+ZAaq+4C9kwz0hTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYY0q1A9Q67dGeVboQPgSa+ErngKIVgbA00T8C5irpQLg+GtNoRtjrJS0Qs3I6WdtHB7+3ZwVv7lol98cZkQ/apzDvQr3r6FF15L+vOo7TGOceQ+vcW5ClabobC+PDpSm7VvPeWd6FHWx5G+hKTNRvpjjP37MoumQ4oZmwjE5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3sOgdvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0377C4CEF1;
	Wed, 27 Aug 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756256408;
	bh=XfN84snU1gJ6AHS+8pEr2gWBXJb+ZAaq+4C9kwz0hTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3sOgdvgpZFFFDS1+1Nk1VHrbgJKGEBEhHjDltOCNb71RevT2ZHb4mOtiVHOHmBem
	 PKIeYOuarnT4GxC3TYl7c4ScEKFDwT60CB7Fv2ACSSOJWlmG/kgitaXxB6diFLdck+
	 r5lIVgIhJJhPmwKirWBvI01dHQP+9wUeBYuHEZqhq22FTknzZXpgA1vmoQFCZkJXJN
	 Sz4M9LNt+OzoFsHMQPoHfV4YT5DMA1cfPrZ57E93ogc+qPKgVWh4ffq5XbolH7wUCX
	 eVdTU7XkAiE+EIghjLqfN24M3tHyTfOhJwyxJ055eAJMkhfi0t7G38pHKoVkCBVZv6
	 c1Ral94+7GlrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AA109383BF70;
	Wed, 27 Aug 2025 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: 3 bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625641651.155051.10153195354009259219.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:00:16 +0000
References: <20250825175927.459987-1-michael.chan@broadcom.com>
In-Reply-To: <20250825175927.459987-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 10:59:24 -0700 you wrote:
> The first one fixes a memory corruption issue that can happen when
> FW resources change during ifdown with TCs created.  The next two
> fix FW resource reservation logic for TX rings and stats context.
> 
> Michael Chan (2):
>   bnxt_en: Adjust TX rings if reservation is less than requested
>   bnxt_en: Fix stats context reservation logic
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Fix memory corruption when FW resources change during ifdown
    https://git.kernel.org/netdev/net/c/2747328ba271
  - [net,2/3] bnxt_en: Adjust TX rings if reservation is less than requested
    https://git.kernel.org/netdev/net/c/1ee581c24dfd
  - [net,3/3] bnxt_en: Fix stats context reservation logic
    https://git.kernel.org/netdev/net/c/b4fc8faacfea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



