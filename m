Return-Path: <netdev+bounces-137304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3A9A54FE
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2055E1C20AAD
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960D1974F4;
	Sun, 20 Oct 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvCWx5CY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EB196D9A;
	Sun, 20 Oct 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440636; cv=none; b=Gw1WzeyYbfNt2MYCkgiXPGAWt1cFsHil2LFTFdeTsmnRLOhbW3wyAAqwzjFvHGiENbn34KWVoU9hdnkBNGqpzxUrsgpY2kFT3Rv8TtSEMRdElrkPCs86yh5L0FdLh1AtCXiq17nGnbOEqdScacK7LmHZDz33EMwzo2xGuHbZ+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440636; c=relaxed/simple;
	bh=y0+xXId/09bGlQdedgpY7N+6WcCTvgP6Y5ybpL5Etrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GtVPQ6LnGOMw98l5XHAAw15X1pZyssBSp7RFuNB8kUoXzemhA0c+j9oUup3KzqqhsDYGqgeRS1/J0rwWKTezdIggue60k5n7KzUpq7LTrM0uxsy/wt/J5PIeDII6BSDuvMOnQevDZssy0RV6ywirSt0YieePx8nWNEU1ezuhoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvCWx5CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB35C4CEC6;
	Sun, 20 Oct 2024 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440636;
	bh=y0+xXId/09bGlQdedgpY7N+6WcCTvgP6Y5ybpL5Etrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EvCWx5CYVpA/bTf9tR+54L4jvMs+BfsH+GpgASMz1OhYCg5rZz+UBgbV+csVUSL4p
	 ty+xoS5zKE4R6vsV6/yzhgWOFsAq+12YRknUee0sECNSuz32ufWJseBAdpROhMkb0V
	 wwYmlYno0j0lweuYFjwQyHz23bYI2bZXM3WdIhjoQYsa5wqYg4au5ZAUmtoi6qjVpN
	 6h2aGkXEg0IhjjRUkC0shHRP5O3JOjQi98DFQWwpxX38mN5R3STp+V4px5TETYipq8
	 WNBdXtGUOSOTIC70P8XpCyr0KkM3WnK3HzttWMkv8tXRJ5spGrQ8v2zk1k6/hgUQA9
	 V5XVzu+hMrXRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FDA3805CC0;
	Sun, 20 Oct 2024 16:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: Fix typo 'accelaration'. 'exprienced' and 'rewritting'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944064224.3604255.1585916865196633858.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:42 +0000
References: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
In-Reply-To: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 mchan@broadcom.com, jdmason@kudzu.us, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mcarlson@broadcom.com,
 benli@broadcom.com, sbaddipa@broadcom.com, linas@austin.ibm.com,
 Ramkrishna.Vepa@neterion.com, raghavendra.koushik@neterion.com,
 wenxiong@us.ibm.com, jeff@garzik.org, vasundhara-v.volam@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Fri, 18 Oct 2024 10:19:10 +0800 you wrote:
> There are some spelling mistakes of 'accelaration', 'exprienced' and
> 'rewritting' in comments which should be 'acceleration', 'experienced'
> and 'rewriting'.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> 
> [...]

Here is the summary with links:
  - eth: Fix typo 'accelaration'. 'exprienced' and 'rewritting'
    https://git.kernel.org/netdev/net-next/c/9e2ffec543b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



