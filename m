Return-Path: <netdev+bounces-181037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA5A83699
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA6C3BB951
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACD1E285A;
	Thu, 10 Apr 2025 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUje2t1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DC1E25F2
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252795; cv=none; b=KbgAelEFuuBq3047S9Ug9TLENss8ZIEBEIhcMsluhXnqlqy3yDEEipVm/BPFZTlyBlvN/sE4n5x7+pYhBHUIP2Blnasa0cr0OwqqsyG/2uQHDM1Tt5H9tsH0fsgJopdW8aUfw+zbwS3x/YbQlhViFCG4rqs1qXMlp3UaRGIJJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252795; c=relaxed/simple;
	bh=tx6d1r2SNl9loRX5Z1JywYvF5FUTL/MzYb0rUJrnkjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpsMYIIr1EOQIAY8Z49NKTUaamnDVAXd673nRzEUMx2Z71rdhiy9jwKmmByDHCaXTfBWcQ61H3gHKSrax7dsMtJfMAQ5GkCLRxaVeuuHowQpkqy01WsF86BwiBvyFSCKUeKsKreHNcFwRhpfI8Q9B2ohsZwW6S0l8sKcDA6gqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUje2t1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4159AC4CEE2;
	Thu, 10 Apr 2025 02:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744252795;
	bh=tx6d1r2SNl9loRX5Z1JywYvF5FUTL/MzYb0rUJrnkjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUje2t1iteEIGMpm7dXOmYLIJtYTH/yXgo3I3TpYmIh2kDTWe7i/kHL9pXJTRBOBo
	 gUyTJG67OoM8l4/MQDYxAZJkQZBgEhhvwEUDhahML/t1blEtB0VNac7GONfnU4bJqA
	 QyRn79aXGHWy9AAWgRoD+awdj5MeeVxNofFpWWQ4/CX9g90mhfvZu433lwA7pd06iF
	 XqQrN2Y68MANJUbS2eGsriIz7A2ixaZsJreFO5MCL1n9XiKKOs/j5Su6hjjx2ruoOQ
	 /wCcjbwf4VxTkJe55eD/ektt170fZEJLDrXNfq3vhp6l86VhAjQ/oEfhxG3Z7XYpNI
	 tgb7VFDFpYm+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5D438111DC;
	Thu, 10 Apr 2025 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 1/6] net: libwx: Add mailbox api for wangxun pf
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425283276.3122537.2028208285803978854.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 02:40:32 +0000
References: <70017BD4D67614A4+20250408091556.9640-2-mengyuanlou@net-swift.com>
In-Reply-To: <70017BD4D67614A4+20250408091556.9640-2-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 jiawenwu@trustnetic.com, duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 17:15:51 +0800 you wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 176 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |   8 +
>  4 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h

Here is the summary with links:
  - [net-next,v10,1/6] net: libwx: Add mailbox api for wangxun pf drivers
    https://git.kernel.org/netdev/net-next/c/29264a372da9
  - [net-next,v10,2/6] net: libwx: Add sriov api for wangxun nics
    https://git.kernel.org/netdev/net-next/c/9bfd65980f8d
  - [net-next,v10,3/6] net: libwx: Redesign flow when sriov is enabled
    https://git.kernel.org/netdev/net-next/c/c52d4b898901
  - [net-next,v10,4/6] net: libwx: Add msg task func
    https://git.kernel.org/netdev/net-next/c/359e41f63155
  - [net-next,v10,5/6] net: ngbe: add sriov function support
    https://git.kernel.org/netdev/net-next/c/877253d2cbf2
  - [net-next,v10,6/6] net: txgbe: add sriov function support
    https://git.kernel.org/netdev/net-next/c/a9843689e2de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



