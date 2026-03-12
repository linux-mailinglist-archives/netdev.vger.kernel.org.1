Return-Path: <netdev+bounces-266842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPCAFosgsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5E26C172
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0347F3047BE0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EF342524;
	Thu, 12 Mar 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6mfRmHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5A1EF39E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281416; cv=none; b=X0pqOf15Ssl53aaUODe32ab4NhqvUxE0RePuVZd9cs5I5xFYSYiif2FZBBcDJykyiyV8YK4qZWbmUjTup/KhwNM2Zex8kEl1abBMrcX5KpGAnxbbB3Shi74YIy/SLTPwqkwxgCbS8XJwEJxlgvjUhLUFkJiZps5GZCF39S+miDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281416; c=relaxed/simple;
	bh=cv1M1fghdZ4EhQ55aI1990xjAYWzNfrGUkNeREeUY20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1E5iwum5yimDcHSBMwEz0D+R5NKNdX87wN/eE/OxH58KGOHVR9WKhU8Es22Fi+iY6jh4B3xDmVVz+Iuiq+T2ub7CRfQNq7AUYc9QBkM+OM9NUuEtnSb2/TYKkCiiycWV9dNI2hpsjmqvImJ1FJP4XQLVgmtorURg7IDuUqzRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6mfRmHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3012C4CEF7;
	Thu, 12 Mar 2026 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281415;
	bh=cv1M1fghdZ4EhQ55aI1990xjAYWzNfrGUkNeREeUY20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6mfRmHMvw6sLQbeSYLzo9y57AcZTxQ9shEFiHX8fJHRRxaujQHhl8DeRZofOy/j9
	 d7tG3IuFAxM/5YofadpPezl4O5rm1Gv19lBunKNBrHWJszoqWp6niNf4yYAq+MRrni
	 B2q9aS9NY2V0Iw/GuX0JaKR7rt8L7+CKCVy4d0xQPWXaGU6gfU20cK9tLBkj0BTvsO
	 Aq9e2PVLzvbSm2/gh4t3mxcx/Vh6uUmH3jOKoQx6smA+JBiYxRBfM7imJfQw6rvj5X
	 5DUPCbEQHfPFFggJ+sauSjN4uoVgHthFuq0P/mNcC0p/8/EL54rxRnKznn7r0Qxtl+
	 P2XwrX24l9YAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F983808200;
	Thu, 12 Mar 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: realtek: Fix LED group port bit for
 non-zero
 LED group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328141156.3905617.4397320883467393121.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:11 +0000
References: <20260311111237.29002-1-kabel@kernel.org>
In-Reply-To: <20260311111237.29002-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, luizluca@gmail.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-266842-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1F5E26C172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 12:12:37 +0100 you wrote:
> The rtl8366rb_led_group_port_mask() function always returns LED port
> bit in LED group 0; the switch statement returns the same thing in all
> non-default cases.
> 
> This means that the driver does not currently support configuring LEDs
> in non-zero LED groups.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: realtek: Fix LED group port bit for non-zero LED group
    https://git.kernel.org/netdev/net/c/e8f0dc024ce5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



