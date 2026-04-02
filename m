Return-Path: <netdev+bounces-274513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLalKQRczmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485ED388CF8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F20BC302D9C1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BCA3C9ECC;
	Thu,  2 Apr 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="tsIlGj1/"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C339D6E8
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131583; cv=none; b=bWZgqEm4QDZIXmNOeaaIAes3keajn7t0lfcsaO2FnSxAoZKrS5UPAOQ9uzbJvyWzYIYAddryMbKNaRgVqHfk0FxDk4q0SynrouIOxby3IV0NTzVI5H8rCkEuk0Tk+TiADWKSQmKFzlLcq/xFVTHPYCN2SAnvKeYvXnNrkqyBeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131583; c=relaxed/simple;
	bh=wTKOVE172x33ogTJ488J+DHu8qmeu2NG6PA4znno9y0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQF6cnEsMPnV6zTjq3VUd99KWRKXJ2R01UQEIRH10Q5pN58wAJ9VIVzrjWhGPOkvvKfUaxJHU3FVfsKkXyRYbhcKgql/uC2OGFYkYHPeExKPwRKqTHxHiaPLsG7uiKMNAeqoqTa3bc4BdFYHfEFXrFoyB/iPgVwjHLCb2d450xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=tsIlGj1/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 338E1206DF;
	Thu,  2 Apr 2026 14:06:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yabjBDPZlw0K; Thu,  2 Apr 2026 14:06:18 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7AD9F20853;
	Thu,  2 Apr 2026 14:06:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7AD9F20853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775131578;
	bh=ESjNUTCU1GHV8myfhu3YwiadCFGWjJyYODhCZ3IAYno=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=tsIlGj1/xzLw8TVQttl+eiFQcmcewwacJ2adgi0t24dcpQr4z4cyT2WD8JC3rdWzf
	 RlLNcnIeyp9C+yxCW7QZWtXsdcGhbpnZNeZphA+5LJ/1qyCCy1JYDjxhmdWynsyKE8
	 xnY+Q+RSjvlil2Rnr0mqVD8IpPcToXPM1ezoPGeYSj9g4i/SmNBHxTTeG0eWkHOq3q
	 BFmECBIACNpuoTFMtJnuRhq6d7WT7Ly2Q+hfk5cRxvz92E/mD90J16yA9yM3mZ1+pa
	 C8oKTSs5112nFai1ehhW+FCpFE1YVBOA9z1JMiukREozDVTs0xuqO/V2pFZkOaf3vz
	 MsO1OZF2/5LmA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:06:18 +0200
Received: (nullmailer pid 3819456 invoked by uid 1000);
	Thu, 02 Apr 2026 12:06:17 -0000
Date: Thu, 2 Apr 2026 14:06:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec 2/2] xfrm: Wait for RCU readers during state netns
 exit
Message-ID: <ac5buYqi6I7s_H-3@secunet.com>
References: <ac5TePdKtegtWiRG@secunet.com>
 <ac5TqJaXXg66dqBy@secunet.com>
 <ac5ZsQTyo16xST_a@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac5ZsQTyo16xST_a@strlen.de>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274513-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 485ED388CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:57:37PM +0200, Florian Westphal wrote:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > xfrm_state_fini() flushes the resize and GC work, destroys all states, and
> > then frees the state hash tables and the inbound percpu state cache.
> > Those objects can still be observed by concurrent RCU readers. We need
> > to wait for a RCU grace period before freeing the hash tables and the
> > percpu cache to avoid netns teardown racing with lockless lookups.
> > 
> > Fix this by adding synchronize_rcu() before freeing the state hash
> > tables and the inbound percpu state cache.
> > 
> > Fixes: c8406998b801 ("xfrm: state: use rcu_deref and assign_pointer helpers")
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > ---
> >  net/xfrm/xfrm_state.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 1748d374abca..84fbf1591138 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -3327,6 +3327,8 @@ void xfrm_state_fini(struct net *net)
> >  	xfrm_state_flush(net, 0, false);
> >  	flush_work(&xfrm_state_gc_work);
> >  
> > +	synchronize_rcu();
> > +
> 
> xfrm_state_flush() is expected to relink all states to the gc list for
> the gc worker to handle.
> 
> The xfrm state worker calls synchronize_rcu() and then frees states
> on the state gc list.

Yes, xfrm_state_gc_task() does the synchronize_rcu() already. I found
the ploicy thing and had the impression we need it here as well.

I'll skip this one out.

Thanks!

