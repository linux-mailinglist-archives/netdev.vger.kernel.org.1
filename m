Return-Path: <netdev+bounces-225437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE4B93A25
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90AC2E0F3D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD7296BBB;
	Mon, 22 Sep 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1DfjxTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729B270ED2;
	Mon, 22 Sep 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585009; cv=none; b=k8x511hyE93cqYu/ijbf14IhAB0pc0I7bgU5Jx0Jbji2msvzpp7upp8sqkjHgEzaH61DdRnXav51X/Dv+zVcJrY6F4r9BmtOb6rlKScWPlJpqUrYk3I1Lh6wCCxPk69bXmw3kN1CnAoRRZTN7RIXJicpUkr1jR18hfeeqgIbSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585009; c=relaxed/simple;
	bh=agCvfuj/ARGtO1UtAuT7xggF1OP1KAf3GXQ6Cf5ckl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kS3urpolb/fUzPGDiX6Mwhja5ciNwyIaqlA5xrhwimGBMoY5G6JHaUsBuyaDnnxND6ohFJaTunXSvJt6M2KqECp4SCE20CMkgw2Ox9CyCkCdt20i9I20wqkBWkSeTZM+WVPTaa2aKN/9L7E5Hm+MbbFMyhqVSu/cSrTO5PipOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1DfjxTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBDC4CEF0;
	Mon, 22 Sep 2025 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758585009;
	bh=agCvfuj/ARGtO1UtAuT7xggF1OP1KAf3GXQ6Cf5ckl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1DfjxTinxof/VMTg9RYGqyxl9SltZ98D73OOlH1M8KLw9JQ73V1Jt+xHYeMBCSQ0
	 3hHUxcdOGTmC9fTLQHXM9yjhdXo53iEd1Q2kGk7ZIuCnofloahEBNjWuNlE7j538pP
	 QG5POSSHZYxkQPb/9nYE2A2I9rp852w3bVfTDAgTUwbmPN64ZVXxa2o5ds7wLswoOX
	 Okz6Xwg7X9P792WMHnY3ZdnASzBOGWOILdAzhX9Y7qGwZVCWuxKpUKOUjVsDhCrS+z
	 z7dDtO4Ve7VHPxvVrvEZJ8MLva8SBGLZiRdq7200E7l3U1OOsim7jKWE2+7xBICOOL
	 5WMru3NABErXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFEC39D0C20;
	Mon, 22 Sep 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: ax88796b: Replace hard-coded values
 with
 PHY_ID_MATCH_MODEL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858500676.1197860.5339803741570254262.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 23:50:06 +0000
References: <20250919103944.854845-2-thorsten.blum@linux.dev>
In-Reply-To: <20250919103944.854845-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 12:39:45 +0200 you wrote:
> Use the PHY_ID_MATCH_MODEL() macro instead of hardcoding the values in
> asix_driver[] and asix_tbl[].
> 
> In asix_tbl[], the macro also uses designated initializers instead of
> positional initializers, which allows the struct fields to be reordered.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: ax88796b: Replace hard-coded values with PHY_ID_MATCH_MODEL()
    https://git.kernel.org/netdev/net-next/c/530ae8ec0e5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



