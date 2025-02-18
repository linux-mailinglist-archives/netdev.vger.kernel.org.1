Return-Path: <netdev+bounces-167146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95EA3903F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E950C1724B7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3360DCF;
	Tue, 18 Feb 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+jDm3tE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCC749A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841603; cv=none; b=VdMHO1VXUioTPajjJJ+Yk/L+8u+oHj19R3jtKyIDf3Nix+TsQ+UjSJO3UC0zhJEpyWzpQke9OluAtog9vtZeUyCX7egrQpO9L0sjCf/ubJhil0/z9WJ1KF7O/JZk9aIwqiPjLFTrzWWcdDIyUSEXplgGoBm7i9II4ZTl1u01Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841603; c=relaxed/simple;
	bh=Bc/W7X5UgBEB03d4AshfN6TAa5rPfyljYxxRdy0VJgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hatAJ5sCeiPYnY/tY7SV+AK/BiWFxyc4wQ5HW87/H+a3aoHtOgwCPxfZtsVNdOTf1rA2quN9zU/gvO7ZqSx8+LRyDjN40FMDUylZ3jDkguVaxvM9ZyRcG0PYYON/AXcILicdj++umL2w4JLaxenM7/TqvF/xZvUHRVGo3fEGMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+jDm3tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F84C4CEE4;
	Tue, 18 Feb 2025 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841603;
	bh=Bc/W7X5UgBEB03d4AshfN6TAa5rPfyljYxxRdy0VJgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+jDm3tEn1NaYshv2/zFGcu2T4CAl/CTu4lrpJ94zIApBzQCcNd3h/dT5r89Nnq0i
	 Kuu7MmXIGOD5lp8TcSlioa3k2QHH4TQq+B44peofR3t/c8cNTBZz42vdDULbYeCVOT
	 XkYm6FIkLI6mMfN3U+/RN+Sd+PMhB1M1wAEDg5i/0jBLkVwCEgNtj/WaZV7AlxVySB
	 NqgjjtshokoQVcLmTlVScnaUkVMDmmszvp3UYPurAtS7JBWNa7R+Hj1m5dHepAiTW2
	 XK9fMckJ4udzVSIMbx/gRGDZrOkD5gSIie5rJUZOhgiKSnJ3Hzqv+gEkCymy1bndVC
	 k34VSaLI/4ebQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7109D380AAD5;
	Tue, 18 Feb 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ibmvnic: Don't reference skb after sending to VIOS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984163302.3591662.5271002902483430576.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:33 +0000
References: <20250214155233.235559-1-nnac123@linux.ibm.com>
In-Reply-To: <20250214155233.235559-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 09:52:33 -0600 you wrote:
> Previously, after successfully flushing the xmit buffer to VIOS,
> the tx_bytes stat was incremented by the length of the skb.
> 
> It is invalid to access the skb memory after sending the buffer to
> the VIOS because, at any point after sending, the VIOS can trigger
> an interrupt to free this memory. A race between reading skb->len
> and freeing the skb is possible (especially during LPM) and will
> result in use-after-free:
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
>  Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
>  <...>
>  Call Trace:
>  [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
>  [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
>  [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
>  [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
>  [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
>  [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
>  <...>
>  Freed by task 0:
>  kasan_save_stack+0x34/0x68
>  kasan_save_track+0x2c/0x50
>  kasan_save_free_info+0x64/0x108
>  __kasan_mempool_poison_object+0x148/0x2d4
>  napi_skb_cache_put+0x5c/0x194
>  net_tx_action+0x154/0x5b8
>  handle_softirqs+0x20c/0x60c
>  do_softirq_own_stack+0x6c/0x88
>  <...>
>  The buggy address belongs to the object at c00000024eb48a00 which
>   belongs to the cache skbuff_head_cache of size 224
> ==================================================================
> 
> [...]

Here is the summary with links:
  - [net] ibmvnic: Don't reference skb after sending to VIOS
    https://git.kernel.org/netdev/net/c/bdf5d13aa05e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



