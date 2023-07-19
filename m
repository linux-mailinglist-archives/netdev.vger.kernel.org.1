Return-Path: <netdev+bounces-19000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E675947F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C001C20F40
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3914A92;
	Wed, 19 Jul 2023 11:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E414274
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C881C433C8;
	Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766820;
	bh=O7KE6QURVyG2deYSiL5ojlS/R2PfvC0hv2Gs+IrY7Rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SM9HlMi7I0VLwP3EQW15edoyGCWkpKwaeHJi4bIXhmZkYQcIDjBgHb/7Jak7n5bFS
	 CyCkOqV4zi2haiMnI+3xG1kIKn96Zv5YFgLp4A1N6ikTxWt75ZT2e5MPKiuw0xdGk9
	 fLwyr40vmJKeBNs0L5MRrwKptRLsxuTI0PpgiY5EUocQq5QSbtEn1FWTM9Zx629fYG
	 TONpweJHqoRh9hI4LJeo4Hldz+pOrVKPnSPLk/AA34esMprz2YvgGo3CD4xVkev4e2
	 R5G509oCwCJAkVR6irYLIr4rCqQ2CMQ7qRNyPR1/9Dw7gNZyCeqitfgWTfl3ET7+8d
	 GUNvmoG0K+Q7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A891E21EFA;
	Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: Remove more RTO_ONLINK users.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976682016.23748.15879521041642434800.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:40:20 +0000
References: <cover.1689600901.git.gnault@redhat.com>
In-Reply-To: <cover.1689600901.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, pablo@netfilter.org,
 laforge@gnumonks.org, osmocom-net-gprs@lists.osmocom.org,
 dccp@vger.kernel.org, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 linux-sctp@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 15:53:24 +0200 you wrote:
> Code that initialise a flowi4 structure manually before doing a fib
> lookup can easily avoid overloading ->flowi4_tos with the RTO_ONLINK
> bit. They can just set ->flowi4_scope correctly instead.
> 
> Properly separating the routing scope from ->flowi4_tos will allow to
> eventually convert this field to dscp_t (to ensure proper separation
> between DSCP and ECN).
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] gtp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/b16b50476714
  - [net-next,2/3] dccp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/2d6c85ca3eb8
  - [net-next,3/3] sctp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/ba80e20d7f3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



