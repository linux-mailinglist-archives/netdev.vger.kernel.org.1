Return-Path: <netdev+bounces-177228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB6A6E5B0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148FF3A7E70
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE01A2C06;
	Mon, 24 Mar 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ4X+Nh8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056442A99
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851798; cv=none; b=CSF9ifghE4gzidUS01n6S4x4txCOWHCRK+tQO+Ubxg1Scb1XpusESfKig/5xVZvPltcQai4IEv7vzQXjw7ohYXVgaNVIpfu88U79bVOxo4KrgTzdsR/lbjobeh3lUjmBzlY/YNF4KgxUDYGkFDd+awN1Zy3YXuPf0PBEW0xSMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851798; c=relaxed/simple;
	bh=LXlco5Do5mkbcL/yXaxYecJ49w+mNbtVO8+Wj8Fa95M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=asDcHjHnHxP4cAO88KHSZJ9gK/L0nJ8OZvMl5eYM8nMYXGMaPyCR3b2Z4mVMccvabkfbexu8pNI/x7Ono8uTUS3c0pHSZ9UEW0t2BhSayk7mr7AlJyeHQ1iTDypr79nT+Flt7A8pazqnL4lOo3ODozJxmLgJc32wlr/KiClR8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ4X+Nh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3A9C4CEDD;
	Mon, 24 Mar 2025 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742851798;
	bh=LXlco5Do5mkbcL/yXaxYecJ49w+mNbtVO8+Wj8Fa95M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aZ4X+Nh8NkU8FKsYrt2eZRkMe57cRa1hGn0XlbMLdYuxNg3KpPxs1CPFERQxG8xZE
	 Ahh+cM/jAXgrlY5nYyjge3OlZXqY/Gv43zOMRcEpJmKIOuAQNoNBg1NeY20kHrGF3a
	 ZuBC/8nUwn6nhppnrIj5WpOF8iJrqaZpXN6/TkIOV7NBo0VBrEPhQvVGpfR4HRLVh1
	 qB2IdpaU5QKZKyOOeHKZ7KjjTBkOu0OcoYO4HYtqcEs2RS88YcxwMldVI8rRj0Qn3E
	 B9LhfivmRer+3LVZAN8cYpvRgM2pz3d+4ysndv8DkjdIcFcglUHtQRVI3p9a+6/vc1
	 gMvRwukF+9yaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712AD380664D;
	Mon, 24 Mar 2025 21:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bnxt_en: Fix MAX_SKB_FRAGS > 30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285183428.4184841.13047267317532416621.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 21:30:34 +0000
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
In-Reply-To: <20250321211639.3812992-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, osk@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 14:16:37 -0700 you wrote:
> The driver was written with the assumption that MAX_SKB_FRAGS could
> not exceed what the NIC can support.  About 2 years ago,
> CONFIG_MAX_SKB_FRAGS was added.  The value can exceed what the NIC
> can support and it may cause TX timeout.  These 2 patches will fix
> the issue.
> 
> Michael Chan (2):
>   bnxt_en: Mask the bd_cnt field in the TX BD properly
>   bnxt_en: Linearize TX SKB if the fragments exceed the max
> 
> [...]

Here is the summary with links:
  - [net,1/2] bnxt_en: Mask the bd_cnt field in the TX BD properly
    https://git.kernel.org/netdev/net/c/107b25db6112
  - [net,2/2] bnxt_en: Linearize TX SKB if the fragments exceed the max
    https://git.kernel.org/netdev/net/c/b91e82129400

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



