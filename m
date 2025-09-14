Return-Path: <netdev+bounces-222865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75866B56B6B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B621B1899005
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D11F4174;
	Sun, 14 Sep 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iiwbhd6+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6131B532F
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876416; cv=none; b=CuJ9TcPw3y9NlcfxLL0tJ4Xl9AWp4xzApjC9ZE0ISgM3iVJ96mORVlOvHhtRdgPtmCI69aKkn2baqWHsruDX8Owp7nXCyRp29YiA6XWajntxXAXjJnbOHPoe/goStSwIrS3fDVnyxTqrN9f87TS4daqLnWJrYTOVCXlTlGONywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876416; c=relaxed/simple;
	bh=K9UTDHKIBQwyOKMcrLhCfzGglpzzynnhfxYA3Xz+AXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+TRlP4+h9oUgWRrekuChaiCWsnSDj2029EaAbGDUGkR/LuCFrAJEI6840jz0B9MAx3zc342zdTfzqW73wDxihESJADq54ZsDMNeEfsMYP7Y5uFzMEJoFBQv8YrZC5ofy9gpYThNLZ5eN83kXVaUsKLOEx3Da5pyG1brVo+hd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iiwbhd6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F99C4CEF0;
	Sun, 14 Sep 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876414;
	bh=K9UTDHKIBQwyOKMcrLhCfzGglpzzynnhfxYA3Xz+AXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iiwbhd6+Fr3SsoJsCYoFCdUtR4jzD2xXQ/8bDiJ4yLvvUksxAKqmV4/u+EQ3WNYwh
	 DoN6kcExFD1+a11mn0RMuJLn1lVwjMYoxENM0VSkTyAendV2exsKVsmhB/LtKMQaMF
	 pKae7p2Bk9vJ7Cy20IcS0xMivvZjsTX0tjKbfxoJHFow5WZ5p4Mm5px6PlwBmeTS7p
	 BQyQoobs7B8k5eCBBhTtezmOBN4Cg1hIzW6fKrOesiSZQ42Qh8MR2EKp2+TIGzZp3x
	 2oTacyOyt60DbsXm/xyksI+4sVEWrloo6OuEaO3X1cTAzJFv9zgDelpAJHqoJjf1QP
	 ImcTe0isf6ziw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9439B167D;
	Sun, 14 Sep 2025 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: dsa: mv88e6xxx: remove redundant
 ptp/timestamping code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787641600.3528285.2615248298382187506.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:00:16 +0000
References: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
In-Reply-To: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 11:45:55 +0100 you wrote:
> Hi,
> 
> mv88e6xxx as accumulated some unused data structures and code over the
> years. This series removes it and simplifies the code. See the patches
> for each change.
> 
> v2: fix evap_config typo, remove MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG
> definitio
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: dsa: mv88e6xxx: remove mv88e6250_ptp_ops
    https://git.kernel.org/netdev/net-next/c/afc0e12a235c
  - [net-next,v2,2/4] net: dsa: mv88e6xxx: remove chip->trig_config
    https://git.kernel.org/netdev/net-next/c/578c1eb9c541
  - [net-next,v2,3/4] net: dsa: mv88e6xxx: remove chip->evcap_config
    https://git.kernel.org/netdev/net-next/c/ae4c94981683
  - [net-next,v2,4/4] net: dsa: mv88e6xxx: remove unused support for PPS event capture
    https://git.kernel.org/netdev/net-next/c/fbd12de4c5b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



