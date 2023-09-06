Return-Path: <netdev+bounces-32180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16057934DE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB981C20959
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9B653;
	Wed,  6 Sep 2023 05:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0B817
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1DB1C433C9;
	Wed,  6 Sep 2023 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693978223;
	bh=z61UfxOVoVm/ms3V/hcHCmsvyVBlhcaLZpo1InMzYuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onGN5VqAYxd/LHIYFahDZ7+JVvItHOhPB9FphuXWrKahv8g2uVjB7m/799y3Xmo37
	 F9r4MG+I4QyPRfnkeagtME6O6TKCJ8Gqgkqbj2J+vQ1k6xrdCcwW8Chh4tfDMafTno
	 uwSb5iAkiYHXRG8Mt16hHQv2V0lhHgjnvVtfAfg/YUWIGf13L+Wumfnn2Q4rSoJLPl
	 aivfGgSXGSdTl+b8oVYuJpMMSTOmuvhPuNmDtrGW+L63Pow8quy4T1KaPgH+eLiF4Q
	 0gLgGtT6fffjG3psEFpxJyd0qEtiMlk0AHmgL0T1J9a8rzEG3/dgm1yh2FD6Dk8pEC
	 hKYfqj956Wlsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AA9FC04D3F;
	Wed,  6 Sep 2023 05:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Change MIN_TXD and MIN_RXD to allow set
 rx/tx value between 64 and 80
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169397822356.31592.3331483970727995773.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 05:30:23 +0000
References: <20230905180708.887924-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230905180708.887924-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, olga.zaborska@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  5 Sep 2023 11:07:05 -0700 you wrote:
> Olga Zaborska says:
> 
> Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
> value between 64 and 80. All igb, igbvf and igc devices can use as low as 64
> descriptors.
> 
> The following are changes since commit 29fe7a1b62717d58f033009874554d99d71f7d37:
>   octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE
> 
> [...]

Here is the summary with links:
  - [net,1/3] igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
    https://git.kernel.org/netdev/net/c/5aa48279712e
  - [net,2/3] igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
    https://git.kernel.org/netdev/net/c/8360717524a2
  - [net,3/3] igb: Change IGB_MIN to allow set rx/tx value between 64 and 80
    https://git.kernel.org/netdev/net/c/6319685bdc8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



