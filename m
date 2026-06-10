Return-Path: <netdev+bounces-297412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dsFJMD3OKGqxJwMAu9opvQ
	(envelope-from <netdev+bounces-297412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81566578A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:38:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=ejIouRFC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297412-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297412-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31AD3301025D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708FB261B9E;
	Wed, 10 Jun 2026 02:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445212165EA;
	Wed, 10 Jun 2026 02:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059129; cv=none; b=qzO3rdlBdgl+4PxkgIle/HEbShUE2k+ulcuAJ84w6SrUvQzSyMX9fWY0Bw8r+Ybj+y9PXM8gSRMv9udkFgGONP1JnnIjC4rVJ7xZvdoys4fTkAlR2KJj6P+yJ0R6GqbGgQQNxR17YzOtX0ccASq8VxhTglxu6r6z+aLj9ek9tV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059129; c=relaxed/simple;
	bh=DjLshAltart9t2Y8L80+63ENGySICbXbBUCkfmhve8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxHl05zsCici1gl2GzfeKe+IhyDOdb9E+Fx8YssdRqbdizGIALrmYUJ7vJyCRy4WuyiOf1ffQOklIBnZPfG3b/nYzwsAkL25PNnC9vI7vGmrD3chwfuErb571vzwb1LfCOb/WHrsJAWyQqONBChUhCxzMJRtLqwCcHeAuusjPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ejIouRFC; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=F4PfoyOSBZB+B0oBmVrxEsJLeUyLRt7oiVKVVfBrTFU=; 
	b=ejIouRFCgL7Pds8B1YDOO/rMwKfebD3iQvcM6K5PpBdqW/z0u0jBSvoAFkCPmPn9n6x7yijEjYs
	ziFpZlhxhlEalPp1bMVtmtIkl+BICLcsUU4l4mxBUFUMUvJTLtvL3tzvoI9vQKPIGQNJuc8ZCm0g0
	bG4KMs5q1/tMEg50HKqbbRKqjMT4ES7atVRzfOTmuJn+DgGCuvtkWuuCBJXbdE5l8JlD9liUu0EP7
	PZW/meLn7TBvsBSoo5j9rUekxWmtiufQ4BB10Hgf3eGYad7/pafzNqoTwnnXuVXFWJonLL5BqUy3p
	+/lxisVf0Zp9X6tzs3h4v3y1x90/wZYOZQWQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wX8pn-000000049DN-3OyY;
	Wed, 10 Jun 2026 10:38:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2026 10:38:27 +0800
Date: Wed, 10 Jun 2026 10:38:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.c.dionne@gmail.com>, netdev@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into
 net/rxrpc/
Message-ID: <aijOI93Fg8wJICgP@gondor.apana.org.au>
References: <20260608173921.GA434331@google.com>
 <20260522050740.84561-1-ebiggers@kernel.org>
 <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com>
 <20260603050557.GB18149@sol>
 <764077.1780985938@warthog.procyon.org.uk>
 <a4091402-e7c0-415e-a2a4-67d2b509462f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4091402-e7c0-415e-a2a4-67d2b509462f@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297412-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:dhowells@redhat.com,m:marc.c.dionne@gmail.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:ebiggers@kernel.org,m:marccdionne@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.infradead.org,davemloft.net,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D81566578A

On Tue, Jun 09, 2026 at 06:11:31PM +0200, Paolo Abeni wrote:
> Hi,
> 
> On 6/9/26 8:18 AM, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> >>> If there's no more feedback, could this be applied to net-next?
> >>
> >> Any update on this?
> > 
> > It's fine by me, but I'm not sure what I need to do with it - shouldn't it
> > already be in the netdev queue, or do I need to post it?
> 
> This slipped under my radar, sorry. I just revived it in PW. Also, I
> think we need an explicit ack from Herbert.
> 
> Link to ML post:
> 
> https://lore.kernel.org/all/20260522050740.84561-1-ebiggers@kernel.org/

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

