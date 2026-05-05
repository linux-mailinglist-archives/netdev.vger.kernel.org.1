Return-Path: <netdev+bounces-284227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0b0JGkaD+WlN9QIAu9opvQ
	(envelope-from <netdev+bounces-284227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:42:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A371B4C6F1B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1403013496
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609863C1967;
	Tue,  5 May 2026 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="h95Yi7OQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596AB3B38BD;
	Tue,  5 May 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959746; cv=none; b=UyOvQGs9K1yL/3yBsPTH7NmvpdyFMptXD+Q22gU8zh1JGXrAF+FBe8w8dG3SmSjGi9VprLFJGBI0es8ZLpdSLB8E0LOZXGbUdnujLpOx4UJxooyAZoEdINNej/DZt/qPJJz/9FADOLfM+K/He28uovzl02Y3POfIxmmolrutz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959746; c=relaxed/simple;
	bh=rc8ERhUgL8kJ9G6ULhFgUZndgBMUabGV9dCng+4g9lE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCW5R95djRQPrRR6fC4LvvYPLw4QwbX1FsecL20LblNe7F+RZIFYGOiLiUkEjk9zzMg98JqClukDHzNA4dD3WpqoWvXcmvtcs4y0RFb0GuzyRqC47eKGsWbGt8ifhxGaJntgDJIugp2uPuzcnv+h0W04q0/Kk1XL65/JnraAnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=h95Yi7OQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3236F201D3;
	Tue,  5 May 2026 07:42:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZL8htbvpt135; Tue,  5 May 2026 07:42:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4BE4F206E9;
	Tue,  5 May 2026 07:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4BE4F206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777959740;
	bh=AX/mJIodJOkU62A34/3ZwiHur+eoFFAy0H8PUqWd6tg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=h95Yi7OQh8MVszlvv8wse50Q1ynYdOoB71gycNyLbo3n1weFbqkLhj0a4AAKnk2gw
	 nZJ8mDPNhkDiwFvsOgjVk32EB9bbQ76qxPTdLXUA66WmLcqb6VWWWfr2yRbzuO0KG2
	 nzbyPacfIIW/jg1+Kam7NvyQBYoh2oVX0RldDPS28cn+NwlsOPxi2Ndn28p8kT+f9o
	 nvPjnZRqPGhIjEDV7FLwgVOm+/+tqctq7cDdSVQvGIXO/m1HF1Ub+iCkvhFo+FwHGx
	 AhclimUGEA/yq5I4c0Aqq/OoWaZKRNivkcAltvcMN9r4JgMkdnuOTDnvyiupXaBFmb
	 uVzNLPBkAIWKQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:42:19 +0200
Received: (nullmailer pid 3692452 invoked by uid 1000);
	Tue, 05 May 2026 05:42:18 -0000
Date: Tue, 5 May 2026 07:42:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hex Rabbit <h3xrabbit@gmail.com>
CC: Hyunwoo Kim <imv4bel@gmail.com>, <netdev@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb
 frags
Message-ID: <afmDOrObXxUC7eDt@secunet.com>
References: <20260504152712.76305-1-h3xrabbit@gmail.com>
 <afje62FxYMuTUpSb@v4bel>
 <afjpqNXYFVfZjQl5@secunet.com>
 <afjrqlBPSv0X9kaY@v4bel>
 <CAF3ZFefQM5Ud8iWDoKV9FPdZ=8V0KD56Bvkdcku1fmm6aaD_Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAF3ZFefQM5Ud8iWDoKV9FPdZ=8V0KD56Bvkdcku1fmm6aaD_Cg@mail.gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: A371B4C6F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Tue, May 05, 2026 at 10:49:42AM +0800, Hex Rabbit wrote:
> Hi Hyunwoo, Steffen,
> 
> > The report and patch for this issue were already posted on
> > the public netdev ML 6 days ago, i.e., the bug was already
> > publicly reported:
> >
> >   https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/
> >
> > Credit for patch authorship is adequately covered by
> > Signed-off-by alone. Setting aside that your work proceeded
> > independently rather than as a review of my earlier
> > submission, the trailer should conform to convention to
> > avoid future misunderstanding.
> 
> For clarity, I also found and reported the issue independently to
> security@kernel.org on the same day, with my own reproducer and
> root-cause analysis. At that time I was not aware of your report or
> patch; otherwise I would have referenced it earlier.
> 
> I am still not fully familiar with the exact kernel trailer convention
> here, so I added both Reported-by tags because the reports were
> independent.
> 
> Steffen, either trailer form is fine with me. If you decide to drop my
> Reported-by because the patch already has my Signed-off-by, I have no
> objection.

You reported it, so you can have the tag.

This is now applied to the ipsec tree, thanks a lot everybody!

