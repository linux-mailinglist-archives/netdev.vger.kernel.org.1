Return-Path: <netdev+bounces-277526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Pwk3OvFQ2WmooQgAu9opvQ
	(envelope-from <netdev+bounces-277526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B743DC077
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872AD3004F50
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386431E832;
	Fri, 10 Apr 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I4ruxAHc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9412F12AF
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849707; cv=none; b=IeyqumxjFJuHQCewL5AKxNQuq+wLGPhIBug9vRzdI0IcIWM8t0xkw/YDKiUhcTcZw1JC3GE7WbrqPL9ankOGFxtIQxipXMpbsuKxFhJmcErBNGFMwA6jGJY2zMLgAT82AT/otRPS8rIGkhBLAduNiaHWndGqaTGwOCjg3i5oOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849707; c=relaxed/simple;
	bh=f1HoDsB8R7IJohfCWyIQcg6mbyOTTSj/m9M+CxqMbuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXRw1h3vhsHdWgsd5K1apzFw1MO4NY37ek+gOiqikDZdz07KkskT1M/d7KYily5faM4o60p1bY68RfVOIdweRj8+ExczubfTzBmePXgZkydA3OU8urnc834e6KdzdVMTRp1bztfvWbxgOvZkD6jweea/I6fsj9JW+pNH1OTSGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I4ruxAHc; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-40ea611d1a4so1119015fac.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849704; x=1776454504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb+SROsG8Qx3Kqg1xXWTzNrP8Z8K7i6BAoEVOF2edjc=;
        b=Qp1v+mbozZfLcE+3GnLozmLt7FWXQzIR6w4jwV133FLAfAI9otN0grPbklizj9U2X4
         lhUqoBn0sEcpIiwzowqVkz2GCm67XcyBRHi/8+Fh/rRomX9ZgzAQQwXEDNuuqGOg9vhY
         wU8cytame7NbO8AY8uYS3wnE0NfHEedWVcGsVC0iOEwwI3nYZcw9i55qi/oPhmiNnzej
         KvTaLXxWyhAv6geNoVjXbbxDsNyT3irg5FP577JkmacWv1a750N2n4TPxgmjLK0VKLLi
         f7TCYMCeIQrPmNcvVr3Rkqf8uh3Iqkfj25LRSgqIQtOt6AIwQomwui3o9p8+h74t3xiC
         9rww==
X-Forwarded-Encrypted: i=1; AJvYcCVzjE1uk3N0MougANBAZWLU9EOKUelPm+AqXHspOnmeMXV9xk35rEbhoczLFNUmdjAc3qGsGBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvzdl4xk9370+Ol1BqeG7AtNY2XGEthhspnx+bTX4mq4FpFXXZ
	sNBjAAYnsTUrb0M5ecDNhD2tqAvLnkH93EwjEzvLiOvhsLRyn7hABH4yxDESGIYe3RCfO2diKH9
	3lIASHHMNFr9sqR1qJ7lyk8gQxmsYmBWpoxaZ1BtTU/irgMHz5fSGeYKauXTYxk0HGYDGw1ZEhM
	4zEWgE1WLNLCjaypuMJbN+rgdXmuhjb4DLriY1s3lHSChOsQPrKbDyIgUhJeytxkNroLZsJKwy1
	0HzxJWjIFnpvNdHNQ==
X-Gm-Gg: AeBDieslirvnWmy5ziDvsTmB6NNvnim0/0qsnBbH+o6WFOIAPIPJSCUoHAZqJUW8XIP
	0Pt0O3Gzi3dSvznW9anxhP3pdzXA7F/itYlWfJP/9JYpV82ucbfnI+e3hKs8XrpfOefCfnAbniW
	YKwoQHHc6K5src+rGUGT1keLauikr2sOObWlD41TLIo8PE0Riw+lWN4bpOhukg5M4OJrWQPnDWA
	RPrs4+4vwTl2oCXLfOLEGD/2lG/I3J8XOby8C4Ug5Ee+22M9IfFfbBF35QiViZ36R2Lko8PZegp
	vnyHclcG0uG3KZI6lAzaM3GBn/45tTCZtitCsZIo2ixlDUlyf0z0KKYxhZy8hzci929qBRmB0LW
	drSWFaainI20sDZs3WNmzN3w7s/o3N+VprjWP5R0XpngUqUiZRtRFUuDbqyyatjRjRo5l3vubrP
	EAywGE9ad2KWBVbw2E3u7NcoHiVFP2/MHXd0K2Fu5u6QQOo1mymoFKlB3NMlnph0o=
X-Received: by 2002:a05:6820:150e:b0:67c:9f59:23ee with SMTP id 006d021491bc7-68be604b1e8mr2167866eaf.14.1775849704391;
        Fri, 10 Apr 2026 12:35:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bca5f9493sm266343eaf.13.2026.04.10.12.35.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:35:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-794b74a8b2bso56912917b3.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775849703; x=1776454503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb+SROsG8Qx3Kqg1xXWTzNrP8Z8K7i6BAoEVOF2edjc=;
        b=I4ruxAHcr3U+WVRargf4ZyVulNk/atGKqz21QeKWn3lgHx10pliojsDoA0GOvjtPzI
         eHF4FvuCg2frCQFY6NhqurgnUBkZx9W4oORu9mmNSMUYt/wbHaLsq0CyKuOaXZfX11PI
         uJ1Uz/3wtSGPlIM8r0zNiZirrCJH+tU+iqcLw=
X-Forwarded-Encrypted: i=1; AJvYcCV1Jv+xjl2NU2eAXyn53fly42ax3QN6V5LXnEDGu4uEG6/mSFQqe7DbMeToZ2J5kP+uObGZIC4=@vger.kernel.org
X-Received: by 2002:a05:690c:dd4:b0:7a2:ce0e:8635 with SMTP id 00721157ae682-7af6f9fe04dmr52246917b3.19.1775849703322;
        Fri, 10 Apr 2026 12:35:03 -0700 (PDT)
X-Received: by 2002:a05:690c:dd4:b0:7a2:ce0e:8635 with SMTP id
 00721157ae682-7af6f9fe04dmr52246477b3.19.1775849702825; Fri, 10 Apr 2026
 12:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Sat, 11 Apr 2026 01:04:50 +0530
X-Gm-Features: AQROBzCqdOiSFH2V3TG8W02uXCgbqpPrtGMxtmXtaLTUqiJAPT0IFIjUnfMkNLo
Message-ID: <CANQF7iDycps5vpReLMCKeDVELAQSTcdiKM4ULqkc7XO59rHTxw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemb@google.com, daniel.zahka@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com, 
	ajit.khaparde@broadcom.com, kiran.kella@broadcom.com, 
	sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c5dcab064f203ab5"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 38B743DC077
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c5dcab064f203ab5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 3:07=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akhilesh Samineni wrote:
> > crypt-offset (Crypt Offset)
> > ----------------------------------
> > The crypt-offset attribute specifies the byte offset within a packet
> > from which encryption begins. This is a per-device attribute that
> > allows a portion of the packet header to remain in plaintext while
> > the rest of the payload is encrypted. This is useful in scenarios
> > where intermediate nodes need to inspect or process a fixed-size
> > header before the encrypted payload.
> >
> > The default value is 0, meaning encryption starts from the beginning
> > of the payload following the PSP header.
> >
> > spi-threshold (SPI Threshold)
> > ------------------------------
> > The SPI (Security Parameter Index) is a 32-bit per-device identifier
> > used to distinguish security associations. As SPI values are allocated
> > monotonically, a threshold is needed to trigger timely SPI rotation
> > before the space is exhausted.
> >
> > The spi-threshold attribute allows userspace to configure the value at
> > which an SPI rotation should be initiated. The default is set to
> > PSP_SPI_THRESHOLD_DEFAULT (~90% of 0x7FFFFFFF), providing a comfortable
> > margin to perform rotation without racing to exhaustion.
> >
> > NOTE: A follow-up series will add notification support to alert
> > subscribed users when the configured spi-threshold is reached, enabling
> > timely SPI rotation.
> >
> > Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> > ---
> >  Documentation/netlink/specs/psp.yaml | 13 +++++++++++++
> >  include/net/psp/types.h              |  7 +++++++
> >  include/uapi/linux/psp.h             |  2 ++
> >  net/psp/psp-nl-gen.c                 |  6 ++++--
> >  net/psp/psp_main.c                   |  3 +++
> >  net/psp/psp_nl.c                     | 27 +++++++++++++++++++++++----
> >  6 files changed, 52 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netli=
nk/specs/psp.yaml
> > index f3a57782d2cf..b22869be91cf 100644
> > --- a/Documentation/netlink/specs/psp.yaml
> > +++ b/Documentation/netlink/specs/psp.yaml
> > @@ -38,6 +38,15 @@ attribute-sets:
> >          type: u32
> >          enum: version
> >          enum-as-flags: true
> > +      -
> > +        name: crypt-offset
> > +        doc: The offset from the end of the PSP header to the start of=
 the encrypted payload.
>
> In 4 octet units?
>

Yes. crypt-offset is in 4 octet units only. I will update the
description accordingly in the next v2 patch.

> > +        type: u8
> > +      -
> > +        name: spi-threshold
> > +        doc: Threshold for the SPI to trigger notification to the user=
 for appropriate rotate action.
> > +        type: u32
> > +
> >    -
> >      name: assoc
> >      attributes:
> > @@ -170,6 +179,8 @@ operations:
> >              - ifindex
> >              - psp-versions-cap
> >              - psp-versions-ena
> > +            - crypt-offset
> > +            - spi-threshold
> >          pre: psp-device-get-locked
> >          post: psp-device-unlock
> >        dump:
> > @@ -193,6 +204,8 @@ operations:
> >            attributes:
> >              - id
> >              - psp-versions-ena
> > +            - crypt-offset
> > +            - spi-threshold
> >          reply:
> >            attributes: []
> >          pre: psp-device-get-locked
> > diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> > index 25a9096d4e7d..875f7822557f 100644
> > --- a/include/net/psp/types.h
> > +++ b/include/net/psp/types.h
> > @@ -25,6 +25,9 @@ struct psphdr {
> >  #define PSP_SPI_KEY_ID               GENMASK(30, 0)
> >  #define PSP_SPI_KEY_PHASE    BIT(31)
> >
> > +/* Default SPI threshold: ~90% of max SPI (0x7FFFFFFF) to allow rotati=
on before exhaustion */
> > +#define PSP_SPI_THRESHOLD_DEFAULT    0x73333333
>
> Do you want to choose a more round number, in either hex or dec?
>

I think we can use 0x70000000; it's approximately 87.5% of the maximum SPI.

> > +
> >  #define PSPHDR_CRYPT_OFFSET  GENMASK(5, 0)
> >
> >  #define PSPHDR_VERFL_SAMPLE  BIT(7)
> > @@ -38,9 +41,13 @@ struct psphdr {
> >  /**
> >   * struct psp_dev_config - PSP device configuration
> >   * @versions: PSP versions enabled on the device
> > + * @crypt_offset: crypto offset configured on the device
> > + * @spi_threshold: SPI threshold value on the device
> >   */
> >  struct psp_dev_config {
> >       u32 versions;
> > +     u8 crypt_offset;
> > +     u32 spi_threshold;
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
> > index a3a336488dc3..bb390159dc72 100644
> > --- a/include/uapi/linux/psp.h
> > +++ b/include/uapi/linux/psp.h
> > @@ -22,6 +22,8 @@ enum {
> >       PSP_A_DEV_IFINDEX,
> >       PSP_A_DEV_PSP_VERSIONS_CAP,
> >       PSP_A_DEV_PSP_VERSIONS_ENA,
> > +     PSP_A_DEV_CRYPT_OFFSET,
> > +     PSP_A_DEV_SPI_THRESHOLD,
> >
> >       __PSP_A_DEV_MAX,
> >       PSP_A_DEV_MAX =3D (__PSP_A_DEV_MAX - 1)
> > diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
> > index 22a48d0fa378..e50b8b80955c 100644
> > --- a/net/psp/psp-nl-gen.c
> > +++ b/net/psp/psp-nl-gen.c
> > @@ -23,9 +23,11 @@ static const struct nla_policy psp_dev_get_nl_policy=
[PSP_A_DEV_ID + 1] =3D {
> >  };
> >
> >  /* PSP_CMD_DEV_SET - do */
> > -static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VER=
SIONS_ENA + 1] =3D {
> > +static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_SPI_THR=
ESHOLD + 1] =3D {
> >       [PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> >       [PSP_A_DEV_PSP_VERSIONS_ENA] =3D NLA_POLICY_MASK(NLA_U32, 0xf),
> > +     [PSP_A_DEV_CRYPT_OFFSET] =3D { .type =3D NLA_U8, },
> > +     [PSP_A_DEV_SPI_THRESHOLD] =3D { .type =3D NLA_U32, },
> >  };
> >
> >  /* PSP_CMD_KEY_ROTATE - do */
> > @@ -75,7 +77,7 @@ static const struct genl_split_ops psp_nl_ops[] =3D {
> >               .doit           =3D psp_nl_dev_set_doit,
> >               .post_doit      =3D psp_device_unlock,
> >               .policy         =3D psp_dev_set_nl_policy,
> > -             .maxattr        =3D PSP_A_DEV_PSP_VERSIONS_ENA,
> > +             .maxattr        =3D PSP_A_DEV_SPI_THRESHOLD,
> >               .flags          =3D GENL_CMD_CAP_DO,
> >       },
> >       {
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 9508b6c38003..536ee44db09d 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -79,6 +79,9 @@ psp_dev_create(struct net_device *netdev,
> >       INIT_LIST_HEAD(&psd->stale_assocs);
> >       refcount_set(&psd->refcnt, 1);
> >
> > +     /* ~90% of 0x7FFFFFFF; allows SPI rotation well before space is e=
xhausted */
>
> Repeat comment. Not needed here.
>

Ack

> > +     psd->config.spi_threshold =3D PSP_SPI_THRESHOLD_DEFAULT;
> > +
> >       mutex_lock(&psp_devs_lock);
> >       err =3D xa_alloc_cyclic(&psp_devs, &psd->id, psd, xa_limit_16b,
> >                             &last_id, GFP_KERNEL);
> > diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> > index 6afd7707ec12..fbb77460a24b 100644
> > --- a/net/psp/psp_nl.c
> > +++ b/net/psp/psp_nl.c
> > @@ -101,7 +101,9 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff=
 *rsp,
> >       if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
> >           nla_put_u32(rsp, PSP_A_DEV_IFINDEX, psd->main_netdev->ifindex=
) ||
> >           nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_CAP, psd->caps->versi=
ons) ||
> > -         nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.vers=
ions))
> > +         nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.vers=
ions) ||
> > +         nla_put_u8(rsp, PSP_A_DEV_CRYPT_OFFSET, psd->config.crypt_off=
set) ||
> > +         nla_put_u32(rsp, PSP_A_DEV_SPI_THRESHOLD, psd->config.spi_thr=
eshold))
> >               goto err_cancel_msg;
> >
> >       genlmsg_end(rsp, hdr);
> > @@ -193,6 +195,13 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struc=
t genl_info *info)
> >
> >       memcpy(&new_config, &psd->config, sizeof(new_config));
> >
> > +     if (!info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA] &&
> > +         !info->attrs[PSP_A_DEV_CRYPT_OFFSET] &&
> > +         !info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
> > +             NL_SET_ERR_MSG(info->extack, "No settings present");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]) {
> >               new_config.versions =3D
> >                       nla_get_u32(info->attrs[PSP_A_DEV_PSP_VERSIONS_EN=
A]);
> > @@ -200,9 +209,19 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struc=
t genl_info *info)
> >                       NL_SET_ERR_MSG(info->extack, "Requested PSP versi=
ons not supported by the device");
> >                       return -EINVAL;
> >               }
> > -     } else {
> > -             NL_SET_ERR_MSG(info->extack, "No settings present");
> > -             return -EINVAL;
> > +     }
> > +
> > +     if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
> > +             new_config.crypt_offset =3D
> > +                     nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);
>
> PSP defines a 6-bit field in 4 octet units. Does this need bounds checkin=
g?
>

 Yes, I will add the bound checks in the next v2 patch.
> > +
> > +     if (info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
> > +             new_config.spi_threshold =3D
> > +                     nla_get_u32(info->attrs[PSP_A_DEV_SPI_THRESHOLD])=
;
> > +             if (new_config.spi_threshold & PSP_SPI_KEY_PHASE) {
> > +                     NL_SET_ERR_MSG(info->extack, "SPI threshold must =
not have bit 31 set");
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       rsp =3D psp_nl_reply_new(info);
> > --
> > 2.45.4
> >
>
>

--000000000000c5dcab064f203ab5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKkdGKPjkVBb
o8BY/uZcx60KDCygwelDFaVJzLDMYXPMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxMDE5MzUwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAIMWMKGxCYZQXB8drz4xf15eGw+gKdutwB8HUMCQORrwXS+C
k+oCRK+WNPdlCz2mwMLylF2JjqjVMVRyX+Bqy3DBIyO8nodKThOcMLmUqUkQtC0pPfN2ttgNawM7
1HQQm9QbbGLZdXWBRpuWYfuP7zU0cV1Oz564xrOIv1xyzM+10UuHVVzIpn2KfRqx0TrmxCKjakwh
Ven+KHz4vHP5nS24ruEB6c2nkhzUIALJnJxh0jaRX8B++VwifwLL+jHN4ZPyCm8TgXFyFAiF0s7S
vv7W9bLWNPBCokf6ClzDgmCpdQ2JHiHHItyRH9CBkkJ+Zxy9/b4fEJRvaYuZ+mtyqFE=
--000000000000c5dcab064f203ab5--

