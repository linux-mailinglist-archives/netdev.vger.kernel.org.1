Return-Path: <netdev+bounces-230241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79871BE5B84
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF023B1579
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCEE2E36E1;
	Thu, 16 Oct 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7QsAFwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F72E1F08
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655034; cv=none; b=UiRhBnB+yva/9QIUisVFBT9yncY/walH3GK6qjcmmHrtHafZMgAPIndByitZTr1Sxg9d2ns2SPV3gJvT1LRCx+MH6NOTJZJVj/exr/c8Ix8xIw6ekjz/Q1knSog1HB3lgBeO+miczceusIyCQJJJoraWqDvY1gtZRFzZ7lxmFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655034; c=relaxed/simple;
	bh=P4fIB79QWtiJzWsVTyfxNg0TWh1a+Px9Hwm3g9ikyww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JPokJF0cUT9ExsvKh0wyQuhajIVpvC+2SdgvHiTIcCKkxbpEQDSKbCIaxfn/x/o2sIB4rrHxKApbvtpicjpsa0xoYjJGlbOM+tTpSNjUwtwk6ctGWZ7lYRXHG89vWx45sOwL+3m1lQcYZDrOKDC1f0aslb/3YKv4z+qTHuOnuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7QsAFwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B99C4CEF1;
	Thu, 16 Oct 2025 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655034;
	bh=P4fIB79QWtiJzWsVTyfxNg0TWh1a+Px9Hwm3g9ikyww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J7QsAFwmGb9PQ3DcuJsTptlnxfD3KiXKkvDx68VEDbp69m3BvR8rw7Sxl5gFe6EMv
	 CRYqud4Dc9Tfk+cssye0DFuJkfs3+VjPCdXoZ/ZgBQpzkoniZPNxzUM8g9WFSLaaSm
	 mnEHjAcxTbzGqWPAiiJ5aRNln76LA4Awwa8KYuGmafoKDXlhdSTAiMuq+D5UoE/f9F
	 RojXgE/z7Z+FJghwkxD9iEwcBysiaWWcUQZCfR30MrfrYMemiA9ZPICss/10AAjBKx
	 1FndLSbMC9S9WEEl7LtUELr++3Ugd7OYsx3MU1pfjuOC3A0YaBYuLC9JJq0zuYpOGZ
	 tIvXHcAQY4h2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712F939D0C23;
	Thu, 16 Oct 2025 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: amd-xgbe: use EOPNOTSUPP instead of
 ENOTSUPP
 in xgbe_phy_mii_read_c45
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065501805.1934842.8525814840904618022.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:18 +0000
References: <20251015025751.1532149-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251015025751.1532149-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Shyam-sundar.S-k@amd.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 19:57:43 -0700 you wrote:
> The MDIO read callback xgbe_phy_mii_read_c45() can propagate its return
> value up through phylink_mii_ioctl() to user space via netdev ioctls such
> as SIOCGMIIREG. Returning ENOTSUPP results in user space seeing
> "Unknown error", since ENOTSUPP is not a standard errno value.
> 
> Replace ENOTSUPP with EOPNOTSUPP to align with the MDIO core’s
> usage and ensure user space receives a proper "Operation not supported"
> error instead of an unknown code.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: amd-xgbe: use EOPNOTSUPP instead of ENOTSUPP in xgbe_phy_mii_read_c45
    https://git.kernel.org/netdev/net-next/c/bd853a59a87e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



