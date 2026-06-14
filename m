Return-Path: <netdev+bounces-299107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nvJpD5TxLWq6nAQAu9opvQ
	(envelope-from <netdev+bounces-299107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97860680188
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m/YSI3Mf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299107-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299107-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DC6830099BE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A782772E;
	Sun, 14 Jun 2026 00:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7A2135B8
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:10:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395856; cv=none; b=qOSOwQTsHwqmFQBx7uQJvcem513AXxg/mqvheGTkDbbglmkKZf4g8qqCXhXzdXWUjyAZKzLLBSQsDuLR8dFm7TSWcbKt8zrxERKqAgx0kqzOofiylEM49VHfk1juTgFHeGGD+a7hMiUc1A8zgTEatYeI/WpFm7qqXqoeHLvjz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395856; c=relaxed/simple;
	bh=z3JPufBLKyPEG56l3ed0X93NQz8KsewzFS36we9xZbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXduaZkcuWqpnX9PcEWuo5dwu+8FlJ2T2mqMmyEqK1vq+UHJc/c5jQfKx9Aoc+SMxj8UaJmNC10CJafM6+/6bBJxw/BlMz92Rv64UD54i+TQ+zRcCM01GNIcEqer+NACd1IveOhh/Sfi7vrUtm8PBwcJbjJYG/Tf+zpOnuA0J60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/YSI3Mf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B605E1F000E9;
	Sun, 14 Jun 2026 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395854;
	bh=iVGWX8CTJMTSnQUUg8I8G4xd1w723/IV0/c/rDWcb4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m/YSI3MfUtuAFpISmhJxLo65XTHfWMA5E7z6oSE56efHUWRSfn9ov74DUSKYyjgOU
	 ZiQ/tk0jehzIMqmVpUW8Gpmp6ZHw7ViIianP6mYMuyjUe/Z1W2OErnDbROA05FbeIV
	 liKOl53qLu5a+Uyx06ZfaEWcL8N/uPbXJVYEOhBNC75XtODrkgrzsrZo+m6wBe9B7F
	 cdzIbDI6ENoUGsSGqkoHRqr8N+0AKdRIk4Q8IjPl/N5H29xG1Rr5JDzEmPtuS4RJ3j
	 RGjnTlwQJd5ruGt6FY0vQLcw8M4s5OFrMMtn7pj2kfFw1KqOXSnemSUmDOazj9ZYgt
	 vyzS/Cm/R63bA==
Date: Sat, 13 Jun 2026 17:10:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260613171052.0dbdfea4@kernel.org>
In-Reply-To: <CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
References: <20260607031640.2743713-1-xmei5@asu.edu>
	<20260609183018.1764046d@kernel.org>
	<ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
	<20260613164820.491226a7@kernel.org>
	<CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97860680188

On Sat, 13 Jun 2026 17:02:39 -0700 Xiang Mei wrote:
> > >       if (data_len) {
> > > -             int nla_len = nla_total_size(data_len);
> > >               struct nlattr *nla;
> > >
> > > -             nla = skb_put(nl_skb, nla_len);
> > > -             nla->nla_type = PSAMPLE_ATTR_DATA;
> > > -             nla->nla_len = nla_attr_size(data_len);
> > > +             nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
> > > +             if (!nla)
> > > +                     goto error;
> > >
> > >               if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
> > >                       goto error;
> > >
> > > Let me know if the new patch makes sense.  
> >
> > I assumed the author intentionally was avoiding the memset for
> > the memory we will override with data. Otherwise the whole dance
> > could be avoided and nla_put() would have been the answer.  
> 
> The reason nla_put() isn't used here is that the payload source is the
> sampled skb, which can be nonlinear, so the data has to be gathered with
> skb_copy_bits() rather than a flat memcpy().

That too.

> There is no nla_put() variant that takes an skb source, hence the
> reserve-then-copy.
> 
> But that doesn't require open-coding the attribute: nla_reserve() only
> memsets the alignment padding (nla_padlen), never the data region, so
> nla_reserve() + skb_copy_bits() writes every byte exactly once with no
> redundant memset over the payload. The bug was that the open-coded
> version dropped that padding-zero step.

I find it hard to believe that nla_reserve() was not considered.
It's a widely used function in the networking stack.
Please move on.

