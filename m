Return-Path: <netdev+bounces-93919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53F8BD94D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709CDB20AD7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600964A12;
	Tue,  7 May 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsg0e2Fb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C646A4
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047827; cv=none; b=ooB+FLphhBEdwU/HLT77taMNUVXfpFSU4X/Lyh6U4c3E369sYnR7dWYGHP4+o5vN85e8+2AohLkzX1+NRehPA3lLdSuSULBro84ncw964m11KLyCJbwmpEPim3dtArri5kQQhJ+o20635uAxrWLOdOqRKnk2M0Vbz91n5PnZbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047827; c=relaxed/simple;
	bh=CPansORL4SJWZJ4Cph/x8l1HtMNIZCH012uf2pAypXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvYWxmsB04rbGa8JhY0NfS273DQTKw9DSUzKSjdftMDXKKqfg2IrBuF9xMd7M+0TZeXrtfktZUfGe/n8S5+D4IRUhoTIBAMsvlEBr4IcBTvoqZgaLUXVCuvI3BRtA0xgAopCgHHlpIhCe/KGa5xIf7qRsLxIv3ytKVXGgnpv7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsg0e2Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F3AFC3277B;
	Tue,  7 May 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047826;
	bh=CPansORL4SJWZJ4Cph/x8l1HtMNIZCH012uf2pAypXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gsg0e2FbutADlWkkEIua7+n4k4FBbfBang/LbOeR4wE3b5fk0/1BaR06snsnW8yEr
	 uf3m2brBg07z4w8x4Qtd4A614fxTcDKu6A0QoreuRZyU1yX2fwIaPUxAfS1bZnlvue
	 w8R04rn7oSklFSHUaiiJBq8MeX07D2HjH4rDP/nzjgcrBWUzcr0VCLpiMSlOc+9Qtu
	 MuLk0BBJp+kN7W7cyDIPC9ML9icHc+0HY4PLclXDYTRex7XxyIUshzDG6k8E+xRyr5
	 +Fkt2Bdcm+Bh1zcThriTf4zJDFdPyt3rEEShP0rDr6ZWPHREFhEDfn9HOAA3tYcuig
	 upmZkocJiu5LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BE19C43337;
	Tue,  7 May 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-pf: Treat truncation of IRQ name as
 an error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171504782656.18663.926414916456400043.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:10:26 +0000
References: <20240503-octeon2-pf-irq_name-truncation-v2-1-91099177b942@kernel.org>
In-Reply-To: <20240503-octeon2-pf-irq_name-truncation-v2-1-91099177b942@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, dan.carpenter@linaro.org,
 netdev@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 May 2024 12:11:58 +0100 you wrote:
> According to GCC, the constriction of irq_name in otx2_open()
> may, theoretically, be truncated.
> 
> This patch takes the approach of treating such a situation as an error
> which it detects by making use of the return value of snprintf, which is
> the total number of bytes, excluding the trailing '\0', that would have
> been written.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-pf: Treat truncation of IRQ name as an error
    https://git.kernel.org/netdev/net-next/c/6bee69422590

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



