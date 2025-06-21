Return-Path: <netdev+bounces-199981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B766BAE29BA
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E54D189B7DB
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318761E25F2;
	Sat, 21 Jun 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMyNLCaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5B13C81B
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750518590; cv=none; b=KEx4OB6LZslkr5WD37bprLWv6GTbLCkemmDh9LV+87WFNlqZYAQK3NjY8AEMcknJ+Xk0S3VAo3LmopmVFkN5DOdzA9tEgoVldXA+epQk5RDKVNxy4T+uk2RRhK882+o8Iv6bgmr5zaUm0mmgYNsq8OYV1wq01cPBYUHik6A1/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750518590; c=relaxed/simple;
	bh=ub3bLoW+5hucyfRprq/tyOjgIp0n5wDvFniCqfFs+LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RMMuCYCIGrq+4z2KSoAkHAHRUBzeaysMvVYjQ8rxCcizvEKx8YnQvjODzXLpXi/fjf0VIHTCw4EASYnzt7HUZq1n8wkuELWzCV7+d4D07oBcmDJqsfKKA1xjPmTKf2o5XDumhDt4uJcs5MrsDA09fxywat9mDolORv/oClRgObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMyNLCaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F88AC4CEE7;
	Sat, 21 Jun 2025 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750518589;
	bh=ub3bLoW+5hucyfRprq/tyOjgIp0n5wDvFniCqfFs+LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BMyNLCaZgdFYlfkUvO7v7xWRf0eN53xuV3stV3AEr2inik5ZPZighg6p/bYk0eaUU
	 9fLnY3BUE6BBbn2UZNwPjFR5feBjI47VJl5B+Ywz5PrjXSY+LilDfQO7PlOjuc0/9T
	 Dq2H0+fdKFK0Td6KxoaoFD4VAUtzmfKZ5Budn0oA15W8H+JMB4bRn7ktsdEA0CPVr2
	 Xg6LBQNqmhR5j5HaDjk/17B0De//8FzyTrGTktvobTI0CIKsPRnts2fK6OUXqMfrez
	 OEJS6/FJqrG7fx6f7RhuWZUwZ82R29jBeE0uh/TZhUHW+Xs9iIiNPOQOnqVVG3S40v
	 po5bZCYtbsW6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6F38111DD;
	Sat, 21 Jun 2025 15:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] eth: bnxt: add netmem TX support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051861726.1879824.14551996400445539238.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:10:17 +0000
References: <20250619144058.147051-1-ap420073@gmail.com>
In-Reply-To: <20250619144058.147051-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, almasrymina@google.com,
 praan@google.com, shivajikant@google.com, asml.silence@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 14:40:58 +0000 you wrote:
> Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> By this change, all bnxt devices will support the netmem TX.
> 
> Unreadable skbs are not going to be handled by the TX push logic.
> So, it checks whether a skb is readable or not before the TX push logic.
> 
> netmem TX can be tested with ncdevmem.c
> 
> [...]

Here is the summary with links:
  - [v3,net-next] eth: bnxt: add netmem TX support
    https://git.kernel.org/netdev/net-next/c/4922ca773d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



