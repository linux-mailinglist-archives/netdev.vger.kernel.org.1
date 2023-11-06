Return-Path: <netdev+bounces-46163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CDD7E1CDD
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB132812B0
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1D156E1;
	Mon,  6 Nov 2023 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUKS6iTo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D8156CB
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91125C433B9;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699261225;
	bh=YtuMPCn6ErOXWQoBxP3LOGLm5xJrHRGf6xLKjAte3AQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUKS6iToVYe899BvwIbZ12L5etoSX0QAttfJaJ3yyXgfkpBluZBkNTrAuFZw/gsWJ
	 aJQPhKOwtuCfXQ6VKRBxXsyE5ycPccuyJVQ6WrfBBTD2OS0rNiEPA8jLT9vBrYq33q
	 e9LAFVbDPfuy1vbNMHXyLJnfX9TWvSrPVdtNYPdFONZBpfJbsqt62/8OwFpefBk8X5
	 wkrgLcigoWFp2+sGtmjRl1eV2tchxPhsmFMCvm6CoWW68gkbCw//RnsAc3mpVmh1jj
	 LYwqcTJCLflYRPqs1RrcC8M9kHCE8FjYDuwMwdcTLnlL8eGRf8tY2iGkWHLkBReOpR
	 mAuXYMw+H6m+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 766EAE00088;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix SYN option room calculation for TCP-AO.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169926122548.1218.5954506176074367350.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 09:00:25 +0000
References: <20231102210548.94361-1-kuniyu@amazon.com>
In-Reply-To: <20231102210548.94361-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, noureddine@arista.com,
 0x7f454c46@gmail.com, fruggeri@arista.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 2 Nov 2023 14:05:48 -0700 you wrote:
> When building SYN packet in tcp_syn_options(), MSS, TS, WS, and
> SACKPERM are used without checking the remaining bytes in the
> options area.
> 
> To keep that logic as is, we limit the TCP-AO MAC length in
> tcp_ao_parse_crypto().  Currently, the limit is calculated as below.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix SYN option room calculation for TCP-AO.
    https://git.kernel.org/netdev/net/c/0a8e987dcc13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



