Return-Path: <netdev+bounces-44480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195B7D8399
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC91C20F2D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91C2E3E8;
	Thu, 26 Oct 2023 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBZHsqFo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9C2E3E4
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C1A5C433C9;
	Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698327026;
	bh=tp2S4Ih/c/YzjAmSE40jDtMAIOA6AA3irtN430hTP9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uBZHsqFoLGh1W2bIwxkVd+vsr83TDvb2YXzSbh3CyruCkzx2pRJjVFThCVq49jhR1
	 WPK5HEn42OLfD0odi1y+0Ga7fc5qP2/en/AYl5w4Bb4N82dT21u4BvVzCB5TrOcgeg
	 7KwoRew241p+wMj3A3dCzVDFtbOKzzxgAbJbp1EtDkdquzbNYJ4l+nsWVVkl5G8gEj
	 LFabeYMinaOrf3bzl5CdAqyq33H/rMmiUNHpmzzBNmRtHWTK4rLdmC3oeGMZoLlwk1
	 Jm0PCee0jlIuymSBXYYtNqKs/Dxd6W1NM5kAk5Ec8yK/8uCfsf5rwGeTEw2u0OdpUz
	 GUQCaSwrAidmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EEADE11F57;
	Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/19] netfilter: nft_set_rbtree: rename gc
 deactivate+erase function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832702645.29524.15070556170397760167.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 13:30:26 +0000
References: <20231025212555.132775-2-pablo@netfilter.org>
In-Reply-To: <20231025212555.132775-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de

Hello:

This series was applied to netdev/net-next.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed, 25 Oct 2023 23:25:37 +0200 you wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> Next patch adds a cllaer that doesn't hold the priv->write lock and
> will need a similar function.
> 
> Rename the existing function to make it clear that it can only
> be used for opportunistic gc during insertion.
> 
> [...]

Here is the summary with links:
  - [net-next,01/19] netfilter: nft_set_rbtree: rename gc deactivate+erase function
    https://git.kernel.org/netdev/net-next/c/8079fc30f797
  - [net-next,02/19] netfilter: nft_set_rbtree: prefer sync gc to async worker
    https://git.kernel.org/netdev/net-next/c/7d259f021aaa
  - [net-next,03/19] netfilter: nf_tables: Open-code audit log call in nf_tables_getrule()
    https://git.kernel.org/netdev/net-next/c/8877393029e7
  - [net-next,04/19] netfilter: nf_tables: Introduce nf_tables_getrule_single()
    https://git.kernel.org/netdev/net-next/c/1578c3287719
  - [net-next,05/19] netfilter: nf_tables: Add locking for NFT_MSG_GETRULE_RESET requests
    https://git.kernel.org/netdev/net-next/c/3cb03edb4de3
  - [net-next,06/19] br_netfilter: use single forward hook for ip and arp
    https://git.kernel.org/netdev/net-next/c/ee6f05dcd672
  - [net-next,07/19] netfilter: conntrack: switch connlabels to atomic_t
    https://git.kernel.org/netdev/net-next/c/643d12603664
  - [net-next,08/19] netfilter: nf_tables: Drop pointless memset in nf_tables_dump_obj
    https://git.kernel.org/netdev/net-next/c/ff16111cc10c
  - [net-next,09/19] netfilter: nf_tables: Unconditionally allocate nft_obj_filter
    https://git.kernel.org/netdev/net-next/c/4279cc60b354
  - [net-next,10/19] netfilter: nf_tables: A better name for nft_obj_filter
    https://git.kernel.org/netdev/net-next/c/ecf49cad8070
  - [net-next,11/19] netfilter: nf_tables: Carry s_idx in nft_obj_dump_ctx
    https://git.kernel.org/netdev/net-next/c/2eda95cfa2fc
  - [net-next,12/19] netfilter: nf_tables: nft_obj_filter fits into cb->ctx
    https://git.kernel.org/netdev/net-next/c/5a893b9cdf6f
  - [net-next,13/19] netfilter: nf_tables: Carry reset boolean in nft_obj_dump_ctx
    https://git.kernel.org/netdev/net-next/c/a552339063d3
  - [net-next,14/19] netfilter: nft_set_pipapo: no need to call pipapo_deactivate() from flush
    https://git.kernel.org/netdev/net-next/c/26cec9d4144e
  - [net-next,15/19] netfilter: nf_tables: set backend .flush always succeeds
    https://git.kernel.org/netdev/net-next/c/6509a2e410c3
  - [net-next,16/19] netfilter: nf_tables: expose opaque set element as struct nft_elem_priv
    https://git.kernel.org/netdev/net-next/c/9dad402b89e8
  - [net-next,17/19] netfilter: nf_tables: shrink memory consumption of set elements
    https://git.kernel.org/netdev/net-next/c/0e1ea651c971
  - [net-next,18/19] netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
    https://git.kernel.org/netdev/net-next/c/078996fcd657
  - [net-next,19/19] netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx
    https://git.kernel.org/netdev/net-next/c/9cdee0634769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



