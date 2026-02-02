Return-Path: <netdev+bounces-255852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOJyN9WVgGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:17:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08ABCC44B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 113E430056EB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3835DD09;
	Mon,  2 Feb 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="NvYeWq9E"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EBD23EA8B;
	Mon,  2 Feb 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034626; cv=none; b=aAfh1LAb1t5NXU52LrHtK/+MswHJVBVYkMI2mtrUeyLAGP9PaJPtRx3R1Ij/YmEl6tsuRsNX6bv2m9PCpy5LTAEQBNpXImYZKfucn47+vYIf0vwURzCdwkqzfA0weJK8bXc7tkuPgykKvwptXdw/clbFH3/Ygq6MjMdodCQ/K3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034626; c=relaxed/simple;
	bh=KiiVfW7gDbgRUN6d93pvTDSOaEYSsBVczE80UlUTzqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe1VFOGwMXRX7GZ5gGzFZur2d8duDZp5UtS2G6Mmz75aVvMzY6Cz9uFLFUU6a8vQyqkxML2q+eFNqeXwej4ZpnceqoWQlbqBnEBQBCxTeveR+7Ah+b+qW5vurCfMn7id5SrVDoIXDbdNuwsO/nQjLpLoqkr+rzdxci8J3Q/hqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=NvYeWq9E; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1770034052; x=1770898053; bh=KiiV
	fW7gDbgRUN6d93pvTDSOaEYSsBVczE80UlUTzqg=; b=NvYeWq9EfSE4NTafBqH6
	kCbrtHFCOUVeSASFt94qdiY9DwtTmO3YSogqZuVyjeu73XUU8tBEHW3yI+e1+Lv8
	pd773AM38wdjZJMKuTUupC3cEnwPf9xdbbzQgkFGw6ENMiu7pQSZTfy8VlrbKzm8
	EwHepLCF28HS4j2bmDTXzPB6h/ZYGcX5YqVmt1/b3TwnCfQwdDrSI9uMpb9CnKiE
	qLpr3gfeYeTRSGMqXIJOg03DLcMird4LWGCY30xcJT7uK/x4GzB600wSR1LOxLqm
	l612THu3LRV9tX5PQxz3F4cDXxifCcLD3BkR9vrMgFrNAGsyORL5K/H6GYoPcnay
	rQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 02 Feb 2026 13:07:29 +0100 (CET)
Date: Mon, 2 Feb 2026 13:07:27 +0100
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org,
	Tobias Brunner <tobias@strongswan.org>,
	Simon Horman <horms@kernel.org>, stable+noautosel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH net-next v4 1/2] icmp: fix ICMP error
 source address when xfrm policy matches
Message-ID: <aYCTfwblH8wtnF6c@Antony2201.local>
References: <cover.1769595011.git.antony.antony@secunet.com>
 <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
 <20260129184510.01319683@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129184510.01319683@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255852-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phenome.org:dkim,Antony2201.local:mid]
X-Rspamd-Queue-Id: A08ABCC44B
X-Rspamd-Action: no action

Hi Jakub,

On Thu, Jan 29, 2026 at 06:45:10PM -0800, Jakub Kicinski via Devel wrote:
> On Wed, 28 Jan 2026 11:25:14 +0100 Antony Antony wrote:
> > Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches
> 
> > Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> > Cc: stable+noautosel@kernel.org # Avoid false positives in tests
> 
> I don't understand what you're trying to express with all these tags.
> We are sending incorrect ICMP packets, seems like a normal net-worthy
> fix to me?

You're right that we're sending incorrect ICMP packets when IPsec/xfrm is 
enabled and this is a legitimate fix. My concern with backporting is about 
potential disruption rather than the correctness of the fix itself.
The issue is that some existing test scripts and monitoring tools may have
hardcoded expectations for the current(incorrect) source address behavior.  
When this one-line fix gets backported to all maintained kernels, those 
tests would start failing, potentially triggering regression reports and 
requests to revert the fix from stable kernels.

Additionally, without the
commit 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages") 
being present in older kernels, the behavior change could be viewed 
differently in stable branches.

This is also the sense I got from IPsec users.
Given these considerations, I opted for the safer path of targeting net-next
with stable+noautosel, no backporting.

-antony

