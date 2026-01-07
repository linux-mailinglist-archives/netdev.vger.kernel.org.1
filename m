Return-Path: <netdev+bounces-247544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B28CFB94D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46534300AC8A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72F13B7A3;
	Wed,  7 Jan 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2sIklyE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E93FCC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749017; cv=none; b=C6g3bLpUUqW33jnT/VrxLrTqquKX6Un6AdlZ7fMLuMTgNH8V+vd/atk2k2HvfVYzWyjlXv3WNr1rbNwEhEdgEmMQGRKEO1jB4O6FKMWhXH6w2iCGNYVZlUtSotOYNyQbTolsJRAWc7CDwWX+weMT3hOzTRMn5CpjhRqFjxGH+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749017; c=relaxed/simple;
	bh=5cFJO5s3wQK+4Ifp8ZJthLIPbVJ6jfkCvYSf0lyofR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GAKHCUDJ5jcrQuo0kKhm06cUtNdSerOi/jECf2ZH/W9x0Cktax8EZZH0J/Y+OJ3C48eMnwfJQxtoYw3e11SS2MX6zhzke0Dv22day96m+S1THpB8EYuUTo1bxey7yEavBWbAcJd7sIO6roNXhZXg32OPu+WfJZpc3S+FkicZKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2sIklyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16701C116C6;
	Wed,  7 Jan 2026 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749017;
	bh=5cFJO5s3wQK+4Ifp8ZJthLIPbVJ6jfkCvYSf0lyofR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2sIklyEBO/CYs87pAiZmQ0zUYGPZraIpqStPxRNwuP0iqIouTC1ySo5YrGMhJBwM
	 sKoxSIjDrplOvYKegAUM6rD1Q+kGMb9Dc/b6+qi/TnSSJLOBQB19RtFVTOLiXQknGM
	 BnPNgh2BRkqKoq3wzFlJS0QQi13oA7LLt3WJRP5rZL2Ws4b466LEmpfxsRZSLF0RM7
	 s/yRLd985tmyAXW2s2hsp8kVC2/L9liGveDwtEy3+JgvLTUhs/cDWpOmJle/3RK48+
	 Puqp/4173YlxUf6JynVZ9/Caj0l0mEURC2b+FIxoNQFSk1EXIxdYwkJB1+yBp5sTvu
	 /kRc4Yv2cNbhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A58380CEF5;
	Wed,  7 Jan 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Use gdm port enum value whenever
 possible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774881426.2188953.14906966324669227872.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:20:14 +0000
References: <20260105-airoha-use-port-idx-enum-v1-1-503ca5763858@kernel.org>
In-Reply-To: <20260105-airoha-use-port-idx-enum-v1-1-503ca5763858@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 05 Jan 2026 10:40:47 +0100 you wrote:
> Use AIROHA_GDMx_IDX enum value whenever possible.
> This patch is just cosmetic changes and does not introduce any logic one.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 40 +++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Use gdm port enum value whenever possible
    https://git.kernel.org/netdev/net-next/c/4d513329b87c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



