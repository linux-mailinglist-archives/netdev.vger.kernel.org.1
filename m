Return-Path: <netdev+bounces-182898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BFA8A4C9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68887A490C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A129899D;
	Tue, 15 Apr 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vcf2cpB2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993617A2F8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736395; cv=none; b=IfyX8Q81s2EZxlLxlkbP0s/3sIAnjXdwDdlMvBQiy4Q+LDLJx6vhK1a79dvNHbhbQwa/9AM6kvks2SJOXjaC7auQsKpOqG41szCF+YMcPUBrJwFwZCzjGlVScFBq7UAtWM50T0Fx6vGEJWvsEKQ+KOykXnwreT6uC/pDrVTrBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736395; c=relaxed/simple;
	bh=QGlq9R0R8qTIYSOTBZMapKKqj5tjqjmL/lpcoOrOJdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aqIf/naFKJuxcmsXEXaTwhXdiiBseJoc6SMFzSjxGutOdKOKTSJnNjlsbiYaVD5w2XKZJ1qkKwNXMdDj58LVqQtfweZmFmOqH58NveNScFNTMmUj90vGK8D79pE6KuP9p+AhbbIRmt7s1hH8EwXOb1pOzWrrZVrNoBkmHmZ7nsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcf2cpB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB09CC4CEE9;
	Tue, 15 Apr 2025 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736394;
	bh=QGlq9R0R8qTIYSOTBZMapKKqj5tjqjmL/lpcoOrOJdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vcf2cpB2Bgs2Bw04iWCBKWo5OkWiDsneKNU1A/aduPKetDy7fK1gohzf0jwNJKwX5
	 Mvi4hhJUOakDcRxTENLHnI5SdGgZgBNIUxqf3J4LBSNmxemrKMIg0kOZjBltPQft+4
	 dSEw6jVGAMpo/nCe+dkTlucNrA+5UISpmrMUqWmtd+tJTwyGr/J1XgfxNWzQJgJePy
	 EnlBCB+GcTjfpFLA0Hl979pGZpqZKnyJRYpJdZGR9r6CmgMXkswlBfArmbMx2PWtql
	 9dQNTVNLXHQBIhyCfdU+SL1tJe22ke6U+1qNCl0tp7fzDG+j42qsJ7IpXzxa7P+bPb
	 pFejE3xrnEucg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE693822D55;
	Tue, 15 Apr 2025 17:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeon_ep_vf: Remove octep_vf_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473643278.2707730.12989256432227950338.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 17:00:32 +0000
References: <20250414-octeon-wq-v1-1-23700e4bd208@kernel.org>
In-Reply-To: <20250414-octeon-wq-v1-1-23700e4bd208@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, srasheed@marvell.com, vburru@marvell.com,
 sedara@marvell.com, sburla@marvell.com, linux@treblig.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 17:44:48 +0100 you wrote:
> commit cb7dd712189f ("octeon_ep_vf: Add driver framework and device
> initialization") added octep_vf_wq but it has never been used. Remove it.
> 
> Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
> Closes: https://lore.kernel.org/netdev/Z70bEoTKyeBau52q@gallifrey/
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] octeon_ep_vf: Remove octep_vf_wq
    https://git.kernel.org/netdev/net-next/c/bbfc077d4572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



