Return-Path: <netdev+bounces-250425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37413D2B0AA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B45030AB955
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C863446B6;
	Fri, 16 Jan 2026 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFt7H7ok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C93446B3;
	Fri, 16 Jan 2026 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535632; cv=none; b=hv2xolw4lis4hqywdwrhOjZyIl4X5bhoZAB5AWPCcV1ScaByPt8H5CPQUWZNqZ9aRqpdHTkclK1W1SOvZPxC7YSQ3nJ97fZxr88ajgF+Sw6eSenvHiN1pSVGqu/yaHLzByCGtApWNWI8naH10rR6Gkd/x8UzwBo/4oP5tyaHcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535632; c=relaxed/simple;
	bh=jXdKw9HJDGRABcB+VH6LXM3hW8bTyXm2PoWb50Hz+io=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2HfdHuVSCxGy4EuFZLWMr4j9fbNGcpt5lymJYFVAOBzf37TB4NEwfauZ6CrvpeuwaRs6OhTsAs9bX/swODRrJFr5rL1zCdeMdCjKOScw6RydaYt5xvK3LAfwDo0WSFklDcPDQYx87Cv1jPzQqax6wWPtBK91/XshWuCwtAMtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFt7H7ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D49C116C6;
	Fri, 16 Jan 2026 03:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535631;
	bh=jXdKw9HJDGRABcB+VH6LXM3hW8bTyXm2PoWb50Hz+io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SFt7H7okqpvV3+Fquw5L3XDWuZuHPsDKcx7+aRlyO1SxpNMbuTvU886UcM/2QYNkl
	 iMeZhkZ2MzqeSiT8mc5c7lq/51zaFRNUx8skuxIOgMmxapftq4GR1lvtLBPGmNwpGO
	 x/yO2PBUlab9o/4RR1/Xc/TGwH/1JD5PBdYoHB7fqS/Zhj+gnjUVdLKzRzmNtMgJqQ
	 wZC8mFfT+arQT5mzzBt6q+Y6W+9nZzpR5MkdOSz+vOAzKyIrAjB4bemMB/p2+F41pw
	 /Cr1JfAofMuaiZM2KZrwboNCiV2LnJoUTeSPp8+xu4uCYDLrsSqeEAQpd/f6I9lN06
	 yoocITc9ng9aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F305F380AA4C;
	Fri, 16 Jan 2026 03:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: remove unused fixup unregistering
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853542352.73880.1429898234019907496.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:50:23 +0000
References: <ff8ac321-435c-48d0-b376-fbca80c0c22e@gmail.com>
In-Reply-To: <ff8ac321-435c-48d0-b376-fbca80c0c22e@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 corbet@lwn.net, horms@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 08:23:17 +0100 you wrote:
> No user of PHY fixups unregisters these. IOW: The fixup unregistering
> functions are unused and can be removed. Remove also documentation
> for these functions. Whilst at it, remove also mentioning of
> phy_register_fixup() from the Documentation, as this function has been
> static since ea47e70e476f ("net: phy: remove fixup-related definitions
> from phy.h which are not used outside phylib").
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: remove unused fixup unregistering functions
    https://git.kernel.org/netdev/net-next/c/b1b77c82cec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



