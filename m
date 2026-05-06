Return-Path: <netdev+bounces-284641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9bIJiX+mk6QAMAu9opvQ
	(envelope-from <netdev+bounces-284641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6C4D537B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACBAE305B2E5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68526CE2C;
	Wed,  6 May 2026 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaeEi1RC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A2267B89
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030463; cv=none; b=PIfWlqUuAuwTle/BIc4s1k7SHdULpmXt2aX/SbUX6oT5AZwQ+kqUKa7d2H81pUt0O62dSh/tTByfzo9CIyGHTRGN0wryDCsaBWxp4k/CZhYEhsjfb7c5rdvcopM/ryj/o8VR3BNgDDy7zYclnTevXNEYH31j4okxduC/Ce5Eo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030463; c=relaxed/simple;
	bh=7d3hUfLS9/Ny1rGpsEFBpEenF8GHVxLtIt8X65rA3mY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/2CEkP/lWR3scJHZ+gUiTS7A+uiytXUylSylDZc/YNqB4XKtrvqAKuxqmKX/oOR2C6rHLVYLHWXXzgugPMhrRmHhygyNQIGJ6cpH1LAOiBHL0R5pngLSzniCybq0MAQy7o1zNRmMIGx25z6MOKJfXNx625m+hr/qtv9D9rg2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaeEi1RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C7C2BCB4;
	Wed,  6 May 2026 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030463;
	bh=7d3hUfLS9/Ny1rGpsEFBpEenF8GHVxLtIt8X65rA3mY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaeEi1RCblP1aTQ8qs9/AGeQgHCvKPmxXj5K2O7XjpXehb9XAmMuq2BUcqnjuGEvK
	 mSY33dXOY4I/adUSKfho2FHiSY7SO5RQWpp9p5xV7505WjONgwI8cdub448YNaSdaD
	 FYw14xstj4+fF7t4TBDc/FKltrLgxcMX7rKbwPbSMqt5C0UI6ixAb9DsU1IGkxdMwB
	 Cf2+4xJBsDcIJmSUzPUtpqeOzh6q0UdQZ0Dg+oJQyeSfGiwE7f9Qg2zFAISrj1cF4d
	 uSjYjipY975KEKPNq6/NfpcoYsQv39whHJslDq6vHfIu1ixLOkHQgluO7fjB7OwjHp
	 Xe8Ww91ORWswA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ECE3930780;
	Wed,  6 May 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803041354.2335725.14444497746979869376.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:20:13 +0000
References: <20260504152653.1389394-1-kabel@kernel.org>
In-Reply-To: <20260504152653.1389394-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, rmk+kernel@armlinux.org.uk,
 vivien.didelot@gmail.com, tobias@waldekranz.com, netdev@vger.kernel.org
X-Rspamd-Queue-Id: EDE6C4D537B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284641-lists,netdev=lfdr.de,netdevbpf];
	NEURAL_SPAM(0.00)[0.688];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 17:26:53 +0200 you wrote:
> The .port_max_speed_mode() method is not used anymore since commit
> 40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports").
> Drop it.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c |  9 -------
>  drivers/net/dsa/mv88e6xxx/chip.h |  4 ----
>  drivers/net/dsa/mv88e6xxx/port.c | 40 --------------------------------
>  drivers/net/dsa/mv88e6xxx/port.h |  9 -------
>  4 files changed, 62 deletions(-)

Here is the summary with links:
  - net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
    https://git.kernel.org/netdev/net-next/c/9c7d567358cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



