Return-Path: <netdev+bounces-307406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HaEGHTb/VWp2xgAAu9opvQ
	(envelope-from <netdev+bounces-307406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:19:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD10752C22
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:19:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RfGnb3jQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307406-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ABEA301F8E3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED943CEEB;
	Tue, 14 Jul 2026 09:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D3FA5EF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:19:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020788; cv=pass; b=tXWYdvHIdvhX1XJ/ya6B/sBP9cRBit3ulhyw0oaPOB+ADUeWkjJveJrK8S7u+XH9CzupTfulvx9MquvIOVb0xBAlxhlhh8349vU42MHYoJwTWFqhmzqPqHaaVXpihJuL+x/pj/1D3/we/bUEzP+VB8+GVoyWR64iSrqgfUMHNvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020788; c=relaxed/simple;
	bh=6PmlsKXE0MCYpvR9KItzVmj6YlhEjITKeeccrh9fVoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jI/Qopq+TqMaAhVwurhL6zYqLGhMC+A73TPx4ONB2EUl1lOC33sW6DoFuA3Wz6nAZSDrmegDUv5QJlgImGFF5LzQe9sNSJsvuJEgbSLLWOX7kVvrjbd4Yi3P/eEDFClSO+ALfWdNB1JeP+eMKY6rixbbdLyLXWr/hZUS3Zd+lqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfGnb3jQ; arc=pass smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so461936a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020786; cv=none;
        d=google.com; s=arc-20260327;
        b=P0KZ73sslMrn4wIEndsq/hHhWzljC63Ao5H8o0V6XLgOOL/BvOzzrtLoLsf1o0hFmO
         lI62vFhWgBH3wX5jUZaq15MwwtDPfINHQGB5PQI+heyucxLJKSq7tnfoOIR5tpxufBNE
         5AquURWqZI50korrVrDpUu3MVkQdHtJoRLC5LuAK+19S7/fdh/+REZzgsGSaat/ZYKif
         D9uA5HhaItHVU1t10ns+r/+Id7G+VzzUQTDjyMAAVr7cMJvrKzsPxWMiAbJIPB+3FnNL
         +rENMGL9AwnDnHZAiM+2Km9tFl12kdltKrv82l0FH8RNyyTrZszN45cNoaiW4ACmkJ6T
         diKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        fh=NGBksKW7b3HjWIpidgBADQodEbrbi223FbkdmLsrO+c=;
        b=INB9uY5+5moGe8vmGrgI1mZJwrVJuxYWnl/Efvz8HsgaHsAluJr+kbeuvQLyWbGG3F
         NzL3zoZ5nTj737DqvK+aXKs+R6GTYrgjkl9/9Twk8+hgOgLoreSa5+wnPkQwJ9o/j12p
         np1OS9IMV4bsI+9sbuEo4V/8/4BznSZZ5WeLwuaAFVf0+hy1/o0a3gFjEVZvUPgVZIlW
         dle8wBI+7+BzhHuPgOdWHpbyoVlgIl19L+WwmqCmJGjemvuKKfY1O1PbA/h2ISgiVLou
         AwOcqR3WUVIwBfQiWVFOZszSKlIAs386w+R3WNGGCzGfz9IdN9HHp1Doh0mban6BBiv5
         zdJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020786; x=1784625586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        b=RfGnb3jQs2u1C3Rtb3uOzdBmouoz4pns2w1G55aCDQotLeEnY1Rt1MJdxBPK79FHQZ
         Eq2gRudGFB0AG2geNG17s7f4LHFiwGrlfplzhc5NhZPy4hvnGXvaSvfbQ4L04imX/FF2
         xY3rea1ElAmxwYJu5mPgvsjpI2xUemPqOedhzfGhU5a7sBKYEHjvzAf0Jp5j0Vqn/HrL
         bhn3eaOQJEgl2vrtm7j5IG4rT4sK4WjscWoey7Dqc2krOdnkQ7uEQqFkqeby6bGFk/mF
         q7Kn1WiPXCjePlt8EnYpumUs7xV9daBxAP6XG8CrkBTEcEsVfgqWk5U9jActlKGHTUlF
         UfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020786; x=1784625586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        b=X8HZqht3KgggmxwxdkLP/m54OJv2VIFNo1sxEiOphANOjWM6i58FFg/BeBZ0UuoMdp
         ffTRBWvWiFZxFoSy9zEWb9x3BAuBSVShDNGaX/jnaYP3Lz4zAcNGscZxJyxUEfxlG4qC
         QYyr2HAlFHF+xE2KEh6oK4MyuYB11MDsg5Od45DylK02Ypn+NBoE3yLngo5lLtlrsHUP
         Va1BAv6LklZzA1ZzAbEdKw8jLRJLgyAl517yXyAuRJ4+JZmOYjPhDwjqMxwQq4toU21h
         4X7cmLrK/cJYiu9SB7ZkS75OJwyudUv9vQd3jdM1gMe1a0fBUOUoGBRFZnGv556lG2Bv
         gapg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1MhLdsTAUNSo6SI+xVRMqag+50m7M+fm66tkfLpJCpzjM3YMFkcZr9ZJFX7RlLOSl0PnjzzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ONtamFP3tW4sX/Clt/tgxbkP7O46T01W9j/qfNwxU4+YQY4b
	PxLWTuSQJhyfBkrPPFJ9IEcJMfF9hwjQmseM1r2iKBrfNaOzmL4zwOKoH3A9u7CsL8Zzpo/YHnR
	ZiA2OnPDepuAekRkjuovTtNhd+Bz1gmkAzyzj661a
X-Gm-Gg: AfdE7cl6kWyBYn3XmQn7llKuKcu61mjeEscZ7AEgC8Wzh2seLpNkIr7UKOaABsDzqMr
	NQEvo11l8Wbb9iVfutJQvx6lHGhQiyWzadIUy0dXlvpxlql11iU2ArcmxX5iCcFsN/BNuxH7QOj
	IGvGFybN5/bh1+5/xSfamJ3QA7qOPT3Wyq4P6I24p2TthgwxgQBXvp9mlkBxwj1lJFa7AF3zZ3Q
	9UH+CCfrZL80jcGXMCjE140Z5XPTMpmHSe2zajwtzb+tblVAQsFutJ9RYeljzgS5yk5j8bAh0PD
	o1KCFgF1P0KC58ToZQkeqPW0sYxHW6L+YInekEmb1RscctBThombGNNqetuzXIktAunzQEZBd2j
	mV/6t2uof9Wk=
X-Received: by 2002:a05:6a21:3116:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c110ad50a7mr13080453637.53.1784020785828; Tue, 14 Jul 2026
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260712192958.1631672-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Jul 2026 11:19:34 +0200
X-Gm-Features: AVVi8CdkdJq4l6QltZm6uQsqemNybzBK7YVO4LUopurosDpikg8UT-W_TW5bYlc
Message-ID: <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
Subject: Re: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all
 socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307406-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,xs4all.nl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BD10752C22

On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> fall through to the generic sock_setsockopt(), failing with
> -ENOPROTOOPT.
>
> Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), a=
nd
> also for accepted sockets in unix_accept() (reachable for stream and
> seqpacket).
>
> This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UN=
IX
> socket types.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  net/unix/af_unix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..3d256255085b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, int l=
evel, int optname,
>         switch (optname) {
>         case SO_INQ:
>                 if (sk->sk_type !=3D SOCK_STREAM)
> -                       return -EINVAL;
> +                       return -ENOPROTOOPT;
>
>                 if (val > 1 || val < 0)
>                         return -EINVAL;
> @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =3D {
>  #endif
>         .listen =3D       sock_no_listen,
>         .shutdown =3D     unix_shutdown,
> +       .setsockopt =3D   unix_setsockopt,
>         .sendmsg =3D      unix_dgram_sendmsg,
>         .read_skb =3D     unix_read_skb,
>         .recvmsg =3D      unix_dgram_recvmsg,
> @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_ops =
=3D {
>  #endif
>         .listen =3D       unix_listen,
>         .shutdown =3D     unix_shutdown,
> +       .setsockopt =3D   unix_setsockopt,
>         .sendmsg =3D      unix_seqpacket_sendmsg,
>         .recvmsg =3D      unix_seqpacket_recvmsg,
>         .mmap =3D         sock_no_mmap,
> @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct soc=
ket *sock, int protocol,
>         if (protocol && protocol !=3D PF_UNIX)
>                 return -EPROTONOSUPPORT;
>
> +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);

Please move this to unix_create1(), then we don't need the chunk below.


> +
>         switch (sock->type) {
>         case SOCK_STREAM:
> -               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>                 sock->ops =3D &unix_stream_ops;
>                 break;
>                 /*
> @@ -1864,8 +1867,7 @@ static int unix_accept(struct socket *sock, struct =
socket *newsock,
>         skb_free_datagram(sk, skb);
>         wake_up_interruptible(&unix_sk(sk)->peer_wait);
>
> -       if (tsk->sk_type =3D=3D SOCK_STREAM)
> -               set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> +       set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>
>         /* attach accepted sock to socket */
>         unix_state_lock(tsk);
> --
> 2.55.0
>

