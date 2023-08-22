Return-Path: <netdev+bounces-29499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33078384E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234DE280F88
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BBC111F;
	Tue, 22 Aug 2023 03:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92E7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFCEC433C8;
	Tue, 22 Aug 2023 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692673823;
	bh=MqMjNGXXKE+fnG8FGeTFISuoCtqfCuM1rjajbejYzzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tWE8qg5xyqnDrMUIACOj5EhA7whUDPYtDQ2C14P5v/LknPK1Pk9d2/71IlydbuHF6
	 DMkqCrxQFWLRDpK+Alg/0OYV2LqxiLBqrDKLuQXw0qBheR/F9pEbbRZ8zIipkJR4dj
	 cl8dKFgP5rIEbMP195kRSjof9TXkPrVJ23/ZbIYvCTVgpQzeXg7rPVJ7T4+JP8VNJJ
	 TSdYdaqMrH6zNeDDqrb4BsXMGQQUFTyNj0G20LfBzxHkwq3RXFV16SrdXjAoA69JoF
	 zXKT4G9wTgZiSiGV2eRigq6SLr4IV1GgurFKNyzn9nQyzoDeOst2DQms9e13rjGgEs
	 1toYkdh5ac2Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D00B0E4EAFB;
	Tue, 22 Aug 2023 03:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tg3: Use slab_build_skb() when needed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169267382284.21798.14870275848532968526.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 03:10:22 +0000
References: <20230818175417.never.273-kees@kernel.org>
In-Reply-To: <20230818175417.never.273-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: siva.kallam@broadcom.com, f.ebner@proxmox.com, prashant@broadcom.com,
 mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bagasdotme@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Aug 2023 10:54:21 -0700 you wrote:
> The tg3 driver will use kmalloc() under some conditions. Check the
> frag_size and use slab_build_skb() when frag_size is 0. Silences
> the warning introduced by commit ce098da1497c ("skbuff: Introduce
> slab_build_skb()"):
> 
> 	Use slab_build_skb() instead
> 	...
> 	tg3_poll_work+0x638/0xf90 [tg3]
> 
> [...]

Here is the summary with links:
  - tg3: Use slab_build_skb() when needed
    https://git.kernel.org/netdev/net/c/99b415fe8986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



