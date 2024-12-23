Return-Path: <netdev+bounces-154098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8379FB415
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4231881D12
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDBA1C5491;
	Mon, 23 Dec 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2VhLX74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249951C4A36;
	Mon, 23 Dec 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979231; cv=none; b=tqkcxdqkhRnEmync3s8x1y4VDYm4wb/TR79T0OaIWnvudC92ignBUPJpgMQlC1lR2YaEx3VGvda2BkDrjQFRX+B9AsEuMeBCVBCfCUNhrvC8AlEBMz5Q7HEdGkCJo3Xk9waXO/W1vS4npGA+y30k8Ep0tDkqux2vdekozmVHxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979231; c=relaxed/simple;
	bh=iNwglH/j4fNdH17HXBw4AZOYbI58RxayZsD+6yrrLGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZtUz/X71DLIaf+t+1GzKwUxb4VHij2G+qEqO+TvhVbwZg79hSKe5atbqqKDBcnAsiANzuy6ovKc3+HLMZqz/pJwdKW+ZaX+anQ7oUABV3PuPD/pJ+/MliiyPqN7d+YbjYWOh1c7XHN2chHoV8vyejRfDqev1qjDP3nnK417ieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2VhLX74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA2C4CED3;
	Mon, 23 Dec 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979231;
	bh=iNwglH/j4fNdH17HXBw4AZOYbI58RxayZsD+6yrrLGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2VhLX74gWwRfOkOyeoaKOsOIbV2fpP8cURRXG6A8LgGXDOL5QxDrJpxnC34/oum0
	 CyVwokgfE5KJIGSZKXG0yGCWf9Zu1o57wzFvuIpYasVfFssOUbfNB3Z2dy5t6KCD+a
	 EP8zW8oGz2cY8GQGuV3EWqkbczdUz+v1JxM+uJWyns9uO3eNEE+kurUwvpUvGy2+ka
	 0uq679i46UXs5wSLfbuTJWcpqw5XKYqZarZXw2sg8jLGHDkGEY9ZnNouCuQH4Pvlke
	 mv5wTo5Gd7nTnCNuziczdEHmIGE1bBu2AARsQSh8ujsrDspNO318QnkbsPwRMlZJAA
	 x7zfLFJeY+B7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8A73805DB2;
	Mon, 23 Dec 2024 18:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/5] Add rds ptp library for Microchip phys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497924924.3927205.5120013224832919837.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:49 +0000
References: <20241219123311.30213-1-divya.koppera@microchip.com>
In-Reply-To: <20241219123311.30213-1-divya.koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: andrew@lunn.ch, arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 18:03:06 +0530 you wrote:
> Adds support for rds ptp library in Microchip phys, where rds is internal
> code name for ptp IP or hardware. This library will be re-used in
> Microchip phys where same ptp hardware is used. Register base addresses
> and mmd may changes, due to which base addresses and mmd is made variable
> in this library.
> 
> Divya Koppera (5):
>   net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp
>     library
>   net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys
>   net: phy: Kconfig: Add rds ptp library support and 1588 optional flag
>     in Microchip phys
>   net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
>   net: phy: microchip_t1 : Add initialization of ptp for lan887x
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/5] net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp library
    https://git.kernel.org/netdev/net-next/c/d46ef4ee381f
  - [net-next,v8,2/5] net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys
    https://git.kernel.org/netdev/net-next/c/fa51199c5f34
  - [net-next,v8,3/5] net: phy: Kconfig: Add rds ptp library support and 1588 optional flag in Microchip phys
    https://git.kernel.org/netdev/net-next/c/2550afc61ef5
  - [net-next,v8,4/5] net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
    https://git.kernel.org/netdev/net-next/c/85b39f7593e1
  - [net-next,v8,5/5] net: phy: microchip_t1 : Add initialization of ptp for lan887x
    https://git.kernel.org/netdev/net-next/c/9fc3d6fe8029

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



