Return-Path: <netdev+bounces-38533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612C7BB56D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB081C20A5A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD63156E5;
	Fri,  6 Oct 2023 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0jVkRbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26714AB8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9361BC433C7;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696588824;
	bh=qhT0eu22PlmzUyLd3Q3ONTTIHsSkSo1eg3PLBdc04Pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0jVkRbcCcwAC080XpAbxw+p8baQfKEyCJuEaLh5YbXJTEPuJKBH88W0KoHd8xMdQ
	 PmhGjNvga4F9vzf8YfZ01c01yy4JWDITxqDXa9zk6ri21yxNgsdvBevubrVFkWEukU
	 SGwdC0+47VVylZPSFOOC7a8s7DmyaGhjGCbVov4LZUwwfELDepdOjxzEGe2Vg1bt9d
	 H5JzKOg9OOmDPdw5+odA1E+0wp/p63etp2TaaomZWz6LqFG2Ez9cOnSVC1cI508qVo
	 MndDh1xoAZHgc5bIV11QGzQIAL6sxPDt2wKhj4b4cCnJCox7QAMPJRFlpa0KKXR5Ky
	 dYbyMDsMYCGxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76065E22AE4;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: use uapi header name for the header
 guard
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658882447.10984.6284523867974344652.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:40:24 +0000
References: <20231003225735.2659459-1-kuba@kernel.org>
In-Reply-To: <20231003225735.2659459-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 15:57:35 -0700 you wrote:
> Chuck points out that we should use the uapi-header property
> when generating the guard. Otherwise we may generate the same
> guard as another file in the tree.
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: use uapi header name for the header guard
    https://git.kernel.org/netdev/net-next/c/71ce60d375f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



