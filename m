Return-Path: <netdev+bounces-43168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BA7D1A09
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A3F28277D
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B867EA;
	Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxeK5Y0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6D657
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237EFC43391;
	Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697849425;
	bh=SwiIL60cYIwdT8Bj6HUQulAcBc0qTcFgAnVCGEwyHE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxeK5Y0q9299Rt6SDxxY3fYO5ntEqaEvhhvvUtauaSB4T+vGVWmCLH7zAmPeXIu8D
	 SYeV8jNbmWuj1iW/djy+/ikwi2dpEIpObgRrBV2Ue/hyQSMv0B9f8QseMx7EvYUQjg
	 UuPb56GGUFUV2NLA4T04ZkemIJwrA8G3q0fXao7H9sIFfv3Yc1+WwsdQrSwDaUCGzG
	 w7pMmq7yUhnxHOeg9SJ3hLfknup9+r62HjS5YkICIN7IRBjGty/BLbGAN05NhNRnMO
	 8Ug+iZrcXqAh+4TUq7rps9b83AeWBaLB8CscV9/BKzlytAtHrzBGbjxzRULmK4yGyK
	 n4/y3Vf98Kktw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CFBDC595D7;
	Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] pds_core: add an error code check in pdsc_dl_info_get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169784942504.14403.3244794654825339187.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 00:50:25 +0000
References: <20231019083351.1526484-1-suhui@nfschina.com>
In-Reply-To: <20231019083351.1526484-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 16:33:52 +0800 you wrote:
> check the value of 'ret' after call 'devlink_info_version_stored_put'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/amd/pds_core/devlink.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - pds_core: add an error code check in pdsc_dl_info_get
    https://git.kernel.org/netdev/net-next/c/a1e4c334cbc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



