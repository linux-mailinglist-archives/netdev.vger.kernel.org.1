Return-Path: <netdev+bounces-289674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0p6INEYFDWotsQUAu9opvQ
	(envelope-from <netdev+bounces-289674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:50:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF258661E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8413040027
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34E2475D0;
	Wed, 20 May 2026 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiEG+loa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4F3438A4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238212; cv=none; b=SXduNIvaNOgp6Q5S/vETOLOA2jp28VlOm/GWSGor5aB6qGReceF8KvcHKCx/V18HY0X3wnQvLQUQmU/DFF1SW1e9WfCQPgS3k/wz7+Ari4WGDLxLxoHGziXGajojmucZfoFPAubG572ULr6+3DA5niRXheyoNJBv+un+r4MUndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238212; c=relaxed/simple;
	bh=yZsanh6A6idxePmlY72aYExbwN7xMIrme4fuL445AsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tt+FiYGFzixoQLigJKOQMTOl9a+Ae61LVi6Nf1CZiwH9tjzTWcgUwwjLIC+luhg87PUk8Kh6WmJOyIVkL14gFroChhxkx+dkHuNubwJr8Ll/s3ofqrSqHLRP9hd/EUCauX7cpe9J11SIszZWJVKGOYRA07GpIRBxJ0Apo1EJlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiEG+loa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071461F000E9;
	Wed, 20 May 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238211;
	bh=xETyB/jUNFN5VKGPq3BT+u4C5ttGHz5ikIxoZ46cPnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fiEG+loapb9SYuQvetGfJk4d3XPmND4/8meby4HfWxW6MOw3bkJVGTxJh6In+8cr7
	 szmnRSQqwM76ccH+ty0XDhccn44qauo2wKrmXKhj8n5hEzWsNCOH0YIxEnMwod0VOk
	 0IuMjNJCWhc/xRwmZz4rkY/vmARzyx+Q1fmwPyhfuB1Ss2z8czyXj0gUancn4GVjDB
	 dhzbeId+hHmDe3cBR7YVH7kKRbdGcdUZaM0zNgwIcm9AdQL4iDxdbaIS1M9m4/yXLb
	 6uM3slLV09RA4xlSaTonNI3Cl9jWOZ9ol8Wvy6LlgWQlgn+OXcQJgX/+8bWYrS2wrZ
	 hZ2uoz0IGN91A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19967383BF53;
	Wed, 20 May 2026 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] Add support for neigh_forward_grat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923822163.2936298.14037169284404480049.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 00:50:21 +0000
References: <20260517082501.899009-1-danieller@nvidia.com>
In-Reply-To: <20260517082501.899009-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 razor@blackwall.org, petrm@nvidia.com, idosch@nvidia.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-289674-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CFF258661E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 17 May 2026 11:24:59 +0300 you wrote:
> The existing neighbor suppression unconditionally suppresses gratuitous
> ARP and unsolicited Neighbor Advertisements, which breaks legitimate use
> cases like Multi-Homing and EVPN where these announcements need to
> propagate across the VXLAN fabric.
> 
> This series adds a new neigh_forward_grat option that provides
> independent control of gratuitous ARP and unsolicited NA forwarding.
> When neigh_suppress is enabled and neigh_forward_grat is also enabled,
> regular neighbor discovery is suppressed while gratuitous announcements
> are forwarded.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] iplink: bridge_slave: Add support for neigh_forward_grat
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2c6d5e670539
  - [iproute2-next,2/2] bridge: vlan: Add support for neigh_forward_grat
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5d8d82f60c52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



