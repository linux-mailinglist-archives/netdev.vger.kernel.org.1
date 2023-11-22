Return-Path: <netdev+bounces-49866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662477F3B5D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1790628291E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E74439;
	Wed, 22 Nov 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axoW0M2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7D4401
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F37C433C8;
	Wed, 22 Nov 2023 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617225;
	bh=/mDybIKKXULJmj6tE+N/3coaqNA7Go8jYqtE5oBlwP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=axoW0M2H+a7yYV+fuxEOit2+fknALqDbLgcR24aSz46eSygV1QWM5U0E1iMgXUaQ5
	 h295N2EqYFyMUGpDzdupGhfSPsr0+Nu7LoQ178/mhJE9/+f524Ti4Z1I0V3R/s/+lc
	 bFLgk+JpLdnGFOXEulaCeaCiAuB+UN9pXdJz0Jsmb9Stsq6zDrZXN7KcLvCRsRxiPt
	 xFDQh48vLaLdnyRL40TrsFCJghCotXOtf1WKpo/IgpmgBBdJ1B61Sz4wxiZjNqDi8u
	 BJGhqgfh+xxxzXA0HdF1g+RLmNJEeTo5dTmPRBcmfbBkFYR4dtaEUSkKZ6ThHsdvQE
	 4VRwoRKCDQTXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96C7AEAA955;
	Wed, 22 Nov 2023 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] bnxt_en: Prepare to support new P7 chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170061722561.4150.8169365811227319023.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 01:40:25 +0000
References: <20231120234405.194542-1-michael.chan@broadcom.com>
In-Reply-To: <20231120234405.194542-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Nov 2023 15:43:52 -0800 you wrote:
> This patchset is to prepare the driver to support the new P7 chips by
> refactoring and modifying the code.  The P7 chip is built on the P5
> chip and many code paths can be modified to support both chips.  The
> whole patchset to have basic support for P7 chips is about 20 patches so
> a follow-on patchset will complete the support and add the new PCI IDs.
> 
> The first 8 patches are changes to the backing store logic to support
> both chips with mostly common code paths and datastructures.  Both
> chips require host backing store memory but the relevant firmware APIs
> have been modified to make it easier to support new backing store
> memory types.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] bnxt_en: The caller of bnxt_alloc_ctx_mem() should always free bp->ctx
    https://git.kernel.org/netdev/net-next/c/aa8460bacf49
  - [net-next,02/13] bnxt_en: Free bp->ctx inside bnxt_free_ctx_mem()
    https://git.kernel.org/netdev/net-next/c/e50dc4c2206e
  - [net-next,03/13] bnxt_en: Restructure context memory data structures
    https://git.kernel.org/netdev/net-next/c/76087d997a84
  - [net-next,04/13] bnxt_en: Add page info to struct bnxt_ctx_mem_type
    https://git.kernel.org/netdev/net-next/c/035c57615982
  - [net-next,05/13] bnxt_en: Use the pg_info field in bnxt_ctx_mem_type struct
    https://git.kernel.org/netdev/net-next/c/2ad67aea11f2
  - [net-next,06/13] bnxt_en: Add bnxt_setup_ctxm_pg_tbls() helper function
    https://git.kernel.org/netdev/net-next/c/b098dc5a3357
  - [net-next,07/13] bnxt_en: Add support for new backing store query firmware API
    https://git.kernel.org/netdev/net-next/c/6a4d0774f02d
  - [net-next,08/13] bnxt_en: Add support for HWRM_FUNC_BACKING_STORE_CFG_V2 firmware calls
    https://git.kernel.org/netdev/net-next/c/236e237f8ffe
  - [net-next,09/13] bnxt_en: Add db_ring_mask and related macro to bnxt_db_info struct.
    https://git.kernel.org/netdev/net-next/c/b9e0c47ee2ec
  - [net-next,10/13] bnxt_en: Modify TX ring indexing logic.
    https://git.kernel.org/netdev/net-next/c/6d1add95536b
  - [net-next,11/13] bnxt_en: Modify RX ring indexing logic.
    https://git.kernel.org/netdev/net-next/c/c09d22674b94
  - [net-next,12/13] bnxt_en: Modify the NAPI logic for the new P7 chips
    https://git.kernel.org/netdev/net-next/c/f94471f3ce74
  - [net-next,13/13] bnxt_en: Rename some macros for the P5 chips
    https://git.kernel.org/netdev/net-next/c/1c7fd6ee2fe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



