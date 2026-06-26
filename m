Return-Path: <netdev+bounces-302279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7QfCDPQNP2rlOQkAu9opvQ
	(envelope-from <netdev+bounces-302279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC196D0873
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RFnbfnoj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302279-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F13D3008689
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B421E30BB9B;
	Fri, 26 Jun 2026 23:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0A28E0F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 23:40:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782517230; cv=pass; b=jZ4KhDT7njupNPdFomhtc5PAmfzTrmrv1EDYG8F5fbTOPN+7OhcGLSkywctkKcUrPbjtGOvW07wkz5ytnB5IvqD1S4Llkjykgq9FO0y888sLvJotMv1mmWcw+OtjrVjuhKYneUFDaGRDR3culcj+aOQrA581B6N/EUwq7osvxEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782517230; c=relaxed/simple;
	bh=vOwNTWptAgYzKdREjHQnzWTq5/l5S6TcCLWGk01eaUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyWFhYJ/b4wF8TkKaSsaMszChb9ppzuJXo9v3mqZ0ie+IOkRlVvkQfkSmtGON0CJKzdtiz2dfUrgXiARNqTD3grwoEjDm1z4ARZN0l03bW2Lyi/JvTFcijfw9Rb9eDUzjsagGQBebJhJfSaxaeqf5UavH08XgAE3ghQ7nloy2h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFnbfnoj; arc=pass smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-139edc6bfc0so1201377c88.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782517228; cv=none;
        d=google.com; s=arc-20260327;
        b=XJr/xI/OsHXpxxTYaBTJQ3036+FCz21j0BRjUL4+AkVLuGHH4Hfkb5zfopMz/7kJRF
         86HxKHje3LUOlwFFrkdihNWYqt4/XzqsblSCTplGjk9cojle6UVuLx5LTNETV2Y2Q8Kb
         WFyRfs4CtCYvzW2eIKX7CAchpCXqi4/nOnnVHlx+0ne+q6JAz8uLCEd9Vh5UUcCQHo/x
         EStyLmO+QATTubRXw9p7cetIWi6LapRvviWvfSSJ/nOSABEGa0v+lTc0G4i8tfan3NRI
         /gEBrg6diBSJg7x8t3ggZ5vQEVQ5ke5A4j+1HVWQS1CUzlkIuu7sY1PGEL7CG301Z13F
         1/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOfrINdpJM+zKLAk//ftt1Vs/ii9P6kTgvF4dqWtGLU=;
        fh=COCQ3EoS6tjjvBULIhjXEHfdz5vKUHlUCYF4D/iOS7I=;
        b=qBSoxLlN0F3XvE7NfPU7wy1A+9T7bRQbA4Hr6YrRBofVAtahZNlW3WiFG4TvgtSG/W
         U4UXM1Bo6AQTbOsrLHn/QOwDHNsyKCDUNY8h2w12hv/2ZN/T8UF/Etf472ppQ9qu3GtV
         f6be9XOdoKGBeYxfubtXpnmRiYN+agMKAgsyV79o4AeaAhyydqz35ednYS/H4loLYUGY
         3Bc9HrlzQouyd86LH5/DExonqOK8IILD+/EmgOm5r0VyfCqiksGTfozQoTujCp+sJga0
         iN2ht7P1sQR186sAr7TjRanltMvRR5EpiSETl4s51jyrZXwckLNVDNNl7AZ14s8Ntt5W
         bY+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782517228; x=1783122028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOfrINdpJM+zKLAk//ftt1Vs/ii9P6kTgvF4dqWtGLU=;
        b=RFnbfnojLJFBigPZMRN/UxfOv7LLExCFq9SF4XscKJArbRE5PO2iVkPpRJLMmkRilo
         amXzYoYbrtqA8muGXONxVXDMzURJQgG2+njHgcqzg0N1KU1yCNyptfX2qDXV6xoZ6GSa
         lCMg8HR6BbQqpkessdBIwYRZYoPp58clHZ0yrPjGH/qe1q3xQdfjTFGsnwxpTuOVxPbT
         ItDnZLi46MjgfofmREpCBQBNIpLr8Yikm+23q51GJzMR3NTC/8w3VhZOLhyf0SJrk3hT
         YE/mhffHEpoTXHikzFVuHDUkdCaVCRuefdcZq7Wxk3DgjPw83dNAqourV8vEfTajlk/p
         P2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782517228; x=1783122028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOfrINdpJM+zKLAk//ftt1Vs/ii9P6kTgvF4dqWtGLU=;
        b=YAYOk9QkYdsV6Zo7H+1rv3vMCcMiMCq4mu9CabwPUa+7qKSD8FXiRdPlDyrAUupZhI
         Cu07rSL4RV647o8IJksSt9edghnZpLL+GLFd8r8djJVV68Y0faAOxBuHGXAatg2s2oNF
         kePM12YfYbFQ6Ze3yW72zkHuM8Yn4pindOXHFnrtHWddYZzfZdDDsm0q396vcXUv9EPL
         Gyq6pn11BaDkayOpmuV3nOWAt3TJLNsUZzvUoI7G3XvVIrNiW0ZdUhGXxO9JfPiJvx/N
         0Xlf/sbYDJPPlsTVU1kKvswM8n/BT706ucZzze5eX4y1od3Ecg80urlwgT2HWwGL7Mcr
         Iqag==
X-Forwarded-Encrypted: i=1; AFNElJ/ARdbwOoVjdrXQZzJXNJeysWd6lQz/fs3EySAr4FnzB/V6dGtTbr88AdS+2vCdNiPa/kNOE3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwrgLLKNWTXsLBk7SykITVOpFAh2RQocQ2PoXG4+31z1aF4cz
	SH7VzElBp0/R89GGH0VsQqxGfo+sGqZMLqgdBHqcnh4rWZs/+7oe9SYs8eaochE1PIhhhP/XOvA
	yqG5mYelrzaIcYQDeg72MJ5MV2xC82/Nyig7XmE5r
X-Gm-Gg: AfdE7clMJC+/8lQzi8R5eLwR9KOrbQe4AmY+7+iYhPxNz7RQH0CbittaV42NdUowpto
	1taNcImJgs1A60S7vHfWAAB8PLV1PFePkX1q5sWFfxdv0X7JpL/JCX9ei5ygUUoWxuMQuQz1uGn
	xV0HL4qm5ZnBVSE/7LNKASec8UL3i3zWZfwz4NBxPnI3duJgICuUSF7i+XBnr9+psUYcOOBUnsV
	7l+3D3QtxYNry9NDBGnikUgAw1IvoAA0pXRSxXYNXE8c9yygvGR7mEuskNBsEhv2GAYIKHfejSb
	wnd1qGgEYWo/cpArLWoX3q6Lg6/M6jn7T6ePEh7EzQ1YIsEC+yV0b7whzdjXHSSQJPOgj29M1k/
	cM/4MsYa7b2c0lxYa+R464+hcL1dSdPt6tnmF6k4=
X-Received: by 2002:a05:7022:6626:b0:139:8172:76a6 with SMTP id
 a92af1059eb24-139dbaa5c0fmr6979225c88.1.1782517226857; Fri, 26 Jun 2026
 16:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 16:40:14 -0700
X-Gm-Features: AVVi8CdhF44udywOOBpjvR8ZTQpjpP1Xll4rjBb8Q8najFeZ8yAEAMuLRnNfllE
Message-ID: <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local
 bind range
To: xuanqiang.luo@linux.dev
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, luoxuanqiang <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email,kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FC196D0873

On Fri, Jun 26, 2026 at 2:40=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>
> IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral port
> range on a per-socket basis.  __inet_hash_connect() already treats such a
> range as an explicit application partition and scans it with step 1 [1].
>
> Do the same in inet_csk_find_open_port():

What's the use case of IP_LOCAL_PORT_RANGE + bind(, 0)
without IP_BIND_ADDRESS_NO_PORT ?


> when a socket-local range is set,
> walk the whole selected range instead of first splitting it by parity.
> Keep the existing step-2 parity behavior for sockets using the netns rang=
e,
> so the default bind/connect separation remains unchanged.
>
> [1] https://lore.kernel.org/r/20231214192939.1962891-3-edumazet@google.co=
m
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
> ---
>  net/ipv4/inet_connection_sock.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 56902bba54838..ad8af70c92ca3 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -323,13 +323,16 @@ inet_csk_find_open_port(const struct sock *sk, stru=
ct inet_bind_bucket **tb_ret,
>         struct inet_bind2_bucket *tb2;
>         struct inet_bind_bucket *tb;
>         u32 remaining, offset;
> +       bool local_ports;
>         bool relax =3D false;
> +       int step;
>
>         l3mdev =3D inet_sk_bound_l3mdev(sk);
>  ports_exhausted:
>         attempt_half =3D (sk->sk_reuse =3D=3D SK_CAN_REUSE) ? 1 : 0;
>  other_half_scan:
> -       inet_sk_get_local_port_range(sk, &low, &high);
> +       local_ports =3D inet_sk_get_local_port_range(sk, &low, &high);
> +       step =3D local_ports ? 1 : 2;
>         high++; /* [32768, 60999] -> [32768, 61000[ */
>         if (high - low < 4)
>                 attempt_half =3D 0;
> @@ -342,18 +345,19 @@ inet_csk_find_open_port(const struct sock *sk, stru=
ct inet_bind_bucket **tb_ret,
>                         low =3D half;
>         }
>         remaining =3D high - low;
> -       if (likely(remaining > 1))
> +       if (!local_ports && remaining > 1)
>                 remaining &=3D ~1U;
>
>         offset =3D get_random_u32_below(remaining);
>         /* __inet_hash_connect() favors ports having @low parity
>          * We do the opposite to not pollute connect() users.
>          */
> -       offset |=3D 1U;
> +       if (!local_ports)
> +               offset |=3D 1U;
>
>  other_parity_scan:
>         port =3D low + offset;
> -       for (i =3D 0; i < remaining; i +=3D 2, port +=3D 2) {
> +       for (i =3D 0; i < remaining; i +=3D step, port +=3D step) {
>                 if (unlikely(port >=3D high))
>                         port -=3D remaining;
>                 if (inet_is_local_reserved_port(net, port))
> @@ -384,9 +388,11 @@ inet_csk_find_open_port(const struct sock *sk, struc=
t inet_bind_bucket **tb_ret,
>                 cond_resched();
>         }
>
> -       offset--;
> -       if (!(offset & 1))
> -               goto other_parity_scan;
> +       if (!local_ports) {
> +               offset--;
> +               if (!(offset & 1))
> +                       goto other_parity_scan;
> +       }
>
>         if (attempt_half =3D=3D 1) {
>                 /* OK we now try the upper half of the range */
> --
> 2.43.0
>

