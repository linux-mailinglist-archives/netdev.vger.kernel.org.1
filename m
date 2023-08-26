Return-Path: <netdev+bounces-30846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C982F78933B
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0773A1C2109A
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E101364;
	Sat, 26 Aug 2023 02:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822667FD
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ACCEC43395;
	Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015228;
	bh=QH/KR54yLDYfnoVOs3tqhFrjNx/DdiaL8A1fYMdoGQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lF5+kssz1vrPFlpYyCGZyWyNXMKcdRsnXZLY1GzTcX8zfoXTMzSbuJWORH8JIzOrE
	 eZxPe6+8Cc8b89JrZX3fuu42bUvAvU4JmBOLYkKivFJB1Okh/Kts0ROPsj62rajJZs
	 y/SoRAOktt9ErMiVLpWj56hvVeRxd5JHgFv/49Q4vchtOT7KELGRD4L/dsotBvM0fJ
	 6Vlr7V6xf+Y3PIPvduTiCGLsOrHjjOtfVaJBeHl8+FxcmwK4xsHfZrscIgL/Nxo7GS
	 vSe0VoeBqD0TS1d7kXkpLiQ6Z/UO/mP72JXiycrV30yoengGD9ZZioXopKyEcxnzlo
	 Gbp/+apGnlxOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF98E33087;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: fix uAPI generation after tempfile
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301522791.10076.15313676651166037219.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:00:27 +0000
References: <20230824212431.1683612-1-kuba@kernel.org>
In-Reply-To: <20230824212431.1683612-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 14:24:31 -0700 you wrote:
> We use a tempfile for code generation, to avoid wiping the target
> file out if the code generator crashes. File contents are copied
> from tempfile to actual destination at the end of main().
> 
> uAPI generation is relatively simple so when generating the uAPI
> header we return from main() early, and never reach the "copy code
> over" stage. Since commit under Fixes uAPI headers are not updated
> by ynl-gen.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: fix uAPI generation after tempfile changes
    https://git.kernel.org/netdev/net-next/c/a02430c06f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



