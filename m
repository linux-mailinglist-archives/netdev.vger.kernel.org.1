Return-Path: <netdev+bounces-61496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0AD82407D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5685A285950
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDF2111F;
	Thu,  4 Jan 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBWM8nQS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C52111B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E44C43391;
	Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704367225;
	bh=NrTnb+Kl9gL8+CW3QIzaYLHbASt6hq1ca+vPiB3otKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBWM8nQS5spb70WQWpyejzEj/QsI6tifCzEZd+wPD8A+lg8T7gR5PdU7dNSjWhmk3
	 gXyIw3Gb2m6BUCANLGysy+xyvqtRmzVl21UhixjwwiaWWvOtJTd43ScnCNpsgz3Gq1
	 fsxXdaKkk8UixltKoNW6ePZO5xW23TwUz4VRiFQ+yD+sZx7HbmiIo2cYbLVzABEGcy
	 7vTv4C/BQbaQHyhFkKAY+N8h3Zd4codf7ZJp/a915kQTtQgId4ob/TL/frdlQXgga8
	 RNy4tl+8mKr5RfAI3PUMAyILsp+JNXte5gqU+Y867fviZjmq/JI1JbWGm0/ARRnhVk
	 D2PJv0aQeHpvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 448D1DCB6CD;
	Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Fix compile error without CONFIG_RFS_ACCEL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436722527.25413.14427761462157073464.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:20:25 +0000
References: <20240104010108.41100-1-michael.chan@broadcom.com>
In-Reply-To: <20240104010108.41100-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, arnd@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jan 2024 17:01:08 -0800 you wrote:
> Fix the following compile error:
> 
> .../bnxt.c: In function 'bnxt_cfg_ntp_filters':
> .../bnxt.c:14077:37: error: implicit declaration of function 'rps_may_expire_flow' [-Werror=implicit-function-declaration]
> 14077 |                                 if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
>       |                                     ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Fix compile error without CONFIG_RFS_ACCEL
    https://git.kernel.org/netdev/net-next/c/0f2b21477988

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



