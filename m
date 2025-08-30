Return-Path: <netdev+bounces-218440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDA0B3C760
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9711C58793E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1425FA3B;
	Sat, 30 Aug 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6aIYeBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21625F998;
	Sat, 30 Aug 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520411; cv=none; b=cYMnlDRocn3r7QTaqmoWWz+ea8NHX1mL8n90aIihtMg5zycbudGCfkCCNlcACz0q2BS+I0enPTTKV/upnGWLgpwMl/4sE1nHa8kpKBdf7kujXqZIadXLJ7vFN+chHKqsSubeLCltkqdxk6hYJVNnyqNrhbT/zy+YLoJ1rrjHVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520411; c=relaxed/simple;
	bh=tNH1BB/XjadzHaidMR9LHXW9AJ1Ye9LYSQSZPLfJ/BQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zqg9gsU2jLNyLCLtvTYrtgmLF3vQ94ctC4I+qMxv3RpyH0rO+8LLrilBRZeiuMXNxHYGQtqsMypVPNbcPALfZ1m659i2RC+4zGTrU5FlaQDhk3hpO6LtGWWX+egeZhfTamltqtNgUD/TLP1MN+NO7PrRGMSI5rop0m4iAgWQaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6aIYeBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60061C4CEF0;
	Sat, 30 Aug 2025 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520411;
	bh=tNH1BB/XjadzHaidMR9LHXW9AJ1Ye9LYSQSZPLfJ/BQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p6aIYeBlgwWRMWinF0pTuIcsh7ma53Hl7aPIXaJQzp0m9ZxzJTB59Of26uilandvq
	 I5uaDDCmrjew63QO7kuL+HZsuZKpzxW6UmYZmOW/E72AVXjAWCpF1py8TkOOZvDLSu
	 M+e5dyGeFnikWi3RzM6hEg3QrLf0bsQZXiM1SnBmcgZEpWF+zM546/Uu59goIQsItk
	 vWCeL0dyVByjbmPj2QAsdTIwk/dbOPQLeJ43RSUtfJ3JFB40gATCwb0KorCJ4mbBtP
	 CWXwan+2CHvEoKSIKX7zaHBOsKEI0aaBxfX62OCftN13goGRbSUWxR13EvKTqTQlPW
	 N6TWvrh0v8+6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A3E383BF75;
	Sat, 30 Aug 2025 02:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] microchip: lan865x: add ndo_eth_ioctl handler
 to
 enable PHY ioctl support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652041773.2398246.16998288535239239249.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:20:17 +0000
References: <20250828114549.46116-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20250828114549.46116-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, parthiban.veerasooran@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 17:15:49 +0530 you wrote:
> Introduce support for standard MII ioctl operations in the LAN865x
> Ethernet driver by implementing the .ndo_eth_ioctl callback. This allows
> PHY-related ioctl commands to be handled via phy_do_ioctl_running() and
> enables support for ethtool and other user-space tools that rely on ioctl
> interface to perform PHY register access using commands like SIOCGMIIREG
> and SIOCSMIIREG.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] microchip: lan865x: add ndo_eth_ioctl handler to enable PHY ioctl support
    https://git.kernel.org/netdev/net-next/c/34c21e91192a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



