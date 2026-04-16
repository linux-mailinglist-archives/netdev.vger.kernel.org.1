Return-Path: <netdev+bounces-278919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Go/BA5e4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:57:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71840A1B2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3467A3016177
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A68275848;
	Thu, 16 Apr 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfkKJwKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1C27AC4C
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311752; cv=pass; b=sNL+n+18TXgpkU9s9XvaTm/zA+ZehwjVCXp2KXAq+DzZ49BA1P9JIulAHJnDS1Yh0mUwMzSjUclziGPSz7aKDLY1yeLUCfB+vjE30tElraezuzsXon9OZvEEwjtnAIYejGVLKfGmUmgRrJrv9eZuf7rHNzjNy1eDmIsk70TvB7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311752; c=relaxed/simple;
	bh=OcYN5IGXghYWFoAIchFWJw3FkppmQylxuBo9OALWQYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOrqjQtuNMaN2f9DFkmCK4LB1K38f0Jxu22BR6aZDiwTRHRBlLsqmXYTK1/PriBJVK06b/Km8ZCxJvHrvzxS3ZzHWbL2/dL30/gdZ5DhYrcrIRg3HLuTBGUPS/iyvo4mpMCyJ4o6wUC8o/IWVeIjgPZLsfq5VpFEReXrHDMoIIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfkKJwKw; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40947c81b31so343181fac.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 20:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776311750; cv=none;
        d=google.com; s=arc-20240605;
        b=dwBVem+VNmVxmEIHAo0MVEtsC2dVPcD+b0H74sPriBJ4oCBKK8v47MgmWPjzNlztdA
         6dHWCPFLiOcTfoDO9w87NxFSuhbohtFWj7aHI810MjXx0T5xH8wpHfVhfB/gK6P8OOjC
         E0Bea8MdUKZX6knOZ4BhEpB4HX2rgrN+CEQDSmmmJVHYoIih3d93G6EBof30zwbEgulD
         rZCaTeBaiEM7kTEnNwSPfWyrKZkZaLQ4WIKqpucb1CvSFAGgpMytRS0qR2nnZlDK3n2K
         zQHrGgQpbSCDbUM6mOUVCFR2H/QML2CPvB5U8E6h//88ZijDDJFaEUZnmH3msdZeTVGy
         m7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnflnbGtuYVuzyIj7FT4Da3iZhZDEzJCKiZl3ehn6uI=;
        fh=h8JSi214CggotktuzEst9ijuHrMAI0LoQ4aepkxzokU=;
        b=DyOULXUoYTZNt6r9oN5G1hXorSeN1CtY8wjcFbHr1OrB5JdRtJJ64B2LG2mMlKAHkB
         ZdhmZiE3XTyZ98YVTG+IjXdQPE7s7sRlV5lQLCvmLnvId36qirOscdxBqTzfkGnbUTVl
         8WLBnOoE+aAO/Nh0ZZGiwwbkB6c9n6XTsSHFS4gM+e58GegOTViAKThD1plRDlEo76W2
         BsG1PHARArMqLw/kgx5Kfn28Jxw001TRhEQKDWZIxT3RejKuZ6gJ5jZMX2cy7se3jJCn
         0/2O+Cnx+l62wJbs/2jJljNw/M6QsOJ8n5KtiJffzCKq5SE1U2ksauFojLVZYDBhNCF+
         aitg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776311750; x=1776916550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnflnbGtuYVuzyIj7FT4Da3iZhZDEzJCKiZl3ehn6uI=;
        b=DfkKJwKwqACQ1YjW8Gz2+zv+g4F0oHeHcqjIyvWxqoPtoMHx/mfdbnRRR3Qk9DvVw3
         0VJq3zVl8bHGOJVwgDiI7gcXICKpZA7yxOMRHebSDlgom2LUZ3KmBvtr9ksSRXbdUOnN
         z6glMLXsyBJzM1ocAscYDLWd8xbA/ypfgCFjc/vpMcoR/O3mj/VaQ5YyCtRkGfOdSNQC
         ahe4afRZgSbvtf1rcEO8DfZakcrqHk196p61bpE1Ozoy6Lbdugdy/1whYACvWp/ylH3S
         43ll0u6xNG4Kn2l2q69lME/KgxAtjF4xeHH6F3cX+km0j6GD0G4/E+ZyoWaRstG2cutf
         agCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776311750; x=1776916550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnflnbGtuYVuzyIj7FT4Da3iZhZDEzJCKiZl3ehn6uI=;
        b=SCEI7td/+r884LtoikjKn0bsLmlZ4JUOVkrXtXmzBkfyMaDsdbk95Jr/OZUokgjNKy
         OoUhB1Wbe8yFLVLYygyJX90K8+QXa7hFJCwuaad67iuDGUVSAD6WG3xiSV7AMytiagpj
         V+3A9Rs/Y9tmFBt9WiepLFRpbV/3tsxaczd9/hArxC/baFEcbLqseM8xuitzEWxsadfk
         HDcOB+K9lb+LEfgUJWU5tqKkdUXR8W7ygsvZVqWtod+3eFLj9qE63rysF+KgpCYxmlNC
         23RZKCRiiMtrSvGGiTA2N8Hv/MUnOEcWAQ0+C0d/y2o4aKOYaTQPsi5uZyZs3UosaPT3
         +/ig==
X-Gm-Message-State: AOJu0YyDRVJJV14xcA8gNdc9t7X9dAiB1W50EwUuSPzMFR6ftgjv4DV+
	rDbeqazcLl4uZpaOYViWlUbtd+4RdS9Ig7GTh0vbpzMB+9zOXlsYvcxAADjPt4sJ/BS7eDs+ZmC
	c2TT3k58q+CYJyAT9LHA4zHSxi8t0MKo=
X-Gm-Gg: AeBDiesFBPqxAhPiiGwEauVzOaJmRh9k8YUIGIO7efhBrAGWMb/sWnT0dhuwoOS2T98
	ZPfTlt4o9rhXWY/o+L8uha+S685azTmMZ0XXd58tTubdZhG9P+IcjJ88vcr081VZg+8XQLCzijr
	xi+E6JLHunhnp5AcOWAjdDxxSbyFtHsrCNWZFcvZz3m39EXKoufxCrS6SloeCdkMvWMhNfcjABr
	dD6+eNxuNcfyYcmnuXFPwEaFMB2ctM4TSm2LlQ8jSFWha+Y081RNmUXSLVfx4T1jEwHdJMk9c5w
	fiL5luEKmalARlub
X-Received: by 2002:a05:6808:bc2:b0:46e:df55:240f with SMTP id
 5614622812f47-479890b9538mr286612b6e.7.1776311749765; Wed, 15 Apr 2026
 20:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
 <20260408231415.522691-3-weibunny.kernel@gmail.com> <bc8ef831-a4ea-4d85-ab7c-a287c9b80e61@redhat.com>
In-Reply-To: <bc8ef831-a4ea-4d85-ab7c-a287c9b80e61@redhat.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 15 Apr 2026 20:55:38 -0700
X-Gm-Features: AQROBzDI51ysVVr5tP_HvjmVXjXbnScXYJu5Za1jfWmMoEA3M8rM4efnTQiEEoo
Message-ID: <CAGqc4nVZA+XSPbeO5_0OUvXzG1TMtqScrzNaUpuK0rVnR2ZFng@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278919-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D71840A1B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 3:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 4/9/26 1:14 AM, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > The main purpose of this cmd is to be able to associate a
> > non-psp-capable device (e.g. veth or netkit) with a psp device.
> > One use case is if we create a pair of veth/netkit, and assign 1 end
> > inside a netns, while leaving the other end within the default netns,
> > with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> > With this command, we could associate the veth/netkit inside the netns
> > with PSP device, so the virtual device could act as PSP-capable device
> > to initiate PSP connections, and performs PSP encryption/decryption on
> > the real PSP device.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
> > Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
> > ---
> >  Documentation/netlink/specs/psp.yaml |  67 +++++-
> >  include/net/psp/types.h              |  15 ++
> >  include/uapi/linux/psp.h             |  13 ++
> >  net/psp/psp-nl-gen.c                 |  32 +++
> >  net/psp/psp-nl-gen.h                 |   2 +
> >  net/psp/psp_main.c                   |  20 ++
> >  net/psp/psp_nl.c                     | 325 ++++++++++++++++++++++++++-
> >  7 files changed, 462 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netli=
nk/specs/psp.yaml
> > index c54e1202cbe0..3d1b7223e084 100644
> > --- a/Documentation/netlink/specs/psp.yaml
> > +++ b/Documentation/netlink/specs/psp.yaml
> > @@ -13,6 +13,17 @@ definitions:
> >                hdr0-aes-gmac-128, hdr0-aes-gmac-256]
> >
> >  attribute-sets:
> > +  -
> > +    name: assoc-dev-info
> > +    attributes:
> > +      -
> > +        name: ifindex
> > +        doc: ifindex of an associated network device.
> > +        type: u32
> > +      -
> > +        name: nsid
> > +        doc: Network namespace ID of the associated device.
> > +        type: s32
> >    -
> >      name: dev
> >      attributes:
> > @@ -24,7 +35,9 @@ attribute-sets:
> >            min: 1
> >        -
> >          name: ifindex
> > -        doc: ifindex of the main netdevice linked to the PSP device.
> > +        doc: |
> > +          ifindex of the main netdevice linked to the PSP device,
> > +          or the ifindex to associate with the PSP device.
> >          type: u32
> >        -
> >          name: psp-versions-cap
> > @@ -38,6 +51,28 @@ attribute-sets:
> >          type: u32
> >          enum: version
> >          enum-as-flags: true
> > +      -
> > +        name: assoc-list
> > +        doc: List of associated virtual devices.
> > +        type: nest
> > +        nested-attributes: assoc-dev-info
> > +        multi-attr: true
> > +      -
> > +        name: nsid
> > +        doc: |
> > +          Network namespace ID for the device to associate/disassociat=
e.
> > +          Optional for dev-assoc and dev-disassoc; if not present, the
> > +          device is looked up in the caller's network namespace.
> > +        type: s32
> > +      -
> > +        name: by-association
> > +        doc: |
> > +          Flag indicating the PSP device is an associated device from =
a
> > +          different network namespace.
> > +          Present when in associated namespace, absent when in primary=
/host
> > +          namespace.
> > +        type: flag
> > +
> >    -
> >      name: assoc
> >      attributes:
> > @@ -170,6 +205,8 @@ operations:
> >              - ifindex
> >              - psp-versions-cap
> >              - psp-versions-ena
> > +            - assoc-list
> > +            - by-association
> >          pre: psp-device-get-locked
> >          post: psp-device-unlock
> >        dump:
> > @@ -279,6 +316,34 @@ operations:
> >          post: psp-device-unlock
> >        dump:
> >          reply: *stats-all
> > +    -
> > +      name: dev-assoc
> > +      doc: Associate a network device with a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
> > +    -
> > +      name: dev-disassoc
> > +      doc: Disassociate a network device from a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
> >
> >  mcast-groups:
> >    list:
> > diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> > index 25a9096d4e7d..4bd432ed107a 100644
> > --- a/include/net/psp/types.h
> > +++ b/include/net/psp/types.h
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/mutex.h>
> >  #include <linux/refcount.h>
> > +#include <net/net_trackers.h>
> >
> >  struct netlink_ext_ack;
> >
> > @@ -43,9 +44,22 @@ struct psp_dev_config {
> >       u32 versions;
> >  };
> >
> > +/**
> > + * struct psp_assoc_dev - wrapper for associated net_device
> > + * @dev_list: list node for psp_dev::assoc_dev_list
> > + * @assoc_dev: the associated net_device
> > + * @dev_tracker: tracker for the net_device reference
> > + */
> > +struct psp_assoc_dev {
> > +     struct list_head dev_list;
> > +     struct net_device *assoc_dev;
> > +     netdevice_tracker dev_tracker;
> > +};
> > +
> >  /**
> >   * struct psp_dev - PSP device struct
> >   * @main_netdev: original netdevice of this PSP device
> > + * @assoc_dev_list: list of psp_assoc_dev entries associated with this=
 PSP device
> >   * @ops:     driver callbacks
> >   * @caps:    device capabilities
> >   * @drv_priv:        driver priv pointer
> > @@ -67,6 +81,7 @@ struct psp_dev_config {
> >   */
> >  struct psp_dev {
> >       struct net_device *main_netdev;
> > +     struct list_head assoc_dev_list;
> >
> >       struct psp_dev_ops *ops;
> >       struct psp_dev_caps *caps;
> > diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
> > index a3a336488dc3..1c8899cd4da5 100644
> > --- a/include/uapi/linux/psp.h
> > +++ b/include/uapi/linux/psp.h
> > @@ -17,11 +17,22 @@ enum psp_version {
> >       PSP_VERSION_HDR0_AES_GMAC_256,
> >  };
> >
> > +enum {
> > +     PSP_A_ASSOC_DEV_INFO_IFINDEX =3D 1,
> > +     PSP_A_ASSOC_DEV_INFO_NSID,
> > +
> > +     __PSP_A_ASSOC_DEV_INFO_MAX,
> > +     PSP_A_ASSOC_DEV_INFO_MAX =3D (__PSP_A_ASSOC_DEV_INFO_MAX - 1)
> > +};
> > +
> >  enum {
> >       PSP_A_DEV_ID =3D 1,
> >       PSP_A_DEV_IFINDEX,
> >       PSP_A_DEV_PSP_VERSIONS_CAP,
> >       PSP_A_DEV_PSP_VERSIONS_ENA,
> > +     PSP_A_DEV_ASSOC_LIST,
> > +     PSP_A_DEV_NSID,
> > +     PSP_A_DEV_BY_ASSOCIATION,
> >
> >       __PSP_A_DEV_MAX,
> >       PSP_A_DEV_MAX =3D (__PSP_A_DEV_MAX - 1)
> > @@ -74,6 +85,8 @@ enum {
> >       PSP_CMD_RX_ASSOC,
> >       PSP_CMD_TX_ASSOC,
> >       PSP_CMD_GET_STATS,
> > +     PSP_CMD_DEV_ASSOC,
> > +     PSP_CMD_DEV_DISASSOC,
> >
> >       __PSP_CMD_MAX,
> >       PSP_CMD_MAX =3D (__PSP_CMD_MAX - 1)
> > diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
> > index 1f5e73e7ccc1..114299c64423 100644
> > --- a/net/psp/psp-nl-gen.c
> > +++ b/net/psp/psp-nl-gen.c
> > @@ -53,6 +53,20 @@ static const struct nla_policy psp_get_stats_nl_poli=
cy[PSP_A_STATS_DEV_ID + 1] =3D
> >       [PSP_A_STATS_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> >  };
> >
> > +/* PSP_CMD_DEV_ASSOC - do */
> > +static const struct nla_policy psp_dev_assoc_nl_policy[PSP_A_DEV_NSID =
+ 1] =3D {
> > +     [PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
> > +     [PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
> > +};
> > +
> > +/* PSP_CMD_DEV_DISASSOC - do */
> > +static const struct nla_policy psp_dev_disassoc_nl_policy[PSP_A_DEV_NS=
ID + 1] =3D {
> > +     [PSP_A_DEV_ID] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [PSP_A_DEV_IFINDEX] =3D { .type =3D NLA_U32, },
> > +     [PSP_A_DEV_NSID] =3D { .type =3D NLA_S32, },
> > +};
> > +
> >  /* Ops table for psp */
> >  static const struct genl_split_ops psp_nl_ops[] =3D {
> >       {
> > @@ -119,6 +133,24 @@ static const struct genl_split_ops psp_nl_ops[] =
=3D {
> >               .dumpit =3D psp_nl_get_stats_dumpit,
> >               .flags  =3D GENL_CMD_CAP_DUMP,
> >       },
> > +     {
> > +             .cmd            =3D PSP_CMD_DEV_ASSOC,
> > +             .pre_doit       =3D psp_device_get_locked,
> > +             .doit           =3D psp_nl_dev_assoc_doit,
> > +             .post_doit      =3D psp_device_unlock,
> > +             .policy         =3D psp_dev_assoc_nl_policy,
> > +             .maxattr        =3D PSP_A_DEV_NSID,
> > +             .flags          =3D GENL_CMD_CAP_DO,
> > +     },
> > +     {
> > +             .cmd            =3D PSP_CMD_DEV_DISASSOC,
> > +             .pre_doit       =3D psp_device_get_locked,
> > +             .doit           =3D psp_nl_dev_disassoc_doit,
> > +             .post_doit      =3D psp_device_unlock,
> > +             .policy         =3D psp_dev_disassoc_nl_policy,
> > +             .maxattr        =3D PSP_A_DEV_NSID,
> > +             .flags          =3D GENL_CMD_CAP_DO,
>
> Sashiko notes that the above allows deleteing an associations bypassing
> the netns boundaries. Do you need ADMIN_PERM flag or exlicit checks in
> the doit cb?

I think the concern is if we are calling this from an assoc_dev's
netns, it should not allow it to delete any assoc_dev from other
assoc_dev's netns. Right?
I will add a check to only allow deletion of assoc_dev from its own
netns.  (except main_dev's netns).

>
> > @@ -292,6 +455,145 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >       return err;
> >  }
> >
> > +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     struct psp_assoc_dev *psp_assoc_dev;
> > +     struct net_device *assoc_dev;
> > +     struct sk_buff *rsp;
> > +     u32 assoc_ifindex;
> > +     struct net *net;
> > +     int nsid, err;
> > +
> > +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> > +             return -EINVAL;
> > +
> > +     if (info->attrs[PSP_A_DEV_NSID]) {
> > +             nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> > +
> > +             net =3D get_net_ns_by_id(genl_info_net(info), nsid);
> > +             if (!net) {
> > +                     NL_SET_BAD_ATTR(info->extack,
> > +                                     info->attrs[PSP_A_DEV_NSID]);
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             net =3D get_net(genl_info_net(info));
> > +     }
>
> psp_nl_dev_disassoc_doit() has the same code; perhaps it would be worthy
> move it in a common helper, called via pre_doit()? It should also
> simplify the cleanup paths.
>

Ack.

> > +
> > +     psp_assoc_dev =3D kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> > +     if (!psp_assoc_dev) {
> > +             err =3D -ENOMEM;
> > +             goto alloc_err;
> > +     }
> > +
> > +     assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> > +     assoc_dev =3D netdev_get_by_index(net, assoc_ifindex,
> > +                                     &psp_assoc_dev->dev_tracker,
> > +                                     GFP_KERNEL);
> > +     if (!assoc_dev) {
> > +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFIND=
EX]);
> > +             err =3D -ENODEV;
> > +             goto assoc_dev_err;
> > +     }
> > +
> > +     /* Check if device is already associated with a PSP device */
> > +     if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
> > +             NL_SET_ERR_MSG(info->extack,
> > +                            "Device already associated with a PSP devi=
ce");
> > +             err =3D -EBUSY;
> > +             goto cmpxchg_err;
> > +     }
> > +
> > +     psp_assoc_dev->assoc_dev =3D assoc_dev;
> > +     rsp =3D psp_nl_reply_new(info);
> > +     if (!rsp) {
> > +             err =3D -ENOMEM;
> > +             goto rsp_err;
> > +     }
> > +
> > +     list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
>
> Sashiko says:
>
> ---
> list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
> There doesn't seem to be a limit on the number of devices that can be
> associated with a single PSP device.
> If a user repeatedly associates devices, could the generated netlink mess=
age
> in psp_nl_dev_fill() exceed the maximum allowed size (GENLMSG_DEFAULT_SIZ=
E),
> causing it to fail with -EMSGSIZE and permanently break PSP_CMD_DEV_GET
> and management notifications for the device?
> --

Ack. Will enforce a max allowed number on the assoc_dev_list to fit
into GENLMSG_DEFAULT_SIZE.

>
> /P
>

