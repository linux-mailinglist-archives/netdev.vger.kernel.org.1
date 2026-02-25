Return-Path: <netdev+bounces-260782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLi4L0mnnmmrWgQAu9opvQ
	(envelope-from <netdev+bounces-260782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:39:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E719398A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D933053BA1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A611F03D7;
	Wed, 25 Feb 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRqrFHkM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C6168BD
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004598; cv=pass; b=qwWC+Yw9Ds8XYSWRATtDlfpRwDNWaOIBS9u0Gg0eqydFXPGJ7nFSF7eFMWHovezj+PsqqLG4eJFVkRtbngYI4Sx79yiT6S8fo5lgdYbjdnZbDI52zt8wkkmEc+dXtfo1c/X3LDja3K1gSmsYO0PJ+CkRIlXOz/dHFple0a2Oyx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004598; c=relaxed/simple;
	bh=zlvttmqrIQydUvy/OW4M9oFwpUji43WeKa2olTfkb8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGJhJTkZPAIEUyz0+d4pp66jfeJa73tyfylo/l2bdQY2HuDYnBYTx8KH62MIT0FgDt1t5uoQ7KRkPgJyjUGTHbdfYaQ7bNRe6sInFkOkxoWMmeCazbzSUtwBTzf7OrstBt2Bi5sXGAHOUbXQGQxxbESCsmk8QkKrdDlSbD8Vfvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRqrFHkM; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a3400f30so5397891cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004596; cv=none;
        d=google.com; s=arc-20240605;
        b=XuxV+pjPg3DCb3d1HwggnHw1NiwfOBGXEYhV+Q5Tws5s9Demj9XbDmQ0fRBulNPj0T
         S27Pi24zLI2nQFBgylBVtXSwOe0HflcHtp9VgtmTrF+DklU8ssWw2fY85LpB58R3tjJa
         rb85ZvF8gBxG/Toagz8ECR6sHUj/nagTa3xw/DgV7ikbgD7H7q1s0TNhZaGmuC+jrINs
         J+OpyU+I7H8hKf1Yy+r5FvIbgVSuDXdq6EUP6ycWO/jwuZbfVfWoNljmVfAoHVM2qD8p
         SSa0SRT2C6ZSaJDOS3cM/T6Zwn/JFGWg2/PZ3VAaeo6kAYTvut17TnnznVHccSBTqLYv
         lWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9cRhowXyGkMAbItm3z5r38qOFU1s3Sw3qN2DNxicus=;
        fh=cASGKQMvTd+iBbtw51hUCfhMnq5wdJBE+bvfCpVR36I=;
        b=WaNpt+UISKoiynj6JMLRFB9ensZb3ouV0XBp6DYyAt1JHdiuAFuVXM6Fojc8AE54hY
         DPgyzl3K7M+p9HBL9Bk8TAIS4wL3PRmUZDfH1tIx+JHi1hpAXAByVLR9qc3zQF/2zxBJ
         q7YTS7EYxxyF/Jxk+uPnYR68rZt7dL4EMoWJsHns9Nah15Rnaip+XPCOtPlwdKvTVmcu
         SuH2F+RtUt6mNX2KCZaUutEQUkABTcbQSYJa92oQtvtLt75FifuyRpkSpEijlLxeBU4x
         L3nsM+pd3GKMMG14hctfCo/fuTWSv4vEfuazqcXjPb4fDdkYqtwC0/BN+IwlHtTtoUSH
         JRSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004596; x=1772609396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9cRhowXyGkMAbItm3z5r38qOFU1s3Sw3qN2DNxicus=;
        b=PRqrFHkMl2ud/lESvKTYj8H05t9Mt6WpShJAa7LpUs6ITLZ+xJhh9JIjsZ3LA2LG+6
         yNdjf7dBSgs+vTgwM+LnVXy+VzZbYcDvbS+VozOLq80SPyvU6BAd7VVyAd6D0nhTwRsN
         jfJciheldA7xZmqaf8g+gbtZD9K9Vs5uTveFHXhmywbWOkrrii7i5Y3Ok1Lkv60CwCBe
         hWj1q4mgAyyS7GlPTmSNJOP4ni+tEu8uPQHRxr1ZKwG8TRYS8TB3Fk299g/mOI2hp6ia
         KmlOGwdBzY3ArGKK8fBYIJuFIhVxtgq5nuvjUnF3zO9q99wH9uIpvqbcmyL+1lrPIJ3E
         IDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004596; x=1772609396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9cRhowXyGkMAbItm3z5r38qOFU1s3Sw3qN2DNxicus=;
        b=Exy3Glx+jQTWF459Uvf7vnqBi+qHkrNrUbBL3bnyX14V3nPmXv/Ic1eVwDYndpwPsn
         WvGHIjJ5zOqFNyJ4UtgBMQ5qEu8OA2t5Evx0TqxRnIjbrZV6nLNp4cHEb4YBGFaSIgAV
         a4lYb7PjKgYa2cYgm9MC4kDmHrQpRvYoW15hwBHlDeZsX2KCjOE7JOPMmqPSNvawp29X
         to/u7WGtwJ8eel9aZdghNupTc9gmSYYAa4yWHsLUJnvjw1KAvXMhKS9TfQVRPY29E55E
         hTaYsernni6seqYRjfhW90ji8DDm8HITL0lhLxXOxI0DQ+ZlnqA+/KFoZjFIKQ+4fsjB
         CVfw==
X-Forwarded-Encrypted: i=1; AJvYcCWP3eo++WIezHHVR8axFafz5lyKN00vaEvkvu4Ey3pZQ4TC5yU5c/LCd8OFywqbiSN3dEmxgTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92bTZhWqscv7VTy+T+nIf8Dme3bCacAk6EdB9QhcD80UFLmzr
	VdJotumWyGynds+/WHElTp7J+YMy8ZxTuU2OehDdCbEem9LyY98kVgPkErTBLBa92y5fK9/fb87
	xUW6ryHKRpUQEXmAHUSbHp3A0odbYcFpDZzNCB4vb
X-Gm-Gg: ATEYQzzsuEfmikcBl5ir+CWCTm0VHWf6ZRO/KmDEliZNKa0zbfwFiVwN+yk+kaKXdLM
	oM3SV10JkFKGMAAsuQ47VTKTbffg0asHaZPR6VZsgSqeA/JOrdYCrKxCjAVz/pqbNGvv7f5FxEe
	HKDpd3ZgpDi0W2tJ0PJiBuG2yI2ghgbPdyChfdtzEaCKPcDbiXHcteu/U4/pZCpscmKwe5ZwrBb
	6GtAeRM7fDhsdoZSz+ncnflppgH1hdJtrII0SkKP6c7qiJFQF2MxlUUbKmGzbFUiCH2ZimwtY2l
	2Iq6uLMs9nHoya56ZAKv+17gEJLKf6KjkmnWbNqtPnJduzaIhBPr
X-Received: by 2002:a05:622a:199c:b0:506:6d1b:6e88 with SMTP id
 d75a77b69052e-507365ddc8bmr32658211cf.27.1772004596042; Tue, 24 Feb 2026
 23:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225033216.601205-1-edumazet@google.com> <CAAVpQUDMTefL+Rsb_9FnMFf5o8UsqhxpZ3Vgg56_TDQQbPHCRQ@mail.gmail.com>
 <CANn89i+oE7SpzKq8cVw4J=0DTHvQt2Ou_v=cxmNKhCviK7fXRw@mail.gmail.com>
In-Reply-To: <CANn89i+oE7SpzKq8cVw4J=0DTHvQt2Ou_v=cxmNKhCviK7fXRw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 08:29:44 +0100
X-Gm-Features: AaiRm50ZetHdssHl-R5pbwmAao6Ve4jm-9S2e3vIvuA1kUSNNZi-8F5OYgqxCUw
Message-ID: <CANn89iKfD5-MZUcCFjnkWV1E=RwBVf6T+sSFRv+zEiAMEc46Sg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use cmpxchg() in lock_sock_nested()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260782-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 298E719398A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Feb 25, 2026 at 8:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Tue, Feb 24, 2026 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Add a fast path in lock_sock_nested(), to avoid acquiring
> > > the socket spinlock only to set @owned to one:
> > >
> > >         spin_lock_bh(&sk->sk_lock.slock);
> > >         if (unlikely(sock_owned_by_user_nocheck(sk)))
> > >                 __lock_sock(sk);
> > >         sk->sk_lock.owned =3D 1;
> > >         spin_unlock_bh(&sk->sk_lock.slock);
> > >
> > > On x86_64 compiler generates something quite efficient:
> > >
> > > ffffffff81e96100 <lock_sock_nested>:
> > > ffffffff81e96100:       f3 0f 1e fa             endbr64
> > > ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,=
1)
> > > ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
> > > ffffffff81e9610e:       31 c0                   xor    %eax,%eax
> > > ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x1=
48(%rdi)
> > > ffffffff81e96117:       00 00
> > > ffffffff81e96119:       48 85 c0                test   %rax,%rax
> > > ffffffff81e9611c:       74 33                   je     ffffffff81e961=
51 <lock_sock_nested+0x51>
> > > ...// slow path
> > > ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d25=
70 <__pi___x86_return_thunk>
> >
> > Wow, this is interesting !
>
> And using try_cmpxchg() might remove the "test %rax,%rax" after the
> "lock cmpxchg"
>
> >
> > Should we use __SPIN_LOCK_UNLOCKED() for the old
> > value too ?  Looks like parisc assigns a non-zero value for it.
> >
> > arch/parisc/include/asm/spinlock_types.h:5:#define
> > __ARCH_SPIN_LOCK_UNLOCKED_VAL 0x1a46
> >
>
> I will take a look thanks !

WIth this diff on top of V1 we indeed remove one test.

diff --git a/net/core/sock.c b/net/core/sock.c
index 2a03d1432111f2dcea9d700f80efb7b0bb4a47d8..86185f194d64b4eea0835ee0f9b=
53fda184c73cb
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,11 +3782,14 @@ void noinline lock_sock_nested(struct sock
*sk, int subclass)
        might_sleep();
 #ifdef CONFIG_64BIT
        if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
-               socket_lock_t tmp;
+               socket_lock_t tmp, old;

                tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
                tmp.owned =3D 1;
-               if (likely(!cmpxchg(&sk->sk_lock.combined, 0, tmp.combined)=
))
+               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
+               old.owned =3D 0;
+               if (likely(try_cmpxchg(&sk->sk_lock.combined,
+                                      &old.combined, tmp.combined)))
                        return;
        }
 #endif

00000000000077c0 <lock_sock_nested>:
    77c0:       f3 0f 1e fa             endbr64
    77c4:       e8 00 00 00 00          call   77c9 <lock_sock_nested+0x9>
                        77c5: R_X86_64_PLT32    __fentry__-0x4
    77c9:       b9 01 00 00 00          mov    $0x1,%ecx
    77ce:       31 c0                   xor    %eax,%eax
    77d0:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148(%rdi)
    77d7:       00 00
    77d9:       75 06                   jne    77e1
<lock_sock_nested+0x21> // slow path
    77db:       2e e9 00 00 00 00       cs jmp 77e1 <lock_sock_nested+0x21>
                        77dd: R_X86_64_PLT32    __x86_return_thunk-0x4

