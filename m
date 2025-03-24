Return-Path: <netdev+bounces-177182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C428EA6E344
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CC172734
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A419E7F8;
	Mon, 24 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ot5uJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F619DF5F;
	Mon, 24 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844002; cv=none; b=SLvkbRwIyDPY8/PLWMKX2pkvmaE3A2uy8erAE0vieWGkJ5MaDHdsS511rkQCUjWtRt2GZnOL4Q7OmsYosczseJzbwhs8g3CsFesYXS4i3HLf1iaCNnEqUjxTlmKVMZMSjTarGK/tgA94QJj/mL2yFp7v8IB3iLv9J9qkU3QBsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844002; c=relaxed/simple;
	bh=PeehUfjfAxD5S2vu36KoL/A4lTpmyqrRjLXpa2o19UQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LnJFditZZZdXtcrL6aWxCD30ZnBOgW+Ve9/D85BpWPh/ariiAKKcBORrvrlfoxAsf8+kvVDRjc7jIXEk4to/cEYWaoSC1epJvd8LyBa2WiofUxr2+bIrEkm+2Zvwc/cHAqkc2gjo3v6DFgzC+D6lyNLwHSzmxBc8XZ2Z7nzTGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ot5uJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C53C4CEDD;
	Mon, 24 Mar 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844002;
	bh=PeehUfjfAxD5S2vu36KoL/A4lTpmyqrRjLXpa2o19UQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M6ot5uJIgkeqpi5u2/8IkQeqX23DoR6Y5Iu2dGE8XUZ1XokHFiIhC+DNhFVExpgf9
	 qse7211vTuhHzKrlwxzckpy8WLR9bIw+6ckXzgnQhyhJp0TVaQvJnNmBAKKDAIqmmh
	 Verghsv5BfCfaN+oxf5dha/SHMoT/2ENOM3+QQSXFiQbVhmvn+xwgA7JuvuN9+Ntz4
	 LbdwrL+BAsLDI6biK9fxfScSoplZXiP+MwBL7iQLbjyRXS8PPxz2WVH4dZZlU2k3lY
	 fXrMV5UFvq7sBbPBwMMKFhepvdB7C3ViDt28TE8ygw5Wrrsi5p398eh6yUWazjEPsS
	 SGv13nW9pX0Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE68E380664D;
	Mon, 24 Mar 2025 19:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: networking: strparser: Fix a typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284403852.4140851.16314793821703962181.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:20:38 +0000
References: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
In-Reply-To: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tom@herbertland.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com,
 hello@sourcery.ai

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 15:46:56 +0800 you wrote:
> The context indicates that 'than' is the correct word instead of 'then',
> as a comparison is being performed.
> 
> Given that 'then' is also a valid English word, checkpatch.pl wouldn't
> have picked up on this spelling error.
> 
> This typo was caught by AI during code review.
> 
> [...]

Here is the summary with links:
  - docs: networking: strparser: Fix a typo
    https://git.kernel.org/netdev/net-next/c/6d1929475e36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



