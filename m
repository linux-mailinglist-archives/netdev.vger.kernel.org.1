Return-Path: <netdev+bounces-227813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41ABB7D32
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE574A50AD
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE52DF13D;
	Fri,  3 Oct 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlHGidax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE42DF128;
	Fri,  3 Oct 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514423; cv=none; b=cs3dOIh9x7Sy0V9EThDma/0V0N3p1fqm7u1yUjd9U0103OoAMRswynBsZxsG6JUmIpD1zoex0YhEP4JUft/oggmWZt+556bclkPtHlu1F3G+mM15qEbVXWKU3xQen+9WoOCwvq4mkaewsJ+6a3vpTA7BKnZcuhMRF2Nx/Z5VyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514423; c=relaxed/simple;
	bh=GecTde0LWdZKHylj78jeHskxHfBTpN0ZQIUAes50qz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bzge0wqnb7SwDdUx87zWYVgOjjYV1k/BumLJ+Ij76f5g8RWotYsBGyeWOlCprDcwzDouKgrwj0MCLj8yC1Zm8uqcV6rEDLoFz6nOHGZywdc68CihBBxanpYWtKijvXRSdSyRobXzL1gLqRcrWjH1N+Lmq3i//4X9BVhhtz9rB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlHGidax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8D7C4CEFF;
	Fri,  3 Oct 2025 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514421;
	bh=GecTde0LWdZKHylj78jeHskxHfBTpN0ZQIUAes50qz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TlHGidaxC6KWNp2mHI0e3FgjafWc/rSwWp6jU2CpUkczW7MOxLVXjo4RnUCmeual3
	 ajne2os+ekU1DZ7lSitPB1RGqiZO2ZPA5+xZQr4aQDqtFN7qsb08UfZGg0sgfUCcdz
	 gKtmGRB671jO2XFm41VEWFfU2jZw+ugm6/2zoE8K4JoAC4IrszJicYjYWDpgOgSgQf
	 XMN6zmgj2up75DXC7OpMvj70RJJvsR70lmHry6wUTsbkLZriwIie4GCP2UDXqTlZ9l
	 HiItgW3RZNlkMJwuhyYeomXVgIUjm+gWA3oNA0YbYFcUOmQ9gfPEz4wudimdsk2+OU
	 +/+DYppCJnqMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EEA39D0C1A;
	Fri,  3 Oct 2025 18:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175951441326.20895.16161652671675865420.git-patchwork-notify@kernel.org>
Date: Fri, 03 Oct 2025 18:00:13 +0000
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
In-Reply-To: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Sep 2025 14:19:02 +0530 you wrote:
> Syzbot reported read of uninitialized variable BUG with following call stack.
> 
> lan78xx 8-1:1.0 (unnamed net_device) (uninitialized): EEPROM read operation timeout
> =====================================================
> BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
> BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
> BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
>  lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
>  lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
>  lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
>  lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
>  lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707
> 
> [...]

Here is the summary with links:
  - net: usb: lan78xx: Fix lost EEPROM read timeout error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
    https://git.kernel.org/netdev/net/c/49bdb63ff644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



