Return-Path: <netdev+bounces-261392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGyHIAVjoGk0jAQAu9opvQ
	(envelope-from <netdev+bounces-261392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:13:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 005451A8569
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE4F3084BEC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF28D830;
	Thu, 26 Feb 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwXJ/TNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389433A1D13
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118058; cv=pass; b=T8gXRE8r9j688eIERsZL+O8P8G7Ky59kp+S3ZyU6JNzmnD43i5iBcpsTTJ05RfWecFB4jI8F1KXOble9837ctK+iQHIRP7f40BVK4ZNfWKItMKhFRkJYJhsvXA/Q+GKO0a0VbnSGCeAUEAIIfaKSNzKtDkuN0ZDI/xiYmMgT5fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118058; c=relaxed/simple;
	bh=JNnMiJju5QdanijX2DkdqzrfVYG15ENEV+hDxkyhxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAELQaQS7P+fAJ3YwkXuH+fIX1E31wXsrHDLqSswn4WwmmyL81o1EFlWDItFYd5Bt3pnhmGGowcYoBfeRxgnYOkMhrn5e9Z2VF1E+lzmky81nRFIdYsQpBanGdWbSil24XahmEah278rwK97BzMxZe0vh880NEvYDbhjDBqKyDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwXJ/TNh; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a6cf8242so6674021cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772118055; cv=none;
        d=google.com; s=arc-20240605;
        b=RD4sf6XsNoKc0htvdWSsoxo4heyohJraF7TXO0Vuhj+JvR/g57BUPwVmFK4ZhxciWu
         KeykrD4WgOFNyDpIfyKmNrYD5HeRmE9Tqr95721zK+Q1BuY6KSYNhim5KpOUx5Oppw55
         5v/oCXQP5cExBaELmVMl7ly6PwHzQw75BMpZJueidYfgNkSnsG23ads59mk5G/8eKMWr
         Z/r/tTwfFbXlD73RkG7+aUr4EJTF6rFk9BH93GGnzFLbkZ7OCJ0qdqeqPXNevbgyrQ52
         MGoZGhm5eJUJ2Wre8X6z89DEQ62hkCiwXVAZ/Tkav375UeopHdararPP8Rp/HSzGGauk
         fdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fDBHi6yZMjrS821WY5UBSYf/CSv/xvQn58gGyI0pSxg=;
        fh=OnaESdn0rJGIEVWGYAMbARDH1J6ak3jLv5ubtFK5PGM=;
        b=GbbG6MV74lOXmWxIzGjUOridFJfhc2fVa7Ih2vKG4VX+2qx88sY+6nZjk793t0yRx4
         t578+A0FvXPK+XwwhuzazmCJPdQkOCvPx+ssmNZGvSJBgnkZRQ4Up6eipyby4w7QIGJC
         UxKK4AdX4ykRJFDAmdQv52V9Xi1BLX1ziCEDzrEBJXqcpVFpylGNyD4S5vkwVE8Ov0Ws
         GHEvnn0GlTfKsroaeb61VtI9nJpwDaeSY+u/JuAWVXDepZFF+1zujcqc2qd2YcHcrSg7
         DXCXkpFewSXheNC1vibEgRZ9T4fG46PFYAvbXTHqsy+H99Z2gPTu/O2/fLFTawP+Z4y2
         TiNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772118055; x=1772722855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDBHi6yZMjrS821WY5UBSYf/CSv/xvQn58gGyI0pSxg=;
        b=CwXJ/TNhwzcFFP9oULqHD8CtvTeFFba/x5uNm5/oho7m9FfKWagIudysJQXRFxmKWC
         /8mLa0cwp3PDXqjpA8lZGxZVjslzJ3RbtCWwr/OpikzOYF5mQjvIf6LxEZvhZaA+e4iY
         CQTER/5UXkwtwv6ZOeNf93l0BnWyhMN1mrvLSC5/6Ss0J9tnEceERAHrbLDIhucqhMqk
         5OTsalF7hKZ1Lx4qBSIRtaOyXirfZ0FicEn6gB9a9vf6SgLCjLfDXk2piLFFOsNWox5p
         8quxrysc0Qap2JmlQp2YFrQblqh4M6pMDuOSLOS6MBT7pEIHLeT5F7T4KoneKN/SglH6
         v76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118055; x=1772722855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDBHi6yZMjrS821WY5UBSYf/CSv/xvQn58gGyI0pSxg=;
        b=jKEOmb8Eb+K4rXL7sgmBYuk9RDHfT32SFCooxqSlLFKdND43Yl+euNhEB9zIQe2WEc
         resY+M+wy8f0nJHmwQKVvsW0F9BnLhrHnVWEzLR/NaxFu6AKksMm7mLeSk8voUZniCUJ
         X5SkfdtrMiVxh+DCymfu+VNxZf1Wwrh8dy+GXOrUWZWx4tdgBIkineyCpLKjXdqgkaAj
         N+20L8nMcdvlnhJ3oIeVfef9n0BLZLDr82SeFOsj6bcMtWQwVDdCrZOovc1TOilQtFlF
         3rm9Do4chEwvbQAADQH9JwqKx6mD9oY1n5vpkiR/vJmyGY5qO4V+ki9EnNGY3r6c/sMK
         modg==
X-Forwarded-Encrypted: i=1; AJvYcCUhLcLJmqmZSEbMp0+n1yHPUToNWLuOrr3aa9t4EAFW1tmdaQVsUODGtLImIRoU5YnRC40/cCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZztIZmsKh5UZ+3sbGrstrMVRa+M+i8wrGmC6q7W71tiAIGk9H
	RWare4NqMyG4Ze5vjFIczypoUN1xjpFNwwf/nhGuwog2DosqVAqiYQuzcf8wMUf5fSsZYLXrOTk
	xxMYGF41MDmfaV9lTcR/2f5in8HTEkIo58+FUstdu
X-Gm-Gg: ATEYQzyiz8VjRmNUDmWLxc/jhEKw+l/Klurq1ggu23gk0Ky2UK48conc8nRTRplVq1r
	hGVCvpls7tAl422Qk/ElmFl+1zuNRup8R8jq3646sFDvD+S4EDTVWuETitpavwYxsJ3Fsm/Nv2x
	zOlNzsYRP+b2j1PaWCGBHI+1uMWAY5VRNCLlJgmt1aYgHQHEKhgZl0vHwVfTjYAVQqvtJzfdkvH
	s2hnPmcNQIKx18Y2GYqJkQ8VJbH2YJquItaYqXQa1ozoVTE2akxj/WI/sSqD1vZb5dylFfDOVNC
	gAxfC9TluBrr4mRyhFMAtYc1YIDiHhyeyETYuNVHJg==
X-Received: by 2002:ac8:5a87:0:b0:506:bd04:4a6f with SMTP id
 d75a77b69052e-5070bba20c3mr311502531cf.12.1772118043996; Thu, 26 Feb 2026
 07:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226111721.25454-1-yuuchihsu@gmail.com> <CANn89i+rJeZHoGna5PGWN31UGDO3jy1xx-rWs0SA23H6mU6qKw@mail.gmail.com>
 <CAPAzCqEtb9r6pP+A-RjnAKeLbHJJs3Cc3PuGcmNSR9GpaCLjdg@mail.gmail.com>
In-Reply-To: <CAPAzCqEtb9r6pP+A-RjnAKeLbHJJs3Cc3PuGcmNSR9GpaCLjdg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Feb 2026 16:00:31 +0100
X-Gm-Features: AaiRm52MxdXP-5oiz-lcB0RYshb3-sVF73Z4aiPYgg6GoJ4lwfj_lrudTwi1sIU
Message-ID: <CANn89iJH-RXQh=3ztsO1xA1uycDetkY7sogyNQTU7r2d7urmrA@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
To: Sam Su <yuuchihsu@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-261392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tmp.data:url]
X-Rspamd-Queue-Id: 005451A8569
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 3:50=E2=80=AFPM Sam Su <yuuchihsu@gmail.com> wrote:
>
> Eric Dumazet <edumazet@google.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=8826=E6=
=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:02=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, Feb 26, 2026 at 12:18=E2=80=AFPM Yung Chih Su <yuuchihsu@gmail.=
com> wrote:
> > >
> > > struct sysctl_fib_multipath_hash_seed contains two u32 fields (user_s=
eed
> > > and mp_seed), making it an 8-byte structure with a 4-byte alignment r=
equirement.
> > >
> > > In fib_multipath_hash_from_keys(), the code evaluates the entire stru=
ct
> > > atomically via READ_ONCE():
> > >
> > > mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_se=
ed;
> > > While this silently works on GCC by falling back to unaligned regular=
 loads
> > > (e.g., LDR/LDUR) which the ARM64 kernel tolerates, it causes a fatal =
kernel
> > > panic when compiled with Clang and LTO enabled.
> > >
> > > Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire w=
hen
> > > CONFIG_LTO=3Dy") strengthens READ_ONCE() to use Load-Acquire instruct=
ions
> > > (ldar / ldapr) to prevent compiler reordering bugs under Clang LTO.
> > >
> > > Since the macro evaluates the full 8-byte struct, Clang emits a 64-bi=
t
> > > ldar instruction. ARM64 architecture strictly requires ldar to be
> > > naturally aligned. Executing a 64-bit ldar on a 4-byte aligned addres=
s
> > > (e.g., ending in 0xEC) triggers a strict Alignment Fault (FSC =3D 0x2=
1).
> > >
> > > Fix this by moving the READ_ONCE() directly to the specific u32 membe=
r:
> > >
> > > mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_see=
d);
> > > This instructs the compiler to emit a 32-bit load (ldar Wn or ldr Wn)=
,
> > > which perfectly satisfies the 4-byte alignment requirement and resolv=
es
> > > the crash.
> > >
> > > Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a =
sysctl to set multipath hash seed")
> > > Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
> > > ---
> > >  include/net/ip_fib.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> > > index b4495c38e0a0..318593743b6e 100644
> > > --- a/include/net/ip_fib.h
> > > +++ b/include/net/ip_fib.h
> > > @@ -559,7 +559,7 @@ static inline u32 fib_multipath_hash_from_keys(co=
nst struct net *net,
> > >         siphash_aligned_key_t hash_key;
> > >         u32 mp_seed;
> > >
> > > -       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_see=
d).mp_seed;
> > > +       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_see=
d.mp_seed);
> > >         fib_multipath_hash_construct_key(&hash_key, mp_seed);
> > >
> > >         return flow_hash_from_keys_seed(keys, &hash_key);
> >
> > What about proc_fib_multipath_hash_set_seed() ?
> >
> > It has :
> >
> > WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);
> >
> > Which is IMO strange, regardless of ARM64 clang and whats not.
>
> Hi Eric,
>
> Thank you for taking a look and catching this!
>
> You are absolutely right. If READ_ONCE() on this 4-byte aligned struct
> causes an unaligned load-acquire (ldar) fault on ARM64, the
> WRITE_ONCE() in proc_fib_multipath_hash_set_seed() will inevitably
> cause an unaligned store-release (stlr) fault when a user tries to
> modify the sysctl. Using WRITE_ONCE() on an entire struct here is
> indeed structurally flawed and unsafe.
>
> To fix the write side properly, I should write the members
> individually to ensure safe 32-bit atomic operations. I am thinking of
> updating proc_fib_multipath_hash_set_seed() to something like this:
>
>     WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.user_seed,
> new.user_seed);

SGTM, but please add this part as well:
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 643763bc214279047c90b5b92a9ba9be6c24a443..1974b826bd9451fd9d8054e1db8=
11760ff4b5a9f
100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -500,7 +500,7 @@ static int proc_fib_multipath_hash_seed(const
struct ctl_table *table, int write
        int ret;

        mphs =3D &net->ipv4.sysctl_fib_multipath_hash_seed;
-       user_seed =3D mphs->user_seed;
+       user_seed =3D READ_ONCE(mphs->user_seed);

        tmp =3D *table;
        tmp.data =3D &user_seed;

>     WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_s=
eed);
>
> I would like to take a little bit of time to reproduce the
> WRITE_ONCE() crash on my ARM64 device and thoroughly test this
> proposed fix to ensure everything works correctly.
> Once I confirm the fix is solid and runs perfectly on the hardware, I
> will submit the v2 patch addressing both the read and write sides of
> this unaligned struct issue.
> Thanks again for the insightful review!
>
> Best regards,
> Yung Chih.

Thanks !

