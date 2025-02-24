Return-Path: <netdev+bounces-169226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB128A43019
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F3D7A77CE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778A2080C3;
	Mon, 24 Feb 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGn/0Rpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C5207DF7;
	Mon, 24 Feb 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436203; cv=none; b=n6qabvpmNX2qC3Q/L25sVBu1MOIcDvPC14LIWEZhUrmHlhetWDVCEiHIlqt3XDl0xPtcDU264uAz3X1xjftN2lZZZZ4MYNkMPu9XLrohJkxupeWkrKnxYXQluGKXt/8tZTBDXRW8sHZwp8eKQNU4NK2jgP5+OI0eznpyRp7/spU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436203; c=relaxed/simple;
	bh=o3/XUGQL0m+SzquU2ZDcO4lPV6KEAziuUL08AurUYbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VnKCSCdyb6CB1ayQ39ah2O/JejO7lOIrchRaeQly2RP50NRjkbH62RLOznKNbNZsNSY1xyYFLkdTafJENLyJIirYJ53w6U8VEiUCri82jIxCBKDVdFB7OB5lIyCmn39xej106uskzsf6Ti4VX0BH1WpKv6ov2nAAr4qdp/3pcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGn/0Rpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC08C4AF09;
	Mon, 24 Feb 2025 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436202;
	bh=o3/XUGQL0m+SzquU2ZDcO4lPV6KEAziuUL08AurUYbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qGn/0RpawzHOsnFvI+rH6yVY8sEZBQ4Ru9LrvwomnSMOBM7gbURtsNY9Tltn1QPmO
	 7b4pV2JXHvEvlBzcG0GyAS17NEYI9ssMVLZdBocr77Hkrm5k7gQbEEVLaAu7SvxW1/
	 yTiGqcWzIszCb+0rVsvn4BrBdeONccFpI69Yk+rDPB05jmJNtAk0D43Z/pLcbaUdl4
	 Af6dWoKh9cva+nTOa6RA4ORrWVuwIJvsBa6ziNpmn9hL8tHtMdkI03cCT36xZ2lF9Y
	 4kfbRDe+YPyR1bd7yqQ7gbnk2MCWvLagTJkx0DATywvCPBs/muZq/qqLtMeaOBHncE
	 //vufIbOmc8fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6F380CEDD;
	Mon, 24 Feb 2025 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: Correct usage of maximum queue
 number macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043623374.3631570.5317337904130972259.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:30:33 +0000
References: <20250221051818.4163678-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20250221051818.4163678-1-hayashi.kunihiko@socionext.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, chenhuacai@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 14:18:18 +0900 you wrote:
> The maximum numbers of each Rx and Tx queues are defined by
> MTL_MAX_RX_QUEUES and MTL_MAX_TX_QUEUES respectively.
> 
> There are some places where Rx and Tx are used in reverse. There is no
> issue when the Tx and Rx macros have the same value, but should correct
> usage of macros for maximum queue number to keep consistency and prevent
> unexpected mistakes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: Correct usage of maximum queue number macros
    https://git.kernel.org/netdev/net-next/c/352bc4513ec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



