Return-Path: <netdev+bounces-140065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F89B5250
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96543286C41
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C542076A5;
	Tue, 29 Oct 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/kCWXpJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F632076A4
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228433; cv=none; b=ls89wgW5IDDn4SOIAhid60ELyn3n7Qa57j3+bx5NkJTZsRxtKIlxEX7TD82od5qeS+R7XN8OWmcASlGKW8W/ZlPAF5drNFmacxOdPCTO/xYWmuEexMTBvPh7y2O6cI7U34eRl73AjXBvyhtAQ6HS11s0IEoSppCjbGDBFwv8mZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228433; c=relaxed/simple;
	bh=bkKndJn7XIkhmYLdiOQqsdhPc/z38bfThzkiyz8pkUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UjWmn2JR+Kq+dXFFwHjJQGoXtUiZ6wVVaCVyqUqmupFw1Zfoho7JP6g9rkcJg0L80gIokpdf85Kv/+sU/dd4CA9XrO8VlKccyadKYKvOrD6yOaeJ9iph7g0u3Re9zO/X+uTwPI88xzrACzs7sEMiNkD+D+xcQr5N+xS5HOqK6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/kCWXpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5E0C4CECD;
	Tue, 29 Oct 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228433;
	bh=bkKndJn7XIkhmYLdiOQqsdhPc/z38bfThzkiyz8pkUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/kCWXpJNH2q8IuPHi0RhDMdXIaZguef2Bit3sDZPUkFZjiOCxmLB9EEUnQPtoH2u
	 uAqo7cr8M6plDFIrmVJswzPwZXLdRWN4Xa5VjqE/Z+9873kjUrkbthHSo4FMka9jmF
	 pm2CqckoxXwtmsF107bfYjIgj0ymT/TrBwujWkD05SWn0NWtHHZz40lSwp9iYCGIP6
	 v6Q8A4KDdHjZ2rnmAVJdv/RJad+pnSbo0/kgR0/8LKDuq4eLp1WM4La5cj0Xayx29Q
	 1W6l7+YkBhkWnwEl2CjN+nxGQDa97zP0/Q2GZzxsXdomp9Y+J/cUDUYeNfXpM3/K/k
	 XkkNjwVmQl4VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D25380AC08;
	Tue, 29 Oct 2024 19:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: phylink: simplify SFP PHY attachment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022844073.790671.7512388845260359270.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 19:00:40 +0000
References: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
In-Reply-To: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 14:41:17 +0100 you wrote:
> Hi,
> 
> These two patches simplify how we attach SFP PHYs.
> 
> The first patch notices that at the two sites where we call
> sfp_select_interface(), if that fails, we always print the same error.
> Move this into its own function.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phylink: add common validation for sfp_select_interface()
    https://git.kernel.org/netdev/net-next/c/280ed44982ff
  - [net-next,v2,2/3] net: phylink: validate sfp_select_interface() returned interface
    https://git.kernel.org/netdev/net-next/c/41caa7e81b97
  - [net-next,v2,3/3] net: phylink: simplify how SFP PHYs are attached
    https://git.kernel.org/netdev/net-next/c/25391e82ffe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



