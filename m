Return-Path: <netdev+bounces-264982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pz5Mnd2q2l+dQEAu9opvQ
	(envelope-from <netdev+bounces-264982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:51:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A812291FE
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DBAC30DDAB1
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041527991E;
	Sat,  7 Mar 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os0L/MYz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D48F5B
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844611; cv=none; b=S0Pq3oPIVLPNdtkkiUxnWO4DskmLcfohHHiOqBqH+v3FknvrJBSbNykWF5dvyNYKdmcWX/f3kymx8X+FS784H6Fszxoan5BnI1ccZqjZ996zKA4C1AhU50XfhpGy1VCyOvIiboi/z01NOy77zJ69wkQtRlTLQqzZRsSS4F5T9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844611; c=relaxed/simple;
	bh=2UmbcpUt9mLtkE6gIiqoACabiWJP+lHeSWzP5uqHpDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4TGZ+AzhEbnp2TL78g7veIyfvQiS7j1+cZKVI/oD9X+hhpAHl3Q+M9pa0IlD0ov8oKDjmjfhtoGG0TQKYJ+y5hi8dlj+DpvRaN64NiWs8fZfOb4cPQ6MLpIKHdHH+Sa82Bxeu7+bzIMeFCQBLxsCTajX68gRBdj+upgV0w26So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os0L/MYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC9EC4CEF7;
	Sat,  7 Mar 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844610;
	bh=2UmbcpUt9mLtkE6gIiqoACabiWJP+lHeSWzP5uqHpDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Os0L/MYzNi91HER/CYg6Va+gHgiPiXafgfXKEzrQIrkrqrmv4WbmKrCNnBJn4N6C7
	 V/sTgiWe0Y+tGbEP4FU3y6Vf2CdfEvS+DYfxco7k+zcajqGAIVy0wXrQpU/20bimPy
	 3XyROR2HXwntq+co4daov/thjNOZ9zCrn+CC7OQyrKbn0Qfqr3oBTG2ROA3aT8CdvC
	 AOMG0welPw9GlE2YgvtKWSZrjBwFIleQsnJb0IkRbKK0T39wPyLYWBdmhiX4IGkFIy
	 YeIm6PG4xkBJEv/mmiuhmVqVYX8WREPVWe5UONztgnUIKqc09nn76J68C1Tr6JJAwE
	 l3AkKur1bBkmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEF83808200;
	Sat,  7 Mar 2026 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove phy_attach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284461004.108926.8525523855235472524.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 00:50:10 +0000
References: <8812176a-e319-4e9f-815d-99ea339df8b2@gmail.com>
In-Reply-To: <8812176a-e319-4e9f-815d-99ea339df8b2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 37A812291FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264982-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Mar 2026 21:17:28 +0100 you wrote:
> 378e6523ebb1 ("net: bcmgenet: remove unused platform code") removed
> the last user of phy_attach(). So remove this function.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 38 ------------------------------------
>  include/linux/phy.h          |  2 --
>  2 files changed, 40 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: remove phy_attach
    https://git.kernel.org/netdev/net-next/c/260d27b3aec9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



