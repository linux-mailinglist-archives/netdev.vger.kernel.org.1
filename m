Return-Path: <netdev+bounces-74657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED72862236
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ED41F242F9
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B04DF67;
	Sat, 24 Feb 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhp21QS+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEFDF56
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740630; cv=none; b=StJOxvh6qb6t3xVV0GNGt1BBfPtJq2HvHG/Oe5QqZFy6UFPs+NE2N9GG6Mw+L4XNpwAfxCXg7lcm3TXbadZPcsUc9BkwtyklH9miRzXAd+Vfe66YsT4341zqsqB8MuUFgMLygDzy5Aa5DIpKZ/8rooxAikhjwfqMmSoe+aF87yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740630; c=relaxed/simple;
	bh=e3awmqg9DuvQucPvgIH+uPzPjXjLUPXMLUcPP7URmYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pS1NzrU80opstcL15f+/WcaAoEIAIS7k2LUeISN33xeLzsUuawVUgv2slGeORzfDSnOX6X6FGDw61ITe33q1KfiIFgWLkAK4HtWod4W3plcevUd5/vzgr7dHzMUUZCazqW1XsRZfbsg6MBuWKQLhBUFIo+TwsdpPdcpUwTCk1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhp21QS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981C7C433B1;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708740629;
	bh=e3awmqg9DuvQucPvgIH+uPzPjXjLUPXMLUcPP7URmYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhp21QS+4BnuICE7ZhAiXzVD7eNcy3Pn9GzyE1nC+PEBrbKOX6WF7vIiTwORgjBBs
	 tKV9PgJNJv5IbKvn2T4MHkrfIqwhAt6Kdgi0aimFXwOk/daPfaXJv1bg/Cimhbo2JT
	 wVD4PBNg06HRejU07WYitoedfe09/QQ+s9EqC8s5XxxYRk69QGvL/FMjhZRNF2uowb
	 8kngcfSgcbZq//M+HvpQ08LVkTH7o0P8xOL2r44D7g5yLmmL7S2zh17/5vbhd2cc+2
	 DuLQxcL4rqgL+0BRiKnrlZfjtTh2Sk4KyMkr11t+WjcTR0n/aeHXF+xBAi93mW5kwl
	 3Je2Ttjz5aDhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74E20C59A4C;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ps3/gelic: minor Kernel Doc corrections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874062946.5601.16694725773526396855.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 02:10:29 +0000
References: <20240221-ps3-gelic-kdoc-v1-1-7629216d1340@kernel.org>
In-Reply-To: <20240221-ps3-gelic-kdoc-v1-1-7629216d1340@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: geoff@infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 17:46:21 +0000 you wrote:
> * Update the Kernel Doc for gelic_descr_set_tx_cmdstat()
>   and gelic_net_setup_netdev() so that documented name
>   and the actual name of the function match.
> 
> * Move define of GELIC_ALIGN() so that it is no longer
>   between gelic_alloc_card_net() and it's Kernel Doc.
> 
> [...]

Here is the summary with links:
  - [net-next] ps3/gelic: minor Kernel Doc corrections
    https://git.kernel.org/netdev/net-next/c/3e596599372e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



