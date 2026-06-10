Return-Path: <netdev+bounces-297373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O28JHXm3KGryIQMAu9opvQ
	(envelope-from <netdev+bounces-297373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266B6651A3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:01:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QhkPajNU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B8423047679
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59664259CB2;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFB248880;
	Wed, 10 Jun 2026 01:00:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053220; cv=none; b=Kq42YipKGumsjDjXHgE+XWzEQihaL7zuttDyP+xbEZiMXcgQKoNw+xDxwWooaoghsM6KiXKnLz4NRV1iS13x6cfAGvwrwaOi/0KpzK3NguEnK4MYvmZ4QN6h3Fw6711Akxf26hakyVyYIOZ2R5yEF3v3RvtHvoCQsgkpaf3BNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053220; c=relaxed/simple;
	bh=wLwt2G8jW7yg7dZCQpEhpZmCUYIjn6d9ID/HQZuuBNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B1l1glEYkyCkWUWYytgdAW9Eu0hRo3Ic9jIahLijTiuJZiWSlijLqjFBj4hyOffm18d+zuaU4aUiAAmUtzkQeLQrQ50gZ6HJbnCQUemLXNKQfaPINENqX/X9aiXKl+aTUnkHCL7rHlD0F2qoQZu5mfOl3HX4YNuFNOB9DdRN/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhkPajNU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E811F00893;
	Wed, 10 Jun 2026 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053219;
	bh=rDxKiM+w3SmdOsTJtOMtmUeQ/ErFwtyByc3Qblso3tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QhkPajNUym4UFYH6hLfqRVXqYK3GTX5rtsFH5Dt/g2Ep+tsq7E9kAOAxfCVqP2Ond
	 WHo0+Pk96OhgVXPbi2+OAu47mLF/w4vaYqtyxRRAAZqmnIpsXQb42ZNbzrxdbfsIQP
	 KmE5sut+BbsTCo/WIke5jgNrnkjthtVVNvfiYAygaubF7Y3VY6TeZoLLUTAT2wJQEC
	 mYmnZzojNBxRC9UOWMiopuA7oYpe2Y8YLjlN409byhdbsevvL22hv2UbMNPfx8UaDN
	 z2IEa+2hngxHDQDHwk5CEsolISYw85fyJrt4bYVagxpWkX+pyEeoWmIDKxFAnqjlCq
	 yQAUc3PyEjkbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B5E3930A12;
	Wed, 10 Jun 2026 01:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next-next v2] net: dsa: qca8k: Add support for force mode
 for fixed link topology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105321713.2773882.746838782482338822.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:00:17 +0000
References: <20260605-qca8337-force-mode-v2-1-d9a6b6545bfa@outlook.com>
In-Reply-To: <20260605-qca8337-force-mode-v2-1-d9a6b6545bfa@outlook.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297373-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1266B6651A3

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 05 Jun 2026 12:11:29 +0400 you wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> A fixed link topology is commonly used to connect this switch (on port
> 0 or 6) to a SoC's MAC over SGMII. When inband negotiation is not used,
> the switch needs to be configured to operate in force mode. As such,
> enable support for force mode.
> 
> [...]

Here is the summary with links:
  - [next-next,v2] net: dsa: qca8k: Add support for force mode for fixed link topology
    https://git.kernel.org/netdev/net-next/c/e0a77b1ed900

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



