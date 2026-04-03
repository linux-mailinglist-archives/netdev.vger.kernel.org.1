Return-Path: <netdev+bounces-275272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GJDJEJJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F1F398FA4
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20A6305ACBE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5FB38C2D1;
	Fri,  3 Apr 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DocFHo+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF538C2AC;
	Fri,  3 Apr 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257831; cv=none; b=fCsFFX5btMZwc475K3bVD2hg7LHIZQcasN+v4HqnQ3OSp+y9TugWNez+yH2bu+nKwj/GMxvYHDDvzB4qB+xmAaRe5uwoN3KsuEKnWRGkLxtRANCmPFOI2zSteHPvJ0u2XfdU/qUoUL2JQkhb7qyGiKpPKUnd9Lq72zZRtTOlXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257831; c=relaxed/simple;
	bh=7Qq+LYp5gQ0cm4ZoUBVvJkoKzNdpEci4Ll96Q4J9IwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qrzRlkW1yWphsTx6egc+PJH05r36FtbkMdkaa6KXrLlqeR+X7yohPXORwKoa5dwTob+2V1AYcRkd0LJlKk9UjDTQWv2k5hC8r/JPhyZK8BYUb3GUQu2BzC36mCCqtwHezu0xc5O3Ld5Ey7ykGoW2itd2BtJ4++1EWEVQE4lP3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DocFHo+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A3EC19423;
	Fri,  3 Apr 2026 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257831;
	bh=7Qq+LYp5gQ0cm4ZoUBVvJkoKzNdpEci4Ll96Q4J9IwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DocFHo+5aNF44/UDrtsgsffqqnb6qIb0whkj7Bl6EkriLg2Ghh994qGXDvER6cCJd
	 k9jocBZgvd92/wgT62jf7GHUd72E/QRzHGXrnxkDD0CbhAMTVGhFdMrLvnEfpSdV+L
	 +La82Ab6N5T14txYwhlZ/muMxyAG6JHOXoDONFLAVQuD+cXXh+FPjGyow1ePduumd+
	 0FWm2L0rV5kHPDs8HVpRUZ6d7+lFFTF9Cf1pFsSAyYQYh2kP2M6XaozL+jDsP76dx/
	 bLCZuVkzYyPJpjiRPPJLu5C+aVZUlmobgkRe+iZ3O5I8fqTrd/LlMIbxs/vZl5yv37
	 lDHewgnmNF9Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC4A3809A14;
	Fri,  3 Apr 2026 23:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 0/3] net: stmmac: Fix Tegra234 MGBE clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525781278.1484550.12961600432345411536.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:12 +0000
References: <20260401102941.17466-1-jonathanh@nvidia.com>
In-Reply-To: <20260401102941.17466-1-jonathanh@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275272-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7F1F398FA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 1 Apr 2026 11:29:38 +0100 you wrote:
> The name of the PTP ref clock for the Tegra234 MGBE ethernet controller
> does not match the generic name in the stmmac platform driver. Despite
> this basic ethernet is functional on the Tegra234 platforms that use
> this driver and as far as I know, we have not tested PTP support with
> this driver. Hence, the risk of breaking any functionality is low.
> 
> The previous attempt to fix this in the stmmac platform driver, by
> supporting the Tegra234 PTP clock name, was rejected [0]. The preference
> from the netdev maintainers is to fix this in the DT binding for
> Tegra234.
> 
> [...]

Here is the summary with links:
  - [V4,1/3] net: stmmac: Fix PTP ref clock for Tegra234
    https://git.kernel.org/netdev/net/c/1345e9f4e3f3
  - [V4,2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
    https://git.kernel.org/netdev/net/c/fb22b1fc5bca
  - [V4,3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



