Return-Path: <netdev+bounces-206947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC31B04D70
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57CA1A67D42
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2F1C84B8;
	Tue, 15 Jul 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8S3wtSr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154961A83F8;
	Tue, 15 Jul 2025 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542988; cv=none; b=CETNJeClhIFf3IGydSScy3EL0UzBi18/3/rdBY3R2/7f3CHmVuOGwwlVJTeNwV+VhQGNxmbuqkxitKxOnFR4DP3+jEPIqNmZnVQ6qAed/Oo6fauaTQ7hSrH8btBdpFchz2gBn2hz0ofDzy2bZRSGRTpJCAMIClY4FfLF8CzcsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542988; c=relaxed/simple;
	bh=NFtG1yp4KAvmoF987bsoECw6745I4XetR5kNMHK7MBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XcNInscpk7BD/cpNnUm+Y72ZssS+y+Z0dCZTrt+7RCQL2kgGoCSGsbdEXZXbfJhPh4w1/AOhlaoQAe7ELExYuhnIrbbdiPHwo2QQfbXSjwKfvECjH+0kkcK0LiSpYdgO0pPZRmzVkrajjCZbsE+gIQddlYU5edKBuxq6fg84AAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8S3wtSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D18AC4CEED;
	Tue, 15 Jul 2025 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752542987;
	bh=NFtG1yp4KAvmoF987bsoECw6745I4XetR5kNMHK7MBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8S3wtSrDUVFh8tACJDKHNX3kBS2utFTMDpMEXRsDyarsvTkOnWNYWcEMnJ+gVFU0
	 685A1STZUrtD3a7pyzbID8yCECMyLp3F0pdi2zweX5Y4HgfqQEmoHctoyPKmHv/AXM
	 1js52Ee2euA/AxguDmGzQChKE9eZWfN4H7cKtj29PmuKR1qqnJqJGEPByuePLV9X1n
	 gJ5hVSyx3Ss/I4ZSZaOf7cuk+R1bYx11aDVclNycmTv2/WGmCLS5X+IGv14gD7Vrh3
	 GjMU7a21UGyRBEjCEMAe1nJ6jhtwZjPzRpeGbsFIzfrNb2eCHPg3WYPvEYS8Jc9kOZ
	 IRfZp1EFcyU3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 99F94383B276;
	Tue, 15 Jul 2025 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wangxun: fix LIBWX dependencies again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254300824.4049503.6759866563316837064.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 01:30:08 +0000
References: <20250711082339.1372821-1-arnd@kernel.org>
In-Reply-To: <20250711082339.1372821-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, arnd@arndb.de,
 vadim.fedorenko@linux.dev, heikki.krogerus@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 10:23:34 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Two more drivers got added that use LIBWX and cause a build warning
> 
> WARNING: unmet direct dependencies detected for LIBWX
>   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
>   Selected by [y]:
>   - NGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI_MSI [=y]
>   Selected by [m]:
>   - NGBE [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
> 
> [...]

Here is the summary with links:
  - net: wangxun: fix LIBWX dependencies again
    https://git.kernel.org/netdev/net-next/c/a86eb2a60dcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



