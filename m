Return-Path: <netdev+bounces-257614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO/oNfQZhmlNJwQAu9opvQ
	(envelope-from <netdev+bounces-257614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:42:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7737A10076D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE69F304DE8D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973732861E;
	Fri,  6 Feb 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PhTESns2"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B730F950;
	Fri,  6 Feb 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395488; cv=none; b=Uj7XE4xnWft3b5oCpsJiyjTHF8fW9+1oUA3R8ILqTBfN9LDc3gRnVeG8zP2HyuxYqbXu6aLWZWE7kyFzTq/5vDCcARECwZ9H4Dx+34jWnb4/WYz5rdv7cH0BHsLVIJMdSasLOEdXrBFzxo8qxa9tIRvY7hfn9ftRL6Ro8HMg19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395488; c=relaxed/simple;
	bh=CA0zXufTVCu8yovgyhZqUdx10x8GwI/gpxsU3x47Wok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdiQVC8s8941AW2WibzUARLugb6lpV1pKwUAoV0OuXvATrEphplUM+9jC3KJuB6OJyJYMVG4C9a+nMLJNzDD5TlT5VVeede0JjWOotmv/1HBN+vfKEO+95Cvn3x33ClXhf0YQW9ta2auA0/EsHyU51dzsMSslmEK3rn9n1at+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PhTESns2; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4f6zvB1ZM9z46k0;
	Fri,  6 Feb 2026 17:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1770395078;
	bh=CA0zXufTVCu8yovgyhZqUdx10x8GwI/gpxsU3x47Wok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PhTESns2XqhoUnZ+MpXxGrdPz917NASiisM+uIIgqM8qT6RVPmoji5W0WrJX93n5N
	 VEOqczFbTqrmZphL/6WLrbHR0Y13o5xLpSjG9KGaWIdRI0zqjudyHekaKF7r3x4N7l
	 D0kDgjb7B8NDxuvO1Akwu2cbzpVYoA+DMY7LhxUWVJrbJk2IJ7L6sOMcT2IachGpEK
	 1KZQiIO0LP/j0ugHHdcAakAmnjsRF5notollQQhkvK27JIil/YbZF+YXRgp6tpqEnG
	 4iwkMkgWnel5A7svtlKq1K2efI0OQOpPlrZzEfJFlWn6APHBWgh6n9UXSIg/CjJQGP
	 rtn+IzeRYkdIg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4f6zvB0rPzz46hm;
	Fri,  6 Feb 2026 17:24:38 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4f6zv91G4Kz8sWT;
	Fri,  6 Feb 2026 17:24:36 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id EF9BF66F47;
	Fri,  6 Feb 2026 17:24:35 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b82d8cc1-2124-417d-95f8-5fed429e2d0e@leemhuis.info>
Date: Fri, 6 Feb 2026 17:24:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] NFC broken on Thinkpad T14 Gen since 9c328f5
To: "Lukas K." <kernel@0x83.eu>, linux-kernel@vger.kernel.org, krzk@kernel.org
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 Michael Thalmeier <michael.thalmeier@hale.at>
References: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177039507652.2809654.1894967214230795230@mxe9fb.netcup.net>
X-NC-CID: Bt98CjVrTXu9MdKvxaR1V7auDVmS08codIbbXfbktlRIwkJOQ3M=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257614-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:mid,leemhuis.info:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7737A10076D
X-Rspamd-Action: no action

On 2/6/26 16:15, Lukas K. wrote:
> 
> from 6.17.2 to 6.17.3, the integrated NFC reader (driver: nxp-nci_i2c)
> in the Thinkpad T14 Gen 4 (AMD) stopped detecting tags. This can be
> tested by running
> 
> sudo nfctool -1 -p -d nfc0
> 
> Looking at the commits between 6.17.2 and 6.17.3, 9c328f5 (net: nfc:
> nci: Add parameter validation for packet data) was the only one related
> to NFC.
> 
> To see if that commit indeed was the culprit, I reverted it on 6.18.7
> and nfctool is detecting tags again.
> 
> Since the offending commit merely adds some bounds checks, the root
> cause may very well be in another driver in the NFC stack.

Thx for the report. Seems Michael (now CCed) also ran into problems and
tried to fix them, but looks like that effort stalled; but might be good
to know if this fixes your problem, too:

https://lore.kernel.org/all/20260112124819.171028-1-michael.thalmeier@hale.at/

Anyway: Given that the regressions seems to be known for a weeks now
without a fix forthcoming I wonder if we should revert the culprit, as
we are way past what Linus wants to see in a situation like this (see
the "within a week" part in
https://lore.kernel.org/all/CAHk-=wi86AosXs66-yi54+mpQjPu0upxB8ZAfG+LsMyJmcuMSA@mail.gmail.com/
).

Ciao, Thorsten

