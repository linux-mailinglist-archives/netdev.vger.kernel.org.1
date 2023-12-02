Return-Path: <netdev+bounces-53225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBB801AA5
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663C81F2112C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18343D70;
	Sat,  2 Dec 2023 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFmyKaT3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5321BE6F
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D8EC433CA;
	Sat,  2 Dec 2023 04:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701491425;
	bh=uYh0hAOiVfqI1yraa83qaecD3Lom4RWZbQ4IgR1ECHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFmyKaT3ipMSiZai/820Ocv8gBge6eS+OGjYI4aC4Uib7ITroyhEfTDho5W6epbP/
	 KwtdAvBW9Ea9zz35HfGnT2ucThRdq9bEO22hr4JTtJmy/W3IFNicrkLaubWz78em30
	 s2A1bDrC2ykmHvQ/FmsFPI1aAXdjw7P4DfiBjVvgqaAYiCL+9GUef0fFSPDeuIi3EA
	 y4JMsl+Le1BhLVvHsYCx/eFZnDqx3Jy2g7iXkwOj4e8lVkqWTsGrnN1WqPr5rpPkxU
	 +QhM2fjk3d6k5BvevQw6YoIgdeEtlLkLs7IM2QzqpyY/l6iN0mCHsTMQWibVMpa9Vq
	 iAFexZgHEYoWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EF4DFAA84;
	Sat,  2 Dec 2023 04:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: ethtool: expose transmit SO_TIMESTAMPING
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170149142513.10970.6458960041889194841.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 04:30:25 +0000
References: <20231129080413.83789-1-louis.peens@corigine.com>
In-Reply-To: <20231129080413.83789-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 yinjun.zhang@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 10:04:13 +0200 you wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> NFP always supports software time stamping of tx, now expose
> the capability through ethtool ops.
> 
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> [...]

Here is the summary with links:
  - [net-next] nfp: ethtool: expose transmit SO_TIMESTAMPING capability
    https://git.kernel.org/netdev/net-next/c/7453d7a633d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



