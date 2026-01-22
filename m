Return-Path: <netdev+bounces-252208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDmRB+eqcWnYLAAAu9opvQ
	(envelope-from <netdev+bounces-252208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:43:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525B61C46
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 268E14E0F35
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A9425CF6;
	Thu, 22 Jan 2026 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuorqOdP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC641325B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056992; cv=pass; b=I/rV6EriROXhk28d0z/vQXWiFDfLQhSOm9Btr6CpqvsJIyiwAQY2Y2v9Lf3aIiS6gSjlFMlum6ixoOZVNv62hvMdWjNIcTwlU77mJ68t1vQbc8aq5vVGZ/tYTJduWVKzydEOYKLePXVhpL7VPNM8CdzPaFSaeGDNS5V3FEiBtuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056992; c=relaxed/simple;
	bh=pJM8lGgtUJ/wTZmXrm74UyMZeLkN8SeYhilCep4Jxes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUhckJK/UsG4rMtPMeWsgIlqiRepQd9d1n+v8azg1GiTx6gyhb/qob1GEeiU6AEVXK63dLIptZCWV9B7SOdIEBvC5je0E2pQdUJXRsjhNFI+j4nWUWJRqJ21i/PH1+Plpy4pvqtvlN9qBIikBElR1+Fc+bjDPNVflGrOBj2QYjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuorqOdP; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-894770e34afso9411806d6.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769056987; cv=none;
        d=google.com; s=arc-20240605;
        b=k6bUEo7LKpJtmXay42LG0djD3YixMeZwtrXrt79MWqzM7R8g39lhmowTrtcYOsOcGZ
         QO1qsW1lmF35Ce9/UnrDWe1boKsJt1IrFmLelkSQ1ZBGunSsagFGEB2MJPzaciOCjWvs
         2mUzkETGjKuCwp1LVPdu1YGN8YYSa7h1EezW0FlgJzoTAInJ681UytB9niNF0xYS3hBA
         SQJTvA6b0Y0grXS6IGSkLWeH0lDQveWanHyG3fcT3+X+nGNXS4xZhcb+IYaZxSMmQHNb
         GnqCIwL+DSD15dxqxEnoYKdO2DgqiLOXmQhvlxzTXyNuw1KmgbVfPAIFw+HH4SgjCgXW
         M07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C2WyKh72YZ/o0vuncnbjTOA7DWTRpxJUig7YSzL8W4o=;
        fh=3Rk5QNjezc4mX5WbylVOe50dx4lNaBmVPjoqE/ClL78=;
        b=cjJnOvfEXxEmFY2cFXMTKj3IHMwo4BRC7iwcWH6iXejDkdf8nYmh5bFPyq9mu2byZu
         JAVmZAJ8prki+SuHgciQRnl09I40QmExx2lxCvhzpowkkevuTX6lVwuoc3DqLQrvh+dD
         jy3+ZJH49lil6wKnEgT45F6TB6oTsf5vWzw2NeaWqN93B1dOyDSFqTAH1UNutgfFyEDY
         5FdlhP197eIk9zTXgWvZLl2N+b3BYL/Akz4KRw+48hbLF8JeUeL9B/gLcNnYIk1KVrRz
         GDWS4ONqMv5dnyZrG3ZrlZycgGc0bOmg7cFX6DMiacAHk97PvV8yBgsaWgsdB7n0rW7J
         XpqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769056987; x=1769661787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2WyKh72YZ/o0vuncnbjTOA7DWTRpxJUig7YSzL8W4o=;
        b=FuorqOdPRjDAt0I+wqCaxxsKqPoEv1e/nhYJHPaQf5LZZwgKIP+h1AEMphzKApi8Ex
         x6efMNs/ReF6rvOrCbephjEvt7iHs95QHuZ7fmJx91ur62jHEvRrS+2kCmVBIWFYKxg0
         EONaaJdEGyrDCCAvNve0fcabkUNsTW5S4ksLSGjsvm2RoHCU2F7vVjIvt5iEQBQYjClN
         kxR/KFb+pCBriztmbw1bZlH8/l65JyB45gkh+bve5yc9io2dS68L+ucI4RxaO54HowGj
         SjZfxHk8ZLUu05ZUHOpqoYefvgVyZMPkwjQzmIcr9DuLFsVmVi+9a2M7YC0T4FmMh152
         vmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769056987; x=1769661787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2WyKh72YZ/o0vuncnbjTOA7DWTRpxJUig7YSzL8W4o=;
        b=OgesqfRgUnxXCe7EbKoGkRatQPDdgypkvoxv60rByMMl6c8FLJlHj8jncFGJfW4YXl
         zH0g8mYOgWmfnrajZvPrLOWbUJSydjHXTX/c22Tu6LTEi/sUmcxLJsDDODRREv48ZtjK
         sZ2u5UuXdWmkJ8p4cxlRSBuvCctLYnAc/H+yTwUi88Wx4wGxr7dDK/ECRz1wh9Hj1Rve
         xQhEfJe9FDMEBm1Xjdj8dIh/mX0qRdhDRtZJ2HnW8wkkjej1+7g4EiUaLfoF4LX72t75
         BxaRbBCYj6fz9J/mVAQdvxoLN2RXUT0OKUQ1VjmjCE+TPfJSLfIFdLmg372x1YiP6FbW
         6Izg==
X-Gm-Message-State: AOJu0YxXLCKVQJq30UJnjgTK9VV3A4qJ4UbHk5us6H9pbkU/H8L8MykA
	7PccbUVOirS28szozAL1rXZgzI6UqPg7dfh/3VjVQ4U09uQA5kZJXrM3a0f8GUrAzY74Zzjaf+o
	qwElBQhFODyUv5GbEJ4RDArcOJKu7aAB56wf93gS2
X-Gm-Gg: AZuq6aIUBeAIaP1GFNXvmzpNd5/XPktZuoUPim5D9d+FeYxV1nbmAnZGlunaa9My3Qp
	OWBIrNCh6BAXqSDlMIxKmzyG05htVzhJ4RGAga5pgiL99bU0gkH3f2arGW3gQSrAj5gUEUpOOqr
	ia7DaDidi4nMA2ykAfksLjer0wLaWIugVYM17bpXCDJWar5GaiU12BIVxVKlsTGSOovpXw1saaP
	vpDELc7D0Y4QEu8wfkdytW8Ercn4bDbb5YsPylaX2gLh04paHuLFL64Oa4VQu98PQa/nb4=
X-Received: by 2002:ac8:7f56:0:b0:4ed:67ea:1e5d with SMTP id
 d75a77b69052e-502d856148dmr110247601cf.53.1769056986650; Wed, 21 Jan 2026
 20:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152856.1694824-1-edumazet@google.com> <20260122022237.2529455-1-kuba@kernel.org>
In-Reply-To: <20260122022237.2529455-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 05:42:55 +0100
X-Gm-Features: AZwV_QgliijMY1mRVtNh3Uk1-FZGesb2QGrcMSPgN2mJH_NoMMeNIxdI-1VmpOg
Message-ID: <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net, 
	eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252208-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 8525B61C46
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 3:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bonding: annotate data-races around slave->last_rx
>
> This patch adds READ_ONCE()/WRITE_ONCE() annotations to slave->last_rx
> and slave->target_last_arp_rx[] to fix KCSAN-reported data races in the
> bonding driver's ARP monitoring code.
>
> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/b=
ond_options.c
> > index 384499c869b8..74708bd2570e 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1152,7 +1152,7 @@ static void _bond_options_arp_ip_target_set(struc=
t bonding *bond, int slot,
> >
> >       if (slot >=3D 0 && slot < BOND_MAX_ARP_TARGETS) {
> >               bond_for_each_slave(bond, slave, iter)
> > -                     slave->target_last_arp_rx[slot] =3D last_rx;
> > +                     WRITE_ONCE(slave->target_last_arp_rx[slot], last_=
rx);
> >               targets[slot] =3D target;
> >       }
> >  }
>
> Should the IPv6 NS version of this function also get WRITE_ONCE?
> _bond_options_ns_ip6_target_set() writes to the same target_last_arp_rx[]
> array:
>
>     static void _bond_options_ns_ip6_target_set(...)
>     {
>         ...
>         if (slot >=3D 0 && slot < BOND_MAX_NS_TARGETS) {
>             bond_for_each_slave(bond, slave, iter) {
>                 slave->target_last_arp_rx[slot] =3D last_rx;  <-- no WRIT=
E_ONCE
>                 ...
>             }
>         }
>     }
>
> This seems like the same concurrent access pattern that the ARP IPv4 path
> needed fixing for.

I saw this spot, but determined this was used at setup time, not in
packet processing.

I was maybe wrong.

