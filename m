Return-Path: <netdev+bounces-51650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F787FB950
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A01C21312
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538244F5FE;
	Tue, 28 Nov 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkinbTfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379ED43AD4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF679C433CA;
	Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701170425;
	bh=urPJ4vOJ76R60Bbw9R055iOzZ5pzXSFIvAM6WcsmwOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VkinbTfpjETTMtxSNDuhNEZjy8WF5A5l5TDTfxisiOTD18nJifwg9L5X92OGyDQzy
	 IzPlX8+ymSluUnRVxgYNQM/+KZOjYfQvcvHtiYl8nXIeDMG6auDB6jya+wCobGeOEG
	 qQotkBZ/YvmFWR7DUi55rRs3RW1wfSse4iCqHxxKVEu5z/NUtq6pRRyhSG4cspsg2i
	 iQD2DxX55FTfT4BbCgNjRD2Z7++hSdJtJg5ZqalgABybFe5NW9321r9ZeHOJlH5N+L
	 XUvM6ztc7EcMM5ZLzfGsfI00pslFCNiahOYqc8of2bKn78TeBQXHL1wRLq4jBz8BEc
	 Z9oAgnFi0lWpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF05C39562;
	Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix adding mbox work queue entry when
 num_vfs > 64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170117042558.17319.13811133588326696769.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 11:20:25 +0000
References: <1700930042-5400-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1700930042-5400-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 22:04:02 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> When more than 64 VFs are enabled for a PF then mbox communication
> between VF and PF is not working as mbox work queueing for few VFs
> are skipped due to wrong calculation of VF numbers.
> 
> Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64
    https://git.kernel.org/netdev/net/c/51597219e0cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



