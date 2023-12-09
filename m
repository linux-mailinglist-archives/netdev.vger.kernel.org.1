Return-Path: <netdev+bounces-55512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B639A80B16D
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD4F1C20D66
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45D810;
	Sat,  9 Dec 2023 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XslYQBbC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D680E
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B90C43391;
	Sat,  9 Dec 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702085424;
	bh=OUXQXRNrn0qruMAxko1OUePwJGDkB2lJwccaep8maLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XslYQBbC1CPdqqCn0nUY88KZkXh+1fV/G0sFvI8YL0FFxctAgIzNkG2gcACBXUQye
	 zlQ9rEs4j72phbxXYIP7NTY56NRhaqKAJ2eyTyuMw/QpMi6jBr44cu4WTJz1Z5hqSU
	 7ki5iD62CjDuNwczoCnTMH0MeMlHpU+/kkFGbalvW9Y1rZ9yfdSMmTy4oIrs9slqQB
	 mzMGn6+eleF8iIUeTH4ldNWLdrTdEA/InrFOtP67Lzt3cRYnKzExk0IrDDRChfV2RB
	 5d/2Yq8ctAb7HPKpy2w8Fken5iFe3khK9/ksGBhvL5er1v1kJP3vHwO1pxPFock6iZ
	 urpHe6sRF8YNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5B60DD4F1E;
	Sat,  9 Dec 2023 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: do not check fib6_has_expires() in
 fib6_info_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208542393.22393.12653821622545796367.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:30:23 +0000
References: <20231207201322.549000-1-edumazet@google.com>
In-Reply-To: <20231207201322.549000-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com, thinker.li@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 20:13:22 +0000 you wrote:
> My prior patch went a bit too far, because apparently fib6_has_expires()
> could be true while f6i->gc_link is not hashed yet.
> 
> fib6_set_expires_locked() can indeed set RTF_EXPIRES
> while f6i->fib6_table is NULL.
> 
> Original syzbot reports were about corruptions caused
> by dangling f6i->gc_link.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: do not check fib6_has_expires() in fib6_info_release()
    https://git.kernel.org/netdev/net-next/c/a3c205d0560f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



