Return-Path: <netdev+bounces-306317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6AtpLWPPT2qbogIAu9opvQ
	(envelope-from <netdev+bounces-306317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FB07338ED
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=ZNznLYKV;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306317-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306317-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D1830A5DDC
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51ED399889;
	Thu,  9 Jul 2026 16:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771D39903E;
	Thu,  9 Jul 2026 16:38:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615130; cv=none; b=Uav6SG7eYXQmNvNoP4blJezY5Rmi1xUTv/2aYIksCYdMxPObEIOhvTF8rN7QjpwoqpQO7LyMG0l2l67KRagPotfC/RPZYqOmggKFs07tjekW5P5l7XCGZnTyY97bv9VLKDsCpExZPGdUhdqW6Yh0uYEWU47ERbSAAsz8UhH5Jic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615130; c=relaxed/simple;
	bh=0a73eJQMiohbn6QT4pvZwY77RLnsVkKRtt4dG7DpzC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra/o9kwLEzcW+iY1Tb+gAMCJXMn3VplWOZseYIz+g5MGlkhcX1jCmGwuIxF4HXKSapztpbfYx3ma5RXPpcd0TpzrvQKcxhZGlih/l0cfmyBD4Gfv+yAm5e266pNjQWyX4aHzlMyySqKqLe48vG/tPqhbbgQ0aY6e5z6aDpdL8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZNznLYKV; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NuQTGH3+APiOn/6liz7yOWPh/Eu7AGICy8vOLDYKfsI=; b=ZNznLYKV/j20eFdnO8IiAVE8G1
	YPmtO0+dN4iDKaVbC5V6bLMklXz0YTe5GzVUdvkF5uclXsGSma5UI5R23bzn0ROfzgFMafHqTXhV1
	exHnzK+VXBqI/8NCQ8r9lVZO5rFIGv1cDZmrdxXq4BC1UiFA/wGKKv71uGYKbCA9orWAfwXSh63mX
	BzWNrAC6+r4qBWEags3k6/7Wa3FFgkwssLu7a+WKEIhnxwDS0AnQIkCLuPxlYek5yW2dMOq+4YlwK
	xfv+PAMf7HOlNPzTnvVGs21NgLxF13T+AQ7lyC2bVw1TL7kqd5YXB6yqALd77TTzIqon6ykNVwl0F
	pfUkTubA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whrli-003qTX-0B;
	Thu, 09 Jul 2026 16:38:34 +0000
Date: Thu, 9 Jul 2026 09:38:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	asantostc@gmail.com, gustavold@gmail.com, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <ak_OepTvPdSlUafF@gmail.com>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com>
 <20260709101945.GN1364329@horms.kernel.org>
 <64257110-d9fe-42df-9990-2ec1421a7c29@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64257110-d9fe-42df-9990-2ec1421a7c29@redhat.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306317-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:horms@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6FB07338ED

On Thu, Jul 09, 2026 at 12:27:35PM +0200, Paolo Abeni wrote:
> On 7/9/26 12:19 PM, Simon Horman wrote:
> > On Mon, Jul 06, 2026 at 04:55:35AM -0700, Breno Leitao wrote:
> >> On Thu, Jul 02, 2026 at 05:19:44AM -0700, Breno Leitao wrote:
> >>> This work continue to untangle netconsole and netpoll, improving
> >>> memory usage for netpoll users that are not netconsole.
> >>
> >> Quick follow up on the sashiko findings. most of them are assuming that
> >> netconsole_write is called locklelly, which is not the case, except
> >> on panic (CON_NBCON_ATOMIC_UNSAFE). 
> >>
> >>
> >> There are in order as they appear in
> >> https://sashiko.dev/#/patchset/20260702-netconsole_move_more-v2-0-1ebedd921dcb%40debian.org
> >>
> >> Tl;DR: There are two pre-existing issue that I will get fixed, but
> >> I don't think they are blockers for this series (IMO).
> > 
> > Thanks, I agree.
> > 
> > For the series:
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > I did notice that patch 2/8 now applies with some fuzz, which trips up git am.
> > You may want to consider a rebase.
> 
> Yep, a rebase is needed, thanks!

Ack, I will do!

Thanks


