Return-Path: <netdev+bounces-269564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDAQKlAwvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD92CFD08
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7107A3060CED
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DA389E08;
	Thu, 19 Mar 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="r9J5Exk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146133563F6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940150; cv=none; b=MLyt7kPSiH4816fXhdqiw3JPCDcUhYp8BW5/eRPigCRZsw1/qLxPzWpAFyYE+x8sHshOqo8XittxBmUpMmqoaumzWmPwbvG+izbYetfB9o5yQo8g2DQFJ9eFGU5ODLW8KTC5KW2ffpK9Y9mwnx1OvHF9TRPicKuZCH+Sqe47xbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940150; c=relaxed/simple;
	bh=yjuF9xAV1vdhVProkPDDgLZxMZq70MdjbsBVZBgMtiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slneJKMuM1mq6tfYelav42FgHQzlAIi9R32F0bxGKtYWpjMPB2FZrKQVBMTnRH8w+W/KENNmrXXGP5+aSWupLO1S4m0kLlJw12NRJo2hyOx5M2xGNEB90NPDLaCPWLXgajkvYUNRPSyj/fsiwfhJNWwv/Syy83yW31Q6vrPTcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=r9J5Exk1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso745537a91.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773940147; x=1774544947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+hX2S30TzDh6XwWhQKX0yqfwzeDA9CM0NhQsO3zAFY=;
        b=r9J5Exk1ApRHIUncfavgaA3ZQUV7XPhSPUbz68jh7yZomX4C2kmEA3P4kJ4Cm2ekwO
         MSQoWuFmPk/BoN8ZSuj5kI9bkSWRyVWqoVUrQnWnjziTRdWICIvK+BR5sP0sqpdK8Sff
         DPMH/ZQjMEiSV+qC4HYJDP+mZAl0inbKflRoLsoni+fHiyqavAr9sp/i3jIQoo8DViK6
         fpU7qCv+m4sso3bUKnE+UQ35cruX4A9jReXzt+uYQzsu647SJpCK1VF/T0YNybllBeqI
         r9nPv8FNeQghnlIkAqFd1RHtSbCXPOr4MhguSVAznbjcQc5w6zpLS/FP+30bjJvh+yBf
         dHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773940147; x=1774544947;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+hX2S30TzDh6XwWhQKX0yqfwzeDA9CM0NhQsO3zAFY=;
        b=DmkcGox4rVmV2I8k4mSZjhuZGxr7FTvJMWJ+CBLHPZarkXNgFQvPnmW1CLaP5ABE6c
         QkFH3uItu3sbET30Zyp6lrVpHcHYaH9CR9YGKQU62vfASkYovxg7rAe5mpsV44zc5lRy
         G5IkYYRPr0Z1U+GCsems2wzGzlnTzwIW3E+01g1nMy0e85dMlLeexMwxt4OPRTCoZByX
         NJy0vFAN+5b6rauyP6YMbEv+rX8ZnLcXscIR+TogiA2PhDAARVE4W7noINTVSxbrcePK
         0dof8rjLdU0qHetHs5KZp1syZW5kS49rYJ9YgI6liNtdvmAmJz8v26+ba9FNJ9EVY8pf
         y/eA==
X-Gm-Message-State: AOJu0Yxy0h8FEC6T2MKPf3xpcQlWkYNVyUaTkLRAj0OmJTiNXFJoCrbW
	wUbVeC8rnGlRfBZyaf+Ha4TNRKwjekqfJqHcIunP5/7bi9nfIHZ0bvzb+pnEL9lxSUs=
X-Gm-Gg: ATEYQzyG7ZNwb5/MMAQr6o0BDsw5lpnqidOOp+HtYbi1xfpM3cx3nH7Eqb4KBPW9wjd
	ipAhMRf8IjZRO1XI3X2GTprTwPC7xHboLOXuVrWrbAR6lGUXqDxgabtTwFTHbBzqBFoAT6aoVmQ
	nac0gd/m6JXBRDsbmPgHTqnXxfuFyIjYGR8BNxyaQvbFaUA6KcUBMFNBXN7pqSkbBh8vwbvPhYK
	15ekfeau39zz2JgYkbXgjWI99Bdsn/UPJcVWB0xqHF8LpIXTUIo4zxE2Ekot9iNv8xvOq4fsFn4
	bnr6z9GIHuS+38VFbwoOmEhnSAz42P74U3gzNb4PrI5Atg+h+hnW/mFNGeOlqJ/3HkmxuIznxuA
	STfJFwCUe0aw9byzo5/4zPWQI+13xSYdt3rN5WaM6E/pyzK7/NvnCJ46zPSwdp5Vb6Frpq3ERNP
	FAy6qS
X-Received: by 2002:a17:90b:4c0f:b0:35b:a44f:b7c with SMTP id 98e67ed59e1d1-35bb9e7f6a4mr6438639a91.15.1773940147321;
        Thu, 19 Mar 2026 10:09:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbabc03ecsm3218505a91.2.2026.03.19.10.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:09:06 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:09:06 -0700
From: Joe Damato <joe@dama.to>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v3 02/12] net: tso: Add tso_dma_map helpers
Message-ID: <abwtsiQhycAgmgjv@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
References: <20260318191325.1819881-1-joe@dama.to>
 <20260318191325.1819881-3-joe@dama.to>
 <20260319073959.GJ352386@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319073959.GJ352386@unreal>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 25CD92CFD08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:39:59AM +0200, Leon Romanovsky wrote:
> On Wed, Mar 18, 2026 at 12:13:07PM -0700, Joe Damato wrote:
> > Adds skb_frag_phys() to skbuff.h, returning the physical address
> > of a paged fragment's data, which is used by the tso_dma_map helpers
> > introduced in this commit described below:
> > 
> > tso_dma_map_init(): DMA-maps the linear payload region and all frags
> > upfront. Prefers the DMA IOVA API for a single contiguous mapping with
> > one IOTLB sync; falls back to per-region dma_map_phys() otherwise.
> > Returns 0 on success, cleans up partial mappings on failure.
> > 
> > tso_dma_map_cleanup(): Handles both IOVA and fallback teardown paths.
> > 
> > tso_dma_map_count(): counts how many descriptors the next N bytes of
> > payload will need. Returns 1 if IOVA is used since the mapping is
> > contiguous.
> > 
> > tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
> > On the IOVA path, each segment is a single contiguous chunk. On the
> > fallback path, indicates when a chunk starts a new DMA mapping so the
> > driver can set dma_unmap_len on that descriptor for completion-time
> > unmapping.
> > 
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Joe Damato <joe@dama.to>
> > ---
> >  v3:
> >    - Added skb_frag_phys helper include/linux/skbuff.h.
> >    - Added tso_dma_map_use_iova() inline helper in tso.h.
> >    - Updated the helpers to use the DMA IOVA API and falls back to per-region
> >      mapping instead.
> > 
> >  include/linux/skbuff.h |  11 ++
> >  include/net/tso.h      |  21 ++++
> >  net/core/tso.c         | 274 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 306 insertions(+)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 9cc98f850f1d..d8630eb366c5 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3758,6 +3758,17 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
> >  	return ptr + skb_frag_off(frag);
> >  }
> >  
> > +/**
> > + * skb_frag_phys - gets the physical address of the data in a paged fragment
> > + * @frag: the paged fragment buffer
> > + *
> > + * Returns: the physical address of the data within @frag.
> > + */
> > +static inline phys_addr_t skb_frag_phys(const skb_frag_t *frag)
> > +{
> > +	return page_to_phys(skb_frag_page(frag)) + skb_frag_off(frag);
> > +}
> 
> I skimmed through the patch and it looks generally correct to me. The one
> thing that disappointed me is this function. It's unfortunate that you
> have to implement it this way and cannot rely on phys_addr_t directly.

Thanks for taking a look.

Would you prefer if I modified this and created a netmem_to_phys() helper
(page-only for now, but extensible later?) and use that instead?

Or is this patch acceptable as-is for this series with the understanding that
it only handles page-backed frags?

Just want to make sure I'm following what you mean.

Thanks.

