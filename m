Return-Path: <netdev+bounces-260781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDHqKe2lnmmrWgQAu9opvQ
	(envelope-from <netdev+bounces-260781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:34:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C22193822
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C95E231AAC6A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A62FF669;
	Wed, 25 Feb 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkUdfsxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633C2F5313
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004244; cv=pass; b=EVPd+zdkBVEPD8i0oHVSrt+lV6L59lfiM2ABBH2NP2fRngCHbmromVB0iS94FvCylHKyfPrUulvyqWHQ+mL73xcfg+tc5ezj/GXHrBajrxyrr/UAPmme4hJN0OSzVxGsiqlfkALnlZVJzafCy80BzDIzWDWd1dy8RsL2oxhDGH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004244; c=relaxed/simple;
	bh=dtM+l/tJYLXALrpaT8XNEnkiNJJXCsY+A3lqvcq2wV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+KkYy5fj/pLe2hiZGEqeZnsbru+RwUPstMYla6FzFepKKgCf95CQSGDZSEnGnl61Zj8idJOFU32F+183HELy+QHJiYuRqNigI4Z9BnCs36zm5byFMVIWXQ0UW1KC7krTL8tmZhdtrZ5ZZbRSEKPIqdJ/f/WxbiHDZFRd7ilpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkUdfsxn; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506cb1b63d0so69484881cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004243; cv=none;
        d=google.com; s=arc-20240605;
        b=Wyuphtm36ysTWbaSE5JVB99pLbBRCWDtpEkJYH0PmEq8PN4Vt4EhXFJye0apa5bBmI
         ifyd+023shlBinsV1KE/iRcSGlTLI5EAGcnJCLJIiFw6YtA+G83POBikVH62rRZ8Cr0p
         PXTukgxHfoCgAiG7m3tQGY5RNZuRJxp3EwqvAYIYGxxwEOFGPrBlIMm45SYp4ZppMXAQ
         Sone927MercM+MWSZew86XYqRpSNR6dGN/mrsJUFcR40Nuhe6vowaL6XWevuHr2mIUDm
         w1dhyoNZCphzw991pcQ53oFXhG+O1fz5GQq+E4BwjkQNTWZ/BBEGXdUQTuiqNi6faDp6
         T1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hvndr3OtpxB0InC2gQSj3q4nYtl2fxS1skQRNPhJIig=;
        fh=AH7eSwG3W/4Jn2negs7uo03+8Sl+g8RxMjyeC7rZWdo=;
        b=K/JHcA9Qkzpl/mUAILhPsmtpJXeljkVuZ8qePQJlh0l65ZRWT3eQaZ4/oywc9cUW7l
         XUPuHPB0V4ekOq7S1pQPiNdosJsRlPyfzZKaqd9wtZZW0A363dnb+Okc0rOcJ+IBmU9U
         NvCPh6vgDgOTgamRO0cTiMameZqBG+9QXFuvX4y4xAyAcBfKx9ehr+kasZOJ+2NwcqK4
         XXPGj4cjJR3jqtiKyUrXBAyNTdb/A1MaMU/k47NuPXV8H3UaAzx/ZB0EgfL8fI72PNJQ
         wDu9T712mYcsZIbwJ38abk5ZMJWW0BZdVzJ7GezPgy5Eg3f4hXQF7syYR8j/9RnPgVpt
         D0Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004243; x=1772609043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvndr3OtpxB0InC2gQSj3q4nYtl2fxS1skQRNPhJIig=;
        b=CkUdfsxnvLH2MTST9whsTpSlvcDXnNImoXRgs+N6Xiovx1L0rQyM3ghhetxP4GIWqE
         yqdPV8b0n385Yr+6sgGwnknjrs6OQZcavsXe0Uraar0tBK6hbN48JJDrIKLGFBR1XQfn
         TWuWsOKZy+n+6XbdmeKSjtgcBlRBLBRYQQOheCTmL/1Esuh6KLriyYY6scLvHEgtHbLQ
         OgeHzPoVGJHwvL8s4ero/TMJtKp41klkI+rFIFFWyDHYJb5wRgNgRN/H5onBPQ7sjg0g
         NymOhMt2D2pKWp71+RDLQuDZ+4lhkpbKHSrfQ7saQWeOkXu4pGaLxARKHTuaVuKZ1aNa
         8piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004243; x=1772609043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvndr3OtpxB0InC2gQSj3q4nYtl2fxS1skQRNPhJIig=;
        b=WTwS2JED4v/yuQKyJQ3ngmlgQgLO6hPcyBGqb/fQDmSrvbTwpWOH4gJ0ZcGQXglvSi
         kvSLuEQ2tpwiNdX5HWxtXQ7JX7qRWkOP5FUu2tB0RceuA39CZoWnAiuz1h6D3lv9f/M5
         vNO4rjKkGjNsF4I8IKq/FMocsl+EN3G+Gev1xNVyh12dZ8emjfzyAum2tZ7SQs3aGydE
         14RLPGnJnNxMmqpewwLJCQ5FckyQQFNd1kjvboWEir1/HyvhNUi3ZyreEfU5H8Szkuka
         IlK9Jqpl8j/56I3fRUjHD0v4vdgYL5l4DyQSFi5vEkfEBLLxkjhyGu3Bl01u2LMf+O+w
         QRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAV8/EEH7Gw4VXWRpvSMZLHgySaUmAumhXqitqf7DF/CRBZKV8cB0xgWz7DE20Piu/tUGYCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JJj7qw2xVWDIP5hGvTIVyd9ID11kyE5WvyvdiCkOWfPV0XkD
	qMQWfzetPr3eQyibm74ShDZo6bAq67Ntt25lc54mL/RrDX5gh7s0cDIkGET7KSzLDkQCykiByQh
	k/nvBcBr2sIW8YCQRyVvNUd/ZQwMXTpWtExFJLp6J
X-Gm-Gg: ATEYQzwsZ6QsFhpA0T4Wxj9XO4Q/6S1sEdPFusP4wozX0aSl5xQ3TzpxSHxjDLwctlB
	xsJZUhOSY5ZI5sX7srWhIKUOHdVOtmLAO4w4gXKizUhrhMvS36cmhUbNJWKVyr6nFwK1fjRUMOT
	2VWCYJubyKyggQRzm1ZdhHt31xoHmODK/CN04OSrAR7HEq+OwYSwP4jSqJ0nV6JU1d3n/8QA9v0
	HnozCHHWpMRa/fIy2FF6iSGqE40fh9XxYOboqgHK2j41aQQQ6HIEjS3uDlDPZXOJnXbG5DtfZSV
	v/V4+1oWycyDbHU5vipfF/5pt6cszY4JNeh+oIScrHe3QtkEQLLk
X-Received: by 2002:a05:622a:130f:b0:4f1:c7b3:b180 with SMTP id
 d75a77b69052e-5073a30ae14mr18285241cf.36.1772004242230; Tue, 24 Feb 2026
 23:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225033216.601205-1-edumazet@google.com> <CAAVpQUDMTefL+Rsb_9FnMFf5o8UsqhxpZ3Vgg56_TDQQbPHCRQ@mail.gmail.com>
In-Reply-To: <CAAVpQUDMTefL+Rsb_9FnMFf5o8UsqhxpZ3Vgg56_TDQQbPHCRQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 08:23:50 +0100
X-Gm-Features: AaiRm50v-_qAlEJWEzrXSagwov4PTiwjh-yv9DmuPWlYHDhLdYfJXP2WB46eUjs
Message-ID: <CANn89i+oE7SpzKq8cVw4J=0DTHvQt2Ou_v=cxmNKhCviK7fXRw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260781-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 44C22193822
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Feb 24, 2026 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Add a fast path in lock_sock_nested(), to avoid acquiring
> > the socket spinlock only to set @owned to one:
> >
> >         spin_lock_bh(&sk->sk_lock.slock);
> >         if (unlikely(sock_owned_by_user_nocheck(sk)))
> >                 __lock_sock(sk);
> >         sk->sk_lock.owned =3D 1;
> >         spin_unlock_bh(&sk->sk_lock.slock);
> >
> > On x86_64 compiler generates something quite efficient:
> >
> > ffffffff81e96100 <lock_sock_nested>:
> > ffffffff81e96100:       f3 0f 1e fa             endbr64
> > ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
> > ffffffff81e9610e:       31 c0                   xor    %eax,%eax
> > ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148=
(%rdi)
> > ffffffff81e96117:       00 00
> > ffffffff81e96119:       48 85 c0                test   %rax,%rax
> > ffffffff81e9611c:       74 33                   je     ffffffff81e96151=
 <lock_sock_nested+0x51>
> > ...// slow path
> > ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d2570=
 <__pi___x86_return_thunk>
>
> Wow, this is interesting !

And using try_cmpxchg() might remove the "test %rax,%rax" after the
"lock cmpxchg"

>
> Should we use __SPIN_LOCK_UNLOCKED() for the old
> value too ?  Looks like parisc assigns a non-zero value for it.
>
> arch/parisc/include/asm/spinlock_types.h:5:#define
> __ARCH_SPIN_LOCK_UNLOCKED_VAL 0x1a46
>

I will take a look thanks !

