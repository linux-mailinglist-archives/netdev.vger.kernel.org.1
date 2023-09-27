Return-Path: <netdev+bounces-36390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB87AF7B2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 40AAA1C208C2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD5185F;
	Wed, 27 Sep 2023 01:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125D15CA
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:31:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC61FC9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695778283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKKWgd5VsqXZ/BIG1sZfFJbYnkYOL9oMt5Zq9rtrFwA=;
	b=Ib5g9FbVIvQaz6yWzEi/EPZ8Y4HAu7xsrCanMRQSx0F7JqdoweoZcYdGWsMntElTmYr7OQ
	zlzfnRMAqMbZKrwIlklwILdF9Tcc92M/gKBQYqSve3G/egWoQcGPnZCA028vN1zEEq/41W
	kSUE3eXSRoAqesrbK6wmB3s5iekuxmA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-oWFo9Qt8O4uAyRRjeF7N-g-1; Tue, 26 Sep 2023 21:31:22 -0400
X-MC-Unique: oWFo9Qt8O4uAyRRjeF7N-g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so860867466b.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778281; x=1696383081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKKWgd5VsqXZ/BIG1sZfFJbYnkYOL9oMt5Zq9rtrFwA=;
        b=L6MuJ0tkaPR5cz6XFlkTVm7gR2gAA7axdlwFOW0DGxfsYPYVwOvGsWAXYodUio4avS
         XD0w+bmkKONGTSMfCwvJr3WG0UjA7Y+48+/Y0nujaafrrmxCYOTkJX9UYAbPPl8YG8Zp
         ua3J11/Xz6XCkbNgBwM75RxrKoZu2D+38X7i3O92zoUUB82OabQfbHP6CymS7w/TwPlM
         if9dMy6o7DZdZf9K6lC5iAxgz5KfYi4UrD9MlHgzNH91QCOAtXXQc1rHgZ3saJtypIss
         rEWAbWY53DFes0iFnm6d0z6N9mIlVaW9NaF6p0quFT8WW+emKpDoStZWH8noUFioxFIV
         nxZw==
X-Gm-Message-State: AOJu0YwQs0u/Q04GvrqIHvFScDCaoCN9TI7sgjYkKDiNrlG8jEg9j4+n
	UwSBgPnnHpsMXJp+rCsQJOUOJpoaJv4xqU+6ab2FRAqZopov3jFXym148HmLhjKwvqYrphn+p9S
	8mUgClWJpudP7mReAVGPwg+3KQ8xB/PZt
X-Received: by 2002:a17:906:3112:b0:9ae:6388:e09b with SMTP id 18-20020a170906311200b009ae6388e09bmr324722ejx.40.1695778280956;
        Tue, 26 Sep 2023 18:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGieOngArYKjbDZq9ItVo4lMu8KHH9bkbQTWHVzS+VH7ZAmNietCpu1nvdDCLEVyOAgGWGkqlAqAMKupLcDZM=
X-Received: by 2002:a17:906:3112:b0:9ae:6388:e09b with SMTP id
 18-20020a170906311200b009ae6388e09bmr324708ejx.40.1695778280682; Tue, 26 Sep
 2023 18:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-8-miquel.raynal@bootlin.com> <CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
 <20230925094343.598c81d1@xps-13>
In-Reply-To: <20230925094343.598c81d1@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 26 Sep 2023 21:31:09 -0400
Message-ID: <CAK-6q+jFmvXGWOJFvHagC06mnbu6O1=Ndg8auNkGXTaqSf-7rg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Sep 25, 2023 at 3:43=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 24 Sep 2023 20:13:34 -0400:
>
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Coordinators may have to handle association requests from peers which
> > > want to join the PAN. The logic involves:
> > > - Acknowledging the request (done by hardware)
> > > - If requested, a random short address that is free on this PAN shoul=
d
> > >   be chosen for the device.
> > > - Sending an association response with the short address allocated fo=
r
> > >   the peer and expecting it to be ack'ed.
> > >
> > > If anything fails during this procedure, the peer is considered not
> > > associated.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/net/cfg802154.h         |   7 ++
> > >  include/net/ieee802154_netdev.h |   6 ++
> > >  net/ieee802154/core.c           |   7 ++
> > >  net/ieee802154/pan.c            |  30 +++++++
> > >  net/mac802154/ieee802154_i.h    |   2 +
> > >  net/mac802154/rx.c              |   8 ++
> > >  net/mac802154/scan.c            | 142 ++++++++++++++++++++++++++++++=
++
> > >  7 files changed, 202 insertions(+)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index 9b036ab20079..c844ae63bc04 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
> > >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > >                           struct ieee802154_addr *target);
> > >
> > > +/**
> > > + * cfg802154_get_free_short_addr - Get a free address among the know=
n devices
> > > + * @wpan_dev: the wpan device
> > > + * @return: a random short address expectedly unused on our PAN
> > > + */
> > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> > > +
> > >  #endif /* __NET_CFG802154_H */
> > > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154=
_netdev.h
> > > index 16194356cfe7..4de858f9929e 100644
> > > --- a/include/net/ieee802154_netdev.h
> > > +++ b/include/net/ieee802154_netdev.h
> > > @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
> > >         struct ieee802154_assoc_req_pl assoc_req_pl;
> > >  };
> > >
> > > +struct ieee802154_association_resp_frame {
> > > +       struct ieee802154_hdr mhr;
> > > +       struct ieee802154_mac_cmd_pl mac_pl;
> > > +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> > > +};
> > > +
> > >  struct ieee802154_disassociation_notif_frame {
> > >         struct ieee802154_hdr mhr;
> > >         struct ieee802154_mac_cmd_pl mac_pl;
> > > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > > index a08d75dd56ad..1670a71327a7 100644
> > > --- a/net/ieee802154/core.c
> > > +++ b/net/ieee802154/core.c
> > > @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
> > >
> > >  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev=
)
> > >  {
> > > +       struct ieee802154_pan_device *child, *tmp;
> > > +
> > >         mutex_lock(&wpan_dev->association_lock);
> > >
> > >         kfree(wpan_dev->parent);
> > >         wpan_dev->parent =3D NULL;
> > >
> > > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, nod=
e) {
> > > +               list_del(&child->node);
> > > +               kfree(child);
> > > +       }
> > > +
> > >         mutex_unlock(&wpan_dev->association_lock);
> > >  }
> > >
> > > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > > index 9e1f1973c294..e99c64054dcb 100644
> > > --- a/net/ieee802154/pan.c
> > > +++ b/net/ieee802154/pan.c
> > > @@ -73,3 +73,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_de=
v,
> > >         return NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > > +
> > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > > +{
> > > +       struct ieee802154_pan_device *child;
> > > +       __le16 addr;
> > > +
> > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > +
> > > +       do {
> > > +               get_random_bytes(&addr, 2);
> > > +               if (addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_BRO=
ADCAST) ||
> > > +                   addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNS=
PEC))
> > > +                       continue;
> > > +
> > > +               if (wpan_dev->short_addr =3D=3D addr)
> > > +                       continue;
> > > +
> > > +               if (wpan_dev->parent && wpan_dev->parent->short_addr =
=3D=3D addr)
> > > +                       continue;
> > > +
> > > +               list_for_each_entry(child, &wpan_dev->children, node)
> > > +                       if (child->short_addr =3D=3D addr)
> > > +                               continue;
> > > +
> > > +               break;
> > > +       } while (1);
> > > +
> >
> > I still believe that this random 2 bytes and check if it's already
> > being used is wrong here. We need something to use the next free
> > available number according to the data we are storing here.
>
> This issue I still have in mind is when you have this typology:
>
> device A -------> device B --------> device C <-------- device D
> (leaf)            (coord)            (PAN coord)            (leaf)
>
> B associates with C
> A associates with B
> D associates with C
>
> If B and C run Linux's stack, they will always have the same short
> address. Yes this can be handled (realignment procedure). But any time
> this happens, you'll have a load of predictable realignments when A and
> D get in range with B or C.
>

I see that it can be "more" predictable, but what happens when there
is the same short address case with the random number generator? It
sounds to me like there needs to be a kind of duplicate address
detection going on and then choose another one, if 802.15.4 even
handles this case...

I am also thinking that there is only one number left and the random
generator runs multiple times to find the last one aka "it's random
you can never be sure", when it always returns the same address.

However, that's only my thoughts about it and hopefully can be
improved in future.

- Alex


