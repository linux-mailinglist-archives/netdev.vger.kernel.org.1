Return-Path: <netdev+bounces-279183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB0DN3dv4Wk1tQAAu9opvQ
	(envelope-from <netdev+bounces-279183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 01:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D7415885
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 01:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D1423037495
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80B39FCDF;
	Thu, 16 Apr 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoH5FTdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750539DBDB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381813; cv=pass; b=ORE5C1QbRvl6fI5rC9rUsDnDCQmKhnZk4p13MCKbwNbxeCi4jU1LWiQqOOkrzzaxM1J1eUre0anNEDAv1PT/ZYYBlPPaMGIk4EOJPWICgPFP7PQi7I6HWybXm59/hTaox0Pk3HXDSjUapYolRHGusi/MeJnMELWXs/x53uDG6y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381813; c=relaxed/simple;
	bh=MSl3nvuDSVMtfIj5JqZYbakxfH78fOSoz70nNrcEOzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaOyKy57h994G14rPsRNqSahFrt4AjwN67AhDz/wpoGVyh0lDRdigIfl+xrUYRKkECZMUdDMSmErhtv3cATUByh8pDco9F9cIHxnjMKBaLFftdg6XIULHHR3BGuTQqq31jcOgxUuWEfGAUGwpncdgbIOUghahcfJAdXPps18TSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoH5FTdN; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4232d4b3467so18342fac.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 16:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776381810; cv=none;
        d=google.com; s=arc-20240605;
        b=CLJrfVffFRSoTU3g4p4FEpiJdj0ErPmKPmkkwo2DoaORgSUIiXI8F5VTDM3/UBAxAJ
         XbJcYbFU9euRcSjEZsl/OQHVniap5l/Cog9IPj2Pnmu1pQCj+3BZuR19iHAo00AkqF1i
         CvEhzQrQ6Ot2DDHMs8zpHJ0LJN05d75GKuCplYmf/WsDM0s2xHElOsOLQEMKpgbJKwTk
         Pt7i+8KSCQiMGXOdV8FYXd1ErEz2rVwa7/YSECVHwrJ/moVhDNSz/928bhc08vnjgMtJ
         O8DSZRg18kuzaDYE8f1QTmUa9Z8lk1lCfrWREaoFPu3Wxh5CB5YLuJlyqAlUVA8uKMZ7
         zxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcWWL7/VaTPCw1yup7VvnnZzhSs44IpH/iH/9OjKiEs=;
        fh=h8JSi214CggotktuzEst9ijuHrMAI0LoQ4aepkxzokU=;
        b=iFm5u0IvSYWHbq+OXNhKXHQ68FUlzufu4SJtDrGYmcf5h0kcoeTqR5uRJKZKml4TXp
         tdOMU7PjCPcjem99fbbsBv/Z7cNa8H3CcZFn5sV4md+IOKnqx522H/pM0RetpHGD6CJT
         xIlyjH5ns/TwnGdEugEUSE1TY4oBElT7kxJyyYszGtpNYVyNIbQ0OmCgZQX4W1VEYzZC
         9OAXaUIo0NiluPLq6G/HCrdyDjDfkJRcLlRP2KZFwjKbd0AZ+UpuyKLRMtxeoYorUZ0N
         gbsCdrI4rKavqHVHwEKmllGW7PUMF6SoQP/vtnFEyj7ZBKmh/9mk9aaFVFA1lJtm7Rgc
         5ypw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776381810; x=1776986610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcWWL7/VaTPCw1yup7VvnnZzhSs44IpH/iH/9OjKiEs=;
        b=QoH5FTdNmWzIA6k6z59aRuCBFjBUWufh+jnf2ZJDA0mBsfmc5Xo24wlIO4p4aITo+S
         wuuwihjRtv1b8rHdPlClcQzvdrGdD/sYmdpHV7UwmDGJp2InNoka0EAvKmMkg2ylGkJ0
         pV94nrFE69YyGeW3Uh/6SKv4xepF0kMOcdbvBUDVqxVwj0eIa1GkVRCxm5tYwpg5burQ
         4KAfMSZrbblPnZdyuM2rcz+3L3BeUiQhr6yBktB5E7gaK84xul5tY04bN/inMLnYramU
         bm34A0p5+wwKcMjUMVHL3IqZVhYaHrNy5e6EdbK3pCRnSRoK754m1bBOmL60s1k8N/3P
         UXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381810; x=1776986610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcWWL7/VaTPCw1yup7VvnnZzhSs44IpH/iH/9OjKiEs=;
        b=hT77yPu9vfbrPtI2ZnJkQrjebedeY3vwMye+gg+Tq6JrlNcB30HZSb9LHHCnmT5rQX
         /uF7EwunNG/HGtkVLejzMh3i1jMaCuBT/+1dzjlI5MrC0wIsmE1ZC1tT3LP9ZgUG5mO7
         O1KVITjp30XQJXoEuxTLoqIGMJk4GiBokfxGCHmK+pdFCBhJxpTTA/mGsZ47yzKMQ8Vx
         KhlnyEFYMeCSgJiorsBP0+9MYPZNNq2Ts3Z5nWy+e/dS3DT4fDyf1L5E1tUi/zl5oRwC
         wpB8ssg+MfjhguX/cB0cHNyp1KxThqtoEZqrQ8Nq0tWanKbagw6E7T5BwQhdIH3cX1Ch
         Mmsw==
X-Gm-Message-State: AOJu0Yy9kOfbHd+4VmsloC2eTEVJotu6Ka5vdopp+DrXQ7PRTEsP4/kk
	Xsq589oSJMNaXJFbFqrlF1VdBjeqdPQjkR/Z0uPEqdqMXcydduH/UWMUperG72P/jpDh6soZjRz
	U/C9zqmaX+XSKtldRDghvzeXzFQxlPmbVLUK+m/I=
X-Gm-Gg: AeBDieu1+Nv1kzxX4mJUKY6ay4sVNxx3AhFH60SL/ya+4rnzrC07IopJtobfB5AnkMt
	thnsgXRsFi1QsQqKCjG3UAoihPIGBvHLU7Xu0sMIknHVyAu8bTRes4DZnzrUAFy23CiLUhpMU51
	2W6isPIRFdorCQuAqNE46fOd3C5gd4wgulWqLoUA73OebYNUPS8So9FEjePsTaBalmJLRN+wuEf
	1cinqIm7Mi1nMWPxz3eAfASOrdeyhqv7GClHElYqg3PL8kM1xVDy8Spp6LrR76fc48QBDytBM5G
	denNVSMqfa8ccjbf1C3YZP0EJquuLOf8yQ==
X-Received: by 2002:a05:6808:3442:b0:467:53b0:b44d with SMTP id
 5614622812f47-4799ca97211mr73456b6e.5.1776381809955; Thu, 16 Apr 2026
 16:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
 <20260408231415.522691-3-weibunny.kernel@gmail.com> <bc8ef831-a4ea-4d85-ab7c-a287c9b80e61@redhat.com>
 <CAGqc4nVZA+XSPbeO5_0OUvXzG1TMtqScrzNaUpuK0rVnR2ZFng@mail.gmail.com>
In-Reply-To: <CAGqc4nVZA+XSPbeO5_0OUvXzG1TMtqScrzNaUpuK0rVnR2ZFng@mail.gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Thu, 16 Apr 2026 16:23:16 -0700
X-Gm-Features: AQROBzBHnvIscbThv_NbJl1nJz2ICFoNV8XQFFLsvnMzMWnU8TSQ9dKeT1sTGPw
Message-ID: <CAGqc4nUaYk7DhJuMYRDkKg093i0C3DdWMYR5HYjmywUaNY8byA@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 521D7415885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 8:55=E2=80=AFPM Wei Wang <weibunny.kernel@gmail.com=
> wrote:
>
> On Mon, Apr 13, 2026 at 3:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> >
> >
> > On 4/9/26 1:14 AM, Wei Wang wrote:
> > > From: Wei Wang <weibunny@fb.com>
> > >
> > > The main purpose of this cmd is to be able to associate a
> > > non-psp-capable device (e.g. veth or netkit) with a psp device.
> > > One use case is if we create a pair of veth/netkit, and assign 1 end
> > > inside a netns, while leaving the other end within the default netns,
> > > with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> > > With this command, we could associate the veth/netkit inside the netn=
s
> > > with PSP device, so the virtual device could act as PSP-capable devic=
e
> > > to initiate PSP connections, and performs PSP encryption/decryption o=
n
> > > the real PSP device.
> > >
> > > Signed-off-by: Wei Wang <weibunny@fb.com>
> > > Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
> > > ---
> > >  Documentation/netlink/specs/psp.yaml |  67 +++++-
> > >  include/net/psp/types.h              |  15 ++
> > >  include/uapi/linux/psp.h             |  13 ++
> > >  net/psp/psp-nl-gen.c                 |  32 +++
> > >  net/psp/psp-nl-gen.h                 |   2 +
> > >  net/psp/psp_main.c                   |  20 ++
> > >  net/psp/psp_nl.c                     | 325 +++++++++++++++++++++++++=
+-
> > >  7 files changed, 462 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/net=
link/specs/psp.yaml
> > > index c54e1202cbe0..3d1b7223e084 100644
> > > --- a/Documentation/netlink/specs/psp.yaml
> > > +++ b/Documentation/netlink/specs/psp.yaml
> > > @@ -13,6 +13,17 @@ definitions:
> > >                hdr0-aes-gmac-128, hdr0-aes-gmac-256]
> > >
> > >  attribute-sets:
> > > +  -
> > > +    name: assoc-dev-info
> > > +    attributes:
> > > +      -
> > > +        name: ifindex
> > > +        doc: ifindex of an associated network device.
> > > +        type: u32
> > > +      -
> > > +        name: nsid
> > > +        doc: Network namespace ID of the associated device.
> > > +        type: s32
> > >    -
> > >      name: dev
> > >      attributes:
> > > @@ -24,7 +35,9 @@ attribute-sets:
> > >            min: 1
> > >        -
> > >          name: ifindex
> > > -        doc: ifindex of the main netdevice linked to the PSP device.
> > > +        doc: |
> > > +          ifindex of the main netdevice linked to the PSP device,
> > > +          or the ifindex to associate with the PSP device.
> > >          type: u32
> > >        -
> > >          name: psp-versions-cap
> > > @@ -38,6 +51,28 @@ attribute-sets:
> > >          type: u32
> > >          enum: version
> > >          enum-as-flags: true
> > > +      -
> > > +        name: assoc-list
> > > +        doc: List of associated virtual devices.
> > > +        type: nest
> > > +        nested-attributes: assoc-dev-info
> > > +        multi-attr: true
> > > +      -
> > > +        name: nsid
> > > +        doc: |
> > > +          Network namespace ID for the device to associate/disassoci=
ate.
> > > +          Optional for dev-assoc and dev-disassoc; if not present, t=
he
> > > +          device is looked up in the caller's network namespace.
> > > +        type: s32
> > > +      -
> > > +        name: by-association
> > > +        doc: |
> > > +          Flag indicating the PSP device is an associated device fro=
m a
> > > +          different network namespace.
> > > +          Present when in associated namespace, absent when in prima=
ry/host
> > > +          namespace.
> > > +        type: flag
> > > +
> > >    -
> > >      name: assoc
> > >      attributes:
> > > @@ -170,6 +205,8 @@ operations:
> > >              - ifindex
> > >              - psp-versions-cap
> > >              - psp-versions-ena
> > > +            - assoc-list
> > > +            - by-association
> > >          pre: psp-device-get-locked
> > >          post: psp-device-unlock
> > >        dump:
> > > @@ -279,6 +316,34 @@ operations:
> > >          post: psp-device-unlock
> > >        dump:
> > >          reply: *stats-all
> > > +    -
> > > +      name: dev-assoc
> > > +      doc: Associate a network device with a PSP device.
> > > +      attribute-set: dev
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - id
> > > +            - ifindex
> > > +            - nsid
> > > +        reply:
> > > +          attributes: []
> > > +        pre: psp-device-get-locked
> > > +        post: psp-device-unlock
> > > +    -
> > > +      name: dev-disassoc
> > > +      doc: Disassociate a network device from a PSP device.
> > > +      attribute-set: dev
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - id
> > > +            - ifindex
> > > +            - nsid
> > > +        reply:
> > > +          attributes: []
> > > +        pre: psp-device-get-locked
> > > +        post: psp-device-unlock
> > >
> > >  mcast-groups:
> > >    list:
> > > diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> > > index 25a9096d4e7d..4bd432ed107a 100644
> > > --- a/include/net/psp/types.h
> > > +++ b/include/net/psp/types.h
> > > @@ -5,6 +5,7 @@
> > >
> > >  #include <linux/mutex.h>
> > >  #include <linux/refcount.h>
> > > +#include <net/net_trackers.h>
> > >
> > >  struct netlink_ext_ack;
> > >
> > > @@ -43,9 +44,22 @@ struct psp_dev_config {
> > >       u32 versions;
> > >  };
> > >
> > > +/**
> > > + * struct psp_assoc_dev - wrapper for associated net_device
> > > + * @dev_list: list node for psp_dev::assoc_dev_list
> > > + * @assoc_dev: the associated net_device
> > > + * @dev_tracker: tracker for the net_device reference
> > > + */
> > > +struct psp_assoc_dev {
> > > +     struct list_head dev_list;
> > > +     struct net_device *assoc_dev;
> > > +     netdevice_tracker dev_tracker;
> > > +};
> > > +
> > >  /**
> > >   * struct psp_dev - PSP device struct
> > >   * @main_netdev: original netdevice of this PSP device
> > > + * @assoc_dev_list: list of psp_assoc_dev entries associated with th=
is PSP device
> > >   * @ops:     driver callbacks
> > >   * @caps:    device capabilities
> > >   * @drv_priv:        driver priv pointer
> > > @@ -67,6 +81,7 @@ struct psp_dev_config {
> > >   */
> > >  struct psp_dev {
> > >       struct net_device *main_netdev;
> > > +     struct list_head assoc_dev_list;
> > >
> > >       struct psp_dev_ops *ops;
> > >       struct psp_dev_caps *caps;
> > > diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
> > > index a3a336488dc3..1c8899cd4da5 100644
> > > --- a/include/uapi/linux/psp.h
> > > +++ b/include/uapi/linux/psp.h
> > > @@ -17,11 +17,22 @@ enum psp_version {
> > >       PSP_VERSION_HDR0_AES_GMAC_256,
> > >  };
> > >
> > > +enum {
> > > +     PSP_A_ASSOC_DEV_INFO_IFINDEX =3D 1,
> > > +     PSP_A_ASSOC_DEV_INFO_NSID,
> > > +
> > > +     __PSP_A_ASSOC_DEV_INFO_MAX,
> > > +     PSP_A_ASSOC_DEV_INFO_MAX =3D (__PSP_A_ASSOC_DEV_INFO_MAX - 1)
> > > +};
> > > +
> > >  enum {
> > >       PSP_A_DEV_ID =3D 1,
> > >       PSP_A_DEV_IFINDEX,
> > >       PSP_A_DEV_PSP_VERSIONS_CAP,
> > >       PSP_A_DEV_PSP_VERSIONS_ENA,
> > > +     PSP_A_DEV_ASSOC_LIST,
> > > +     PSP_A_DEV_NSID,
> > > +     PSP_A_DEV_BY_ASSOCIATION,
> > >
> > >       __PSP_A_DEV_MAX,
> > >       PSP_A_DEV_MAX =3D (__PSP_A_DEV_MAX - 1)
> > > @@ -74,6 +85,8 @@ enum {
> > >       PSP_CMD_RX_ASSOC,
> > >       PSP_CMD_TX_ASSOC,
> > >       PSP_CMD_GET_STATS,
> > > +     PSP_CMD_DEV_ASSOC,
> > > +     PSP_CMD_DEV_DISASSOC,
> > >
> > >       __PSP_CMD_MAX,
> > >       PSP_CMD_MAX =3D (__PSP_CMD_MAX - 1)
> > > diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
> > > index 1f5e73e7ccc1..114299c64423 100644
> > > --- a/net/psp/psp-nl-gen.c
> > > +++ b/net/psp/psp-nl-gen.c
> > > @@ -53,6 +53,20 @@ static const struct nla_policy psp_get_stats_nl_po=
licy[PSP_A_STATS_DEV_ID + 1] =3D
> > >       [PSP_A_STATS_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > >  };
> > >
> > > +/* PSP_CMD_DEV_ASSOC - do */
> > > +static const struct nla_policy psp_dev_assoc_nl_policy[PSP_A_DEV_NSI=
D + 1] =3D {
> > > +     [PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > > +     [PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
> > > +     [PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
> > > +};
> > > +
> > > +/* PSP_CMD_DEV_DISASSOC - do */
> > > +static const struct nla_policy psp_dev_disassoc_nl_policy[PSP_A_DEV_=
NSID + 1] =3D {
> > > +     [PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > > +     [PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
> > > +     [PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
> > > +};
> > > +
> > >  /* Ops table for psp */
> > >  static const struct genl_split_ops psp_nl_ops[] =3D {
> > >       {
> > > @@ -119,6 +133,24 @@ static const struct genl_split_ops psp_nl_ops[] =
=3D {
> > >               .dumpit =3D psp_nl_get_stats_dumpit,
> > >               .flags  =3D GENL_CMD_CAP_DUMP,
> > >       },
> > > +     {
> > > +             .cmd            =3D PSP_CMD_DEV_ASSOC,
> > > +             .pre_doit       =3D psp_device_get_locked,
> > > +             .doit           =3D psp_nl_dev_assoc_doit,
> > > +             .post_doit      =3D psp_device_unlock,
> > > +             .policy         =3D psp_dev_assoc_nl_policy,
> > > +             .maxattr        =3D PSP_A_DEV_NSID,
> > > +             .flags          =3D GENL_CMD_CAP_DO,
> > > +     },
> > > +     {
> > > +             .cmd            =3D PSP_CMD_DEV_DISASSOC,
> > > +             .pre_doit       =3D psp_device_get_locked,
> > > +             .doit           =3D psp_nl_dev_disassoc_doit,
> > > +             .post_doit      =3D psp_device_unlock,
> > > +             .policy         =3D psp_dev_disassoc_nl_policy,
> > > +             .maxattr        =3D PSP_A_DEV_NSID,
> > > +             .flags          =3D GENL_CMD_CAP_DO,
> >
> > Sashiko notes that the above allows deleteing an associations bypassing
> > the netns boundaries. Do you need ADMIN_PERM flag or exlicit checks in
> > the doit cb?
>
> I think the concern is if we are calling this from an assoc_dev's
> netns, it should not allow it to delete any assoc_dev from other
> assoc_dev's netns. Right?
> I will add a check to only allow deletion of assoc_dev from its own
> netns.  (except main_dev's netns).
>

Further on this point, I think a cleaner solution is to just reject
user passing in nsid if the user is not in dev_net(psd->main_netdev).
In such situation, we should only do dev-assoc/dev-disassoc within the
current user netns. So no point of passing in nsid.
We only allow nsid to be passed in if the user is in
dev_net(psd->main_netdev), i.e. admin user.
Let me know your thoughts on this. @Daniel Zahka @Paolo Abeni

> >
> > > @@ -292,6 +455,145 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb,=
 struct genl_info *info)
> > >       return err;
> > >  }
> > >
> > > +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *inf=
o)
> > > +{
> > > +     struct psp_dev *psd =3D info->user_ptr[0];
> > > +     struct psp_assoc_dev *psp_assoc_dev;
> > > +     struct net_device *assoc_dev;
> > > +     struct sk_buff *rsp;
> > > +     u32 assoc_ifindex;
> > > +     struct net *net;
> > > +     int nsid, err;
> > > +
> > > +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> > > +             return -EINVAL;
> > > +
> > > +     if (info->attrs[PSP_A_DEV_NSID]) {
> > > +             nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> > > +
> > > +             net =3D get_net_ns_by_id(genl_info_net(info), nsid);
> > > +             if (!net) {
> > > +                     NL_SET_BAD_ATTR(info->extack,
> > > +                                     info->attrs[PSP_A_DEV_NSID]);
> > > +                     return -EINVAL;
> > > +             }
> > > +     } else {
> > > +             net =3D get_net(genl_info_net(info));
> > > +     }
> >
> > psp_nl_dev_disassoc_doit() has the same code; perhaps it would be worth=
y
> > move it in a common helper, called via pre_doit()? It should also
> > simplify the cleanup paths.
> >
>
> Ack.
>
> > > +
> > > +     psp_assoc_dev =3D kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> > > +     if (!psp_assoc_dev) {
> > > +             err =3D -ENOMEM;
> > > +             goto alloc_err;
> > > +     }
> > > +
> > > +     assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> > > +     assoc_dev =3D netdev_get_by_index(net, assoc_ifindex,
> > > +                                     &psp_assoc_dev->dev_tracker,
> > > +                                     GFP_KERNEL);
> > > +     if (!assoc_dev) {
> > > +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFI=
NDEX]);
> > > +             err =3D -ENODEV;
> > > +             goto assoc_dev_err;
> > > +     }
> > > +
> > > +     /* Check if device is already associated with a PSP device */
> > > +     if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
> > > +             NL_SET_ERR_MSG(info->extack,
> > > +                            "Device already associated with a PSP de=
vice");
> > > +             err =3D -EBUSY;
> > > +             goto cmpxchg_err;
> > > +     }
> > > +
> > > +     psp_assoc_dev->assoc_dev =3D assoc_dev;
> > > +     rsp =3D psp_nl_reply_new(info);
> > > +     if (!rsp) {
> > > +             err =3D -ENOMEM;
> > > +             goto rsp_err;
> > > +     }
> > > +
> > > +     list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
> >
> > Sashiko says:
> >
> > ---
> > list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
> > There doesn't seem to be a limit on the number of devices that can be
> > associated with a single PSP device.
> > If a user repeatedly associates devices, could the generated netlink me=
ssage
> > in psp_nl_dev_fill() exceed the maximum allowed size (GENLMSG_DEFAULT_S=
IZE),
> > causing it to fail with -EMSGSIZE and permanently break PSP_CMD_DEV_GET
> > and management notifications for the device?
> > --
>
> Ack. Will enforce a max allowed number on the assoc_dev_list to fit
> into GENLMSG_DEFAULT_SIZE.
>
> >
> > /P
> >

