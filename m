Return-Path: <netdev+bounces-117503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6C94E235
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE11C20A0B
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95511537A7;
	Sun, 11 Aug 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhYK9zjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C70152165
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392772; cv=none; b=a9veJgQHESXidPOEtxA2fsg5f4vWIAzU9oRNvy4H8Gaj6Tl9d9TwcZjztGm9xNshcuCsc57zBLOAwp0WA7UaKn4Hjvsi6DBDGtT78FHlWjenVm+jYUucRXAm7lasCXe1sQJ3/DwgB3g46qmwfO5EojtZw0rmkuQBuGyUqouqpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392772; c=relaxed/simple;
	bh=dJKSqlScRjhp1FPLhaRNXpQI7RzSYlSrLwyzJg8pWn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4FeY+bpIkbhbcgjIUZOQ5uDE34ij6jsFItq2PER1GeN8UviImATWe3IGVupj7EyMWObe85WwpbmizqF0PimDnaxtLrwR6wT0X911YyaWHEv32h9a1u55jzB4oBI9cqOXLS+CdMWqyTiRbbLRczjJJxGunsMZ/N6cBsWPsExMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhYK9zjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064ACC32786;
	Sun, 11 Aug 2024 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723392772;
	bh=dJKSqlScRjhp1FPLhaRNXpQI7RzSYlSrLwyzJg8pWn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GhYK9zjQkV25GM31ksk6pGWGnoTl8wE4IhgmWbZLM3e1Ln9f8FsBieSD0MHUn0nM7
	 3ZFCcysGuJZzIJPlAmX1UcIBhwXw7yNNSeDgKgE43bmS3H1YPioyRcqDEu8XEXX/e3
	 RXHJVq+lkh50TestX7hqS4LnMUa4sKAjFtqSdxzzAjDoFg3SMzGojV1N5WsIlfOtS0
	 krQy8iBgtnRHbj6Q+JUjfZ8LVVRe57WIrO5JPOi3Bh1JDgewPU6slFZ5yCY6u5doON
	 fENVBfPV8osKwamCKPViTNYJd08z+La4GvWngPC6V1vagKO4m4hTLehgYvWp9AQH2A
	 woVV2xlbPfrVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D193823358;
	Sun, 11 Aug 2024 16:12:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phylib: fix fixed-speed >= 1G
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172339277106.219113.811510760004372996.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 16:12:51 +0000
References: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
In-Reply-To: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 8 Aug 2024 12:40:36 +0100 you wrote:
> Hi,
> 
> This is v2 of the patch (now patches) adding support for ethtool
> !autoneg while respecting the requirements of IEEE 802.3.
> 
> v2 fixes the build errors in the previous patch by first constifying
> the "advertisement" argument to the linkmode functions that only
> read from this pointer. It also fixes the incorrectly named
> linkmode_set function.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: mii: constify advertising mask
    https://git.kernel.org/netdev/net-next/c/aa9fbc5dd9da
  - [net-next,v2,2/2] net: phylib: do not disable autoneg for fixed speeds >= 1G
    https://git.kernel.org/netdev/net-next/c/6ff3cddc365b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



