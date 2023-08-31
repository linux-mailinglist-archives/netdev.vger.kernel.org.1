Return-Path: <netdev+bounces-31538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A452B78EA37
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E90F280DBB
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33C63CC;
	Thu, 31 Aug 2023 10:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E958F5D
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9AF0C433C7;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693477823;
	bh=lcdyCame1K6Cpq/Z9tvWP/+Yb4WyfJASA5xnc1tbzFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CZDi3aZYeiVbR0U9vUwRcGzOc140WDZft9QNb1B4cA4qzWyqO8+y3fbGo77GMsYkM
	 aQklS03l5Jv5mcfzGpqJcop9fa5mbvEM4S4zGHhjIfTmIq0AtZQ63sIY7+Zim4nbFz
	 LhcmaCuINpDacalwKbvN9QLQm/h00oSne8pOHNxvFrjtYGIc9cBqlwYgVaOoqzKOch
	 Qo26Kj5sv6CNaazgFDobEy+ZEfkEEC5D8bp2ixRVtb5rZnwYGYxuLpu9T/d8HIo+Qk
	 HtxmG7DAFwBEmEFARMg/1En2yTHlsLBv1Ql/a7cRHJK6dsZzgEl7Hu+sclAXCtDzH+
	 Z9pmHY+3xMG1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B126BE29F34;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: annotate data-races around fi->fib_dead
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169347782372.15498.17752645687758449604.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 10:30:23 +0000
References: <20230830095520.1046984-1-edumazet@google.com>
In-Reply-To: <20230830095520.1046984-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Aug 2023 09:55:20 +0000 you wrote:
> syzbot complained about a data-race in fib_table_lookup() [1]
> 
> Add appropriate annotations to document it.
> 
> [1]
> BUG: KCSAN: data-race in fib_release_info / fib_table_lookup
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: annotate data-races around fi->fib_dead
    https://git.kernel.org/netdev/net/c/fce92af1c29d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



