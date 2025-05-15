Return-Path: <netdev+bounces-190594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD7AB7BAF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA141BA5D90
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79390286897;
	Thu, 15 May 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIpUSieQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE84B1E5A;
	Thu, 15 May 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276798; cv=none; b=fsEUHcJ4Rj1Mu2MkMr3KalfVtO8Gxg+B8DuArpRB/RxHR1vOo2ya22aYH773bZNhRcxTNNPmHblVKWEdJkjdzduljtECJN/JA2TCNY1hMwrSy85ty2ghsOUAiAALpJWfpzi5ZC2v4qg7d4Zarao2uZX0as0dzW+JCZ/sIX1Jivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276798; c=relaxed/simple;
	bh=Mq2PrXBlmn6qQ1CRh+n+NP1v+eQjNXSk/tK92hzlynw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AU3xgLStZHFtZkE+p9UxgjfNjoVedKTq+zaurU8rrT5C3jIFjK9R6akP0GclKRMpN+1OSW/ANxSWBpd53voN+1meLMhGJUTm8tET25djDrRS7eEn+6OA9seyTB5zLdENTsnxstDS/RktXNCjSRKKbNLSuj9x9jGj1auDLLUoA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIpUSieQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DFCC4CEE3;
	Thu, 15 May 2025 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747276797;
	bh=Mq2PrXBlmn6qQ1CRh+n+NP1v+eQjNXSk/tK92hzlynw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LIpUSieQINY08zDFQkGQB/gSMjC35pAp5hMo7ubBnSRCAgMzlezdYpFXLc5SOtCrP
	 Yr2soX2U3lNDGhUpSeccqVrZrKHiwTATRfQwDeyRIsdqYrkJMpyx49ZXXT2Ov6u3v6
	 lwA80ZOZewC4tjeCNVMu1cy1qhImX3XoJqnlRZoVgeEJLojn/T3GfxUy/Kv/XAgn8X
	 XBGP3damhPq7JGZTDs8bJPZ3YFYBc+7SpesJGXsGvoFjhbAHB1OnjX8vRYSNJSn4Ng
	 3qUKGkjFttQFnXnGZJCtW7gSSir41CeCp4cgoctqurghlnXW5ULmVs8O6yZvIBdsIs
	 9JHthToM4gS5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C85380AA66;
	Thu, 15 May 2025 02:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] octeontx2-af: Fix CGX Receive counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727683476.2587108.3782943844699332629.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:40:34 +0000
References: <20250513071554.728922-1-hkelam@marvell.com>
In-Reply-To: <20250513071554.728922-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cjacob@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 12:45:54 +0530 you wrote:
> Each CGX block supports 4 logical MACs (LMACS). Receive
> counters CGX_CMR_RX_STAT0-8 are per LMAC and CGX_CMR_RX_STAT9-12
> are per CGX.
> 
> Due a bug in previous patch, stale Per CGX counters values observed.
> 
> Fixes: 66208910e57a ("octeontx2-af: Support to retrieve CGX LMAC stats")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix CGX Receive counters
    https://git.kernel.org/netdev/net/c/bf449f35e77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



