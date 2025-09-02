Return-Path: <netdev+bounces-219343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C26B4106D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2448526B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2327B351;
	Tue,  2 Sep 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eClenyOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFA27A916
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854005; cv=none; b=X7H7BpGOhCIRtjV5IrI5Pz8W8GjWiRCGexMgV8ktOewT0EkDj3V25hfsL7P7x8un4ItiaP36VEH2nYLyzuNUVjaxlHKxHgFrs4L0TIB38jbvu/7grp/8KC5H7Y5uFMfpfVA5kXYewg4ilw6IJDRAQvBFvyHQGw/ka4NvMTXCRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854005; c=relaxed/simple;
	bh=eLUyRBikwav/j3G5wwUdYMh0suVyvkQHBbYiOaRIGjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qoN8j6htQX1ziKRckJX06vL7YdZb75Ssjt1Em6i765+/Y3RWKuJi1JLe1VdQmZWT6fD2pFmanI5oTi9dLswZDxIgX/FDzMBx7qbNdjHMJVOxRk9uR8eO94EsXdsC2CLF1zLb8FZ8w5dq5R6LcOGKQogoou3d7hcwznMn0ZVzuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eClenyOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E558C4CEED;
	Tue,  2 Sep 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854005;
	bh=eLUyRBikwav/j3G5wwUdYMh0suVyvkQHBbYiOaRIGjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eClenyOzyyarpk3YBo/aU3SqnoPJ/wRsAe8dXswzD3Dw6pIYDVTOoTlJM8JbD/VdV
	 L13+aQ07IQEVn62xNb5g21kp58s5vGS16wuuP8GDBdDJzzdHIqtdJYvWUWpownSoUG
	 iZX9R/Hce8LRTBvBNNwrC0NL1ugs9qP+Ppx3rI3+H/p85mAnrfjMa9PXR34rez3NkY
	 sy5E9rwP7mz89naH2nrniSFJJWUzxGYRwgkRsOLkPceFjSmjRpVp0O9+QPH+gJY05p
	 sJ3aquj5+lZpmec9v2jD5Ss6IX8hKZSoLkcly3+1M79eeCR2XbvVjSzEY3LnFjr4i4
	 f3r+ry7Kevgrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00D383BF64;
	Tue,  2 Sep 2025 23:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] Revert "eth: remove the DLink/Sundance (ST201)
 driver"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685401024.461360.5129799426391558320.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:10 +0000
References: <20250901210818.1025316-1-kuba@kernel.org>
In-Reply-To: <20250901210818.1025316-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dkirjanov@suse.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 14:08:17 -0700 you wrote:
> This reverts commit 8401a108a63302a5a198c7075d857895ca624851.
> 
> I got a report from an (anonymous) Sundance user:
> 
>   Ethernet controller: Sundance Technology Inc / IC Plus Corp IC Plus IP100A Integrated 10/100 Ethernet MAC + PHY (rev 31)
> 
> Revert the driver back in. Make following changes:
>  - update Denis's email address in MAINTAINERS
>  - adjust to timer API renames:
>    - del_timer_sync() -> timer_delete_sync()
>    - from_timer() -> timer_container_of()
> 
> [...]

Here is the summary with links:
  - [net,1/2] Revert "eth: remove the DLink/Sundance (ST201) driver"
    https://git.kernel.org/netdev/net/c/8b3332c1331c
  - [net,2/2] eth: sundance: fix endian issues
    https://git.kernel.org/netdev/net/c/d2644cbc736f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



