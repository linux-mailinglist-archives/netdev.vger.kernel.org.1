Return-Path: <netdev+bounces-173148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA127A57820
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCF16F0DA
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B231A7045;
	Sat,  8 Mar 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJgfF/y4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39F1A5BA5
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405815; cv=none; b=PFJ/Z2rlFxlAdPgLAO7h7F85zNuVL9oh+47CFR5YUUlQ3bBUebz3oHHdzbQ2aRnhSnNKBoOd/nYtRhh7igNDuWA0Z3vlvj8zBwbPklf3IxN/d+LjsjzZbyhcv3pD1dfGGO8jvvOCuUSerL6z+/f3OLe8CIYQeTNa/FLD8RlUURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405815; c=relaxed/simple;
	bh=xE2+uw+AFnhzDitml+gkUzF5Kgg8urCh96jFwvZzS3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6geBbjOi/iLCuR+tfFrc3HbySCgTXIVbUpj7FtW1C3PUJR+710dNEBFDGx2K9o76oWfmAtvbIpLz1J5IyT4WUdJ2emxhcaoMwc/8Al7LIgD4Z9FRasTbhPF0nrdqzFZ6/KurbfwsBFZj2TkNLHQxD3U0Z+ficxauah6X0DxJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJgfF/y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E8AC4CEE4;
	Sat,  8 Mar 2025 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405814;
	bh=xE2+uw+AFnhzDitml+gkUzF5Kgg8urCh96jFwvZzS3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GJgfF/y4H++uOdzzwERDongLhSjFxXO56cp08RSikXjLPfeG3K5RPszxW7xYu6lAO
	 V3B224iU+i7m/s+T5iAZDEum9ukR7Szf6qzBwhtxji5mR0ZcvTmsdbcC0YL8m6RaIM
	 tqTFLrVJqOAtec6WilbdDUCALzOeFJfPc4mG+G2mEc8Op4o1qLmBVA57/4d80mkLzj
	 JIO/AA+8hPdM4/nx7DFS+wpydRG235UoFvKCrpdjlXr7cH3aVZ9BoFcZoAAceCKTbh
	 Zl/K7LZm+nAqL33YyW/tjLvl/T+PLNXev7I6VK2K5SV74VFX1QpNJzu6iJfo6pqD9F
	 0vKcTWlKBCxyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F26380CFFB;
	Sat,  8 Mar 2025 03:50:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix dev->dsa_ptr check in
 airoha_get_dsa_tag()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140584799.2568613.1611630968507110835.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:47 +0000
References: <20250306-airoha-flowtable-fixes-v1-1-68d3c1296cdd@kernel.org>
In-Reply-To: <20250306-airoha-flowtable-fixes-v1-1-68d3c1296cdd@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Mar 2025 11:52:20 +0100 you wrote:
> Fix the following warning reported by Smatch static checker in
> airoha_get_dsa_tag routine:
> 
> drivers/net/ethernet/airoha/airoha_eth.c:1722 airoha_get_dsa_tag()
> warn: 'dp' isn't an ERR_PTR
> 
> dev->dsa_ptr can't be set to an error pointer, it can just be NULL.
> Remove this check since it is already performed in netdev_uses_dsa().
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix dev->dsa_ptr check in airoha_get_dsa_tag()
    https://git.kernel.org/netdev/net-next/c/e368d2a1e8b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



