Return-Path: <netdev+bounces-87839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E18A4BF5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2621C21DB0
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FD140868;
	Mon, 15 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOx+fHfL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD64CE17
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174630; cv=none; b=jNT3Hmz7bZAZL07JP4J1VdthE+F5nLFKedipGhDy8x2ISgN65rg+99ZO/Wosy1dRYmnnkfybMtuo7MoDRXzHQt2zTuidf8nuR+7oDxmS5XHkyj3xKE68+lwYT5pA+HZ66iOHP3i7dHlxdD35VUEI52CXFFZL6/GOlPfxlapPv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174630; c=relaxed/simple;
	bh=BLT40wdUlfvme8+Qk/IGnMouR2ELBFIYOpTD4oXPDk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l3eSlYjMYK5EfPLYIFAwyYE1ksu4kXjc2tvJpO/BK/+xBju9afQ/fjDuNQLYQbwbRVrQpKbvxRVk5yTbnrnEQXcRrWUc+OVBWod1/Y8reqlLd1mgYPXINFU/nSvLIt8gVprC7VBDHyh/zQsNIk7PedB1Ybfdr1ojVyJFQX7F54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOx+fHfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6D4C3277B;
	Mon, 15 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174630;
	bh=BLT40wdUlfvme8+Qk/IGnMouR2ELBFIYOpTD4oXPDk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOx+fHfLyUF/a0K7lfSS4zlHoRE/2PkrNXfXdcu0Woka3hgfQa887OvLaOK787mGm
	 nwT2/VFeUW5/m2h24EHfyNIwnEgHgfkOdGulA9vKaYsuGNe95Ll0MxP4EKU2at8eq6
	 OrS+q/TblybILmHNFSTUZL/S9hA3J2IBiLN95ueAv7BSAybrZd/10tGk9RcwNxrIpD
	 9Sx9YffKHit6wh2mf5b3L2WThkzeNIhKvyex8nzu4kN6uojil0iuHF85vwDAZtzyOd
	 PbGtdKOvHb47s8wdYv49gyvxVF0lTdL+2/oer+gaUak1TrHY3UT8UDVVmTI3YW5niJ
	 ZPPMt5C67qh0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7765C54BB0;
	Mon, 15 Apr 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: convert dsa_user_phylink_fixed_state() to
 use dsa_phylink_to_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317462987.17847.16681567491312671190.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:50:29 +0000
References: <E1rvIcJ-006bQK-Hh@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIcJ-006bQK-Hh@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 16:15:03 +0100 you wrote:
> Convert dsa_user_phylink_fixed_state() to use the newly introduced
> dsa_phylink_to_port() helper.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  net/dsa/user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: convert dsa_user_phylink_fixed_state() to use dsa_phylink_to_port()
    https://git.kernel.org/netdev/net-next/c/a788fafff56f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



