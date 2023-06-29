Return-Path: <netdev+bounces-14563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950574269F
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1487C280BE9
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9A23C8;
	Thu, 29 Jun 2023 12:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD623C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:38:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921912952
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688042321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyjed+n6vJ2GKQu5IWKEiyVp5EbB8rMW7EJ9oglJpcs=;
	b=etpxNrBrZBhhGHQfWW/TMYf5x+o3hooFdC0ebqSa8vv4KDymaCaX/bzHn+N1RxkNarGR7Z
	tqXrhtqBdj+PgyZSUt700qx3CSGiLZrYLL8jK2PHexgPw5HGjDa8bPo/cxaH/jVH/jTWPi
	so0OO5/LDwsJEBJU7W3MLbSY/0qvKLg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-bzxT3Li8P0e48Zh2gMHzPQ-1; Thu, 29 Jun 2023 08:38:40 -0400
X-MC-Unique: bzxT3Li8P0e48Zh2gMHzPQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76721ad9ed7so13672685a.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042320; x=1690634320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyjed+n6vJ2GKQu5IWKEiyVp5EbB8rMW7EJ9oglJpcs=;
        b=h6lTgbBbOqoPUmbd/eaNqQlDeRNcqGDygySwOEVTpIYxLske5EA6g37l2iJfZtbUhj
         sbbh2yePTgLETTfbrQAJzmNqK4HKnw4Gow5UmeciQJ8d7RKkIvkwHgFOVx7RXHz5awgG
         UkNtH1agK/w7kE2IRXt0qvAkdgEa76jkbGc8mN39Y5ZkckPGZ7AySvfSzP/Jmh1UHKcd
         7l4XCItHzlOn1ylEonjMRpdLWBsyH0GV1vZ7ZnU98ACZoMeeSJ84nK6yZA4f5jBL/sLJ
         9zx1TMu0NdQ8fCAF3zuF6i3MFNAAjZTHBvy4Co+lUymGkaUJj0ZtGHpQaJBr/budK9rE
         BHZA==
X-Gm-Message-State: AC+VfDwNk1FUUNZYBp0B9BsueQDb60HImKJplr0PS3DyC65SFTZ2Y9V2
	t7mD9ArvVPaIZ4CPdxlj8BL1NbkrRmGq4MmIl6JbT2Szo2uNl83+DBUsiKJetNv8u99dDWTQR2O
	g8KHJcto797UhC+VUtugpn7Ga
X-Received: by 2002:a05:620a:2a13:b0:762:41d6:c3dc with SMTP id o19-20020a05620a2a1300b0076241d6c3dcmr50289600qkp.0.1688042319844;
        Thu, 29 Jun 2023 05:38:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ThMNPYxWx8urdYfE3Ljj3ILrdnC9+Z11L9FWiMBmDEx49tx+y0HEXiZETIiDlQyjMoZwwiw==
X-Received: by 2002:a05:620a:2a13:b0:762:41d6:c3dc with SMTP id o19-20020a05620a2a1300b0076241d6c3dcmr50289573qkp.0.1688042319516;
        Thu, 29 Jun 2023 05:38:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a071400b007671cafbf5csm1940570qkc.85.2023.06.29.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:38:38 -0700 (PDT)
Message-ID: <756bda986e5b9946e2035926dc0370d14138fd20.camel@redhat.com>
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org
Date: Thu, 29 Jun 2023 14:38:35 +0200
In-Reply-To: <20230629101950.7s3kagwvkzlnu7ao@skbuf>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
	 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
	 <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
	 <20230629101950.7s3kagwvkzlnu7ao@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-29 at 13:19 +0300, Vladimir Oltean wrote:
> On Thu, Jun 29, 2023 at 11:36:38AM +0200, Paolo Abeni wrote:
> > > The big drawback with INCL_SRCPT is that it makes it impossible to
> > > distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> > > 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and=
 4
> > > with zeroes. Only if PTP RX timestamping is enabled, the switch will
> > > generate a META follow-up frame containing the RX timestamp and the
> > > original bytes 3 and 4 of the MAC DA. Those will be used to patch up =
the
> > > original packet. Nonetheless, in the absence of PTP RX timestamping, =
we
> > > have to live with this limitation, since it is more important to have
> > > the more precise source port information for link-local traffic.
> >=20
> > What if 2 different DSA are under the same linux bridge, so that the
> > host has to forward in S/W the received frames? (and DA is incomplete)
> >=20
> > It looks like that such frames will never reach the relevant
> > destination?
> >=20
> > Is such setup possible/relevant?
> >=20
> > Thanks,
> >=20
> > Paolo
> >=20
>=20
> They will have an incorrect MAC DA, with all the consequences of that.
>=20
> Given the fact that the incl_srcpt was enabled up until now for the
> vlan_filtering=3D1 bridge case only, this was already possible to see.
> However it was never reported to me as being a problem, unlike what
> is being fixed here.

Ok, the above sounds like a good enough reply to me.

> I see no other escape than to unconditionally enable the send_meta
> options as well, so that the overwritten MAC DA bytes can always be
> reconstructed from the upcoming meta frames, even though the RX
> timestamp (main payload of those meta frames) may or may not be useful.
> Doing that might also have the benefit that it simplifies the code,
> removing the need for tagger_data->rxtstamp_set_state() and
> tagger_data->rxtstamp_get_state(), because with that simplification,
> the tagger will always expect meta frames.
>=20
> Because of the lack of complaints, I was considering that as net-next
> material though.

[I'm mixing replies to your 2 emails here, I hope overall this is still
human parsable ;) ]

Quickly skimming over the patch you shared I *think* it could be -net
material, too. Given the mentioned lack of complains for the potential
issue, I think it could be a follow-up to this series.

I'm applying it right now.

Thanks!

Paolo


