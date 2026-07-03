Return-Path: <netdev+bounces-304633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xWZrFPrwR2qhhwAAu9opvQ
	(envelope-from <netdev+bounces-304633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC42704A55
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phenome.org header.s=oak1 header.b=H5ik6g7d;
	dmarc=pass (policy=none) header.from=phenome.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304633-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48CEB300D4D0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DFD2F7F16;
	Fri,  3 Jul 2026 17:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660212F7EEF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 17:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099638; cv=none; b=DvNA6vxZs41eMNz71Kh3PKKD6PF/jmSlF7GK2tlKbOs25PJmD52ClcrYbFFfHiL8AnO4Y4MZYHN3mQk994GQBqltZ7tkkbwmC/bkRC22ifkxpeJUi04g/t102PFmgIFPb3UYnfN/H78qIS2q+NGi6oT/iUw+eIEtQdekxWroupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099638; c=relaxed/simple;
	bh=5UFznE4iYiNEzfMpidbDCXoe8Z+zxMSziclq+prtSas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnaurdh/LNAYXMPgW0DCGnoXq9xtSsPkHQV6oM5Wmzx/CwmDf8zIMycZ4vzpxJ2n7lj/L+3IkkMRhqNFICjGyuAIVK2E3J5zGW/B+M+6/UV1ZDuF8ZxkIXMQ7dCLCuh8y+WZZBFjHbyZ1AXi0097xztE8wUus0gjN4RKAYqSDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=H5ik6g7d; arc=none smtp.client-ip=193.110.157.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1783099260; x=1783963261; bh=5UFznE4iYiNEzfMpidbDCXoe8Z+zxMSzicl
	q+prtSas=; b=H5ik6g7dacRyC71/jNg4+TwHcab1UVe9vyeYr9JtP7xtXvls6/q
	Nl8ZMkhdpmauga84WY5dxVxkvhp3XfwW4U/Ldb3NIKzkbhaUe9AqZjv6bwQ2SUmQ
	d8TIWYDiK0/gaadVLeOf3KPbPpXhvQ2k7+f8PI395XMtrQDkl44zg7WpbDRYV4F4
	+hEuISHh3NiRiayw3PzL+gC5zoikgjGygalB+p8qw6A1nj8/YuG0z3QnWgxLIaZY
	gUPPXLzuO9LToCKWRROV5LdEobMr4NtwSZrumqPgse1nxsjGwvUr5rUpSCSgRSmg
	BvuJleZpJxJB68BckM745VvxqIgmx2y1djw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Fri, 03 Jul 2026 19:20:58 +0200 (CEST)
Date: Fri, 3 Jul 2026 19:20:56 +0200
From: Antony Antony <antony@phenome.org>
To: Yan Yan <evitayan@google.com>
Cc: Antony Antony <antony@phenome.org>, Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nathan Harold <nharold@google.com>,
	Antony Antony <antony.antony@secunet.com>,
	David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	Tobias Brunner <tobias@strongswan.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <akfveJrtxW9yMLXK@Antony2201.local>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org>
 <ajDlFUhMfJP36qA8@Antony2201.local>
 <ajvzbVLCce1p86i6@Antony2201.local>
 <CADHa2dAtGVsph3Kq0id7QqgNdJww0Q=Z1PK+=fomVxKE-Mmvjg@mail.gmail.com>
 <CADHa2dB9e=O_thTEPo3Bwtj9qRxE0UJd_MBriC8qqrPFB+x9rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dB9e=O_thTEPo3Bwtj9qRxE0UJd_MBriC8qqrPFB+x9rw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:evitayan@google.com,m:antony@phenome.org,m:kuba@kernel.org,m:steffen.klassert@secunet.com,m:nharold@google.com,m:antony.antony@secunet.com,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:tobias@strongswan.org,m:sd@queasysnail.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[phenome.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,phenome.org:from_mime,phenome.org:dkim,Antony2201.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAC42704A55

Hi Yan,

thanks for testing. Would you please test on a new series?

On Thu, Jun 25, 2026 at 06:58:47PM -0700, Yan Yan wrote:
> Hi Antony,
> 
> I ran the following test cases and two—4.2 and 6—are worth disucssing:
> 
> 1.  Mark Inheritance: Creates one SA and migrates it without
> specifying a new mark. [PASSED]
> 2.  Mark Update: Creates one SA with a specific mark and migrates it
> to a new specific mark. [PASSED]
> 3.  State Update Isolation: Creates two SAs differing only by mark and
> verifies that migrating one does not affect the other. [PASSED]
> 4.  Mark Collision:
>     4.1 [Specific Mark] Creates two SAs differing only by mark: SA
> (mark_1) and an SA (mark_2). Verifies migrating SA (mark_1) to mark_2
> fails with EEXIST and both SAs intact. [PASSED]
>     4.2 [Wildcard Mark] Creates two SAs differing only by mark: SA
> (mark_1) and an SA (mark_none). Migrate the mark_none to mark_1.
> Expecting failure with EEXIST and both SAs intact. [FAILED: SA
> (mark_none) ends up being deleted]
> 5.  Mark Mismatch:
>     5.1 Creates only a wildcard SA and verifying migration using a
> specific mark fails with ESRCH; SA intact [PASSED]
>     5.2 Creates only one SA (mark_1) and verifying migration using a
> mark_2 fails with ESRCH; SA intact [PASSED]
> 6.  Mark Shadowing Failure:: Creates two SAs differing only by mark:
> the first SA (mark_1) and the second SA (mark None). Migrating the SA
> (mark_1) fails with ESRCH, two SAs remain untouched [PASSED]
> 
> --------------------------------
> My questions are as follows:
> 
> Regarding 4.2 I believe is a kernel bug. During the pre-migration
> collision check, the lookup for the mark_1 matches the wildcard SA
> itself first, causing the kernel to miss the collision with the
> existing specific SA with mark_1
> 
> At https://github.com/antonyantony/linux/blob/migrate-state-fixes-v0/net/xfrm/xfrm_user.c#L3450
> 
> x_new = xfrm_state_lookup(net, new_mark_key, &m.new_daddr, ----> BUG:
> We are looking for the existence of SA (mark_1) but SA (mark_none) is
> returned.
> um->id.spi, um->id.proto, m.new_family);
> if (x_new) {
>     xfrm_state_put(x_new);
>     if (x_new != x) { ----> BUG: We end up having x_new == x
>     NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
>     err = -EEXIST;
>     goto out;
> }
this should be fixed no. Would please try again?


> /* self-match via wide mark mask; not a collision */
> 
> Would it be possible to traverse the entire list or create a lookup
> method for an exact match?
> 
> Regarding  6.  I wrote the tests as per the kernel implementation but
> I'm not sure it is intended. Intuitively, this migration should
> succeed by finding and updating the specific SA (mark_1) instead of
> failing. Is this failure considered an acceptable limit, or should we
> aim to support exact-match lookup here?


While trying to fix MIGRATE_STATE I fell into a rabbit hole:)
I realized many methods have this issue. Just never noticed, as it would be
a misconfiguration, and would likely cause operational issues rather than 
crashes.
However, given that xfrm accepts multiple identical SAs differing only in mark,
a proper fix is to add __xfrm_state_locate_exact() for both spi and byaddr 
lookups.  This should be used in all calls from userspace.

I just send a new series.
https://patchwork.kernel.org/project/netdevbpf/patch/migrate-state-fixes-v0-1-a69e8637ba3b@secunet.com/

-antony

