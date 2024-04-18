Return-Path: <netdev+bounces-88942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CC8A90D1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00681C21D9F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D04EB3A;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSRK9f6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF53BBD4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=uMrYZ7suASc8eNhOx8vfGU288c07SPlMpXUS0s0IW1gXrEiu2BLswHmUVBnN13J3pAB8KSxDpdFG+iOuiU/cK+C1Zz4tEaUUrlKmamwj/ZesUD5spIeHXGTbjqtTL5QpgoasbxV3mxUuP/q5LbJ7+DqHCDtj1Ds2YIa9PsJ3iJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=Tm7POmZahQ1RQpojafvvkItP9d4kC4+VepqLLp4kW7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BeUCPKW23llMei/KeEkiGKnhPB4oWqpE51z1HyZMsADZBcVnaSPihL8YIbmydeUSlvJlcEpGgJRlPuHgWLchb5GHoVd+LFiRMDWQn0nxruDQA0HtxtOhsUx1Q75vE2IM8Cjhg370axOXrlJnw3b7qDlP6DMoJtmYVx/ktjlAyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSRK9f6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31740C4AF0A;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=Tm7POmZahQ1RQpojafvvkItP9d4kC4+VepqLLp4kW7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSRK9f6WcaQGOj190ElrSedkuaaXIyRciKPGZ9e5a5W/bOGb+E1ZmW0T/4c3MKQcf
	 2s/IunWjkGeXbF++STp8Q3/kW2GeiGT72oI2C3a0E5sN7IkFhqFU0uYutAeGpIVe1u
	 DDx30jGYDVJC5T8k3GVZARU0vmzOufwARM80v0tjDtKxstNbRBSPEkhkW/jqE52//y
	 OzVh2D87j123/de5+CNuGU72OGdYjKr3Pwzow8rxqj+Ws3/DfRgtJFHI7ip41a7NYN
	 XdeQgQl9HZ4Fl/YCrDigriAX1kMPz4O04T54o/g3fT1+8aV3KmW3Ua808PBV8cGovH
	 gBCLSmESL3Qqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E9D3C4361B;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: xrs700x: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442812.27861.15015853521851706182.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:28 +0000
References: <E1rwfu8-007531-TG@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rwfu8-007531-TG@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, george.mccollister@gmail.com,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 11:19:08 +0100 you wrote:
> Convert xrs700x to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c. We need to provide stubs for
> the mac_link_down() and mac_config() methods which are mandatory.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/xrs700x/xrs700x.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: xrs700x: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/860a9bed2651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



