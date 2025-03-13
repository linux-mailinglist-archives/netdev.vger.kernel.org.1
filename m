Return-Path: <netdev+bounces-174481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305CDA5EF2B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89DC188FB28
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44226561F;
	Thu, 13 Mar 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9bT00QL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550E265618
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856999; cv=none; b=bocfxwZfAP/Chjqe9aF8rCYMqYDSCkzRYiJBvIZ1VTtMqpp2c4zaZt1MfGubeYgDwv75Y6TlBNJLCvbupDYAvd0H9ByZeUzaIPsH2OA4HFsioQH/ZFLh/naFaGPMfagXOTgst9zs1Gr3wDSMs50NA5YiKuObYlG7BnfTjuGINlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856999; c=relaxed/simple;
	bh=a072/iy7t323+szC7BiprxxueBdmRmhOwsCwWCV1rVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IM1KuPH2JSetIpqvnyS1FQ9k5wgteK9fSVXZpFepo7V2paqUDKJZln51vywVLpfp4D6xys0NF7/rqxcW0gbl9//99EDY398DdRAn3Nowrw+QwsXsqkAHN3425nsajCqFoFk9sxGzuUMnBVwxcXa2nPjgfTP6IaWZsALz4NsEKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9bT00QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3504C4CEDD;
	Thu, 13 Mar 2025 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856998;
	bh=a072/iy7t323+szC7BiprxxueBdmRmhOwsCwWCV1rVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y9bT00QL6upUS9ONqWjC6PhPTGn4Hvv/V2P4un/2B1zspOuVQXc6tuEwICRYB+Wpo
	 WyXSkZ42qKFvnkSU7lkmKzgZuCpMhE8l3yQ6c/9VtbV5Tjnrtqt/CTmdiLbdlDfqeO
	 fzmNMq8cGnQEMF2CfvERxl0asJGpWUL+bGZ2W73cRliv9v8U3qpnLm1ixis3mlxHQI
	 P45dO/9seiQLePqTXTgkg22wUXXpd8xPb8/SJSpyZrvIVoJTRkeKvkzc3XAXD8RUW4
	 Ng8wworzlrEf0xxtd+iXldkdDX6qE0ysAF6obCx9TMrgBk62VZr+Bu7lTf7TlY3GLP
	 wPNv2s6EIUxvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BC53806651;
	Thu, 13 Mar 2025 09:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: cn23xx: fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185703299.1429089.7342036961331088511.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 09:10:32 +0000
References: <20250307145648.1679912-2-janik@aq0.de>
In-Reply-To: <20250307145648.1679912-2-janik@aq0.de>
To: Janik Haag <janik@aq0.de>
Cc: horms@kernel.org, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Mar 2025 15:56:49 +0100 you wrote:
> This patch fixes a few typos, spelling mistakes, and a bit of grammar,
> increasing the comments readability.
> 
> Signed-off-by: Janik Haag <janik@aq0.de>
> ---
>  .../cavium/liquidio/cn23xx_pf_device.c        | 76 +++++++++----------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: cn23xx: fix typos
    https://git.kernel.org/netdev/net-next/c/676cc91e1f2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



