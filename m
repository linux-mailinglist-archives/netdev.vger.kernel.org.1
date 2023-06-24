Return-Path: <netdev+bounces-13765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B439C73CD54
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB43281111
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5AF9D3;
	Sat, 24 Jun 2023 22:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C704691
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C74B6C433CA;
	Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687647019;
	bh=2Y09zlKyxywwYAR9+6Vy7iCEpg2/BpmZwNMcFlJpIqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aPobRqeu61zPyQKu//ZTY+7Eby3yN9TuR4lov35E1LA8NbXrXMf0jm1OlsOHNSFIJ
	 SQ/Qm7u667JuMVnraKnT/iz0s1dGUauJTI9f45Q0CHwOJtISDlvOc1DFxYpcSyDEs3
	 qmd8R+bk3e01DuUgcS/8aL/+XIL68DhnaHGFjcUTAeoPcLse917Tu/+GV2xu+HErDJ
	 NwvAPFLXU9A6Mc83p/tBKysiGQr3lu49LZuI7bG9MBJ2ZwWObBCszkhYXmJO9bWDvg
	 rPcDkhJtho3IsH1er8IU1OoExuiWwxxr1JkZId6/iSR2AP5GBVpszC0VM/EojWsyO0
	 bjmM2zoHoWDww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB256C395F1;
	Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] net: axienet: Move reset before 64-bit DMA detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764701969.4822.7421047378744146603.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:50:19 +0000
References: <20230622192245.116864-1-fido_max@inbox.ru>
In-Reply-To: <20230622192245.116864-1-fido_max@inbox.ru>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: netdev@vger.kernel.org, robert.hancock@calian.com,
 radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 22:22:45 +0300 you wrote:
> 64-bit DMA detection will fail if axienet was started before (by boot
> loader, boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
> 64-bit DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect 64-bit DMA will not work.
> So move axienet reset before 64-bit DMA detection.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] net: axienet: Move reset before 64-bit DMA detection
    https://git.kernel.org/netdev/net/c/f1bc9fc4a06d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



