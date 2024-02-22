Return-Path: <netdev+bounces-74037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924A85FB70
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C21F1C2123F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACD1468F7;
	Thu, 22 Feb 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyRuHhYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7A36B15
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612827; cv=none; b=jc+a2eo+gtSnrxtS08ZNaoT0tqx50a4gdnzCXS5RsfywqGVrSCQmUh4L12OS46mTEt+HIpc95YJN0odQeUnoptA2Oa+qIcgF2h0i/IZ3Lqo7IK7QcVTy0vISLJaZkirxSRP/Mk7yJnkXMt100Ag/sySYwHz8roj790gQw0LynhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612827; c=relaxed/simple;
	bh=T0hSBWsciEU/YcXvSLDMZvm7kqrtsyIcHCpFDExIkhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJm005OsB0CsUuElHHA6sISYcD5xXyKiv8lRFX2YKAXAZ4z4Ny84CM14yLknMZ+R4thdgMpxuPuav1MJZrsjw+7X9MNMTlx4HjuPwRg8tXSgJY4ZeQ7t0k5oHoGKXK4qVxQQ+Cn1hC0mvH7tavBz9tYuPDdM3NBgE5UchFSz45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyRuHhYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B9DAC43390;
	Thu, 22 Feb 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708612827;
	bh=T0hSBWsciEU/YcXvSLDMZvm7kqrtsyIcHCpFDExIkhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VyRuHhYUVtXgKZW2+TAPUfaLnvO//I9ggKVWi18myIShiOjsvjk9VJhvFRXppIJBE
	 5Y+WvoGgTPrBvoAIuKSrBgNnUUN0l/UM/UB8J9pJ3DStV4lmj0FERGtE+0xHvFekUc
	 FVAYNJi2ltV5bxRPPUHhqIiGlrcYfyFUCE81S05ZSMAdnz3Efy+OkPISHd42THVeEb
	 aTZKID0v26c2Xi9GuWafwCEXADs9Gz7XoXNyDlH9Zm0umSCykmavGQPaEICKT51zDP
	 ZM4NppJNtAYlw39yqB3EOL72ax0WyVeCYZZky2q8wPoOsOkARC3ejNZKRcE9DZL6I+
	 aPk/UvWUa0IGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF148C04E32;
	Thu, 22 Feb 2024 14:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] bnxt_en: Ntuple filter improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170861282697.10679.17094342488665074404.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 14:40:26 +0000
References: <20240220230317.96341-1-michael.chan@broadcom.com>
In-Reply-To: <20240220230317.96341-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Feb 2024 15:03:07 -0800 you wrote:
> The current Ntuple filter implementation has a limitation on 5750X (P5)
> and newer chips.  The destination ring of the ntuple filter must be
> a valid ring in the RSS indirection table.  Ntuple filters may not work
> if the RSS indirection table is modified by the user to only contain a
> subset of the rings.  If an ntuple filter is set to a ring destination
> that is not in the RSS indirection table, the packet matching that
> filter will be placed in a random ring instead of the specified
> destination ring.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] bnxt_en: Refactor ring reservation functions
    https://git.kernel.org/netdev/net-next/c/257bbf45af81
  - [net-next,02/10] bnxt_en: Explicitly specify P5 completion rings to reserve
    https://git.kernel.org/netdev/net-next/c/ae8186b2d406
  - [net-next,03/10] bnxt_en: Improve RSS context reservation infrastructure
    https://git.kernel.org/netdev/net-next/c/438ba39b25fe
  - [net-next,04/10] bnxt_en: Check additional resources in bnxt_check_rings()
    https://git.kernel.org/netdev/net-next/c/929429986773
  - [net-next,05/10] bnxt_en: Add bnxt_get_total_vnics() to calculate number of VNICs
    https://git.kernel.org/netdev/net-next/c/8c81ae6c54c1
  - [net-next,06/10] bnxt_en: Refactor bnxt_set_features()
    https://git.kernel.org/netdev/net-next/c/5d5b90fb4e90
  - [net-next,07/10] bnxt_en: Define BNXT_VNIC_DEFAULT for the default vnic index
    https://git.kernel.org/netdev/net-next/c/ef4ee64e9990
  - [net-next,08/10] bnxt_en: Provision for an additional VNIC for ntuple filters
    https://git.kernel.org/netdev/net-next/c/532c034e4b2b
  - [net-next,09/10] bnxt_en: Create and setup the additional VNIC for adding ntuple filters
    https://git.kernel.org/netdev/net-next/c/93e90104bd12
  - [net-next,10/10] bnxt_en: Use the new VNIC to create ntuple filters
    https://git.kernel.org/netdev/net-next/c/f6eff053a60c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



