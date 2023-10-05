Return-Path: <netdev+bounces-38160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FC7B994E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17E25281CFE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A65EA2;
	Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRD6lOse"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA7627
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7C9DC433CA;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696466427;
	bh=yuoZk5SdP8+64pTgp5xHlFuJzKfqFdHivOlTD6uo9c0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YRD6lOsedoXdXnhmckMQ7DLwd0yW3VNU/6ToX/N8MsVlKQcnhSbEHSm2lLjxFCem8
	 KDrgzU9cbcJy9qUkIGJz9XkODMIZLB5vwniN4TgsRdU0hbOnuVun4zpn1sn0NsuORm
	 NYVUlKNGQV57nm8HkJ7zGo1jTn73eVrfw1ZlGR2/HfFuGWAwT3bHfWHAYp9vSXtC9s
	 wwGCwTm+DY3JApHaCVxZJEhpNn1kgwjKaWjxJqov7wR17CA6Vo4nvk264zwLeBLn/H
	 NiHOb1eRtg6XXeGlf8Sa0+/axABKPsVrIzX777tL7h1VYneMbJGs9oH8iglhoZgLDc
	 1W8JCfUL9R1Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A82CCC595D0;
	Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: annotate data-races around sk->sk_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646642768.7507.12024346736982930852.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:40:27 +0000
References: <20231003183455.3410550-1-edumazet@google.com>
In-Reply-To: <20231003183455.3410550-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 18:34:55 +0000 you wrote:
> syzbot caught another data-race in netlink when
> setting sk->sk_err.
> 
> Annotate all of them for good measure.
> 
> BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg
> 
> [...]

Here is the summary with links:
  - [net] netlink: annotate data-races around sk->sk_err
    https://git.kernel.org/netdev/net/c/d0f95894fda7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



