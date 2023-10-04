Return-Path: <netdev+bounces-37923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7067B7D25
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3DEC728145A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03629A5;
	Wed,  4 Oct 2023 10:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B78111A8
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE757C433C9;
	Wed,  4 Oct 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696415424;
	bh=dtr7LhD77q+F43TnUZuewxByxzx/uzxMVFedPh01nLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=swQyp6wFmUYQupgQLQg8IIrz8dKyXubCSwX12wVnZZ1+4zFEaZYJiK/2fftRagMmW
	 KVIdreqK7dtp+HGgMMZ8rlYXwQaBx+8BHe6aUivwyObuknuocDsBcrPoLvgoykVCJO
	 Xty0435a5AV7z8OjBwe0KRrxmLXszYtZ9xTSi+1rOYRpZzEbvEoI7Rsdz6x78/hzB6
	 aMt2wcrJiLZVyFMj1VyuE94fHpiRYyb57bG8XcZfgBdWCY7bmjvLA3sonT+lWqOyPV
	 3J4X17rss0b9qtpzDtZe4kfi0/iLc/UM43rrvvJvOm0Eqn2x5VpBryPoQhCTGfwywG
	 kyMEPYi5d75Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2208C395EC;
	Wed,  4 Oct 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ibmveth: Remove condition to recompute TCP header
 checksum.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169641542478.13675.1330841896958252719.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 10:30:24 +0000
References: <20230926214251.58503-1-nnac123@linux.ibm.com>
In-Reply-To: <20230926214251.58503-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, dwilder@us.ibm.com, wilder@us.ibm.com,
 pradeeps@linux.vnet.ibm.com, nick.child@ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Sep 2023 16:42:51 -0500 you wrote:
> From: David Wilder <dwilder@us.ibm.com>
> 
> In some OVS environments the TCP pseudo header checksum may need to be
> recomputed. Currently this is only done when the interface instance is
> configured for "Trunk Mode". We found the issue also occurs in some
> Kubernetes environments, these environments do not use "Trunk Mode",
> therefor the condition is removed.
> 
> [...]

Here is the summary with links:
  - [net] ibmveth: Remove condition to recompute TCP header checksum.
    https://git.kernel.org/netdev/net/c/51e7a66666e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



