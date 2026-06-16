Return-Path: <netdev+bounces-299881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7NgAOe1nMWprigUAu9opvQ
	(envelope-from <netdev+bounces-299881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AAC690D48
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aZG8JcDb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299881-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F980302BEAB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803E36E470;
	Tue, 16 Jun 2026 15:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815633370EA;
	Tue, 16 Jun 2026 15:07:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622447; cv=none; b=e++gs7PCdD+LMpYRNGIqXsdaWLhvHnIhnvETnRwON+a8gGvsNjxOWuhhoukpmq4w+CtVdplH/JNwFHhpR4tzE2m1OEumu84gDPupsGZVuoFajz38MjbLRmtD9rt2qgzi7mPg/MQHb9/2FQ31vt2B1qxN+ZcMbub74UtetJrZq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622447; c=relaxed/simple;
	bh=z1TF7B7XeN9/uFBlmncRwLn+Ra4uSP4Szhh9LsxGPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Poh9grut3rHdKjdVx6ZOG7lWubjeCWwtlTcq07BJxipVK9Vbdoh+1663TduGQI/G/zMaxML2ZT68Wc2Bar2x038vp/TzxetJtSSzEkR6NLz2toI8gPhVZdTj+JXsrUmKyib3+YqAF1lygL1xQVqTxPph7s7bKrhtUyig2uK0gTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZG8JcDb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274F61F000E9;
	Tue, 16 Jun 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622446;
	bh=KNVv9ooOdPt4gDQz9b3gx0JN5sbG1rJmvfll/bOWLP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aZG8JcDbtDdPMer8gahR3+Hxh/jL/eqiKUDl/uBBRl5RBJcFCSsjs4mh/e2mesDVt
	 CDfMQ6pquhUPGsno/0bwQr9n6y2w/V2YlH4gn0YW18R5Cu5SYMRcqRUrwK7Rr/xesZ
	 NOq0T+yyGkrUNX3LKXyvx4+8hIjiFFgnL5CdOEyM7agauR8r1aEB/K2fVFSdi6pa7p
	 sT+tcGyqSbVCHiR4AkOz8+ewHv4nCR0AvStJ3V/7sv9Hn0MbowuCkJwzMVsIvvqpHQ
	 WvHlogKq3i29sduKqEY+DEfFrgwHfOiwnyo/FeCYvhl6eQeoQ8TdtGpi+HD91NpLeP
	 NoHYYg3bvgLzA==
Date: Tue, 16 Jun 2026 08:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
 <vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
 <jacob.e.keller@intel.com>, <arnd@arndb.de>, <basharath@couthit.com>,
 <afd@ti.com>, <parvathi@couthit.com>, <vladimir.oltean@nxp.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <srk@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
Message-ID: <20260616080724.0d838fd6@kernel.org>
In-Reply-To: <d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
References: <20260610052511.781752-3-m-malladi@ti.com>
	<20260615231041.1007484-1-kuba@kernel.org>
	<20260615163932.50bb3df0@kernel.org>
	<d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299881-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40AAC690D48

On Tue, 16 Jun 2026 18:24:22 +0530 Meghana Malladi wrote:
> >> Could the firmware-register lookup table used by emac_get_stat_by_name()
> >> be separated from the ethtool -S string table, so the new preemption
> >> counters feed get_mm_stats without also showing up under ethtool -S?  
> > 
> > This -- not sure about the other complaints but this one looks legit.  
> 
> I agree that this is legit, but right now there is no other place holder 
> other than pa stats to put the mac merge firmware counters. I believe
> the effort needs to go in re-structuring the hardware and firmware stats 
> implementation to address this issue.

icssg_all_miig_stats has a true / false that looks like it's supposed
to serve the same purpose? Maybe I don't understand what you're trying
to say

