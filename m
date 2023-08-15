Return-Path: <netdev+bounces-27539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD677C5A3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED371C20BE2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F217EF;
	Tue, 15 Aug 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8017C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E7DC433C9;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692065421;
	bh=AtLBI3iumOo8oPgLPTi8eq44LXo2RRL7ckhDTfH+OxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DEj73u2QEThS50btGejfOymb4HiXls3RSvU2zkt2OQF4H81iglvalPU5L0qmo2Jui
	 12xfA0KFFnE6NvM/sHPHh1fKoRn8nVgx/1LRKuKzKD8UwgDiCV7BOyAej944ElTO46
	 RzyrD25z2JaSRkTom7Y44jie39X/srr/bidlmRKVf4RGLA5JQMWN6lTAsypiKfUhcs
	 77M63owi2qK49hK5GKkg6iOntaQbu8KDv6lP8eMdhhPjGMaVOhF9+ifjwHpQJFofwn
	 iAZMI/MqIOPbtRgTNvqXSdWluqVUg9iyPDInTfF1g1spr+mtN0Tv+eWI6BfcP/SdMv
	 2IzxbZWErpygQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78922E93B37;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: In ZynqMP resume always configure PS GTR for
 non-wakeup source
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169206542149.7478.10606104390007198232.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 02:10:21 +0000
References: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Pandey@codeaurora.org, Radhey Shyam <radhey.shyam.pandey@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, robert.hancock@calian.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 18:44:51 +0530 you wrote:
> On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
> network manager bring down the interface and goes into suspend. When it
> wakes up it again enables the interface.
> 
> This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
> the power management controller power down the entire FPD (including
> SERDES) if none of the FPD devices are in use and serdes is not
> initialized on resume.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source
    https://git.kernel.org/netdev/net/c/6c461e394d11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



