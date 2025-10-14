Return-Path: <netdev+bounces-229376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361FBDB513
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 318D34E3231
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D99306D36;
	Tue, 14 Oct 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnlTStHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8B27F736;
	Tue, 14 Oct 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475021; cv=none; b=jelSFZrVe2AZDznSVjwHh84dYBBSh6gT8ror4MQFWEmg6JK/43cgV1321ZOgqpFWhlP9Kzc51Eea1iw9xl5qd8Mw1z4DvSsHDKkoc1eYPB6vEYJxoc9l8Nt2NV/PxZ6+fdG75EWlIA1+lTHHcf7ChGyXJYkEE7ca3FaT6kGFwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475021; c=relaxed/simple;
	bh=pUZy9tdk4f39b5vD2vlJ6uCU8Q+eks0yazNcf05FS+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxJM3pBZc5Fv71X/iJScmooVCf0RohPVcdaMRGjbxCdPNYn6EXy4zSclcgf0N909TBH4/GpERerKrilAJdlVfEKyKH4KWP40jsKBcv8yz0g3/OI4t6hYeZReCYLKgqR0CPMZ2pH5C5MJEDN7MZGTNrZHZYiIrxm/EpZmQiIq2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnlTStHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16847C4CEE7;
	Tue, 14 Oct 2025 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475021;
	bh=pUZy9tdk4f39b5vD2vlJ6uCU8Q+eks0yazNcf05FS+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SnlTStHO1aECjfnAfqYP27nfOEIcO4c0qT4K7cjiRR8XSkDr6+NFTe00+RFLFnHiy
	 gim8syMGGZmyHdKu32QQfD1GW0Jdb8qNuleNakomcy+B5HLkCxepRhyXWKgGn4R4mD
	 Lxek+Y50EkP2RJbzdmMtLIcyAqQWOV2nINAtr/a+fRgRrgAxg/Ol9njW2NTn6yNwPc
	 49wT9OmKe68ROTMNhwU/ygmICfBWBMxf4qXpuUd7GfACwnRcd6dC3NRVDVWQshojSV
	 8gkSQdaDqO8trRqB//l75g9G8IVJXXqF1pk/67DTWQGD3c3u5DoASn7Iq3ceQgN3Ho
	 SUfH/H5OWIXqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71746380AAF2;
	Tue, 14 Oct 2025 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: b53: implement port isolation support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176047500627.92082.6355801879246780611.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 20:50:06 +0000
References: <20251013152834.100169-1-jonas.gorski@gmail.com>
In-Reply-To: <20251013152834.100169-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 17:28:34 +0200 you wrote:
> Implement port isolation support via the Protected Ports register.
> 
> Protected ports can only communicate with unprotected ports, but not
> with each other, matching the expected behaviour of isolated ports.
> 
> Tested on BCM963268BU.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: b53: implement port isolation support
    https://git.kernel.org/netdev/net-next/c/bdec4271e808

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



