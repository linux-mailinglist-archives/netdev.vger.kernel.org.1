Return-Path: <netdev+bounces-294347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywQ0N+wlH2qSiAAAu9opvQ
	(envelope-from <netdev+bounces-294347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691A631353
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:50:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cO4z5pL4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2D20301531D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11469396B9A;
	Tue,  2 Jun 2026 18:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DE327C08
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426218; cv=none; b=GMt8g8xoomXN4xOYhddwCM0EYYNiw89GbsARnlQZlJcK5SdiWdia8/gvwkJSolBZZ8yFW5hoqWOkU//2bdF9HQsEWdDyPibKOQNx3wlrdEDRF9ffByrmnp1NzHa9nrYvN0K3mMNIxuTY8VYSsmGfyPHoUNOig61Fs4yUC7wdZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426218; c=relaxed/simple;
	bh=I7YxKKIdQfR1iS7sFbxPgJc2eoGpzCertLRhtpkIWjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dL04nwht30Q4QRjCzwpWyd/gkAkcpbzuet6b0Xym6jVsNrJk2caLlgLth1t1/NRjeSANe14yrwFfbRkFIEHeaC5cWbOksEC/4t+PPlEW5nrVJoDUVVJ/di2Fcg8qbjjSWaImJBOx6d8Ah1QIlZfR95SGT9htHyH1ITClRpz7RNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO4z5pL4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69CF1F00893;
	Tue,  2 Jun 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426216;
	bh=R0SYplVMloySSwDq/VBwbPpxyuYMm+A/S2XlHZ9g/P0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cO4z5pL45jgVF8E2WaHaCrSDjsWAXa8HvMf7DumpRLo3dcoCzwMTzwILsP8IiarqO
	 FhGdW01X/vKBfcT1oYDPGkmgTgnFuP+frX86cXkbr4COIQhL2zzZmLWpfp1/3ORR+X
	 /EfxaEEtyzge5p4WWA0O4odAuI2wxDW670IyAFiRG7uC513o3ZoMc1and4MKPZsVHn
	 7LqkKpZ+NlRG2DFRNl5D0IBtYSBl16DIr4lII3bVUsIeW1p89cuh6paz5LTAUzmzie
	 B4quxZResp2dVXW4mhHFtcNqOEgi2HieDX1me7mpi+IVhUnA/ha3Aa0URtW8zYkRCW
	 K81swYIid4jeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A513811A6C;
	Tue,  2 Jun 2026 18:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/2] net: phy: dp83822: Add optional external PHY clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042621839.1003781.7382173821656040286.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 18:50:18 +0000
References: <20260528184642.33424-1-wahrenst@gmx.net>
In-Reply-To: <20260528184642.33424-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294347-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wahrenst@gmx.net,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.net];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6691A631353

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 20:46:40 +0200 you wrote:
> This small series implement support for external PHY clock for the
> dp83822 driver.
> 
> Changes in V2:
> - Make readability changes a separate patch as suggested by Andrew
> - Make clk a local pointer as suggested by Andrew
> 
> [...]

Here is the summary with links:
  - [V2,1/2] net: phy: dp83822: Improve readability in dp8382x_probe
    https://git.kernel.org/netdev/net-next/c/d790b7064387
  - [V2,2/2] net: phy: dp83822: Add optional external PHY clock
    https://git.kernel.org/netdev/net-next/c/8a9f9bd2d070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



