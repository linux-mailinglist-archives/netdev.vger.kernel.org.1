Return-Path: <netdev+bounces-207289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74AB069BE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D07AC011
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F082D46C7;
	Tue, 15 Jul 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJA48c6A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14D2D3A98;
	Tue, 15 Jul 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620988; cv=none; b=KWKVnvhpV/MwGcPd8UoykAivOnrr1iD6RB5k/KMGYVdH2dhue1Wu/s+zp2isvM9rY2XOflMl900jJpp/lubQffMel9wxfr1OYfnSI+pJgXRCBbGnCtS9RGgfYAKCocSr8i2M1oUqvy7gVZvbOy/orsnjTFYFdafixz8BmonEaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620988; c=relaxed/simple;
	bh=YOmnXgvM5vzlC1lpAL+tZsqNx97efp40hWXPIu9CvcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ruHZvxocOe0PGe3d6L5yqvxLbai1VSLvgn6KOlkvxQRPMWqIlY/r3JSOgGOetqv9V3rkBHC9RlW8YNcwYGbpSf0Xy6Bo1Ww//RGsQPmc50Qw/R4RAFxqrSlRtHONPngKWjRgrHLeQjBk02J71HN6bM+bTZcyXjpULlyGSFM2/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJA48c6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F0C4CEF7;
	Tue, 15 Jul 2025 23:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752620988;
	bh=YOmnXgvM5vzlC1lpAL+tZsqNx97efp40hWXPIu9CvcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GJA48c6A0td2OYMqxzln6V5/ObGmg0pk4PTEMKOcV4vyWHifqpHwk9wCgJv1ayT+k
	 VKJWtv/h01OgBXr5Th9sGbITc2F1q8OoCCOl+TLSGy1dpxpVQGM8mG5Do0Tqp/8HGy
	 vG2GsN/CEnWuvP4rxGpuvAMRjqESOAbt136t9Xf7GwGoRDjz2wCbvOKNaN7xCw1AwL
	 0SLklElIRb2042CB2p3FNVlARkthr1uP0/Mk8UNUtJ2drg7IWfRhKoxA8HIJc1ukzl
	 INFWwW5ThLq3SXlnakIMMjV8t30dKGYsVX/tBT2TfjL4kYpc0Z4loHXxahJ9zoY82c
	 AwbHsFVz+v5NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1FCC8383BA30;
	Tue, 15 Jul 2025 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] usb: net: sierra: check for no status endpoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262100900.609531.18066112974576940495.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 23:10:09 +0000
References: <20250714111326.258378-1-oneukum@suse.com>
In-Reply-To: <20250714111326.258378-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 13:12:56 +0200 you wrote:
> The driver checks for having three endpoints and
> having bulk in and out endpoints, but not that
> the third endpoint is interrupt input.
> Rectify the omission.
> 
> Reported-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-usb/686d5a9f.050a0220.1ffab7.0017.GAE@google.com/
> Tested-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com
> Fixes: eb4fd8cd355c8 ("net/usb: add sierra_net.c driver")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> [...]

Here is the summary with links:
  - [net] usb: net: sierra: check for no status endpoint
    https://git.kernel.org/netdev/net/c/4c4ca3c46167

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



