Return-Path: <netdev+bounces-40660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F047C8304
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E10CB20B62
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAD79EB;
	Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgDbGUI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7412B71
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ED6BC433C9;
	Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697193025;
	bh=E+AM+8L+/+E2wAQz5uNrWwrsiv4KLURnmO46P96IoFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgDbGUI8Y0B8kl9oAatsuC7QOIVGRO6l6eSxhcRYr6dZ5JPbbsUD0OIv10tNAV83E
	 2whduj+oOLcDQdhaJly7VIagE1bzKxpI3+ZyfhXc5/V5qL1egtrvZXebuILaVbu2QU
	 b3DVmeKbzDmJ1gTwSrEwPC6tcdzMVMe3FErCEV9umho7K2GrE08CkRKa6OXlwH5BGD
	 2bkzkDvv4Ppo9vRuwq+ybdj3pvHRVHc+/74g0D/9+VvvK165Nfee7SFhXUF43MnZkY
	 2m4ZSFpj7/mri+kEQsikVvhIqRGMGNvKVbkkugHD+NJ21ypfeLo/VzhveTQhNoCY0g
	 nMKfVE/unBWzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E05CC691EF;
	Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] net: tls: various code cleanups and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169719302538.12798.6457177601639507185.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 10:30:25 +0000
References: <cover.1696596130.git.sd@queasysnail.net>
In-Reply-To: <cover.1696596130.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, gustavoars@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 22:50:40 +0200 you wrote:
> This series contains multiple cleanups and simplifications for the
> config code of both TLS_SW and TLS_HW.
> 
> It also modifies the chcr_ktls driver to use driver_state like all
> other drivers, so that we can then make driver_state fixed size
> instead of a flex array always allocated to that same fixed size. As
> reported by Gustavo A. R. Silva, the way chcr_ktls misuses
> driver_state irritates GCC [1].
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] tls: get salt using crypto_info_salt in tls_enc_skb
    https://git.kernel.org/netdev/net-next/c/3bab3ee0f95e
  - [net-next,02/14] tls: drop unnecessary cipher_type checks in tls offload
    https://git.kernel.org/netdev/net-next/c/8f1d532b4a49
  - [net-next,03/14] tls: store rec_seq directly within cipher_context
    https://git.kernel.org/netdev/net-next/c/6d5029e54700
  - [net-next,04/14] tls: rename MAX_IV_SIZE to TLS_MAX_IV_SIZE
    https://git.kernel.org/netdev/net-next/c/bee6b7b30706
  - [net-next,05/14] tls: store iv directly within cipher_context
    https://git.kernel.org/netdev/net-next/c/1c1cb3110d7e
  - [net-next,06/14] tls: extract context alloc/initialization out of tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/615580cbc99a
  - [net-next,07/14] tls: move tls_prot_info initialization out of tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/a9937816edde
  - [net-next,08/14] tls: also use init_prot_info in tls_set_device_offload
    https://git.kernel.org/netdev/net-next/c/1a074f7618e8
  - [net-next,09/14] tls: add a helper to allocate/initialize offload_ctx_tx
    https://git.kernel.org/netdev/net-next/c/013740799987
  - [net-next,10/14] tls: remove tls_context argument from tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/b6a30ec9239a
  - [net-next,11/14] tls: remove tls_context argument from tls_set_device_offload
    https://git.kernel.org/netdev/net-next/c/4f4866991847
  - [net-next,12/14] tls: validate crypto_info in a separate helper
    https://git.kernel.org/netdev/net-next/c/1cf7fbcee60a
  - [net-next,13/14] chcr_ktls: use tls_offload_context_tx and driver_state like other drivers
    https://git.kernel.org/netdev/net-next/c/0700aa3a7503
  - [net-next,14/14] tls: use fixed size for tls_offload_context_{tx,rx}.driver_state
    https://git.kernel.org/netdev/net-next/c/9f0c8245516b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



