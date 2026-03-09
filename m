Return-Path: <netdev+bounces-265567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCGtFmnYrmmKJQIAu9opvQ
	(envelope-from <netdev+bounces-265567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:25:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD6223A7B7
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4538B31E1F01
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B233CF66E;
	Mon,  9 Mar 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbyhW1le"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724D3B4E96
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065918; cv=pass; b=LJBIzuY9HYifhFc4UrbCcRajEhlso53rKs0AUMMqWsPbkU+6gFBCcZ/Uvlw1+71TMW2RED2L2ofcpy0T9HqvLC5bf/ZhTZZbk0LyRAwHed1MytdNiCAX4GuVbmR0OEtLKhcj6UnU6QmQ9LHYWc7Za6zAnm0zorKVugmtvTz+rrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065918; c=relaxed/simple;
	bh=pXApf3ivqeAKsxMfGi4H6L6RX5gAiJ4RCgXo4mAGGG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmwNYeo5ROpH0Yw0k4bW93lg3bxmCXnPi/o3XifpOgO41WbBiAVSdywx5bQ/FXLHqVLtHYsaW17jKRIo/TZd0hF3zkzDzVd/jq3wlXj6i7Whdl8ESubjM8OrbjK0+s5rT8lrj453EGwGuHqt/r/sr1BU+hcipyc1zdTXbYTgzY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbyhW1le; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50919fc3a14so12791301cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773065917; cv=none;
        d=google.com; s=arc-20240605;
        b=itoIYrhGhC0SOZGORnQpSztedGxkEPdEcGyvnRf37yxNdqNInDCjbdPoK3A/QKboEw
         rmKVY8qHHvUtJYmbEB9w7WXGtXgvHGPe91rLVX3074wNwd5gP06ggeI5rdtrrJMJ/kp/
         crBq2NpOqPSqMVwV0E8uR4/SMm9eAloiAnVZfGaXwZMHqb+JqCPVGP9aBlhdiorpfUPF
         PgWtp6F3/VAmiTapzFXIkGteH6ZnrQkNPrp+87Hh3gKkVJMSA5J0Lw3rkEF/iTdH4dJF
         MSZKDl/whFDaIIsukiHaVuCmhV5wnQT44T60tEXLEkvd0zEKJwr66+zZaYAs7NnJNbsG
         3KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iPk/1KZXvsYmN7WqqIwr0XmaqxpBnF1UEIKXnct92mA=;
        fh=9NZLpaR1HtBbiQpAKClLJRbgVS7efNaOMVm0TB+feNo=;
        b=ELzfs3xJAv7ngwmfkcS95sJTks2SaJBG5P6goph/mdAjUYNTEBUcyphUg3NBaQ2008
         FuRt1fdXPjUldJNu460ZSrN3PjiOUH6FAzGRChulF+3L62mV+b+5aknQl+iO6H33DBz+
         E0T7Set1eUVbQupdCt34lagu/yC4EAqhqjvChrQhMkRgIgrRGAk37eZyl+Jyc/EvaVtN
         AZmfgw3C+cN6oZXx5+su/crfnFGvEBbCg7uO8lEqtt+TpvpwApr6Ropd7YbONmDb0aY1
         ogMedtCapqnhlagMnhVaIVcols6W/lthgapYIR0DGRfZazbO7U6e2USF2sszOHvPvrVj
         IeoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773065917; x=1773670717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPk/1KZXvsYmN7WqqIwr0XmaqxpBnF1UEIKXnct92mA=;
        b=YbyhW1leQbAbnvPA/0WyH9F/hBD9Q9cZyyCwxmL8N3fw0DM0kO93uyeDU9HqS0Ugvl
         ZYDqGQa1IGep7vuzCgmi/FOhhhyulqOscwSuHv+3Y+9hJZRAB0JyKtiuJ2YKwRosGKh2
         s0RtmsTuO439vN5qjBkMp05fC9FfNvHezvP4OMW2uYNuwrtK5ieHYg1lnfAeJJ9ic/q1
         QBtd/I1gAYU/f/DPzNr22oU40NPIwrKfAZg6P3lalCjcbcbt+FORKr3ii/wOIbxcRl0b
         6Z1t0RjFXeJd6kvMJG0r+9JRZDOeBV9HnA3/RtsosYD/Oq05ryHjvSrXbJb3FnOKVenU
         NFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065917; x=1773670717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPk/1KZXvsYmN7WqqIwr0XmaqxpBnF1UEIKXnct92mA=;
        b=iZv/llymBTQMpHcXjBonzm0LEvJnNA7MvzDgt8HikSdDt7pPln6lemzJ/50iHPL37V
         gq4e3RNjdiX3XOMqNQahjI1stEbZa4oWd13ayI8IYxzPoYeeqEtU/MqaH8DhEP8Z3ZjA
         SM9eJIGNIpE5teVA1QqYQX6qig0+YdpRsa9adtzj3JLUirJx5vy8oFpM4vGJwHv9N1RI
         BVvH7g2UFtMSmaKWpuPbeeF+oE6VOhWMGuMP7gt9T81+OjbdoGzVxaeZo6MA2yLOjPRm
         nzIZc5FiHUZfg9J73xHq6zvAJAqTuiVc6vI6S7b98zp3yXnhCAV+HsoV6aP505vSKDyh
         E2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXPQhRCP0HcZqEX6Reksu5f9MW78g+al77nvbyfJwPt2bQki9RBG8BdyWJM15cgaP0oRNnRhKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2RrT4HgzGvVXG3oVwzQGnqd/X9AFfNyPcU+75SeS/3vFSmsm
	a5sBsWd59pUCmXmwYmXQV97rUJ4kUqJpDsqnXeVSHn77mv0MqQ8FkqCHbxft2M/dD/+yXX4AkXC
	AjHzs8AExTIIVmgRSvlPCUctKO1Z0v92zvy9664Jt
X-Gm-Gg: ATEYQzz/iJO0roqVZjfGs9lHuU4QCtSUDIhOEJumkcF6joWG4eIRAYWKlwfPlO18wfw
	TzOM+m1dQQFp6MPQQA4Cn4R785zax8JGjX0CPdYS7BIpt6NO/DOB5hZPYt8MpIG3sSN7Miasbde
	b4+2xEmeXqZlLkyy+UhG7iNrlwvmRIZbywHMhDIxMH+Aw2qI0TfGVXIsg4exljY3kmCg0BZ2fRx
	3BO+XOOU6L/JAa6VGRM0JINIoPBeQ9ryrYRg/IBH7pqsMztBC28KR36bBeom63o4cWerZy03KIY
	kgI2hh4=
X-Received: by 2002:a05:622a:10a:b0:506:1d7a:7250 with SMTP id
 d75a77b69052e-508f49a4a3cmr148744761cf.66.1773065915381; Mon, 09 Mar 2026
 07:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
In-Reply-To: <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 15:18:23 +0100
X-Gm-Features: AaiRm53p9-wu3eda_3WFiPrfIRjvD90DHLNSCsCr1tV9FXq2X6u4mCU7l32-23E
Message-ID: <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CDD6223A7B7
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
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-265567-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
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
> It might be partially done.
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a83d2a3c18de2965808442546c49b..50455951dc38668b0cbbcccdb=
2c5ce726e3c4da9
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7498,3 +7498,12 @@ struct vlan_type_depth
> __vlan_get_protocol_offset(const struct sk_buff *skb,
>         };
>  }
>  EXPORT_SYMBOL(__vlan_get_protocol_offset);
> +
> +void ericeric(void);
> +void ericeric(void)
> +{
> +       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> +       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> +       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> +       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> +}
>
> objdump --disassemble=3Dericeric -r net/core/skbuff.o
>
> net/core/skbuff.o:     file format elf64-x86-64
>
>
> Disassembly of section .text:
>
> 000000000000fe40 <ericeric>:
>     fe40: f3 0f 1e fa          endbr64
>     fe44: e8 00 00 00 00        call   fe49 <ericeric+0x9>
> fe45: R_X86_64_PLT32 __fentry__-0x4
>     fe49: 65 48 8b 05 00 00 00 mov    %gs:0x0(%rip),%rax        # fe51
> <ericeric+0x11>
>     fe50: 00
> fe4d: R_X86_64_PC32 this_cpu_off-0x4
>     fe51: 2e e9 00 00 00 00    cs jmp fe57 <ericeric+0x17>
> fe53: R_X86_64_PLT32 __x86_return_thunk-0x4
>
> Disassembly of section .init.text:

Same for

+
+void ericeric(void);
+void ericeric(void)
+{
+       raw_cpu_read_long(this_cpu_off);
+       raw_cpu_read_long(this_cpu_off);
+}

I am guessing __raw_cpu_read() is forcing the asm ?

