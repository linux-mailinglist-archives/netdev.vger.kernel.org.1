Return-Path: <netdev+bounces-188327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA09AAC2D8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28663B3EA2
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBA2797AA;
	Tue,  6 May 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYfbhagg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E3221D93;
	Tue,  6 May 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531595; cv=none; b=oUKyrWSvpng7VDHgyi0z54a+oR0QJN9O/hSI7Kmo0F6sPdIjgTgqissXZab2oTmrXqbRJ4Xo/YhtDJvRiqhsqzxs8MyK9tYuh0bnlnUoxsTrXYLLlJ/QcuftQDcXm3G1N96uIwJ2mqrCrNo0uEj+BYQD3o6TpigTqrGoXQ8s1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531595; c=relaxed/simple;
	bh=miH0hOl7818FNbHGRDY+t+UmxhWkUHjxTFCHlEY+fUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGlwmX7iJPwsj7n07VWdHZ5jY/gj+uUVl5aajQ20DVo033WHsyRjxrCyNtrE8c4Sg50puOBgeO2u2pZfGgTPmz+kft7rhnbY7l1mL30O9CT0900oa0PLRGAxIrYH4AeUP5qhI0wGEvRZrAltbh4thBGyWkKiOS7OF7VD/hSjqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYfbhagg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1142C4CEE4;
	Tue,  6 May 2025 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746531594;
	bh=miH0hOl7818FNbHGRDY+t+UmxhWkUHjxTFCHlEY+fUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BYfbhaggRTKkRMylzFAxQ/mPG5uY6tKx17ga5qUwKaQOj8ccaNruoxHRrW0aBE7R3
	 UAIC8QcadFDiAzFaNt5jyE5JRt7208FqLxqcxyJqRlSybUzlhMdqYfWtzZOou33ocs
	 mg0GlVunr+/zBsA/T2TNNDgQcWt9CFaKMc7VHg/dXdW1QKYHyO6QW582PsC6OI/n7N
	 33oAFdA5EOvn87hV3mm6LhhCn/69X/MnJwjFe7wSpJVyPykU8Stvv+W69+KdFbwVDy
	 E3L3h+ch9RJylM9gwfD45D0r/WCNIs8z+96q3xlPPtuEkvWOfiOhUFusWbYL3Paoug
	 BgiyXcK28/RIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C88380CFD7;
	Tue,  6 May 2025 11:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v7 0/6] net: phy: realtek: Add support for PHY LEDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174653163399.1488563.15219009456248413531.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 11:40:33 +0000
References: <20250504172916.243185-1-michael@fossekall.de>
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
To: Michael Klein <michael@fossekall.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  4 May 2025 19:29:10 +0200 you wrote:
> Changes in V7:
> - Remove some unused macros (patch 1)
> - Add more register defines for RTL8211F (patch 3)
> - Revise macro definition order once more (patch 4)
> 
> Changes in V6:
> - fix macro definition order (patch 1)
> - introduce two more register defines (patch 2)
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/6] net: phy: realtek: remove unsed RTL821x_PHYSR* macros
    https://git.kernel.org/netdev/net-next/c/f3b265358b91
  - [net-next,v7,2/6] net: phy: realtek: Clean up RTL821x ExtPage access
    https://git.kernel.org/netdev/net-next/c/7c6fa3ffd265
  - [net-next,v7,3/6] net: phy: realtek: add RTL8211F register defines
    https://git.kernel.org/netdev/net-next/c/12d40df259e3
  - [net-next,v7,4/6] net: phy: realtek: Group RTL82* macro definitions
    https://git.kernel.org/netdev/net-next/c/8c4d0172657c
  - [net-next,v7,5/6] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
    https://git.kernel.org/netdev/net-next/c/be1cc96ddf82
  - [net-next,v7,6/6] net: phy: realtek: Add support for PHY LEDs on RTL8211E
    https://git.kernel.org/netdev/net-next/c/708686132ba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



