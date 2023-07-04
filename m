Return-Path: <netdev+bounces-15350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18490746FFA
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A4E1C2098F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3EA5680;
	Tue,  4 Jul 2023 11:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A54566B
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 11:34:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC9E7D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688470468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXnq89Vx5Bj4GKEzPiuso1zUj9ISNTq+r+8jY2dLtAU=;
	b=JI5s/Vmvbgz9DA5A63/iRGb/jcdW+3LuluC/zC8mu1PTO1BCLwi25GJ65AZWdPb5IWusXk
	mUNdyjde53qnitW0gNcolQY7v59gP3/srMvIkUbwqgF2S1Rw0hiU4rQ2qPOYUp5GQs28mP
	L0HR3EpI58ntB1oXhYEbKR9flM5MQyo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-SpPxeOXkM7SxPPA2AFJCZQ-1; Tue, 04 Jul 2023 07:34:27 -0400
X-MC-Unique: SpPxeOXkM7SxPPA2AFJCZQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-565d1b86a64so47185867b3.3
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688470467; x=1691062467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXnq89Vx5Bj4GKEzPiuso1zUj9ISNTq+r+8jY2dLtAU=;
        b=KXcapnu5JKC9EDZvtqPpa5dc7tdwcgM8rnUhQ4PfLDxt49+gAwF5GvDvsazF8sT/dN
         IJWfv3a3NOWLSpglAKRC0zMPWZQnTd3KbUOraX+Bu6pEgvY0nMYIJ+khcEervFuhZTNq
         FkRs3v/6d/mnmPnFBOyTTWUUB6YL8oOn5tkGRMmjE0N8MN1oCaVoj5YIlGZpNvLpCa1I
         uXL73l89lx1S4TIJV8E61ABLbfZy+QjB/FasO/FzJ9Bp+Z3tteAP4/eRHFhwHrxgNUgA
         V1lYcmCuGFptveMyoHGbUKvRx9hfZIHfQ9QI3R+YSvZ4K9vCVdosGDlXQNy6PIfX+ipF
         ikYw==
X-Gm-Message-State: ABy/qLawNKeksrC3pvXv/7/LEYbw2Gz/+x4F72+lI0Ue3VolYin3eAZg
	EqQBT3HORgMszAUWEtoB+VF6SKByDizZOZn0cyqD2bp/Nu5EDPgAUxbluNbTwMXyeHhsZmLwN5V
	pPrvm0y1MFySlprGAGBLCIq9JFQmbbRUU
X-Received: by 2002:a0d:df86:0:b0:579:ec06:eb3d with SMTP id i128-20020a0ddf86000000b00579ec06eb3dmr8401484ywe.21.1688470467336;
        Tue, 04 Jul 2023 04:34:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5MOd7qOxgSjWgDl9pSrHRuFKa43Hot6W59FTuInBNuqzINdcyIeDq+YGAQ4+QkEQ5ltD6O4RxW8//WwZqgZU=
X-Received: by 2002:a0d:df86:0:b0:579:ec06:eb3d with SMTP id
 i128-20020a0ddf86000000b00579ec06eb3dmr8401459ywe.21.1688470467004; Tue, 04
 Jul 2023 04:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
 <20230601154817.754519-5-miquel.raynal@bootlin.com> <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
In-Reply-To: <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 4 Jul 2023 07:34:15 -0400
Message-ID: <CAK-6q+g_0LZ_OPZtCjAsL8Vn6TiTKM5RUzQTxK7GDzuEEVNSEg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 04/11] mac802154: Handle associating
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Sat, Jun 3, 2023 at 6:09=E2=80=AFAM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Hi,
>
> On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Joining a PAN officially goes by associating with a coordinator. This
> > coordinator may have been discovered thanks to the beacons it sent in
> > the past. Add support to the MAC layer for these associations, which
> > require:
> > - Sending an association request
> > - Receiving an association response
> >
> > The association response contains the association status, eventually a
> > reason if the association was unsuccessful, and finally a short address
> > that we should use for intra-PAN communication from now on, if we
> > required one (which is the default, and not yet configurable).
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/ieee802154.h      |   1 +
> >  include/net/cfg802154.h         |   1 +
> >  include/net/ieee802154_netdev.h |   5 ++
> >  net/ieee802154/core.c           |  14 ++++
> >  net/mac802154/cfg.c             |  72 ++++++++++++++++++
> >  net/mac802154/ieee802154_i.h    |  19 +++++
> >  net/mac802154/main.c            |   2 +
> >  net/mac802154/rx.c              |   9 +++
> >  net/mac802154/scan.c            | 127 ++++++++++++++++++++++++++++++++
> >  9 files changed, 250 insertions(+)
> >
> > diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> > index 140f61ec0f5f..c72bd76cac1b 100644
> > --- a/include/linux/ieee802154.h
> > +++ b/include/linux/ieee802154.h
> > @@ -37,6 +37,7 @@
> >                                          IEEE802154_FCS_LEN)
> >
> >  #define IEEE802154_PAN_ID_BROADCAST    0xffff
> > +#define IEEE802154_ADDR_LONG_BROADCAST 0xffffffffffffffffULL
> >  #define IEEE802154_ADDR_SHORT_BROADCAST        0xffff
> >  #define IEEE802154_ADDR_SHORT_UNSPEC   0xfffe
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index 3b9d65455b9a..dd0964d351cd 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -502,6 +502,7 @@ struct wpan_dev {
> >         struct mutex association_lock;
> >         struct ieee802154_pan_device *parent;
> >         struct list_head children;
> > +       unsigned int association_generation;
> >  };
> >
> >  #define to_phy(_dev)   container_of(_dev, struct wpan_phy, dev)
> > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_n=
etdev.h
> > index ca8c827d0d7f..e26ffd079556 100644
> > --- a/include/net/ieee802154_netdev.h
> > +++ b/include/net/ieee802154_netdev.h
> > @@ -149,6 +149,11 @@ struct ieee802154_assoc_req_pl {
> >  #endif
> >  } __packed;
> >
> > +struct ieee802154_assoc_resp_pl {
> > +       __le16 short_addr;
> > +       u8 status;
> > +} __packed;
> > +
> >  enum ieee802154_frame_version {
> >         IEEE802154_2003_STD,
> >         IEEE802154_2006_STD,
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index cd69bdbfd59f..8bf01bb7e858 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -198,6 +198,18 @@ void wpan_phy_free(struct wpan_phy *phy)
> >  }
> >  EXPORT_SYMBOL(wpan_phy_free);
> >
> > +static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> > +{
> > +       mutex_lock(&wpan_dev->association_lock);
> > +
> > +       if (wpan_dev->parent)
> > +               kfree(wpan_dev->parent);
> > +
> > +       wpan_dev->association_generation++;
> > +
> > +       mutex_unlock(&wpan_dev->association_lock);
> > +}
> > +
> >  int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
> >                            struct net *net)
> >  {
> > @@ -293,6 +305,8 @@ static int cfg802154_netdev_notifier_call(struct no=
tifier_block *nb,
> >                 rdev->opencount++;
> >                 break;
> >         case NETDEV_UNREGISTER:
> > +               cfg802154_free_peer_structures(wpan_dev);
> > +
>
> I think the comment below is not relevant here, but I have also no
> idea if this is still the case.
>
> >                 /* It is possible to get NETDEV_UNREGISTER
> >                  * multiple times. To detect that, check
> >                  * that the interface is still on the list
> > diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> > index 5c3cb019f751..89112d2bcee7 100644
> > --- a/net/mac802154/cfg.c
> > +++ b/net/mac802154/cfg.c
> > @@ -315,6 +315,77 @@ static int mac802154_stop_beacons(struct wpan_phy =
*wpan_phy,
> >         return mac802154_stop_beacons_locked(local, sdata);
> >  }
> >
> > +static int mac802154_associate(struct wpan_phy *wpan_phy,
> > +                              struct wpan_dev *wpan_dev,
> > +                              struct ieee802154_addr *coord)
> > +{
> > +       struct ieee802154_local *local =3D wpan_phy_priv(wpan_phy);
> > +       u64 ceaddr =3D swab64((__force u64)coord->extended_addr);
> > +       struct ieee802154_sub_if_data *sdata;
> > +       struct ieee802154_pan_device *parent;
> > +       __le16 short_addr;
> > +       int ret;
> > +
> > +       ASSERT_RTNL();
> > +
> > +       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
> > +
> > +       if (wpan_dev->parent) {
> > +               dev_err(&sdata->dev->dev,
> > +                       "Device %8phC is already associated\n", &ceaddr=
);
> > +               return -EPERM;
> > +       }
> > +
> > +       parent =3D kzalloc(sizeof(*parent), GFP_KERNEL);
> > +       if (!parent)
> > +               return -ENOMEM;
> > +
> > +       parent->pan_id =3D coord->pan_id;
> > +       parent->mode =3D coord->mode;
> > +       if (parent->mode =3D=3D IEEE802154_SHORT_ADDRESSING) {
> > +               parent->short_addr =3D coord->short_addr;
> > +               parent->extended_addr =3D cpu_to_le64(IEEE802154_ADDR_L=
ONG_BROADCAST);
>
> There is no IEEE802154_ADDR_LONG_BROADCAST (extended address) address.
> The broadcast address is always a short address 0xffff. (Talkin about
> destination addresses).
>
> Just to clarify we can have here two different types/length of mac
> addresses being used, whereas the extended address is always present.
> We have the monitor interface set to an invalid extended address
> 0x0...0 (talking about source address) which is a reserved EUI64 (what
> long/extended address is) address, 0xffff...ffff is also being
> reserved. Monitors get their address from the socket interface.
>
> If there is a parent, an extended address is always present and known.

I want to weaken this, we can also have only the short address of the
neighbor. But it depends on assoc/deassoc, I would think the extended
address should be known. If you look on air and make per neighbor
stats... you can see a neighbor with either a short or extended
address being used. Map them to one neighbor if using a short address
is only possible if you know the mapping... (but this is so far I see
not the case here).

We need some kind of policy here, but with assoc/deassoc we should
always know this mapping.

- Alex


