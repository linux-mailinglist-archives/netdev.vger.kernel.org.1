Return-Path: <netdev+bounces-250422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C2D2B06C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF75B30704C6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433E344053;
	Fri, 16 Jan 2026 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAYmCB2f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187634403E;
	Fri, 16 Jan 2026 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535623; cv=none; b=NR2bJgq2D3+YzzdoozxQvjMwA7vhe+6gmboiPyctC+EfOpCPUmevX8FxJAut33SDrkYGNXWk9qyARmFvUSGFnHe/ASZUBKDbnPT2MSOFB0BdP5kJAyIF+bK4NBbwD2ZZB3lFShSCTAJJ0bHMQyZf9XCXvex+x4KsJtCczvJOhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535623; c=relaxed/simple;
	bh=BL83QA3J/K3M/g7RWyYOI368jPKHfHfqOTz0Zfvm+e4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p4ZwirUsaitiJbSM9b4vtTYCj38g+meZxlR7U9jQbGHunxUP7NztxEAKMrPpvUT4tmPgA1jshplnqBltoO+w8XbSiCaElYO4C8kI5VdUI4lSXQ5VTjJkcAd54BTAWDJq+cuKmzcYmfy7k/KWdn80Om1umu1Hh5eQZeZJRXHSu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAYmCB2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53735C116C6;
	Fri, 16 Jan 2026 03:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535623;
	bh=BL83QA3J/K3M/g7RWyYOI368jPKHfHfqOTz0Zfvm+e4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAYmCB2feLv7LjxvgZ0ujzQZBSCxR6qMFc5QLBh/UtAzT1OfT2PO55CYUMcls/Ywc
	 6RSWZ4YE23H2vm3TO3khorHLr13V3WDiSG15X0ucGaFtBlUHXUnXvRm9HCjbiYEbX9
	 qlgZQ/P015FQhw+G6F9hWCFZHRkKq6TDRNBpYCDmvVHgmdY1ZRZzyq3f3xGbYYu6rK
	 qoGSg8RyYjNf2bFPsH0xEPRaxspLAU6ZzjzI9i2DvddAFbwKD7n2DxPDg7MXpONWhR
	 OWVOscY3/sL7UT388gofqcHyKFOAIqf1AwtgKbEuCHtOjnuIgyqifOj9uZx5snx+mn
	 kIH+6B5Uwqhqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78860380AA4C;
	Fri, 16 Jan 2026 03:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: dm9601: remove broken SR9700 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853541503.73880.8065779196205635793.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:50:15 +0000
References: <20260113063924.74464-1-enelsonmoore@gmail.com>
In-Reply-To: <20260113063924.74464-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, peter@korsgaard.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, liujunliang_ljl@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 22:39:24 -0800 you wrote:
> The SR9700 chip sends more than one packet in a USB transaction,
> like the DM962x chips can optionally do, but the dm9601 driver does not
> support this mode, and the hardware does not have the DM962x
> MODE_CTL register to disable it, so this driver drops packets on SR9700
> devices. The sr9700 driver correctly handles receiving more than one
> packet per transaction.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: dm9601: remove broken SR9700 support
    https://git.kernel.org/netdev/net/c/7d7dbafefbe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



