Return-Path: <netdev+bounces-104014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F590ADD1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9B5280DCF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90521957E3;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIbXTXr+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB51953AF
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626830; cv=none; b=IoWOrU30I9LeB3UmrUezTV43cITQKMesKL0xSXDZQzOQfSK8WyE98e1+MQ4jkyfn2yoLvyEPjY/hd7vHykHdrZ4UskKAXBoIkfFcFIo1cEgnj6Xc36ICOiuRAwqmUzZB6imJ7tnm1JIco24f0aJGEc67z6bKdquYOBC6Sj4iHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626830; c=relaxed/simple;
	bh=SUwnS/Pvz87n+pc74eWGZSEKXgNjxm7ilzISf1ud+co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o8ufOibh22ER9aTlIrDAPsUpclQoEjlfiKhyIZZuSamxR5vA0ZjNhAiixcQKPuvMv72ZCzw5MQvhWdrZllTolX6Zzrf3FGlydND8/sbllSDNTtzba6sqinkUBTxvBcM6DEY9MkYALYN4TTQ9c9SyHbRTVIx3GueN1wu2QCw8cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIbXTXr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C9D3C4AF49;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626830;
	bh=SUwnS/Pvz87n+pc74eWGZSEKXgNjxm7ilzISf1ud+co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VIbXTXr+n8/2Bf/lbdJUx7DxiVt2MmjBD5F2MC8Mak+k2rAFjcuVJNBa9bAnotHJi
	 CFB/KJQUtGZhrFVnqPGYOF4DsFtu2QhXFcXzn7qKBHFZ3BKapqjAFFsJ308fbPm5uV
	 7aq5krw8ekcPyG0JkeY0coac50dhQ3aDZGkcTQZrCQr0VIqMbZR22W3rXSkSfkM+rv
	 gaxbuZv0kxO4Qt2IJUF/EpK39Dgq2I7f4D0fb9grADDmzQ6/XOYyFyaySBr+i2XxDP
	 4NsIRFuc6wsTq/nrXg1y9aVPQb89DznMfzYaEEeqoLmMWS67VM1a2AKxgR0Ui1NO/a
	 K2gIXm3oJZbNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C471C54BA0;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: make for_each_netdev_dump() a little more
 bug-proof
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171862683037.300.18122366052098634825.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 12:20:30 +0000
References: <20240613213316.3677129-1-kuba@kernel.org>
In-Reply-To: <20240613213316.3677129-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jun 2024 14:33:16 -0700 you wrote:
> I find the behavior of xa_for_each_start() slightly counter-intuitive.
> It doesn't end the iteration by making the index point after the last
> element. IOW calling xa_for_each_start() again after it "finished"
> will run the body of the loop for the last valid element, instead
> of doing nothing.
> 
> This works fine for netlink dumps if they terminate correctly
> (i.e. coalesce or carefully handle NLM_DONE), but as we keep getting
> reminded legacy dumps are unlikely to go away.
> 
> [...]

Here is the summary with links:
  - [net-next] net: make for_each_netdev_dump() a little more bug-proof
    https://git.kernel.org/netdev/net-next/c/f22b4b55edb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



