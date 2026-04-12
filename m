Return-Path: <netdev+bounces-277914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JFyaO/4O3GlMLwkAu9opvQ
	(envelope-from <netdev+bounces-277914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4A3E6278
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA180300A62D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E729DB86;
	Sun, 12 Apr 2026 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4oek9Va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF631238C0A;
	Sun, 12 Apr 2026 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029433; cv=none; b=o1TwBsZWegRORhxkDnRvsjWlCbG3f6d39e9ts2yxFciACJD3eUOrcX6wsybdxTTomvp+I0VkhkqGmoVpdbBOV/tceKPrf8IpC6Oy+MI44tq4DwSU1H/MVAXWHktP+VHnLbfsFdvJagsVC/OhclXzKj1SPQ3OsFa8EzrnfwVESIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029433; c=relaxed/simple;
	bh=C9eJ81Pz9+T+ZVp6CSc3Bh2MIrSLIODyXATowOKiVlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qt1Ngmfz5pnOJ5X579x8KCUqT34gOLOpkNTo+vKfYZPEanVbhPipg4+E6KUZW3kIeBgdINTavXfEooA8/krdu489YQySyfjrdJWgwK5eWoLkTZ645r1JQRT8JJ3PplVn3twXxRZlDx8KkHum1rb2R5+W8Po5I90Lh4LH77QmnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4oek9Va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7218EC19424;
	Sun, 12 Apr 2026 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776029433;
	bh=C9eJ81Pz9+T+ZVp6CSc3Bh2MIrSLIODyXATowOKiVlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m4oek9VawBgPngfaf0YwE3bQmHgu6ZOXeS8qMLyZYxbvlICsaXzj0tqGWko8sCPuK
	 BcZTCsWcFACWGGD7aa8IgXXwmRMQTOboPD0U86oq+vMu409avy82mUVBe3N/Wg48UV
	 n1Z0IQ/+NprUBn0JXfS/ZkL3gDUsSZfFK7kcOTAmvtbGSDCAR2EzM8oPH3DBynhfjJ
	 XxiqhWL4HJhwUYYZ4qFGemFSidQeSEp0FLAx2KMWG+ErMV7pcFJdjjnnww8BWboIy7
	 Xlqdg1+1UXRPc17N5i400rGCZppo4NCpLy/DvE8xRIBEnBEHhe54V/zCCy6S58mUfB
	 YJP6UQljst6Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D453809A8C;
	Sun, 12 Apr 2026 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: fix a return path in get_phy_c45_ids()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602940581.3828553.12668559320267490460.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:30:05 +0000
References: <20260409133654.3203336-1-charles.perry@microchip.com>
In-Reply-To: <20260409133654.3203336-1-charles.perry@microchip.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277914-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 43A4A3E6278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 06:36:54 -0700 you wrote:
> The return value of phy_c45_probe_present() is stored in "ret", not
> "phy_reg", fix this. "phy_reg" always has a positive value if we reach
> this return path (since it would have returned earlier otherwise), which
> means that the original goal of the patch of not considering -ENODEV
> fatal wasn't achieved.
> 
> Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: fix a return path in get_phy_c45_ids()
    https://git.kernel.org/netdev/net/c/6f533abe7bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



