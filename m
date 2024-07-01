Return-Path: <netdev+bounces-108040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453991DA8B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283332831D5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371A128372;
	Mon,  1 Jul 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxi0804y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6B127B57
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823830; cv=none; b=AkLFf4Way8G7dp+NPJg/IlzQAFdyDYX81IoLjCyvQpK+umcGF3rakaecKTT82VhBA4B7TW2Yqpggf58StmM1TFCxDbQXkglwbRcpA3Ghqrq5kPmCV8f/sRpoH8XM4yIBu2Y99Xfjr4y4xUCbNfqTJYca6u9wZeXcF/OrTHssZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823830; c=relaxed/simple;
	bh=rSzOTwsNNEgho/LkPfo28qXnTfaF1FP8LpvsDqfwz1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eRnoXRGn2cgXi63JGzju8m6G/74l19LL69jacUefM3Jy9qyfNWx2m9xWGNJMcd2HZfqf578for9sFH/7VmV6M+qKZo7oVFi2xe1+EpTnni5w70pZX03yhlYmHlFbef0UHMVsgOyW9TQ5wPn0BNFsc7mv8EQFBdNQ/xNxRzX0Ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxi0804y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84CDAC4AF11;
	Mon,  1 Jul 2024 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719823830;
	bh=rSzOTwsNNEgho/LkPfo28qXnTfaF1FP8LpvsDqfwz1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yxi0804yZWJNi/1Z2mfi/+GAMdtYJT5Ib/TE89B9bY3lbBrgJeW2z2KT13hG95HSM
	 L9Uq3qaHBQv5bEVHSIiUrOWnt5tL1lSp6kv5j++MRhtAm1eGNJ60f8YgnoYqY7QA72
	 ckwHMRPcEY8YiDAT38Hei36/JG8EpwBVHzRlrV/lOu2DCSi5fSP9VbpbkYOJ+Lr6Lz
	 +opNoN/CYYwINQpHMa3RKXNJmEyQA88QKPC7wYVf0KDXh53So1xDmAypSy7uPOQQYY
	 j1k+L4akVuYLY55ixEu0GHx9RkgoXq+lK/5w6FvMbFMIhwhwpIizPAmG/gxGWOjmX+
	 W70cj+oVHMk8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B8B0DE8DE2;
	Mon,  1 Jul 2024 08:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] tcp_metrics: add netlink protocol spec in
 YAML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982383050.18736.4428619199553157199.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 08:50:30 +0000
References: <20240627213551.3147327-1-kuba@kernel.org>
In-Reply-To: <20240627213551.3147327-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jun 2024 14:35:49 -0700 you wrote:
> Add a netlink protocol spec for the tcp_metrics generic netlink family.
> First patch adjusts the uAPI header guards to make it easier to build
> tools/ with non-system headers.
> 
> v1: https://lore.kernel.org/all/20240626201133.2572487-1-kuba@kernel.org
> 
> Jakub Kicinski (2):
>   tcp_metrics: add UAPI to the header guard
>   tcp_metrics: add netlink protocol spec in YAML
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tcp_metrics: add UAPI to the header guard
    https://git.kernel.org/netdev/net-next/c/7c8110057b1b
  - [net-next,v2,2/2] tcp_metrics: add netlink protocol spec in YAML
    https://git.kernel.org/netdev/net-next/c/85674625e0bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



