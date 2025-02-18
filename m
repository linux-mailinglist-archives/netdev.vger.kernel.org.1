Return-Path: <netdev+bounces-167129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A8A38FED
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12437A17AE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CEAC2FB;
	Tue, 18 Feb 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugqWFrfW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA1BA4B
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838602; cv=none; b=Im4CXkhtfXPoz1WL9J7CFerv5L6qDXSAUB/c+Oo28LXLFs0sH2yHsjDFnTRqWDT6oqU9ycaGoXBuw3uwfciKomi7IZHIzkLIcCwetUlDHTB3guOPWtpjPu/9356s+OxFXBwe8RgB8wHswNC57pBjD+vU1z9fBGTC+lxapbcnlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838602; c=relaxed/simple;
	bh=aFB0LapqLhvzRLgxkdfcMQnUs9nK5bFAMMwh3rI/wnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIYw2ZHDloGO4hnPZG05pBNumHztm5zNdrSZxTiiNecpTwI0CBLeoMzAlMi7Z6H7Dp4pAIXLUNG3RonnJwv6bWGEtvWn8AUA3EoQ35il7q8/nDeWvGeZkechrq8/tKeT6cUXuRfXb8eub84SI9iZvymBitBL2U2GL3aSPkXGlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugqWFrfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B5C4CED1;
	Tue, 18 Feb 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739838601;
	bh=aFB0LapqLhvzRLgxkdfcMQnUs9nK5bFAMMwh3rI/wnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ugqWFrfWC1T8NZItcpv1cD/7iEHq7RhyipjXL1TXCpigQkEe3QODT+rznjU01gCOv
	 wJLJ30m/tVX0bBtUjWOkNvznhyVUubMBklWI3N0RZKVx/DhBjUfh+WRUcHV/BQoRm6
	 x6SJLj8vjcAsemSJJTrzH0P9AfCm4jZr1/EeksWx/TXffXIgQxp8vvYP6/A2KmDVCw
	 03hscLXhTmjRgvUYiP4nGWHJrUtCEo3rXOVahZlzOs4k1GhmlaeWbPY6Dxe/QO2HYo
	 8MmlJ5ufUq8LGVC8BmbW7Ex0rsDwvGlXDrGAM7INF4BVEJAAIC+DesJ9nCmpU+MiEE
	 +rU6EtuVfu56Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01A380CEE2;
	Tue, 18 Feb 2025 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xpcs: rearrange register definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173983863176.3581223.9538893840764505858.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 00:30:31 +0000
References: <E1tjblS-00448F-8v@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tjblS-00448F-8v@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Feb 2025 10:20:42 +0000 you wrote:
> Place register number definitions immediately above their field
> definitions and order by register number.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/pcs/pcs-xpcs.h | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: xpcs: rearrange register definitions
    https://git.kernel.org/netdev/net-next/c/1dd1bf505c09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



