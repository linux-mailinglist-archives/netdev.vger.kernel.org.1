Return-Path: <netdev+bounces-105093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5490FA46
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37972824F6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122E6116;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpEHyP7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CC3FC2;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843428; cv=none; b=bhET4x83EyMvwLcEbyrBg4tHgKO+QhdBW59VWWJje1SBVxBjAQiAiSqnOB3z7f1VuFJ4dpUWCNYSsOrdiNL9MhhKNzlx17/IF39E4Fyenfj3/MNQPczS46sE+hW7qOQdGWQX2GvRKWLkbK3SbPFkiZNbkDTZL4O+PksZY9crrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843428; c=relaxed/simple;
	bh=xbc8Zmi3Bmbg1lb4ckWibU2TsYivfw18LapC26/oXH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKK9cwLGm8C7pcE/s7r3MgXNE2lghGM0uVOMrDm6Ht5LXMzqbfz5WmZzgoHcJbeYNMJL06cieAIKMto8381sWNeG7phU6prNbkXn4RXTX8zGAZmha4y89We+/z8DOacEUuj2fpvrpp+06XZSBbdGE8pewR+gp0Psbd8lgyuBoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpEHyP7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27354C2BBFC;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843428;
	bh=xbc8Zmi3Bmbg1lb4ckWibU2TsYivfw18LapC26/oXH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KpEHyP7ShMtkcjd93I144ldDRUhI6LGvQ1EodQUMKDgl5ONf809yrT8sz5sw752Tu
	 6U3+gtSZm4xV89vbIC6csUavt76u4Ybsz7Slu0lN1kreshNFgGhclUJ/6puwljj2Hw
	 zRZZ2/XvUAHmUHBMGxGUrMj+PFym0mWlJTCxbtHXarfkmXahRyKW6ME0+vpDcvCaaq
	 08VQAzk+RvrzBGdph20Q5wOSKvWmVRdBe9FhzQv3DnYkzuDcgUC0BkePfU1Kn/s2g1
	 e9ZwPb7lxgpqocRY0BSmZvKcek9Zs6qjFMH37ip1SfcAwhStUTPb8VaYN6peQfGXJE
	 F7KfyzGONnZMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13B9EC4361B;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mac89x0: add missing
 MODULE_DESCRIPTION() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342807.23279.8819940675643672464.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:28 +0000
References: <20240618-md-m68k-drivers-net-ethernet-cirrus-v1-1-07f5bd0b64cb@quicinc.com>
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-cirrus-v1-1-07f5bd0b64cb@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 10:41:54 -0700 you wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/cirrus/mac89x0.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mac89x0: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/netdev/net-next/c/5e736135ad00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



