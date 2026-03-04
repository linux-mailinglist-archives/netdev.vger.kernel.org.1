Return-Path: <netdev+bounces-263939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDUmLrRmqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:07:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3696204DA0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 080C03004420
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6D35E935;
	Wed,  4 Mar 2026 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7i89NJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49036C0B3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643689; cv=pass; b=pdlzgaQ3ljVbT6g/mXkCUD3kLDyG4Exn0hoZYfl2mgXgJZBuzgX9vc+gGMie3ZF1iJB7P90gCxU0lUIZntCq1WQuS8LKdGX6nfFMxMFQ6UcoQyxxjPIA92zgTJkrzcVExjA/dBR1miUnQIGb2yCseahfHI3SD/RtgKyGqfs1Ejc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643689; c=relaxed/simple;
	bh=o299gxYCvveG0ioxAvNVdDX3kBkvKq4dYH9zlp4jbt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjfTmmbtw+JfHM82wgDqwt8F3cBpmr04BxrDglBwT8ZUPy2srkeqJqaQyp7AwBTNltWBwYStoT4b2Nh30XHWXsT7ofrx5qNtVo4AFOxw7BJgkCG7ojNVoaIMqQcV1ENDczIi1mDlB9XGbOmjSMFB60bBNgMag+BpUQOX1mJ/Xdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7i89NJO; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a355aedfso1149401cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772643687; cv=none;
        d=google.com; s=arc-20240605;
        b=SyUcTaSfXQD/Uo9zYr5wfq6vjEU716QwLYL1gmJjydive0Ew2sZmwm/yhtb3AUn6zM
         S+LEcrX3VwIUew5fLvQ1ZKYcNjMhC26QXy9k5CC2FXfh7SGblJjyN/PbAoYLG7lIQeLM
         nr9NcjMOP+29b17MTGD8UeZYyo5W6GIF/a/9bWVXXm/n5fJDzU8gH4CI+PI9E3JoZzmb
         ZXUCLbDbgCyLMxHxoA5nwe4tsxLfqExPgce3JdyJV+fKAEgR0bJxrf4SHq+jM2OKtlHv
         j24WacOSLGOvZEdHn+60g9LUDktq4U8Y7tr3ywoszuFqMKhJtlfms/MJeoVzYClp7oR2
         E1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ePLUHmonyPNDLPv4byza3Ws5AVjTjCE7Twc5jE/g3/c=;
        fh=eILCYj8ZD4hy+5SrqMtzn1NZxEEZJDaGGTuH+X6DQOc=;
        b=jAhulbBG9JrfGkpvOcBy13R7xeiRSo/wS4EMgDTCv1YjzleB0uf152LCKN9lQCiZiE
         2OxdtW6XrJU5O5HRIbJv62bbTCnu4oXDKxl4gJBSrB0GkCfZgi/8kXIZOp1xC1fMJ465
         m7rf/7Y3l2gwOO5ScBl2YfG16TNk3AApmcFTGAquvKLa7OEvJi1mNLTi+v9BLF0o8KOA
         tJDUDr4tziUhot+6SSat4jmIw7myYjIz6gr67ZLbAeU1BGEk72ph+2kisS3o2/jkzFLM
         wNRs3wsUcqJwEb3dDvGygMGhUksH9W16Ihv+OXfRjhZyof5T2ECSQMogyI+GJC3RP5ao
         eeBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772643687; x=1773248487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePLUHmonyPNDLPv4byza3Ws5AVjTjCE7Twc5jE/g3/c=;
        b=D7i89NJOBHJK4Qdjk5QMBbofS2WkvfJ0JrKq+cZhOvNeJC0J5K1c466EOCXOEIQJJ4
         /pWX3W0tWOt4kuAwBDujaKRLHY0E58ZoK+By4vH+OmDzzRW7ttBQlxC9m3FjwYav48UF
         CMF3hB/ZKV5EEjeDEwLRVlCZ2TxmCtifiwGDtRtG+j1WYkJFlotqzShH1uIrR3+zEwxv
         iRI+d6pfRyTLUiccr9xaPIS5bAzmetXiAjsAveJPh1H+qST+r2xksaUQP5rihNSTYO0F
         tmcoDC+Ppvg1kl+fvM0H0IPHfUdrMWITRBdamvPAnUbUyqfsBr4q1Z4lwZ+V0iuIFOW5
         u+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643687; x=1773248487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePLUHmonyPNDLPv4byza3Ws5AVjTjCE7Twc5jE/g3/c=;
        b=kJ/iOS7Gw2zma4quLGxWvf7RXgn20FkD2WgE7YpiBExTg1u2npVpF1N2OiWHVAdTPO
         XAmukcI76GmMV/iF3WHBdwtDpf7nNG+dcRAzy2kTV/wrXEINdPjP0Bd3C816LK1S1MMk
         fuvsk6xrSQZV6oeOtMJY0sujEsy8xsoSNjfoitUpFuEJzru8qW693gFqlEYZ2A1444Gk
         pyoPgrTvwru27bmGmAJKyLuksViiUwA+lZ6wNQhwbD1JFGIgQX6bkBRzeUFbmM+7lkxJ
         /tBOv5FrbwlxL728n/5FFMCSlijbOQKITuUoNz2edOy5SyXiNC7eh5JBcLNPpxeaQzcT
         bGXg==
X-Forwarded-Encrypted: i=1; AJvYcCVSRAfAzNiqlr2WoN8KZgkS8ovgPHbQ59M9w3LtIWUROZPxuuSyU/GHyD9aBZdEZ1f5KGOO7kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuGaebNaGK04vPinCJ8JOhzhN10lT+jzWyBCyMCYz7ABJg6CO
	tHXKaphPiUcVz9zEmw1lK8rzk+xPLa8LRgp2LLmU4kGS/ln0asfmskyvUI1Q1XEb0+f6Z3/Jd7f
	YypGxP/r9RGJA8TGPbnLrxbMKU1SlJ9EKj1YS8LQP6naJ4ik3X1x+pDSY
X-Gm-Gg: ATEYQzzFdith49Jjyiu38kaX99IozfXLhuL5FJvZB12NgIHkGtZvTbFb9BsHLE5x0NT
	tZPtgDAlKgvkK1nzzXcsZiQR1GwYu6Roz+2w336PeyYsnzrV+662uPVpWe1878Zt7gZXgi9iW5A
	zBffG6abe2jNeQn58fQ5BDkVeq5XUh25PaoeyS/f7mMETXVkL+ghUX7KqEOBmyib4oxylt8P8wH
	GLAeNB9+eR/zOabZNA8yauD/OrosTQPF6SSMUPkCIKlk8xFuLCWDY+zo56OqxczmVef719O9RT2
	Dz8y2ADaBS5uVm3pEIhBv2w+3er5sNUtw3wz8w==
X-Received: by 2002:a05:622a:292:b0:506:2116:4b93 with SMTP id
 d75a77b69052e-508e4340fbfmr1023241cf.10.1772643686103; Wed, 04 Mar 2026
 09:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304094318.1769536-1-edumazet@google.com> <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
 <CANn89i+SQd4H7q=ELJp7-aaN5PyZ-Oakoy9MHZpbuX1iGKV1ag@mail.gmail.com> <CANn89iKvXbBGXb7Uzu9ZCi+M65SwmMxoGM0C-HR6cO1+PxyYbA@mail.gmail.com>
In-Reply-To: <CANn89iKvXbBGXb7Uzu9ZCi+M65SwmMxoGM0C-HR6cO1+PxyYbA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 4 Mar 2026 09:01:09 -0800
X-Gm-Features: AaiRm51jn_WE54HEEGMlEjL1hUK6fpZMvYy96zmBM48YkLYGt67qy9y1LxpLA8g
Message-ID: <CADVnQymwOvzW1LWvVpGPULsu3LbkLULLWX06o_1FHVT9piC=uA@mail.gmail.com>
Subject: Re: [PATCH net-next] inet_diag: report delayed ack timer information
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E3696204DA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263939-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 8:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Mar 4, 2026 at 5:00=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Mar 4, 2026 at 4:48=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> > >
> > > On 3/4/26 2:43 AM, Eric Dumazet wrote:
> > > > inet_sk_diag_fill() populates r->idiag_timer with the following
> > > > precedence order:
> > > >
> > > > 1 - Retransmit timer.
> > > > 4 - Probe0 timer.
> > > > 2 - Keepalive timer.
> > > >
> > > > This patch adds a new value, last in the list, if other timers
> > > > are not active.
> > > >
> > > > 5 - Delayed ACK timer.
> > > >
> > > > A corresponding iproute2 patch is needed to replace "unknown"
> > > > with "delack":
> > >
> > > ...
> > >
> > > > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> > > > index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df0=
4644c00bf5c7db4e150d2 100644
> > > > --- a/net/ipv4/inet_diag.c
> > > > +++ b/net/ipv4/inet_diag.c
> > > > @@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct =
inet_connection_sock *icsk,
> > > >               r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out)=
;
> > > >               r->idiag_expires =3D
> > > >                       jiffies_delta_to_msecs(icsk->icsk_keepalive_t=
imer.expires - jiffies);
> > > > +     } else if (timer_pending(&icsk->icsk_delack_timer)) {
> > > > +             r->idiag_timer =3D 5;
> > >
> > > How come the idiag_timer values an enum in
> > > include/uapi/linux/inet_diag.h since this is a uapi?
> >
> > Yes, this can be done, although we survived all these years without it.
> >
> > Do you want to send a patch or should I implement this idea ?
>
> I will squash in V2 :
>
> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_dia=
g.h
> index 86bb2e8b17c9f197fd49cf7996d5e4f555a9b8e8..21f0d735fbae206cf2e1e5739=
12a324bb2eb64d9
> 100644
> --- a/include/uapi/linux/inet_diag.h
> +++ b/include/uapi/linux/inet_diag.h
> @@ -129,6 +129,15 @@ struct inet_diag_msg {
>         __u32   idiag_inode;
>  };
>
> +enum {
> +       IDIAG_TIMER_OFF,
> +       IDIAG_TIMER_ON,
> +       IDIAG_TIMER_KEEPALIVE,
> +       IDIAG_TIMER_TIMEWAIT,
> +       IDIAG_TIMER_PROBE0,
> +       IDIAG_TIMER_DELACK,
> +};
> +
>  /* Extensions */
>
>  enum {
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index e4cb18061aefcc22df04644c00bf5c7db4e150d2..34b77aa87d0a48bcbceb7f293=
5a210a347812cc6
> 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -241,7 +241,7 @@ int inet_sk_diag_fill(struct sock *sk, struct
> inet_connection_sock *icsk,
>
>         inet_diag_msg_common_fill(r, sk);
>         r->idiag_state =3D sk->sk_state;
> -       r->idiag_timer =3D 0;
> +       r->idiag_timer =3D IDIAG_TIMER_OFF;
>         r->idiag_retrans =3D 0;
>         r->idiag_expires =3D 0;
>
> @@ -284,22 +284,23 @@ int inet_sk_diag_fill(struct sock *sk, struct
> inet_connection_sock *icsk,
>         if (icsk_pending =3D=3D ICSK_TIME_RETRANS ||
>             icsk_pending =3D=3D ICSK_TIME_REO_TIMEOUT ||
>             icsk_pending =3D=3D ICSK_TIME_LOSS_PROBE) {
> -               r->idiag_timer =3D 1;
> +               r->idiag_timer =3D IDIAG_TIMER_ON;
>                 r->idiag_retrans =3D READ_ONCE(icsk->icsk_retransmits);
>                 r->idiag_expires =3D
>                         jiffies_delta_to_msecs(tcp_timeout_expires(sk)
> - jiffies);
>         } else if (icsk_pending =3D=3D ICSK_TIME_PROBE0) {
> -               r->idiag_timer =3D 4;
> +               r->idiag_timer =3D IDIAG_TIMER_PROBE0;
>                 r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
>                 r->idiag_expires =3D
>                         jiffies_delta_to_msecs(tcp_timeout_expires(sk)
> - jiffies);
>         } else if (timer_pending(&icsk->icsk_keepalive_timer)) {
> -               r->idiag_timer =3D 2;
> +               r->idiag_timer =3D IDIAG_TIMER_KEEPALIVE;
>                 r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
>                 r->idiag_expires =3D
>
> jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
> -       } else if (timer_pending(&icsk->icsk_delack_timer)) {
> -               r->idiag_timer =3D 5;
> +       } else if ((READ_ONCE(icsk->icsk_ack.pending) & ICSK_ACK_TIMER) &=
&
> +                  timer_pending(&icsk->icsk_delack_timer)) {
> +               r->idiag_timer =3D IDIAG_TIMER_DELACK;
>                 r->idiag_expires =3D
>
> jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
>         }
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index d83efd91f461c8ad0157faeebae051b32cb07bf4..3e8ee2054466e109644a758f8=
b4f0a646e22e456
> 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -212,7 +212,7 @@ static int tcp_twsk_diag_fill(struct sock *sk,
>         r->idiag_retrans      =3D 0;
>
>         r->idiag_state        =3D READ_ONCE(tw->tw_substate);
> -       r->idiag_timer        =3D 3;
> +       r->idiag_timer        =3D IDIAG_TIMER_TIMEWAIT;
>         tmo =3D tw->tw_timer.expires - jiffies;
>         r->idiag_expires      =3D jiffies_delta_to_msecs(tmo);
>         r->idiag_rqueue       =3D 0;

V2 looks fantastic to me. Thanks, Eric!

neal

