Return-Path: <netdev+bounces-167573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881EA3AF54
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3061897D0D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39717BB0D;
	Wed, 19 Feb 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXfxxAze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89C208CA
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931005; cv=none; b=n9Y43oPemaSxfwfEsKQv9k92lWZlNCPNuFZs6S0lYn2cQm40kJ3uzmSU9jeSMtPh1vfHOw6asnjNp7DwaXLYJp3V7nZJp6zk9lOBqA+KqIXfvWcH1YcJtnd4GVsZmt73lfJ/C2CLHptUWD3rDY/+FuDg5Y+z62pbLxYJ+NkBrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931005; c=relaxed/simple;
	bh=z3SGjAhgYqyUWLEJ6PwkH2rifuxrP4WBeNIF36wbEsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f5FmSn/rEzCRwCJoivNrTgcv3M3M9K/5vGQFjbcrrC2Vv42ZlCxx6eRuAzJMPFGAo5BouKInDlEL81N6DtvlWqoKPz5LD+tp4UzPe+sW+o2aEBgXT8AUhSajq/sLe+60Yi/KypbYdRlfnLverDPdsMa0a7f9lPKA4UTI9t9Fvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXfxxAze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5606EC4CEE9;
	Wed, 19 Feb 2025 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931005;
	bh=z3SGjAhgYqyUWLEJ6PwkH2rifuxrP4WBeNIF36wbEsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MXfxxAzeVAbvwUHjGZwrbz86wQc2ZMynYNwT2+DuzEj4r4i/90TrzdSJSqvDh4XcQ
	 Z00n+el4/1rZs25+9PP5KhwJsNvC+HYe2Owr0pvD0vPz0tMmSCDN6x4Q8sOWJL2T+8
	 pdTZNd30OX1cRkBGBfK9oGLtJhGEb3QyjBYATDW23VD/bu99cZ8wk0j+CmayY0w1hU
	 Zb75kyGqpWuyHTw6FTCFwRL6NE1q6g9E903M+WT9cNgYBw+3cZCMzF9pgUJnmqkMpw
	 DhcFH9Ie4q/36beGUDf6eFMNuWCgBLKsCT6trqMrNASZ//podKsZyChHSZy1q3KmU7
	 KOvf6dsai/KSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF3380AAE9;
	Wed, 19 Feb 2025 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: trim the GVE entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993103539.103969.6233271461379198908.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:35 +0000
References: <20250215162646.2446559-1-kuba@kernel.org>
In-Reply-To: <20250215162646.2446559-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jeroendb@google.com, hramamurthy@google.com, joshwash@google.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 08:26:46 -0800 you wrote:
> We requested in the past that GVE patches coming out of Google should
> be submitted only by GVE maintainers. There were too many patches
> posted which didn't follow the subsystem guidance.
> 
> Recently Joshua was added to maintainers, but even tho he was asked
> to follow the netdev "FAQ" in the past [1] he still does not follow
> the trivial rules. It is not reasonable for a person who hasn't read
> the maintainer entry for the subsystem to be a driver maintainer.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: trim the GVE entry
    https://git.kernel.org/netdev/net/c/2f56be7f52ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



