Return-Path: <netdev+bounces-266705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAZCDnecsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:46:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4126786D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA80304B592
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4793E0C4C;
	Wed, 11 Mar 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWnUKj54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550F1FC110
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247522; cv=pass; b=CeW7dJadCCjAEZAaEoD5Tvw3yU7PtdIwEP5JuQlbOjXDiOEJ4vA3y/PmsT0mk5tHRnCHZzVRWO2yrkmiCPQ5E+UICNRKO3Y04NL7SAqq3dLm0DONNkz2LGY2Yau2Lw+W9/HC/hjmMRtuv/bTY98Ie0D7XAPoKcBKFhhtpya7Fo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247522; c=relaxed/simple;
	bh=kl6v+XHNBnT1GXVUvnY8qTfJxwt7nloYe2Bk+elANfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWg2Km4qXcO4quedrn7Fw9y2C5+GnUvbmkD2nUeiEahj0fDg6jlIMQV0zQPYG/Js0jaG2PbFVFPpu/5V8nPTyXNyPa/FfpzNRz/kAZTSkzNsy5IJ3qifX9N/1GV37VV2nq+m4h9o6KzEklXIMc8u28bKGkzEeOa0q3xeJD4K1z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWnUKj54; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a3486419cso929201fa.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773247519; cv=none;
        d=google.com; s=arc-20240605;
        b=Xk9PRic9KbpKImSD6PvA9NVeqpqbdflmE5Oj8DLXrR4378vZlDfZqCexfTaqMe3BfU
         4Ur0T/Ou3qYIOrHsVgAlk/PD/tHqYvYZXRe/k2/y7B6vgB+FA6eqoqKQQEKGVggUTS9L
         vO8kl1uacBrs1N+G6Dj81o9EValvzb0Qf8EbVglPNUYFEYvrPO94ScQkVsBeXQVAm6rv
         hz2mgzflwJgoJY7fMfHLJh5WYB88wTZmIGkPGQ+VmMR3uRCaafFlGx9p9F8f1c/tg2yE
         omHAXt1/yKmeLBw6CQd5l5UkABfs1OFJ0X6/dNSKKvhCr90UxP8VrZV5wp+32MQey2sG
         T2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gc6qFjhjONxJ2zx/Xofxxab/xC2P3PGZw9467l435A=;
        fh=hfogBtDmlTGmGfYS31wGY1CP4TnWrkuX3uzLfHdbMR8=;
        b=QlEjA7gwByIQ03g64+BYTT/01NcV3BJHfFOSS45z+KdeRiirbAwdOt/Qn5VoDaaVVQ
         yk6gf/SZuZ25S8EbL7bne9t7GunrWLnAbMpeu485vENXoQW2ESN9C4AR5H+9QSoRcjyw
         u2zSecYHVKKaqjAU0MoY4ekESPYJ/LRDkSNNCELCGTCVT6KNbAmPuzuDYvZybpn9kOfx
         wsPcs35baae4QpJFwBjRxnmVpHk8uYHPzpIvztNB0TbkUSHvUht56bRxTszxGvFCjKxk
         RG3mbNda4h+dKbeUwKeUrAjh0CfsbeKj2LKr1lbHOZtyBYVuGDc31uzFjPZ8fRxN8s3X
         MaAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773247519; x=1773852319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gc6qFjhjONxJ2zx/Xofxxab/xC2P3PGZw9467l435A=;
        b=OWnUKj54qvOWzndrssfsPIXSSvLociLV1T8dWJp9bfOAf4nb3fPt+X2FurUy8tOP93
         ne/kXGm+u65kGbl1oKFSnSymKBIkain04zd82znqzSrIIg0HFmBzZcGgq45e2qA99ozB
         dIgLZ8N+12gcN39p8xyEKz013tQ3hwDeAzLS7qfz6GTlIoOU0O1wqsRcVX1ghotGNDiB
         O5s/q8G3NsecEYfhRuQpPxfT64ImoTRjaGSXjUBKWpCmSpuppnDOtYqJWiFp0vo7QFsS
         WGt+UAoKdl+UOh2SXdwPjgeZfXBj5Gw8CfPpmWzAarStVfVAU7fKJf7WgGZsVpA+iVMG
         PDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247519; x=1773852319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gc6qFjhjONxJ2zx/Xofxxab/xC2P3PGZw9467l435A=;
        b=pkFf1YnoWhL9vSFg+ePYsp5uVhbl2wZR4u34qzN19FI08yTd5uiwjuBsImvz6tRaV/
         pfQuCnXawPKlXn8RaymYxGZIut0HHqxia+015sXd6NGqpX5tCgRr/z4BuliNau5JHPOV
         nVw7JM/aRQ3Eigl8VNM77cAizqEFOfeH1VXmcVvULBBoBMVEAuwC/LJUh+UZJQA183lE
         FKl/1XNjN/f2qj1RivyVnM7G38Jr/Vkw90YAe20DfI3QMv8dlc+l5xFNQI6h+nl3miev
         uJhLCA8MhSoFwqw9UvKBjduz9N79bnDFw4X7MTotY6b4k2D5kklZrb4yvHGF3YLyVHba
         z7ew==
X-Forwarded-Encrypted: i=1; AJvYcCX/4P5Bkse2bx9UEMqfUUoR7dRGVincQsCfNV7/vRnHkTl0LNOInVmL4kpz3B4U+gDja6x19vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjAEZpa+sxGfrTXpcCuME5mdi0h2xPd4EIXQS83Q9LpNCH06m
	aHzSrchXjcLug9RJwg7FrQpyQ5YKP4VFZuraSTYuUev97SWvYtNEgZ0jHtYQYK2y6tYFHhN3Ens
	LF/JnsIyjnUe0KyGmzFsXm+3uCqObew4=
X-Gm-Gg: ATEYQzwel0utGHL96df2B0sDx4jTJOLMILQluzHVgGgryQG1X0D4vBiHfzaVp+bHQAv
	MNcxLIPffx2Am5e0D5dch7hrfLr6hXMWxstN5f4iLTjb7AnI8POz96CIWxVq+8qaEIQ4f9Lkt7d
	f//4l/Rbs+Rn7BBF8IZLqo3JEElRHjJLikyWFoPX1YxzstnefiPrQydKJPBjHChQZ2tKJ7mQeve
	TFr8PwOjLES3bXn4JFx5RDbe4BrPUn9/ZOGKWv24V7ksvb0w3dbkZ+6msYAumb5+9oexWahcD29
	DcyjBtw897Spmq7m5ksf0xOPAVgCEgGxV207oz3dOJkDarklz1ZltbuVhCNSDP1ghMxH8iWRLpN
	JUm3W+VJjRHCvaAXFl0CqXjNBQH4h94RsOzs=
X-Received: by 2002:a2e:be25:0:b0:38a:513e:4379 with SMTP id
 38308e7fff4ca-38a67e3869cmr13249181fa.27.1773247518869; Wed, 11 Mar 2026
 09:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
 <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
 <CANn89iKyPZUqmirYza5ewD2dBQfZCMunG771x7cMpUFkvw9x9w@mail.gmail.com>
 <20260311155539.3Aikrlaz@linutronix.de> <CAFULd4aGZ4HcUYcXJ=5LYkyNtJ=0fHFbk-ZEvotpd=+CF3F1JA@mail.gmail.com>
In-Reply-To: <CAFULd4aGZ4HcUYcXJ=5LYkyNtJ=0fHFbk-ZEvotpd=+CF3F1JA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 11 Mar 2026 17:45:07 +0100
X-Gm-Features: AaiRm505IbJlTJFY2rMlJ2-a3xgRsAKOaqWykgrLjp_vFSApG-_WZj9shFlbt4U
Message-ID: <CAFULd4Yw4DSYDUsUGRWndLeDNVvm56o_Amq9JW36oFRtefJUBQ@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,infradead.org,linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linutronix.de:email]
X-Rspamd-Queue-Id: B4D4126786D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 5:32=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Mar 11, 2026 at 4:55=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-03-09 15:52:34 [+0100], Eric Dumazet wrote:
> > > > +void ericeric(void);
> > > > +void ericeric(void)
> > > > +{
> > > > +       raw_cpu_read_long(this_cpu_off);
> > > > +       raw_cpu_read_long(this_cpu_off);
> > > > +}
> > > >
> > > > I am guessing __raw_cpu_read() is forcing the asm ?
> > >
> > > Might be a clang issue. Oh well.
> >
> > So the difference is that with gcc we have USE_X86_SEG_SUPPORT and with
> > llvm we don't. This leads to two asm statements with LLVM of which only
> > one is eliminated. This optimisation origins in commit ca4256348660c
> > ("x86/percpu: Use C for percpu read/write accessors").
> >
> > __seg_fs and __seg_gs is supported by LLVM but enabling it leads to ton=
s
> > warnings and aborts later.
>
> Tons of warnings is just due to clang being picky and warns for
> duplicated qualifiers, such as "__seg_gs __seg_gs var". This can be
> fixed with:
>
> https://lore.kernel.org/lkml/20240526175655.227798-1-ubizjak@gmail.com/
>
> > Is there something missing in LLVM? The generated code for
> > raw_cpu_read_long(this_cpu_off) looks fine.
>
> Yes:
>
> 1. The %fs: and %gs: prefix does not get emitted in inline assembly.
>
> 2. An internal compiler error when addressing symbols directly:
> https://github.com/llvm/llvm-project/issues/93449
>
> 3. Wrong named address space for anonymous struct:
> https://github.com/llvm/llvm-project/issues/119705

BTW: A related issue is that ASAN fails to handle gs: prefixed
addresses. For GCC, we have had to disable ASAN instrumentation for
all locations in non-default address spaces. With asm accessors, the
access is hidden from ASAN, and the memory access is not instrumented
anyways.

Uros.

