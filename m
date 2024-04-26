Return-Path: <netdev+bounces-91505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C378B2E83
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515E5281832
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5649EBE;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZcNZxO0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA531849
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096828; cv=none; b=FOpUhk2knt5BfCMUTRaRv05UubusnGKAC/6GAzulXCJ11myX9GH9xsDWYT5AGcfvt3Fc8IVSV0hCdSUfRVNrXA+TxMsqaC3/fITCz9h4JWkgZdhYuW2r2c3rJeLj7kK10w8fUCy/MdTkeSN8+g5aUcEGBNL93JZEKbhglneCR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096828; c=relaxed/simple;
	bh=emvgRdkB4bT+QIHO1cO+WSz3Va0SmO9mMlVIKK1qlh0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Er5ReAhxnqpWh2JSjrCgce6YR/4EgqaQ4Q4AhPDAGzlUG56PBqEAlI48s5jdLTgkbHa6d7bWDl0Sk4YrBpYub8PU09zKXtDqJCx6EeDibph2ESYEpwAYLCelDTlQG11KV3x6YOPYdOHPUGhNhf60h/7j88toABvMYENMJM2hGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZcNZxO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BB2BC2BBFC;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714096828;
	bh=emvgRdkB4bT+QIHO1cO+WSz3Va0SmO9mMlVIKK1qlh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZcNZxO0DKIK/Knu/s0P0jTty/qKWVBDUkORJQnZTLlSBwwSbRJNzNHwEGyySng6Z
	 QOCo2mezH4Z8hOv4lMLW6maO0DhmpfSTMKXtG/aYh9n4gRWff6rFxOvwRdPG+ctEzq
	 ZUoO3NCzYdw5JtRZ9DY3UPGdhLu2K0hyZuUYAAHw5zscEC78cNSpHXEEKBkI5EVMQy
	 hA6bh+YBO7qbIpDab3Ggxbdi6Dpbzpz6QlNCzL5Up8/mgMP/4khuZjR1VX/vJIUCQj
	 H0YLS/15q2iJhWRALKC03kQRYw/CfQZ7GSQdWm1zzOLZpOsiEEZohSxpl87wRIBrJn
	 Vmowr4MDn6y9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B9CAC43614;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: sfp: update comment for FS SFP-10G-T
 quirk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409682823.30663.5163968269339844749.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:00:28 +0000
References: <20240423085039.26957-1-kabel@kernel.org>
In-Reply-To: <20240423085039.26957-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 10:50:38 +0200 you wrote:
> Update the comment for the Fibrestore SFP-10G-T module: since commit
> e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
> we also do a 4 second wait before probing the PHY.
> 
> Fixes: e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: sfp: update comment for FS SFP-10G-T quirk
    https://git.kernel.org/netdev/net-next/c/6999e0fc9a55
  - [net-next,v2,2/2] net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module
    https://git.kernel.org/netdev/net-next/c/cd4a32e60061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



