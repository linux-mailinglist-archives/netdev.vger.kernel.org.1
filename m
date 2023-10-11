Return-Path: <netdev+bounces-39794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0F7C47F6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C6281D2A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A04F6106;
	Wed, 11 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOxp8I9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1535504
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FFDEC433C7;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696992625;
	bh=w9gu+nb5Tz52hnmU6Kk7Z7DuZ/JVvqc2nRkEOjPHfu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eOxp8I9VrHM/hedI5giFGh94WPs1aqQg9Gcn9aINebbCqzTrZUTZXb4WOtYcvxIGX
	 tbCPpyhYcPlhlyYb1k3zE53y8tiwbsCPAUSLtsj/03w+ELylCWlUQNxJhYBtcwYfiN
	 JO6oeJetGiA6LcQqKaDmxsimO8UeUZxycRkBMPeXnuuADvc+1HgrM2zd2GmFnyC8Mo
	 FBUBR7BONEBD6Pf+X1Z3p8gKabgIX2CQU27qBaklzSNa+RT/CgNvAPQJqSRoSP9IgH
	 LUf2SQsVCjnJ0uLzD4F0YG0z8tiwtxvN70SM8XEtJ1SFSdFYmT4zNIFH06aKXiKTNH
	 nL36NtS7YNuTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A0D0C595C5;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: skbuff: fix kernel-doc typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699262543.24203.5794008894779033273.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 02:50:25 +0000
References: <20231008214121.25940-1-rdunlap@infradead.org>
In-Reply-To: <20231008214121.25940-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Oct 2023 14:41:21 -0700 you wrote:
> Correct punctuation and drop an extraneous word.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] net: skbuff: fix kernel-doc typos
    https://git.kernel.org/netdev/net/c/8527ca7735ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



