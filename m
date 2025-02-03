Return-Path: <netdev+bounces-162260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B2A265A8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69151162BB3
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392920FA98;
	Mon,  3 Feb 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrc1k83s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED717D07D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618210; cv=none; b=jjWtPPgHH70/OweAVXMWe0c6YWqPWG4cTZMlW6Pa6++wh9aD1W/Uc5VQd1i2WXZTHTqjShSVps0INfYLGk2ArKgx7bRHKGVDZWKqRgQRlurHVUc7c1SgqG2O+fmvqO+nwZWy2s0UH0sO6/DNBDwB0APpSo0e/pzzjYWr/yg6rDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618210; c=relaxed/simple;
	bh=QE7MAavoKiTBsGDhzMm9Lhj5jS/RWOkaVmcL8ENQP+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MHV3mGU7bMKu2qfBJZdC85ZqRO3j/Gj1DTKJaH2EP7kgGa1cYDbXhWwEqnJwfg4SRlzu74o5OIwvwhLksTOO4s+hIcYjTnHAzppIrTuXm0TQJCjpqVM7z1OPhLSHKXA66sH+eO9C3H1DyreBdS3ZgLBLw3izU3KDhohBqCdGwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrc1k83s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94688C4CED2;
	Mon,  3 Feb 2025 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618210;
	bh=QE7MAavoKiTBsGDhzMm9Lhj5jS/RWOkaVmcL8ENQP+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hrc1k83sqJBDetL+jOIcko1TXVpvk5s2azqhhqyThlcpoVniDSA/lD9imo3zirxYm
	 fKRfik47ZxmHOWTqqoia0MVv762j9XuuOVsKlG5YR5eMikEUPgTRyfOx4UIKOs9GVG
	 LIRDsJCDS/loA9pfJ961i3rdjRluktAsBp7e8fGFRrZ14T/witLkYl8vIxTPKlcweT
	 kkqDsKEPS1mVbqQ6m8SQ0Yo2MD9rgNEKztTsaxUVDID3DCH1TsUW470FUiLta4Zcbc
	 vuDSUFDF4e0OxhDzhFkYzi3V0Fqi9NJr9n0rRS0R4upPq4AG3P3tLGbjS9Ubj0sV1D
	 x3pkZOhOFLFWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00F380AA67;
	Mon,  3 Feb 2025 21:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: list openvswitch docs under its entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173861823753.3505817.2386083292656752971.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:30:37 +0000
References: <20250202005024.964262-1-kuba@kernel.org>
In-Reply-To: <20250202005024.964262-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, pshelar@ovn.org,
 dev@openvswitch.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Feb 2025 16:50:24 -0800 you wrote:
> Submissions to the docs seem to not get properly CCed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: pshelar@ovn.org
> CC: dev@openvswitch.org
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: list openvswitch docs under its entry
    https://git.kernel.org/netdev/net/c/3a4e7193ec37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



