Return-Path: <netdev+bounces-265561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHgmBFzTrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:04:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F69223A3DB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E097030649D2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6B3C2781;
	Mon,  9 Mar 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNj452Xg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708F3A9620
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065016; cv=pass; b=XjblA0OpPls1YPYyPirawTdddcEf6qiBUTIavtGPXtEkAvwBRlHb+v+beytZY+sNLEVgKGuGxwty9H/RWhQLEnNNrC+lPrQPQrkGNTBCnoUTrwqpbsoB9KPUTo/X8fk2zs8lpQKdne7c9Vyam8GnCsUp/PPG6V4vzi0krwAXuTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065016; c=relaxed/simple;
	bh=QZCkZCrfW4fm2v9OTUEVnP/gMFSKyUQxcXvy3LMrz20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+oLca9FlPTNfiiyoKT1kEa/MkbkNO3B5XWPs0yJaDHck9JlG/BSgtR70u/5kksASwNHiOQsEoGh6cugvgU+Frt8mcDLkJE5M+Qi2Gt9NF8XvxXhE25pJEobEkuMJSLzyGQaNg1lz2P7/T+jdY44ZFhYfWohG8n8oQMoYkITffw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNj452Xg; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50912a097b0so6465571cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773065014; cv=none;
        d=google.com; s=arc-20240605;
        b=fEhFP5/iwKdWHBK9IQpKh29eEuMqsQjO55TpNSUCTZWuHC3fPJRiMefEnSAoDeo9YM
         BL+ubo4Tm8mqLurdFj2vb5hdNkreQt0IgtqHw+F6OOz7nAS2QozMTCk4t77gX/5/AjlY
         lZpDlVO52Ksm4DeZntWmu8jJKGfxGY2ecXH1YbjT1DQNbkDu7qt6tng0rcjdvmOZm+DE
         L1ebxDJu4c5OgguvxeTkKuJIhcJaweijETGjv2Wf1zvEQRLi31o/CW0J/OgBIP653sLP
         Ye8uBhm3JerEJjOgOOmu6ZID03oN5a4Bpujm+JlFY3ksYlFAWq2QO307/TDWUlpyk9GF
         MmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tP3OJLDDr2OUHQEXViM3iTT7Wundbb6RHG+uLmGrHfw=;
        fh=+CZido/grMPp4Ym7a7+uitWQ4NInC5bds9nt/x3EVDs=;
        b=BaWHooPEsdoK05o6JeVsLj7O+OCMUM7PK+RShzyEO1tVUCNJ6ZQ1Gjp4VvwQQDhP+V
         vVkLS/QYMC8KLXoOsimzacH9T8rD0oho1cVRJdy52D9fv/VyuoGclK80Zh/iqE4Zr15H
         Evd6ClvjcVQL2DlAV8WCc/ZQdTGkM3C0va/YT1tQixCX7Np8biswkkh0YadGFIajAJKx
         TYVMfO3gBwYyn2rzdpbtyvOS1pDm87CrsIoTb4KNoC1uetIa86wLInYrihdEuyEPjw/C
         eeFlJBk+8iG5HZiIA35dkYOaCUknL5RkcPruPtCh7eWvRS91gad2ygPY2eKc+Qx6ibPS
         DwXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773065014; x=1773669814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP3OJLDDr2OUHQEXViM3iTT7Wundbb6RHG+uLmGrHfw=;
        b=XNj452XgAu+n7PwdQiscwgssZWsgzsi/r6NFoS3XoEryc58pF/7/C6615zZaHCIg28
         yODEcNm9FLprWaqpxr1Z5IdPcvbe70vPEmpHsWMQkh09d+qS5Xxl3dAVqRFVQ7YTamjt
         /fff2GM9aqKlA5PSV4JRXvOqrbJONQFLp7I/xNf0z2pIdeBg0jZb+lAsh0xLkJQexUXh
         qBTrjKDSU1wqa0wVxKm4/B4MgUaQ8xPCFp927n9Mz5A0Rlrdxag4ACTCALP0UnnXbKGh
         2XO3j90EDG7etnEcLy6F4FqofV0zal4QOCqRQQaGwH3ufCmn3t6MmrSDNCdou6Op2AF8
         R+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065014; x=1773669814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tP3OJLDDr2OUHQEXViM3iTT7Wundbb6RHG+uLmGrHfw=;
        b=Y+SXdF9vYeQNzOWVOXLLqGpV9VoYZ10NfFZVa3NmrG7NWulq+UDOfZOLYAX1TrIuMF
         0ixaLwr1Rdu0cjWjLiImHV0us4QBduEORiBh1FCZ5B1UQaGcxel4CPIGBQzpJwmLGGE/
         f+ix3WHp3wOM24H+8xC7d3JvDF/kUiLoFtCRQQXYHuLENyxmG9cZ9pLCMlMCc4OwzAEb
         C1QP/drfP6zbD+lHefexnIUY168AWn10f4vsiQQVekAaAK1F9kEb1pqknDHpQ/PVzudd
         2CvZ7POkwfczbvxeAlKB1zZY4lHOlvV8tYJK8+mhfCodidnROqiTx1MMpg2LKeXVHrEe
         QRRw==
X-Forwarded-Encrypted: i=1; AJvYcCVFlRHWltv937eKk7tt9/oG1opPEQ9u4RuFLmCKYI4ApKVtKrGZ1asGkM1CL1m/c15BFB102Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTLV8SaB0AEZd1HSY4hCsPXdTQdNqNoN5/C/DdLA7EDBEGeQv
	7FaBVf37UPEltyHO9tforuf4S/bW3bKLYkiJqCRigBEgQEiFl6cZGZwoJH4D9PYCT/zElXGrXVW
	aDBcgiHC4Gtx8DJj5eYTgpnUpQTEdw14tDARL5mWQ
X-Gm-Gg: ATEYQzxVV71k8lVlUo2jbKvENYzJG4R6n89WkUT3q+kA/9ges75FvVq3r57udqj6xUp
	d65C4FgkOzsS4ziE3ilk37xdpWkybvupVxi3w2YEKRrGYZZ79A/tcC6a2tEdgsMBkMOo8TEdky1
	fNt1kO9uA8ArdQO4NqsVV2h6nFAZb04ryAjAXrEpiu2Wr9H0ZBrRyUmpZuEbbSaB0MjZOPBOj3T
	7EBM4wkF/Cd+4u7GR8VSpowxfqF7hC9Bjg01ysTLjAaNniXEynTqkGBDE3ySwXeJwv/oB2t0+f1
	ATE7tPQ=
X-Received: by 2002:ac8:5715:0:b0:506:a075:b247 with SMTP id
 d75a77b69052e-508f46e6777mr146583901cf.14.1773065013186; Mon, 09 Mar 2026
 07:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260309134355.GC606826@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 15:03:21 +0100
X-Gm-Features: AaiRm50H9C8shedHk8GMj7UCgFz3qnSnLC6ynJqvyVwxfP7DftkmVLGyfF4DLv0
Message-ID: <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F69223A3DB
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
	TAGGED_FROM(0.00)[bounces-265561-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
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

It might be partially done.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a83d2a3c18de2965808442546c49b..50455951dc38668b0cbbcccdb2c=
5ce726e3c4da9
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7498,3 +7498,12 @@ struct vlan_type_depth
__vlan_get_protocol_offset(const struct sk_buff *skb,
        };
 }
 EXPORT_SYMBOL(__vlan_get_protocol_offset);
+
+void ericeric(void);
+void ericeric(void)
+{
+       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
+       local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+       local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
+}

objdump --disassemble=3Dericeric -r net/core/skbuff.o

net/core/skbuff.o:     file format elf64-x86-64


Disassembly of section .text:

000000000000fe40 <ericeric>:
    fe40: f3 0f 1e fa          endbr64
    fe44: e8 00 00 00 00        call   fe49 <ericeric+0x9>
fe45: R_X86_64_PLT32 __fentry__-0x4
    fe49: 65 48 8b 05 00 00 00 mov    %gs:0x0(%rip),%rax        # fe51
<ericeric+0x11>
    fe50: 00
fe4d: R_X86_64_PC32 this_cpu_off-0x4
    fe51: 2e e9 00 00 00 00    cs jmp fe57 <ericeric+0x17>
fe53: R_X86_64_PLT32 __x86_return_thunk-0x4

Disassembly of section .init.text:

