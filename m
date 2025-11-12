Return-Path: <netdev+bounces-237791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4BC503D4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A61898D51
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C1292B54;
	Wed, 12 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EitT0dFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779C291864;
	Wed, 12 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912243; cv=none; b=KitxxfPst3F1VjT/PH8E5PDc8Hvdlqgny7hzPudbtcNA/Cf4B9wGXvGIWNIE0pSbU5WKj8vZOM6pfVHjm3mSburwMh83QqbToJ0xGXkeOOWJvqV62p02K4OG3M5l3AM2sUe3Yw7VBIqtpQXuj2lr2Ujk+GLFrE3Wysx6AxUt7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912243; c=relaxed/simple;
	bh=eidUOVATaPJ26btdNQ/nqcAKZQ3QWQ0nxhcKxFwCQX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=is1BK9iMG8tOT3dBZ6Mlclex+B7z8XLQoVZEsPPxqEoQaICKdATDlbFwVsWniyHGP71JyQ58py/iCu9wIqXICvhOOiqNj67O5rX1MyF3zw6JwDSrAAYWeg1XWhrL+bQ604DFkZlekr7FP+U6mZhcRmWD2Td8wwZSJ87K9xvSEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EitT0dFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D0CC4CEF5;
	Wed, 12 Nov 2025 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912243;
	bh=eidUOVATaPJ26btdNQ/nqcAKZQ3QWQ0nxhcKxFwCQX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EitT0dFWqNFqGWfs226TNhyn+zuftHvhQRMkVESHsWG5UWhcSUmLhge8AVgtdJKTA
	 apMiVWvSLkQ/nMsGut5ElwxahSCfnBKV+E2oP27o3bTHCYyu6XTFNkc/5YNJvKNn+/
	 KT7Ppb9fRjwIlEjLvlOO/4DjBnJfejqeogkA2ZtjSRncrPh/eb97WnrBqhQDCafr5b
	 qp2Qjk0Aa+ot7LcnR62Y8VDm6IhpBNGsBujt0LgsWciKUe6tWZb8uoeNUIlNdQygFc
	 BsBi68rywSbfN89fHuXZ+N9W9P1IWHwUuJF8lgrcmDq70J1UmXjrzN6sOV6nxHuDUn
	 14pC8nTEk9MPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B93380DBCD;
	Wed, 12 Nov 2025 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethtool: fix incorrect kernel-doc style comment in
 ethtool.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291221324.3630231.15309273955873419805.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 01:50:13 +0000
References: <20251110182545.2112596-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251110182545.2112596-1-kriish.sharma2006@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Nov 2025 18:25:45 +0000 you wrote:
> Building documentation produced the following warning:
> 
>   WARNING: ./include/linux/ethtool.h:495 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * IEEE 802.3ck/df defines 16 bins for FEC histogram plus one more for
> 
> This comment was not intended to be parsed as kernel-doc, so replace
> the '/**' with '/*' to silence the warning and align with normal
> comment style in header files.
> 
> [...]

Here is the summary with links:
  - ethtool: fix incorrect kernel-doc style comment in ethtool.h
    https://git.kernel.org/netdev/net/c/bb8336a5163a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



