Return-Path: <netdev+bounces-41532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7F7CB355
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB581C208BE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704ED341AE;
	Mon, 16 Oct 2023 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2yQfLzw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2428DD2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:32:13 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7183
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:32:12 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b636ee2b38so2922132241.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697484732; x=1698089532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA3K/EPwbeV5Alw29dURj5jjnbcdSxur8gNAfN1jS2g=;
        b=F2yQfLzwrHKx+DYRuDMTVfac8oYu15HSsLaTZ3uH3koNkXat3gw7mb8rPZE1hLnbdN
         b+DXzIjYPsj3T0mrxEH0ev72s+QdClgGmboe8dGniww54SbYWO2+y7sxfmvAD0ZrogWT
         yZoY55DgJnlMZ7UjdTwsWwc7dvssfALZCFXBYA0okOllE03MCxPh4OYUDeT9NW+5OUWg
         RfpH8WxS5SNuzn+5+IqQ6C5+U0yeyNYtsq+GKA8+tknk4EgZz4fsIILXbPmDqySRi7ER
         TpTkIMtK+y+mVg3xo0C1QhNwMbrW40QDyPFe6CqD4Yk5r8rGfCrCMYFmVP8t9ydjPhO9
         dgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484732; x=1698089532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA3K/EPwbeV5Alw29dURj5jjnbcdSxur8gNAfN1jS2g=;
        b=PxvSSN1Cem5e8vabWkLkRGIUPmaBG8KoYDlyS3tcs7juuxT05NQ8O3OL59rb/7fDIx
         NZ9bGRlfUFtQVEQ3AM+zChfE9wQmkgyoIeuCjI7JdjLCTUyYz1sWYW3RdNR+KEM0NxOv
         ONALudUAYRCRaNJXtvD7GSOrIZS3f0HpJTvDfbn0MvMEdNtxXtyqwgHpuZdpD+g/bPbw
         EdSEIjuf9nBHsxAHAP+A/GKlayxGTdK6ijJbckIoqGB8Nv+bjTUP8APJPEM5Ve1B7OUh
         i8g+1LSQy4FTgVsx5eSPqeh6m0S0QnYWybPzaH2I5y/EEvjmmh/J3yWZCaGFP68OdiDA
         tdmg==
X-Gm-Message-State: AOJu0YzUlhSGqVyP/FNB4w/mm5muQ2DIrlKaLw+DjDW2S1pYT0B89V82
	CaGgbSyqOW5fTK7bxvK3Vds9QM0jUwDKEJV4ADI7t+eG
X-Google-Smtp-Source: AGHT+IGr8tLDs7p/xA1dhP87z8BEWf0xftYb93lMtso90i6/QlubRrGsxvbW58tlpUbqYzC1xf6kwY2P+2roEZbmjpc=
X-Received: by 2002:a05:6122:181c:b0:495:e688:72b7 with SMTP id
 ay28-20020a056122181c00b00495e68872b7mr312569vkb.4.1697484731688; Mon, 16 Oct
 2023 12:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003153416.2479808-1-kuba@kernel.org> <20231003153416.2479808-2-kuba@kernel.org>
 <ZS10NtQgd_BJZ3RU@google.com> <CAF=yD-Lx7eWLHwNaTwarBPmZEJZ-H=QJVcwpcrgMUXDSkc6V3A@mail.gmail.com>
 <20231016114624.3662b10b@kernel.org> <CAF=yD-L1XE=a4OfxXBgfEPxc-3XfPmyz=E5PUc_Vxptp0tKJ1Q@mail.gmail.com>
In-Reply-To: <CAF=yD-L1XE=a4OfxXBgfEPxc-3XfPmyz=E5PUc_Vxptp0tKJ1Q@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 15:31:35 -0400
Message-ID: <CAF=yD-JL8Q7bvSGrUTBseNuU74gAB9Gq-nHch4a=UBWded2GHg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 3:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Oct 16, 2023 at 2:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 16 Oct 2023 13:43:07 -0400 Willem de Bruijn wrote:
> > > > Jakub, Willem hit an issue with this commit when running cli.py:
> > > >
> > > > ./cli.py --spec $KDIR/Documentation/netlink/specs/netdev.yaml --dum=
p dev-get --json=3D'{"ifindex": 12}'
> > > >
> > > > Traceback (most recent call last):
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py"=
, line 60, in <module>
> > > >     main()
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py"=
, line 51, in main
> > > >     reply =3D ynl.dump(args.dump, attrs)
> > > >             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.p=
y", line 729, in dump
> > > >     return self._op(method, vals, [], dump=3DTrue)
> > > >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.p=
y", line 714, in _op
> > > >     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
> > > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.p=
y", line 540, in _decode
> > > >     decoded =3D self._decode_enum(decoded, attr_spec)
> > > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.p=
y", line 486, in _decode_enum
> > > >     value =3D enum.entries_by_val[raw].name
> > > >             ~~~~~~~~~~~~~~~~~~~^^^^^
> > > > KeyError: 127
> > >
> > > Indeed. The field is now interpreted as a value rather than a bitmap.
> > >
> > > More subtly, even for requests that do not fail, all my devices now
> > > incorrectly report to support xdp feature timestamp, because that is
> > > enum 0.
> >
> > Sorry about that. This should fix it, right?
> >
> > diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> > index 13c4b019a881..28ac35008e65 100644
> > --- a/tools/net/ynl/lib/ynl.py
> > +++ b/tools/net/ynl/lib/ynl.py
> > @@ -474,7 +474,7 @@ genl_family_name_to_id =3D None
> >
> >      def _decode_enum(self, raw, attr_spec):
> >          enum =3D self.consts[attr_spec['enum']]
> > -        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']=
:
> > +        if enum.type =3D=3D 'flags' or attr_spec.get('enum-as-flags', =
False):
> >              i =3D 0
> >              value =3D set()
> >              while raw:
>
> Mostly. The "set()" output is unintentional?

Never mind. That is the same at 0629f22ec130~1

Tested-by: Willem de Bruijn <willemb@google.com>

Thanks for the quick fix!

