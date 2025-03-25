Return-Path: <netdev+bounces-177611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C1A70BD8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073BF3B582E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EBA266EE0;
	Tue, 25 Mar 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrO9RiE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0C267386
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936408; cv=none; b=N1lT2nCt/LiF+AvhsEiPTUeQaEy1UOObwiAvdf+h1JDkYdwKcH08TG40gg8sbHKD/pT+mxeILk2b1GMncJyAazKVObmQUMfhNCGJNMccVtX8qVvLR5a3jzSJEcTcaU7MrPMtg02nhCiXKaD6Bq8Duk4uTRWiSN/iQgcxyCujka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936408; c=relaxed/simple;
	bh=JBu/Nd9NmKtv+ARn9PeRJag7Naxx04IWjyGfe0BLq60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fz/FNhQhjKY/FaQkSsVNYr8490GEoT0Y/1tro7zpbERpFQclge99Yzi4//huc97s0vsRYataHuu5H/T2R3FyCXfsNIvSb+U4wDrH/be99ox9J615QWCvWgyMfN4+yfdk+3WdIA6nSHs84FFxx6dmeNI//uuMPhFjGdXM7YhuylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrO9RiE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3198C4CEE4;
	Tue, 25 Mar 2025 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936407;
	bh=JBu/Nd9NmKtv+ARn9PeRJag7Naxx04IWjyGfe0BLq60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rrO9RiE8IzfDqmwR00ea/4OKASGyMkBM/T6JgbTyVCnvC/LfMrZrSMe7MlRz9qE56
	 t4rLwn7oEJaBElkrhxwvyxty5RVLo4s8k0ku+N3EZVcxTqtbnH9INRN6xoWCwRrEw1
	 zh+w6DBPoThV28gHIsDwdjcudYFxYtVQwT6cq04zwZxlvkkPXmMLoUHJHNm1qdBi0c
	 a0R413F/ZOJ7c99zuq3usZEtE89b+0wqknqFu+cMIguIm1rMAnMe43Jr8vEoZKWj0v
	 +yXeJRMxumPMFUfpQtJTuDhpEdfpbsQvzkxj7yGzCrQ2uQPvRj6HZoXiO/loRNavjK
	 fRw+39y6ZOPlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F0380DBFC;
	Tue, 25 Mar 2025 21:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: force link down on major_config
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293644426.727243.12184411244742126663.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:00:44 +0000
References: <E1twkqO-0006FI-Gm@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1twkqO-0006FI-Gm@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 16:40:08 +0000 you wrote:
> If we fail to configure the MAC or PCS according to the desired mode,
> do not allow the network link to come up until we have successfully
> configured the MAC and PCS. This improves phylink's behaviour when an
> error occurs.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: force link down on major_config failure
    https://git.kernel.org/netdev/net-next/c/f1ae32a709e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



