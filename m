Return-Path: <netdev+bounces-280846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOvIDBts6mmhzAIAu9opvQ
	(envelope-from <netdev+bounces-280846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D586456461
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E76253009F32
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0600B3B19D1;
	Thu, 23 Apr 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIHsVZhB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411525A359
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970772; cv=pass; b=Ozsytgy+dIOcdWQU0f7WGiuJpM+mnuP5+14x9NBam8hhCx2i0lYw3DesqWdZNnOsTAYsoCyOReL8rtkolUdwQZoULVjeM+mDnnTdRbi4/FB0vt1mVOLcJKci6XfEUdxmAq7o0pgr7tcRQdV0YdwFd8mL3X/PI/o5meUacUcRs0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970772; c=relaxed/simple;
	bh=TfDcCQuw4d/P40swF01UTEiMeBSg7UxkkzWEnMFxiB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhSGhN9pyQD7HfDg/Fio+Zenzwb4+BusJ4/vbbdl3Xcg4yyrfFjJZn4cCvBOk2BI/JmVoTgN1pz2uqlNNEgBpsh+JNMeO67WIqQB3W6CmAf33URIIub5vecwUQwdwESqN3gVvGFUaf3mfO7aunlY4LU5acSqdxQJodJja7ENeg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIHsVZhB; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a08fa355a1so98019706d6.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 11:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970770; cv=none;
        d=google.com; s=arc-20240605;
        b=S0IyHxDdoeJEraQg8U48HfbYVASqq9ex31Os2mdyQCJVep89rHvZ3gu1I2cw54jjaX
         5hCXp9Pzw8BtGVUg24eKh7l1exwv0wakd0pM4ZCFLtSF30IwC0/8VvmTRDvNrlG5ulCO
         U4HSQBmx9CrBNMEl4JPyYfOoIIWNKCFfDFHwys3ZSLIxFcTcvMcMUHZ8WaAUxkgYNhcw
         eKIuTYwGo8geIzXT15RPgBwoYp1yBxV8Hxau0ifj8zTkvM9lzHbShjJ0HcLEJGFKDXZ4
         rLxskspyVBAE9Ov3gk3O/gY0pVr7vxcJkUI9V9QElQhW5aUKYR9ehZjxkyKVrvBGENlt
         Wwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euYM+JGa9D6y9zb8IltXpE6O+vn2sVJ8xGTLsM292Is=;
        fh=l1iz9gK+mGtBPty59cOUjxpmsuRwYy/2dyQCs064LXc=;
        b=S9lUqBfrILhcGHxTDmlTFXCVm9dzk3QEa/Ve+Nn+4JKzw71AI37VEQEZP3VQQkwHdS
         xMKYvJrbO0v2IServ2TIxr1U9/coX8zCFeoMsKCkmezzlcT14fNsN53KheUK4yuYotLB
         lqeby7ddE0IUYuyyTQhIemmXrFWJPRt8XfqWSVYEMtFyyt0ucO6V0oXyimBb1PwWGpsu
         NNJGRQxv5kHonjxJg//5U8kj+tJ+++Jpzt42laoDbWasSB/aEq8f+GIPilGeTPN5hVf7
         +NSSVfNoxKOjxGHfiQRB/CTMqOXjgZSSRNMqrjEVlXeUHCZpmuxA6cFrjWowtgsPyS3l
         Fmkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776970770; x=1777575570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euYM+JGa9D6y9zb8IltXpE6O+vn2sVJ8xGTLsM292Is=;
        b=LIHsVZhBvFzcwIBjFj2va37hrb6aW3YgJ3TqafPmMtIHqvRRIoiUrgNEs2jZW30sZ6
         3RUsbG+b7MWFF6a528W3YFJP6AdJoOm57aJx5ztspeON3sXICMb2TIMKrNlRABrTto/o
         dS7q0rWTCidZxutGYuHiT+7c3fhkRKcJW3vHKhg5l2543+uP2mwzSDFF70v7WcB64o13
         Ucz5w6zEq951xhtsHzfwTa9dn/k1SNH0LPGsnVqapmA1qF/j22529yDrYQnBzsDXNVXo
         7uG1NCuMvP6LrGprsxiH28Not+mcBZo3P56HpulHfOdRv36mQEkSOwg4JO5Q1tQrz0TZ
         uymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776970770; x=1777575570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euYM+JGa9D6y9zb8IltXpE6O+vn2sVJ8xGTLsM292Is=;
        b=j+HaCcQWnfBskoTGt7Os1ISvhWSBx+uPOuwUSwHBifJ6IUobXlDkAGwsfbb+G0dpie
         5fG9QNb6JiwoPtxVgBcoymykky2sNWhSMs65rAOAnNhEzEnljdjzo0J+NxpRvhsd6yoT
         RDogPYifl46d5sHSR49zbAra+eA83BiSUgD0zh0LRA6WBP6uiSgQzGg+kbubnBv86DqR
         W0outp+uMpR+s+N180lhibNMKXf1SXvOLh1R6ihfsvIFPgDyCvYSbLrqQTgbbuEBMkrp
         bAHW9uiYlBFmNj6cYLQK5aM2tNOyxsQhwDtkn/altPegDE/Jm+BNxWh/aNDPf0wG4iot
         VvXw==
X-Forwarded-Encrypted: i=1; AFNElJ82YCfNapOPtqdH95rUPDtW9P831Nh6IfUNTodVXy0g3OpDnODWvfNHPtf6Ymy0oHId4S0NJ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRh0KpMetLZPIlZB5zBGuTVBGvO9eJU/UiXT7mXx7xB9ggXBDf
	xUT8DsFqZS6ZhlwkLgx9A6vSo4YtY2px23KmZlFb4GhI74pe6F9pQfRGlkWubw5ANscOCgJUfNE
	EAJaV+FgBEyuQbIcxydiXXOTYEYBIhksc8zQr5gSl
X-Gm-Gg: AeBDieuZSuThD7m+np/upFZOSOOcVLU/9a2SHyUcUbcddNipuvtVsc40UqkAPLeIfA3
	tuMZVhyfSJwiOIX4SqHxNehAcEva5uhnZvenLd1VKpfqetKAl+oseS23NV+bCGdLOwy1FSVznq/
	PkoZTcsyzWHtjhsoUbgIrVohN3edapeZcC+9pp16hqGsvGFyFnYLXZoV7GIQrTfINa4+OC3Vw92
	dWD/ID/MGJv2ESZ+gi8uVl/olp+pm59tPJGWg4OiSuvTfcx5oZGCZ1mIhwY2uqWM33ZP4pDv3ti
	PXxLJz1AXwrcxsX0SRbAK7nAqncMjhJggdhtOCSCiT5vstDr0wA/XNzyWcPUhe9zT0ZN2oqS58H
	r6Ndg0dhg
X-Received: by 2002:a05:6214:4f18:b0:8ac:ae21:466 with SMTP id
 6a1803df08f44-8b0280ce5bfmr402633466d6.24.1776970769936; Thu, 23 Apr 2026
 11:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423010933.3899132-1-kuniyu@google.com> <CANn89iKwALD=b-FqwQe=GjB23u5ksdepOZG+3PCjMESBqSw1bg@mail.gmail.com>
 <CAAVpQUDt+Ox3Q0Lu7SVH5doFrTxFJOSigfP5E1WGB0Bi102S4Q@mail.gmail.com>
In-Reply-To: <CAAVpQUDt+Ox3Q0Lu7SVH5doFrTxFJOSigfP5E1WGB0Bi102S4Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Apr 2026 11:59:18 -0700
X-Gm-Features: AQROBzADJ0We_upfl89Ytdln4Blvr5-eTwUriGbz4S0n2AF2prAWYPSF9Pt47Z0
Message-ID: <CANn89iLZ3GUpK-iEvr0iyut1p-oXPn64rOnCcqpmbtfLwduNHQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Use READ_ONCE()/WRITE_ONCE() for hslot->count.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	David Held <drheld@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-280846-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,04905b8b3523856476c0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2D586456461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 11:51=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, Apr 23, 2026 at 12:29=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Apr 22, 2026 at 6:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > __udp4_lib_mcast_demux_lookup() and __udp4_lib_mcast_deliver()
> > > reads the number of sockets in the 1-tuple hash table chain
> > > locklessly. [0]
> > >
> > > Let's use READ_ONCE() and WRITE_ONCE() for hslot->count.
> > >
> > > [0]:
> > > BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash
> >
> > ...
> >
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 PR=
EEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/12/2026
> > >
> > > Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp*_=
lib_mcast_deliver.")
> > > Fixes: 63c6f81cdde5 ("udp: ipv4: do not waste time in __udp4_lib_mcas=
t_demux_lookup")
> > > Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/69e97093.050a0220.24bfd3.0048.=
GAE@google.com/
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> >
> > You forgot to change net/ipv6/udp.c
>
> Ah exactly.  Will add this in v2.
>
> >
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 15e032194eccc3c29b3e5f3a09214cad60623329..1f4dabe4c350118441f61c1=
cf0398e698581542c
> > 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -953,7 +953,7 @@ static int __udp6_lib_mcast_deliver(struct net
> > *net, struct sk_buff *skb,
> >         hash2_any =3D 0;
> >         hash2 =3D 0;
> >         hslot =3D udp_hashslot(udptable, net, hnum);
> > -       use_hash2 =3D hslot->count > 10;
> > +       use_hash2 =3D READ_ONCE(hslot->count) > 10;
> >         offset =3D offsetof(typeof(*sk), sk_node);
> >
> >         if (use_hash2) {
> >
> >
> > Also one part is missing in udp_lib_get_port()
>
> I excluded this part since it's under spin_lock_bh(&hslot->lock).
>

But you would need a spin_lock(hslot2->lock), wich we do not hold.

> >
> > @@ -289,7 +289,7 @@ int udp_lib_get_port(struct sock *sk, unsigned shor=
t snum,
> >                         hash2_nulladdr &=3D udptable->mask;
> >
> >                         hslot2 =3D udp_hashslot2(udptable, slot2);
> > -                       if (hslot->count < hslot2->count)
> > +                       if (hslot->count < READ_ONCE(hslot2->count))
> >                                 goto scan_primary_hash;
> >
> >                         exist =3D udp_lib_lport_inuse2(net, snum, hslot=
2, sk);

