Return-Path: <netdev+bounces-257117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EbPElN4hGk23AMAu9opvQ
	(envelope-from <netdev+bounces-257117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33FF196C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB6E30086D5
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE93A6413;
	Thu,  5 Feb 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="qZ0KLg3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0E312831
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288996; cv=pass; b=QC0N/mIg9F7ZpkJrMckcBEiTvsNa7IebJIxquM2WbnDJqGcgglWvd0Lqqbmdvw8bjdpg8HlOOMpN1fC093AWGTg20wrR9QQ4hrx7HiI15C238au05Q1EWAR15NguRKsok7wLiBR2zhsIARwbPPgPAbA+ETiSWw/I/MaDYOrawZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288996; c=relaxed/simple;
	bh=2mt/3ELuxz4No996eqVkEOJoeTju2iw0o/O0vunafnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTROpcoRrPx8qhh/NTq5UHIHEtWhlxclK24fS4V6Y1TwnbQLdPK+HzmyQozWY/GwM+hzicdiv+h+bzTd5UuvIwHOXzDeX3pBs+1Io+5znnj6m9ThuuIBCt8jaYOGCcnIWrB3FwxxsxL5D0+wsD/8PVxYp7cy68j4yLzYKOMb0pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=qZ0KLg3H; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43596062728so1333824f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770288994; cv=none;
        d=google.com; s=arc-20240605;
        b=K7mlLLTCzqrCNb+WEza+QbcYfDSh/7oDWNZ0NjC3jU8ERPCiGTfiDpzummBE2QN7Fn
         sn2roP/gcZzuz4FBmH8TtiobTJw5Sn11NOZrk8jbbaHDMjEYekoeaotQZE/5K7cY5/tX
         lKzc0bdVGh1yrAXshCn8mehhPSFOKUBuKBC5FtN3e2KoOuWn3xY08eBve1elsG9iwetD
         P3rBjSFf0yVqCqDP44hd8UthzeP/ngM3vpKB53k47b6bRvQwOwrYfcYzUo/MRdge2QRV
         AAnIDL+fIm2oYzwZguj4b+rFpR0CNfbp4kdJchhCEk2+TUXKdkT3Irt/zDFOMQV2zHL0
         GPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1GEgFvkF/3n1mAlDqAax54qd1+u9y6HUma9Koe2gBrU=;
        fh=dHV5gVCslhHygEAsIpxdSEvk2nP0bbaKimEhimu2FiE=;
        b=lUAWIiMvL9j6+Pg9IruZMnGONr5qD8nrvF9+V1937z12EtQO63E4So6gUjifyeKdEd
         4nb3G243TVPC5ZoYJh12DG3xu7IGcoevqQJ6qamAAUurw9ThjqSyBIlqcWXoPRDl9ZYh
         +tJJRbEh+hzQrwPujNw1lx4UE37deV7fZz43wk5yVOTrSs6gbpn6kVFecKxXnroVjGKO
         Ex3A1UamDYeSz0i/uuSF4LHY6pNUm0UPNH0tUcwjlfKwtd4b1QQwXT9M5CCumKx7Xb/Q
         MBKlbRacC6/lL3brLVTNfNDll4OBLWrB/tn1/kahMDOAR+gLxqkyEHnSdTCQin1Pj9ia
         Mxww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1770288994; x=1770893794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GEgFvkF/3n1mAlDqAax54qd1+u9y6HUma9Koe2gBrU=;
        b=qZ0KLg3H+c9Z8DUXg89yCLtWSw56GnNvIcc9oYTa5CfjgMhWzRP2K2oh1mkelUBJAd
         ml47gWGyNOKMW/Q4GcQSnjmQ2AJ7khXXD6aOhFmlb0GC/U3SllyOiq5WfLOG+0q5i5u0
         LRfYuuw4A83KDzaOR7rbHad/r2ii19JQcLcsi8K/SRotLsGPl/UlnlOI+3jQ9OlhrCr4
         ODCkC/GhbU3B89np0I3TtZlyB8wZE6XEY0MaHmmMy0e0C/+3UabigftAmUl2oaOspeWp
         TWOnGClmeGijD5YumbqSIXvO+t5H/A1jEp0/I/GNhf3RXdNX34Db1H4mOCSE5ubyNydP
         /8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288994; x=1770893794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1GEgFvkF/3n1mAlDqAax54qd1+u9y6HUma9Koe2gBrU=;
        b=WyZehlSyAL3GRUEewHU8JjQqNHTL8Vqh7fLjI7fO8sNxQXxggXyYjBoWmCLEFLjrdq
         8qhCnT8nA7jFMMQN1cYJSeN5VY1oe/wGS24scy73fEsdnoRxcYv1BttqXlYLM0I81BB0
         JwQIIl6xcHpuHZBCE0heofKUony/geFDWJapZAgoLbqeZYL0qEc530zJuAbsD9T4MT9F
         W3Wk1ak3OLVsKEeHm0pcxfz0GDog/AvL+ZE0vO+HOBrQbp0L2usfbRLCDlV4g5Vxj7PK
         J7/1kFrYtJ7rNt8vbV1jOZwNNtPwJ3qJ+OulGYH3e4gFtxp6MDuiarOJkdnXlFGI3gFQ
         QDIw==
X-Forwarded-Encrypted: i=1; AJvYcCVJt9yQNbvQb+9dQiszGF7QqSaMhxRHsxPZT7aMtarfSbnuYUKaIZMHzLEwzTYlIoCrZwKFmj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsLFK4tlVOsOdzV8JAAa3OIAPtCvUqRUl52KgTvBHYOttyQdH
	bRZ8qXtHk4Fgmm4ByCXxdsIEaqiEIzrEucbOqmSA+smxkPcXV8WDuwwpS/nv/123R0YzAc1XU5a
	IC9L+XONdyiXIRpfAae/Zm1O3D4X3un3OZ9rurgWDXA==
X-Gm-Gg: AZuq6aIAGHDONaReTr+JVCCbHkh/EZMvv2PG01BnYpCJWmlMRMF/QKTxRgcPmTloSBv
	ykJ2W6EXIruL2/gNHunfXGGpqAvYAVYuh4ablBZY8ZK/8B43htUF8xSHcCRDXJFYcAmtaAs2rAU
	oyfJcsMAY7mjbVv90dTt7Tx6W4tzFLafdsoossy2u1oP09vT9cROTdHYRT0++YBBOnto0sg3h23
	igxo9kuauC7jtVgIjN/cXWBEJFhy1xEvg8KEtUWA6qEfHTA23T6UUmMClUOuOkXOMtZyxDQoIOc
	drRg34JqMxs11kCzdazQqidrRfSktA==
X-Received: by 2002:a05:6000:2010:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-436213cd231mr4013448f8f.2.1770288994242; Thu, 05 Feb 2026
 02:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
 <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
 <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
 <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
 <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com>
 <CAA3_GnpJ-RV=1xaf4DKRd30RgH0HoAxXJA1tx0cvBCX05OcYuA@mail.gmail.com> <CANn89iLVEJKoBtYNbAdLgxsPr03Fkgi9CJmTh1a0y0L5fV-HNA@mail.gmail.com>
In-Reply-To: <CANn89iLVEJKoBtYNbAdLgxsPr03Fkgi9CJmTh1a0y0L5fV-HNA@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Thu, 5 Feb 2026 19:56:00 +0900
X-Gm-Features: AZwV_Qh6Qdq3_6odx1ZrWxknknmRSBGPDJOWb48O8OK1NvXKBKfM4syzeQOL0Ew
Message-ID: <CAA3_GnqspgihczMgbSBXoXPwfo1=uwiK2ef-V83+FBbR1JEa2g@mail.gmail.com>
Subject: [PATCH net 0/2] net: bonding: fix type-confusion in bonding header_ops
To: Eric Dumazet <edumazet@google.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	=?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257117-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gmo-cybersecurity.com:email,gmo-cybersecurity.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E33FF196C
X-Rspamd-Action: no action

In bond_setup_by_slave(), the slave=E2=80=99s header_ops are unconditionall=
y
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

Patch 1 stores the slave's header_ops in struct bonding and sets
wrapper callbacks in bond_In bond_setup_by_slave(), the slave=E2=80=99s
header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

Patch 1 stores the slave's header_ops in struct bonding and sets
wrapper callbacks in bond_dev->header_ops.

Patch 2 uses READ_ONCE when loading header_ops callbacks
to avoid races with concurrent updates.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
--

Kota Toda (2):
  net: bonding: fix type-confusion in bonding header_ops
  net: add READ_ONCE for header_ops callbacks

 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h       | 24 +++++++-----
 include/net/bonding.h           |  5 +++
 include/net/cfg802154.h         |  2 +-
 net/core/neighbour.c            |  6 +--
 net/ipv4/arp.c                  |  2 +-
 net/ipv6/ndisc.c                |  2 +-
 7 files changed, 91 insertions(+), 16 deletions(-)

--
2.53.0


2026=E5=B9=B42=E6=9C=883=E6=97=A5(=E7=81=AB) 2:11 Eric Dumazet <edumazet@go=
ogle.com>:

>
> On Wed, Jan 28, 2026 at 11:46=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Here is the patch with the barriers added, based on v6.12.67.
> >
> > However, as Yuki said, we are wondering if this would be considered an
> > acceptable change
> > from the perspective of the maintainers (or in terms of Linux kernel
> > culture). This is because
> > the patch adds `READ_ONCE` to several locations outside of bonding subs=
ystem.
> > Please let me know if you have any concerns regarding this point.
> >
> > >  Also, please clarify what happens with stacks of two or more bonding=
 devices ?
> >
> > To clarify, currently the `header_ops` of the bottom-most
> > interface are used regardless of the number of bonding layers.
> > This patch changes it so that `&bond->bond_header_ops` is used
> > as the bond device's `header_ops`, regardless of the stack depth.
>
> Could you try to cook a patch series perhaps ?
>
> The READ_ONCE()/WRITE_ONCE() on dev->header_ops->cache could be done sepa=
rately.
>
> Thanks.dev->header_ops.

Patch 2 uses READ_ONCE when loading header_ops callbacks
to avoid races with concurrent updates.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
--

Kota Toda (2):
  net: bonding: fix type-confusion in bonding header_ops
  net: add READ_ONCE for header_ops callbacks

 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h       | 24 +++++++-----
 include/net/bonding.h           |  5 +++
 include/net/cfg802154.h         |  2 +-
 net/core/neighbour.c            |  6 +--
 net/ipv4/arp.c                  |  2 +-
 net/ipv6/ndisc.c                |  2 +-
 7 files changed, 91 insertions(+), 16 deletions(-)

--
2.53.0


2026=E5=B9=B42=E6=9C=883=E6=97=A5(=E7=81=AB) 2:11 Eric Dumazet <edumazet@go=
ogle.com>:
>
> On Wed, Jan 28, 2026 at 11:46=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Here is the patch with the barriers added, based on v6.12.67.
> >
> > However, as Yuki said, we are wondering if this would be considered an
> > acceptable change
> > from the perspective of the maintainers (or in terms of Linux kernel
> > culture). This is because
> > the patch adds `READ_ONCE` to several locations outside of bonding subs=
ystem.
> > Please let me know if you have any concerns regarding this point.
> >
> > >  Also, please clarify what happens with stacks of two or more bonding=
 devices ?
> >
> > To clarify, currently the `header_ops` of the bottom-most
> > interface are used regardless of the number of bonding layers.
> > This patch changes it so that `&bond->bond_header_ops` is used
> > as the bond device's `header_ops`, regardless of the stack depth.
>
> Could you try to cook a patch series perhaps ?
>
> The READ_ONCE()/WRITE_ONCE() on dev->header_ops->cache could be done sepa=
rately.
>
> Thanks.

