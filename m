Return-Path: <netdev+bounces-288130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJfEEw5pBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:30:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17F548097
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0926230066B1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595B1FF1C7;
	Fri, 15 May 2026 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWrxrQVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A22153D8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804997; cv=none; b=DMTn4BJ6qzd2yMesmFXXLJhis6cBN/8AdyNHDjMViduDjvrWHSHGp0z+jTXU9jvZV6sKFP59ctaNqGXY4rrZ/lyHFGkFtEn7OkOhJVKqvvWtOA8pG+TVNPQJiidXk/5N0t/oXttfCpdDnCnfYWMfeDhbFcsCT0rragQGvo8WzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804997; c=relaxed/simple;
	bh=kZm9COSlCKdfslmMh5PXM3Wbkw9ISu9run4sglfSr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcBqSt6psAzzKWEO3G5xxu7dpFhYwgb5J5rf8hTozq3zS6wq+CYqtS+NAkWEE8fWEL2CzenbHjqxIspbzu3m266y4eW+qwu31Wq/9LgnCri3oGddd9iDphL/JPuKH+qsW+zqv5O3/aTd7NglHO4DksfVqgFSEbQkATapTmnSUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWrxrQVC; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bc7b311e77so1785965ad.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804995; x=1779409795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Luj1/Ld5Y7QK3m1ZU7RiCeSFxxPOLPoPPrLfowkBg+M=;
        b=FWrxrQVCZCrEmKSafIp4awLFGnPYBEWaawzw30biweUlvea9lO3iRcKbLGgbJUHt1j
         vn03bDmyN59e5tJk0oK5HO7gurYv15IWqwtoea0SjF8B4XLUO+ZIZdZD6ynRYfi7u6ix
         oEy6IRGiFdycV4spgARaRKCfmtg/l8n2tojG1UgWrEdxBX3mimfCWGENYhyUO0SI+yTZ
         +TJbYejlAoiAjkD7LxmUaWSo6wu/2/dD9x4P+/Dc1avTkCThLMRQvyWHRZn8K1sG3Ubt
         VyQ2JsxEWe2eUcvCypAt9f17DaumGT5ev1DLDxlWGr7Mb2dr2EvFbpRvKMTUkGy0//gY
         IPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804995; x=1779409795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Luj1/Ld5Y7QK3m1ZU7RiCeSFxxPOLPoPPrLfowkBg+M=;
        b=G1QS3KxNKgYhtntBe2W4kIV+PyTwKCbOMF6pxDXVrEbayi+VjwBb8hK4r9RLYSGiHc
         jBIwCywTD1700QmBA7If3PFNGX9kS78nttoDrXhettnHuV0H9YSkRqpuqG5vST7/wuou
         4hqkgc4ldMR9qfRrQDRRLDFj/sqB4z7FOhdqf3Ww0XJ10U9c1LYKjcZPhdgwIvinCYD4
         lHRD1PAsCbbvNkfBB4/Z/zP6iqa9PzZzX+npCtGkbuun1IfAqNYToZoBFqBcEa5b3Qj/
         zoEhSB61qSi8//D7SIimtbjInW7dyMU7otcWqdwzVRe0T+2ZMIh7hJHzzuB6riWvEqpo
         +5Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8tr8+BVDcZOrcRNl6yxt6zRYiQFRTIspyGdz+Q87epZ75gsZtf3Dq/uflGAv//BNtxFOEext8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPHY7GXxOz9nL08oNj3fpLFN3jQtlfIkuqFRsDZgziNgMgTep
	BYmtRt/VmW7Y77ice9LW58jDfyCqmBT1DCZmy2htkxjwZgXQ61ZO9IAQXyb82Aez
X-Gm-Gg: Acq92OHLm5mx4be2ZjGnW7WF9rWfpTNR/WH0oPTHhnrnFZc1jdjDnEoBQY5JAt2DRr2
	8KLFVoUaSvIIZKc0urDjd+nN7bk0WNM9WhmLe64+6yFIlrjGKm4EwZKJjaGc+SbYh/NHXI+6Q/a
	5IK/BguxMTk+UQL/iX6/ow7MrqKqp1xgyQPrjnlNh+OvgvnRjYTGWjUzjrZKy11jgFPRLTNEPAR
	fjvmo4UP2r1yYCW2wV4su1Oxzcrtpsp6mS23Dc8tudo698MedH9yCdgQ1HjBwXnoeuZs6Eu0Hi7
	yDbZE+pMllkbPk+0JsmSPnYHk/GiFLrG9ItIJj8rC3VYl0tjmFhmiJ29bEzcTY9RBsa+cJkRtw9
	Idaf12NUW53r/alLySeRvtim3Lie5/X32y3OH2ekxko1phptqGM/h5ge/ust4gDnGxc77jJawBL
	UKP0W8MjBzTyRAKX/H
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2bd7e7f4367mr13756565ad.4.1778804995147;
        Thu, 14 May 2026 17:29:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0605ddsm36698195ad.32.2026.05.14.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:29:54 -0700 (PDT)
Date: Thu, 14 May 2026 17:29:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
X-Rspamd-Queue-Id: ED17F548097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288130-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/14, Jason Xing wrote:
> On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/10, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > only the current descriptor is released from the TX ring. The remaining
> > > continuation descriptors of the same packet stay in the ring. Since
> > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > leftover frags and misinterprets each one as the beginning of a new
> > > packet, corrupting the packet stream.
> > >
> > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > descriptors one at a time: each gets a normal CQ reservation (with
> > > backpressure), its address is submitted to the completion queue, and
> > > the descriptor is released from the TX ring. When the last fragment
> > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > function returns -EOVERFLOW so the next call starts with a fresh
> > > budget for normal packets.
> > >
> > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > >
> > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/net/xdp_sock.h |  1 +
> > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index 23e8861e8b25..1958d19d9925 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > >        * call of __xsk_generic_xmit().
> > >        */
> > >       struct sk_buff *skb;
> > > +     bool drain_cont;
> > >
> > >       struct list_head map_list;
> > >       /* Protects map_list */
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 3f1e590c855d..232dd7126905 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >                       xs->tx->invalid_descs++;
> > >               }
> > >               xskq_cons_release(xs->tx);
> > > +             if (xp_mb_desc(desc))
> > > +                     xs->drain_cont = true;
> > >       } else {
> > >               /* Let application retry */
> > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >                       goto out;
> > >               }
> > >
> > > +             if (unlikely(xs->drain_cont)) {
> > > +                     unsigned long flags;
> > > +                     u32 idx;
> > > +
> >
> > [..]
> >
> > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> >
> > Not sure I understand why you want this if you're still marking the desc
> > invalid.
> 
> The key point is that as long as we read the desc from txq, the desc
> should be either put back to txq again or publish it in the cq (for
> application to keep track of this) at this point. Or else, the
> application will lose track of this desc, which breaks the whole
> logic.

Yes, makes sense!
 
> > > +
> > > +                     xs->tx->invalid_descs++;
> > > +                     xskq_cons_release(xs->tx);
> > > +                     if (!xp_mb_desc(&desc)) {
> > > +                             xs->drain_cont = false;
> > > +                             err = -EOVERFLOW;
> > > +                             goto out;
> > > +                     }
> >
> > I also don't understand why you want to return -EOVERFLOW again? Why not
> > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > on?
> 
> This particular desc is really one of overflow cases, right? We should
> warn users to handle this with this error code.

Right, but didn't we already return -EOVERFLOW to the user once?
The part where you set drain_count=true will -EOVERFLOW. Then this
remainder will also return -EOVERFLOW?

But let's maybe step back, what's the expectation on the user
when we return -EOVERFLOW? In theory, the user can re-submit new
shorter packet (at the current prod index), right? And then your
!xp_mb_desc logic will break/swallow/-EOVERFLOW it?

> >
> > Also, have you considered doing this drain in xsk_build_skb error path?
> > Is it more messy? Carrying this drain_cont across the calls seems a bit
> > too complicated (but idk, maybe the alternative drain in xsk_build_skb
> > is even messier).
> 
> Sure, it was my first version actually. One of the primary reasons is
> how to handle it gracefully when CQ is full? Then those descriptors
> can not be processed in this loop at this time and will be delayed
> until CQ has available slots. Another important reason is that I want
> to put the whole read process under the previous clear logic in
> __xsk_generic_xmit(). Some protections like budget/batch still take
> effect in this case. In this way, there is no strange/exceptional read
> process in copy mode :)

Agreed, given the fact that we need to handle prod backpressure, your
approach is good (but see above comment, we should probably clarify
what's the expectation on the user side).

