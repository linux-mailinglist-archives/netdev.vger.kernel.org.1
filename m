Return-Path: <netdev+bounces-137278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871719A5498
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483182829F2
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B2194123;
	Sun, 20 Oct 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNTDckWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062C19342B;
	Sun, 20 Oct 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435831; cv=none; b=In07Gd8G2f5icuuSQioJxwp8yXtpmkq2VfRWF4v/Wv1ujqmN8iRCFUondeFdb4y24snDCtnVKauVsZfmIYuJL8K/MLTuX6SPuN0Bt3JlAqMJxd1bRQPQGuLI+VwaESTm38EceY29mx4ZgcQ0SyZiZN0voGIe9j1gbU2rrdrC/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435831; c=relaxed/simple;
	bh=Y8Slu9wrylwB33Nz7+0pf64zgrLIw+qrVV6xYJbcOo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eJgDSrsjFxUgB0pd9ZWfrh8BHSL2Oj3OmxjAnYG1REHhgrX0q5jffMUzl8ubQm9pmxqQFK3SkzPMQpH50y3QEd+JYLRd/a0gBkYFLc1gazqmcRsIEKR4ibkZCaA9a5MxoGxFJLKte09zQBDKOK8ZwNN+IYH7fjaDn8Ap+THkIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNTDckWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A1C4CEC7;
	Sun, 20 Oct 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435830;
	bh=Y8Slu9wrylwB33Nz7+0pf64zgrLIw+qrVV6xYJbcOo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PNTDckWX487PmCr9KNKFaaDVKuvqMwRmn3EuQy/pDAvIIMTWIovkSyPJ2i1vbVnPT
	 5wWeAihsByZUtvfr0USc2bPuA51mJc/mue+JONcyeTUR1+4Y8XwEfv2YlGZMRuNkRM
	 gxRWQmqdZjC3VsTHF9iNXAKc1GVUTHS+FsUTHHlvqfmrXn2pveDzTm9gu8Da+bCsGY
	 SP7EZh8fedH56bcDit1yn8EVIvxoobd7UwNWnsBRPkWMiCiU9P+oYUq1rlxOUw+x/F
	 H0bNf+RbqQv65PU7yUWjVFhgk3ijtDMw1W9SFKyMzB8pksc/k7GpeFghHte4yFjHMZ
	 DCz9l6PFe9dCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1123805CC0;
	Sun, 20 Oct 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943583625.3593495.15746793954676692659.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:36 +0000
References: <20241018005301.10052-1-liuhangbin@gmail.com>
In-Reply-To: <20241018005301.10052-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, haokexin@gmail.com,
 Ilia.Gavrilov@infotecs.ru, linux-kernel@vger.kernel.org, atenart@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Fri, 18 Oct 2024 00:53:01 +0000 you wrote:
> samples/pktgen is missing in the MAINTAINERS file.
> 
> Suggested-by: Antoine Tenart <atenart@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: fix alphabetical order, make patch target to net (Simon Horman)
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]
    https://git.kernel.org/netdev/net/c/3b05b9c36ddd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



