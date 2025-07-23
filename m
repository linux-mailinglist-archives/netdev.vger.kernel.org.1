Return-Path: <netdev+bounces-209159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA36B0E81A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5701C8860C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632881B87E9;
	Wed, 23 Jul 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMFmQA/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A51A4F3C;
	Wed, 23 Jul 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234219; cv=none; b=Hrib2EJt+MhhcCpD9hN/TchtVCjwKHdmh0AoPX0jx7PIi8QTlIpNpCRGlSnQvq1mx/lveNR0AMDr1ccx9I7CZq6KyjdklZ+uYBGfMtvENOyU0y1GIDHwnChL+tck/+PdzLegL6+tqKXsLjJyOlCQ06SsPQennMGNJ+phxsihEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234219; c=relaxed/simple;
	bh=IZ4nWfDXHA9JxsyQg6ERpoS0dG2FhhBiten7oPTuzXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=InuRV53p/rv7FW2DCVZQQD0TAqZBChVWRVFC/WTnfAkCwIrtl8ZPS7ClYQr8hnHMBfqIyQQaJIg055GgmAkqFELeFf1o+iR2h8vveVgAvUHOlq0i/Bb19LcGi1jHnGlpdriNaGGgm4UWgRFEox5U4JX7f1Jkdqoy5PtsVs51IaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMFmQA/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8DFC4CEEB;
	Wed, 23 Jul 2025 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234218;
	bh=IZ4nWfDXHA9JxsyQg6ERpoS0dG2FhhBiten7oPTuzXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nMFmQA/iR3+kxLvvea4ldB9z1M+lgINnmQos4GR2GQG/48GopTiCkWdr01gJXQnFo
	 BrsQWRxWoTddlFpQUduYWp0Cv+tEF7Px9XjodYRFrqQ8F1wZm26sXswhdWRKY9b5+J
	 KfpDy8dL971UNnqZjbzOubCH4c6KoXVW1ZD9wzrZsYB3l1Jfu9A1j1Yf1hNis9jSwk
	 zEcEWjL9wCQzF6MpHPpef3jKIg+Cyksp9j1SDm6ehBY5sw5w9g+RB+hC6kREYDmcyp
	 NKHwdvsyw3X0aHEfZxIdAPUB3yV3hh4BnV2IWv4Id7QAuZN+E26aWsoAU3moiTQe+t
	 O5gM0QNkui8Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA5383BF5D;
	Wed, 23 Jul 2025 01:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 =?utf-8?q?=5BPATCH_net-next_v7_RESEND=5D_tcp=3A_trace_retransmit_fa?=
	=?utf-8?q?ilures_in_tcp=5Fretransmit=5Fskb?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323423699.1016544.6003435130769991135.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:36 +0000
References: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
In-Reply-To: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
To:  <fan.yu9@zte.com.cn>
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn,
 jiang.kun2@zte.com.cn, qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn,
 he.peilin@zte.com.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Jul 2025 11:16:07 +0800 (CST) you wrote:
> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> Background
> ==========
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
> 
> [...]

Here is the summary with links:
  - [net-next,v7,RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
    https://git.kernel.org/netdev/net-next/c/ad892e912b84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



