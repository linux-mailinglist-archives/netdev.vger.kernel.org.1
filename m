Return-Path: <netdev+bounces-207828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E2B08AF4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22DEA6332B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082E29A326;
	Thu, 17 Jul 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDEY9rCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133F299AAE
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748787; cv=none; b=SlRTnzZlMzDk0glDKAga9THKIxeHw6DyO9EUckhl7D968qeM9wiw2p2OZVv6rW1t8VIfnOc/D1DPaWOiXwtjfaSm18SBfJFP7K12JyK917T95cCexX+kAFf/HrQXLputPiMlfa/s3eMRcVnuHpolab6/TTBTKQNguADfWUecZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748787; c=relaxed/simple;
	bh=IQXPPUQR8xmws6KRNjGxjV+d57bfAfnWOC4NCmmdJ8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WcuKpOb2DQOfJw22AuunsL5f4RGrtFKH4Gp4IDZg+TD4FhnA8jB4WbSLkB7h73tZsrDMnj1JV8iW6Cy9AoDKR1/of4dyzZf4ZBC/n+mXvpd2YeHv5qxZ8qYF8c609PUodhm6A2AfHaFYr89t0HzRQjA3QwxaXKwe09vIcbp1w9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDEY9rCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4715C4CEE3;
	Thu, 17 Jul 2025 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752748786;
	bh=IQXPPUQR8xmws6KRNjGxjV+d57bfAfnWOC4NCmmdJ8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDEY9rCet/1GiyZ/LZjU7vz0969irFh0hRJUmVCgFHIFFK8OgkOixM+YIHP4q+C/C
	 oBYcAJAhESMvjrQblLoZ3RQy2LX8apA0PfLhA5pZwiV3G0B6YA1kN/oPTlsNr9nOny
	 z2XKjYMxRB4GCxb7lFkzVSNHOMEeSxmpAqkL6x6Zwq4GK8KpkzKZzhJw6btqSQb4FF
	 Jy5JHjyMdsbyBnsGruAQ8XLqxD/prFFSsGOf0fVSRyjdeixRGFlKdG5zsh9TZ89ylA
	 YsU5OqGKsPUpwuN5zLrAhNz8/JxpPAyRqNIahc82/ZaYxEHYn1Hiy2WOJaZLenFbgV
	 ocN2ySgH6Ufeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBEAF383BF47;
	Thu, 17 Jul 2025 10:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: pcs: xpcs: Use devm_clk_get_optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175274880677.1884148.8057305071102263342.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 10:40:06 +0000
References: <20250715021956.3335631-1-jchng@maxlinear.com>
In-Reply-To: <20250715021956.3335631-1-jchng@maxlinear.com>
To: Jack Ping Chng <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, fancer.lancer@gmail.com,
 yzhu@maxlinear.com, sureshnagaraj@maxlinear.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Jul 2025 10:19:56 +0800 you wrote:
> Synopsys DesignWare XPCS CSR clock is optional,
> so it is better to use devm_clk_get_optional
> instead of devm_clk_get.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
> ---
> v2:
>   - indicate net-next in the subject line
> v1: https://lore.kernel.org/netdev/20250714022348.2147396-1-jchng@maxlinear.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: pcs: xpcs: Use devm_clk_get_optional
    https://git.kernel.org/netdev/net-next/c/8a2a6bb01664

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



