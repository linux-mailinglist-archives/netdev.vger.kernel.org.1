Return-Path: <netdev+bounces-41529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98537CB330
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA65C1C20B35
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411C34186;
	Mon, 16 Oct 2023 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXqMaMqD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063B31A93
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:08:40 +0000 (UTC)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BF95
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:08:38 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4a40c8dd9b0so1732394e0c.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697483318; x=1698088118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/O9T5sieK4EkHyj+1nYbg1TLkh8rs57T3cSEiqZe3g=;
        b=gXqMaMqD2Bfu58VuW8cFB0NbZyVeCx0suh5OBMH8bwofo22nU9+apc3JFBvMk2gJEx
         3WNxpxmGg2Ty8sna8WgDqUQisdv4fP3e8n6qZVaE0JgIJluJ7fV3BbwUPVEoIV9uFzix
         ydZ4bRWt/N8A8TO8b3GhXOP0E09OuKf57BK4pMQzd5G/v6a2nlCKZSqPDe3dHSebNtMj
         qftdHKoxO91KF0FQ7JJ7zQ0rqJY/nCoBMWxxUHIXDI6ie+KxpCzidlEGwb8yozvm5lY4
         FTRl06mU/lq0dkyztwaIwMdRVQa/PX7ndHNcqFRTRuh38Srg0nEPNWGhyr/c0z+/8ZFy
         B60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483318; x=1698088118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/O9T5sieK4EkHyj+1nYbg1TLkh8rs57T3cSEiqZe3g=;
        b=WIfK5nxi56C0GY403HWsfO3JhkFrMPWoiz+Rmmg3nZFHcok3nwmV+MsrbV14FJeyGJ
         kCX9Zp+fmm/G+ixYQdRUEz1/Lyy+y9XNRDwIA26lmrjDahzV+rQl0khn+4Ey3y0LApzJ
         M7xHHJ/U0gBh3/cy+and6egz36yQ/TKl/nT83R521ml9yhyQEW0EEAfqUpd5ZZGMpL5M
         ACMnRx/SePL59P1tD+zcmtF8l2PdjGtkbpOPd+D9HQtA+wQzNDf2e710V8TM1w1nRWEl
         OEoIIysMU7r34JZLNJZx3Ordsz198xMGnYufAa5fNh+8zaXx/TXF8UFR4SiGiHTw2kds
         faSg==
X-Gm-Message-State: AOJu0Yxi36ofdrssp/MliSpFkxdT1623MgYnALRMjl+Ooxc7vmlY0xBz
	ffW5nwyGR39Bv9zwk6l9IGMoeCLoJcMtJaVtO++R9R35SoUjYgWt57yNpQ==
X-Google-Smtp-Source: AGHT+IGYoBOkASDexY/MnGcwRKL/OeKOE3MiWyzOkH/gyFREBs+mbnwHJlnGBQenZodcgVUP2oyg5UCGSoLI5ILnfk0=
X-Received: by 2002:a1f:13d7:0:b0:4a4:680:bfad with SMTP id
 206-20020a1f13d7000000b004a40680bfadmr324866vkt.7.1697483317681; Mon, 16 Oct
 2023 12:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003153416.2479808-1-kuba@kernel.org> <20231003153416.2479808-2-kuba@kernel.org>
 <ZS10NtQgd_BJZ3RU@google.com> <CAF=yD-Lx7eWLHwNaTwarBPmZEJZ-H=QJVcwpcrgMUXDSkc6V3A@mail.gmail.com>
 <20231016114624.3662b10b@kernel.org>
In-Reply-To: <20231016114624.3662b10b@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 16 Oct 2023 12:08:25 -0700
Message-ID: <CAKH8qBvcqDcdXTtQBjgXNn3j8xNmowUe01WgrGRkCA_am=qQvg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	lorenzo@kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 16 Oct 2023 13:43:07 -0400 Willem de Bruijn wrote:
> > > Jakub, Willem hit an issue with this commit when running cli.py:
> > >
> > > ./cli.py --spec $KDIR/Documentation/netlink/specs/netdev.yaml --dump =
dev-get --json=3D'{"ifindex": 12}'
> > >
> > > Traceback (most recent call last):
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", =
line 60, in <module>
> > >     main()
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", =
line 51, in main
> > >     reply =3D ynl.dump(args.dump, attrs)
> > >             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py"=
, line 729, in dump
> > >     return self._op(method, vals, [], dump=3DTrue)
> > >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py"=
, line 714, in _op
> > >     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
> > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py"=
, line 540, in _decode
> > >     decoded =3D self._decode_enum(decoded, attr_spec)
> > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py"=
, line 486, in _decode_enum
> > >     value =3D enum.entries_by_val[raw].name
> > >             ~~~~~~~~~~~~~~~~~~~^^^^^
> > > KeyError: 127
> >
> > Indeed. The field is now interpreted as a value rather than a bitmap.
> >
> > More subtly, even for requests that do not fail, all my devices now
> > incorrectly report to support xdp feature timestamp, because that is
> > enum 0.
>
> Sorry about that. This should fix it, right?

Yup, that fixes it for me, thanks!

Tested-by: Stanislav Fomichev <sdf@google.com>

> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 13c4b019a881..28ac35008e65 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -474,7 +474,7 @@ genl_family_name_to_id =3D None
>
>      def _decode_enum(self, raw, attr_spec):
>          enum =3D self.consts[attr_spec['enum']]
> -        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
> +        if enum.type =3D=3D 'flags' or attr_spec.get('enum-as-flags', Fa=
lse):
>              i =3D 0
>              value =3D set()
>              while raw:

