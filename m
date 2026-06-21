Return-Path: <netdev+bounces-300916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EOxtNi1fOGp/bgcAu9opvQ
	(envelope-from <netdev+bounces-300916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1E6ABAEB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ogn4JXQ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C06953011C73
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20C37206F;
	Sun, 21 Jun 2026 22:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B764371873;
	Sun, 21 Jun 2026 22:01:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079269; cv=none; b=eBbiFJ3guqiXXbeAXU4y/Z4v6VFv7EklFLErC/oSZ8dsmMcExLBtFo3wW60OXgDv1SSKezEMe0pu3vtkshK18wq5SljznLMwiHBVRl7FUclR3SbdLauFBOH3gdhrio8HvSjyepUhfeEyyNBf+QkG5hVRHv5szZNXSqyPwRZiwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079269; c=relaxed/simple;
	bh=OmtCEXoRXr2eGxNmEGO1gSON5B7dXjYwZpI87PMpR7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP2xAxynlR4i3USDxuviBkgm3eVviJNqIqqlAJW7G705RwH29A4KoHbYh/KOCqy1/4gZYuOnFhjZKft0EP4XVzQCgUxHP20fyPQo6xSnDtndGwWwPBV3q8ahllO0J3KHL/nT39VJnUCi/eWl+x/F2QIQI8gBbWugc3UU9utDPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogn4JXQ5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC11D1F00A3A;
	Sun, 21 Jun 2026 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079267;
	bh=iNjPU6HggFuoVA4ZTw1VkLefgRzbA46/D12Fn2e86t4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ogn4JXQ5AOjyBVu9RdfMxiGA6oO5GEQ6HHmWWo1cdNic2AyOhHGXb0ml0CEMED2I/
	 QR87cTLfNF9MwNevDiM8b6g1lZBFcrE2E9uVuCE0kZ4O4xDNszxEy2GCWhyQr8wsXK
	 cMU+sJqMi+BM7BB1gDTCcYzOhiftIPUZi50h3X7vJMS6Ce7AwZYi3mYRyBE4bYdilf
	 1FzdvjCPota9DF+keTLZ9hclY9huU6z3PfRBkLb6RTAluBxjycrmaf/GGp2j92w5Ns
	 05nEcybd1CLb5X9wOugZJde+owlMCniUVnkmwH0ICnfq5T2X9F4MSBpN0LFdGimagD
	 8bnZLgTos5tKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569503AAA6EA;
	Sun, 21 Jun 2026 22:01:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154-next 2026-06-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207925927.516339.17557918871659939971.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:00:59 +0000
References: <20260620174903.1010671-1-stefan@datenfreihafen.org>
In-Reply-To: <20260620174903.1010671-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-300916-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stefan@datenfreihafen.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:alex.aring@gmail.com,m:miquel.raynal@bootlin.com,m:netdev@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46F1E6ABAEB

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 19:49:03 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An overdue pull request for ieee802154, catching up on all the AI found issues
> at last.
> 
> Shitalkumar Gandhi fixed problems in the ca8210 driver for cases where we could
> have a leak or a pointer truncation.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154-next 2026-06-20
    https://git.kernel.org/netdev/net/c/617fb6fa9c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



