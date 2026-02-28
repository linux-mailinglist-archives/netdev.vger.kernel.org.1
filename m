Return-Path: <netdev+bounces-262066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBR9BP9jomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:41:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F491C02D7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2063070B28
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A47D2C178D;
	Sat, 28 Feb 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPq5mVTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704128641F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250018; cv=none; b=kcgs963BLOmu+a84RrWWhvEJFDl2WKEEmLueqYQQaCQX9gq6jDDfzocmNhWNmp1YopCaVsqxOWXBNnayjQi1dZ+bW2E86RupsdzYuNskHOzfCVIUKjgiqEqzie72oRuNQbWZFAMn8rfbX+QHXHrSUG/AkIv7Tltwkp/RmrNECwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250018; c=relaxed/simple;
	bh=BsaBgK21HxsMO60WC8Y3oU6kTDoT575+nzkem64mO8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSZgwMEuwnXZwipDQ5aSMdZ8OGWXws0qfm+nax/sZCndgCBSU1bnI3rXGyydkQQZ2pT4zBRENxCUChXkULemK6XR+Wv1/3SM0lAW4GBBBQnAzmaJIthgh4881ZsPLbJ+VKojIcJY4kvzCDkKXbkwbXwnqYg/noyRtNtKquettAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPq5mVTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045A5C116D0;
	Sat, 28 Feb 2026 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250018;
	bh=BsaBgK21HxsMO60WC8Y3oU6kTDoT575+nzkem64mO8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YPq5mVTl5LTIIdfWyeqcNICEfak6d+oWoGkdXCyB+4U0mVPSjU+IYUr1J/kpEws6V
	 /2IJauxbejZ38Xh1ZENI9CG4/oJDOo/B+OL4BUbDYMVio2S5kQL/hw8qYGdFz1mRFG
	 LlpceR0YOmMhxhSbm4zAaqYrjaqPbS4ePB+1hFhVaVy1OxcjYqeHHvPcWtcKy3WRMs
	 KYX7Pw0ks6C3/Q093SljIQwFaqK/OsJvPhkpsc+o0/R/mSmJTtmXl3p5455CkUKm/A
	 W6+gXTz8ZHXSH+yd7B7DoNOcRQQm5wAubENBwoJqkaQS0pOUsXnwbbSrJMa9gLs68Y
	 E3pEVCdknlCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FF639EF96C;
	Sat, 28 Feb 2026 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: fix header file kernel-doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225002153.2855218.6435724484103359497.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:21 +0000
References: <20260226221004.1037909-1-rdunlap@infradead.org>
In-Reply-To: <20260226221004.1037909-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, krzk@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-262066-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F491C02D7
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 14:10:04 -0800 you wrote:
> Repair some of the comments:
> - use the correct enum names
> - don't use "/**" for a non-kernel-doc comment
> 
> to fix these warnings:
> 
> Warning: include/uapi/linux/nfc.h:127 Excess enum value
>  '@NFC_EVENT_DEVICE_DEACTIVATED' description in 'nfc_commands'
> Warning: include/uapi/linux/nfc.h:204 Excess enum value
>  '@NFC_ATTR_APDU' description in 'nfc_attrs'
> Warning: include/uapi/linux/nfc.h:302 expecting prototype for Pseudo().
>  Prototype was for NFC_RAW_HEADER_SIZE() instead
> 
> [...]

Here is the summary with links:
  - NFC: fix header file kernel-doc warnings
    https://git.kernel.org/netdev/net-next/c/2164242c5008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



