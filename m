Return-Path: <netdev+bounces-265564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BklOjjVrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:12:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523AC23A4FE
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA32C30075CB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062C3D1CA4;
	Mon,  9 Mar 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/P4MUiV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DB3A784E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065501; cv=pass; b=WlNT8a+cAR2h0NcxkFSOvPJm60/qoqM2X1WcZJyHX+UEWTUyRZSJahAdGX3719xI41qTAR88T0uzDYZR4J4pi/f7FxD3id2enhev+gvDefP+kyPBEBCd4P3wYT0UyTntEvvAzm8IJYrISbN1iLTODGAhtaZzWqy43R2gggLT1nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065501; c=relaxed/simple;
	bh=Gmt2IhSQ+DdRbn0HHDY1QXYzL1n46E4i1+XgIiFgEGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzrkANcBOYZx9kCmbOcpchez2wB83fcyzD/dhZXGHWDsZhX8gN0ZyH23oGdOo/yAUGjBuE8sW6axi3H+KMihg+z+lNdO5KCTRtu90QEvfjA8h51PYNwL7W9MbiiyidTTtyA4zef/1yhANrdotAnTeqiJX+DqFodtDOMuQ58RLM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/P4MUiV; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069b3e0c66so165000691cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773065500; cv=none;
        d=google.com; s=arc-20240605;
        b=T5XLsTcYP31LTZC6hwpIzOCY177GixOD465SIEVTvKJ2LGRgbXKRw2HI9doKu+CNQO
         8s8binEkzw3Dd9n5G6yqW23iO6gynkInq+6VQgLUzEm8aW2VVJ+d4pw+GTYsxbBe4mDR
         9bNWXRx7xeYJlrMT1XMhlf8g/YBnv+uKlRrqDRWEoY+4qVzSg/Fl5Dyj/09eSNiM2HOF
         XuVfeNuApE9PwZKbus11E6ObVmL9loZPf6aLN0z42/a4eMu1UxqCeYtSLIQsLv6mfCnZ
         xlxxsKipZAWDOiQJxkcJMycgJVRYDSqB0xiPpg6kPw4dtIHq4UM+XT5A+d+cB3AllO/V
         7kIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Irjwyp9vJHQvlP1QVUxqnj5+cpvLgsfPnq/IDud2XM=;
        fh=1tWPLyKQRrJHpdO6ah1QjAwm7s9yr9j5OJcl1CCRU0s=;
        b=cy/uoffdfLC2zxyGaG/AXDTbgM7s6L+MPfAE5wv/v+PbnQQl100pzCsk0urq5j+zTH
         mHhvza/G/5JI+N9FlGUztm7IEfXvwdgvJPd+I9Q/RyyucmithynjaHH6RvbHBXpHfdSr
         bB59RI9e95ngIuxGDHPZ61sE/IHcRg1zFfEFivXbhcevzE1YoHUmtscSs0xCbWe2GhJ/
         re5+pB/75HEGJY1la13NxBpwokR4AIaQg9/BEnvHxwp/UzqQgTolqbGJgovRIa0gaXkA
         M9biJPZu3XEBP8pA9deFX9LmeH1oUF0IR5XzyaeWH4wlldCVJdc26lRfb6Ak7AYD47oo
         WaWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773065500; x=1773670300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Irjwyp9vJHQvlP1QVUxqnj5+cpvLgsfPnq/IDud2XM=;
        b=O/P4MUiVnyC+fSxzVfbXIOxq5IqOKmyeagM2WYAc5L56N0BRAvKygB1B1aGFyj4ljO
         OX5ai8s1PR7ohd0z+VwfpUaoC93Be9uQR8g1tdjPiU9NV5jOzqg3BwJK//fhEScb2F2K
         xpWcO0G2pQDDiYsFW/PHsfQFpMWusY830Kq43l6r4pUzfFkJvtTmCBN/t3Wlw7PCn907
         lSs7/23qzoWLTu6qqgdYogn3FhFJ4/zT+dCTOT8MqA8B3UcJ99nRf1T0drhcqK/5kKWe
         ZdMQo/I7xMP/Jw4ouAZ1+NiBYqbrKgtCo+E+w2x9C7PJ7eX4qQn6PgY6pEupn1/wfAkd
         HYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065500; x=1773670300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Irjwyp9vJHQvlP1QVUxqnj5+cpvLgsfPnq/IDud2XM=;
        b=YStKLe3q4Iaiim7YP7XOXqs+rIvlnhIQefXouKgzxzzDIq1N29EdGp9a8cABJxl+7O
         qGhfERAVBtjTxlHIKLbNGqRHOnb0fP9c3hHylDpToGUe1BUjvQxcGtWIusYmfxgK7/jR
         BWJjgBgD5I1PdQT/OofBk693SlcCn4o/HU4vucIVEQ5tI1Chp7bUm9+lreOXSymbUuV2
         8Tmlw1oeufEiKqvCLIPXh0NtNjVMUX10hQTyjARYHjQIL7dz8h4d29Wdjd8ByyclE1dP
         nDjq8M3BuAoAWBvfQBmbNQEZlNi8Hl/D9bWOef99BEl70Jg/hHGwUcm34CGHJVwiwGDP
         5xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcAu7Woi1X07wrlIw2BQ8HoLCZi252K4zF74ZGhacrF+h0vahnFUemlGARoVmBuhQ8P26BYCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDi3GWkJDoZc9jgKi8bqtZQtPu9W6TUMedNJP5e3VbU6Uu90D
	ShtUbMzb7egr6dP0kbDTcs1esO2Pr9JlYZu9SrQjxehpJrQpd/i5JloFPGesKp0QoatgOIFUPn6
	qYW+ZwN3w89+lVPJMZMettnYcwrcQod8FrapCbsZq
X-Gm-Gg: ATEYQzzgZGUVOeKA1ISZpd9egSkRmGzVY6SQRQTgXFLIaJiDO8dCNGZGftc2gZd3Iu+
	PkkEuoFQHrOusWeR0gqdHYvwvYbhCFF5pzIdYokby4PQ6gidbnXnFtP7lQ2Gn7VmBpXP4Dw/rii
	z+dQ8jPrGB0N+D3hqH1vdjy7wQMuLw9qp6SgCSBPoYKj5SXdoeNSzzvMKQB+2g11Gytxl5CYbdo
	SttSkRaiBs+ir5o9+u63B/TNJfeYmAgK+/BKW4H+pa3x+0G++sbvxHGEBsY9N3U06HE4lOa54ye
	Yp960LE=
X-Received: by 2002:a05:622a:1303:b0:509:1554:77cf with SMTP id
 d75a77b69052e-5091554794bmr55116321cf.20.1773065499025; Mon, 09 Mar 2026
 07:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iKmqhKH6pUkRiSG3u6gtpDaPBTVj739dgf3dh8uZHX3HA@mail.gmail.com> <CANpmjNMi-J3E=ZjLOnZVzs6iNDpTxUik6G07fbph5TvyjDpSTw@mail.gmail.com>
In-Reply-To: <CANpmjNMi-J3E=ZjLOnZVzs6iNDpTxUik6G07fbph5TvyjDpSTw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 15:11:27 +0100
X-Gm-Features: AaiRm52coincgTVRjdxMGQFm8vHsd-Ce_5smV2zWc6qadZF7ma4i88OpIBMZhAg
Message-ID: <CANn89iJ=uDWXTUiJwTA9mXA1FLUJarH0AFKrN_7meeMTu4mkSw@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 523AC23A4FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-265564-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:06=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Mon, 9 Mar 2026 at 14:49, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Mar 9, 2026 at 2:44=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Mon, Mar 09, 2026 at 12:20:55PM +0000, Eric Dumazet wrote:
> > >
> > > > diff --git a/include/linux/local_lock.h b/include/linux/local_lock.=
h
> > > > index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be=
7b6327e0922a49befd8fc 100644
> > > > --- a/include/linux/local_lock.h
> > > > +++ b/include/linux/local_lock.h
> > > > @@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_l=
ock_t __percpu,
> > > >                   local_unlock_irqrestore(_T->lock, _T->flags),
> > > >                   unsigned long flags)
> > > >
> > > > +#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) |=
| \
> > > > +    defined(CONFIG_DEBUG_LOCK_ALLOC)
> > > >  #define local_lock_nested_bh(_lock)                          \
> > > >       __local_lock_nested_bh(__this_cpu_local_lock(_lock))
> > > >
> > > >  #define local_unlock_nested_bh(_lock)                             =
   \
> > > >       __local_unlock_nested_bh(__this_cpu_local_lock(_lock))
> > > >
> > > > +#else
> > > > +static inline void local_lock_nested_bh(local_lock_t *_lock) {}
> > > > +static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
> > > > +#endif
> > >
> > > This isn't going to work; WARN_CONTEXT_ANALYSIS is unconditional on
> > > clang >=3D 22.1
> > >
> > > How come that this isn't DCEd properly?
> >
> > BTW I wonder if the following WARN_CONTEXT_ANALYSIS should be
> > CONFIG_WARN_CONTEXT_ANALYSIS
> >
> > include/linux/local_lock_internal.h:318:#if defined(WARN_CONTEXT_ANALYS=
IS)
> > include/linux/local_lock_internal.h:337:#else  /* WARN_CONTEXT_ANALYSIS=
 */
> > include/linux/local_lock_internal.h:339:#endif /* WARN_CONTEXT_ANALYSIS=
 */
>
> Even if enabled in Kconfig, our make rules set -DWARN_CONTEXT_ANALYSIS
> for translation units where we actually want to compile with
> -Wthread-safety. So WARN_CONTEXT_ANALYSIS should be ok.
>
> But for !CONFIG_PREEMPT_RT and !CONFIG_DEBUG_LOCK_ALLOC builds, where
> we build with context analysis (which is purely static, no dynamic
> overhead) we should be able to get the same better codegen as well.

Ah ok, a bit confusing ....

