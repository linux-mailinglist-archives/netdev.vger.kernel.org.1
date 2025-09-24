Return-Path: <netdev+bounces-225754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4AB97F99
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFA8189A563
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5F1EFFB2;
	Wed, 24 Sep 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQsfbOJ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C511DB95E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676209; cv=none; b=pUOoMT8mVMoIzXVKOafWGxr6ipB3bBOITNxjVtOinjU10AEyMfuZoKP9ixpfDRV79OInPVLVqOc3TgzPD8Jqm8/NDBlFvxeO22/NVAAzbYuSK8Q/bKtkz+ZwHGqTxeP3ZoG+vdtLALJh24LvTxpAI50tEtolZEOUI8EQfdlVTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676209; c=relaxed/simple;
	bh=Os5CzUnzUUcN2ha3B16hWQ+D5CFec1RZUEa7IzgDl64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EIKsnc9DWH+UOoz8ovUTx67YT/ajC6wHvJgT/qeWQ17JHKGuI+hlXe+T3+vRZX61ZADKD1MO8xgWwh8xYP4iGmazG+npfuV9VdtazYdCwaAK3JtZT7TpY9ikZLPiyLWF1vTBsU8vM6NSg8kBNbVBN7IeaFGJc+A3uxJKbTwBHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQsfbOJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D165C4CEF5;
	Wed, 24 Sep 2025 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676209;
	bh=Os5CzUnzUUcN2ha3B16hWQ+D5CFec1RZUEa7IzgDl64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQsfbOJ+E3CPVIsWfWbrfDbfyLJxfOpchMZw1WfVplXrAp7F3599E48ZCiMj/E99e
	 V2VcvI69s7lwJNf7+j1hEHr76O+ik/mgs1s4+YXsikYin57HiQnJ1X7KLPjZaJjpbh
	 WXNFZVR+yYBq+KtiAi/WiChzU/ZBR7SJujaEOq40k0z71ia5r9t6TbhGabyWG/6Hmt
	 tmc9Hu/5I4gGnf+GiChn6TDt+FGsKwr/B6B4pFNTHtqvP2nm/yTPSArVqrf/jyA795
	 cDj3HdngN+z0OMwbagUOL6ofGX7U+pMWKDft7GS3Ue5KVncMyee6GsRc+fYpKRGxSc
	 FI1emZ+CF591Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAC39D0C20;
	Wed, 24 Sep 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: tsconfig: set command must provide a
 reply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867620625.1985111.1855619624181809036.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 01:10:06 +0000
References: <20250922231924.2769571-1-vadfed@meta.com>
In-Reply-To: <20250922231924.2769571-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: andrew@lunn.ch, davem@davemloft.net, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, kuba@kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richardcochran@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 16:19:24 -0700 you wrote:
> Timestamping configuration through ethtool has inconsistent behavior of
> skipping the reply for set command if configuration was not changed. Fix
> it be providing reply in any case.
> 
> Fixes: 6e9e2eed4f39d ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: tsconfig: set command must provide a reply
    https://git.kernel.org/netdev/net-next/c/e8ab231782e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



