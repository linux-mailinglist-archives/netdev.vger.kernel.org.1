Return-Path: <netdev+bounces-263938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KufFvVkqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBB204BD7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0398030AE27F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF7376BD6;
	Wed,  4 Mar 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ/vCJFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B53377EA2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643348; cv=pass; b=QAdS4bpCDkVZSAdlMi42KwBNWv12DOGkJzRK6FMkwzFZeUa3BsgFoQJYD8vNl/UBCoxjMXR1KgBZPuKsfl2dHGWN/qI+lRapye6BDpweuqWWmrp7MBf8aBk3p0NUD5easko9PMaNWvwBTS22e+uEbUUFgMF8StvLsO3PhSGXM8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643348; c=relaxed/simple;
	bh=8DLex6OiDVNAnlr92UP4pRiD+VXO6BmVPDMH77Ek58o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiX7nSYenzkZ6fiiH6YfNoFcclabo19DvJvJAtVTFPFWsFCLM4K9IWp7bJPGpwhLN0uov7cvJ0GnvFKmA1sDhTTbB4IJ/rdmX3gIc0aXAN/DDXGo9HUkKRHSy4Bz277nj7pmNYYFbWQpcTO2KR5HZrKeQZrUHEBFDo+7LMgNolo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQ/vCJFH; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5033387c80aso98735121cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:55:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772643346; cv=none;
        d=google.com; s=arc-20240605;
        b=FEczEJjdqGYhdk4rJZfHxNc761sqUBb+X7JxZ7XOZmWnUOENc/BC8xkFbeKzZOhwwy
         U5gmOkDvDMEAzDdSOkmtbKtGIqxfVF3JS50x39w1WUW0q+xUkSLWi5YIuos4n+vJn/mA
         lTUwZ7B4dMQXHxQcH7Yd4+tQuWsm/ed/padkNASxcMx/jlDZdKfH3V6AU35zLqBUWpOi
         /Zlbf+vofrbvPXFMHyX3rOv+MK2bWS8sMl+9WFg74GMEykGn2ZQ0RaYtcNsIIY/LCEnC
         +FrwoqQThyJKefchJVbt2Fc3q8on62N/900vEA/C6pFhpL06JeZahnbEM/eYq6LwQTvh
         K7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kCGKdDjbi3sETx5FMjZx9OCyoz3IP+wTKKvZi2G2sR0=;
        fh=UJKOqhGrO15LeZV1hfe/Qd/P34Jmv1BcZe7tbDmi19w=;
        b=QJyMMfN89IXdsIQUhE5spE8GGel3dLotyhcI6FUaD7A+OuUXN1PXDPTex5zxmxVOUW
         MT529ZDeTVsQDMjlAxR6uHUWLja6DVuCH6w7gz7N8Fhmr8n7oCzHrO8gy5ux6sdVar96
         fH57KHGK8iO65mMVvlcOP3RM6ObLh1rkCkJwXJ6xGHq5AQ5H0hqKLESu5g99wI2XWvA/
         FBieCCcw3zguj5WyADettlZ8aETZ9DC8h6QJeqEM5iNIW8G3iJcme9kFsMAq+8UiNL4b
         7tpC+DGCx8vW+Br22bUltb9XLsoVMmXDVl5yX9v/n7VHToMGyr+4PXgx2vmyPILtI2H5
         t9Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772643346; x=1773248146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCGKdDjbi3sETx5FMjZx9OCyoz3IP+wTKKvZi2G2sR0=;
        b=nQ/vCJFHhyL3MwfKpbkwjtAknK4/JxyzEkhSaSijKscFx60gIMoaIVf5gqicpUA/zh
         sYRJq/ItpvTFw3LeS5IV/YZ6pCuxHeFzA23Qw2PjJmHVSCL1EeBdUnuZGekvCwxqLZyk
         PfSGyIdhVv3XZuPTbuvqx9JgEGLwLUkKRYfCxZfV93KyodYTTWeamdcWr/AxsMUcveot
         0JKWt+32+t/1Ax7xghzFP0g3wvoCWkvWvqJQz5dXsLlkajL2XY6VDvS/2OI4ne7RAgzF
         gCynvmfojkZHWPAdcSKH1/QnFq/nptuXdr3rW/dboqSPf1/OXMsKaswSrgxqZR+GYRad
         diXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643346; x=1773248146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCGKdDjbi3sETx5FMjZx9OCyoz3IP+wTKKvZi2G2sR0=;
        b=agZjhHI6lcfNu6MbOqFKfnI7f3eIvavPG7JjYsT6fpzOJDQdaMkfyrZKJ/EGTS1PLk
         D/s3Bc+FM8d3abSzfsufYfmGPxalhABEGJRiHG5a/BvvlUtXSrkDgh8EfS9vDQZtWF3p
         4NAgkgxB44a0JKEEY+tatNmd63lhC5k+mQi9sPJmABUrGZIbYnE4da1FTEvXqO/qR+l0
         ZrnQksno5u45BSdiUC4WV1r13DCF3bIfXoSgEDUl2lkIQJPxv1XS8J22wzrBba7j+N0T
         pZEqAD0Mrt2LoIbuvTVeZoWfpu+VYaskx18ebdRgAWpH9EoMvUkpv+MegoMhFdNMYB7M
         w6QA==
X-Forwarded-Encrypted: i=1; AJvYcCXIhANM7nnc5SmRqo4pA7HHGrSO1e/XocYTzBEHdFRkVtD7HSsfSYKU3fibw573W4bmV57PsLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3q8sopWgY4KGzvuC9p3mDTwFB1PsDCA4F3ynngOOHjglzA1Gw
	EgEKeZ3GV49cy8ICC/WvX8BmwgTKiflCGIXrFJq6UnUO+jFHc98+3F2Kp1ao6+byM7B84Y4h5jS
	T6mCbxo+PORgq+moa8yFl/yY4/U/ehXbDk8h9AXQQ
X-Gm-Gg: ATEYQzxxz89NwmxYM0CjuJ7DDE7pn5jehe+6S7IvffZpVvG7tzM8WWd/Xk0l6gbX/mj
	jK+mzymhOCvnorzzYBvzwybFyeBL7IA7eKaPaRds9Pxs9JlmhJA8qNLWNyM56YoouGckuVMzUpS
	UhypRKtnQy+4ZCzq5iiRNU2HP0BnDdAVmdSTVJMcj6JcT+EisL20qGZgnvsh9CPKTrxuMI2Cyol
	kWjbVZDtQk15tU/JjDNcVWoEEHmL34Xciigezs9NoJ/MDD1mgUREZAivKMh3mU6ghuwLwmr64wW
	KJgucdx+lT/M8q5mauk=
X-Received: by 2002:ac8:5d09:0:b0:4ee:232e:4950 with SMTP id
 d75a77b69052e-508dbbd711amr28506061cf.8.1772643345706; Wed, 04 Mar 2026
 08:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304094318.1769536-1-edumazet@google.com> <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
 <CANn89i+SQd4H7q=ELJp7-aaN5PyZ-Oakoy9MHZpbuX1iGKV1ag@mail.gmail.com>
In-Reply-To: <CANn89i+SQd4H7q=ELJp7-aaN5PyZ-Oakoy9MHZpbuX1iGKV1ag@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 17:55:34 +0100
X-Gm-Features: AaiRm52OXVloAR5VminZwpzRTxvYbj390bKLM-ZVsNykKiBSNfSh9sZZAchtpNQ
Message-ID: <CANn89iKvXbBGXb7Uzu9ZCi+M65SwmMxoGM0C-HR6cO1+PxyYbA@mail.gmail.com>
Subject: Re: [PATCH net-next] inet_diag: report delayed ack timer information
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B0DBB204BD7
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263938-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 5:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Mar 4, 2026 at 4:48=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
> >
> > On 3/4/26 2:43 AM, Eric Dumazet wrote:
> > > inet_sk_diag_fill() populates r->idiag_timer with the following
> > > precedence order:
> > >
> > > 1 - Retransmit timer.
> > > 4 - Probe0 timer.
> > > 2 - Keepalive timer.
> > >
> > > This patch adds a new value, last in the list, if other timers
> > > are not active.
> > >
> > > 5 - Delayed ACK timer.
> > >
> > > A corresponding iproute2 patch is needed to replace "unknown"
> > > with "delack":
> >
> > ...
> >
> > > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> > > index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df046=
44c00bf5c7db4e150d2 100644
> > > --- a/net/ipv4/inet_diag.c
> > > +++ b/net/ipv4/inet_diag.c
> > > @@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct in=
et_connection_sock *icsk,
> > >               r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
> > >               r->idiag_expires =3D
> > >                       jiffies_delta_to_msecs(icsk->icsk_keepalive_tim=
er.expires - jiffies);
> > > +     } else if (timer_pending(&icsk->icsk_delack_timer)) {
> > > +             r->idiag_timer =3D 5;
> >
> > How come the idiag_timer values an enum in
> > include/uapi/linux/inet_diag.h since this is a uapi?
>
> Yes, this can be done, although we survived all these years without it.
>
> Do you want to send a patch or should I implement this idea ?

I will squash in V2 :

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.=
h
index 86bb2e8b17c9f197fd49cf7996d5e4f555a9b8e8..21f0d735fbae206cf2e1e573912=
a324bb2eb64d9
100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -129,6 +129,15 @@ struct inet_diag_msg {
        __u32   idiag_inode;
 };

+enum {
+       IDIAG_TIMER_OFF,
+       IDIAG_TIMER_ON,
+       IDIAG_TIMER_KEEPALIVE,
+       IDIAG_TIMER_TIMEWAIT,
+       IDIAG_TIMER_PROBE0,
+       IDIAG_TIMER_DELACK,
+};
+
 /* Extensions */

 enum {
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e4cb18061aefcc22df04644c00bf5c7db4e150d2..34b77aa87d0a48bcbceb7f2935a=
210a347812cc6
100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -241,7 +241,7 @@ int inet_sk_diag_fill(struct sock *sk, struct
inet_connection_sock *icsk,

        inet_diag_msg_common_fill(r, sk);
        r->idiag_state =3D sk->sk_state;
-       r->idiag_timer =3D 0;
+       r->idiag_timer =3D IDIAG_TIMER_OFF;
        r->idiag_retrans =3D 0;
        r->idiag_expires =3D 0;

@@ -284,22 +284,23 @@ int inet_sk_diag_fill(struct sock *sk, struct
inet_connection_sock *icsk,
        if (icsk_pending =3D=3D ICSK_TIME_RETRANS ||
            icsk_pending =3D=3D ICSK_TIME_REO_TIMEOUT ||
            icsk_pending =3D=3D ICSK_TIME_LOSS_PROBE) {
-               r->idiag_timer =3D 1;
+               r->idiag_timer =3D IDIAG_TIMER_ON;
                r->idiag_retrans =3D READ_ONCE(icsk->icsk_retransmits);
                r->idiag_expires =3D
                        jiffies_delta_to_msecs(tcp_timeout_expires(sk)
- jiffies);
        } else if (icsk_pending =3D=3D ICSK_TIME_PROBE0) {
-               r->idiag_timer =3D 4;
+               r->idiag_timer =3D IDIAG_TIMER_PROBE0;
                r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
                r->idiag_expires =3D
                        jiffies_delta_to_msecs(tcp_timeout_expires(sk)
- jiffies);
        } else if (timer_pending(&icsk->icsk_keepalive_timer)) {
-               r->idiag_timer =3D 2;
+               r->idiag_timer =3D IDIAG_TIMER_KEEPALIVE;
                r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
                r->idiag_expires =3D

jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
-       } else if (timer_pending(&icsk->icsk_delack_timer)) {
-               r->idiag_timer =3D 5;
+       } else if ((READ_ONCE(icsk->icsk_ack.pending) & ICSK_ACK_TIMER) &&
+                  timer_pending(&icsk->icsk_delack_timer)) {
+               r->idiag_timer =3D IDIAG_TIMER_DELACK;
                r->idiag_expires =3D

jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
        }
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d83efd91f461c8ad0157faeebae051b32cb07bf4..3e8ee2054466e109644a758f8b4=
f0a646e22e456
100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -212,7 +212,7 @@ static int tcp_twsk_diag_fill(struct sock *sk,
        r->idiag_retrans      =3D 0;

        r->idiag_state        =3D READ_ONCE(tw->tw_substate);
-       r->idiag_timer        =3D 3;
+       r->idiag_timer        =3D IDIAG_TIMER_TIMEWAIT;
        tmo =3D tw->tw_timer.expires - jiffies;
        r->idiag_expires      =3D jiffies_delta_to_msecs(tmo);
        r->idiag_rqueue       =3D 0;

