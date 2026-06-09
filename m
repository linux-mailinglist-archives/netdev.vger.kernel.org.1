Return-Path: <netdev+bounces-297014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTC0NMXxJ2o46AIAu9opvQ
	(envelope-from <netdev+bounces-297014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630765F321
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297014-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE78B30451EA
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7543F9F25;
	Tue,  9 Jun 2026 10:52:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF13F9F35
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:52:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002363; cv=none; b=HrroCcGR/eLm36O0NwSRuMTK9FoNTzsJjFHO56Ka1q7unmhG3z8nGwARXLB2hxTATee/ZIwNeOfbjYZxyfUYKw6GWG9Iv06OEZwuop9p6QWjcrJJrJTOkTJiKJinOXgFZCah0Zck3WlSyuUtzg895IuBtX+1sgf+7ojzhCAPPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002363; c=relaxed/simple;
	bh=yJNcbNfJoDmq2WuOfC8F3Kija7CTcgpKSGTVlk1BN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMusYQ7N1mgLsL2hsYB9t2hMWj4Ny8JkdO9gSZbGV7RVwMU2kIBhm5VSVOsuuZKzbyq7LiByh6SaV7hmrgs7Hw16CApGkZO2/NLYpX9Yon/R+fb+zHysmOx5xw5I4kO5AYpVFT72gVEiQ5sdXjP048uafDDwmiaqL0K/1Z325+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from localhost (c6-bw8xn1s.asicdesigners.com [10.193.191.45] (may be forged))
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 659AoQhu031743;
	Tue, 9 Jun 2026 03:50:27 -0700
Date: Tue, 9 Jun 2026 16:20:25 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 0/10] cxgb4: Add Chelsio T7 support
Message-ID: <aifv8SR/ANbxBAUM@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
 <20260608141314.5c79faad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608141314.5c79faad@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297014-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4630765F321

On Monday, June 06/08/26, 2026 at 14:13:14 -0700, Jakub Kicinski wrote:
> On Sat,  6 Jun 2026 23:52:10 -0400 Potnuri Bharat Teja wrote:
> > This patch series introduces base support for the next-generation Chelsio
> > T7 adapter family into the cxgb4 driver. 
> 
> Oh wow! I thought y'all disappeared.

Hi Jakub,

> 
> There have been >50 patches to cxgb4 driver over the last 3 years.
> Quick grep suggests that Chelsio only bothered reviewing a single one.
> You are not fulfilling your responsibilities:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
> 
> This is not right, don't you think?
>

You are right, and I apologize. We have had some difficult internal 
circumstances recently that pulled us away, but I know that doesn't excuse 
neglecting our upstream responsibilities to the community.

I am taking ownership of this moving forward. I went through the netdev 
backlog, Shall reply if they are still relevant. 

Sorry!


