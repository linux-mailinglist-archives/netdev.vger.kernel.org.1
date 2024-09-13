Return-Path: <netdev+bounces-128013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E2977794
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8B01C2450E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308A1D131A;
	Fri, 13 Sep 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brmYS0CG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9351C57BB
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199433; cv=none; b=p9tgxACOx1noMiaFBkXmdxeL9P8/sA4VroRf+D1wWhVRBpnD66RtIgvvi0qZQF02YVEPAOgPO7OtpDa/r4silmZ7D4DJ6daijTxkH4OFaRjnvTURnE61wJ4kCHZpGEGRN7053+oJpSuWSpgfhLOUTQ/NrkZuH6xZc9nIFAEZixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199433; c=relaxed/simple;
	bh=7o5ooeP+lfyAv3Pv9cVHV2YxIwKJy+mAuGdU7R1oxDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JUu7JKp9fmik3xAUftZMCNASvdngZLvguBrNVSjscsjIZiPr9stkHxQMmK1Sa5XFUoB72vKYM9MTE3GHsJSUgzXabnvB5BqUw67GITHbIZXSco199ynJUDBpZhgw4/SZVL6SRaFVp7dtpEDwk5QZKtAamnhQ1Pma7MJrnsk3WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brmYS0CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420FC4CECD;
	Fri, 13 Sep 2024 03:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726199433;
	bh=7o5ooeP+lfyAv3Pv9cVHV2YxIwKJy+mAuGdU7R1oxDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=brmYS0CGnskr0bYTR3H1igh1iFYSex9dtyy2rvy/P414a3k85Hpmyh3XCDi6/US81
	 JI4FPQm82vbNPs51Cbg9HfaLrJsblj3L5Fip74GUE96wsZ7OidAtjTAQRv8WLovCmX
	 /MD+IndsHISLAiRJ/1Q19qqyB9RyZZbb/pOb5o2TFdFKPvP4iDtpt0YgyJbiUwA2db
	 0GLsyYT7eR+pfEvcCMMFD6KiJij2Is9hIFVGClNKKIcacIIdweG+U4orDblrhgnHoo
	 e30zNst+j7pAxt2i+VfXXiLrIkWlC9hsi2dfsAg5ZSKOIfMI6ofF+ozhSOKEcU9S/n
	 6re+oVKW2IcDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF13806644;
	Fri, 13 Sep 2024 03:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] uapi: libc-compat: remove ipx leftovers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619943401.1807670.7533738620169249998.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 03:50:34 +0000
References: <20240911002142.1508694-1-kuba@kernel.org>
In-Reply-To: <20240911002142.1508694-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 17:21:42 -0700 you wrote:
> The uAPI headers for IPX were deleted 3 years ago in
> commit 6c9b40844751 ("net: Remove net/ipx.h and uapi/linux/ipx.h header files")
> Delete the leftover defines from libc-compat.h
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/uapi/linux/libc-compat.h | 36 --------------------------------
>  1 file changed, 36 deletions(-)

Here is the summary with links:
  - [net-next] uapi: libc-compat: remove ipx leftovers
    https://git.kernel.org/netdev/net-next/c/b2155807893a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



