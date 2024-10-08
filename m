Return-Path: <netdev+bounces-132998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3E994310
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740D01C24127
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A491D271C;
	Tue,  8 Oct 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieP9JBbs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A0381B1;
	Tue,  8 Oct 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377429; cv=none; b=KZklvXLtXEq2YDKq+f+4zqHURrnrNRcku/VKxsEkRmhLD3hVXzvQqmYxXfUjU4gWwMp9L6+yK9NYAJ9Ud0vc3pG/Tl+G6jBBfgbB0KSBtIu8V5/hSygYVrtlAV4DIUdoh1NrEADartAkC0qBlDMQV0dxAFUl1l/khKqEXlpzZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377429; c=relaxed/simple;
	bh=2Z7rv8bP63dxEAtHSU/euG3Nmgc6V7vHPzB+0jRf79E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8S3b4ueOz9iIPOCNymSI1d6ncgN+GKS9VeAInkZx9HgKqdaGYT2/Uy0khhsAORrU5nqkAX0WnTLK/KlHKABSpDl0ux0hbDKWkHLl3gYsu8vVgXcXPsEJt+ZJXpjluC66GHTLbfPfJZl4AKXKlLj6tnVhMIC3d2YZnK3x9o9GAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieP9JBbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905DDC4CECC;
	Tue,  8 Oct 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728377428;
	bh=2Z7rv8bP63dxEAtHSU/euG3Nmgc6V7vHPzB+0jRf79E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieP9JBbsU28FMjPaxsVWdRjX0QFNb24TPYkl/lWYgSads6vg5hw6OkADLnPvDDxtn
	 93XNBxh8PkV1IhHz4TbtKh3qshU+lHZSr2dkdHYr8nW6ixdEUozLgWRmpYsI8zjXI5
	 1rdJ6x7yYdUzlDUJ7mdlKQEXcs2hTUgCDQh4QNmiKLo6jEWjbRpuYquEzIL/4TIDZy
	 OzVpg7xUPG+yxIG4HOr9CxpqST7rxdRCnVR4gbgToIKWAULVeXcbqqo0wtGskl2zpY
	 c9N5BruCmw0ACp51ulTlVX9NfT5dkUtLgYroqofXZCYxhNkGqUcdqFrOcVqxZYjHC+
	 rCSvd8JqgOnPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB13810938;
	Tue,  8 Oct 2024 08:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] net: dsa: b53: assorted jumbo frame fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172837743273.451237.9546651713497729915.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 08:50:32 +0000
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
In-Reply-To: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 murali.policharla@broadcom.com, linux@armlinux.org.uk, f.fainelli@gmail.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 04 Oct 2024 10:47:16 +0200 you wrote:
> While investigating the capabilities of BCM63XX's integrated switch and
> its DMA engine, I noticed a few issues in b53's jumbo frame code.
> 
> Mostly a confusion of MTU vs frame length, but also a few missing cases
> for 100M switches.
> 
> Tested on BCM63XX and BCM53115 with intel 1G and realtek 1G NICs,
> which support MTUs of 9000 or slightly above, but significantly less
> than the 9716/9720 supported by BCM53115, so I couldn't verify the
> actual maximum frame length.
> 
> [...]

Here is the summary with links:
  - [1/5] net: dsa: b53: fix jumbo frame mtu check
    https://git.kernel.org/netdev/net/c/42fb3acf6826
  - [2/5] net: dsa: b53: fix max MTU for 1g switches
    https://git.kernel.org/netdev/net/c/680a8217dc00
  - [3/5] net: dsa: b53: fix max MTU for BCM5325/BCM5365
    https://git.kernel.org/netdev/net/c/ca8c1f71c101
  - [4/5] net: dsa: b53: allow lower MTUs on BCM5325/5365
    https://git.kernel.org/netdev/net/c/e4b294f88a32
  - [5/5] net: dsa: b53: fix jumbo frames on 10/100 ports
    https://git.kernel.org/netdev/net/c/2f3dcd0d39af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



