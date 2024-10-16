Return-Path: <netdev+bounces-135918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD499FCA8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ECA1C246CE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973314F135;
	Wed, 16 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+0K7sSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF121E3D0;
	Wed, 16 Oct 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036828; cv=none; b=Ee2KTSzIRYCsb2Agleo/haAY1NFbBFm+FNpgkvEQvO3Vm0PrDbb50NTOCBAkM9zKyAXWMsn1ARvHabJIZFmm4WGoZoMYi2sN1IQ95xXfcWpp8Pm+y2LuUOaLrjautd6i8oZe/YUJCLrdnteZ2o0ZM0B7T1goz8JqCRUkdTiSAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036828; c=relaxed/simple;
	bh=iLzjeD08XgzwYfYJ/ySW3OrdZ/dHSf+eu+YEKuCsMgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QHeK6XtXJ7VjwQKt2SHcM9DtFn2yFvcOQcdtOMU1a6Nwhx1OQ913xABsBiouMl7ohjGljlGFWR2lxNvP2NTw7g+ZoGRIUdDPluNTulNMXUo1KOpveBIoCqn/oFZKd3QyM1vh6yjErmzVts2FICSeevrP8kJik4e/3/Yh6NhVMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+0K7sSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20B8C4CEC6;
	Wed, 16 Oct 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036826;
	bh=iLzjeD08XgzwYfYJ/ySW3OrdZ/dHSf+eu+YEKuCsMgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+0K7sSO7Mx1kOcnpEJeImKwQSDqUeQ056LOZknRUnDEt+SL8/i0h/6FG+J5Ls3Lg
	 MzeDHR5LgvNd5VFB1w1M5Mt4i6FSJ0L5HCt3nUz1y7TDbLKfnTIB2Ir097M3sewBvL
	 Fo1hlrZ9cAlZUoU+flJ66hQbW/BFN0xsdE8D3fH8gqyGMXKwdDyhDquUF5lb9nDV/v
	 VTS0iR5QizYsgt0iZoQB6qSF0z3FxfkT1oeMvD0cq3wRxrS9mRqybyPYOIToZEZBwv
	 Hch9dxccSaZz2mDKEhhcNHMb6Uky95NbrNf4v0+ZIhe7QBuFuQrCIfieHunE5urB/x
	 uywIZolTP2n0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346FF3809A8A;
	Wed, 16 Oct 2024 00:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] cxgb4: Deadcode removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172903683201.1331690.5089222534696448272.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 00:00:32 +0000
References: <20241013203831.88051-1-linux@treblig.org>
In-Reply-To: <20241013203831.88051-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 21:38:25 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a bunch of deadcode removal in cxgb4.
> It's all complete function removal rather than any actual change to
> logic.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] cxgb4: Remove unused cxgb4_alloc/free_encap_mac_filt
    https://git.kernel.org/netdev/net-next/c/65950f275f4e
  - [net-next,2/6] cxgb4: Remove unused cxgb4_alloc/free_raw_mac_filt
    https://git.kernel.org/netdev/net-next/c/b4701c6359c8
  - [net-next,3/6] cxgb4: Remove unused cxgb4_get_srq_entry
    https://git.kernel.org/netdev/net-next/c/10f6ef31f861
  - [net-next,4/6] cxgb4: Remove unused cxgb4_scsi_init
    https://git.kernel.org/netdev/net-next/c/835c16d137ee
  - [net-next,5/6] cxgb4: Remove unused cxgb4_l2t_alloc_switching
    https://git.kernel.org/netdev/net-next/c/625bb8a9e100
  - [net-next,6/6] cxgb4: Remove unused t4_free_ofld_rxqs
    https://git.kernel.org/netdev/net-next/c/73929750f236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



