Return-Path: <netdev+bounces-39411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F697BF111
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0418E1C20B06
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40ED390;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJOVSFrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B33361
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6E1C433C7;
	Tue, 10 Oct 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906224;
	bh=7fTF8e3VNJFiLx6QzH692U0VqzP6aGLoTLwrm3W0BcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJOVSFrfLvl/cn2OkNwjQGgyQJ1I8Od8cgri1RAHSm2zoxi5oCAXmC/oR/eI3coRV
	 jzUcNP3S59WqPQU/tA+2VK+XVimvDKvduUFo3jsc4FsW0jbMAkXH22GJDAq6Awe4vX
	 lGfuGC04+66bgYOPt0b4XtuwIH9/jCruzzydyFJDpWpTlid8ma5IPghv3qxL6S22K3
	 fTtpOJMr+0AWcUL69I6KFUF6HNwelGWICk4GIYcRjyE3BdbiBWyVfGTj8m9xJ8QCPB
	 fWJTGibrLyYdLJ5/0QxjjL/l4bxb/8uu4HDu1+4PR36j1CDIh1GyQgF5Ki0RxUgJaM
	 5RAAJreouf1Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D3AE000A8;
	Tue, 10 Oct 2023 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: refine debug info in skb_checksum_help()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622385.548.17611363548112393339.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:23 +0000
References: <20231006173355.2254983-1-edumazet@google.com>
In-Reply-To: <20231006173355.2254983-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Oct 2023 17:33:54 +0000 you wrote:
> syzbot uses panic_on_warn.
> 
> This means that the skb_dump() I added in the blamed commit are
> not even called.
> 
> Rewrite this so that we get the needed skb dump before syzbot crashes.
> 
> [...]

Here is the summary with links:
  - [net] net: refine debug info in skb_checksum_help()
    https://git.kernel.org/netdev/net/c/26c29961b142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



