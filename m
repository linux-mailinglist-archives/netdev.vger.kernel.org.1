Return-Path: <netdev+bounces-229771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BDBE0AA4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81B13A3891
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4C306486;
	Wed, 15 Oct 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbKUqS9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BD30103C
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560830; cv=none; b=VtTB+ZaWXx5CTRbadUzbZyX8UuXZMt4PnZ2C9+ebXc2e4e99ZZg2lgdongSaAei3PCb+w/42dxI8+RR3IQgnIjbDkpmnuyLSM8YEBQDPX0ajUzQEttUi/R8u1NexptC85M0qp1D5r35gH4xdyH5JpVH0Fwve6gvmnJXaGwmN2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560830; c=relaxed/simple;
	bh=vwKLI9iwghvQLW7hdhxwgPg4v9Fr0M5+PlVGJ17fDJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UAPZfQkrwi+k0febpHPIIuWJeGrjru0iJAQLLIn+n2BNA+wY7hqCdG7dW7q54J7sAdXvMccxhoD60MpRs/oyBkt0y6PCxlGlEvlGJqYaoP9UegISr7DyxYVJGTe5JDT4KbPNrikNsHjeUXzibxWJcKQlYUEGsKtYKipvB1rO06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbKUqS9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F4C4CEF8;
	Wed, 15 Oct 2025 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760560829;
	bh=vwKLI9iwghvQLW7hdhxwgPg4v9Fr0M5+PlVGJ17fDJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HbKUqS9IbqxKkPGGNnXZH12cwTRGxyb/QI2+0foHtHJ87/kkocQ4rFOhUJd/IuAxj
	 7Nh3Fj7gNRCv/eDGNZSZU9cu03jMQZ98PgdaO0O4Hj6A7rtS9V0YGQlHgqVUnhs/yD
	 007PToC9cKzBqkpYhjcaxA10NwYK2zVRARETfHCcMnkTcRhKMA16RAfvUbASZ5T406
	 IOLVm2yQ8lJ4Ltrlmqid2+2g1GQvbdpndQGP8hY5ow6ubSN++JfTlS4XNbunmuD+Wf
	 wrLYVMUc7dvOySbFTxQ5h4s192ElnUiO0H8z7g3CZlb8PnyqRbmiPX3o5d2EO+vxYy
	 l3w9aF8OG6BcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA7380DBDF;
	Wed, 15 Oct 2025 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] net: deal with sticky tx queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176056081425.1041854.4109161900916715208.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 20:40:14 +0000
References: <20251013152234.842065-1-edumazet@google.com>
In-Reply-To: <20251013152234.842065-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 15:22:30 +0000 you wrote:
> Back in 2010, Tom Herbert added skb->ooo_okay to TCP flows.
> 
> Extend the feature to connected flows for other protocols like UDP.
> 
> skb->ooo_okay might never be set for bulk flows that always
> have at least one skb in a qdisc queue of NIC queue,
> especially if TX completion is delayed because of a stressed cpu
> or aggressive interrupt mitigation.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] net: add SK_WMEM_ALLOC_BIAS constant
    https://git.kernel.org/netdev/net-next/c/6ddb811a579f
  - [v1,net-next,2/4] net: control skb->ooo_okay from skb_set_owner_w()
    https://git.kernel.org/netdev/net-next/c/d365c9bca35c
  - [v1,net-next,3/4] net: add /proc/sys/net/core/txq_reselection_ms control
    https://git.kernel.org/netdev/net-next/c/2ddef3462b3a
  - [v1,net-next,4/4] net: allow busy connected flows to switch tx queues
    https://git.kernel.org/netdev/net-next/c/4a7708443dec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



