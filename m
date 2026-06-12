Return-Path: <netdev+bounces-298540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3rkhHz7MK2rPFAQAu9opvQ
	(envelope-from <netdev+bounces-298540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F26780F4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OzzIx0Mx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298540-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CF0303309B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313737474E;
	Fri, 12 Jun 2026 09:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200735F615;
	Fri, 12 Jun 2026 09:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254889; cv=none; b=GqeEbySLxqU0WZROvxGOa3OviGin2KKwnD96V1JrI7IbIBB2bP4mJ1TygqivsLIwIcKm6oZhr+oqgoMbCIBpqUhpB1bmb7p1tQP2ZPxjCqgSoJoOaEbAC4/xzbjvQaoV1/aVdBxoXD8wkNOsfTVBDMuIHxE0dIfhmh5tska/UMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254889; c=relaxed/simple;
	bh=/gj3zLygXNdyWgEPEyW3Z/aV/tAoAZ5gy3a/HIDzGAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW2rVw2ksZj+AKX3eAUA71wQlxQam+7EnP0kzv6APd4SSrpfg9//kTw39UvqdB6bmQDyVh7z9E3oR7Oy+e2A49vy8fvn4GxLaHSS54fsjzqzRKu0OkPVWKyjpUV5AGOmOX1wQNqupMKkSQo/pO0nJNLuDiGE6uEqCiTfi9bZobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzzIx0Mx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC931F000E9;
	Fri, 12 Jun 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781254887;
	bh=JnSsKigRn5c+9jyMwus42zkZGVkrxMiJEJg8g85XgB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzzIx0MxWjxzMrhfGvjizZFWDLyehvu+K58gQuyQ9+W96Q/GbX/fMeZUXOHV6dkRh
	 tQbqn9WBQH7hpivayGb6t7MvJEq/DYJPLf/lWtwhLI/YCTi0nC+ZxCu4vPqNeP48qO
	 RJtyYNfhLxGAVAbtAdmRpMc2BBaIvG26GBmaY2inKz/z0xsJM6yKPtztZZDEkswF+4
	 PuUYnf29ksfLGnbW57TGzLsBtgBHNbwOctn4HMiwNPDjvXi9A513aUkF//seTabDzw
	 K1o+S8NHFkOoxoPOYLWgKvbphdJQNj1jV76wvLKQuT9eWO7s8q/XMb89N26HgaGK/X
	 vuHvevGTK/hDQ==
Date: Fri, 12 Jun 2026 10:01:21 +0100
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: elfring@users.sourceforge.net, haokexin@gmail.com,
	vadim.fedorenko@linux.dev, devnexen@gmail.com,
	jacob.e.keller@intel.com, arnd@arndb.de, basharath@couthit.com,
	afd@ti.com, parvathi@couthit.com, vladimir.oltean@nxp.com,
	rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v7 0/2] Add Frame Preemption MAC Merge support
 for ICSSG
Message-ID: <20260612090121.GA625020@horms.kernel.org>
References: <20260610052511.781752-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610052511.781752-1-m-malladi@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298540-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,intel.com,arndb.de,couthit.com,ti.com,nxp.com,kernel.org,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C42F26780F4

On Wed, Jun 10, 2026 at 10:55:09AM +0530, Meghana Malladi wrote:
> This patch series adds QoS support to the ICSSG PRUETH driver.
> The first patch implements mqprio qdisc handling and TC offload hooks
> so userspace can request TC mappings and queue counts.
> 
> It also integrates a driver-side mechanism to program the firmware
> with the IET/FPE preemption mask and to kick the firmware verify state
> machine when frame preemption is enabled. The second patch adds ethtool
> perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
> .set_mm and .get_mm_stats so admins can view and change MAC Merge
> parameters and retrieve preemption statistics.
> 
> v6: https://lore.kernel.org/all/20260525182700.3135858-1-m-malladi@ti.com/
> 
> MD Danish Anwar (2):
>   net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
>   net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

Hi Meghana and MD,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch-set.

...

