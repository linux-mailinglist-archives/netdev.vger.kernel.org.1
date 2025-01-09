Return-Path: <netdev+bounces-156796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2456A07D86
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49201168EED
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC9222581;
	Thu,  9 Jan 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfCvIXUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C94221DAC;
	Thu,  9 Jan 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440211; cv=none; b=NuQnTfYS3XnRpZ/R2MM4cRqh+QqiieFxTgX2BLLE37DlirP+8R71oZTMFMjOEXwDvq1goFT106yoFwlv/YfV3o+Je5B1Em+IVSvMgOsgdixUiZgX2W9kAtjUBosYX2Ih9S/jJAGkdbYMvL2dwmeb1+tknLVKlw0kkUQgJN+/nyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440211; c=relaxed/simple;
	bh=gHF+7YwDRvaNDvBQ3VXI8jniokAaH7IwBcED0IjxZ0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lILxqT2JINOTHl9pKkX/2Bg3Kvzy7dhsEdS+ku51u4vTB+PHJM5LuWPgt5XanGoi+4EV/w6bwHldgSxv0M0y9+OuKYbUj8zhWJatXwuHpsjhEwlBAUo9rosm0AYNRvzR9AZAVnGB7Ff0k+Imij6I4ZMowC6qYADQAEsC/T04Eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfCvIXUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7787C4CED3;
	Thu,  9 Jan 2025 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440210;
	bh=gHF+7YwDRvaNDvBQ3VXI8jniokAaH7IwBcED0IjxZ0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfCvIXUxY7mFkeosk8aaRgpG6jXAnko28s6FPuUmY3jCt4P3kugljqIsPMSXxr+sf
	 WwDnrwyKcxf2g318nIqjMODmzfJY5WGgX6IJmsbsIhBl7OIsmLA6RaUfwdmvYhltGc
	 5DgYJT+UW+uQsODCmcxlu1njr4AM2sI094qapDIs7nlN74Mnkf2N4VqFvzxlfyLmKt
	 LdGri95vkbppNgqXK8F/lCZZiWLKqo5XMHmLAluzAuzw0PkjNVf3pcYgbKcdZnDevr
	 dkXFf885u2/yDYfNA9jAerqND8NOqYjKS6zO/VK8vHTasaAqiwvovw2hsNE2vuVQH0
	 kYUqbvV712yJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1193805DB2;
	Thu,  9 Jan 2025 16:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtase: Fix a check for error in rtase_alloc_msix()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644023241.1439025.16473910539664572898.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:30:32 +0000
References: <f2ecc88d-af13-4651-9820-7cc665230019@stanley.mountain>
In-Reply-To: <f2ecc88d-af13-4651-9820-7cc665230019@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: justinlai0215@realtek.com, larry.chiu@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 Jan 2025 12:15:53 +0300 you wrote:
> The pci_irq_vector() function never returns zero.  It returns negative
> error codes or a positive non-zero IRQ number.  Fix the error checking to
> test for negatives.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] rtase: Fix a check for error in rtase_alloc_msix()
    https://git.kernel.org/netdev/net/c/2055272e3ae0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



