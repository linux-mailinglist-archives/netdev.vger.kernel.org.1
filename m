Return-Path: <netdev+bounces-242118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A2C8C818
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 916FC4E6ECE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931F2D5436;
	Thu, 27 Nov 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz5jvcM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5529DB99
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205858; cv=none; b=QC1L9FRz4MpNpJEfM+rPZSzSgwLTW5Xuz9Q8dNiGH95NLoRJcLUHtnQsRwv7iz3tvjUrcs8Xb2VVsFgZBfCFRjDq93Ur0IMRprWv2mMJpB8rBSyLa/JIdQ/Qle17ldPDvBEdwrlAs2eVjqX1BvuZBeAS124Wmf7Zcrr9gUy6nnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205858; c=relaxed/simple;
	bh=yKCEHdngMAr+ltUUbMY+t7A0R7Orer6Cs6bz8DaXyZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LvKWZJZTlSyBEu7BJtnBlyQsMqT5EeGfv4dlo4dHBVXOwTfmhOTIy7BVioFKNNATah8b270VFXUyyAqURL2DMQ6nEF6MQiKSH3FnV8wwiN7Jfo9dDXm0E4tHDOGPXX7IxF1ezWF6VgzBhr5VpktIspMMpIUYzRK92Hs4WynXMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz5jvcM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489A9C4CEF7;
	Thu, 27 Nov 2025 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764205858;
	bh=yKCEHdngMAr+ltUUbMY+t7A0R7Orer6Cs6bz8DaXyZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cz5jvcM7so59aycncDh8GyXd/2uaYnEbVQv6eR1Rb53T1UKFzDhdMs7+DGKHnlcpH
	 V6rURSudPwIr88frYn1RSkywdRcJyZiZXC0ewkrGFi9xsznVh0BtIeVu2kHWZrKr71
	 pzfcthhbatoIQCUe0pBJD0sBxlMKPHT/tfbuJbHyhLocAxXa/JsTauK8HcnLCwNPAq
	 FPK1bZcfT/db7XPcSnC7aGGVX7ucHOvGA4amKwfEWbSWhOgDYcAKZBB+ZlYD/2M3fg
	 LneO1kwUzejc6XZypv07yW+hYQAJ6EQ5bWlMEupkFNkMGmZrwyou6MOHxZzBdSzMqP
	 MeWi8f/ZBOqhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E11380CEF8;
	Thu, 27 Nov 2025 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] add hwtstamp_get callback to phy drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420581974.1907207.16340426733676180308.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:10:19 +0000
References: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, florian.fainelli@broadcom.com,
 linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrei.botila@oss.nxp.com, richardcochran@gmail.com, andrew@lunn.ch,
 horms@kernel.org, vladimir.oltean@nxp.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 18:11:44 +0000 you wrote:
> PHY drivers are able to configure HW time stamping and are not able to
> report configuration back to user space. Add callback to report
> configuration like it's done for net_device and add implementation to
> the drivers.
> 
> v4 -> v5:
> * adjust comment about dev_get_hwtstamp_phylib() regarding new callback
> v3 -> v4:
> * drop patches 5 and 6 from previous version as these drivers need logic
>   upgrade to report configuration correctly. I'll send these updates as
>   separate patchset
> v2 -> v3:
> * remove SIOCGHWTSTAMP in phy_mii_ioctl() as we discourage usage of
>   deprecated interface
> v1 -> v2:
> * split the first patch to rename part and add new callback part
> * fix netcp driver calling mii_timestamper::hwtstamp
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] phy: rename hwtstamp callback to hwtstamp_set
    https://git.kernel.org/netdev/net-next/c/6aac2aa2dfae
  - [net-next,v5,2/7] phy: add hwtstamp_get callback to phy drivers
    https://git.kernel.org/netdev/net-next/c/f467777efbfb
  - [net-next,v5,3/7] net: phy: broadcom: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/1cff8392df0c
  - [net-next,v5,4/7] net: phy: dp83640: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/036bb4a5372e
  - [net-next,v5,5/7] phy: mscc: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/ab95392ab5d3
  - [net-next,v5,6/7] net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/d51de60b8edb
  - [net-next,v5,7/7] ptp: ptp_ines: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/dadc51871d76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



