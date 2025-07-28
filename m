Return-Path: <netdev+bounces-210614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F1B140BF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33694E415A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF62749DA;
	Mon, 28 Jul 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXT7SYe6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804B274654
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721398; cv=none; b=bAV1eJ6qXOAJAUB+j3stdb2f2P5xNzRENhH4fDPNk2uOxgrO7tJGYWdDdswCC96a5suTVFKla3NlMFqqrxaMIlZjXu0dLVMbu2u868nuJbdkZFfnjZ0d01KccbOrat/twFp98Sot6p21pX6NBeNr/LmkNjXNPIbik8cnxnahT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721398; c=relaxed/simple;
	bh=f+5NuNfRGZ9jNepnPNx+WWGYLtfyD+5Sq9lxKCuAoQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHIAJ7nhFDA/3LWGmJp+sZGinFbP82Y8oIwG3Cjoss3KhcF6edF45/hPYMHIr8Vv0gxRA6wIzAr1SMdeX3YbmPSBVqyFD/U3cwDUdCA3jgvDh+ykxBOX1L1f8RciNxe8LSozxL2M1BuAhkRJZHS26my7E94umja5so/Sll7oj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXT7SYe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E9C4CEE7;
	Mon, 28 Jul 2025 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721398;
	bh=f+5NuNfRGZ9jNepnPNx+WWGYLtfyD+5Sq9lxKCuAoQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXT7SYe6GfgU/n3CaZ1kJSrj88dxTUTpAD262a67v7dFzd/3ZyX2VKDhNZMxvKfCU
	 UM5W9C3qlpy4qRzBEongBnj+kDKkoW+TGcqvMoFaLDsG/Unh7AX8zs5nZD8CTXWYFS
	 Wbn0TXJL9PbTOVunH81ZrvlW3l8ZQP42mf2dzJk3fB8VkQJL4KdHszNjt6Zc+t/SmP
	 jVqS/5Gywr4qvqb80XO6tCzDRcp3pV5A+W6c6aqFoO3df8+ViOePs52K2W9ljy+BrK
	 tDPWMntNpWHrio3LH748INZMsRjerLgwLC5OSl/3UidCvzmEh/bB4Uh3NIpWO3m3XL
	 DXUmqVQRxizjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF24383BF5F;
	Mon, 28 Jul 2025 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] devlink: Update uapi headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175372141465.776676.5925073167458730838.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 16:50:14 +0000
References: <20250728140554.2175973-1-cjubran@nvidia.com>
In-Reply-To: <20250728140554.2175973-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, jiri@nvidia.com,
 netdev@vger.kernel.org, tariqt@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 28 Jul 2025 17:05:54 +0300 you wrote:
> Update devlink.h file up to kernel commit 1bbdb81a9836 ("devlink: Fix
> excessive stack usage in rate TC bandwidth parsing").
> 
> Fixes: c83d1477f8b2 ("Add support for 'tc-bw' attribute in devlink-rate")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> ---
>  devlink/devlink.c            | 39 ++++++++++++++++++++++++++++--------
>  include/uapi/linux/devlink.h | 11 ++++++++--
>  2 files changed, 40 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [iproute2-next] devlink: Update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1a60e903d949

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



