Return-Path: <netdev+bounces-88238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864A8A669E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A6281464
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A784D3D;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwzqu6M9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7D84A36
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=O+mg6m2rdbJvicLYLL/QAUQahTmpqTbMMx28/dP4/gHGNTkxf3w2MKKokqOA1TH8a7pJuj+xDTtDCdhOhjf6aXhnDQR3QGxx4zLBD6nC3dS08nfNLQrh3dHtm9+3i2/rMnlDHUfnf3UuvlJ5vUDoY8q4QMNoBgIH3zOxm8c2vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=mxvD15dJfLWn2Ay2PPktVtBgaNLfP5ezMJmwu0MJ+AM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h1NF0Dv+DdqHshnP53jkN95/gatMX/2CemLJ0zu2KM5+2bzkqnN1kH+Z9/yuDX4sS5Lo+HA3dtYZaHZWBf74dKIuxAel0dd0gZowvrfTnlzIsqOOVD7FSmNuTB6K1zWuFNfHQF9FKcSmolzxSBKG/EmrwDnMJrwkhSsMA4KPxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwzqu6M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 420EAC4AF0A;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713258029;
	bh=mxvD15dJfLWn2Ay2PPktVtBgaNLfP5ezMJmwu0MJ+AM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qwzqu6M9b3CoZLrZO1HoxG6hh10Q64CozPZFaFvVIw2kj1ar/eVBxVrsBrWnbFHLA
	 PEWTXqvWPcHGq7r2DRsoEZsee0WzY7rBaz6Yblbj0cRQXiqUsSa7qsvdPxXwWDs//i
	 yKl/Ou0Y39L2TQFzsAn0ijcJeQthrHvOo/iBWIFuanBxJGWDTcMLJTefwsQmGicb2+
	 SEItqWIw1txjciRV8NSv6dngLGQ6xnv3A+fimCcw/swbX0CPKveg7637VLa6izSjut
	 5UvqdQreBWTqBOeGU+v6tOKN2dnK1ULP3vxfMRWWofJFgVFB88VGrbdd3qqMDwHHWx
	 YOvD4WTKvzTVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 350BFC54BCB;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: ar9331: provide own phylink MAC operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171325802921.5697.1774263316434462275.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 09:00:29 +0000
References: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 16:15:19 +0100 you wrote:
> Convert ar9331 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/qca/ar9331.c | 37 +++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: ar9331: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/e3ef87ef403e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



