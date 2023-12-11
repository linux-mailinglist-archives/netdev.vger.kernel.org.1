Return-Path: <netdev+bounces-55845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004C80C787
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851E41C209FA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6C2D622;
	Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoBPf+Vu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D62D606
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94B90C433C8;
	Mon, 11 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702292423;
	bh=EwaYZi8lnrqN42d+cQ73ITwWtF2b2+uMdvgzEC4w3m8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NoBPf+Vu+FUCIj+/MPxSIZT13YpM8n/viTikNMBMMmQv9hypsXNMB7ei+1jLJVhhO
	 QJg0YAPAtMGyyPK+qAJWRaWLzHDbUlGXapC4CSmvWLdTj/pRaW37Q0AesdLX2hIdJf
	 OjWiqraacvRoyj1bcv06kVHAzPvLT7sCwYWWzz2fxwBeX+7mCOmE2k/NfSJYdW7AFV
	 0HGCMKNUlHmNat/Y1xcIms2cEpCt3MkW2mTspVUQwUwgdjuyss2ymGGUTy8p6dL1PG
	 eiaUcPSUk19Hq0rlI5ckicqnSzIQCdCqg9ma0NR+YAQtS6xlpHZLLSy54Y+AzIEjEE
	 MRPU+D+GWPjwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7309EDD4F0F;
	Mon, 11 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] octeontx2-af: Fix pause frame configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170229242346.25377.10383723431789286643.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 11:00:23 +0000
References: <20231208092754.23462-1-hkelam@marvell.com>
In-Reply-To: <20231208092754.23462-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Dec 2023 14:57:54 +0530 you wrote:
> The current implementation's default Pause Forward setting is causing
> unnecessary network traffic. This patch disables Pause Forward to
> address this issue.
> 
> Fixes: 1121f6b02e7a ("octeontx2-af: Priority flow control configuration support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix pause frame configuration
    https://git.kernel.org/netdev/net/c/e307b5a845c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



