Return-Path: <netdev+bounces-38762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F07BC60B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19BC1C208EB
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB415ACA;
	Sat,  7 Oct 2023 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAMeR4m5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F614ABC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 08:27:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C1BF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696667208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g++Z06hUi+nwKmqMr5D89B4LyEuvDaU7tbd/BBtAbPA=;
	b=HAMeR4m5tAagLBf+DBQJxH47mzoy/338tfwMSWoXe4arE3M+QEhE6tSnHAvhZyjgpAJXVo
	/I2uYRE5hDVShbFStPdDrhcWI7DEJrNWx5PYCsbn2QgG3nf7u9C0Y9y/gKViXVNHfwnv+H
	Hd5purbCh0GkzzEMsajrRWM2/pU3dtQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ChLCTsy5M7adIWnH4U3WNg-1; Sat, 07 Oct 2023 04:26:45 -0400
X-MC-Unique: ChLCTsy5M7adIWnH4U3WNg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32320b3ee93so1901714f8f.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 01:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696667203; x=1697272003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g++Z06hUi+nwKmqMr5D89B4LyEuvDaU7tbd/BBtAbPA=;
        b=RTuAqjHGNXbCPK94dE4jPDnWCMYMdha9r2VlFwAyyrlw1jQW1MrXurTkCAYtTp3i/F
         P9oFXXTQScJDz+0e4Z37itMrDlyVj9wFTLsU9VO+wX9tKUZxhuKlOobkS6apb9hHtwU0
         lw4uBg7H+0vdVTU7NoxeGYMkg+rpk4plvdM36FPzY94Q9Uzp2UwzG+L6NAlqZsqDPuty
         bysQ4qVvgjtIxaT1DPAgZkVcyvCbwdZTsTAssLlBGCnRmld01s7DYWAYPud5rpXR3kzT
         P/+FZEuI4wNG3Om961g+aTf7e79z21Son4c13DrZq6au2Z+rHlv+uinJ7lIEUiqAGlKt
         skoQ==
X-Gm-Message-State: AOJu0YyFK/tCnjvAMYqbrHvLl54kEGVqcOvCknqFk3T4sdJkC/U0AUoY
	aosmQJw4eItUC2+NkJmAPd0RLKlbANRIvo/k94+guE9vYXqAhBIHaeDxhVxiwsMzO2DZqSWSNBp
	M/06s27IuiNsVh06t3ykI03+y
X-Received: by 2002:adf:f74c:0:b0:320:aea6:abb9 with SMTP id z12-20020adff74c000000b00320aea6abb9mr8836686wrp.6.1696667203160;
        Sat, 07 Oct 2023 01:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE53995CoUMxEsnjkzfJ5vVQN8PApdPb4y2zPGI5VVYSOYYDv9ptTo5oq3Rfardm6LgexU6Aw==
X-Received: by 2002:adf:f74c:0:b0:320:aea6:abb9 with SMTP id z12-20020adff74c000000b00320aea6abb9mr8836674wrp.6.1696667202823;
        Sat, 07 Oct 2023 01:26:42 -0700 (PDT)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d6904000000b0032710f5584fsm3586367wru.25.2023.10.07.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:26:42 -0700 (PDT)
Date: Sat, 7 Oct 2023 10:26:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: ynl-gen: handle do ops with no input
 attrs
Message-ID: <ZSEWQM0Wdq2PJcLu@lore-desk>
References: <20231006135032.3328523-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojaLuNKP6E9rr8iP"
Content-Disposition: inline
In-Reply-To: <20231006135032.3328523-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ojaLuNKP6E9rr8iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The code supports dumps with no input attributes currently
> thru a combination of special-casing and luck.
> Clean up the handling of ops with no inputs. Create empty
> Structs, and skip printing of empty types.
> This makes dos with no inputs work.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>=20
> Hi Lorenzo, the StructNone from my initial patch felt a little
> too hacky, so I ditched it :) Could you double check that this
> works the same as the previous version?
> ---
>  tools/net/ynl/ynl-gen-c.py | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Tested-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Regards,
Lorenzo

>=20
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 168fe612b029..f125b5f704ba 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -1041,9 +1041,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr,=
 SpecOperation, SpecEnumSet, S
>          if op_mode =3D=3D 'notify':
>              op_mode =3D 'do'
>          for op_dir in ['request', 'reply']:
> -            if op and op_dir in op[op_mode]:
> -                self.struct[op_dir] =3D Struct(family, self.attr_set,
> -                                             type_list=3Dop[op_mode][op_=
dir]['attributes'])
> +            if op:
> +                type_list =3D []
> +                if op_dir in op[op_mode]:
> +                    type_list =3D op[op_mode][op_dir]['attributes']
> +                self.struct[op_dir] =3D Struct(family, self.attr_set, ty=
pe_list=3Dtype_list)
>          if op_mode =3D=3D 'event':
>              self.struct['reply'] =3D Struct(family, self.attr_set, type_=
list=3Dop['event']['attributes'])
> =20
> @@ -1752,6 +1754,8 @@ _C_KW =3D {
> =20
> =20
>  def print_req_type_helpers(ri):
> +    if len(ri.struct["request"].attr_list) =3D=3D 0:
> +        return
>      print_alloc_wrapper(ri, "request")
>      print_type_helpers(ri, "request")
> =20
> @@ -1773,6 +1777,8 @@ _C_KW =3D {
> =20
> =20
>  def print_req_type(ri):
> +    if len(ri.struct["request"].attr_list) =3D=3D 0:
> +        return
>      print_type(ri, "request")
> =20
> =20
> @@ -2515,9 +2521,8 @@ _C_KW =3D {
>                  if 'dump' in op:
>                      cw.p(f"/* {op.enum_name} - dump */")
>                      ri =3D RenderInfo(cw, parsed, args.mode, op, 'dump')
> -                    if 'request' in op['dump']:
> -                        print_req_type(ri)
> -                        print_req_type_helpers(ri)
> +                    print_req_type(ri)
> +                    print_req_type_helpers(ri)
>                      if not ri.type_consistent:
>                          print_rsp_type(ri)
>                      print_wrapped_type(ri)
> --=20
> 2.41.0
>=20

--ojaLuNKP6E9rr8iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZSEWQAAKCRA6cBh0uS2t
rNfWAP9zp4JYAlBwpoZM2eWXudgolJL+kJSmP6F78IckEWvtLAEAhDoluGQOAsuS
Yna7WhxajbWibjiBgkXbVcg9mf9s/gc=
=L8bG
-----END PGP SIGNATURE-----

--ojaLuNKP6E9rr8iP--


