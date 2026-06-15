Return-Path: <netdev+bounces-299622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h0QoG75sMGqtSwUAu9opvQ
	(envelope-from <netdev+bounces-299622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:21:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD968A275
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P5SMW8he;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6CFA30387BC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F03AC0F5;
	Mon, 15 Jun 2026 21:20:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5A3A7D91;
	Mon, 15 Jun 2026 21:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558443; cv=none; b=u9VRrGoWY3LjvoE8FVNQQ1pvHllszpdHUwiqljp/ai52SldO0pLhlaJpUEqNnPUpszi6c7y/brUtMuP83+kb3RyWlKPvdLXqLkJ4FtWSpHJr5t2piLR7ULDu0dA2vAUCRxkKB2HWeIr6o0Dfd9awzF3v4a6ay3NJss7ndE8Qgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558443; c=relaxed/simple;
	bh=6SFZ1Z8FWmFOFN0+EapHzJIpEVt9aMs8514PT78fDu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgMbxRcfIK4C+phaTM6n9rwCwiJF/tK8N6zDHBf2rIznQSiW/hRW71jmAuCzRaZOd0sYDqadVkvX4z3J/OB9Dkgkod6ymfkXY1gPLmBoAEvWMaLxrVRl9XFS2js63nZ6PCByfNeiknCCtPLMHHF54BBVLUyxKJ3hyRPGSEPtYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5SMW8he; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADD21F000E9;
	Mon, 15 Jun 2026 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558442;
	bh=hIklq/7rHscenEH8VHGYyl23zXN1GT6gbEWhbckp1hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P5SMW8hewF1NtC5pAYHdm1xzzkXhYCk0f1jGU5vAtyy9par8dUBfggGrG5xG9vbtN
	 toBVaUTaoXB+YUqLeplsUwp+bECqA263Y63q2p9cGW34ittCcJEInFWv+BUHbtR1xA
	 8yyvovVOY96MXkK/qrkuTsuSvkfFFaISzIeKS6y1uTgPbLBWKoHgjhlioY2tqOhFLY
	 vr+WyUkC6eu734C5RX4pM2//s8Ur3m8HGUJQ1DAOMtjKZtF4TfY3/8McaCn2pkeZGL
	 t2p0imHGTdLyir/nh7waEK/EvnNf5YoO2HFN2MBdZrfJYY6TgIWlFbmkdkGGW/HP54
	 m3uFR8hwB37UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097F3839A06;
	Mon, 15 Jun 2026 21:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/2] net: sfp: extend SMBus support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155843738.301119.9459899533729939488.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:20:37 +0000
References: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299622-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCAD968A275

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 13:34:16 +0000 you wrote:
> Today, the SFP driver only drives I2C adapters that advertise full
> I2C_FUNC_I2C, or SMBus-only adapters via single-byte transfers (with
> hwmon disabled). Several SoCs ship I2C/SMBus-only controllers that
> support more than just byte access -- e.g. word and I2C block -- and
> have SFP cages wired to them. Today, those adapters either work
> poorly or not at all.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/2] net: sfp: apply I2C adapter quirks to limit block size
    https://git.kernel.org/netdev/net-next/c/f2a138abfb71
  - [net-next,v11,2/2] net: sfp: extend SMBus support
    https://git.kernel.org/netdev/net-next/c/58b29bdf6186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



