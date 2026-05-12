Return-Path: <netdev+bounces-287178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BqyH6g6A2qh1wEAu9opvQ
	(envelope-from <netdev+bounces-287178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC9522A2F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B30233A726F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087183905F5;
	Tue, 12 May 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyeOW3z7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15E37DAA5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593259; cv=none; b=e2lPTAYYFXJqhJQzYNZ4tsUIwH5gcMfOQ1X853lH4HMOjjN+k4gdl9uK4iXWEsyhXN02hm1dMDnkXTb7l76xt/bPj+moZDwFx2UInzPo/DXekWpVs/qFUvwOvNyFoG41OpWkkkFbTj+g0srDjEDfoCvvAjyjGoL709cWReJ1kMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593259; c=relaxed/simple;
	bh=987bjNRCrI3/Zujt7W+zUe5CBFskLwI/W/PALNXXSqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MYO8Xoeal3KLRtuvP0uErxWudCR1urB8WIBWRh7c5U7Ijoh3Bhyjieg0UidZ4NyVpIxCa/gPLcLG8zJ34/p6JNxDeODtk31CwjXCsbhBbChxga7UUaWJjo82+OSI1RoLNOzVNfb/0hE/AMCcKpjwbrT+OF1eXOuZpNSl0N/dmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyeOW3z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C34C2BCB0;
	Tue, 12 May 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778593259;
	bh=987bjNRCrI3/Zujt7W+zUe5CBFskLwI/W/PALNXXSqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyeOW3z7uGUygE6nQcN80o59NMPBXWRoSgeYa/rjIA6rp/ls22MdtWVxo3QyP0j4+
	 HwTsJUHCO58j6elVE4tAKeVOtfYQMBQkc3tOXFCSuGoWjL4jNKlMjT4WoWnj0iPsVG
	 3b511Km4HzqLUGABYPOaJB6R4ZEjIoFSNgzF/URqpS91nMdzcMf2BzKxSMndRK+hY1
	 bYbs9GshuTHIy64ZING6s95TSF6r8C700OmseF+4AiGyfHfTsnWv5odQX22r+7FdPl
	 Svd2Nl8U1dTKuakWqgTkIUTGVIzoMKFNGZmgefN3d/LQeepRy4yBJ71qLWXk4Bzfh+
	 9H02qASO5gxBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9B3811A57;
	Tue, 12 May 2026 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS
 reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177859320580.2872735.6530995193637920675.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 13:40:05 +0000
References: <20260509023732.42256-1-enelsonmoore@gmail.com>
In-Reply-To: <20260509023732.42256-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Queue-Id: 1FBC9522A2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287178-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 May 2026 19:37:28 -0700 you wrote:
> The legacy ARM board file for MACH_MX31ADS was removed in commit
> c93197b0041d ("ARM: imx: Remove i.MX31 board files"), but a reference
> to it remained in the cs89x0 driver. Drop this unused code.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> I found this issue while working on updating arch/arm/tools/mach-types
> to remove entries for board files that are not in the kernel - this
> reference caused my script to consider MACH_MX31ADS to be present in
> the kernel.
> 
> [...]

Here is the summary with links:
  - net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference
    https://git.kernel.org/netdev/net/c/36a8d04a8293

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



