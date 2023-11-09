Return-Path: <netdev+bounces-46851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E07D7E6AD4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB92CB20BFC
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77853D269;
	Thu,  9 Nov 2023 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHWNvq3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF12111AA
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C21D4C433C9;
	Thu,  9 Nov 2023 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699534223;
	bh=6oNoztCM9tV3eNz+zHOrDNT36LFi8hLvYy/+bzdhopI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHWNvq3QQy1OjSbiv/dw+C3bXbEeOq7qh3X1MKIvc8FN0leMXu0nqfaQLM32YNVOK
	 8zJgVFsRu1pC/nIKLw5Mw1NJiuV9PR2bocupoFTysS2PbySymPeTzGGhFaZS4Afvv3
	 N4W6Sa2BzSpIgG7rx4wyZE0/Q4lIhl109xIqmW3MieP+91JHX8jIbSzR6r6cmJe56t
	 MQjdemT5fuV79RLDehRnoEFzI+OyHZe7t2JENDOXqaDHARY3scHCwQAk1rFPYR2dNs
	 i8CIqZy06bzMOolPAxA1QVus7uFJAHCec/mFycAdkKxf9ifBOK4hRG3MSzoABFs0LW
	 fICVcx9C4bubg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5902E00088;
	Thu,  9 Nov 2023 12:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icss-iep: fix setting counter value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169953422367.31532.8933774990957633696.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 12:50:23 +0000
References: <20231107120037.1513546-1-diogo.ivo@siemens.com>
In-Reply-To: <20231107120037.1513546-1-diogo.ivo@siemens.com>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, danishanwar@ti.com, vigneshr@ti.com,
 rogerq@ti.com, grygorii.strashko@ti.com, m-karicheri2@ti.com,
 jan.kiszka@siemens.com, netdev@vger.kernel.org, baocheng.su@siemens.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Nov 2023 12:00:36 +0000 you wrote:
> Currently icss_iep_set_counter() writes the upper 32-bits of the
> counter value to both the lower and upper counter registers, so
> fix this by writing the appropriate value to the lower register.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icss-iep: fix setting counter value
    https://git.kernel.org/netdev/net/c/83b9dda8afa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



