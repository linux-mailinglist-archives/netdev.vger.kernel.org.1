Return-Path: <netdev+bounces-265562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI+WCf3TrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF023A435
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F833009F2C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F03D2FEC;
	Mon,  9 Mar 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oE7zNPK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5F3D1CA7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065170; cv=pass; b=CzHHDXDmLNv9/i44vRF1uDFPSSIO3jys5s5PwNkY1HxBy5f6m6H+CGH1beL34c9HjC8izEuVgzBOns69igtvtJe5cVzcyUnKh/4/cUHyzIA36cNXUAbB/68L4LrFRojMcSoiPaqYt2VvsjD2pq4u6VRJxQS3UDW2XxTa+cLqCco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065170; c=relaxed/simple;
	bh=EDrtdSdvhbbGJbxEgho956YbKacANNo9zs8Bz8kde4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boenqKEjtGjDs1UobH/iFXgQbZxmfW/oW3jL0u8p2YsKocP/CaeNoh4I1eSTv4DMbxTcJGhNmCyxHOgEb1RII5jOUWcB+SHAubimZ73kHfb6fPnVz7dJ9WrhcmYPeFng2f5ktVAqVzniOX/11pz2x6hjFHEDRIJBUwfdO5w5L6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oE7zNPK6; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9694so7222684c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773065166; cv=none;
        d=google.com; s=arc-20240605;
        b=bXYp4H8KmP+ADMdYykjIgVdKItoVcGts2tXWBLA/gfo2QygElGIdciz14/cjb3NTeh
         a1dI8MXJmTsZS8P0vONy5hkjiuPUEhfJowfrwtK322sGmtXZpMxd7jeGE6TnMTmTg5j1
         bfTq8+IjpbtlDxo1zLoR98Nm15ZaStMR3ERTC2lQ3gXHZSWde1brdXtcZQT0NjJC8qO8
         eNh9dJnDNeFx+WlPPksK9T3qnlUjHmVTAaFlv3YI663TJI+tysTNbYi3dcmQidJj+O0Y
         TcWC+6t7xy96JRMq0jFFPtSu5RH61p87+zJKIl3o1wlVpDtrplJFWayq+HmKan+SHjfW
         60zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J9tEkQRBAqi4shGo0VGbBaqNg+2aL3YU2WjpSdnZw0=;
        fh=egngfQq40JC/WxZjOrH2u1CCy0Ej7U4B4WhWKg8C+iQ=;
        b=D6rDFwEyH7LkZKMRBdFMEqMovpP9Uj/jytawWVTj7BvLHziE3Mgk+rjrnRu6pbb7Vt
         cj5dSeBvVApQlAnhlwjSvLlDLRLOsZ3Vtx8ppuQqShNK5+P0/9Q0wZzqsn6Iaiv1neeh
         AlHMJEbcB50JXl+n2TCe4PFg6wjamQwaKA8n+CQhEBzqf+woS6iPsZ0/ahGaGKAv399q
         f3JKzXS0PjMQb8GblO/SrXIapjXzr+70MOQbjlTh+XM70BriW8LhoYipjVaHxuq6x/AK
         dsiK6A2Enxtx4LXYbUgGdI8FqqGTzjH1d2ATzxJM+GGMXKqGAKEkRq/nGHRhhg0oBWRt
         eRKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773065166; x=1773669966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J9tEkQRBAqi4shGo0VGbBaqNg+2aL3YU2WjpSdnZw0=;
        b=oE7zNPK6QGh7jHw2xpcPaRD8sVETGswKGFvUrJ0eAnICIGGKXiwdRpU4mbbnd5MhdW
         sbdWlPY3cC+Vx0/+pE9xyl0jpzFM2hTwsbOE+dC4Q5myPJiHdV/HiYihaq8Xkskvpnz+
         b/b+k43Kk+C7aWrqxG6R4f1irBMNF2eCuIhA8mZ7vWP8ehy9gUidk1/3gbC2/xwY+VcY
         ubLS/OuXwj6NyM8uyJPpcNNyzapb7J6zg+cvQCpuHLkg/B+Gs+W56oKkbjx+10dJS+Zk
         /NXttFmAaZuoZl4SY/2luGS6go5eBUQIKE25/FZCTIboDyclf+wDDl2gDD8jZCimHoPc
         7Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065166; x=1773669966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1J9tEkQRBAqi4shGo0VGbBaqNg+2aL3YU2WjpSdnZw0=;
        b=RlsxA3Mn52zU6VLq/OITX8U6tVIn/SGEQwuXHTwLL+MqC7JqI6Jt3XYLYxqkF1hqTn
         vH8Bv2Wt45nRoMHX9qx+cBFB1zSvNqnKq5Dl9BMQNJooGkJFRFnsuqcI/ri3hw7B/cH6
         jBh2NOtCLySIoZD+eQyQd4wvvSSHYPtlHsV3ddqv9f+PXMph6TBOtE9u2CveXjsaLQxn
         FU8NKDrOiMCeNy9L1nrZBpOogNuzIdlo5Kg/j5DEg82cOVHX07LtF/zrihXzQY+z8sF0
         nlsGJNCFGjMl6Y/7iJshcYqCv6FVMK2iXieVqSLxibcVs+jpEpaWdDNSFDa8jqnZICK5
         dQRw==
X-Forwarded-Encrypted: i=1; AJvYcCWCUHglC99xKAAw4YsOrLOYdTal0r5GOc//sqvpfufARo/X/iD18oCaLXcURQftn6wGu+RIaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MDB5Qaepe6JIAWQLVu7yLeCb0Wn7yBRXImt3HGoRIgi3kgjj
	2zVMT1mkH0eftNfh3rhGGHuZmQwW1fKHhvsbgwPq0wsuDQHvO7GgZlq3SE/V/GS6KymJs0kiCK5
	/D6IOOl8AtpV9O2MBzfQZoRv2oxWLNeAuDkg4ci8jR7CNUpFg8iAKopSmfE0=
X-Gm-Gg: ATEYQzyu26rm6CWXfOv5Y0LgoyTkJcc5UtMKJioqELewSf7v+U6896IT1X/EThs6NvM
	C79OhWiuikZRXGlXEyXn46hZ51VN+dzfnf/B/SjJDWgdvr/tW2SSYahEC/q6+AI0meK6B/MDPC1
	eLgXSlXwvTyj7bogh9PQqpRVyYsWCpjgNS8xHkhbLPbMaienXR2SJ4XhZUW78XOibFZWKj4/XLE
	9N7kRanYGQfRR05+hSQC+Ej1HkneMDfk3EyYz27wXnW3S/49KxomyyiFwp0l9OWgVk+Tv3efeY1
	Sl9RPk1JPc+gBjOfTMHpOx1eeKl10C/W7kG9mzM=
X-Received: by 2002:a05:7022:6182:b0:128:d51a:5161 with SMTP id
 a92af1059eb24-128d51a5664mr1829406c88.27.1773065165905; Mon, 09 Mar 2026
 07:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iKmqhKH6pUkRiSG3u6gtpDaPBTVj739dgf3dh8uZHX3HA@mail.gmail.com>
In-Reply-To: <CANn89iKmqhKH6pUkRiSG3u6gtpDaPBTVj739dgf3dh8uZHX3HA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 9 Mar 2026 15:05:29 +0100
X-Gm-Features: AaiRm53m-8mHo_6z78hz0h8e4k44SR9EH_2PhaI5btcezPMvBCujmBbel4AtwnM
Message-ID: <CANpmjNMi-J3E=ZjLOnZVzs6iNDpTxUik6G07fbph5TvyjDpSTw@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 91DF023A435
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-265562-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 at 14:49, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Mar 9, 2026 at 2:44=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Mon, Mar 09, 2026 at 12:20:55PM +0000, Eric Dumazet wrote:
> >
> > > diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> > > index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be7b=
6327e0922a49befd8fc 100644
> > > --- a/include/linux/local_lock.h
> > > +++ b/include/linux/local_lock.h
> > > @@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_loc=
k_t __percpu,
> > >                   local_unlock_irqrestore(_T->lock, _T->flags),
> > >                   unsigned long flags)
> > >
> > > +#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) || =
\
> > > +    defined(CONFIG_DEBUG_LOCK_ALLOC)
> > >  #define local_lock_nested_bh(_lock)                          \
> > >       __local_lock_nested_bh(__this_cpu_local_lock(_lock))
> > >
> > >  #define local_unlock_nested_bh(_lock)                               =
 \
> > >       __local_unlock_nested_bh(__this_cpu_local_lock(_lock))
> > >
> > > +#else
> > > +static inline void local_lock_nested_bh(local_lock_t *_lock) {}
> > > +static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
> > > +#endif
> >
> > This isn't going to work; WARN_CONTEXT_ANALYSIS is unconditional on
> > clang >=3D 22.1
> >
> > How come that this isn't DCEd properly?
>
> BTW I wonder if the following WARN_CONTEXT_ANALYSIS should be
> CONFIG_WARN_CONTEXT_ANALYSIS
>
> include/linux/local_lock_internal.h:318:#if defined(WARN_CONTEXT_ANALYSIS=
)
> include/linux/local_lock_internal.h:337:#else  /* WARN_CONTEXT_ANALYSIS *=
/
> include/linux/local_lock_internal.h:339:#endif /* WARN_CONTEXT_ANALYSIS *=
/

Even if enabled in Kconfig, our make rules set -DWARN_CONTEXT_ANALYSIS
for translation units where we actually want to compile with
-Wthread-safety. So WARN_CONTEXT_ANALYSIS should be ok.

But for !CONFIG_PREEMPT_RT and !CONFIG_DEBUG_LOCK_ALLOC builds, where
we build with context analysis (which is purely static, no dynamic
overhead) we should be able to get the same better codegen as well.

