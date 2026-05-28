Return-Path: <netdev+bounces-292776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBcXMTB4GGo8kQgAu9opvQ
	(envelope-from <netdev+bounces-292776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE805F57BB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5F2C3007B1B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC93F4DC5;
	Thu, 28 May 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spyA/b/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B913F99E5
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988080; cv=none; b=NGVwzeNRbAmzQ/bBIWPUyvVB83FUqMId1CMs8P8Bt8yGr3q/3fe/rQGTgLIQ0viALmxob8HflV0suygTBdbUrMPlYcwWGPbOG+vMsZq7sCY8brF2Oqe5QZHV1ayWpNQ64qtggjyH8t4jIn/7CAO+DocfOaDJXgN2p41bOlGAJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988080; c=relaxed/simple;
	bh=/ei+DqEVN9r/8jMk8Ipeh5iIKq+CI3zShNem1+ZRbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqPiivC8Q/yInWxcXiMv36lO2nVdRuAaYxAugj61O6BHV3N1/oEAOrfZsfV0wfJ1wfvrXIuUeN3JbK/28ewX4IKffdB7RuThF99aI+uGR3OL5NH+WQfK/iVJk7Ge+0LRn9oFNk3U9xlWu6e1O0bDiLMvJqTm0B1L8NzEVRGOM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spyA/b/i; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bdbcc6c4500so1209193866b.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779988078; x=1780592878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smhPx+LUPqSlt1Yzaxt2DbCx+/dEe2p7UOWmOxvCr8E=;
        b=spyA/b/iuvhXPScrRbTU19stsYC5D9GZatXFK0m9m2A/wahyp+S+v08anJJzfnd638
         axwO2a52VqEpUxdWmCZxNGZPEvyYHVCsH/dl8YsUuKeusGk1itVPw/QtmjJW5V614dNW
         inYIx3FOIMZ/0Rd5EPE20BkbDIwQ7AFyRDuy74lU45bVGqAJfo6qMzuvl3ozlmfBe0oT
         JZKio6PCK878FdTVTtRhp7nS65oWI0M6hhoovuOVerGRZ5hieh0NPoFXheA/EHiqtqOe
         Qc/c+DIb1qHcXq6Mr96vrnBd1LagddEw+BCp80ydGtj/Mg5GdDxX0+MsQbf9Zrio0j95
         pVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988078; x=1780592878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smhPx+LUPqSlt1Yzaxt2DbCx+/dEe2p7UOWmOxvCr8E=;
        b=XuwAkKh3rKxP2vqvDOF8HhbCnb9ytzT9ySKdvCltIJAF3IuTt8wZAgMY+YMZPZ1RcA
         54ZBUwRkwEymA22PAmr6eAZddP+3MneRgYVwfHmwR9GtKesjLLEdvxxQAH/sL77iOdDX
         gOFV8lAGXmLmJk+PlwQ9wZ8REUC3SUgxvH+u4/7GihVuBlprzu4yR1q7dh3vsPyEbvHO
         Gz7GiNETtLCSXFOPPtpn6bQvUj0pSoXbHZgqbD/3clTQouL6HhhusoPxeqJqkGsplbuo
         h7ewUGATPWR9e579zrSVQAeQZmgZJZK6X5+lS7zikTZdWfJrerm9GX7KJV4Bgk61nAGH
         PkuQ==
X-Gm-Message-State: AOJu0YzOjJ1yKuurNx/bOG2/YPK88FKqsNbaCzG8Fnpyh3cRj2kaVSLA
	PRXI/WWnEmaWkzYsRMCYnmStsmmagsAiVlzEheXgHm+PjPfBQyVhZNYY
X-Gm-Gg: Acq92OFIi8vhZIQDitb7zZN3RWNymXzOH3acoiy0NN/53ff4iqh19SI5AZnZDNeSK8K
	nzqYuFkT4buxXyj1Zsf8ukOIKIFpP5cr4/PGwi134NEJOVROsIUQacDd2drxFgPkDRcNOeARICW
	0rYeZd7SpyywNXBgb+i3LSAdvwFcc0H9nIuHvI/6seAOC3y7VoBisI09chxewLqkMRoy/fCFApv
	ASnd8IZ8itjDX+FC0OmyaTjj0jwZ60LwD7yVI5Ms9O23xLUGgihrqAYAEr5NjWFg+4rgyiV6xx2
	aKS4ZxM4MQzkuiOMKjOLncyHiS3Ys0Ha6W/FydAysjZkq0bdEvHpOArzQYJnlEtiBJSHgSAh8O6
	qCT3XjdG6K++W7Sbo757VkZn//IVp0R7AJ/ILErAa0rEt5GEj8ugmCBF8oF+trsz462qBlnuVhZ
	erxap8JXv6qq7sVw/NE0sc053RbnfVZaAGVC+Ns2K4BXSnBw==
X-Received: by 2002:a17:907:3ea8:b0:bdb:f53b:8e8f with SMTP id a640c23a62f3a-be973d28d85mr2211066b.30.1779988077425;
        Thu, 28 May 2026 10:07:57 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc66d9c2esm742826566b.57.2026.05.28.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:07:56 -0700 (PDT)
Date: Thu, 28 May 2026 19:07:47 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
Message-ID: <20260528170747-oscmaes92@gmail.com>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
 <60438b0d-e664-4c86-b4f6-27343fe2fc7a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60438b0d-e664-4c86-b4f6-27343fe2fc7a@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: ECE805F57BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 04:55:55PM +0200, Alexander Lobakin wrote:
> From: Oscar Maes <oscmaes92@gmail.com>
> Date: Thu, 28 May 2026 16:03:20 +0200
> 
> > napi_complete_done may call gro_flush_normal (though not currently, as GRO
> > is unsupported at the moment), which may result in packet TX. This will
> > eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> > while trying to re-acquire the already locked spin lock.
> > 
> > It is safe to split the spinlock block into two, because the hardware
> > registers are still protected from concurrent access, and the two blocks
> > perform unrelated operations that don't need to happen atomically.
> > 
> > Fixes: 5b2ec6f2be51 ("pcnet32: use napi_complete_done()")
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > ---
> > NOTE: This patch was a part of the following net-next series:
> > https://lore.kernel.org/netdev/20260525125437.4061-2-oscmaes92@gmail.com/
> > 
> >  drivers/net/ethernet/amd/pcnet32.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> > index 911808ab13a7..4f3076d4ea34 100644
> > --- a/drivers/net/ethernet/amd/pcnet32.c
> > +++ b/drivers/net/ethernet/amd/pcnet32.c
> > @@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
> >  		pcnet32_restart(dev, CSR0_START);
> >  		netif_wake_queue(dev);
> >  	}
> > +	spin_unlock_irqrestore(&lp->lock, flags);
> >  
> >  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> > +		spin_lock_irqsave(&lp->lock, flags);
> >  		/* clear interrupt masks */
> >  		val = lp->a->read_csr(ioaddr, CSR3);
> >  		val &= 0x00ff;
> > @@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
> >  
> >  		/* Set interrupt enable. */
> >  		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
> > +		spin_unlock_irqrestore(&lp->lock, flags);
> >  	}
> >  
> > -	spin_unlock_irqrestore(&lp->lock, flags);
> >  	return work_done;
> 
> While this fix is valid, I'm wondering whether this needs a deeper
> rework as it's generally a very bad idea to have IRQs disabled when
> NAPI-polling (except for every short sections).
> 
> Could these irqoff sections get narrowed down to reading/writing
> interrupt registers only?
> 
> Thanks,
> Olek

Sounds like a good idea, however, I think it's out of scope for this bug fix.


