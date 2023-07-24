Return-Path: <netdev+bounces-20315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C133575F0B9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E8281427
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D98C04;
	Mon, 24 Jul 2023 09:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66879FB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23373C4339A;
	Mon, 24 Jul 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690192221;
	bh=NHd4ukGaYelpdsG2A1D51no+AJq1E+sf+uWuGcA3d/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NHzxq8H48i4sEtyUTRDeHs45ud9eN/AJY4oKA1Iqx6uRDz4u21G6qLzNW8yEyUtWU
	 q02h+Xh9fNxxK3wFuj64TukVve0ruejM7Q9qBabjRhDDh75+i3Sn4l5ZydL0XYMVVY
	 PJB3ovXB5ubyDM0zOJRZ0BUiGmyJLZsLhOR9YN3fdY65KKkm+CRf2d6TVBFia6dTyY
	 q7gI1Slk6f27Nn1WET6s51FpLF2+QuC3W0TJKZkoR++imCpOvTAK+UgHIjoUZc0NLN
	 fFd7Z/bJYRvxmI+Cvn+OTJ5xm1QbTUej6LOuQT0ShjZkARJN7+eHIqCieiuMYsiSrN
	 fKos4FTZn50Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 078D7C595D7;
	Mon, 24 Jul 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/4] ionic: add FLR support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169019222102.26830.4630551452871557340.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 09:50:21 +0000
References: <20230720190816.15577-1-shannon.nelson@amd.com>
In-Reply-To: <20230720190816.15577-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 simon.horman@corigine.com, idosch@idosch.org, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 12:08:12 -0700 you wrote:
> Add support for handing and recovering from a PCI FLR event.
> This patchset first moves some code around to make it usable
> from multiple paths, then adds the PCI error handler callbacks
> for reset_prepare and reset_done.
> 
> Example test:
>     echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/4] ionic: extract common bits from ionic_remove
    https://git.kernel.org/netdev/net-next/c/87d7a9f3734f
  - [v4,net-next,2/4] ionic: extract common bits from ionic_probe
    https://git.kernel.org/netdev/net-next/c/0de38d9f1dba
  - [v4,net-next,3/4] ionic: pull out common bits from fw_up
    https://git.kernel.org/netdev/net-next/c/30d2e073964d
  - [v4,net-next,4/4] ionic: add FLR recovery support
    https://git.kernel.org/netdev/net-next/c/a79b559e99be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



