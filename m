Return-Path: <netdev+bounces-250418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6991D2AE83
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36B43045DF8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B511A30C368;
	Fri, 16 Jan 2026 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4a2Xx8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC723EA83;
	Fri, 16 Jan 2026 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535029; cv=none; b=o/qgaLiO2Q/yZQMGhlKSgN0ax5xRCo14KdPr+7P+Pb/gM3SL1SaTxVuKElplZB1mhLNxgI4nX7pFvo8WFBuu/91SRrRWrrsDDbcQJJ25WOSpn0n3WwDoBl146ZommUjcuiLT3Z2Gi03XitI7dmOQ1Yy+eZAiv5RldYYeI+lJIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535029; c=relaxed/simple;
	bh=iGyd8B4dPB7zPK3GnQ0VdReoWMgzw5H0mfAFCAnTYxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R7fxGwpqnwat3y0O7tGSF0LLC2xzCZKEXJfoVCZd8kznnWZzRxFDfKNk5qpYc8UMSQEbG7tIQgES+XvO5pWmg7jCQEvSbyjiEpM4mKEFkvm4InMh9QunBqUK9TPvbObJpGYDZ5yVSeO3Wi7kwg9eBOpRnZYyrqhukLXs9XcCpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4a2Xx8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC3C116D0;
	Fri, 16 Jan 2026 03:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535029;
	bh=iGyd8B4dPB7zPK3GnQ0VdReoWMgzw5H0mfAFCAnTYxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D4a2Xx8wlNkjEyHh2u62pluDZKBuM6zxiAfp2vBYaz5w5nAN3CSAxDRWbhKzqQfdJ
	 ZkeSlmxZvPEs8QEMfgnYDr/H4aV8aDUb8xxqKrlIYOT0dI1BG5A/K+OiA9B6kRRC/m
	 KR5vNGtXVcYteDWgseoiDC4bJfRyxAPHFpGAEGhKjaZF2orgu8kKI5Xc9slsfU3o0K
	 vdRNC/EqH+XFWlnTImzMagfEPaJuzyx+ptIFO1FSXeJ6jII3LhHQLC0LPZhzzSdRb7
	 KgJrG40KBjbELmwH7ISVI+iX9EodOdlzk9w2muKv3jkp2YbVnmM4NJSdmS5lZOhMUL
	 ofXqwEP9FVrGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BBE2380AA4B;
	Fri, 16 Jan 2026 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net: phy: adin: enable configuration of the LP
 Termination Register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853482104.70930.5256956372119132801.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:40:21 +0000
References: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
In-Reply-To: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
To: Osose Itua <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 jerome.oufella@savoirfairelinux.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 17:16:51 -0500 you wrote:
> Changes in v3:
> - put bindings patch first in the patchset
> - update commit message of the bindings patch and improve the bindings
>   description to better explain why the added property is needed (as
>   suggested by Nuno Sá and Andrew Lunn)
> - rework bit clearing to use phy_clear_bits_mmd() instead of
>   phy_write_mmd() since only a single bit needs to be cleared (as noted
>   by Subbaraya Sundeep)
> - remove redundant phy_read_mmd() and error checking (as suggested by
>   Nuno Sá)
> - remove unnecessary C++ <cerrno> include that was causing build issues
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: adi,adin: document LP Termination property
    https://git.kernel.org/netdev/net-next/c/7376ba2db168
  - [v3,2/2] net: phy: adin: enable configuration of the LP Termination Register
    https://git.kernel.org/netdev/net-next/c/a6733836527d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



