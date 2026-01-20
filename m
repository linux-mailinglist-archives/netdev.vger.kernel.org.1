Return-Path: <netdev+bounces-251580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIVGKxjpb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81D4B908
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 235D1A6CD06
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020B44D6A0;
	Tue, 20 Jan 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joAyaW3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC844D022
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933243; cv=pass; b=SKFGTeN01HM839iisHcLPKsG+4d7JzHME+O7p4w//Zu6UAI22kym9eVWxLNk6M79Lnsh6rpYgfKBq8qZERpW28Eurm0tcBE1shPQsO8T3BX+QXiyIx0FYBojPEvXjTBo7C21ZTwMjIj7aEQiKBoJ4OHytdkZZ0GaeAsujVSEPgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933243; c=relaxed/simple;
	bh=qZ+LoyEMJ3eIanoo5DJwJYvr5Gf0DjDyMY5IQp+98p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOw+XbcPVgoUKnhyjHxjYwOuXzuXfwYJjZAjb62XkuEoWOOj2ESMBhYLFfvsjb1eovwkn+SPg7sL3DhPUHgdxZIEBc5I6BXBA4Ye1Lp7Pj/O24GLlH1J/9vSjTf0AZlmZp7qc4utU9vjCGLhSwLRBUt5qpi80lpW0alFckuaM98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joAyaW3z; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-123320591a4so5804573c88.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933241; cv=none;
        d=google.com; s=arc-20240605;
        b=VPy4YrurYhnAgARdnCKkNdwFGIx70i9z8Z7nTfc4g5Ezaufnue9MJPQqeC+6AXuYA1
         lAbSnTz3M9/6eARS3ZDPRNHvfAZkOVfc/xzUyVPyEUGso9adskvmpE8hr8cv2J7duQIa
         G3DOFt6T14m33pjhg6YiRgzF+3OK6+1PkCAkpoQvM46Z3fzFp0oBc2BRnpc7lR379wqx
         vpe9Su/Sp/mTiCVZYULAch9T3U0pfbG6vB8/EQTBR7dU814y9zTxaXI32NspbG3i2QFs
         XWMINlVLqqfJAZSd2k6HQL+QRAazSzTWFZegSrzuCd2i/9aa1R2rL+7AOsaRwfT4SbyD
         CwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0LLXDdpEBBQp2ybKgHCRZTX/RcWXEE8WbVZAkxme8ks=;
        fh=MM2b/Iunc/Wra+6OdRzvmQJEwB3OZcJto5F/c+2n0II=;
        b=TP7bwF3PRG8XQHyBXVxzTYOUmfD4IalH0yWz5NIe7e51gWUCJLRxwpRsFrkpHEDkXK
         KmCfrWj5ETTH46g5x76IioxODwMn/Q0ERwo2MIfGemXmlx7U1H2rgGoqFQc4izCtmwkf
         5O6/0kKZERW1RpxKX7emxnJsp8+WqbD26y+QeaF3L9UKd0o/N5Zlbch+WA6npiQE4z8S
         d5kIxhKvtHIqsjGfY0dhCrTl4Xd/0a+96vh5ByrG/ZAIrGbQ71p3COajO74rWs/hGcQn
         8fhBZE0e6L/1+uvMEQOfpBpC5W2gWvmzqO4K06AbpUeX5KMniV+/JyLzqDb3W+MLmZAK
         eNjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933241; x=1769538041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LLXDdpEBBQp2ybKgHCRZTX/RcWXEE8WbVZAkxme8ks=;
        b=joAyaW3z027cmNaQwhB8Nj7CXvhe6mGfRZflP7rHVDx4TYCKZyZRF+PpnxNLl+CMVi
         TLXWc++Pe40qUY4dR/dShR6DEnc+yC3bNrUrdnkgOb2wdMdGDMlAfRmJaJj9fH4/cAv/
         JzgH4/GoVsLH7LLmfTEhjlACYOakZ6UZNgFmC1Kr91FcLjOvZ05lPRoC4u/Dv7loaNzq
         OUDktd5OWCOc0iaupt7PufQl6NvCc84j0dclBXbnDH6i7Oeyi55UcMiG9ditXX8S8QyK
         TxgXSWmCOPXRPjGMXQyrgitUy7cKBXGiEgBWT6Fi814TTtChKcBVtSNkZ1oDbywrOV6R
         wv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933241; x=1769538041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0LLXDdpEBBQp2ybKgHCRZTX/RcWXEE8WbVZAkxme8ks=;
        b=qozW7D0fAqTSXzHfukiNyC83mDSLH0VuUzLqjR0BCFzSIeJWBJBq6cLaf1M84n1OQq
         XOTLyw7kJcuoVID8gsu+62XYJ9wMdVwlAoLuXyul4Djufgj5GeMWF8CP1bffLDR34gnD
         Lhnpln6MFjys0SAvC+0oB6gwMujjfNM2mzgKz+reJoYhmmTYUMAr4pV6DyTIGfb4hH/o
         KZFIEo9/UyjfLe786m6TxXuADCH0M6Du/5fvcj76B0wFJyiGgYC/V95mTUoP2XCW42kI
         EkkENr1lPaLtGQTXBXPoLLOxom+8FXVTYv3YAcFZOdxc0jWtJrMLT6V8Pfju/V9uoUep
         Oi+Q==
X-Gm-Message-State: AOJu0YwITyTe47VLFYc9f5thaeZieffJ/IAk3glsolINCg8vD3nKWCB2
	U69TJUoRRFEBRGfuwHf9h1GPUnFP3EcGPgAjaBdqv/ByJwWofWTnHuwWMNHzTGXm2w7iZ+rjXC8
	e2jTUiI0enbmAcSkTtdpoA4QYVRtWjqhPpB8Gl4tZ
X-Gm-Gg: AY/fxX64ik7YnndHnmEg3GvzF9Nust9wSTnn5S65xGreUlTTQpDFq2EhrbokJX166Vj
	PkS7qSfDi+NDVYTECeZDrJxxwaUYzZm/d7dVzoEt3Tekd70QmHWCKhi8IO8x2OmTYNnszOtysS3
	yEyzTF9Qdw8CK0Hv/CJasnUuMNlJcxLoDrbxKp2MK2YH/50WcRfYS1fZPK2ElGZkbrFfBYRunPb
	Jn/gCCekE4GJo5mSkBgQQcDWe4gQ1LihDDluvkqOmzY22NDyao2+xtmM0meExESNZkYQRU=
X-Received: by 2002:a05:7022:438d:b0:123:330b:3b5 with SMTP id
 a92af1059eb24-1244a765cf8mr9816513c88.30.1768933240393; Tue, 20 Jan 2026
 10:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115222300.1116386-1-yyd@google.com> <88efe7ae-7ffd-4088-a81c-b3761bd1ac20@engleder-embedded.com>
In-Reply-To: <88efe7ae-7ffd-4088-a81c-b3761bd1ac20@engleder-embedded.com>
From: Kevin Yang <yyd@google.com>
Date: Tue, 20 Jan 2026 13:20:29 -0500
X-Gm-Features: AZwV_QhhIZyBRlxPBHy5tnBT13RXbZmpDRCErc7Bdqb5mNN4W8mE6m2iD7kYsvM
Message-ID: <CAPREpbZZBPvF0MpG4GbGdcpPRUcGgNqFKFZZ=XDvdUyVffH2Ug@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,google.com,redhat.com,davemloft.net,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251580-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyd@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2D81D4B908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 3:36=E2=80=AFPM Gerhard Engleder
<gerhard@engleder-embedded.com> wrote:
>
> On 15.01.26 23:22, Kevin Yang wrote:
> > Network device hardware timestamps (hwtstamps) and the system's
> > clock (ktime) often originate from different clock domains.
> > This makes it hard to directly calculate the duration between
> > a hardware-timestamped event and a system-time event by simple
> > subtraction.
> >
> > This patch extends ndo_get_tstamp to allow a netdev to provide
> > a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> > driver to either perform a conversion by estimating or, if the
> > clocks are kept synchronized, return the original timestamp directly.
> > Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
> > a use surfaces.
> >
> > This is useful for features that need to measure the delay between
> > a packet's hardware arrival/departure and a later software event.
> > For example, the TCP stack can use this to measure precise
> > packet receive delays, which is a requirement for the upcoming
> > TCP Swift [1] congestion control algorithm.
> >
> > [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> > for congestion control in the datacenter." Proceedings of the
> > Annual conference of the ACM Special Interest Group on Data
> > Communication on the applications, technologies, architectures,
> > and protocols for computer communication. 2020.
> >
> > Signed-off-by: Kevin Yang <yyd@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > ---
> >   drivers/net/ethernet/engleder/tsnep_main.c |  8 +++++---
> >   drivers/net/ethernet/intel/igc/igc_main.c  |  8 +++++---
> >   include/linux/netdevice.h                  | 21 ++++++++++++++-------
> >   3 files changed, 24 insertions(+), 13 deletions(-)
> >
>
>
> ...
>
> >
> > +enum netdev_tstamp_type {
> > +     NETDEV_TSTAMP_RAW =3D 0,
> > +     NETDEV_TSTAMP_CYCLE,
> > +     NETDEV_TSTAMP_REALTIME,
> > +};
>
> Would it make sense to document the types? By your change of the
> ndo_get_tstamp() documentation below, the info that cycles is
> about a free running cycle counter is lost.
Good point. I will add a section in kdoc.

>
> IMO the name RAW for the timestamp of the adjustable physical clock is
> not a good fit, because NETDEV_TSTAMP_CYCLE is more raw (not adjustable)
> than NETDEV_TSTAMP_RAW (adjustable). Maybe NETDEV_TSTAMP_PHC instead of
> NETDEV_TSTAMP_RAW?
Agreed, will do in v2.

>
> If I understand your second patch correctly, then NETDEV_TSTAMP_REALTIME
> can provide a timestamp with low accuracy, which can even jump backwards
> (a later received package can get an earlier timestamp due to the simple
> synchronisation in gve_hwts_realtime_update). Should the expected
> quality of the timestamps be documented here?
Good point. I will mention this in the kdoc in v2.
>
> > +
> >   /*
> >    * This structure defines the management hooks for network devices.
> >    * The following hooks can be defined; unless noted otherwise, they a=
re
> > @@ -1406,11 +1412,10 @@ struct netdev_net_notifier {
> >    *     Get the forwarding path to reach the real device from the HW d=
estination address
> >    * ktime_t (*ndo_get_tstamp)(struct net_device *dev,
> >    *                       const struct skb_shared_hwtstamps *hwtstamps=
,
> > - *                        bool cycles);
> > - *   Get hardware timestamp based on normal/adjustable time or free ru=
nning
> > - *   cycle counter. This function is required if physical clock suppor=
ts a
> > - *   free running cycle counter.
> > - *
> > + *                        enum netdev_tstamp_type type);
> > + *   Get hardware timestamp based on the type requested, or return 0 i=
f the
> > + *   requested type is not supported. This function is required if phy=
sical
> > + *   clock supports a free running cycle counter.
>
> ...
>
> Gerhard

