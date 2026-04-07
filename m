Return-Path: <netdev+bounces-275968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOvUGPHu1GkZzAcAu9opvQ
	(envelope-from <netdev+bounces-275968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CD3ADEAF
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 329C53026584
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B463ACF1C;
	Tue,  7 Apr 2026 11:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.servers.dxld.at (mail.servers.dxld.at [168.119.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043B372B3B;
	Tue,  7 Apr 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562478; cv=none; b=GLWAywJ6aKBVBZxyUNJBsJnkdmGfAZdnehoNCY3pV81GLBXRuKs2IeNMDw6kw5Msdcat/4X9gvhmFNTih0evrHsm4QqUhyZ/35GQ1sXkbFk76rMEgKw/pnCIgsWKlbeNdfMZ1NytYjhIOWKPmAOcEuu02wh0PWSh38yXt+Bn0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562478; c=relaxed/simple;
	bh=JYzF85C0V7dRRpq9u6kadu53IyVu+6XVVnHFbfBnr9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAXdtX9ct6pU7u/5eCmb4LzeLif1wH5rDPpcHed8IPNbMYK1VHoGnQLQqqPKYAQx3PFhfc5ESeVRmN12I1Ws6RE9mAy0wbdYeboktb+tHK6Ir8E7FZfMv6Pvd6d1qr77rNBDkgqHQv2wSTV0T2ttamjHIJn40iyfqMube6c3OdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org; spf=pass smtp.mailfrom=darkboxed.org; arc=none smtp.client-ip=168.119.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkboxed.org
Received: mail.servers.dxld.at;
	Tue, 07 Apr 2026 13:30:53 +0200
Date: Tue, 7 Apr 2026 13:30:44 +0200
From: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To: Xavier Hsinyuan <xavierhsinyuan@outlook.com>
Cc: ralf@mandelbit.com, antonio@mandelbit.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [RFC net-next 15/15] Documentation: networking: add ipxlat
 translator guide
Message-ID: <fldksy7obiaonlcxrjcbnfkfmaup27t3fq3ktubd7sx35fsswx@hjmchh6sr7rw>
References: <20260319151230.655687-16-ralf@mandelbit.com>
 <TYRPR01MB12666EEA0B8007166ED446088CA5DA@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYRPR01MB12666EEA0B8007166ED446088CA5DA@TYRPR01MB12666.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[darkboxed.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275968-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dxld@darkboxed.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url]
X-Rspamd-Queue-Id: 8F7CD3ADEAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:50:44PM +0800, Xavier Hsinyuan wrote:
> >+    $ ./tools/net/ynl/pyynl/cli.py --family ipxlat --json '{"ifindex": $IID, \
> >+        "config": {"xlat-prefix6": "'$HEX_ADDR'", "prefix-len": 96} }'
> Should this be like:
> $ python3 /extends/pyynl/cli.py --spec ipxlat.yaml --do dev-set --json \
> '{"ifindex": "'$IID'", "config": {"xlat-prefix6": \
> {"prefix":"'$ADDR_HEX'", "prefix-len": 96}}}'

Indeed, the JSON is just wrong and --do dev-set is missing. However
`--family ipxlat` works for me and looking at the code is basically the
same as specifying --spec.

Could you try this:

    $ JSON='{"ifindex": '"$IID"', "config": {"xlat-prefix6": { "prefix": "'$ADDR_HEX'", "prefix-len": 96}}}'
    $ ./tools/net/ynl/pyynl/cli.py --family ipxlat --do dev-set --json "$JSON"

> >+Address Translation
> >+-------------------
> >+
> >+The ipxlat address translation algorithm is stateless, per RFC-ADDR_, all
> >+possible IPv4 addressess are mapped one-to-one into the translation prefix,
> >+optionally including a non-standard "suffix". See `RFC-ADDR Section 2.2
> >+<https://datatracker.ietf.org/doc/html/rfc6052#section-2.2>`_.
> >+
> >+.. _RFC-ADDR: https://datatracker.ietf.org/doc/html/rfc6052
> >+
> >+IPv6 addressess outside this prefix are rejected with ICMPv6 errors with
> >+the notable exception of ICMPv6 errors originating from untranslatable
> >+source addressess. These are translated to be sourced from the IPv4 Dummy
> >+Address ``192.0.0.8`` (per I-D-dummy_) instead to maintain IPv4 traceroute
> >+visibility.
>
> Would it help to add a few example? For instance,
>  - Interface ipxlat0 with prefix6=64:ff9b::/96.
>  - A IPv6 packet with src=64:ff9b::192.0.2.1 dst=64:ff9b::198.51.100.1,
>    was send to ipxlat0.
>  - Then a IPv4 packet with src=192.0.2.1 dst=198.51.100.1 was received from
>    ipxlat0.

I worry once we start with that we're really just re-stating what's already
extensively documented in the RFCs.

How about a reference to RFC 7915 Appendix A? This has a full bidirectional
end-to-end example of how translation operates:
https://datatracker.ietf.org/doc/html/rfc7915#appendix-A

Admittedly using a /96 prefix (which the appendix doesn't) would make it
easier to grok whats going on. Not sure that's reason enough to get into
more detailed examples here.

WDYT?

Thanks,
--Daniel

