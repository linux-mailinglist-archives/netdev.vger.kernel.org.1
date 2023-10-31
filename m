Return-Path: <netdev+bounces-45479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BC7DD6FE
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 21:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF36A1C20836
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F10225A0;
	Tue, 31 Oct 2023 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inZ8SJJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2422335
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 20:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 602D0C433C9;
	Tue, 31 Oct 2023 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698783625;
	bh=r4GSgxCLPslrTIkjJClBOn1w9GUR5G13O00H8t/gIko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=inZ8SJJHVBi8yJH5ZHrvPn5iy91X2IM18gJGf0H4iuaTRYS9maU7xGQQR3B8Q2VsB
	 K+Xu21X5yd319pLvPc0iltyxKj825GTwAmeARR7FqmNU0M6FH59UKoxFpZgxNsyrCQ
	 PJVXwOm3H1Ss6wYB+xSiy3s6wy2q++RLY7QNTWK6kxYtmAncM6QWSEH2LWctng5FXR
	 fgXhj5oPs0r3lgSOS9t5hBFTqHsOObdZNcuAk1awyJReLaPXjAw/i7m5j1MQxVaTAS
	 Ozj6TOIAPO3an3Gug05H63EU7fEBFcPbUSfl2/t+a76hPg22eTjKM1ydK02eznispP
	 FHnO0OZ41rOyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4836BC395FC;
	Tue, 31 Oct 2023 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] xfrm: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169878362529.17696.13693805875852994206.git-patchwork-notify@kernel.org>
Date: Tue, 31 Oct 2023 20:20:25 +0000
References: <20231028084328.3119236-2-steffen.klassert@secunet.com>
In-Reply-To: <20231028084328.3119236-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Sat, 28 Oct 2023 10:43:19 +0200 you wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> 
> commit a269fbfc4e9f ("xfrm: state: remove extract_input indirection from xfrm_state_afinfo")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [01/10] xfrm: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/5fa4704d14b2
  - [02/10] xfrm: Annotate struct xfrm_sec_ctx with __counted_by
    https://git.kernel.org/netdev/net-next/c/1d495f1c896c
  - [03/10] xfrm: Use the XFRM_GRO to indicate a GRO call on input
    https://git.kernel.org/netdev/net-next/c/b439475a0dba
  - [04/10] xfrm: Support GRO for IPv4 ESP in UDP encapsulation
    https://git.kernel.org/netdev/net-next/c/172bf009c18d
  - [05/10] xfrm: Support GRO for IPv6 ESP in UDP encapsulation
    https://git.kernel.org/netdev/net-next/c/221ddb723d90
  - [06/10] xfrm: pass struct net to xfrm_decode_session wrappers
    https://git.kernel.org/netdev/net-next/c/2b1dc6285c3f
  - [07/10] xfrm: move mark and oif flowi decode into common code
    https://git.kernel.org/netdev/net-next/c/45f87dd6b309
  - [08/10] xfrm: policy: replace session decode with flow dissector
    https://git.kernel.org/netdev/net-next/c/7a0207094f1b
  - [09/10] xfrm Fix use after free in __xfrm6_udp_encap_rcv.
    https://git.kernel.org/netdev/net-next/c/53a5b4f2ea85
  - [10/10] xfrm: policy: fix layer 4 flowi decoding
    https://git.kernel.org/netdev/net-next/c/eefed7662ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



