Return-Path: <netdev+bounces-31540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71F78EA3A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1141C209FB
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2E8462;
	Thu, 31 Aug 2023 10:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559388F5C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3C53C433CA;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693477823;
	bh=TzZ5Q4pziCdF1IoPZ8QrxwL8VLGcfCPZJSZ35wnHDbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2Hn0Ut50hDu0RiJXhSYGTUVJXeyVfZIr9yg45N4XljyAr9i4l/ZpsmaiC/cmYmfP
	 FxNYA+ImKxNQCN6PiTREDWKS5hYMd3QK8F2+4egTlLC+vP3sTLUgEhunSSBBgNDWkI
	 Z/sTUNJqR4HRkYxoy2P/X1iHoynREPsqDfGqKFou+euE/7f0EE1KhhYBxZeZgXVePf
	 lWnLp6D2gUP0oIzXnZnt7a1HDu8LtTCSItywbrieRdPhXZBKoMPJsyfVdFz95kjY/r
	 Q9pCAvuXob83eIg88hfbTuDpmy1+DEQfeRjKfX0QS53YofOu2j6xaKJmbncB3GQSW/
	 XS9XxarRgUGhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB3C2E29F33;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169347782376.15498.4618133245837952961.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 10:30:23 +0000
References: <20230830094519.950007-1-edumazet@google.com>
In-Reply-To: <20230830094519.950007-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Aug 2023 09:45:19 +0000 you wrote:
> sk->sk_wmem_queued can be read locklessly from sctp_poll()
> 
> Use sk_wmem_queued_add() when the field is changed,
> and add READ_ONCE() annotations in sctp_writeable()
> and sctp_assocs_seq_show()
> 
> syzbot reported:
> 
> [...]

Here is the summary with links:
  - [net] sctp: annotate data-races around sk->sk_wmem_queued
    https://git.kernel.org/netdev/net/c/dc9511dd6f37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



