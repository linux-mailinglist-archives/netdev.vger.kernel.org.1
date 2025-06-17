Return-Path: <netdev+bounces-198360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4EADBE41
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1783AE4BA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4313C816;
	Tue, 17 Jun 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5yGtChH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8CCA6F
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120808; cv=none; b=PP9pzs3o7lYe2i3iCVQrJv/Oe+omW4iN2YYYI7ZR5ZaVnD0U78b0Q6+Kr66LHGBdiKyDsYymFQxll+QGiZ3yw4vG9EOokDD+b7kuDCQOUwOk+urYoS6ocWgdO+2OhE08v6ceqBSymzG7cpGmmiIPDNa0auWug5JjIBO5YJ7NvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120808; c=relaxed/simple;
	bh=R93D4QIzzbhBkP6xtRzQ1J53wmd+HS0FcqddlisJl3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FcWHSQ0FZgWR0YLogG+FHbgc2k+MZn+bjV+ZV2D5VVKNHne/UpTnYi+mbCf5w493ennoVCyE5WzRz1J+4Rg+uKFdfI5LCb9zGq9ZWqP3U3MB/062dQZr0Q7c7TN6VHKUKppRClfEuMwcRiUGAHuuhEstzObrJIJE5jxGtjUdqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5yGtChH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71590C4CEEA;
	Tue, 17 Jun 2025 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750120807;
	bh=R93D4QIzzbhBkP6xtRzQ1J53wmd+HS0FcqddlisJl3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R5yGtChHLPVqNgzh3vbbQyYy6QYGfFrp1zY9cghXQGuzGEm60JQyFM8CB+LQy/dJr
	 jiSc6FUfGmnfkuA3UXrA6CsR7LuVRx9vkfKKms/mhfLiljJgO1NgXBOturSH3IF2Cl
	 19xgpxukdgagprKbW/uAdNpMmH6CeDwB+A6d3dFwVFAywWy9Md36fCbhGQo1yvPylD
	 L9jnLrveFTcxTvYpRPxNFAvIFO0Xcd9gYGVu+mKkFoHvPE6zPlVVPvI8ANeri/dWqK
	 ktJkEassBbFj/5Gm1RkafGsTtuPrBoQctiY3+Cfe1cDdaT4g0KfM1lpp+y25PcMtr6
	 emmu5Jq79fAyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCD38111D8;
	Tue, 17 Jun 2025 00:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v11 0/6] CN20K silicon with mbox support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175012083625.2568342.81457433885900776.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 00:40:36 +0000
References: <1749639716-13868-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1749639716-13868-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 bbhushan2@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 saikrishnag@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 16:31:50 +0530 you wrote:
> CN20K is the next generation silicon in the Octeon series with various
> improvements and new features.
> 
> Along with other changes the mailbox communication mechanism between RVU
> (Resource virtualization Unit) SRIOV PFs/VFs with Admin function (AF) has
> also gone through some changes.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/6] octeontx2: Set appropriate PF, VF masks and shifts based on silicon
    https://git.kernel.org/netdev/net-next/c/25d51ebf0f54
  - [net-next,v11,2/6] octeontx2-af: CN20k basic mbox operations and structures
    https://git.kernel.org/netdev/net-next/c/e53ee4acb220
  - [net-next,v11,3/6] octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
    https://git.kernel.org/netdev/net-next/c/f326d5d86e94
  - [net-next,v11,4/6] octeontx2-pf: CN20K mbox REQ/ACK implementation for NIC PF
    https://git.kernel.org/netdev/net-next/c/370c2374bfa9
  - [net-next,v11,5/6] octeontx2-af: CN20K mbox implementation for AF's VF
    https://git.kernel.org/netdev/net-next/c/f8909d3dd554
  - [net-next,v11,6/6] octeontx2-pf: CN20K mbox implementation between PF-VF
    https://git.kernel.org/netdev/net-next/c/70f8986ecef1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



