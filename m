Return-Path: <netdev+bounces-234327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20886C1F6BC
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1486B1A20028
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B2351FC2;
	Thu, 30 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0Vc3+3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75898351FB9
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818443; cv=none; b=VammceXoHoZCeZRpUFNCYt09oE5O4iyMp4pNuI1j0C40zCFioAPyc738YCA6Cu/7WVuq+IQpcSHG7lES6OO7xPqdz0L12QveR7Tovb7WMt4imS7jZ8w5tbwABA7D3Mx/9iDJpA6CQ2ge6iP+K5QgWBsD9gHNMttwOZvuF0je/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818443; c=relaxed/simple;
	bh=346+e760JgoDE0rOIL0Z5pYbipi8wDRqFLzWehKJTz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ay5hUf94HueBQq52gZnQr/eur5eYDufBcJaHUyUucP4WPqCfxHyP6zKxR5LbtOA1aLwjBXCdBA+iWzXtDqRbqgBHNgTxs8Eco/qyPPRR8Wem8q/H/ZDpnlS7FZz+aLE5MbF2AnhM2DmP9q8EbWeGvXDj8BoxFlr3HPOpIPTy6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0Vc3+3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAED5C4CEFD;
	Thu, 30 Oct 2025 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818443;
	bh=346+e760JgoDE0rOIL0Z5pYbipi8wDRqFLzWehKJTz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j0Vc3+3O3qdNfktHo/tNOQyTgGwEDv47FN0tvy0nfUM40i18abYLnDjoHv1eAVAsW
	 0/0OU+q6I8gXEI3LqSAQMJS3b6jNJPwVFu3vo1zNhreMp/mv51VBfmYeQr9BYaRUZr
	 aXqlqS/aFv2NPIt6q4OOTFpWPgJGdp4hUNqQJOB5iYMCuFG9EZ95ON+/JjtxRjFmxQ
	 BNtaOEnGlhn1la11L6QxDtdXtnakEWuh2JOKQBmAnR05f6alBoDp7QSQzujt0VJYnV
	 CA5hkx9QgeTOsbCySV02A1wMv/Ese+fTSdoU70kXC0qAX5kstmvrPEKvNLp/absLR+
	 XYnYDDg9oBLEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6B3A55FA9;
	Thu, 30 Oct 2025 10:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4 00/11] Add CN20K NIX and NPA contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176181841975.3782609.17766308913063444963.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 10:00:19 +0000
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
 lcherian@marvell.com, sgoutham@marvell.com, saikrishnag@marvell.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Oct 2025 16:02:36 +0530 you wrote:
> The hardware contexts of blocks NIX and NPA in CN20K silicon are
> different than that of previous silicons CN10K and CN9XK. This
> patchset adds the new contexts of CN20K in AF and PF drivers.
> A new mailbox for enqueuing contexts to hardware is added.
> 
> Patch 1 simplifies context writing and reading by using max context
> size supported by hardware instead of using each context size.
> Patch 2 and 3 adds NIX block contexts in AF driver and extends
> debugfs to display those new contexts
> Patch 4 and 5 adds NPA block contexts in AF driver and extends
> debugfs to display those new contexts
> Patch 6 omits NDC configuration since CN20K NPA does not use NDC
> for caching its contexts
> Patch 7 and 8 uses the new NIX and NPA contexts in PF/VF driver.
> Patch 9, 10 and 11 are to support more bandwidth profiles present in
> CN20K for RX ratelimiting and to display new profiles in debugfs
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/11] octeontx2-af: Simplify context writing and reading to hardware
    https://git.kernel.org/netdev/net-next/c/85708c5d5f5b
  - [net-next,v4,02/11] octeontx2-af: Add cn20k NIX block contexts
    https://git.kernel.org/netdev/net-next/c/b5dcdde074d5
  - [net-next,v4,03/11] octeontx2-af: Extend debugfs support for cn20k NIX
    https://git.kernel.org/netdev/net-next/c/45229e9a9ab5
  - [net-next,v4,04/11] octeontx2-af: Add cn20k NPA block contexts
    https://git.kernel.org/netdev/net-next/c/8a8b13012774
  - [net-next,v4,05/11] octeontx2-af: Extend debugfs support for cn20k NPA
    https://git.kernel.org/netdev/net-next/c/e4a8e78aca5e
  - [net-next,v4,06/11] octeontx2-af: Skip NDC operations for cn20k
    https://git.kernel.org/netdev/net-next/c/a861e5809f3e
  - [net-next,v4,07/11] octeontx2-pf: Initialize cn20k specific aura and pool contexts
    https://git.kernel.org/netdev/net-next/c/d322fbd17203
  - [net-next,v4,08/11] octeontx2-pf: Initialize new NIX SQ context for cn20k
    https://git.kernel.org/netdev/net-next/c/81f12533572d
  - [net-next,v4,09/11] octeontx2-af: Accommodate more bandwidth profiles for cn20k
    https://git.kernel.org/netdev/net-next/c/f7774633cf25
  - [net-next,v4,10/11] octeontx2-af: Display new bandwidth profiles too in debugfs
    https://git.kernel.org/netdev/net-next/c/47a1208776d7
  - [net-next,v4,11/11] octeontx2-pf: Use new bandwidth profiles in receive queue
    https://git.kernel.org/netdev/net-next/c/33d8a1f45729

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



