Return-Path: <netdev+bounces-192110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DBABE8F9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F471B68755
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF91194124;
	Wed, 21 May 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsZubK87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4760192B90;
	Wed, 21 May 2025 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790422; cv=none; b=evjYkEJo0gKHXX01okSAYTzT9LP1mg0sl7yORznvPOr4cughwSESJY87HZwSU572pLZsJMU9dBaPpzUZ0zJ7UoyvE/ydrqB+zudNuG3ZvzS9qQmXLMtXCnky5uifp6rZe4OqKaNH+bXM7lIDv4bPkhUfkSrONocIRzQb0WpTy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790422; c=relaxed/simple;
	bh=dMgkJgqMz3ctMMmSbSC4dm+FOOp5kC87tNKqiMADZQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=so10qnuMzmUYt5LkWCsNggzXCwyLEe3Cz1EmsjZpfivPCQBu9lSYIBbnXtpddHMkwxcKuNZBeND1fnqm4DKsb9oUfmdd0a+SoJsK1wcLLvSvwdPAQ1wo1fml8VvbPnmbxqNqPVMOqe/IstP4BGPMzT7tJNmG9TZwAo1hg+MyXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsZubK87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A07FC4CEEB;
	Wed, 21 May 2025 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790421;
	bh=dMgkJgqMz3ctMMmSbSC4dm+FOOp5kC87tNKqiMADZQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XsZubK87LEUjL9tKkGsshfsmYLQqDzEUEPa/dLYIFoBBjhpQDLBiNVw35b5iTUekd
	 ZOoM2R4ycsxSEqsn8cqBIgvNw9fUOaUh2esaZ51uvduwMK7m1gYmW0cMWrvcVj4Q5W
	 M1IDj7V36GcXtCzPg9VhMjnLXKeuI0fK0ZFCjOzQXvxFAx1vRRo8U/vzLdtvyEk9WX
	 eGCxVp/Ye2xrPUPBjAhd3mH2bqgMC41b/kY/onU4jLWXRNESWyNyRtM5R2w2Y+dWBr
	 h5mQKm7BXOUZSW0/7k9pPa+GUvh2YqMN+JzrtyG3K3KyDgwKgN6VlmgNgp8PD99Kyw
	 Xup13pnMT43ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7F380AAD0;
	Wed, 21 May 2025 01:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: fix the error handling in
 enetc4_pf_netdev_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045699.1526198.11812446231836291706.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:56 +0000
References: <20250516052734.3624191-1-wei.fang@nxp.com>
In-Reply-To: <20250516052734.3624191-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 13:27:34 +0800 you wrote:
> Fix the handling of err_wq_init and err_reg_netdev paths in
> enetc4_pf_netdev_create() function.
> 
> Fixes: 6c5bafba347b ("net: enetc: add MAC filtering for i.MX95 ENETC PF")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: enetc: fix the error handling in enetc4_pf_netdev_create()
    https://git.kernel.org/netdev/net-next/c/b98b70c103de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



