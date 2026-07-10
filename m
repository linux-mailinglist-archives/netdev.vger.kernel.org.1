Return-Path: <netdev+bounces-306519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n/KcNiLRUGoS5gIAu9opvQ
	(envelope-from <netdev+bounces-306519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:01:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C750739F2F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:01:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=bAAQTWSy;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306519-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306519-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD65C300D74A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCB40E8D0;
	Fri, 10 Jul 2026 11:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECE40BCB0;
	Fri, 10 Jul 2026 11:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681310; cv=none; b=ostSl8hF1c6RVPpFaHj/sbRY5NDHhWYvPK6HmQLG58z93p1XRMOhyqNIMGOYgPEkkXBWFNnNPNgVfo6+M7Nx1MwJzzANGV7ey/zmB9IDsHuA6yDUtaEA0+DAI5a64iTQLJYf8+P7VyGxok1Vo7xzQiRINAjGxCtdu3T/7barCw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681310; c=relaxed/simple;
	bh=71sj0/+6+Poal/Hsw9DD/HIOLf2nt9C41FsAr+UfcOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjiGJKRDIvnNhENMxqqvM0oeL7Lg81PdnJPP7kJE7P21QfNQVjRMP98dR4G1h4JkhnY2lUR3Z7WDKM2viYOR5NWiO4ZvX5mH3KpUiw7knN/Qcm94iM7Dr5aEXtIlUd47F3/va0TrHkEI4uczDEZoMgt4GKsAeqV1tr4JVX7bA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bAAQTWSy; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RvkH/lWQQy/GTDSrZS8UytO7pjbm+735COICxyv0X08=; b=bAAQTWSyKQzQ8LWsqqbONDNDc+
	jLVOOhaGHRZlYboQbs5J1RR8VfMOWAZfWM3D8FqD79mf+KcM2HCCG0l5b9zijWnuKbAcQTYe16q5P
	OAyLecFJvI/NJi8mkEl7mHE3AvgU/JSRFkwTVE4fooay8yYuwTss8fgeJN+1KXdKvGiBLfzNxek/g
	kQhzvtOPxtbaoFRj0peX6pTu1+i65+j6BW0g3UzMDrsU1BRqNRzhDDPyXcPlj1VGfTXeGR3HtUkEG
	XF29qtyIozFpwBp91oisikqUPQWpe9f1dklRUcIprfm5lWbU57GmPO5+MuJOBGO36p7CK5ZTzgZuJ
	trkMb8FA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi8zD-004QqI-2y;
	Fri, 10 Jul 2026 11:01:40 +0000
Date: Fri, 10 Jul 2026 04:01:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	asantostc@gmail.com, gustavold@gmail.com, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <alDMvD5S7TZnoD_V@gmail.com>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com>
 <1bfad1f6-6947-47a4-9dc0-72b4c16fc395@redhat.com>
 <alC5pjeFfFnBuipL@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alC5pjeFfFnBuipL@gmail.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306519-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C750739F2F

On Fri, Jul 10, 2026 at 02:46:17AM -0700, Breno Leitao wrote:
> On Thu, Jul 09, 2026 at 12:20:24PM +0200, Paolo Abeni wrote:
> > Because this initialization happens before acquiring rtnl_lock inside
> > netpoll_setup(), enabled_store() can execute INIT_WORK() and
> > skb_queue_head_init() simultaneously with the cleanup thread executing
> > cancel_work_sync() and skb_queue_purge_reason() on the exact same
> > fields.
> 
> I don't think this is a big issue, given worst case scenario, the pool
> will not be populated, but this seems a clear regression.

Actually, this is a significant issue. We're calling
skb_queue_head_init() and INIT_WORK() while those same pointers are
being accessed concurrently.

The best approach IMO is to move the initialization early (calling
INIT_WORK()/skb_queue_head_init() before the race window), making the
critical section safe.

I'll send an updated series that also addresses another pre-existing bug,
bringing the total sashiko issue count to something we can enumerate on
our fingers.

