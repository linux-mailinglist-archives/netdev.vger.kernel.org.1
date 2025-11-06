Return-Path: <netdev+bounces-236143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A392FC38D20
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4227234FE91
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0DA24DCF7;
	Thu,  6 Nov 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSGsMUfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECA23183A;
	Thu,  6 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395043; cv=none; b=ArEAaQBvxbLxR7OT656UwZBJ/5aXN98f8Yh8pUr+2c0I+4VHuyYM3jtybhSmayWXFPOHN1a4/QVGbUVungwR9TC8gbfWvcvRXgFYHUSoVL6j0OSiyceAeSnrn55irscS4XqNNGIywwTZvI+Gs40DLQVQ7VAkkjSzfe9EHPzngbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395043; c=relaxed/simple;
	bh=Z3XhN86ER0M7XyvLgbCxXeczLMzJ/uvJdfxjwDPihyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NXvjJPGbtuNsKWmIgWNP3RPRQuNKtP0GvMpKwqsohdxYMnv8juPxMdX6g/QRL5JjYcaTLStT/vKyecAOB4ZxWILLMqqfS56MLcWX09eMjVrnf5cYxsRlEb5mdIxBGeL+GQu7zSV0QNCRPmOTWG3QUSNCPJJ1jJlD0ULUKp728vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSGsMUfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C5C4CEF5;
	Thu,  6 Nov 2025 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395042;
	bh=Z3XhN86ER0M7XyvLgbCxXeczLMzJ/uvJdfxjwDPihyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NSGsMUfU1SYUX5ZfUgsZ6FqZIiq89C5j0U48TSalVgrcqf53gUY5kc6mzkMaaaEm0
	 07ehPsqql0j8hgVcXzAJumuMBR3t+z/ax6f0TUSe3l/qf+20OwUukz6uFShCxfLGDq
	 v2N39ystXmBD7loLHpRc4IVJ2hhPnWrmAJKSEZ/v+nhSubtImaSnj0LK3yCTvs6Sn+
	 xYrxKX8AaYt+UftkTSoTbxiG4t2JJbBQ5rnNRIF+YAJPRfT2JFISVt4/xFvQjm7eNI
	 WhvSF4Zau3dn42tv0uB05B1IQ5g1+wDCBBsZNOnaR9eaKAvhMOBj5gTAu6bTI8Y/VR
	 Z5GLnZZTePulg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8B380AAF5;
	Thu,  6 Nov 2025 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: Fix a link check in
 ksz9477_pcs_read()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239501549.3834029.5601067498463856029.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:10:15 +0000
References: <aQSz_euUg0Ja8ZaH@stanley.mountain>
In-Reply-To: <aQSz_euUg0Ja8ZaH@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: tristram.ha@microchip.com, harshit.m.mogalapalli@oracle.com,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 16:05:01 +0300 you wrote:
> The BMSR_LSTATUS define is 0x4 but the "p->phydev.link" variable
> is a 1 bit bitfield in a u32.  Since 4 doesn't fit in 0-1 range
> it means that ".link" is always set to false.  Add a !! to fix
> this.
> 
> Fixes: e8c35bfce4c1 ("net: dsa: microchip: Add SGMII port support to KSZ9477 switch")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: Fix a link check in ksz9477_pcs_read()
    https://git.kernel.org/netdev/net-next/c/c79a02252457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



