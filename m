Return-Path: <netdev+bounces-29235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B513C782400
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25990280ED3
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3272185A;
	Mon, 21 Aug 2023 06:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368E15C2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0941FC433C8;
	Mon, 21 Aug 2023 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692600623;
	bh=BKbNtmchbJbsfYOE+Tfe0xo0Y4e4zK3UAuJ3zcgKBO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W75pJrvXqMliDNLOit/hw/UD7EvtQSyNwLyS1XR+b4ELLczHzKhU7LoSxUxEyUccf
	 THmegxJ7f8bhQKTo5f2v2jZiJQFQOU+AAwngsZ18UucWCo74zRPx12PkL1L7JIAJoi
	 QAp5uKcIIFqO3cV8OP2YrnchWNDQvAkqz+UIuoa+NVKnvYavn3p27bEVrViTwx0nHM
	 sfWf7Ps1kX6g3SzBrxpXg2yAwWchhnHLyprh3STwxlLyN+OxmQ+3zOK5H5KGzQxeAV
	 LYVdJfSvxEMOEJFUlJrrNR4HFII7MLdpwBynj3pGeq9QEJi2QM9fLbhYiQGBwJWHjI
	 GsL+/fmhRdqqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1537E4EAFD;
	Mon, 21 Aug 2023 06:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: annotate data-races around sk->sk_lingertime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169260062291.23906.193616591913842086.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 06:50:22 +0000
References: <20230819040646.389866-1-edumazet@google.com>
In-Reply-To: <20230819040646.389866-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Aug 2023 04:06:46 +0000 you wrote:
> sk_getsockopt() runs locklessly. This means sk->sk_lingertime
> can be read while other threads are changing its value.
> 
> Other reads also happen without socket lock being held,
> and must be annotated.
> 
> Remove preprocessor logic using BITS_PER_LONG, compilers
> are smart enough to figure this by themselves.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: annotate data-races around sk->sk_lingertime
    https://git.kernel.org/netdev/net-next/c/bc1fb82ae117

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



