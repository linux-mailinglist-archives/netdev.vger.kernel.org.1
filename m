Return-Path: <netdev+bounces-47333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156927E9AC6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1E9280CE1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC21CA94;
	Mon, 13 Nov 2023 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utTQ57/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF81CA88
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D12AC433CC;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873824;
	bh=ExY8ABX+iV1daP2D0jLDdL7Fvhf76TXH+N7JEGyRTRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=utTQ57/7tis1IBrFNvNhsfTp8PD2nGin4E3EZxjUcgTEUlGlmZXTsOlx34/fl80Lz
	 yAZG7Oyqi2x5UIdUVf+UxVBbYn9H9PvA4SpY/ATQBZgxCb98EjU0g7ALaZ09tOslY/
	 gf5wYeZBKTijG6uoAG1Bsi7mR9agqcErfzvcFI0ySG/4mSbY/UAIIZ3LeDG4WLnVph
	 qkCXI7tnTwRpddt5wHt1pIzCCvBwiCIw97ThPLhnc9NByj0vFKDgGiPx7XaMgIBBQd
	 CxvMneHmCLbqwvHdrBJXleCKa5KmHIUAgn91R+khUKFx2SSapqPuoIIbaSsyiaLaSV
	 IsLBEdHFld3yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A69BC04DD9;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: limit MRU to 64K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169987382443.356.16944997528877845349.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 11:10:24 +0000
References: <20231113031705.803615-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231113031705.803615-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-ppp@vger.kernel.org,
 stable@vger.kernel.org, mitch@sfgoth.com, mostrows@earthlink.net,
 jchapman@katalix.com, willemb@google.com,
 syzbot+6177e1f90d92583bcc58@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 12 Nov 2023 22:16:32 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> ppp_sync_ioctl allows setting device MRU, but does not sanity check
> this input.
> 
> Limit to a sane upper bound of 64KB.
> 
> [...]

Here is the summary with links:
  - [net] ppp: limit MRU to 64K
    https://git.kernel.org/netdev/net/c/c0a2a1b0d631

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



