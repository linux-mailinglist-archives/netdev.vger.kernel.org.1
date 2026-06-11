Return-Path: <netdev+bounces-298246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GpyiOrjrKmrAzQMAu9opvQ
	(envelope-from <netdev+bounces-298246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:09:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4DC673DCF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tM3pjFfo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298246-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FABF32ACB20
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1143DA33;
	Thu, 11 Jun 2026 17:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442143D4EF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:01:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197275; cv=pass; b=d/knmTUNceWZZdFYvzcLScDZIkUoNBn7ZnPqa8BpBDSoiBDJ25+/pPZUCUON9kYQSqpUEu+Ik3Yn//gbdSOZo1jZmCNUi4H+nQUwk8o2juBOxeRfb58PJROXYph62CmHSt7DH8VaVMNvwOD19dTtkQe87J/Ry2XH+il3lCVPIH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197275; c=relaxed/simple;
	bh=BRG/+Vzt4T53h7k5QJdHXcInjK0uh6ckGOysRuKZ8Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpApn9TsuMW27AFgVN73nz5WM6fbfcxB7EOiqKV3qufCtd8wVdnqTbvOhauT3U/EiKxbtsUW61QJhEEa3jpEAuB9xBkInqlzYyJw6snl1nrb2sbebFmYlDyyYp4Z43GqbJGa05GWs+hVJMvGrtyKfCQ9f3ljjAjcIGHKlGyQfqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tM3pjFfo; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ddd3d67084so628897b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781197271; cv=none;
        d=google.com; s=arc-20240605;
        b=OuWrGsm8skPFuNWZSFi+d2vcOL4H61vMSjBRXUT1ZbDFlWraaK9hjQpsTqBrsswWOn
         kli3zBWGg04h5Rfu7FmzfEl/NuqMoCjIPwFjdVrXLpl3mPcLEcR0wMcCp92yL3Ies2u5
         TfYp13fW6FxnPXhpv2yk0F7WDjp8CIC3ypYHdZip2FXgsf4o6LURA10Pz1f/Ngpuwh1e
         oYefnChIGDSLYJv+uR3XvnVpSujuHd65aU+YcUiyXi1RNY/PqwpFzcgxJjo5NwU5gMYD
         mE3EUQbF+X0nVD7N0t38ZRwqJqVcZK95gRXHecDyhlr+LLDbiWv1CjzJYB8IlMEvacE3
         EV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        fh=1ECodCPcSh8UcAMLAZrqcsOYqM8lCS5qTkyd7sa9S4c=;
        b=Ft3VdnyYZD2to2gsrDmrxa8iBbtoByO9nj3kfRwZyF2uhG+Mlq0F3yWCiQOO6MaJSW
         hZwomriRKwlkbH2dNRthm171YHLwKN55u7+9lufhQgR2DGfpoHjsxfeXOhNRZbT8mq9H
         QlMs8zBVeYLO783WGH+o97TK0vStbyt20NecCGPAZ728OOEMiFJdvyP6auLz+/gYaXk4
         8+P4asyY9PKwdiXYQm81gDIhpjdZ1RxMQqk5aGYeiUAugz5bldErQoJTgV2Ta2IqMRV4
         PiZDtxt1ZHAWiOfFLXuAScskhRLTEIUPeP6erh6bK+BbaaVy5V4D/WbmyJiCylynoSDe
         9v6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781197271; x=1781802071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        b=tM3pjFfokCbPZbIXWfqvS5Fp8MML/h9bYU7nUBklrZq/4D3YyD5c8f/cVlStsxJswz
         ZDwGDWKDbA+vyJlLqVX1+t8NMry+OHpB3S+aY8XktmJjpDT/puuzBeCYHGOUKPdk58Kg
         ss0LfwiRu9sMwPNgq6cH2NzPs+0x0Goo3xE7uJtqOUyQtRx4/Rvo6PycT5RhtT2tiS/4
         LPy/o+IV28FmJL1Tjk+v/H+PzyE81ANkMq0oUts8+G/rjiiu7xdLpFYZrPL8V037DdAx
         y8STMM118lfIFptobHEGv5hMcwL9Q7/6GtLrbt6UjXeHOInUqbHAc5tFdOq5prpy6o40
         NiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197271; x=1781802071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAYyJrdDmGO0RJNipWyudCHDG9PqIFDzzEaVoKYHsmE=;
        b=fEP/RH+qDXM/uCFLDMcyZJ2setByqMEb+DxpXAcUcmOg9oun/bg+eyvH+dfk7kh/zo
         Nz69AOEtJhe7B/kNM/shDNukbT3IgP3svXpAL5v0x9YAKkjvQ+mL9D2EdzzDFMFwVJtx
         eyAnpbuF6Inx09YYZuNv6flWFhHjhXj7mI2s79P5VZKvdg0nMr0Cmd/uw1kYY2zxoKNf
         JAuqMJ4uGWPNMAAnVExpUqvP9a0PF5pSsqkwrpTB1zW0FRFk5t7xrWd0flKvah9arAKa
         c2tiFVmaMb/fdPqc+6Yt4Yd9gFSk6Hw1p6vXkIBRMyfyohgqphMcKBH9ErLwzmi036SK
         SUsA==
X-Forwarded-Encrypted: i=1; AFNElJ+ACJPTUmxpeVFPkXejIe3e8axR/PILRIF/Y5APvlnE1VOLYjFIy2VAsEaE8ND10bpJcxX2Vlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AW7lGvGgPjEWGeAb+rrSZr63OECFvPl+e4Yco7s6/ec0BIqC
	uWsa07rsJj3TolzYJUeoNZ8AC4tNy7I6WjP6Esu7lnh3zvS5Hl2DOcJeAghP3hSO6vv672VIuPB
	Kcx8hwF7wYMD9qQSoldJqrZ55epQUpZW4jTahW3mN
X-Gm-Gg: Acq92OHXCKjwzdgncI52UyYShij2+h1vNgQycJijkiGInFEtt4x4BwuHfb4j+zYH1rH
	63vQisXZcI0VRwBw/qQDrXgTgzk/2j8YHUN/1YYQ5uw8ll5ebWpAVxsHkPbT+A9eMtSsCxlXXLS
	b5WA9NxJNPsNPGDVMthDr7U087TqCiP5J8yqr9r8iLBhrWTFOeNHw5LxueBNJMkVc0QhIO+ecUQ
	qXrVPefxeQrmioCTh9m7rT9KFa1Sycbe04JFxWUM03wyT+P//qCMQmehgJfcDY2FvrhV7h4HcyF
	GIRmdJ0DB0dj8ObdGMpt9j/A/DLLly1O/+5OOFkLpJVKw+NmZItq0pCvtNhrMoEnVBQbA5S1G4q
	CTfpwBa3BaFewrpwtaYHflVW/4bYUiA==
X-Received: by 2002:a05:690c:690e:b0:7e0:97eb:f3cc with SMTP id
 00721157ae682-7f6570993bamr43002157b3.28.1781197270694; Thu, 11 Jun 2026
 10:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com> <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 10:00:57 -0700
X-Gm-Features: AVVi8CdtI2GzmyptA-tGAGNyn1dR7786EfJbaaPlfBCtP3di1yIY6vTdixZaV4g
Message-ID: <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: chia-yu.chang@nokia-bell-labs.com
Cc: horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298246-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chia-yu.chang@nokia-bell-labs.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,gmail.com,google.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,nokia-bell-labs.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A4DC673DCF

On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> This patch adds tso_segs() CC callbak for CC algorithm to provides
> explicit tso segment number of each data burst and overrides
> tcp_tso_autosize().
>
> No functional change.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h     | 3 +++
>  net/ipv4/tcp_output.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e8090f542f7c..3b415c9dcc54 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
>         /* override sysctl_tcp_min_tso_segs (optional) */
>         u32 (*min_tso_segs)(struct sock *sk);
>
> +       /* override tcp_tso_autosize */
> +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> +
>         /* new value of cwnd after loss (required) */
>         u32  (*undo_cwnd)(struct sock *sk);
>         /* returns the multiplier used in tcp_sndbuf_expand (optional) */
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index fe725d94a225..a7206fa61957 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned i=
nt mss_now)
>                         ca_ops->min_tso_segs(sk) :
>                         READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_s=
egs);
>
> -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +       tso_segs =3D ca_ops->tso_segs ?
> +                       ca_ops->tso_segs(sk, mss_now) :
> +                       tcp_tso_autosize(sk, mss_now, min_tso);
>         return min_t(u32, tso_segs, sk->sk_gso_max_segs);
>  }

Can you explain why min_tso_segs() is not enough?

We do not need two different mechanisms.

