Return-Path: <netdev+bounces-282423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFRJBskh8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:20:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D7496B8D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ECDF3034A01
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8322C027A;
	Wed, 29 Apr 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5YphzTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06C36D9EC
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475696; cv=none; b=Xs/NlR/nyRbs1wXXv6JoMeMduRmzpoUeQ6Q6oPnxqEYW4EYXnKQC9pCfdhSE+7As2OcHSv6Z/uKA+A1WatWEzilt6pesyQHxhUjQuGpCJE7b/w96RthbBbSxYyE9ojJMiAyGAJ0t8kki5EoIQWekoAfmCWdwOBXherJbpKf+UTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475696; c=relaxed/simple;
	bh=BspWGzgP3VHgFLMwTG1WzVTslDlWt4FlN7uDeE0blwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZnRaOg9tIPf5w4yoilsxwf4unxIZCx10kbcUrzJ5n08WVcI6Rc16WJvK+oppcSStQmhdEbFOma1og4XVFYVeEnjmnPh1+sU8ZggoS3S1Kzi0Dpzb6HSHcsVBkPqmXhF0a2DMDa0uUZpJpdMYNFlDYPSsVssq8SUtLpc/t7yp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5YphzTv; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b2429f98d0so76132575ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475693; x=1778080493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QNh9rYU4XM3OVhht+9ImRatweLA/+G0hxT8HEvEZ5js=;
        b=I5YphzTvgsN2wPoHDBqO37QmSObWCe+xTyzjuHrTkCU1PbzcJSBOUkxvrEqXiZewNc
         7Nb3sem1tYe1vPFoh3OZvKwHRFH0Gkj07Svt7uleya4Dzh87p6ST6O2l6Qi3I3uh3OvM
         0+e+Pe8uK+MR22EOMZBnvn6QqQDpOMDmmDIGm0tVCQhOuNOZiDc5GESgrIrVCkpA8vAh
         mtnkijpokOFvbVir/pyfV2p55HqPX5q6dculjCH/71IGbQReWh6LyvBHiTcbqqu0OJ/A
         fiPEFS0fHBO6AcUd4HVfXBfI5djZzm6mlJYVPXvQ/4sU/+jKwVdBVIk/FBPSST0FbCQR
         lMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475693; x=1778080493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNh9rYU4XM3OVhht+9ImRatweLA/+G0hxT8HEvEZ5js=;
        b=APxKm3lxBrtAUCIrNSNPhg+V253PY6kiyonzBxkyMfYyrI3x8bFmQYOIsvckK4hqpl
         vnNW2NFK+KqjAKt2TRMq0l9cd65hfJrLcrXWJ0HAV78kjpqO6v1AS9+rdJTN69RTO41N
         6Ao0xZdLZ7PFbrAFCcF3OfOfsnwziLumfE5/QU/5GIDFaiFyWjCmmlxxP/Wbpd4dIceR
         JhKPgux4OuB+IazMMR3HB0NkqC3S9NrwZ1VIPX7TAV4J/AgClDslrpsIDE1PdcJniQXC
         cowidx6yzYxxX9JjflSU0rAHP1eAyN3JunqxpR45kaY6PLByhUOSHU7mK+iH/sR7dx1t
         4GSA==
X-Forwarded-Encrypted: i=1; AFNElJ8YFw04uI1pmEfXUFntwrKckldmB0tKZuuOxelTf0oCp5A/T1A01spPm/hPiDBLqx9HiPKuR88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDS0RahxUIglrlHQ5O5/DoIOJfyG41h/5HptIAynArH45wdOyB
	KoIyG7kA1JX4ZkdH35xAipY5s4GpRWi7GLaqlx9ot486nFBXHYQIfUXi
X-Gm-Gg: AeBDiesGPIw7zaOVzi61Chqp514m/7au3r26YRwvhLDS1vfxk5I0wMXnoH9mRCXydfS
	pzTzaGwB0VjS3H9r0klHxPUcydPOIojy+DaeIupH4ta340ClumxLdjePa49fKiMu7iZ+lEHgZ84
	o7/ZGLwotEWwzqO+bM5iDzwzF//jcY7oHlGsngTbWEbmfgFMexXoG0Mu79gh+GSGlz7bFFZQNov
	GPa3zwyTocgB75/vToH5STPsi6N7DStj7e6P8Lqudl+8XE9rAD+vetdZIBvGx3lz96/CmZtUL4z
	wO602u1Kp4KxgWFouobtiZ6PYeGBzXzs/L2yz74zCB1N3LIWNT5oCQTPL6hGluto1YEzs4iiI4k
	3Lxx8et/WTo6ZmJJqCRodr2jH2e1IcNc8cObSf7P8ch8aLW48HhXc1U0uv791umtoT28nLWsH45
	jMmKp7Ni+OgNbToyUNvzDB7yo=
X-Received: by 2002:a17:903:f87:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b97c4dcbf5mr76447745ad.33.1777475692960;
        Wed, 29 Apr 2026 08:14:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988989d67sm25869385ad.76.2026.04.29.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:14:52 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:14:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
 <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
 <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
X-Rspamd-Queue-Id: AC8D7496B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282423-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,devvm7509.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 04/29, Jason Xing wrote:
> On Wed, Apr 29, 2026 at 2:11 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 04/24, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > uintptr_t cast:
> > >
> > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >
> > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > the descriptor address are silently dropped. In unaligned mode the chunk
> > > offset is encoded in bits 48-63 of the descriptor address
> > > (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> > > entirely. The completion queue then returns a truncated address to
> > > userspace, making buffer recycling impossible.
> > >
> > > Fix this by handling the 32-bit case in the destructor_arg helpers:
> > >
> > > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> > >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> > >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> > >   xsk_inc_num_desc() brings it to the correct count of 1.
> > >
> > > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> > >   when destructor_arg is NULL (not yet set), false when it points to
> > >   an xsk_addrs struct.
> > >
> > > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> > >   before touching any other skb fields; on failure return early so
> > >   the skb destructor is never changed from sock_wfree.
> > >
> > > The existing xsk_consume_skb() already handles 32-bit correctly after
> > > these changes: xsk_skb_destructor_is_addr() returns false for any
> > > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> > >
> > > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > > 32-bit only; 64-bit builds are completely unchanged.
> > >
> > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> > >  1 file changed, 31 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index ed96f6ec8ff2..fe88f47741b5 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >
> > >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > >  {
> > > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > +     else
> > > +             return !skb_shinfo(skb)->destructor_arg;
> >
> > Don't understand why we need to special case CONFIG_64BIT here?
> > Shouldn't the same existing condition work on 32bit?
> 
> Because 0x1UL is the particular semantic applied on a 64-bit arch.
> xsk_skb_destructor_set_addr() sets it while
> xsk_skb_destructor_is_addr() recognizes it. They are a pair.
> 
> As you noticed, one liner works but is not that appropriate: on a
> 32-bit arch, this member should be either a NULL point or a valid
> pointer pointing to a memory region. Testing if it's NULL can be
> helpful as to the long term maintenance because of its readability and
> robustness/safety.
> 
> The error path in allocation of skb is really complex, which is why
> I'm so cautious to take care of it :)

Let's cleanup the error path instead of adding more complexity? Similar to what
you do with your "xsk: fix xsk_addrs slab leak on multi-buffer error path",
but maybe add a few NULL checks?

Instead of 32 vs 64, I'd like to reason about whether destructor_arg
is an address or an allocated array (not whether we have 1 or >1
descriptors). And we special case 32 bit by always allocating it.

Haven't checked, but maybe this is all you need (besides your _set_addr
changes)?

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..03f217e85d31 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -589,6 +589,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 		return 1;
 
 	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	if (!xsk_addr)
+		return 0;
 
 	return xsk_addr->num_descs;
 }

> I've noticed the status has been changed to 'changes requested'. Does
> that mean one way or another I have to post a new version?

That wasn't me :-) From my POW, patches 1-7 are good to go..

> >
> > >  }
> > >
> > >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> > >  }
> > >
> > > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > >  {
> >
> > [..]
> >
> > > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > > +             struct xsk_addrs *xsk_addr;
> > > +
> > > +             xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > +             if (!xsk_addr)
> > > +                     return -ENOMEM;
> > > +             xsk_addr->addrs[0] = addr;
> > > +             skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> > > +             return 0;
> > > +     }
> > > +
> > >       skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > > +     return 0;
> >
> > I think this is gonna be a 3rd copy paste of the same logic? Let's
> > move to a new helper and replace existing kmem_cache_zalloc places?
> >
> > xsk_skb_destructor_alloc_list(prev_addr) ?

Any comments on this?

