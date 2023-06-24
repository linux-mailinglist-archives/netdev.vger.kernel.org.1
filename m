Return-Path: <netdev+bounces-13764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BE73CD53
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3705C1C2091D
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B62EAF6;
	Sat, 24 Jun 2023 22:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA2882F
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BADC3C433C0;
	Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687647019;
	bh=XfzAH5D+NJ2x73kry8Xp6iNcZsdkJPTh9EhjfSDHT3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+Ahd5NJdGZpuc+mdW4+2vHXTYlT/9gdnj0nZ71A2RhOnm1y6XAcW+dUiucW9gPae
	 Kc+tQQrq7suCGPQzEpTqOeOSVtNoWbSHOmYfrsFGzJiQvVCvqRuzTmH3e6bbQuoHh0
	 JqCQD0F92LV26K4G9PIbMD0Ww1rgeDLZb6kRql2NMmE7TSkhZhOif/2rkxqoGJjk4y
	 F3nHgUA2n/Q4tdy0lOPRlFdXOCTZTS5RUgzhAyeP/JUb9Jj1whQsMLhBhWVpnTlSIV
	 iyuPsEZ8w5NyCLBG5MsS4mNLD0yl1VBsZoXml+O7+CocqGIt38PmkZJZQND0AK1NMx
	 gjsCbG50IUd/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FE1DC395C7;
	Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764701964.4822.15290219701986465008.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:50:19 +0000
References: <20230622185131.113717-1-fido_max@inbox.ru>
In-Reply-To: <20230622185131.113717-1-fido_max@inbox.ru>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: netdev@vger.kernel.org, robert.hancock@calian.com,
 radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 21:51:30 +0300 you wrote:
> DMA detection will fail if axienet was started before (by boot loader,
> boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
> 64 DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect DMA will not work.
> So move axienet reset before DMA detection.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] net: axienet: Move reset before DMA detection
    https://git.kernel.org/netdev/net/c/f1bc9fc4a06d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



