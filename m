Return-Path: <netdev+bounces-153194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5D9F7258
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816B616D02F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B63198833;
	Thu, 19 Dec 2024 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpyVtaol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F119DF6A;
	Thu, 19 Dec 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573018; cv=none; b=sNICjQEJD2S6uvYKSsGhquinJMNv+8kfWgvZwcMVpHdm7hRwrwxlDw4kg423Z2BAs35MFwLsF2jQQ+BILUiERICju9r6UijQao4vXzcucER9HOAgHyTs14wIf1ygNQt+xGGmd6qb7Tc525RhOiEnr+kdtvAvdIK08MF4nbwJKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573018; c=relaxed/simple;
	bh=RF73kXAWPk6fo1MJLHxjnLRgTsc0D6sRL09/sFn1rAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OiPY7JXWANmz/xU9LB7OBNrVT5XPPSDm3gCGOB+6senU98NZtfGudAbAoubggSAtlQG8FeGfu30nKumtN+vL+PcT4LjL/wskRRpd0EmORqB2K9EfGKu2u8x/z1r8kzBmibOjlMlwXHHUSRumcU+rb9AfSYUc48G5A3KDFli9bEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpyVtaol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305AC4CECD;
	Thu, 19 Dec 2024 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573017;
	bh=RF73kXAWPk6fo1MJLHxjnLRgTsc0D6sRL09/sFn1rAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpyVtaolqK5FRicH72oxbV3uWMMTRM7I1vp9811Qa2093+SEX75CTXmD9CfoOJbAe
	 yJa5sIxACZXSXOHmo09+H6NAJVs8nvk0TZ3InCKaaYVNE+rTjcSJr3lM31o4raOUKq
	 NhpjIbPEFOUWhFKJjBVh3xeQeR3TFA2EuAiS63EvtEME2pivM9BCbJmNC8dqIOX6qC
	 Le9PKEY7rkBgEIERD2bR08NbDdkUd9aRFZMtxgqJPgPEl7iyClnVZXHdSpi045ArCX
	 254LqHtRefGAWesb6DPrHfa7y4LVwQx5HhBTtYBFPSSq6nKwyXq/pp48VHVT4+JxE/
	 7rgzKC2rC2Gkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 41AF73805DB1;
	Thu, 19 Dec 2024 01:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: net: bonding: fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457303516.1788421.927650361781160181.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 01:50:35 +0000
References: <20241216135447.57681-1-shunlizhou@aliyun.com>
In-Reply-To: <20241216135447.57681-1-shunlizhou@aliyun.com>
To: None <shunlizhou@aliyun.com>
Cc: jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 13:54:46 +0000 you wrote:
> From: shunlizhou <shunlizhou@aliyun.com>
> 
> The bonding documentation had several "insure" which is not
> properly used in the context. Suggest to change to "ensure"
> to improve readability.
> 
> Signed-off-by: shunlizhou <shunlizhou@aliyun.com>
> 
> [...]

Here is the summary with links:
  - docs: net: bonding: fix typos
    https://git.kernel.org/netdev/net-next/c/65c233d8e329

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



