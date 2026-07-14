Return-Path: <netdev+bounces-307532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8LHETNvVmrV5QAAu9opvQ
	(envelope-from <netdev+bounces-307532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:17:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE275747D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:17:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307532-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307532-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C3F30F595B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286D3064A9;
	Tue, 14 Jul 2026 17:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785AA2DB7B4;
	Tue, 14 Jul 2026 17:16:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049419; cv=none; b=g7eKUGl0Z1jLYQQjmomNfbDTa7IN3pUR9kGetCaoqumk0kMs7KFNBWxBQVx4Kx80a5GUVqZBHkuDKPdKaMrFbJ7S/QgY4xKH8gc1wAnea0Eo/ksQPUeY/aNqJtsqgLbRR7N0Efbtx4bWAkWvprPpVRrUIDHvdXgIoqfbyTjG35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049419; c=relaxed/simple;
	bh=nD1exLgIyt/KhruyXitdG6BV49FmMZzAASR26oxBMxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWNP4/ri5oMEZA+D6ZhxxCkIaEUSG/WBSgZk/MqK3xRo+MjHsmkduzHdiI43AMpeLLkHqv9Sarety3o14WVJazYqI0Uh7eJHQLSsO15VV2QLAO7PHaJBLw0qETWlLfQd5ToSnlvxEjiyyPup0JJChLgy6fAkCJR0uBnMrgqI3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjgkW-00000002EWD-0H9d;
	Tue, 14 Jul 2026 19:16:52 +0200
Date: Tue, 14 Jul 2026 19:16:52 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: document RFC6724 rule 5.5
 implementation
Message-ID: <alZvBEPH86WqH56m@eidolon.nox.tf>
References: <20260714094030.136317-1-equinox@diac24.net>
 <20260714094030.136317-10-equinox@diac24.net>
 <87zeztg1ye.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zeztg1ye.fsf@trenco.lwn.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[diac24.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307532-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,diac24.net:email,diac24.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89DE275747D

On Tue, Jul 14, 2026 at 07:01:13AM -0600, Jonathan Corbet wrote:
> David 'equinox' Lamparter <equinox@diac24.net> writes:
> >  create mode 100644 Documentation/networking/ipv6-addrsel.rst
>
> You need to add this new document to the index.rst file or it won't be
> part of the docs build...you should have seen a warning when you built
> the docs.

Indeed... I missed it between the other warnings.  Downside of doing
clean runs without a sphinx cache, sigh.

> > +====================================
> > +IPv6 source address selection trivia
> > +====================================
> > +
> > +
> > +RFC6724 rule 5.5 support
> > +------------------------
>
> Please stick with the section markup guidelines in
> Documentation/doc-guide/sphinx.rst.

Oh, you mean I shouldn't skip the "Chapter" level?

Now that you mention it, maybe I should include the file from ipv6.rst,
and remove the document title entirely - it looks quite weird in the TOC
with the direct reference from index.rst.  (Or rather, I've made weird
choices with the headings.)  Does that sound good to you?

(Or, I could just put the entire text into ipv6.rst...)

> > +RFC6724 rule 5.5 is a very short paragraph in a complex RFC that has turned
> > +out quite tricky, but also immensely useful in multihoming scenarios.  For
> > +reference, it says:
> > +
> > +::
> 
> You'll likely get more visually pleasing results if you just leave out
> the "::" here; you don't need literal formatting.

I did that because RFCs are historically shipped & cited monospaced, and
that's direct from the RFC.  My tendency is to keep it this way for
"established convention" reasons, but I don't care that much - does
anyone have stronger feelings?

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f3218abefd0c..4edf48362a07 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18912,6 +18912,7 @@ F:	Documentation/netlink/specs/rt-addr.yaml
> >  F:	Documentation/netlink/specs/rt-neigh.yaml
> >  F:	Documentation/netlink/specs/rt-route.yaml
> >  F:	Documentation/netlink/specs/rt-rule.yaml
> > +F:	Documentation/networking/ipv6-addrsel.rst
> 
> It seems weird to add this one file here - I wonder why there isn't just
> an entry for Documentation/networking ?

There is, the difference is "NETWORKING [GENERAL]" vs "NETWORKING
[IPv4/IPv6]".  I wasn't sure how much this matters & decided to err on
the side of caution (and also because checkpatch complained.)  I'll go
drop the line.

Thanks,


-equi

