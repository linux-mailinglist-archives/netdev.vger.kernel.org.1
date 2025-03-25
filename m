Return-Path: <netdev+bounces-177642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EFA70D40
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 23:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8BC189BA10
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79161F153C;
	Tue, 25 Mar 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioAoJlp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EA18A6A8;
	Tue, 25 Mar 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942996; cv=none; b=c5W/SxeEj9GpRKywXD2AbhtLbyz2v1PMp+SYvWq+NvIid2c8vKJdyRGrjHo5ucfCpnBfY0olgDFOU1vdRL+D9V4Nxjx+Iv0BSitWxZIjg6Ip57JMWAUbakdsifnYK82Jf3N9sgkB7hhk1TGlCXdoqQkCdj7Y0HYUybwu8g/flXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942996; c=relaxed/simple;
	bh=co7FgKBtgXbqkUapCkD5XvQqzZnsGyQFzcLTxm73rOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cGlfjyRjLfsQc5z58A/5Jdz6llBk9J6k3PikKYN5iR/Hdk3qVtZwEx2XWpOumZ3DtVI4hDRT5sxkCe1ktmwlaXqCH8Tler6OkKaauBxqcgQV60oDyYmWMau20sZy7zWODmigtJd4JrRdDLQhPNXs+s45K1d4fGHRAckIysD16a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioAoJlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343CCC4CEE4;
	Tue, 25 Mar 2025 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942996;
	bh=co7FgKBtgXbqkUapCkD5XvQqzZnsGyQFzcLTxm73rOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KioAoJlp8TrQ2lQ5PkCok9PrazRfpeEGPMx6KBEy4tapX91RXJMZP22GvxLtutL08
	 P+kuhq9hHOXNARTF40rFSea7ykhpMNRsL97iQBgUV8+TI8ag6NsnuojGrU3hzRzpee
	 e1MBAb5CRAxSRrSnB7i+gjsxrvfC4rkRQyj4N9N7bXNhPXcTu5azqAhg0xCV/p79jz
	 NPJ5tQwvf+Ig85GolUzHmN7qqhl4wstXgD+hUamBWe/Edd3AnAL2zxDLoHxTkFcQvH
	 YRSla1gBrVi1QZqL9wGA/lkCMhla+Oad4ZUTBe5Me4Sfbi4etbdzl8iO/pwfXoUrVO
	 +/jc3W+iBmxGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF66380DBFC;
	Tue, 25 Mar 2025 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: usb: asix: ax88772: Fix potential string cut
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174294303252.764297.2012932671054650861.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 22:50:32 +0000
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 16:39:28 +0200 you wrote:
> The agreement and also PHY_MAX_ADDR limit suggest that the PHY address
> can't occupy more than two hex digits. In some cases GCC complains about
> potential string cut. In course of fixing this, introduce the PHY_ID_SIZE
> predefined constant to make it easier for the users to know the bare
> minimum for the buffer that holds PHY ID string (patch 1). With that,
> fix the ASIX driver that triggers GCC accordingly (patch 2).
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: phy: Introduce PHY_ID_SIZE — minimum size for PHY ID string
    https://git.kernel.org/netdev/net-next/c/2c5ac026fd14
  - [net,v3,2/2] net: usb: asix: ax88772: Increase phy_name size
    https://git.kernel.org/netdev/net-next/c/61997271a5a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



