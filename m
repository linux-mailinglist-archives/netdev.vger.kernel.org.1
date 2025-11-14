Return-Path: <netdev+bounces-238548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDAC5AEB2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B13B65A5
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0125A320;
	Fri, 14 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJNoGZP1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C42586C2;
	Fri, 14 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083840; cv=none; b=TMSWL9uKCmfw017agInOvu9ZJtLoWxjmcgPE/fLY83zUjUQYKr1Zr+NRNwpfYVJupx5Bmya0fEya/meLhrlYIslfvkDfyxT5if6ndiWz2wC8H0k9/EaSDo8vTIjJy6sPOrP7sgInokALyVS9pDbI33hNJSXVg6O9pNqiIIRk/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083840; c=relaxed/simple;
	bh=Iz2ugW1IijwbS9Vwn5esUnBaOZ5JmLusWKOLvlIqIvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BMiBPrGNWcN1MqFpkoqo0SoQAyiM6K4rbWMwv8LLlRrz7Q/xNBsOwUUGGE0X+sUQejnQo5CPRJbCKGhboUe90Ig0RPUxYW3mJETRlxFsyrHHocOO3Mk7XX2SUHLdfWLNnDJDfwPEAZCeQLr8TBYhjdXjBYy2Bl228ZxYVFCIp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJNoGZP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA07C19423;
	Fri, 14 Nov 2025 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083840;
	bh=Iz2ugW1IijwbS9Vwn5esUnBaOZ5JmLusWKOLvlIqIvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VJNoGZP1SEoY59JrNyRqW7SYDUysk92pE4JS58sat8OlG0k362gscVIZmDrwdoWEb
	 ZJkcLNmGhNge9LmoSmGW6CT5PCIzSZcuKONJ+Z6xRSB6d78ELm+M0Jk2/WgkWBnwpC
	 T4TM+teEAKZ7mMNesIqAmpBOeXTi6kvfybYhScTreoo7sKo/XIhsdrLM/OfWEsA5ZQ
	 A6DBF8yDUF3Y82+pagZqq7bxU5tNIAdwrz+VQWalGYxw+Pfvel23FvTTSh/wTySnAw
	 qKA2+1NYyVRyrUj4vTybJ12eGlIZ6BNlBgJR0sTQ3E4R0XskUrp1PBCnmNF86UXxa8
	 MtUNt8+jQLPEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5E3A55F84;
	Fri, 14 Nov 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: act_ife: convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308380874.1076537.997274703292244288.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:30:08 +0000
References: <20251112072709.73755-1-nichen@iscas.ac.cn>
In-Reply-To: <20251112072709.73755-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 15:27:09 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - net/sched: act_ife: convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/205305c028ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



