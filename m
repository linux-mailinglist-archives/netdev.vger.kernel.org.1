Return-Path: <netdev+bounces-297714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6RQRIwV8KWrHXgMAu9opvQ
	(envelope-from <netdev+bounces-297714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312D66A839
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M7uT1rKu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297714-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A18F13019541
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293314192E0;
	Wed, 10 Jun 2026 15:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDA4183CC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:00:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103618; cv=none; b=Ix7JZUjVRIbfB+J9nHR3Qm9YyQoT5K1BkN9BwgSKVgxJTV9UyR+DsGwFvUO0AQycskV4E9WYVyzFccb6O/78p1NwSCuBMuHDIr3PZ/AsMvNjQcHOZEqRap+SSmDrWpQ+DmPc4PcYwb4qgq51q09c6XqzQcGi6FveC6wneGY64PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103618; c=relaxed/simple;
	bh=/EVEr/TZ0ZyOXsiZNqmyWdiffafzJvo4hA3Dx5RXXFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0BbeVA30mvLnz0OhQ3994gGUwDbD7yrHzFnAj65JKi3cV0naOkqOdmeye6mvBPnBYJ3rJOMUTPcDT4CLPtk3DUDxlf6oGpJRAiZse+nG4nwZpq7Dz+6W2SS2yLUMu5rGBVzdj4KwBvJST8NwC7FkyBfrgj1A1BthjT4NQYtnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7uT1rKu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CCE1F00893;
	Wed, 10 Jun 2026 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103616;
	bh=H6b/EuxNgTTfZG8Fo9lj4lbs2ggwHWOTevSmgRLsfvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M7uT1rKuG/QWzG3X7NAc7GR+88GFfGJ99vLLuir0/UbJ98C91knvzhN8YzSLWmAQ8
	 2SxgV2gRBmWBz5Wdfabl+cfB6ztn0R96tHwmkgem5M3S9cgM4nmSpg83L+2uKSmKV/
	 tb7N3aQDLHW/uv+VbXqOuDGaPwDbF9UxgADg26+bgN8ARysUihFLmBphAuOYsJAV2I
	 nhhdK3+w8+QH9Qal5H4JkawoJmZsoT/vFwYD1PBLA/uWkts6bB7z0vaVD/nt/pXEGv
	 bY2hr72rnFfy1SUsWfsyNSrXBPyM9wRxRG64Lstrs3O6rrF9nt5zgujyCq48b4YxW2
	 1hPysnhINHmmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BBE3930D5F;
	Wed, 10 Jun 2026 15:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 0/6] bonding: 3ad: fix carrier state with no usable
 slaves
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110361438.3080270.9321212979696390592.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:00:14 +0000
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
 andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
 jonas.gorski@gmail.com, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297714-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3312D66A839

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 17:03:25 +0200 you wrote:
> Hi everyone,
> 
> This series addresses a blackholing issue and a subsequent link-flapping
> issue in the 802.3ad bonding driver when dealing with inactive slaves
> and the `min_links` parameter.
> 
> When an 802.3ad (LACP) bonding interface has no slaves in the
> collecting/distributing state, the bonding master still reports
> carrier as up as long as at least 'min_links' slaves have carrier.
> 
> [...]

Here is the summary with links:
  - [net,v8,1/6] tools: missed broadcast_neigh if_link uapi header
    https://git.kernel.org/netdev/net-next/c/0134432215f0
  - [net,v8,2/6] netlink: specs: rt-link: missed broadcast-neigh
    https://git.kernel.org/netdev/net-next/c/363037983cc5
  - [net,v8,3/6] bonding: 3ad: add lacp_strict configuration knob
    https://git.kernel.org/netdev/net-next/c/32b0b8953343
  - [net,v8,4/6] bonding: 3ad: fix carrier when no usable slaves
    https://git.kernel.org/netdev/net-next/c/0bd695db23c6
  - [net,v8,5/6] bonding: 3ad: fix mux port state on oper down
    https://git.kernel.org/netdev/net-next/c/807afc7544b8
  - [net,v8,6/6] selftests: bonding: add test for lacp_strict mode
    https://git.kernel.org/netdev/net-next/c/f17e4fcc2b68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



