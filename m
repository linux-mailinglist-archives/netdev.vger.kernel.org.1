Return-Path: <netdev+bounces-261716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBEIHbkUoWnoqAQAu9opvQ
	(envelope-from <netdev+bounces-261716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C21B2664
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9711307E591
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9AB3396E5;
	Fri, 27 Feb 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4nRKiYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3213396E8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164277; cv=pass; b=J3TZDJi/qyv6WMkNZsAJIPtTRkk7mBfxKTg/5ZSxlY10bhEkGEnN9uya4JwmMi6EMlnGj1bdZN8sbYltlyVJEfpOp9QHxQ1ihTDh+6JujCunjTYT7Np1VP28iT6xjlIYSldj9a439mdSXkcFTK+9YQyOlBQ9T1pkyJAnd7nZxps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164277; c=relaxed/simple;
	bh=KCqSXRpmtm+dLnuGZeyz56uFuX+xN2Lx9x3FOfzyK/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFTWpuJsqsN3RgNHfBlVNiXu9t6heE5Squ759EHjZCw7qIqxbJhuNKE7z9fukR27yc6aSplG/kpsGpkbOG6Aq+s6v+B5BY9puPVjQD0gDAFXqZ4TDxAgoB5D5AfRREiHH83XNzBaFuNKMzyjmlamSaTzdAgHEGQTYxbrJZ95Geg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4nRKiYf; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124afd03fd1so2191653c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772164275; cv=none;
        d=google.com; s=arc-20240605;
        b=lPVadupZhI3jKAPm4DgdVJ6sJuNYr4oJALN2RrMrsJg39xJesEFbBKye/DIqtYsQRK
         /TgqgaLpXbZIX8Vo7pc543OjhVu5Gbo1hE0czcIXvPfkyZpFn4pjD2IIr6GgQ+CG01e3
         xIrcOvNjYfuEYQdJwyPiG9ntKglT1/Pd23QybK6NOxePkhZ3YRHVsihsrdL6fNmYreEh
         31HqcyXWN/4S5RKaL5DMuoYnBOFOcgZbMBcqMskl1aWmfAO4oSbx52xzBtWs/LA6ljlR
         RbFjGBuXWnVnMbFmpH6RTFbuJ5cZGZK48E13nXCys+mZcqYohPXDzGZWjjMQ5IZHNZSr
         s1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgMFzN8FUBr4VIpkMiVwIubDF0sSvNBkuqSV0G59Oxs=;
        fh=8jGxD9RsCmz5tmOI63OQKaBAyhfjijdantQDNkM32RM=;
        b=Scla52EO8dCc3MBoyP/kkXXPIC1cdblprcRjgnA0JNpHorL5hx1anR+mBqTg89cHey
         uaYjVINyijDJ+V2KKnEH/mE4BIBN9G4L0Ibgy32XEO1l7IoI9ssi1GOdfnUUtc09ygVk
         legIUid5cyQqK98zebxCJjdcIC3bWa881eOZaSVbqn8/VUQta6iVCR+LAIA6ag3Yex/q
         wAjQo8DzvD9ftwsqw6znnnwOqDJEhgU26tpjuCBNb5gnSwOve8gbxXLh16KQ7CAYAaaE
         9bLvKKFEM4rb176ZVfw66i0GtGoeOxcIWPgEmUNzXYMRnsejqsxm+TZfWcvkNlgKL6ps
         lPuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772164275; x=1772769075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgMFzN8FUBr4VIpkMiVwIubDF0sSvNBkuqSV0G59Oxs=;
        b=S4nRKiYfYtjW1JlNhyBCWUXZY6fMPLiDLmoKfay4k2mGxTpZDWgcOnEuax3v+1pNWo
         jtKS2z9myjGOHTyMwR2mn6mhDvT0wNRtrgJHKk2ycFpVlErxWGHULfQQo5dJ+LZKpF1C
         HAy1q0RjlP/x3QadRackigb1IwLwXJS5YUy7HSqzQIdMk8bkiVGBtBpolMHpZzU/gIdm
         5ytvpsgjLpMXnROTC9CkI+VUmlh4PW/rcIWhisJZxi+GpzZ/PeqQxi4FuowpuKJ38tvs
         LcXudHGJ47lHyoVBpFJXVmW93nS1M1qT57TEIuFgVx4xAVONjaKXkgSSwi/po5ecik4H
         9tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164275; x=1772769075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgMFzN8FUBr4VIpkMiVwIubDF0sSvNBkuqSV0G59Oxs=;
        b=r8YpkEXtxLdUXHfGcuNIk6toodqbFh3uTzvOyGdFlE/G2SAt/9r8iY/ZWl630aDtaO
         +8VvAUaLsr/1PIdc4/F49R/i9+lYUhQXw4PRFalT1/QBrf5XW7gKMVe/0p86mWLgS11Y
         l3Q6gRkMk+zn2kBwtNg/5TUsV95ZI/1rEEa8kSTBdQfCxUoOcuhZhuf1TPLXyf3bBwEx
         gTrlOPCPh/0kHN4mfSvr9tUF6FLuDctHTBSAqEoTR5PVeYgB0rALbYpl8uiCcTOKNcxT
         ZaNM7VWF25/NfvN3ezDiaX1ZCdfY+wsdYppfzdbjGQ2h5IYKVp9rSo21SiY2xfnRrNLB
         m2sw==
X-Forwarded-Encrypted: i=1; AJvYcCVWIrZtqajIi5nbbpBNmLG6EAKWMle7keyW6K3M7SmSTeIEyLJEyNf+RPgeUAm9JYuTq5/1x8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSENN54GOkcmDdOfZ1E5G6yjdJpvyTclBWUl+Lmo7WSV/LKb2n
	EqAfDSrI2C5d5+2mikWecnPRquFExkZcFfSWKa2CPTY4268kKLHAkuJPE++c0TrGGerQgFdUgnT
	buA3dlYOF/T5G2GlHljQzFqySe7iLqInHzumHu19d
X-Gm-Gg: ATEYQzwdn/c8oX2r1hquMS5X+cb7CNF/9ZC2TX0iDwsUdGMMn2dQG0pqwSVz5AHg36O
	mrlwU+Nx2Ec/OXZbAiH01s004Nwvwh8gblAONNUsbarbR1j5kV9Gb3sIB+DNp8fxMtiPwoYvs53
	cA3IUVTjcHnetz+drdRcEK/6ImCRlDxQMDGCOW7mUagsS/n6xBxBD04G0xjhH0bV2osiUlU2Hcg
	uQ8IELbAYn8d629SuznGV7Tpai3cpBvGv9WVVdYxzTDxeBtLpPbHOLYBvXKQckpG5HnD7Nspz5w
	0b/BXblpMV51qpbflbDedyPlvsA0dk1tJt686vXNvsih6fJeyNJD0+85zrsrsStvN072u99z
X-Received: by 2002:a05:7022:611:b0:11b:923d:773f with SMTP id
 a92af1059eb24-1278fb607b7mr665571c88.5.1772164274348; Thu, 26 Feb 2026
 19:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225002709.156882-1-kuniyu@google.com> <20260227034056.2605149-1-kuba@kernel.org>
In-Reply-To: <20260227034056.2605149-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Feb 2026 19:51:03 -0800
X-Gm-Features: AaiRm51e5vQP6MQjvRKHEq7QRfMJD_951BsAGwTwAvRddqbpAelJeMYJzRsqLuI
Message-ID: <CAAVpQUBFb33H8XX8eE8_HKZkYSN8c8etj8mKDXJZAbUJ=b2t6Q@mail.gmail.com>
Subject: Re: [v1,net] udp: Unhash auto-bound connected sk from 4-tuple hash
 table when disconnected.
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuni1840@gmail.com, edumazet@google.com, davem@davemloft.net, 
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	lulie@linux.alibaba.com, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,vger.kernel.org,linux.alibaba.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261716-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BD3C21B2664
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 7:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> udp: Unhash auto-bound connected sk from 4-tuple hash table when disconne=
cted.
>
> This commit fixes a bug where disconnecting an auto-bound connected UDP
> socket leaves a garbage entry in the 4-tuple hash table. The socket is
> now properly removed from the hash table when disconnected.
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index b96e47f1c8a2..3388e4ab9056 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2321,15 +2321,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhas=
h, u16 newhash4)
> >               if (udp_hashed4(sk)) {
> >                       spin_lock_bh(&hslot->lock);
> >
> > -                     udp_rehash4(udptable, sk, newhash4);
> > -                     if (hslot2 !=3D nhslot2) {
> > -                             spin_lock(&hslot2->lock);
> > -                             udp_hash4_dec(hslot2);
> > -                             spin_unlock(&hslot2->lock);
> > -
> > -                             spin_lock(&nhslot2->lock);
> > -                             udp_hash4_inc(nhslot2);
> > -                             spin_unlock(&nhslot2->lock);
> > +                     if (inet_rcv_saddr_any(sk)) {
> > +                             udp_unhash4(udptable, sk);
> > +                     } else {
> > +                             udp_rehash4(udptable, sk, newhash4);
> > +                             if (hslot2 !=3D nhslot2) {
> > +                                     spin_lock(&hslot2->lock);
> > +                                     udp_hash4_dec(hslot2);
> > +                                     spin_unlock(&hslot2->lock);
> > +
> > +                                     spin_lock(&nhslot2->lock);
> > +                                     udp_hash4_inc(nhslot2);
> > +                                     spin_unlock(&nhslot2->lock);
> > +                             }
> >                       }
> >
> >                       spin_unlock_bh(&hslot->lock);
>
> Is there a hash4_cnt accounting mismatch when inet_rcv_saddr_any(sk)
> is true? The udp_sk(sk)->udp_portaddr_hash is updated to newhash at
> the start of the function (before this block):
>
> void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
> {
>         struct udp_table *udptable =3D udp_get_table_prot(sk);
>         ...
>         udp_sk(sk)->udp_portaddr_hash =3D newhash;

Exactly, this needs to be moved later.

Will fix it in v2.

Thanks!


>         ...
> }
>
> When the new code calls udp_unhash4() on the inet_rcv_saddr_any(sk)
> path, udp_unhash4() computes its hslot2 from the already-updated
> udp_portaddr_hash (nhslot2):
>
> void udp_unhash4(struct udp_table *udptable, struct sock *sk)
> {
>         struct udp_hslot *hslot2 =3D udp_hashslot2(udptable, udp_sk(sk)->=
udp_portaddr_hash);
>         ...
>         udp_hash4_dec(hslot2);
> }
>
> But the original udp_lib_hash4() call during connect() would have
> incremented hash4_cnt on the old hslot2, not nhslot2. This seems to
> decrement hash4_cnt on the wrong 2-tuple slot when hslot2 !=3D nhslot2,
> which is common for wildcard-bind + connect + disconnect.
>
> The else branch correctly uses udp_hash4_dec(hslot2) on the old slot
> and udp_hash4_inc(nhslot2) on the new slot.
>
> While the impact is minor since hash4_cnt is a u32 optimization hint,
> the counter becomes permanently incorrect and accumulates error across
> connect/disconnect cycles.

