Return-Path: <netdev+bounces-265558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKyMEiXRrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0623A1F2
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B72623003EED
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8AA7FBAC;
	Mon,  9 Mar 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y965fEoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E43BED05
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064160; cv=pass; b=S8UczVV1zh6BjVq4bcaefQ5qX8Amab87rAT7tqqA2AelZUia7hp3INc/I2wFHubHr9ADcgpJoPYR3gYN1HuHbcevm3tZNOGnhJ1A3PiNjtTgcLWdCHqgt5kZiAiUv0Lfq07T4rzwg4gGainWP8o1Zvaonw2kSPW5VRU2aRa2r/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064160; c=relaxed/simple;
	bh=qmJ8yWcyKlJWNdkyNrEUCLckeECFCLJMFol+0LQbLyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pim9KPnY8e4G6VloxzPzBDrBo1HzMCLUb0fWjFsFsah6ZfCBE2gMqijnyHWl3dZRe3QgvU3Rdt01ue62FVHkYj4wMYES2acCAQTMZ49l/6yvKGXLUK2mke2pcmR45CUxoQ1KVOHU1ex413HEqPkFAglsovWC/4+XukpopFdukKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y965fEoh; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509006c070eso20763781cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 06:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773064156; cv=none;
        d=google.com; s=arc-20240605;
        b=X4mipkNCA7CPN7dvo8ar3Dj3ggIJl+VKa536x/eJrOU/S0KXoZ3tcgE2+NWiCmwFbV
         MBsi+ADBxCw6WEWzRXJvOAsZlfck16dErBkKxqPx8YH8L4ExWsac5wqboXLRW/go7UUD
         e2WonPa7f8MvLEuSwPnPQ3dHncf1ssnAviQz8iETTOorG8IVvY4eqJeFgw5ak2+W2yVP
         6fO6q24UuH8rU7M1m4Auc1mF3CTNU2I7KSDZTYC+StEbvKYDar7cusC+BgscVELkrGoz
         wrxLzVt6r0CufBrN/rhvfBUxvkvHNRUlzI5o+VHljYhBAhbq/TmnnYHPTUm+P8MumT+r
         0k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNp1Q4QjClPdUPSYq7I0yBZG2Zy5Dy7h66HjTmS8OpY=;
        fh=w4FjuWbVD7fChl2ClScQaAusCUH1Jd1VuT05ZPR+B+s=;
        b=BqfyTLAprc1A0CzWtL9OWGJqBZFnrwvjoyWz8cE8iKzOh3qe4wKObpuVN8XvTqmtGh
         jcHfCnYzv5SkxsmDxDS1eEFee++Q/lj7ChDmqJiFP9UI1KcV5EvGMqf/4z+gwmaapFPf
         tiCdavfjxYZ9Yh6mvpMHf9W4McwXAMegd6A71noOjhlSDeYhMdpPCP33oxMTwRwlz26L
         Az5OBTEqTUyfw9p3J+FYb2WoQ/OfiHbJBF+9ME0Y3FA5k0Dguy3NQaJAcel2U4thjSZU
         vcQ+JriCKGjQL+R5UfgYBH7thtimTquBCDCAFbAdQ+cacvmawK0hhO+CbShVQc3SzVwE
         1V8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773064156; x=1773668956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNp1Q4QjClPdUPSYq7I0yBZG2Zy5Dy7h66HjTmS8OpY=;
        b=y965fEohyXvZDmWKZBiGdurYN9Sf9n8Uzs4YtqeWfcsKzpv91TEL1MgZGflQbWqfqH
         aFSLA9L6VQ8HJ5+qACkCrcR5zTBWSM0y3jK3cLR2z8Wiu5pBI9MFjOqAbFlBkyNow9NJ
         PSvE27AdEMd+seR9lYMA8HclO37NzkTLfm8NKrMX2ODb47qno+5uMb3t9Bdqdk7ihmWz
         BFyo20PMTrScKY0ixGSIuvoro2iM1v+QWxFisqhH1ULHprIMmEKvScILTEWi5PyvT5fl
         0gMYsa+3aeREuf3Vnvx/7zyYBWyQoCTV4UEu4jENLc4G7LC3dky3uwcYdcJXdwpWwqEh
         df+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773064156; x=1773668956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNp1Q4QjClPdUPSYq7I0yBZG2Zy5Dy7h66HjTmS8OpY=;
        b=E2KPy2Lw2qZqWVFDAge0m41VYiR/ru81tvzX1snZXyxh0pob5MeScHiw4F9eRJPz5Y
         qQnZRsXwb/tzLXFRZT297zl2STSpRCcZgEbzOVjiuFt7tQn0q0K748FAbdpTzN+1n4Bs
         mfxihp/DYUkrv7crLVGQK5ORhwHNq8rfkYEGzFcXhUQWwqn9wp4jo+0C/sYDMoafF4J0
         MiO9VtoRi39WDZp7M6XtZxPaE2mfNs6ZoyjTIdYUuIDOh7zbdj2kTEEoVHMNnssqaUyX
         MwxK/fxKcbWRmGmtpMREz8I1+eLQrfor1+u5cKx25xsimF2OXBHESAiSk0YdQb42Z877
         2YoA==
X-Forwarded-Encrypted: i=1; AJvYcCVouZmKhzFqzoIjAXEoi0gJI1omyLt27T/0cT7Y2SwHcQs+T0uwInkJgO+hTpJuw3PGLM6dHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwe9KwoW1Zu8kuS9NbaQG58+FYrfsTvchiVZfTwLDwEhoevtAH
	xH8Cr6p9IJVkwDvF5TovxhoQhottxx9fUcS2V1rPZLzWXqxpVDOvTHBagPaSbicXATrAODsaOo4
	qdoP8/chsF47+SPCCIj72LG9QXMtaLVluf/rEjelE
X-Gm-Gg: ATEYQzzm8DX/aeq4BvY/CLE7oeyY5J0Cgxbl/5sgz7EaDrDYAoUZ8eXR1RM8xz5v//w
	VeKVyh5/aQmS5aNQn3Tmvv/Qt0fgEkonKuIed6HyjHkKNE0RfFjkDPrBceCuzEYb4h/a00CYIwK
	KdWPHUbaOl/1YjjiCBYkLi1rrsoYxmK+npB+EIrq8Kmtsv6lxDz/afuaeshL7CzIXHRZaqY8OM9
	KY+UeRPdl/c1AV/xRDOfnL60lBIxRAf32Fin1AfRphggxs4/xuGmmFRKsZRfFi/DiGau+VAel9y
	gn9vdPI=
X-Received: by 2002:ac8:7dc5:0:b0:509:1c90:e188 with SMTP id
 d75a77b69052e-5091c90eb70mr31419001cf.57.1773064155692; Mon, 09 Mar 2026
 06:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260309134355.GC606826@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 14:49:04 +0100
X-Gm-Features: AaiRm532DRiWlNXZEZMQzOHPOvkptGPx7jSZp6vcrfT7r-L3EFUNGs6O935Oxkw
Message-ID: <CANn89iKmqhKH6pUkRiSG3u6gtpDaPBTVj739dgf3dh8uZHX3HA@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A7F0623A1F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-265558-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 2:44=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Mar 09, 2026 at 12:20:55PM +0000, Eric Dumazet wrote:
>
> > diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> > index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be7b63=
27e0922a49befd8fc 100644
> > --- a/include/linux/local_lock.h
> > +++ b/include/linux/local_lock.h
> > @@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_=
t __percpu,
> >                   local_unlock_irqrestore(_T->lock, _T->flags),
> >                   unsigned long flags)
> >
> > +#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) || \
> > +    defined(CONFIG_DEBUG_LOCK_ALLOC)
> >  #define local_lock_nested_bh(_lock)                          \
> >       __local_lock_nested_bh(__this_cpu_local_lock(_lock))
> >
> >  #define local_unlock_nested_bh(_lock)                                \
> >       __local_unlock_nested_bh(__this_cpu_local_lock(_lock))
> >
> > +#else
> > +static inline void local_lock_nested_bh(local_lock_t *_lock) {}
> > +static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
> > +#endif
>
> This isn't going to work; WARN_CONTEXT_ANALYSIS is unconditional on
> clang >=3D 22.1
>
> How come that this isn't DCEd properly?

BTW I wonder if the following WARN_CONTEXT_ANALYSIS should be
CONFIG_WARN_CONTEXT_ANALYSIS

include/linux/local_lock_internal.h:318:#if defined(WARN_CONTEXT_ANALYSIS)
include/linux/local_lock_internal.h:337:#else  /* WARN_CONTEXT_ANALYSIS */
include/linux/local_lock_internal.h:339:#endif /* WARN_CONTEXT_ANALYSIS */

