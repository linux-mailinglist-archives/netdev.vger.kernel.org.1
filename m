Return-Path: <netdev+bounces-196385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F0AD46E6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160093A765E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14A28C87B;
	Tue, 10 Jun 2025 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkbe6j6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CE28C876
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598757; cv=none; b=FT/4QA54j3OPJIas6B/UR4SsIP5vqYcnpGJodGiPJOKj0K9FvDhAo05E4uJMLY0DacA6IX0mqzfu3P1gKqOyatrbuejOGKGzCMkDgnF246bLEmoXUf3c5KFBrduB2FX4f8PlJddMnXY/3YKLFnJnNEPXkXlnzLVN2iFAI2foSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598757; c=relaxed/simple;
	bh=l3xtv/wzQH9mSnGuY0XdzWUfnxjGXhIUi2PxYKu3ZeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y96HXZ0tcIbvdTYIJN6oHe2CQpqXJ+Xx3yhm9gfpGrJkMwX0MhaDWJxzwjSlk7d19sgsVDI2nszLRDiQoImbFkGRFaSn/cqToA0WfZsbxKYMkYH0UFLnSZ0Rp/L0AKCF9u8OmG+U1kJjIo2JqUM4St5zrQ7nP4F5U+iLb3+4fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkbe6j6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9C5C4CEED;
	Tue, 10 Jun 2025 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598756;
	bh=l3xtv/wzQH9mSnGuY0XdzWUfnxjGXhIUi2PxYKu3ZeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fkbe6j6vazwP3r+ZeHInc7f76VQRHzuPnm5fW3jJ+HXc01xg1rUCN+Qv78lxrXg/a
	 0xP7mFEN8pjybQ/GDP/NaGLxg4L8z7F2k/h+OE9c+Yu4IVbZ6iyrP1ff+iZE921e5Z
	 GLzwyYpp/SW3hGlit5qEGU+fo2sMe6Ebvp5KsPqK4HIm4OSFTLiPxQ0zE4lF+wr7Sc
	 kICNjmf4BKlU5R7+L7evv5xwUdyma4kfVNfurq87s/OmW7UCxXTASRTTWwAjkdpooo
	 /FsxsQC2VcY1TAFxFJBRwfIkV4/rVb9TpYYO0UT6e11GRLb/fgpx+eprytEIS2xrL/
	 fmu4yYzF43i9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6B38111E3;
	Tue, 10 Jun 2025 23:39:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2: Annotate mmio regions as __iomem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959878649.2630805.9672777593405577511.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:46 +0000
References: <1749484309-3434-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1749484309-3434-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 bbhushan2@marvell.com, lcherian@marvell.com, jerinj@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Jun 2025 21:21:49 +0530 you wrote:
> This patch removes unnecessary typecasts by marking the
> mbox_regions array as __iomem since it is used to store
> pointers to memory-mapped I/O (MMIO) regions. Also simplified
> the call to readq() in PF driver by removing redundant type casts.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2: Annotate mmio regions as __iomem
    https://git.kernel.org/netdev/net-next/c/d0976b43956e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



