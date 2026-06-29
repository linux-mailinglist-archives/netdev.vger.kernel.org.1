Return-Path: <netdev+bounces-302645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+jcBDJ0QmpH7gkAu9opvQ
	(envelope-from <netdev+bounces-302645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C186DB429
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=QSD+OS2B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302645-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302645-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5133015D0D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED814071FC;
	Mon, 29 Jun 2026 13:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70E408013;
	Mon, 29 Jun 2026 13:22:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739334; cv=none; b=mAH+CBBPqwRQLHg3bLp5awuLRUFn1beh5BgMkbztlwe2Ky2Pq7bdJRK//fo2EO6VwbIFuKIF/C+W+8cm2mJNVWeHhrNsN0+sWMiquwL4HqE4x9Zn4P3TyWWBVslBpFkB2KEB95V5KjT7L4GY9hL37IRtK+M5RkspUGpJ5nsffDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739334; c=relaxed/simple;
	bh=8esuHclQn2TmNlUkMOFiokUzrniEpSCwHmAvMa6AlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csGPQdHEZ6f8d74/s+qrP8q+EBKkuhE3urEhuGGV+wAfrDL8/YMjIpknenKZLUAMjkxhS3VP7yJiN24TaJAxwJA94T15itSUb0u3iIg+PEZWRZsFscoaYK/gty4DrkrB8+ip9CZp2XeTMk+jc0guv9RbJWDQdKS/ApTHirCCDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QSD+OS2B; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yYFpYJ+g2LXtimSsYZ5CW6pJeIZVEOYSSSKP4yuzF7Q=; b=QSD+OS2BjfQAAENwOEWJmxxbGR
	70LV2fhofGtUx+vncvyeV5M4OmFUakmhX+gehxwr9GDCK0ewQCQPi9NR0YoMr69fmWWgLV+E4HMX9
	RMwmili6X90m8JgvXWGLraw42/Pm/7VmRc7H59uKOhQv4lLYEYqFKS+5N8pDQ0SWAO2dBQvr/uCTB
	bBzf54OeuYGyQfGV0NVZZJYXdZvGcnzfKCRHYBiKO4jJZE0t8awhTj1bN2jAkcuP3jtog9gNi1Aqo
	ebiYDrgSLa/XyyA9NgUmQeMPbx0WeSzADT25Av4NVROP3jU4gKge5MsteghFBpSG2eCv3iEdZfHnx
	BGmggXlg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weBw8-006JqD-2S;
	Mon, 29 Jun 2026 13:22:08 +0000
Date: Mon, 29 Jun 2026 06:22:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, 
	horms@kernel.org
Subject: Re: [PATCH net] bridge: stp: Fix a potential use-after-free when
 deleting a bridge
Message-ID: <akJxbo5tn7_fcCdL@gmail.com>
References: <20260629072117.497959-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629072117.497959-1-idosch@nvidia.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:razor@blackwall.org,m:horms@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,vger.kernel.org:from_smtp,ssd-disclosure.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65C186DB429

On Mon, Jun 29, 2026 at 10:21:17AM +0300, Ido Schimmel wrote:
> The three STP timers are not supposed to be armed while the bridge is
> administratively down. They are synchronously deactivated when the
> bridge is put administratively down and the various call sites check for
> 'IFF_UP' before arming them.
> 
> This check is missing from br_topology_change_detection() and it is
> possible to engineer a situation in which the topology change timer is
> armed while the bridge is administratively down, resulting in a
> use-after-free [1] when the bridge is deleted.
> 
> Fix by adding the missing check and for good measures synchronously
> shutdown the three timers when the bridge is deleted.
> 
> [1]
> ODEBUG: free active (active state 0) object: ffff88811662b9b0 object type: timer_list hint: br_topology_change_timer_expired (net/bridge/br_stp_timer.c:120)
> WARNING: lib/debugobjects.c:629 at debug_print_object+0x1bc/0x450, CPU#9: ip/359
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Reported-by: Neil Young <contact@ssd-disclosure.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

