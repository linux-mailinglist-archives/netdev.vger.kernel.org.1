Return-Path: <netdev+bounces-271340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPFdHXoxw2noowQAu9opvQ
	(envelope-from <netdev+bounces-271340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:51:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D294331E1C1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF05301AD01
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEF1A9FAB;
	Wed, 25 Mar 2026 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKV8+def"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377513635C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774399516; cv=pass; b=rMtrhR92CrvgCVOEv3VTjBUphGTnaN55MjbDAbH+kM3Fxly1oIdNTo9vhD2SB3seS/77/u0joYfKIhsQiOSeafsi67CC1RZLGloum+yZdWvTZCSKoIfM/aWGrFoJcCnQ3pp6fA/21CJGkKrFWyDQyLAYmohVURhtWWhj9F3UNJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774399516; c=relaxed/simple;
	bh=LuKNjIE9seM569fVAINJp2Nm7xPTdSK2o5pK6Y6QAsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIIAYeyk5doCh1vM8Rztg0EC9RQBngeSTT55tqzF4913IgzxMkGiFHcy81mlCV0muG+gZt/Ex5FTz5fzjahJFsolXMEOp0GQ9U7IvulLrirWTwyRGczt3UmXHfcOA0qGNk0N+megEJ5uVuExTEM2NuIaIhnfbU9x5jah4ekky9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKV8+def; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso3731667c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774399514; cv=none;
        d=google.com; s=arc-20240605;
        b=HXuXM7c/9LG24BS2zAU1RVu4yUa4rynm6/gBced1/Vf6cRJuAlip98X3LiiJxZ0oE0
         +NsliOmY41sTQOxBrGWZOirKjTUKnM6pUcFPfZv2cNrjwEu5y4qxKgpkIf3fzdhZokX1
         if61rRfpcKT1TeHZCcRBqAIVxAhkox5X3G/LxL0iPK6pSSm4IlRXC6VRdiG8e6p0KPbo
         id57ygFBjSYlYCgUaNjnWko/HlDIuz3nTtuFWGT7+bEwuyZmCeTnyHDv9uLpOrh/FQpC
         VxCtrlBb3EgWEgGQYEsicZM+78xQiC+u9vIVD+lmWkQB7TLPdPHc3A8o4KhjDmK8a5uc
         l7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEYXUAm6wiQufxGQp649StAV/Q/oI6XllUU306ZTBuc=;
        fh=MiNez4LT3BSCzlmIlO2bu/O8YhN1AdONdhga8Lh1wqU=;
        b=ifdLU+ypFpYaEMxvltRyhozTrpeGUfICAPfC2Jy3i82KH18EoFho5QdYdrOxyzpUrD
         EjkSue08bilR1bFag6erX+JZMOjeq/q6jELZN36u3p0mLtRdEg5G8ktp2etrNfY60QcJ
         LLsn/7pjZKC9FgKXi86FENPoK0yEl38t/T6xMLQyts+TfAFMQdANahgDcFG36XBB7hdV
         l63JDpAgE2BHU6bAvTJyyXoR/3nSQyRULSbP4JVnVLRAwriIIdHqO9NQAWfLxfpGUD7h
         w+h7haxrcPTbKj2fvY/6FT7oxa6rzilezIBkVavBKcSyQKk23FLJA584f15inytTvas5
         bV9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774399514; x=1775004314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEYXUAm6wiQufxGQp649StAV/Q/oI6XllUU306ZTBuc=;
        b=vKV8+defwpEz1TegPURGXSA87CaWV8WuZciYH2nPRkoHtuZJROUDD+S/8jkUyMimYD
         6ovu3ATuCrEzMwAqj7+6rpRt2rpxtX55JSmRxouEtFg82bjhp3lVaCdOS3bzAh4zwakX
         cmutasEhF13RPfabet1twNnthDGaauLouMhyoeWC09XaJb3Y0g0UiBSrmWAOOB96PtHk
         xN69MZ5exA3dlfk4q4muYpY0oRKlFIO2ZTwx3hag+NNTS/FY4A7AX0L4qtF/33e5sydh
         2d28Sky/3dVDP4bvsI3RkHuUpawUp0tb/gEmAGDNHOvfBvXNCxhg72JILNQ/Szvzp3q1
         3XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774399514; x=1775004314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEYXUAm6wiQufxGQp649StAV/Q/oI6XllUU306ZTBuc=;
        b=pOVWtAfDHvUPd4IljCxScV8SWO1YGcOSR+x9rWPTfIfGx+ld2FktvKjl5TDfaIdEOE
         JlfFKBhEPweRnVwMDLYbfGDseNIgM9/RWBqu0c/uaTvTnq3nRsYLHUGM7XSKe4WvSY+p
         deKAXECYdIqyc5KGtHS6ms5YBVOS+0OEboOhbzDPjeeb4yvd2iPuffByfWcTe7bo2IVp
         8uCOqjGpG8XRoTtE1jZnabORj/jeDjlQavbKMKKSX7UQfd79hERhSxQ9ZhA4vsENLjjr
         iwcGT82OOa/WFseQdmecctv7aNT5JRlqFIS68e9KBTxhcp1VizvAYx5NmW/X6iGgLFGP
         al/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/4aXFN/gOxlpIFunbb1006w0BildcZPg9Zw7oxWLHagLA67WFU3Bekw0eyN/gnudqelgjwM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CSOCVtv35MoMWxcn81FGequOhUyLcYHM9R2jsWHB3mTj0QFZ
	kZvY8XaCGzQmzjcXFODQJ4sgH58aU7HL+MS49NunOFczSUIyOOpVH6y4XEFYASpQrix9t4FRJhd
	95RJDkrfk/h8akYyIlp2ypc3OFzY42vtZGtqDmbnY
X-Gm-Gg: ATEYQzwLkXqzBx9BMcWdTcRFH1xTfDmNC1uGGmefKB9tkqKC9BRsMKq94Czv7Crz9EX
	WrBeYgcYgA0DfYWkQ5N0ySkIm9EOsvFiLgiySoT09e0OvW7FunMf0VqQglHknyV6WF9khWA63du
	mM/sZORLH5oYxDfFwgDbM6mpNZiKh8GbG+Ln9YOJnKxGUvLkC3HKyMPP2Fqco2IPlRdJM5i/03e
	7GrknLmq56D/F3FI1FLvrMpCsr4/flt0TICjG6p6aI+FBahELSOSAdUVIcosgoPEx4ga1BZI+WX
	kFbqpe63lINx+oReQ6AzLb1/BPeKY1kZMLRD0rYQUjw/M+Atw8jD9ZPY6jZ/U9xBVVWEybjKMRq
	iCgLChvsremRuSnLfTk624mPJ98zBQYj/kZ4o9GklgWTVW8cNsVK5roJHVCzESkCdOldqjlhUdi
	NSq4zx
X-Received: by 2002:a05:7022:126:b0:12a:713b:8964 with SMTP id
 a92af1059eb24-12a96e5c068mr902553c88.11.1774399513876; Tue, 24 Mar 2026
 17:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com> <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
 <8b43d234-867a-481f-90e6-e155132100a5@intel.com> <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
 <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com> <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
 <20260312163025.3765321-1-aleksander.lobakin@intel.com> <42850fe3-b153-4b98-a58e-c5c78eb05f08@intel.com>
In-Reply-To: <42850fe3-b153-4b98-a58e-c5c78eb05f08@intel.com>
From: Steve Rutherford <srutherford@google.com>
Date: Tue, 24 Mar 2026 17:44:36 -0700
X-Gm-Features: AaiRm50FPDUi7C-_bpOFdeULdh-AAGgvkRwK7UPtyEDKAzf26n8UENoZAYDQs3E
Message-ID: <CABayD+fbfK6eNnTYgWCd_6BFfJkhnWRn3AHxd73TU-aVk_pYyA@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271340-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,osuosl.org:email]
X-Rspamd-Queue-Id: D294331E1C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 6:33=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Thu, 12 Mar 2026 17:30:24 +0100
>
> > Hey,
> >
> > From: Steve Rutherford via Intel-wired-lan <intel-wired-lan@osuosl.org>
> > Date: Fri, 6 Mar 2026 11:35:27 -0800
> >
> >> On Fri, Mar 6, 2026 at 6:52=3DE2=3D80=3DAFAM Alexander Lobakin
> >> <aleksander.lobakin@intel.com> wrote:
> >>>
> >>> From: Steve Rutherford <srutherford@google.com>
> >>> Date: Wed, 4 Mar 2026 14:01:46 -0800
> >>>
> >>>> I believe syncing twice isn't inherently wrong - it's more that you
> >>>> can't synthesize the header via the workaround and then sync, since =
it
> >>>> will pull the uninitialized header buffer from the SWIOTLB. Outside =
of
> >>>> SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) the=
y
> >>>> are copies from/to the bounce buffers.
> >>>
> >>> Ah I see.
> >>>
> >>> What if I add sync_for_device after copying the header? This should
> >>> synchronize the bounce buffer with the copied data I guess? A bit of
> >>> overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpa=
th"
> >>> L4 protos are fortunately not affected.
> >>
> >> That should work fine as well. I'm not certain I have strong
> >> preferences on the right answer here, other than "does it work and,
> >> ideally, is it less confusing?" The patch I posted is a bit
> >> unintuitive. I think what you are describing might make the workaround
> >> self-contained.
> >
> > Could you please test this patch with SWIOTLB? If it doesn't fix
> > the issue, you can try changing `page_pool_get_dma_dir(hdr_pp)`
> > to `DMA_TO_DEVICE` and/or `DMA_BIDIRECTIONAL`.
> > Currently, I don't have any machines with SWIOTLB unfortunately =3D\
> > Let me know if any of these works. I'll submit it properly when we
> > have a solution.
>
> Any updates? I need your Tested-by in order to send this.

Sorry for the delay, tried to reproduce this against a 6.18 kernel and
ran into environment-specific issues with 6.18. I'll take another stab
sometime this week.

thanks,
Steve
>
> >
> > (the patch applies cleanly to the latest net-next and should apply
> >  to a couple older kernel releases as well)
> >
> >>
> >> thanks,
> >> Steve
> >>  [And sorry for my gmail-driven top posting crimes D: ]
> >
> > Thanks,
> > Olek
> > ---
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index 45ee5b80479a..42111d56d66f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -3475,7 +3475,8 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_=
fqe *hdr,
> >                            struct libeth_fqe *buf, u32 data_len)
> >  {
> >       u32 copy =3D data_len <=3D L1_CACHE_BYTES ? data_len : ETH_HLEN;
> > -     struct page *hdr_page, *buf_page;
> > +     const struct page_pool *hdr_pp;
> > +     dma_addr_t hdr_addr;
> >       const void *src;
> >       void *dst;
> >
> > @@ -3483,16 +3484,20 @@ static u32 idpf_rx_hsplit_wa(const struct libet=
h_fqe *hdr,
> >           !libeth_rx_sync_for_cpu(buf, copy))
> >               return 0;
> >
> > -     hdr_page =3D __netmem_to_page(hdr->netmem);
> > -     buf_page =3D __netmem_to_page(buf->netmem);
> > -     dst =3D page_address(hdr_page) + hdr->offset +
> > -             pp_page_to_nmdesc(hdr_page)->pp->p.offset;
> > -     src =3D page_address(buf_page) + buf->offset +
> > -             pp_page_to_nmdesc(buf_page)->pp->p.offset;
> > +     hdr_pp =3D __netmem_get_pp(hdr->netmem);
> > +     dst =3D __netmem_address(hdr->netmem) + hdr->offset + hdr_pp->p.o=
ffset;
> > +     src =3D __netmem_address(buf->netmem) + buf->offset +
> > +           __netmem_get_pp(buf->netmem)->p.offset;
> >
> >       memcpy(dst, src, LARGEST_ALIGN(copy));
> >       buf->offset +=3D copy;
> >
> > +     /* Make sure SWIOTLB is synced */
> > +     hdr_addr =3D page_pool_get_dma_addr_netmem(hdr->netmem);
> > +     dma_sync_single_range_for_device(hdr_pp->p.dev, hdr_addr,
> > +                                      hdr->offset + hdr_pp->p.offset,
> > +                                      copy, page_pool_get_dma_dir(hdr_=
pp));
> > +
> >       return copy;
> >  }
>
> Thanks,
> Olek

