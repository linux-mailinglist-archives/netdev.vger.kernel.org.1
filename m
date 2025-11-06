Return-Path: <netdev+bounces-236530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8CC3DAEC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2487F3B3452
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1A34DB65;
	Thu,  6 Nov 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rotZVlnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE334D911;
	Thu,  6 Nov 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469454; cv=none; b=drxVNCfnGOc5OcUulP9J9UNtv+NLnwcE1eDMrnP4LEHVazuffT/WyGz5gLPfRvFoyEb+bXDhoGFdGfCB2ILxbCFn2vHSyhnvvDna5BfuCmaqKXSnIz4oYQuU19zcKcMZfkESf+OLXdvVw9MOKzsxT9vf2CsP3j+leGf8qPS0258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469454; c=relaxed/simple;
	bh=9mG4eeS8pDEr/kATyQJtRZ4K0MOrnCrABXQqRPoOeYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1ppPgHRcAtKlvGS6H5wPb/GrCpNyOX/GSAa8FL/mOrx1lmT2CgJgJk8Q0MVTrR4bDO6iiMnPJfiI5ESOA+pmfNEgMBsXXh18g+HDcLGKBCATpKrresPOeGfXsqnbtVn9nrZjLwOwX3Menm6FfCSpbbBoLmO4/d0S7HhqE9VbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rotZVlnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B746CC4CEF7;
	Thu,  6 Nov 2025 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469454;
	bh=9mG4eeS8pDEr/kATyQJtRZ4K0MOrnCrABXQqRPoOeYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rotZVlnS/1ASMXm6bJt/fxcrmX9TiRQgSiGXv3YndUSf4ERhHvSqTRlmS+nLF0ron
	 BACdCJx2YcYqBgQXbLuwY+Ny3G96i2UM9sJUmHyTUDPSw6OdIsR46QsmQN6AVzvhXX
	 OBFDoKWVXtYXaJ9nIfmUV6GZcCO5GZRmOQlWJMpCgjM/eaPjFKa/torl3HJZFnnfoS
	 n8459nXj+dgOEWuWgVwRAViFTsaNHVgQh/76QIV7jbV7ttjS5iFvsc62qv6zbADEGv
	 JLYgajQTn7x5gXNDIq88hZQYmlVysF1Itg1qhEsZas6SKmRvpQzVNs5ug8tacQHt9I
	 QHrZlPvTEJAWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5139EF96E;
	Thu,  6 Nov 2025 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176246942750.378775.12387953911259542013.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 22:50:27 +0000
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
In-Reply-To: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Nov 2025 10:01:12 -0800 you wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/c04956cccb78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



