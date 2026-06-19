Return-Path: <netdev+bounces-300732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMouJOhvNWpjwQYAu9opvQ
	(envelope-from <netdev+bounces-300732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC36A712B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=BSCYrreJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300732-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C230C30A6F50
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966183BED01;
	Fri, 19 Jun 2026 16:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876A396579;
	Fri, 19 Jun 2026 16:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886867; cv=none; b=TAi1HBKnaVzbY8DNCGA3XEpHAtLih9yybVICs0ierRQzPkxGCGBBTcCsxlHomSA+YPINaUO8beaDziQb6qydhGHtoYpRzwkrcxvsTG6o97M6P9IS+4qBGTWwiMpT4+YL+SJppMdl941KqEUskMmN4qByq9xDT3rggu0nAN04QvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886867; c=relaxed/simple;
	bh=umIpAGwG08ccehpImsnotu3Acx+eUIrj9V5Rh7uit+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnlv5+8uC5gezHNT0utqxjWDNsc5jJZycTrKq0z7WoFInvFz7RKiat4ku2rb7m+T6W1Ikm+IrUuWFHWI+VEMzXio0DMKNo1i+H5fAk5lsSZPlHFzPY6Dx0xh7pgD81q8sv/rkXQWtTS8zQScVhm2fY9peE6d5E2//HraiATlj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BSCYrreJ; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=JtrPcPWLxvfUB56XuxdAYk3VgQ7KQnW4bFFt7AsAsb8=; b=BSCYrreJf9QDrwXWaqltFWeG+r
	+yLW9bJJHQQM9/N8j57Xgp5JnyQ5l0oSWIa9DTU7DcMHy3GuwViPQlMSOMOJy1kBzglOcGWONZjN+
	h2+Aa3CZ8axXEa0VV2/pzhMV/mQZhLCJEu+dppjUre+hn32dKGRil1WSGMxIQWMxNSO+HCS2Im6Kk
	Px7FO9nu7UmuIdd1Xz4p9r70JDkFgvTksXZIZMXevfIpz7pgURyPoeS28H6cxvnqKkDCQ6GQf9CTn
	e4yc96M04G48Ui4cv4ZZMsvkzRkX4a6wVidCA7zQAo9+lKP/UzMP4t4yM+oPaEz3/kWe57ABLdvMc
	17RvNLIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wacAf-0000000EAFP-0WE5;
	Fri, 19 Jun 2026 16:34:21 +0000
Date: Fri, 19 Jun 2026 17:34:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex Goltsev <sasha.goltsev777@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add sock_open() for unified socket creation
Message-ID: <20260619163421.GD2636677@ZenIV>
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
 <20260618211231.GB2636677@ZenIV>
 <CAEKmD4JfM5GWSiRMUn6NK+kKFeyXA8i3A9gthDz3hVKFcR1YDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEKmD4JfM5GWSiRMUn6NK+kKFeyXA8i3A9gthDz3hVKFcR1YDA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sasha.goltsev777@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sashagoltsev777@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300732-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ZenIV:mid,linux.org.uk:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBC36A712B

On Fri, Jun 19, 2026 at 01:35:56PM +0300, Alex Goltsev wrote:
> > What's the point (and why not make it inline, while we are at it)?
> 
> > Are there really callers that would pass a non-constant value as the last argument,
> > and if so, what are they doing next?
> 
> 
> As for `inline`: in this case, it would have no practical significance.
> 
> The compiler already treats a simple inline function as a regular
> 
> symbol within the `EXPORT_SYMBOL` context, whereas a static inline
> function (the standard
> 
> kernel template for helper functions) would completely break the
> export to the LKM.

How so?  All three underlying primitives are exported, so static inline
in whatever include/*/*.h you put it in would work just fine.

> As for the last argument, yes, today it is usually a constant,
> 
> but that’s not the point. The purpose of the enumeration is to provide
> 
> a unified, explicit control interface. It’s important that if, in the future,
> 
> someone adds a new type of socket creation, existing calling programs won’t
> 
> panic or throw a compilation error, but will smoothly fall back to
> 
> the default case and return -EINVAL, which is a safe failure mode.

Collapsing several functions together is worthless unless the combination
can be _used_ other than a (questionable) syntax sugar.  kmalloc() can;
something that would only result in trading multiple identifiers for
functions for multiple identifiers for "which function to call" is not
an improvement.

