Return-Path: <netdev+bounces-159591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9CA15FD3
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48261886BD0
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87F12942A;
	Sun, 19 Jan 2025 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyhL6CT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007E2837B;
	Sun, 19 Jan 2025 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251413; cv=none; b=CNRYe0Zky0edE4Wczg9w7M3YgQZMV3oVw3Vfcv/0gyTzCAYbC4RJKovEYqA3N4MohmJHV7n19lxHIYApMYNsEcNhHnfL6JxKYnEktXOqwnksxMvbOQjFX8d9c0/fOhGIMQ0v1X32xU0hO26yaOhrKlaDSZ0379GbqzubVLb56no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251413; c=relaxed/simple;
	bh=EsCgqF0PW2Pf0IXz2LO3tp2VrjrQFmgzM4n3mbjjuZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N4/PbHoqATpUC8GC9eWFMQomDjMj/elxR01XOjRmPbc2lBmQPSLrwNSxPNhjKjXWO70Ffvmm0zKlrKfCJOCQGP58FlNiKaAEeaErnVA++U6/yRPS+sVv7u5F+10Sa0fCc9LeLTSVS779u2ynnLBQCGBgXhjtKFULtOe9YToPfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyhL6CT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0B8C4CED1;
	Sun, 19 Jan 2025 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251413;
	bh=EsCgqF0PW2Pf0IXz2LO3tp2VrjrQFmgzM4n3mbjjuZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JyhL6CT7wrR4YIU1OOrpZMKJP5jwqXKXBTd8E4Re5GYYKFJK7JporA36PZoUVbYIG
	 aUN54YVCoRDgUlODgXzqY6hopzs7tYq3aH+aG7UabxLViBUC6UfBWq8x2an1Ew0h37
	 N5I0vmRUgMYgkLk4y5I+24gLBF5hGf8gn1wJ+jcKvDVb/4MskYn5HWLNwe2XN+3NeX
	 5ukPD7SxlkcQph/t5GNShDWs44NdOPCIwBBSgadIN8IwVs9KhA6AOytho7FP6rer51
	 SmMWV0WIVPi3GhX0xnD0bMsMbZRrFi1k85WuJ2nYBFvOMdZNizQcoiL9P4CSq5Eesa
	 GWRbU/GRhyUhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2E380AA62;
	Sun, 19 Jan 2025 01:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143649.2533015.4073289679568150020.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:36 +0000
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
In-Reply-To: <20250116232954.2696930-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 michal.simek@amd.com, linux-kernel@vger.kernel.org, shannon.nelson@amd.com,
 linux-arm-kernel@lists.infradead.org, hengqi@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 18:29:48 -0500 you wrote:
> To improve performance without sacrificing latency under low load,
> enable DIM. While I appreciate not having to write the library myself, I
> do think there are many unusual aspects to DIM, as detailed in the last
> patch.
> 
> Changes in v4:
> - Fix incorrect function name in doc comment for axienet_coalesce_params
> - Rebase onto net-next/master
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
    https://git.kernel.org/netdev/net-next/c/5cff9d1756fb
  - [net-next,v4,2/6] net: xilinx: axienet: Report an error for bad coalesce settings
    https://git.kernel.org/netdev/net-next/c/9d301a53a532
  - [net-next,v4,3/6] net: xilinx: axienet: Combine CR calculation
    (no matching commit)
  - [net-next,v4,4/6] net: xilinx: axienet: Support adjusting coalesce settings while running
    (no matching commit)
  - [net-next,v4,5/6] net: xilinx: axienet: Get coalesce parameters from driver state
    (no matching commit)
  - [net-next,v4,6/6] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



