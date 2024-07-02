Return-Path: <netdev+bounces-108468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C9923EC1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E011FB22748
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D71B4C21;
	Tue,  2 Jul 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNq0cbuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250261B47D5
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926430; cv=none; b=MLdm9Ab4e4JWDXSJIQ50DlB5zQiSBgYgBTlYN/kbefwshWDnr61Q8gPzz0nwr0gnECpzvBdQn6kc2mtzjxEyED0U09IUchqMvB1AlivXwwaC4weyNN/yvs7Xe3oVZcXAY40WZ2W2frmz44VfnDhrkSdHTXBmdJyzoQkQAv0owGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926430; c=relaxed/simple;
	bh=3CuepPftJk/TWHf1Ra+QMvZfoRCfNV/ua/CRSYDMcOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sb3ZiFh2K9KYIgPmXcqCvg6WkaKZmkg/am34rWDg7RhE/Uch07uBGmudqrb8uewzz9aYJ4HlV/Vo3fnVYnPIDaKau+sWjeKRwtkZGFc5+SalApa74kB+nxsCra4Gp9rW/BP8aRwCXqVmEx18G3G6go03lVv9IG41+Me4/9ksfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNq0cbuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1961C4AF0E;
	Tue,  2 Jul 2024 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926430;
	bh=3CuepPftJk/TWHf1Ra+QMvZfoRCfNV/ua/CRSYDMcOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XNq0cbuXvOfRroalKQYa7mr3ZHCqbqhTGgcAVf9JCUn2L2JoeR6Q/M6W90U/HOTET
	 QHfd2yGQn7YAGGCs65MZa58l1ogrMJ3yOLNuRiV2apRzp/tfsU/UMVICBllg3lmN9V
	 KGTiH5v8vShEi1MxKcSvpYu+J8rb90zMxSXHwUXxulYDCPPOOkcb6PCMBqik6qakGL
	 ztw+qwMn56tjb7eoGyEu596Oh+oer36aw54LyuNKvJkmkJT5ELGBLd6C+1mXcBBUql
	 +XXLU5b0/jDb2UbAEForWNgTZqFge0Uw0BCnAaIvzkBddMTvMj14Ml2v/3M4LGPxC/
	 3LsePFv/lj5bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF3DD2D0E2;
	Tue,  2 Jul 2024 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] page_pool: bnxt_en: unlink old page pool in
 queue api using helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992642989.16847.4738082206088376537.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 13:20:29 +0000
References: <20240627030200.3647145-1-dw@davidwei.uk>
In-Reply-To: <20240627030200.3647145-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: michael.chan@broadcom.com, andrew.gospodarek@broadcom.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Jun 2024 20:01:58 -0700 you wrote:
> 56ef27e3 unexported page_pool_unlink_napi() and renamed it to
> page_pool_disable_direct_recycling(). This is because there was no
> in-tree user of page_pool_unlink_napi().
> 
> Since then Rx queue API and an implementation in bnxt got merged. In the
> bnxt implementation, it broadly follows the following steps: allocate
> new queue memory + page pool, stop old rx queue, swap, then destroy old
> queue memory + page pool.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] page_pool: export page_pool_disable_direct_recycling()
    https://git.kernel.org/netdev/net-next/c/d7f39aee79f0
  - [net-next,v2,2/2] bnxt_en: unlink page pool when stopping Rx queue
    https://git.kernel.org/netdev/net-next/c/40eca00ae605

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



