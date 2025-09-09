Return-Path: <netdev+bounces-221476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F9B5095D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562943A00D1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CF28C840;
	Tue,  9 Sep 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5PM2tsg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FE28B3E2
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461803; cv=none; b=YzIYUVWs11kFu42uPFRkZHA8IEl6hxCOtTvapyg+K7J7wcBi1YGxh+LQ5iwuUidrIdR8f0lHsPKoPBepDOnkXRtmvm+gcTe0UoFSzkxyR9Mr0sLZ8kxSVx8oQODqMxecjYSsXCM0reL52g07WpnarFOf4uO5bbGaucWHL8HRzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461803; c=relaxed/simple;
	bh=RqtryOcxxvVf288nth9GSg2o+p6vpLFhpSX2oG3bny8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2eBHWBEVnm8UV9rr+BuIAM+HXj5HVmVvTCAeM04HlKe8rdge6HbpMuGl6l1u7il1cmPOneBo9fJkguhXKNkLM8ZGiwkG3X7SXQ2g876Wh265JXauPWj2d+tO7sdvMY2j5mupQIcr5v7jAQcFExuj0rcIJBXqGBmmGYhmn/vaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5PM2tsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3DDC4CEF4;
	Tue,  9 Sep 2025 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757461803;
	bh=RqtryOcxxvVf288nth9GSg2o+p6vpLFhpSX2oG3bny8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r5PM2tsgzZ2bBMx2Ux6y8oIUnJgqWseGqW0CtUXyOsFf8xRH3/IETo85ddkqUG/x3
	 Jv+6bN+7gTO5916R/XD4JFzbHWehAnmu7LZyafWvw7Zq0yu7XvFv0I32qT81qy8471
	 yVlvvN2hBhq00Y5tYuQAXHvQNe2GJaEoXCzBuJSSFJZNlGOzMs9+ZfnYSxmjNGkQ73
	 gM+AwhtKuIEYMPpSp4aevEXSGUHJ7omCQ79Eisyr9XxPqotwYxDri22rxAV9XyFNTP
	 MSFVhcgKL0b+/Cu3bdkzPFUxfGHdH+9UVo8XYdJ7ODNl6r7ovLjJQ+t6y4XKyVZj6+
	 hg1wJSaQ+CGQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F2E383BF69;
	Tue,  9 Sep 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746180626.849476.13109642087360346525.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 23:50:06 +0000
References: <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 07 Sep 2025 21:44:01 +0100 you wrote:
> The blamed commit changed the conditions which phylib uses to stop
> and start the state machine in the suspend and resume paths, and
> while improving it, has caused two issues.
> 
> The original code used this test:
> 
> 	phydev->attached_dev && phydev->adjust_link
> 
> [...]

Here is the summary with links:
  - [net] net: phy: fix phy_uses_state_machine()
    https://git.kernel.org/netdev/net/c/e0d1c55501d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



