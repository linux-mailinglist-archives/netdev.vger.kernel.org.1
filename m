Return-Path: <netdev+bounces-299746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W2KoIg7nMGoqYgUAu9opvQ
	(envelope-from <netdev+bounces-299746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:02:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7908E68C54A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:02:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phenome.org header.s=oak1 header.b=ouNpQP8W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299746-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=phenome.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A08E53009E07
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33963DA5D5;
	Tue, 16 Jun 2026 06:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC63DA5D9
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:02:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589767; cv=none; b=OrNV/VIIcHvZeeiYzYFA+tHawoVQJmrPCF+4L0FpHM09nH/Xw7MlbFlSDeop8Gm4ZKzaVCQlB4Sd6jfu++GGRxqv1FYXxVle0nD4KSvDG9J2QBEcl/l+xKIKbnqcgPZeb96jjOYRdUh5wQJA7tkcvBzApJTWf5SHmk5sF/cS6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589767; c=relaxed/simple;
	bh=B/Fo63KqjMlZIKLkWIeSni1oYyYInJEcJ0WTJoaHWs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVKmOhNdD+vu0TvE6AonumdVAwX9JzqR9qhkkBbE1kPt1XY91DsDjtRsl+YAexcqlNz7S8ofpMlDTSEaEmErchz0DmUPiHZiAL+Ejup25G83Z4ZOhMKfub64wnSyz2y3SeG6uObPMG2N8U37l/y0jGRgXTOtSHAADV7DJsRb6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=ouNpQP8W; arc=none smtp.client-ip=193.110.157.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1781589273; x=1782453274; bh=B/Fo
	63KqjMlZIKLkWIeSni1oYyYInJEcJ0WTJoaHWs4=; b=ouNpQP8WFmG8oa44RlMy
	+tnuysg+KCF/3WLOX6SfUCymb8Fck9QJdB+MQXzlCQN3pMbR/V2XXVfKLosqISYW
	e8vuWzZFkQAs65wSwKepnW/8+GFiLWZSoXObRHukD+wpIUeWY9DPjAcpBnA4Wp5K
	EXa4O+hNG9mL6JwnlhHZEZ25P8oXiJdpPyoS5azZjOSgu2cytVQ8fHk+7i9LjCYR
	hkYExBz2Ksusti6rkv1mNlC9Z9iN6JQEKGqfxo3mhmPz5Dg9hF7hBNavq+Ki2HNn
	Cv71JPKz92eBQV5Dk3vQ+RUhap9WhFs0INjL227vuUUVu5wjlF31/n8pklMet9il
	oQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 16 Jun 2026 07:54:31 +0200 (CEST)
Date: Tue, 16 Jun 2026 07:54:29 +0200
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <ajDlFUhMfJP36qA8@Antony2201.local>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613131552.2562d433@kernel.org>
X-Mutt-References: <20260613131552.2562d433@kernel.org>
X-Mutt-Fcc: ~/sent
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:steffen.klassert@secunet.com,m:antony.antony@secunet.com,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299746-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7908E68C54A

On Sat, Jun 13, 2026 at 01:15:52PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 09:46:16 +0200 Steffen Klassert wrote:
> > 3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
> >    allows migrating individual IPsec SAs independently of
> >    their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
> >    to policy+SA migration, lacks SPI for unique SA identification,
> >    and cannot express reqid changes or migrate Transport mode
> >    selectors. The new interface identifies the SA via SPI and mark,
> >    supports reqid changes, address family changes, encap removal,
> >    and uses an atomic create+install flow under x->lock to prevent
> >    SN/IV reuse during AEAD SA migration.
> >    From Antony Antony.
> 
> Hi! There are some Sashiko comments here, please follow up:
> 
> https://sashiko.dev/#/patchset/20260612074725.1760473-8-steffen.klassert@secunet.com
> 

Thanks Jakub. I have fixes and testing them now. And I will send fixes soon.

The comments didn't click until I realized xfrm_user_state_lookup() only
keys on mark.v & mark.m, so distinct (v, m) pairs collapse to the same
masked value. A lookup key of {0, 0} matches a source SA with mark
{0, 0xffffff} (both mask to 0), but reusing {0, 0} as the migrated mark 
turns "match only mark 0x00" into "match all traffic".

Fix is copy from old SA than from old_mark passed along. This also pointed 
more issues.

-antony


