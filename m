Return-Path: <netdev+bounces-92309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3C8B67ED
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D21A284252
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105221C33;
	Tue, 30 Apr 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2kjgj49"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DEC14F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=LaVYTcyS6BJquyATbhEds+qvYCVUOJKToI8z7Un2Bchsb9xoNgfo+i7GeNOEYL4lz3p4Xszvt1M5+yrxItAmn5k168VCAaMH0fD24FYFR5lS/zl6ZBW33ZqECFcVQUIcfoLpVPjqGuNb4F9WNcti2q1/p2EFvHfntmK0GtjZAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=mb6I6JGQCxD/QwT/OivW6cj6wpg9v0tM9yE/7iYPjDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6uXi/sCiQ08UoZNmnb5enjacgyF8Cb3lCPWBlB8R50YdmzKqHrwXwYljGbp5LwdgApqW4Lql1k6rT2ov1tEGPpcWJHPDBFYbtHD08X7IClGScegOMH/b3cFWkkg13mhBzomcSwTGhFbav/mEDOE7w3GQnGY2LeJ/AWp1/3XuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2kjgj49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 626FAC4AF51;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=mb6I6JGQCxD/QwT/OivW6cj6wpg9v0tM9yE/7iYPjDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2kjgj49ffjGI8Cn1kCToW+FdsZPv1cYq1OAs7H0u1xRbBOpfPibeeK/lOlBhZETt
	 gRH+k0dPst2/nXq7008sIbr1c8VoviBtVLiyQYmzFXoJ2uv4vPhEaFcwAV99VW/E6U
	 hUmxe5UHFd3YXR8zd34vls07b1Q2c5eOpYB3U1VdK5ZTxl4TVOqZhhtU4gzqPFHcjw
	 KJ6iXZvwiRtmKGFkzpe7sP5VoWasaCE8pfPAe49nPcWhAahErVtGUEMNS0VPEpdARR
	 OgQD41LkYvIiqFbrnhpq54uZiDna/WRzA0qw0KbfpDp0GKps8xecN3IDuFH6XBBkOB
	 lzesCkFjgzutg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53CE5C54BAF;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: use phylink_pcs_change() to report PCS
 link change events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363233.30384.9324866389120590859.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <E1s0OGn-009hgf-G6@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s0OGn-009hgf-G6@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 17:17:53 +0100 you wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: mvpp2: use phylink_pcs_change() to report PCS link change events
    https://git.kernel.org/netdev/net-next/c/45f54a910626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



