Return-Path: <netdev+bounces-267281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFCgKHJ7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4427CEA0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 737D2303BF96
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9D34B194;
	Fri, 13 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4rg3PXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EA33F59F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370214; cv=none; b=BKd2EE3v5o/x0bi/NWZ3sK/SogsWTymL/izqdDaXWgQKTOBIxEcZmY5DJAz1+l6RLYb7XZvfG+B7uT4pVjbgawoDZctDH7U9G6n4ZLGXat/KzKLtOwHOtUWwztLAoTvOzeXY1cvZyPRQDSjwkQmgIicIrdpamwFX3k0ieAY3jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370214; c=relaxed/simple;
	bh=AuB2hoB3rjDHQLSLwJW60WMeyxkHcMmTCZ5nEcsEHVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QlbqJK1sYKjaH7yfV+7P/dBhRGAc6aO3qy2FWbv6d+wx1JEXxHKMY7v8AIT1cvAmtA+cK/l2S0qHEH1SjgrlJ6SIWnkpm3gCsMgyCPt95ZfcHrjTAC2tgAyO2UM9zlNZUvG+HU4XVeWE6bEMAh8Yv036zBL1n/Og+9Cl6od64/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4rg3PXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6BAC4CEF7;
	Fri, 13 Mar 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370214;
	bh=AuB2hoB3rjDHQLSLwJW60WMeyxkHcMmTCZ5nEcsEHVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4rg3PXQxmY9CUCKjSxES+88pBV5ty/oLzbXoEwliS2hRPD1GOBs63dvQrmEI8OlD
	 SLGENXxpZGjZmUaGwvRDzRwrsQ52bXdEG7GoUPtGEqD7s66RIvgJEGAgrO6JaEOvka
	 Dut3YAITI4sM8ftv7IZzBNUKnoXKk9SydIhGOxtPXbQjgWY+1KVaYb2GMf5QD3apB3
	 maL5ZSXlWye0Og1flWaQQ6Kib7RTMfY/XyVIhxpErBp/hVBiA5z2Lqxt4KYnPnL5Pz
	 yzsUtnOql5Want1yECEsf+rJQHSYZGfMGKc0/HVj+DqhFpPJhHi2slRKO4qN23NzO7
	 E2p9cTvs9gQUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E263808200;
	Fri, 13 Mar 2026 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mpls: add missing unregister_netdevice_notifier to
 mpls_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337020979.648356.12952589246966136546.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:09 +0000
References: 
 <7c55363c4f743d19e2306204a134407c90a69bbb.1773228081.git.sd@queasysnail.net>
In-Reply-To: 
 <7c55363c4f743d19e2306204a134407c90a69bbb.1773228081.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuniyu@google.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267281-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42C4427CEA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 23:35:09 +0100 you wrote:
> If mpls_init() fails after registering mpls_dev_notifier, it never
> gets removed. Add the missing unregister_netdevice_notifier() call to
> the error handling path.
> 
> Fixes: 5be2062e3080 ("mpls: Handle error of rtnl_register_module().")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net] mpls: add missing unregister_netdevice_notifier to mpls_init
    https://git.kernel.org/netdev/net/c/99600f79b28c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



