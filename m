Return-Path: <netdev+bounces-256689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIW4HWI4g2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:15:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5400E5AC8
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49EDF308B82E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437283ED137;
	Wed,  4 Feb 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKgFlgvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CB3ED12F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207027; cv=none; b=Rni2vO4rvk0HJ81DUGMOiKPM9IYeEbSB3DuNRu0rVMCAoiiHlECSAEwgbTl7Av3Dz+pA3vGsfmBOn7Z/z+UTkb9TqmrGBMybJDVp1sOvqpQoUC/iGqAWEJcY25IhiXnDeYv1jrMouDnjRNKZZO5+BLwGbX4HIPu/+1ASk4ilv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207027; c=relaxed/simple;
	bh=viUsIz0u1WXEFTH4ZpONzhlMPFimqGztc2Q86y8MegE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njlqgHhiE4D9z241Z1fIwSgm6uJLuj5PbDhxxDowJ2we1Hd6654sxWU4Vn4Hrm6dDyEZVb7VhslHhahy4WmZHhgPD73JIthKn0WpU8Ak9dHni8oveaVVwH4xWesuoruDIhGCw/9FSGL58hu/5SaOri6JpIXFQUswWXFQw3ZZajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKgFlgvW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c52f15c5b3so74256485a.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 04:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207026; x=1770811826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8j03KsnP+WY4a9H678qmXjMqSuVnhErtf2XtQN2/1o=;
        b=bKgFlgvWaEfigIpxa6+Wfu+bBzMDaw89UMpbsJaL30YOR1LaNHg0dvgRv8/6dHnPJT
         esnm8xd9VighPZIzs4qT6AEpetDjqYPTZQF4m44cq5OBzg+6f6dgjB+Hu4ze2U+8lUmt
         gwGkqr40QNSj8HdJZb+cuY0TCfU8yFvzJbmEUdO42+TvsLblii/rmUIQEHfd/g78EmTq
         JwCWsNQl+qLnv2iNtl4SmbWE4I5Nktgic8pyIj8+PIsxopnqJkL8q3N7XcAko+uBmlDT
         4D3AoP0ahg2kIeRqenAXCdzJYmluimBiHM3PUqaU/fgqa0vu9ewmuOsxoSXTnnJIaDkV
         O9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207026; x=1770811826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8j03KsnP+WY4a9H678qmXjMqSuVnhErtf2XtQN2/1o=;
        b=l21qI+IKNmsu7xoJ1VeuR4YyCr97Uujtp0EuVYDw5w1bnp9+/1JOXXzz93NLSecmrs
         uNMMYoVJytJxlDvalHVbEsI7+p0bR1T+cyX7F3Kbe++sLzcIxFF/0+PBzdWKPK0s7dZd
         f79LG/z7WtJZrFC3krMlv0+8J4P3hIFx+RWAzIhHLW5qmumApeBHhhCwdXIUQ2iGyUhd
         hYJE+ru6QadMdG736xh5LWx3JE8TA8AsEoYvKVIkLndMuE9rJgLwy1W5mLN0foQXIWa0
         mdjR7+QTqGkvsBeBsFB1f/PRite74ppsC7HmEFNxwMT/OZO/5hMQGNn/iHeYv78IujcF
         nWoQ==
X-Gm-Message-State: AOJu0Yxnk7pgLCF704gOe84xp2t+6pp8vDRagjuNoeuRkj5FJnpbeHwk
	wOK+v1MUfWM5u2QoiiWXYklehjCN0zN4GGdpFRE1vFc3JF7B9+p1p3Ha
X-Gm-Gg: AZuq6aKpdhtduxOiZzgQILaVdV1WBebilkP23M7jH4v2pAfaVm6PLRweNfNJtm4l7ej
	q+tjpLHUBhIsLWMGKtCqBVO8n9CfGkLar2b9L5WANazGvltW3n0zHwDoBpvC2nuulaxwOWIOg0o
	Hr5ZAc7tiHcwXEmDPYq1q1je0aL8iTzQh+A+lT2CevGMmQoB+9GhoNC56cokheCrGPtWnVznGeU
	R05yIJlLT/yTq/wQwIv+1ILwOJXxXRQOBC8ZAACx3D+RW76LTGjVuHH4cl6hfsjiJoEpA74cY7Z
	UDIarBmd0F1343soYi/x6lOLfOrvDLrEGzethqa6DudCL2nLoTfxemE56PPPA9ZM4DekwQXvXsq
	MC2mKcie21q1PUpDrnzbs0d/yt/M7b6OIbduw1F1bm6q8AqWiCXLVNtiJLdsYIoFTSggHxWx60Y
	8h+kAVYMc=
X-Received: by 2002:a05:620a:2981:b0:8c5:af6:3efa with SMTP id af79cd13be357-8ca2fa653ecmr363157485a.86.1770207025521;
        Wed, 04 Feb 2026 04:10:25 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm172588085a.14.2026.02.04.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:10:25 -0800 (PST)
Date: Wed, 4 Feb 2026 20:10:17 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Byungchul Park <byungchul@sk.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Himanshu Mittal <h-mittal1@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Use system default
 workqueue in ndo_set_rx_mode callback
Message-ID: <aYM3KduEzTb7DyQD@pek-khao-d3>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
 <20260204-icssg-prueth-workqueue-v1-2-9a892f4b293d@gmail.com>
 <ead52d66-b594-4dd8-91a7-9baa88230728@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mb1aNZiUmsBX9LTF"
Content-Disposition: inline
In-Reply-To: <ead52d66-b594-4dd8-91a7-9baa88230728@web.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[web.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5400E5AC8
X-Rspamd-Action: no action


--Mb1aNZiUmsBX9LTF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 11:45:24AM +0100, Markus Elfring wrote:
> > Currently, the actual processing of ndo_set_rx_mode is executed in a wo=
rk.
>=20
>                                                                          =
   queue?

Will change to workqueue.

Thanks,
Kevin

>=20
>=20
> > However, there is no need to create a dedicated workqueue for =E2=80=A6
>=20
>=20
> Regards,
> Markus

--Mb1aNZiUmsBX9LTF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmDNykACgkQk1jtMN6u
sXEUoAgApTqyXcgdxPEsnGSk4SwdDIAe9cjn9wHdm7s8LAQDDcBmgmlEJI8f7l1Y
5cA35FvqcUdSztcFpeVTSnKZ7//WleDs+yrMcqfe0oePCq6wyJFNpYVmJgEvUZcC
kKft7F19hHVjnaQcVvOZ396X4+xOu+hahp92khvhlUW/AqK9MCO4wiPJ0WT/SAHd
XICqNkFG5qtBeV1Nfk9zpPd+16VGhrzg/NkskSXFTSsab1APN731ip/jiAPR76cb
KNbgziOEoPeEfyuiBeOSzEBISOkKGshAmkP20EDE9qIk4oCmDDIvSWY35y//FCJG
ejAze+4V036DywWg4N3kIEepLeI0Og==
=SedH
-----END PGP SIGNATURE-----

--Mb1aNZiUmsBX9LTF--

