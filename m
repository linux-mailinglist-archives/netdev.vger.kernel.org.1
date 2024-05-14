Return-Path: <netdev+bounces-96214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF568C4A7F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10121F2203F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281280C;
	Tue, 14 May 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGhpV4Yx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB27EF;
	Tue, 14 May 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647231; cv=none; b=buZECNZbA1UwoHgglDB1RTzWr9gRJO0LWZ22hswb7flx7APTVhnsmVMHgV58FNnKSEeeTTy5buLFiDiIgQmzbBhZDi1bzxbhDUC+GSWvDL7Q+j9dBUbNPuBa2yqYe+MA0vwVcLHqndVoJyTC6IikNYmeGV2FUeMoHU8gtIhFNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647231; c=relaxed/simple;
	bh=GuggH1Zyj8T2UnJBxaBdCkD187tntfeAmpE8CK3VXoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nQennCraVqidkomhnLlvU+who1gx2rbD+6oOgsQKX6oJiE4JtOV/+pDO10SNE2aj94wrwQQrFV0+oq5GuxRIuxIUojdnyeKVYDYPv+XLePP4wL5Kb6YAMFf6+4+7f+YIFb+7oUZN9mBCGihX91NLzAqUWbMvaCju1FS4WBrpEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGhpV4Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05C4AC32782;
	Tue, 14 May 2024 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715647231;
	bh=GuggH1Zyj8T2UnJBxaBdCkD187tntfeAmpE8CK3VXoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gGhpV4Yx8FbQ3eR2vHxmS2nC809Umd0oPBuCLxUMsqkUr9l+Q6nVGzczfrpLfVjAN
	 79aXdvicR9igfjMdoH+K3B8JqTy/RwIe5aqFihS5EkZq3aaHcKOjG3KOVTeW8Dcu01
	 xrIKCORojuRQ5VE+kuYEl2GaH+phIXCTnf+UZtSJepj4wwUg6NEHgE915Z1si/R8fW
	 4eod9d1Ao/0qtje0nrF/bhWTY9S3KPTwbDacxb5lcEzn4obi90GhwGpVUkXFiksxwr
	 Up4hCVWWfReA3WMZEg3kYUTLtLShXrdKv+SqEQF26dOhmBl7/Zx/1bIeFGiTqB6Evc
	 V9bIWJ2GU7qBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0096C433E9;
	Tue, 14 May 2024 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: qede: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564723091.24946.3728093094904006906.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:40:30 +0000
References: <20240511073705.230507-1-ast@fiberby.net>
In-Reply-To: <20240511073705.230507-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, manishc@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 May 2024 07:37:03 +0000 you wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: qede: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/486ffc33c2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



