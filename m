Return-Path: <netdev+bounces-267313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPEIF1HBs2lQagAAu9opvQ
	(envelope-from <netdev+bounces-267313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:48:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3427EF7F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC2B302F7C4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E21917ED;
	Fri, 13 Mar 2026 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VZ3BO9kY"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2179CD
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388109; cv=none; b=KPxyhruBvOm7+mRQedQ/EMvP0dGYlFkPAf6W5Eb6WvmatS0TzXZL0h0hCp1mEJ6dDcUpWFBuweY0DH9pc2W7p88NdIaVAGzFTiaS9a1YLzAG6edNtefrOOOLk3X9lhuVdWZChCjIm44qku6euShV9Ox1E6lP0ICo9WrPB9/8Xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388109; c=relaxed/simple;
	bh=oMoLqytWvqlbh9nTZunhUVkMxpOK58oR2YWmxsGChYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrvEjzZzAARhyE0ivE7IKg+MQqu0bDoNAOvn6al95OPuqqQtwSGs1qfdZIzIRTkGgWqq24uxmE353NIrwZahX2eEcDI2iHgeDZwN4Gyz60GMDtozASkbZvoQoGOJT3M41o2IX8zBN65sEf1ehrnzb1KTPVhxU1nwZ+9DaK64IZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VZ3BO9kY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C86C8207C1;
	Fri, 13 Mar 2026 08:48:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IELiMnh6aWMl; Fri, 13 Mar 2026 08:48:18 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4CB0520590;
	Fri, 13 Mar 2026 08:48:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4CB0520590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773388098;
	bh=L1ua3y1FLcim1VBLtNc4NWQySV15oFdT5AA8hmWo8bY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VZ3BO9kYJfakBruSgMJtfuSvdczWAL0dl2oodZ7FsVepmqyHYbUjr179QUPtImjnd
	 Hw49l6hFX+aUgzVof92k3qLNrwMuhetmIL7pa/SC4AcTQTl7ouGd4DHryE3YPfj1p0
	 lxXueaSW08bVnqYfEGZQLqHy5/wRQCKCAtpTTg94FsaNH0LFhoNfl5H1SHgW04u72i
	 wQBRGOYfpE4JCLpPevAa2N112Wz4ItKmbYrBhqDuGhGnbN2h9voAHnrX5UKHtG8aGL
	 qM6C+SWm9/8GyWq0YWnocyDMCKCqeePVPHZ7ZhQl55qCwOOMtBBHto91l9kGwycQbv
	 kpDwHCsD1zG5Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 08:48:17 +0100
Received: (nullmailer pid 3685931 invoked by uid 1000);
	Fri, 13 Mar 2026 07:48:17 -0000
Date: Fri, 13 Mar 2026 08:48:17 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 00/10] xfrm: fix most sparse warnings
Message-ID: <abPBQcgtrZh9sGCr@secunet.com>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267313-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CCF3427EF7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 11:32:33AM +0100, Sabrina Dubroca wrote:
> This series fixes most of the sparse warnings currently reported about
> RCU pointers for files under net/xfrm. There's no actual bug in the
> current code, we only need to use the correct helpers in each context.
> 
> Sabrina Dubroca (10):
>   xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
>   xfrm: state: fix sparse warnings in xfrm_state_init
>   xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
>   xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
>   xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
>   xfrm: state: silence sparse warnings during netns exit
>   xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
>   xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
>   xfrm: add rcu_access_pointer to silence sparse warning for
>     xfrm_input_afinfo
>   xfrm: avoid RCU warnings around the per-netns netlink socket

Series applied, thanks a ot Sabrina!

