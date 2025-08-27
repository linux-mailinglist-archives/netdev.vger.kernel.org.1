Return-Path: <netdev+bounces-217103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E91B37612
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2421BA0D59
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A21DF256;
	Wed, 27 Aug 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZusrJqmq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177B1DE8AF;
	Wed, 27 Aug 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254010; cv=none; b=B2vJ91lXRXUlXTGOjKGW0n8BOUb4IUzk7XN8Svrj6yau6sFiRpdITEXPf7LPgORucr9Oypz2exFboYerBgg99OPKzi9Mbay5lV2cZKcMIesfnHvXh9v+ntvB1R6c4/dhDGAZy6J6MLG5KhPt5WdaQmOGjGa9Dhi8qgzmSZmzKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254010; c=relaxed/simple;
	bh=qzn2DrjAU6WNb9hxfKJXnZRZrbUxRt1DyNvYI3+6h14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NalycRhtcCFXcm/g+Rsj+baTByYfsm3OHFQWQddEVeNdXgWhAXnoHZw2+jDt7MTLANjSUq9xIJ0F+axz+RA1EKWFWAfn+OwpV83HOPSxrGL90K1np7KPDmirhlnHpd5deZXBGpJCoVvO6DTyiwIVK5SiizDUvKjYwpwJCf595mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZusrJqmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FC4C4CEF4;
	Wed, 27 Aug 2025 00:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756254009;
	bh=qzn2DrjAU6WNb9hxfKJXnZRZrbUxRt1DyNvYI3+6h14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZusrJqmqLuZrOwVrSZ/jUPUF3vm15pn8gBy/w6MGc8ZhYtS0YjbOaB89+2TsBCL0u
	 Erf0qofH9kAp0p6s4iVtyR7ZKx4rSGDvNeaS5yaEbTEOj92B76TQFq/9DLXOQvfS8a
	 k9N14F+atfcVg0J88eVKPMnT+ehyoYlxvyt7852cbJhD5a11HAGIWP34itgwUn2SNN
	 msvuo0ELL2ebFCEis4eTjq049CRD1KK4o1ieydrM84dqrWYakVf8GB5CO2BtaYBq5n
	 GVOJ1ZG+TG6up8W7qCupUvHXPJIhczdojfTiMkSgH2Mx85FCqIQNrcrRneFxqi+amD
	 GIupanR+UpBfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1A383BF70;
	Wed, 27 Aug 2025 00:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 1/2] net: phy: introduce
 phy_id_compare_vendor()
 PHY ID helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625401674.147674.14688569538445352363.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:20:16 +0000
References: <20250823134431.4854-1-ansuelsmth@gmail.com>
In-Reply-To: <20250823134431.4854-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 Aug 2025 15:44:28 +0200 you wrote:
> Introduce phy_id_compare_vendor() PHY ID helper to compare a PHY ID with
> the PHY ID Vendor using the generic PHY ID Vendor mask.
> 
> While at it also rework the PHY_ID_MATCH macro and move the mask to
> dedicated define so that PHY driver can make use of the mask if needed.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: introduce phy_id_compare_vendor() PHY ID helper
    https://git.kernel.org/netdev/net-next/c/1abe21ef1adf
  - [net-next,v2,2/2] net: phy: as21xxx: better handle PHY HW reset on soft-reboot
    https://git.kernel.org/netdev/net-next/c/b4d5cd20507b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



