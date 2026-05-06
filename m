Return-Path: <netdev+bounces-284651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJLVOeqc+mkKQQMAu9opvQ
	(envelope-from <netdev+bounces-284651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8F4D561B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC04B3016263
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90808258EFF;
	Wed,  6 May 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOutQGeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06D211A14
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031846; cv=pass; b=Pl0VyM0gPp1wDcorxRz2qhdj/NKcN+QpNxYfcWTEQrGoCrIYg3S3RnuIwOKM+EKn8CW433I5ii1PAiQ6ekBtQ5HkhAh6q8+4YBK3M9GiZAio64J0zaZDd50jaVGu1sLZ7z2wD7aKbFAu2r0QDhG4Qe1GzldnS6U8eHkvDcZtOAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031846; c=relaxed/simple;
	bh=y2Z3q33j0yVWSthSiN6QTMXGQqEoyQEer4U2gNzupyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmgLB02g3ViP8IIKzfeCS182wx4DU84n3nQfvZmMy4jXaaZyDwoeNPM99w1Y3U83frpCZTFxwdQF+aN2qV3j0I9lOoI9hfEoXpZKxfdCagg8B6CP0jcWmGDJ6dJf8d75lPhZ6SWcxl6q6IrfbUckJOWIzpmfHdI6/7nUmSHvaZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOutQGeH; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c88e5f4aeso343017c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 18:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778031844; cv=none;
        d=google.com; s=arc-20240605;
        b=FXjWijYKNOsp1e4a+t/55YrvhgzUKkL2lMFXgclHNQAeaLwhS8qSY9qmLiiqBk+XIs
         rEwLBNDxSMaClw/waUKaR0U89cYtqYRoBtMAPm6ywtPQNz0W+M7CkvFsIJrPN+i+CZvZ
         l5YhWwOtVl3vcGu13Ez5PNCZv436IEk9T4w8zrQ9XnRT71Rm0qR2BaI+2njEsnqfY2BJ
         5fYnMOTA98tORTZg2/ZuDv55UbxyrQBtVCMSH9DrFm/tnnSGcIfRGSqjpWQbZQbdN7TC
         ChIerb9eL/h/ZXgiYurRaiXd1tj9LF9eluNpAoD91JKQGwKGRQ5B7rtDKHG/R0bERpc8
         a36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6b30ikEraLD3Gzgss6qrjg4hUn4tXLZhZEeWeANGVQ0=;
        fh=2pIUaLxdLXlYf4wE0ZRgbeCJxF6mHakPjSNZcn2wZx4=;
        b=OLmQshJMZz0jfm389YrfYJQNplp+1YtwVrkdqE49lBimbr2Pt7THESzsi2pvdqb/id
         U3kraGKRpoHDEnKfTscwBaN0x3N9fRUNn2EeZzTSSz5fUfmz0O/YhKEyv4n6YKhE0LeH
         jOwyvzEqfDmoqmlU32oQJEiV9M7KosbnuaenUODeKtXRztnXiBN7kMTttqAfPodPHSv6
         AluaIziknpxJwMKfqCvdRPF2JYfLvK1vzj6H03vLI2d/lVkDLPnXI78qS/nW4Gk8CrIJ
         5tNpbqWpxve9TjhF/8WQzXglk1auYAzg0PL94dN7bhrSB510uzV15JXaHAkKdukRAz3/
         xHeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778031844; x=1778636644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b30ikEraLD3Gzgss6qrjg4hUn4tXLZhZEeWeANGVQ0=;
        b=OOutQGeH5WCQjC6+6lOruiiWvoruZo6+O2qvxovB71jLNC9FgdYtPG/EqpX+yxJQCR
         OEBt/oXSkeMWsveOBiwTfZrxNFG5RtFjPBV5ryaTkzXEMA6tlAUFvIlCVEylmPj3Y9+n
         P8WNw5iVg0wc7RxoOLKVwVIICP9hjgIIMzEOlJ9h8v3DgWMMOvFyy+eYMwiZhM59Hgi7
         pbbmEqloB2bh+O+Jh5yQVDcsoEJRe3NV3Z5E+P3/cl24xZ11CLcaN+hZweXFAXlYEY+c
         uAXpodtlb09+EfqJkqJe9PcI6DsMPTBz8mkTZxMlEwHUBI861VylDwCyXJ2wl8wGczLo
         h/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778031844; x=1778636644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6b30ikEraLD3Gzgss6qrjg4hUn4tXLZhZEeWeANGVQ0=;
        b=Qbg0W/+Izmd6ZJJtFF7F3eBI2XfIkpPKMHnOaXPRmQZMJlI6jwSonf+JwhdvuTXOJ/
         uMREgwMYGpcjFQNpaerhwg6xKkk2W6de8E1wtFeA7YKZOv47ZAw8w+e4IkuKiVl4Sy3V
         b3wjSxZth9r3gH7GOmG4FhZd5JJW/4wq8UeYtD0C9rC0zfTzs6nRtKpk4luwLJHuEvQG
         UdkIMCyh3f5qVUBVsUs7rstHXlZB1JEp98Hte3KireDp0z5Tia6M22Pj8On4VK2l7NAb
         KZRZu+w7ddgyBCqS3g6OQkNFtS8D6N41BlnWr0BWCuwV3KB2KbbsiiPqCjJ+8JE6yT5v
         cxnw==
X-Forwarded-Encrypted: i=1; AFNElJ/TZmCO4VLKWu2wsLaaofDX11ZOB0hu90sUW72h9XvgohrysQp0MDSpQMbBMlvhOr5LHLlEGug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPywX6qonru7ry9xcb2aYUilCIrPIAMEZunm9ZKRWxnomIoSy
	3Mpyjn/yf9J7GDaVVQDtdYXGuvSFviyMedcMeqqmnoiMhEGP0+Zbc7MJZECgLZ8eePqKF3PyqrF
	XKRjr5BEpqzlURXF9odIM4aF6mi+Qa5RPD5A1kBQcHqFh65C+9K62oP+j
X-Gm-Gg: AeBDieuMwP6+FEHMZXJWn9En/ymEkc9vvOH+bNkylGDLztvlvqrwOVdURvWudsmmfYA
	aNh9Hu5VEwMV9aMS4kBqAonniq21acTv/jKdRR1XkJ5y7Dr1xc5c5fFRKZApUMqsAU7EgJukN3e
	6fCnGMkQcqjHZtD5xw0TTPOIC275ZD5uEBT+SpphU7OwQ+OQ/Sxmix9qKpM6fGBIDTx6j2WR+WX
	NW/T88t0ja9IdaKLp+36rMw9eFs7bqt1YH/TEhy5uj6/QntJ1wIqanLzQUjj7JcMzhAlOIz4d5S
	IvHi6wmVIR3v59oM1ok12B8qUh7hFzfMv0qG119ENXB+hb+GOTlVASOK1gPzIJFaIXF2I9RhnoB
	0GB462B+MSpaXGuDBHaWrw2SWOrWohR6Kd8cwQtw=
X-Received: by 2002:a05:7022:239a:b0:12c:6ec9:3f1 with SMTP id
 a92af1059eb24-130a9ff40f1mr2928743c88.21.1778031843800; Tue, 05 May 2026
 18:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260505174904.52b20741@kernel.org>
In-Reply-To: <20260505174904.52b20741@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 5 May 2026 18:43:50 -0700
X-Gm-Features: AVHnY4LkFhPV6WKvIGe8HfWLBWaKM95-FI-qOcMfrPPvuhsExBIN7nMNGceKFnk
Message-ID: <CAAVpQUBb=Gxy5C49R_hsB1zG=yuVfOCQarDRqbX_mEs-dkr+Sw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/15] udp_tunnel: Speed up UDP tunnel device
 destruction (Part I)
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 60F8F4D561B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284651-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 5, 2026 at 5:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat,  2 May 2026 03:12:53 +0000 Kuniyuki Iwashima wrote:
> > Kuniyuki Iwashima (15):
> >   udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
> >   udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
> >   udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
> >   udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
> >   udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port()=
.
> >   vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
> >   vxlan: Store struct sock in struct vxlan_sock.
> >   vxlan: Free vxlan_sock with kfree_rcu().
> >   geneve: Store struct sock in struct geneve_sock.
> >   bareudp: Store struct sock in struct bareudp_dev.
> >   fou: Store struct sock in struct fou.
> >   amt: Store struct sock in struct amt_dev.
> >   pfcp: Store struct sock in struct pfcp_dev.
> >   tipc: Store struct sock in struct udp_bearer.
> >   udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().
>
> Excellent job splitting this into patches, pleasure to read!

Happy to hear that, thanks ;)

