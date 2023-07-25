Return-Path: <netdev+bounces-20635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0287604D4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98157281563
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1DA1390;
	Tue, 25 Jul 2023 01:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C387C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DAB8C433C7;
	Tue, 25 Jul 2023 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690249220;
	bh=DXOnBDlZw4xfAif0iHSszj8IchUMGm4DrmfhSqOoTtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKdh6qcRtaYc9wnWbdTzWYvALu8wypNqRuvmGYF85ubRrmDAt9sbQclhiBvPTmjpy
	 HbmvXNK4+ayN/2wWbLThFp36RnLD3CGhr5ZNe8ntGAmVEtqIkfZ3fezwGlGrPoHjWf
	 szyhmyb13fnlp75waRpltxUh7yXeX3M731+e+p2LinMjzJ5sEEqqy2lIq4bWCvhF6W
	 Jby2BtiL3gxnoEXbdoQQ29arb0n22BJZwfzDDspZBDO/2k3bQmZgI1mAs0TqpfsUrC
	 z5RMY1Mox1kSMRRQr85P1IGTo+F5b1lNY55+V5ML756Y7h4boVEdSNQiBJtOkeLFiR
	 vOxDv/ll4HhQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0AC5E21ED9;
	Tue, 25 Jul 2023 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] tc: fix a wrong file name in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024921997.19916.3427881254511155476.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 01:40:19 +0000
References: <20230723164257.1262759-1-yamato@redhat.com>
In-Reply-To: <20230723164257.1262759-1-yamato@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 24 Jul 2023 01:42:56 +0900 you wrote:
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  tc/q_plug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] tc: fix a wrong file name in comment
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3a75c7a28605
  - [2/2] man: (ss) fix wrong margin
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=02ea021446f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



