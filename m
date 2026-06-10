Return-Path: <netdev+bounces-297417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6s99OOTQKGq3KAMAu9opvQ
	(envelope-from <netdev+bounces-297417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B866581B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:50:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Olw3XyUW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297417-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32ED4302B83C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B382D0602;
	Wed, 10 Jun 2026 02:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3021145A1F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059808; cv=none; b=SEZhZGi9zYJ+hG2UJoPLJ/8r9n/cUPGYNlnd61OFhRn0nnCVSzSQFCYC1nQX2oOQNlvmQbWTGjl6Hp3/sKaGd6Nm3ggPNx+kAsh8COK8rF9IBN2a3Toc9oNAnfKp3EdHy1t38yBSuNjwgPM/+nvmgJc3X1RqXX2ZJjLp7D4TqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059808; c=relaxed/simple;
	bh=stY0E8LRzxdFUUiib3Ca7Wgifcpl5nDQGX2Qr6+Af9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=okoyxBEslgTl3BJDuIMMz2a9jbl6I6znVbySypAvFXRHi9mU4vaMJPngWLTtbcsLcPXzbmCun0LGg8qYEv+ZENkLHRWfkbJGOoXKabRqaGXPS0bD5L2rgmUImSKdJTBn3hkxJ1l2ovhf2naPor7G9YRcDqDj/OGCDO/89AdE5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olw3XyUW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3EF1F00893;
	Wed, 10 Jun 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059807;
	bh=kYzkiUak/Nr6n9s5xskIwZFviCrSvm8i6bvZdI+wewk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Olw3XyUWd3QJG4LrEpij40MIT0Bxm2v0Yx5nVuFhtbU9IHrm7qiKbMfDgpETnEbd2
	 cKs/Q/P6C9nueQ9OHmKNOGYvVV2R8nzFUZstV9ZRvJjQhGZDNhEtALRzJ3INKctP5a
	 1RBJU8zGhEYha51wtI4kBzp6476XtrkmB2rkTAVJkEZ3ZSYaGj7qkvAbIK881fBLaL
	 MlFfdaRoxtPsrBYrSTjqfurT50B8mfoIprOFQGBl09+MndTEtvLH3yz+s+yIjeJy0Q
	 noBVA0dhia4psnJfRzKr0+DFuiFy9xTgLaUOKMnTMiGeDeb7qy5fWt3CMRe35KGwCR
	 s1EmoqAIlES9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0B3930A20;
	Wed, 10 Jun 2026 02:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ptp: ocp: fix resource freeing order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105980539.2805596.14452078462884649454.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:50:05 +0000
References: <20260608155952.240304-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260608155952.240304-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
 kuba@kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297417-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:vladimir.oltean@nxp.com,m:rmk+kernel@armlinux.org.uk,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A2B866581B

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 15:59:52 +0000 you wrote:
> Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
> events") added a call to ptp_disable_all_events() which changes the
> configuration of pins if they support EXTTS events. In ptp_ocp_detach()
> pins resources are freed before ptp_clock_unregister() and it leads to
> use-after-free during driver removal. Fix it by changing the order of
> free/unregister calls. To avoid irq handler running on the other core
> while ptp device unregistering, call synchronize_irq() after HW is
> configured to stop producing irqs and no irqs are in-flight.
> 
> [...]

Here is the summary with links:
  - [net,v5] ptp: ocp: fix resource freeing order
    https://git.kernel.org/netdev/net/c/627366c51145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



