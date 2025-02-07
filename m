Return-Path: <netdev+bounces-164188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD4A2CD5A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4E016C91F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC319DF44;
	Fri,  7 Feb 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b20841o6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3919CCEC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958406; cv=none; b=OU8JL1ftknJXPR0wJqU5H1GEMkjI2KrCETNW91EPyzcn6Uq8MZUM2Kg8AQR27qlyOg01lNdnSEJLMrymZES/TQx8GS+kp4F2ZyZmtmLtsXWhp7QG9tzCO+ELuzpPaMlIm3rP9wcUSaAcERkH2KDTlbUJLIql2o6w5YuOhYim77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958406; c=relaxed/simple;
	bh=2Vay7qnWQD4e4RV/yPWpHI6Zs+BT4PGM4KCDaWf67gE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=agWm2T6FPvvUnmgYTzOVC3cDlJWPlfAzI3r9I8E4Fgw7bVtjzB8hnxwtCc+67T1yD602KSyGAfI4gXkYT7ww8/dhrtxrxUiLQP6gtiWPvF4Yg0GLSRP1HwXtVOfYuQe+nTjo0d6k+NS6R33/sDtTOKGqPIQBwWdnYNf/EBTz3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b20841o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4195DC4CED1;
	Fri,  7 Feb 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738958406;
	bh=2Vay7qnWQD4e4RV/yPWpHI6Zs+BT4PGM4KCDaWf67gE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b20841o6RUm+2JIZEMl+lB2DpHGnwfFhclYpvkaNLhPPlwfUtX36G5PWqLaAUrlo6
	 O24ezNt53fldgiQvPp93dwKEN3VVFsFjVXEdxO/t+9TNPw2iZ0a4vZ/rZgkwXVODtb
	 6HGb1iYkCmGbShoUBXeOPPPM6cCHe4/28SJpPXrRwxyN1NIqvnTcc3Rz0Iaeh8mX7l
	 /mw13ZQ2Hw/utGPzKE9yR/WUlCsd2tvFs5aUDVc2mFfJ2TNijdzPUbM9YUfV6oDknL
	 BNgmzadaN/sM2GTjnnU2zYeTwb5Tgo144xCZP9qEJlwOsSfAcRnPY/mOj94LE03gq9
	 Zv3xQosKV2xrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DE380AAF4;
	Fri,  7 Feb 2025 20:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vxlan: Remove unnecessary comments for
 vxlan_rcv() and vxlan_err_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173895843430.2364321.14918596668666658542.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 20:00:34 +0000
References: <20250206140002.116178-1-znscnchen@gmail.com>
In-Reply-To: <20250206140002.116178-1-znscnchen@gmail.com>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 razor@blackwall.org, idosch@idosch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 22:00:02 +0800 you wrote:
> Remove the two unnecessary comments around vxlan_rcv() and
> vxlan_err_lookup(), which indicate that the callers are from
> net/ipv{4,6}/udp.c. These callers are trivial to find. Additionally, the
> comment for vxlan_rcv() missed that the caller could also be from
> net/ipv6/udp.c.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vxlan: Remove unnecessary comments for vxlan_rcv() and vxlan_err_lookup()
    https://git.kernel.org/netdev/net-next/c/a494d1512c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



