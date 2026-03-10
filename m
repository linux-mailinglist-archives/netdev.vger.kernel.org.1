Return-Path: <netdev+bounces-265993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKRKJlL2r2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:45:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3D249911
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 280393034B28
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FF37D100;
	Tue, 10 Mar 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="aq0RkypZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8C378818
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139533; cv=pass; b=jzSqLFP8brUjF2n0vsa2tEqExPDP2ZEvK3uh9i+ZCr+Ie93abm5gnSvPcQTsoYewyVU1y0SrDXMJjFF+O9sMxjxGySQiLiPVC0awAE2QxLVz3DP0VCEhsISDmBYXVhpQWk5fSz38FZiIDKTchVj8h1F6gK7Hyna/ttST+ccTE0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139533; c=relaxed/simple;
	bh=teQhl+gbfHGEZUE3mSFi6vo7shMkJBjvewUx11zdopc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBOgzmsEbF35n21MXzNhDBiNI4LNJd2QsrkZA/HxIw2Zn3wR3b5Ln16cSBWx2VxhzEoK/WdVx1xa4rp1uPxkbMdovh8q/bJ5CLCfRixZ02wjDbm5wtxorjSiHyDHWT39VKzeWJmar6NdFP+gcQLJHdBNTpAgoVI7ujtK1gEnE6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=aq0RkypZ; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b1900bso6645797f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773139529; cv=none;
        d=google.com; s=arc-20240605;
        b=fWfkDRFUuuxQKV3FDNMq5iPzcZHs1/MySLg+0E5VTGZ2aVi2Ex5rewtT7G9UJdnW0j
         F4MGIG8YkEv3uYXfOZN9NfCYr6Uctz08ZJ7P9CsMLgPLciYb9hS1p4DoKrwRLPaV1OKj
         uQiLmv2uW3IIqi8Mv2qcmYsXwEcj6FkGIclQH6aytDFVtxZBdJpBTuQ2dgVq6whSuqAt
         O85XwCEXtyCLQAKnX3PF6DA3/X27dELn//CfTsUQ4l7ngUwPbHQ/IcbEM/SHxlk3nI8Z
         gCOEGIHxrm2nEmG97lPPDRPg49GMnMMteSwTPz5KPLiMQ+hASJaM9csc1ghjDTKqC5rj
         70+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GrixRc7bN9BU9GrTQWXkWWkABU2EfD2sJWUINH6raKo=;
        fh=a3eTw8dXZ3paiSK8Dl7hK63LMOSMoKoQ12oDPTwtNn4=;
        b=G82bCVBAUXkQKmgWPfb1kzQBjfuEXm8R3eShyM2/KMQNCiUc+1jdg0yth5TIevJxEi
         umnCyVjod0Wf/l2Xnopagn6YqnIzDL0LhKMTimbxXNc01X9PsSmCGnfRI0KUvscb8Jsw
         ZbKQy/2V0a3tOzxFsRy3QUsPUeE8pTJJexDbbu0Li90MacEAix+znfaFF51nU5+f2O3r
         KL8P6gucCiGdzxUY2ODi9adFiAVOm0+fw//uDHO9cx6TFOJ16BawQKzfBhXV3FzM8sXK
         Cs+1aG88C6O3w0OV9WB8kdRa7deqo/v0eY5uxPvfubz6jHw5YQKLGegbDAbQFno4AENu
         iMMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1773139529; x=1773744329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrixRc7bN9BU9GrTQWXkWWkABU2EfD2sJWUINH6raKo=;
        b=aq0RkypZQC5hZnvBnYqpvF7XZ3Ubd+9V2ERypRF39YBX7Ug7uOcpyXkEgrg4UmttaT
         61TcE6P2qlUjEMzimcFGtiZRe4YvRwEgtTZSdhseU8gyLrBtGb7FLZM44al8GiNJqRHC
         LezDWuQxGRrbvnEVJFs8cw68YYW8r2awb8+bBuNFLaAaYbfFUFih6M9PbJMr5htgFtqp
         DO1YntfVO8Gvx2+aRAiNGJFyHDVvnzKls45fakxOV8AXF+90By9YEM0UocCRaiSlC8bj
         gFxKK26ODrAVkJ+UGdz3ore0Tq69yhzTdTtueD7wp4n8WQWrg4D1gH7H+wgjbeqSybX4
         HjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139529; x=1773744329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrixRc7bN9BU9GrTQWXkWWkABU2EfD2sJWUINH6raKo=;
        b=AfVzjlbkRHAKdLT9ZB1b9Jf5ds+fKUOr5zfY5LiarS3uFRZYo2vhem9GEdzzvyCBHz
         RO+VX7D+eCyHpW22lq/k4RaCy9LnOyFayXSSlg03jLMPskZm01U8mspHuHIpXZYe6V7O
         RXP4+JbBCmNiMUYtRKsoO4YFcqo00m99jWZaeS59S7qm0zI5jwpqqKD8MYhExR/HCbS8
         RjWQn6x7trGu/NCiBmNNJJsTu9cFXARqWCktxUKlVlONhiOlwFjFw/K3iVpwgvPimGKZ
         FmSLj8hfBOhLJdxwYIsfrhA5im1zr7ojMZmfrxBOuOAox5uO7YzC67S2ZjW/8HBg5+Dw
         AfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzxQxNwitVKO/iBiZ4+xm8guUXh8jGAsXeIRd4PYTGbFsrBpGc5Bz1nOquJX2DG4iyPLa8g+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrUaslY5pOYjPalbUiVnNPK3k6SBwugPx4HVkb7jwdt8cHOfI
	T/FGAr2zws2s1WC75uKO8EHZz3tQ0Av3u0Ta+6GVGlcfubjflm3hyLVojtyduvkl7jFkHadaXWK
	SXxUelhJbrSuVOob8SULaUlUbITvIe/1wuHptKv1Kyv4UDw33RdG+ZO0=
X-Gm-Gg: ATEYQzwr5mjbN5knzfVmrBncBQqZU2p/AzGO2O4tXcEQgVpt8TZ9UqdHao+T2S/xFNQ
	tPWBTHxA5RIv2AhU+btuCKMCof4jVfbGnNblkGYnO1rTV2y0cX067jzno6kugPJhmKPlwGREuNd
	oSBZqZfJJyIE1qyGd/zsxwwjH9PZTTRADgsJNYZDrjpybFerwkgx48FyD5BdbNGB7I1H85J5Ywk
	mQad98uMymgpewVLKDRASGuZvq5/Zg9+D+k0KyxVqSsIljEKSbvhBBJgGzJwbF6T1dT+WkLNEgl
	zQGFFkuLveAWzJZPdxtAcpV4COv9gFxVD9ALzq2+AA==
X-Received: by 2002:a05:6000:4301:b0:439:b5f9:eec8 with SMTP id
 ffacd0b85a97d-439da65001cmr25067391f8f.4.1773139528623; Tue, 10 Mar 2026
 03:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com> <1356396.1772744345@famine>
In-Reply-To: <1356396.1772744345@famine>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Tue, 10 Mar 2026 19:45:16 +0900
X-Gm-Features: AaiRm53iunZX7EKPV3bYhCHF2O8vNQNbUUEOAgXI9zqkJbjeOVbBlXbVQfrnzBc
Message-ID: <CAA3_GnozeoTATh8_U_25VHmLCWkeRuiZkbV7+dy+M-PBKGXBgA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] net: bonding: fix type-confusion in bonding header_ops
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3BF3D249911
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265993-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email]
X-Rspamd-Action: no action

Thank you for your quick response.

I was not aware that such a patch had already been posted and got
approved. That patch looks like a good approach to me.
Given that, I am happy to withdraw my patch.

>  I also wonder how this bug was discovered.  The code in question
> hasn't changed in many years, and now there are two independent fixes
> within a week.

I found this bug through kernel fuzzing.

2026=E5=B9=B43=E6=9C=886=E6=97=A5(=E9=87=91) 5:59 Jay Vosburgh <jv@jvosburg=
h.net>:
>
> Kota Toda <kota.toda@gmo-cybersecurity.com> wrote:
>
> >In bond_setup_by_slave(), the slave=E2=80=99s header_ops are uncondition=
ally
> >copied into the bonding device. As a result, the bonding device may invo=
ke
> >the slave-specific header operations on itself, causing
> >netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
> >as the slave's private-data type.
> >
> >This type-confusion bug can lead to out-of-bounds writes into the skb,
> >resulting in memory corruption.
>
>         A few days ago, Jiayuan Chen <jiayuan.chen@linux.dev> posted a
> fix for what sounds like the same problem[0].  Their solution appears to
> be much less complicated.
>
>         I also wonder how this bug was discovered.  The code in question
> hasn't changed in many years, and now there are two independent fixes
> within a week.
>
> [0] https://lore.kernel.org/netdev/20260228095854.391093-1-jiayuan.chen@l=
inux.dev/
>
> >Patch 1 stores the slave's header_ops in struct bonding and sets
> >wrapper callbacks in bond_In bond_setup_by_slave(), the slave=E2=80=99s
> >header_ops are unconditionally
> >copied into the bonding device. As a result, the bonding device may invo=
ke
> >the slave-specific header operations on itself, causing
> >netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
> >as the slave's private-data type.
> >
> >Patch 2 uses READ_ONCE when loading header_ops callbacks
> >to avoid races with concurrent updates.
>
>         With the READ_ONCE changes in a separate patch, does that mean
> that patch 1 by itself is subject to race conditions that would result
> in errors?  If so, that's not acceptable, every patch must stand alone
> and not break the kernel.
>
>         -J
>
> >Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
> >Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> >Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> >Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> >
> >Kota Toda (2):
> >  net: bonding: fix type-confusion in bonding header_ops
> >  net: add READ_ONCE for header_ops callbacks
> >
> > drivers/net/bonding/bond_main.c | 67 ++++++++++++++++++++++++++++++++-
> > include/linux/netdevice.h       | 41 ++++++++++++++------
> > include/net/bonding.h           |  5 +++
> > include/net/cfg802154.h         |  2 +-
> > net/core/neighbour.c            |  6 +--
> > net/ipv4/arp.c                  |  2 +-
> > net/ipv6/ndisc.c                |  2 +-
> > 7 files changed, 106 insertions(+), 19 deletions(-)
> >
> >--
> >2.53.0
> >
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net
>

