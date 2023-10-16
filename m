Return-Path: <netdev+bounces-41525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C667CB326
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DDB20DF6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D7339B3;
	Mon, 16 Oct 2023 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6NhWUZF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171A29425
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:08:19 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDA95
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:08:18 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b625d782b9so1741148241.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483298; x=1698088098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxV3iM2aR9m9YjN0smbrjTmBXgTgGEFg5AuPLNIiAnk=;
        b=a6NhWUZFOOBiu4yyr8cBSekOGoi1ksG9BXVCU0JpXY+j0KMSQHZrW7WKAugHvAuQO5
         XWKUsFagv0Hwqqhzx6tRRp0FbBu1q43BGzSihXt42DB8UDhUDDGROV4tUKvIjn1zea5+
         mq/sii6eezGXQwbe8AGVYcQsSSYd+y9rGmBz8Q1v7MS33rjtbYGbhC6SZSF5WU/CHf43
         Zd7HMPwOnQBJypiqEkDSMPCjWVPrXKiwIIDad1NtLccq68Ifew8X6ZCbdQkm4f7s9LRC
         94uWVXf5XRSKaH8bDL+vhxefIZBMEt68uGDW3a4YDWydeer/x+N1KeP+WFELoJVza/he
         nIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483298; x=1698088098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxV3iM2aR9m9YjN0smbrjTmBXgTgGEFg5AuPLNIiAnk=;
        b=D/qiZUs5ZqZjbv7e+n6AKtj6HgTqCKgnaFkHkEaI672FTafvgrs3V+d5RTjSRfCWvW
         FoKNB03HY++/BSUtbszc/UfAyE0qzLtcfPyxgYExQTWrsZV+ADQ7Mi4ohmCqG9I+qBrU
         DGLmYYANDNbNVibhuiwt1VY+7QSCkYESM6Tled3XnlwRh0F/L3egBZ9IKj7UCL1IG70j
         bJHhVyC/YxRAfeXuWQgoN6otFtRjwQLq3acbKzeCI+8753RVxQd1EXPS0rsdJK+u3E6Q
         +laJHHXc8x7b9raZ0h58hcBb7qOU3q+1elIOnmDNS5R5+xdNaxpiRQmqMme3cPozmmsG
         bOQA==
X-Gm-Message-State: AOJu0Ywb0QVoz8i7zJYv8akXFQYMxPwVN03tKrbW/kuaiYuLuIUwgzDy
	g7HcAMaHOSWtJtE65U+zaFC9zsznAzhBVJWaPUA=
X-Google-Smtp-Source: AGHT+IGBmmrZui+aaCY7+MBWM/XffIhOn4x/rCvzXZSrktfLVUOeb216/QC/XGphnKv0weYlvPq4j+PU2P9OhaOaAZg=
X-Received: by 2002:a05:6102:201b:b0:44e:9614:39bf with SMTP id
 p27-20020a056102201b00b0044e961439bfmr317630vsr.6.1697483297705; Mon, 16 Oct
 2023 12:08:17 -0700 (PDT)
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
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 15:07:41 -0400
Message-ID: <CAF=yD-L1XE=a4OfxXBgfEPxc-3XfPmyz=E5PUc_Vxptp0tKJ1Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 2:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
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
>
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

Mostly. The "set()" output is unintentional?

# ./cli.py --spec netdev.yaml --dump dev-get
[{'ifindex': 1, 'xdp-features': set(), 'xdp-rx-metadata-features': set()},
 {'ifindex': 2,
  'xdp-features': {'redirect', 'basic', 'rx-sg'},
  'xdp-rx-metadata-features': set()},
 {'ifindex': 3, 'xdp-features': set(), 'xdp-rx-metadata-features': set()}]

Contrast with netdev sample:

# ./netdev
Select ifc ($ifindex; or 0 =3D dump; or -2 ntf check): 0
      lo[1]     xdp-features (0): xdp-rx-metadata-features (0):
xdp-zc-max-segs=3D0
    eth0[2]     xdp-features (23): basic redirect rx-sg
xdp-rx-metadata-features (0): xdp-zc-max-segs=3D0
    sit0[3]     xdp-features (0): xdp-rx-metadata-features (0):
xdp-zc-max-segs=3D0

