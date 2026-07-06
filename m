Return-Path: <netdev+bounces-305151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id js3xGsviS2pacAEAu9opvQ
	(envelope-from <netdev+bounces-305151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103E713BEB
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="ZgA/mN2h";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305151-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305151-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D82FD30172D0
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99D3DDDAA;
	Mon,  6 Jul 2026 16:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690E37C926
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:54:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356882; cv=pass; b=YWEZPCKZs9mbUTguQ4l5GPaPjILwH7Nl1wloVm6f6CMlksVOCloeEEjoia1cMsI7QXzrx9h8/+OPEklbGyby6NrbYaI/5z9aFmu/3MmB0ZOdF+/kWfwSpjwVeazrTkGzY6Tupt3rdpcauRaAXGPlGNLqJ4jeRNvgDY05JDKl8ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356882; c=relaxed/simple;
	bh=0Y+jPbggfz0+aTRExiPF5rT44GzTy6yyUw8vlBFttSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljl3kfKkhvuykP47oU/gKqXRzsx6Efm2Kf+tdHN1CjYjwPLQqW8iBtUTS27STxN5RFaN4PX0pyH8Twy1vDes+VfaQWc5+g3XlL9kz13jHXzp407OBAnaVs4/JJ3SbZ7YzZSJP0vDdVU9eYl3raQrA4EApm8Ju7tkF5jOcXwrmD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgA/mN2h; arc=pass smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1978967a91.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356881; cv=none;
        d=google.com; s=arc-20260327;
        b=R7raUQOzEe5ECpP1sL4H0up0LqNdv1RERBh9zPNH5HhOw7C1cQR1CFZbIVuQbn0l4h
         nxxXosHFuLGB3t2MN2G2O7wWrePe8a1Yh2CH5llvFgjvyvFXcBNtyd9YwJLCvH3aC44L
         d1wP+4xW5URquFyGb2dSjDWkn7DQwJfG/tA2ie8iDqzsMmhcRRUD0OJ60QA29cUd9OsQ
         gN545RvidCwX8KTz5IHoHyOO4L4/WzS+ws2pI6cU77sMAitl0DWBpJJh/uA55Tcc1t+V
         N/uk4U+SzRufKYwe7bvHE1qbX2cObc88BHZgd5J/d6xLydrEMayXLodVvA76StpKkmtM
         flRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z4GcYX+9Z4gYXSYhgZvkx5Z4PEsTCSeVsgPumim+UhU=;
        fh=RcOvXH/jbhzgrv0V9Ln7N7ZKulXgIvtjHSyCbdBvxgs=;
        b=LinOG8EuA7Y7x3KOJTW8xz2UsqMcy/BCCtzTJxkICrXTKgsju1mVxemdYANtx3U47r
         L+4k4I2DiiC7Ojx15cRpipihlbM7oWzvnsEZTAhYuE+YWUaQx+o7DtTyrvYm8z6/dA1M
         e86kuYg3VS9MFaT1u6augaKxXg4N8u8OQ8VmRqyfjEjRJsCnSXnCRqdsvGrLMldocBen
         37TyNolIDYFRBTbohwEhLyStxac+ZoaOOaES7WIAg/HUg5vzkvejGur8ke6ekzH8o9Bi
         i/aMBayxc9X/S5FbDZQYSMd+AJjWmpLQt+aoKDziq9Lg54D5q2OS/iZM3jXoSW7iaCoz
         e/uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783356881; x=1783961681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4GcYX+9Z4gYXSYhgZvkx5Z4PEsTCSeVsgPumim+UhU=;
        b=ZgA/mN2hg5paALkOG9IQ7ytWC7hXu++4hocQJB5dB1nXB7l+9K4K/7WkDSDo3V03c7
         4rqSFGBPOGLzSbzGPqISAIfFBRm1NOHGuqQJN/x5xzTcpgpwqHM30HTObBiib7woovQ9
         0BFp6h0DAgoUswVI1GQUfw59Yzw/9G3GYGIZpqfh9tnrh4+Pm31ASSRPj2z8u5BmB2R8
         97hFwAZF1Sq+Ft7NaSdAoi2HaagsyO+4FgT29+dBCzuhhtJGhwNnZfSvSBHrw3THzJPc
         fBVsAN4hRDA/g0/WOLwydQ1PB+8GC89BGvwC1OpEgZCFqU0FJTVXyzwp/tChmRCwPLbF
         EV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356881; x=1783961681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4GcYX+9Z4gYXSYhgZvkx5Z4PEsTCSeVsgPumim+UhU=;
        b=LyJ9eQ0n/cT8kaS7wFYoHc5Tr5Sd47ucjxVaw9rPnKVivMwZIgf+ok+zOimfDp/rLK
         b5Y3dN6f5bagXqPI0noub72d2CNFc3yUaenGfa5d/7AWiip39bGUrTjxFi4iWL78UPaj
         PWhv+I+8+PC8lm28AKbkM8XcGndqk900+g6EgjxUqlEuOS8qB2wV50GCZEoOc0aoTWMr
         b7bbwm8OvLniZZTG2QaWr5Tph8BIaqsX3nJWA/QtbJpNqqzDpYLxGrmNUcxMC9tdcJ0r
         UeZprwjnrx140mH86hNcf5nrmwFbJ8KYFnm+beyRbH77zkw/xtUlbVR/2LVfyEWrTpu5
         SWdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMXHxwyCBG4qtSdszJ610oeaCLsRJVyffVO+G4+l/lVl3vCwuoU6bUBwaKyM0K3sFpF6gnU/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaVNuOHp3KD9vdH2uPo38SpobZFSqFgROs8aAC9BnGBZubOd4
	cqPCbqdHSAuBt3pn88PJAGU++IMocbLShL6cMiVM0y3YENfDnaKvvgB+83TJkn7UAEsOxu165IC
	7soy94/dmuKVRANhr0LfB/dbUcNp1anOsh4/+nwUe
X-Gm-Gg: AfdE7clvr2Jb9RCFrEGdCRgSVntoEITanf5Wui6QRNAJQtGpPF9FwBt8GU4TRXTiIIo
	7LcrRgmlR0nWphVY6jUcdGl1txgxBftXEUy+zf0ihKlzTwpDyiuq/KY48iEDH9xOrf8S5MArs+n
	eXb+guj/Dl+xsCyEByO7F0nbJBRiicD79f/1evVyNKv6RExeRPwwqGRliFDuLTqjbamPCzxVm77
	/0X78wcXWEl8C3wVqZITGyYCUPAWg8pz4Iznndr97ni0gcN9GM2vAUyxpkWftHgJSaxobvrTXa6
	gpLTSo6xjXGjO377rCwxeXm1w+RRKV0x3cNMU3FM6N9YIW3OeLoMjqiXijoeVMmzNf8XEFSpu/u
	vm5TfVVCioekyS7K6rmHea87M7/S1nbXnRje61jw=
X-Received: by 2002:a05:6a20:9147:b0:3bf:6e72:68f9 with SMTP id
 adf61e73a8af0-3c08ee6ddd9mr1642406637.38.1783356880303; Mon, 06 Jul 2026
 09:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-13-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-13-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:54:29 -0700
X-Gm-Features: AVVi8CcCSyIS6Qr00fgmOoCc6bhSGQ00N_rvT3bGq30rFTutXOMPb6CdxIm8xrE
Message-ID: <CAAVpQUC+2_GqR8KT+xW0tR9txY=sanQR3GyQN9eOsqFE1qLkZQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/14] ipvlan: Synchronise ipvlan_init() and
 ipvlan_uninit() for the same lower dev.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5103E713BEB

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> ipvlan_uninit() for the last ipvlan device resets the lower device's
> rx_handler_data to NULL.
>
> Once RTNL is removed, ipvlan_init() would race with ipvlan_uninit(),
> which could leak a newly allocated ipvl_port.
>
>   ipvlan_init()                   ipvlan_uninit()
>   |                               |- if (refcount_dec_and_test(old_port))
>   ...                                |- ipvlan_port_destroy(old_port)
>   |                                     '
>   |- refcount_inc_not_zero(old_port) <-- fails
>   |- ipvlan_port_create(phy_dev)        .
>      |- new_port =3D kzalloc()            |
>      |- phy_dev->rx_handler_data =3D new_port
>                                         |- phy_dev->rx_handler_data =3D N=
ULL
>                                         ...
>                                         `- kfree(old_port);
>
> Let's synchronise the two by holding the lower device's netdev_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index b4906a8d24ef..7adad781e9b5 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -177,9 +177,12 @@ static int ipvlan_init(struct net_device *dev)
>         if (!ipvlan->pcpu_stats)
>                 return -ENOMEM;
>
> +       netdev_lock(phy_dev);
> +
>         if (!netif_is_ipvlan_port(phy_dev)) {
>                 err =3D ipvlan_port_create(phy_dev);
>                 if (err < 0) {
> +                       netdev_unlock(phy_dev);
>                         free_percpu(ipvlan->pcpu_stats);
>                         return err;
>                 }
> @@ -190,6 +193,8 @@ static int ipvlan_init(struct net_device *dev)
>                 refcount_inc(&port->count);
>         }

---8<---
Does this fully resolve the race condition if ipvlan_device_event() drops
the final reference?
---8<---

Yes.  netdev_lock() here is to prevent race between ->ndo_init() (newlink()=
)
and ->ndo_uninit() of an upper device, where the latter does not always
hold the same rtnl_net_lock() with the former.

---8<---
Because ipvlan_device_event() temporarily acquires a port reference via
ipvlan_port_get() and releases it via ipvlan_port_put() without holding
netdev_lock(phy_dev), could the following sequence occur?
---8<---

ipvlan_device_event() for the lower dev and ipvlan_init() (->newlink()) for
the upper dev are under the same rtnl_net_lock(), so no race occurs.

