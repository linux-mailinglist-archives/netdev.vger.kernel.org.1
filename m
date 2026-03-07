Return-Path: <netdev+bounces-265042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHjmIO+bq2kJewEAu9opvQ
	(envelope-from <netdev+bounces-265042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:30:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9E229ED3
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF2F3075EBD
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041A30FC34;
	Sat,  7 Mar 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/3ngELX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D630F812;
	Sat,  7 Mar 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854207; cv=none; b=Rs28/LdpyQlObqzY0Poeq2gMihsTSJvUkzdTEVTQ7M4tt4WKBpBEEWT/vINzFNlhu0rENYKCK64CePAM636Hy5oz4Ts7vs7QtehPSMVjDB6HS9BihNwJOHHv/VXnB5mE0bFr62cmqyAgqAdSxEsWpfFaazqrzY9euwKSbs3mFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854207; c=relaxed/simple;
	bh=0tmablCA/bNk8cZ7LJmdOP0lfOQxP6ewLH2P7yb2+4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k5XO8Auegb5RF1WFhnsDC9nN++SbntlsRNdUc2NmHBNQ4wJxfXKU/O2Gmhb+cCh3vcSx6TAS9rbthDR52RzMBcD6EBACaMU2Ry6jN1amhZf9G6Ns4+x3opWPtB3ReWsDKqny+RQN5l+vZxrpEjUW0BE9pbz9RhZ//nfNK7fFW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/3ngELX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420EAC19422;
	Sat,  7 Mar 2026 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854207;
	bh=0tmablCA/bNk8cZ7LJmdOP0lfOQxP6ewLH2P7yb2+4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O/3ngELXPyO5OSGqMeGO9e2kAd8Z+DYKbEsw1kEbJdoIZxGg5CRSJhZlGkwZGe7V/
	 pZcfHKAt6Z95Td5z5qoSMLzzsJwrbGoD0o2Z1Wc/OT1W3qBq3dXYjWI2auBVd3ho1a
	 Zp/rhmQM/bT5cKUqHLRls8lD7xaPfksxr0MslqajkvIFlW4gbdDqvnQcOmRULB+b/t
	 upJEZOjbT/Onb/h/6XRbj7b2QArhJ1btSn0uzYvRpCI/f9jeKPRaGoYORBSrmIUQSl
	 wQS31wFXTV22l4Dx+Nw3hb2aJ84M9mww/9Jtgn5NMfhtUL48cdSjn1Gg1d11/5qFc2
	 qyNiOH/DA2TYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEE53808200;
	Sat,  7 Mar 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: lan78xx: drop redundant device reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285420605.140745.14809539628005382506.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 03:30:06 +0000
References: <20260305105006.16415-1-johan@kernel.org>
In-Reply-To: <20260305105006.16415-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 00E9E229ED3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265042-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 11:50:06 +0100 you wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> [...]

Here is the summary with links:
  - net: usb: lan78xx: drop redundant device reference
    https://git.kernel.org/netdev/net-next/c/f4ac0cc88e99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



