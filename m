Return-Path: <netdev+bounces-88943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6E8A90D2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7618A283A7C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5A4EB44;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMAMN5V9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4D3BBD8
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=bVEopeiQY4uyYaNzG6qmnnm9k061SOj7k9gOXdQ0ZOSGNC3oRfnbHYg6L+bX1VEXSq7jZTofcbCezKQqcnQM6vMoznAM1M2YFzAPdRHt4OenRvLPs6N90q8qgumTyZ5gkERbAjlU760hMwe5C+E1cjMYjbsdH3rTnNdc2+x0mPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=tzYfF0e0RFgQt3/WeGtPAtiV3/DZV8QxqLV5w1GbV/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbCz1IXET4YH/FOMAimhXIZQ1V8AeMQrT2C0zF1t13ndmGcBhItS9sc2nhKCxvVHYjziediHP3vwR256QXrdNdG6LMQxUj+ElU8K8lBxbxBMDwiAqiASrSkOi8B+1zrhvrBOQaBOb3qY3bMrl/1GbigVArEvqkxVDfrnhC2kL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMAMN5V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39642C4AF0B;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=tzYfF0e0RFgQt3/WeGtPAtiV3/DZV8QxqLV5w1GbV/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMAMN5V9DrRIEX+XJ9UUyNJBA5a+oxLmoTLXGmjypLcreT5sL2XLuKWPaycyySGqh
	 +U2zPSZlej/zeUDodgySa9431nhy9yb6Lz38b1b+zwDCs1NPJgDubhzETj8jbR+ASS
	 XSJZH7dA++RTnwph2sDEzbLnu3mYXPPC3CXA604GNa2W1r7JUOr5KiZB14YbKpWbgc
	 FzBSlvCTjVc3flXmXOeW3MEkZP2dQRBo+eMxfAuhzWwmB5E+6gHfbBmmq/5ptIsVyC
	 4dEOx3fXhDvHIKTWszHO34hvyTU77FtgnhuaDAjMjmarid8GtQW5GMOcN9Ho9LvpQh
	 DQqgkCvZNn4jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28595C43617;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: lan9303: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442816.27861.10648287547352555044.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:28 +0000
References: <E1rwfuE-007537-1u@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rwfuE-007537-1u@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 11:19:14 +0100 you wrote:
> Convert lan9303 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c. We need to provide stubs for
> the mac_link_down() and mac_config() methods which are mandatory.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/lan9303-core.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: lan9303: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/855b4ac06e46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



