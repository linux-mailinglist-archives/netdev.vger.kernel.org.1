Return-Path: <netdev+bounces-203548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F8AF65A7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C13C3A7C68
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5BA2652B6;
	Wed,  2 Jul 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW3KD/H/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB42260575;
	Wed,  2 Jul 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496604; cv=none; b=rlh5ZzhesVvsLPglOHNb46E67JaIApmFYFym6JnDK2GULJUBpEuhG04Cn4Hh2af5twzK9KexwRaXt+hYkkxJPJujvBHBNhULAGwocxNi1E6PfTrVTMtrFMt284KgDHcGTejv3iTqZn3AxFD+8N5cuTqGuBuhYh1SP+Rnq5pMvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496604; c=relaxed/simple;
	bh=Wycl/TIHNL8gwnmGyoRRgjyRHlwQWQEqNA5Db38y2VU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0DF6/fpjqwOVftiLFaq7xTbMnDMf0rCTTJnCMVh3sj9VrhDmyprDlLndEWkSqOK25O6lqT8+onAPDR6O1mbvAPD125pTYQgepr4Nd3apOZZDxmwn5JW8E5ePM1h0m82R+k1IYgzMGfkDY2dEgBC1OJoqCx5Bs+yYYIpRvG8TKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW3KD/H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B581C4CEF3;
	Wed,  2 Jul 2025 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751496604;
	bh=Wycl/TIHNL8gwnmGyoRRgjyRHlwQWQEqNA5Db38y2VU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AW3KD/H/a7I0wzEGre23ZmtdgiA+poJQ92pc0ROvjV3+BbBti9kNumA5mBhjOv8JZ
	 oUTBgi8V3Vd53Eki07GBndgLfhvo1uWqcy81v601tuIlQ8piSBkFP6Y2M3yOmnEx2e
	 pJy3zPY1m+WeFEjbHIYFBmciwD8pKUV6Ag+e+twDvTisQJ/lKxGq8hHxY5hF+q4Qna
	 LZ4omZMEYH7lV7sfM1pPIPychSbBB9JddNXMUjIBEKvcCBJ4Z6oH3/s33BG/lJuYuV
	 X/tJR2GSPBmmQyVjRjSn9tD9c0H4FmOKCYDLvuReBUIcQBiZkGSISRTmKVnedmXTm/
	 uw7V74CvqqX+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADA6383B274;
	Wed,  2 Jul 2025 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: Fix spelling mistake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149662850.890932.9219557571562861851.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:50:28 +0000
References: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: paul@paul-moore.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 13:58:20 +0800 you wrote:
> change 'Maximium' to 'Maximum'
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/ipv6/calipso.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - net: ipv6: Fix spelling mistake
    https://git.kernel.org/netdev/net-next/c/8b98f34ce1d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



