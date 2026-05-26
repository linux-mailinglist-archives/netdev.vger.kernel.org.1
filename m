Return-Path: <netdev+bounces-291705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICmuJoimFWqJXAcAu9opvQ
	(envelope-from <netdev+bounces-291705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3B5D6ECB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DC16300334D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CDD3ACEE9;
	Tue, 26 May 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlTGdn6U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127C232367;
	Tue, 26 May 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803658; cv=none; b=YWvazvN3Hh2zULZruIbJc7l5zi90n8CKm0wgrmq1rl+8mq99rCIisXR9wAd5s3GJ+JVc7n1dQcI4OHJXHWsgOzOJq8IE8qTLwaYhnNP2t42xsnWwo8lOM5hvOQ91R1qWz2q+Wa/mwnoqFVN1hpPiWA4Dwh9a+ircFz1oNhp8Hh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803658; c=relaxed/simple;
	bh=wKJXDkASdxGv5XkbxOAscLvJvMCCT9ydNiDEGPXCgMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tzSryomqLrxy3R8PQ5D3eO+CMSaPgR2lHSAprs/LL2OgAFH2m1GX7A+NY4+clpxL6CERXhrT+wq9mAYr7vQNnH8MpGQacVMUNDb8+2KxsGKEGTO9SPiq+5sNORwp/YFLBHxniSQAtBBsku9xQRsaK56lahAZfvX4zhc37uFaK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlTGdn6U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76BC1F000E9;
	Tue, 26 May 2026 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803656;
	bh=WLgV/Xin7YlIjiVHXZ4eiEvQ7g3pM9UQaagNfol6CcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mlTGdn6UwKHGnAtDoCHqlihkP1FQVsSGmNwid/oTs/b1NfOv4aNVTMmqZyKyWmrlo
	 Xtnjp6cShAv57ggMfiHV+A51e5iy6HOskyDYysF9Iz4scnRjo5zf1QwINgv0jQSW7f
	 Wv+RBsIQZlkuvHcz+xb6q3PlaMnJSrOIJH1s+4waSJwUQXjB8AXTfXaptS5CgczYb2
	 6CofEmjQUHrbvkRPSCZ1SfSPEXX9Jug0BxzvBN5rpVJ1x76JasN/wUQkzdp2ZCn3Pw
	 ktJZtgwVwLslpg8/i7JCDh7I5gbzVx1F/mn3qsSvA4o7MU4fNWnjS/xIXFxlrxATjp
	 D2143pzxnXjFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199CC380CED4;
	Tue, 26 May 2026 13:54:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] s390/ism: Drop superflous zeros in
 pci_device_id
 array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177980366265.3384005.17527957478769119230.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 13:54:22 +0000
References: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-291705-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.803];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4FE3B5D6ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 May 2026 17:30:09 +0200 you wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by a list expressions to zero without making use of that
> value. In this case it's better to not specify a value at all and let
> the compiler fill in the zeros. Same for the list terminator that can
> better be completely empty.
> 
> This patch doesn't introduce changes to the compiled array.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] s390/ism: Drop superflous zeros in pci_device_id array
    https://git.kernel.org/netdev/net-next/c/18b9f739d3f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



