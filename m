Return-Path: <netdev+bounces-37489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C967B5A48
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7B4C42829DD
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2C1EA9D;
	Mon,  2 Oct 2023 18:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EA1EA8C;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0136C433C7;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696272030;
	bh=UV9QeO2eUsWxPfUTEhIPFDbW+ZsPP9uBROySkLMm6WY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NmheTg+Pbz2sHwigFT80jEFLdtK/7lEz3/CeKzCeB+q7elJhLqYkyETjViMFc/Uaw
	 kKCNpCaAFc4hnjTpev5zWa8zekc4zJZ0QJkJA+YMOv4gpROcYRngTgUYQ+6vaBgq4n
	 iRpLJpIs/cfGXOuewBy7GoxKjLX77XQ9AMPV/MITd2P8vJKpC2j9fx6iUHL9kR1qpJ
	 tgIprk9eX6F62MfbxePbkZ+k4rC+uBPdQpMl7zXdETZijcSIjf/RGQvqnEgn8BDAii
	 azhsoFlrMWPq1F+K4njlEmSBxg6cZpBHsmBOm/JbdCRP8qc7+jmAab/jPH4Q/cVk+O
	 JlPWMB/+nfORQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 928C6C395C5;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] mlxsw: Annotate structs with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169627203059.11990.1243800738958439683.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 18:40:30 +0000
References: <20230929180611.work.870-kees@kernel.org>
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Sep 2023 11:07:39 -0700 you wrote:
> Hi,
> 
> This annotates several mlxsw structures with the coming __counted_by attribute
> for bounds checking of flexible arrays at run-time. For more details, see
> commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> [...]

Here is the summary with links:
  - [1/5] mlxsw: Annotate struct mlxsw_linecards with __counted_by
    https://git.kernel.org/netdev/net-next/c/0b7ed8183375
  - [2/5] mlxsw: core: Annotate struct mlxsw_env with __counted_by
    https://git.kernel.org/netdev/net-next/c/c63da7d62893
  - [3/5] mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with __counted_by
    https://git.kernel.org/netdev/net-next/c/f7ebae83768f
  - [4/5] mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/4d3a42ec5cff
  - [5/5] mlxsw: spectrum_span: Annotate struct mlxsw_sp_span with __counted_by
    https://git.kernel.org/netdev/net-next/c/18cee9da32cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



