Return-Path: <netdev+bounces-272719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLqVEHxSx2nfVQUAu9opvQ
	(envelope-from <netdev+bounces-272719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:01:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2D34D36F
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA578306C466
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77135DA6F;
	Sat, 28 Mar 2026 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCaDk7aG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5935BDBA
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670425; cv=none; b=HgypMr6n9kE77ZynlOnycSh+cG8d0F1UDh+NiUj8X2BFitVh34PO+kfVUFaw0VDi4JdM8/i4nrU7ppiAkkiXYSsZmjLfBN13B4wtuXtWlZgM0JImYa4PoJF1GxYrNf+oaNbM8hki10H+++jGSBsbx75q7/jxbrzqVrjRQOPIgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670425; c=relaxed/simple;
	bh=d86d+Px18uJJrRUwd+Zayhm2FUUAD9dy7JLzEWyC1dg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czL7g3aX43jCYH7z/e1x/bMfFhxB9LJUkgBDXFHZ4bXGvUMdXqc0PCv3ohMXj5nIkdIyv9nBqzc+Zcszw4qSpcx+T6eMj8rXUpjfVofH+Y7ANVF5OtaAVkwkykGk8uKHkHC7BXPMUqVxOA+5UP0z6DOg/yGmI4rW4F2cJQ5Kgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCaDk7aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65ABC2BCB2;
	Sat, 28 Mar 2026 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774670424;
	bh=d86d+Px18uJJrRUwd+Zayhm2FUUAD9dy7JLzEWyC1dg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SCaDk7aGSrpCAAOCaqkRHqDcEjInkC/rDGhb90RzV+OY4rmtFOWz4rUPaSXhOTQtH
	 yf4lWjZLDe13AMnsS5rrsQ/ngkfWU6o1J6MiBbkBsFQaKDEIy3M7z9CmBtuP4HhDAJ
	 rCpJCkVLoqUI2lTUr0rvNeQC2fCyPvy7ntzDCtJlqNe8bCYAtJiol7MeH/sheUt3yA
	 Dsuh9F6EsNqdsOFJ5obPq77o1ZK12RokkoLyq0V+Iuz3MXYmL2JZ1dOpkByR6b/xaE
	 ede0vuWxNtrMHTFUOej9fOAR/5iiP9kypepitzRmt0b6+GFYH/tYGTZHxsLJlToPgi
	 kfUMS6i/VExyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E623930181;
	Sat, 28 Mar 2026 04:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on
 mvneta
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467041053.4173055.12519067439619078618.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:00:10 +0000
References: <20260326122038.2489589-1-kabel@kernel.org>
In-Reply-To: <20260326122038.2489589-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 hkallweit1@gmail.com, andrew@lunn.ch, maxime.chevallier@bootlin.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,armlinux.org.uk,redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,bootlin.com];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.860];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-272719-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6A2D34D36F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 13:20:38 +0100 you wrote:
> In commit 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override
> Autoneg and pause bits") we moved the setting of Autoneg and pause bits
> before the call to SFP quirk when parsing SFP module support.
> 
> Since the quirk for Ubiquiti U-Fiber Instant SFP module zeroes the
> support bits and sets 1000baseX_Full only, the above mentioned commit
> changed the overall computed support from
>   1000baseX_Full, Autoneg, Pause, Asym_Pause
> to just
>   1000baseX_Full.
> 
> [...]

Here is the summary with links:
  - [net] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on mvneta
    https://git.kernel.org/netdev/net/c/eeee5a710f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



