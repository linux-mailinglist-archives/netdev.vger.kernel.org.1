Return-Path: <netdev+bounces-192640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0CAC09FC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7391BC3449
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC7266B76;
	Thu, 22 May 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfIED5gv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4D33DB;
	Thu, 22 May 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910396; cv=none; b=MrXwugO3II5rdGxwaSITjBRjQolWYdo3bBdLU1VXIGoPPMvNXHodpmK9M0UlZkoO0OFytR6qYPD1a15djdPjmOpLEaueDpABBe46VrcIxrWyi1n5jg1u0QxwtHQlG8QoB8SsrLxfmFgKzkTsnyq2JP/j/zZPp5PqOg58kMxH+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910396; c=relaxed/simple;
	bh=i5W9B6LIMsPJSGMDYbW8kgbjB8Bz5CGpjg8Q8kMy538=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ODXmZy4U2I+o4BDih62y+C5voxWeqCn9gQkiXcl+THAAmwrHimHj0mmn9I4xIc+pmjQy6nvL3meoxJnnvB8QdmFXnMvlKClC3Oh9tEPMHK83U2eFfbT/pSAjU198rHLb2HfDlbyxKVv10yyhHyge8GkLKDvS1Ajcmg01Gt/oFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfIED5gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75203C4CEE4;
	Thu, 22 May 2025 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747910395;
	bh=i5W9B6LIMsPJSGMDYbW8kgbjB8Bz5CGpjg8Q8kMy538=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mfIED5gv4wSrv8Xf/4v3FqCIyckUcu6zIpCBwpDmAk5srbst+25TAMTqvls+hOGqS
	 LDq7kpnBH+UNtOy21S9QSPamcii8IHM/hSpRbKE/Xrh2MWjSUPgl9kncMKO65CiUSw
	 R84GGI4oY3gGyG/RC3+FEOPU07dEjQ5zNF/2X8gi8KHiks+FrPiblS8+Yr4c+c8JDL
	 CURk+ywtcFUmsCzkbMYAPYlWA03XO9Pv3iFYk15K9dYjzOcZXlCk4k6bF3oAjQ9b/t
	 VVrZVwUU+YhgZOk+oikVztG+aFaFMwfc8XztvVwscesXTkaYUZ3VAVfb1/MKC3RYlg
	 bnSXX93SuD0mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B503805D89;
	Thu, 22 May 2025 10:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH 0/2] octeontx2-af: APR Mapping Fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174791043100.2826633.7493126881199350159.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 10:40:31 +0000
References: <20250521060834.19780-1-gakula@marvell.com>
In-Reply-To: <20250521060834.19780-1-gakula@marvell.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 11:38:32 +0530 you wrote:
> This patch series includes fixes related to APR (LMT)
> mapping and debugfs support.
> 
> Changes include:
> 
> Patch 1:Set LMT_ENA bit for APR table entries.
> 	Enables the LMT line for each PF/VF by setting
> 	the LMT_ENA bit in the APR_LMT_MAP_ENTRY_S
> 	structure.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-af: Set LMT_ENA bit for APR table entries
    https://git.kernel.org/netdev/net/c/0eefa27b4933
  - [net,2/2] octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG
    https://git.kernel.org/netdev/net/c/a6ae7129819a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



