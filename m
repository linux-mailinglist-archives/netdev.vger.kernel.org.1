Return-Path: <netdev+bounces-29969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A300778565C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C21C20BEB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F696BA24;
	Wed, 23 Aug 2023 11:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA24C75
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:00:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE0E54
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692788408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N04pHyjbcFOP1JGghbkhS7mAgCCfnDAn70ecln2ayws=;
	b=PlM+1AwKedVjuAjw3vFgSvPKjZSvxYyYK7Y5w1Lv5V47dbF0YuCB+DnYQY64O58YEV9MWV
	wQ6PcdcmnyTCc3CBq79too0foBSqN9fGDPHJoGrBQ4SGcqKaZh6UP8rzqifmlxk9JTgpeu
	MxQKppXEzGmzpF/K2JrqHP5CQWOUZq8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-pKX0GViKMSSu93VYRPYzZQ-1; Wed, 23 Aug 2023 07:00:07 -0400
X-MC-Unique: pKX0GViKMSSu93VYRPYzZQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a1be1e2b63so27616266b.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692788406; x=1693393206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N04pHyjbcFOP1JGghbkhS7mAgCCfnDAn70ecln2ayws=;
        b=fuq+pau1KOGcbjCKAJ2pi45SiL6uacnjTlU1EWzZ07lILno+k3i6uVoZk8W9Udpq7u
         AnYYty0IkFvK9KUkHIJeK2cL5wZ5tx3NjudVAECA7qKhxWohj6P8e8g1R4WKznSLafUs
         mGV6xl/v/s/v9Gpu7lVYJblbQbPxU6P18xgCsb78wk6L4Er4KD6HfCBNKg+7lL3YSLqt
         0CiMLXxfX24yUoJ9//CkTgiYp7bK5TydNp7IENKyUZ6yZaHxFXK/EiObhgD41ooCDoUt
         OT4BwaYoqFcerAOGvGd1tNUIFznPqeU9GlriiEsNePQwRsOhafcWnEq08MtzIvPSKB2G
         V1fA==
X-Gm-Message-State: AOJu0Yz2N3rYWu9NKTlfiwv5x35i6VnBCsxJO0i6x0bCrSGgqa8ROQRP
	w2MqBdTDSJe7LtBqXqceuEtcRje0NvPCDwYYi5gO9zslePQ55R5k5UrTBeWiWFV3ZyVhSZGthd/
	kSv9KgmPwuypBhPOC
X-Received: by 2002:a17:906:1090:b0:997:d069:a880 with SMTP id u16-20020a170906109000b00997d069a880mr9704501eju.1.1692788405970;
        Wed, 23 Aug 2023 04:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZljECI3Hn7Rr5/GDh5NBi6h3ugwjSM6qT3dieAkTEYMpBC0nzxwFKD0Me5nBoHSXdIC9RFw==
X-Received: by 2002:a17:906:1090:b0:997:d069:a880 with SMTP id u16-20020a170906109000b00997d069a880mr9704485eju.1.1692788405500;
        Wed, 23 Aug 2023 04:00:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id ss21-20020a170907039500b00992076f4a01sm9661861ejb.190.2023.08.23.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:00:05 -0700 (PDT)
Message-ID: <17afabe7bc302ac5d0cac87410ba9fa0eda144b3.camel@redhat.com>
Subject: Re: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum
 instead of erroring
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org, 
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Date: Wed, 23 Aug 2023 13:00:03 +0200
In-Reply-To: <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
	 <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
	 <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-22 at 21:41 -0600, Alex Henrie wrote:
> On Tue, Aug 22, 2023 at 3:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > On Sun, 2023-08-20 at 19:11 -0600, Alex Henrie wrote:
>=20
> > > @@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_if=
addr *ifp, bool block)
> > >        * idev->desync_factor if it's larger
> > >        */
> > >       cnf_temp_preferred_lft =3D READ_ONCE(idev->cnf.temp_prefered_lf=
t);
> > > -     max_desync_factor =3D min_t(__u32,
> > > +     max_desync_factor =3D min_t(__s64,
> > >                                 idev->cnf.max_desync_factor,
> > >                                 cnf_temp_preferred_lft - regen_advanc=
e);
> >=20
> > It would be better if you describe in the commit message your above
> > fix.
>=20
> I did mention the underflow problem in the commit message. When I
> split the patch into two patches, it will be even more prominent. What
> more would you like the commit message to say?

I think explicitly mentioning that the existing code incorrectly casted
a negative value to an unsigned one should suffice.=20

>=20
> > Also possibly using 'long' as the target type (same as
> > 'max_desync_factor') would be more clear.
>=20
> OK, will change in v2.
>=20
> > > @@ -1402,12 +1402,8 @@ static int ipv6_create_tempaddr(struct inet6_i=
faddr *ifp, bool block)
> > >        * temporary addresses being generated.
> > >        */
> > >       age =3D (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
> > > -     if (cfg.preferred_lft <=3D regen_advance + age) {
> > > -             in6_ifa_put(ifp);
> > > -             in6_dev_put(idev);
> > > -             ret =3D -1;
> > > -             goto out;
> > > -     }
> > > +     if (cfg.preferred_lft <=3D regen_advance + age)
> > > +             cfg.preferred_lft =3D regen_advance + age + 1;
> >=20
> > This change obsoletes the comment pairing the code. At very least you
> > should update that and the sysctl knob description in
> > Documentation/networking/ip-sysctl.rst.
>=20
> The general idea is still valid: The preferred lifetime must be
> greater than regen_advance. I will rephrase the comment to be more
> clear in v2.
>=20
> > But I'm unsure we can raise the preferred lifetime so easily. e.g. what
> > if preferred_lft becomes greater then valid_lft?
>=20
> Excellent point. We really should clamp preferred_lft to valid_lft as
> well. I can make that change in v2.
>=20
> By the way, if valid_lft is less than regen_advance, temporary
> addresses still won't work. However, that is much more understandable
> because valid_lft has to be at least the length of the longest needed
> connection, so in practice it's always going to be much longer than 5
> seconds.
>=20
> > I think a fairly safer alternative option would be documenting the
> > current behavior in ip-sysctl.rst
>=20
> I feel strongly that the current behavior, which can appear to be
> working fine for a few minutes before breaking, is very undesirable.
> I
> could, nonetheless, add some explanation to ip-sysctl.rst about what
> happens if preferred_lft or valid_lft is too small.

I think that we could accept the general idea that setting some
"extreme"/edge values on system settings will lead to unexpected
results/limited functionality.

IDK how much relevant is the 'preferred_lft < 5' use-case.

I fear that changing "under-the-hood" the preferred lifetime value in
use could have unexpected side effects for other scenarios. e.g. we can
hit the 'increase preferred lifetime' condition even when:

cfg.preferred_lft =3D=3D <some largish, more common, value>
age =3D=3D ~cfg.preferred_lft

@David A.: I would love to hear your opinion here.

Thank,

Paolo


