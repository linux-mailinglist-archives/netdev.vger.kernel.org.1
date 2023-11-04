Return-Path: <netdev+bounces-46066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE757E10D1
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 20:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F8280F45
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389E23740;
	Sat,  4 Nov 2023 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLr0tFKt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6318B1A
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 19:47:07 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C5BDE
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:47:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32daeed7771so1588877f8f.3
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699127221; x=1699732021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9QMcc2uRnUhyIVSXx3s6JgWOA/2eoOcLbE4vbnTork=;
        b=VLr0tFKt9TCPdzGU6uDBAhOK+BXGY3tofxmYLCZhR5OEgGOyXb/t9Gwi/Ia9NCA5/X
         JtmIcSRDYp5FR/xPSiTkvIJcOF14alPbB07DmXy4bfdfH2ooZWNJkBZl765Bq0crRFTU
         6kCGQRGAXuKxrmZrE6Nfp6DYBcd661yZW5yusQE+rqvSaa2OMm6FB1Hhgt0bsV5RZkrU
         y5XdFS3bw0iy1iYSiGQ/kXMvtbATiDvi+b7lMeMZkFyqSZEH/87IKSvFwsgssNQ/J0Bk
         U+LpmLGNi+33FI/fawn7ZTJZySnGewS83AK0xDJTO7n17FgjcH+YyuVesrsx6S1jq7cR
         EqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699127221; x=1699732021;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9QMcc2uRnUhyIVSXx3s6JgWOA/2eoOcLbE4vbnTork=;
        b=fYFJS5E0hQx2GI8qqGTpLhXTWV37n/xF8blqxLfmb0skinNZj/FE8yoTEr65YFaPM7
         SlH+ids+tASsQReyMybs1j2bnfkGlECy+P7Z2BiKmTImnmGlndNptRcs9HJHyVOWyaEn
         jF+4B3n5U+DBIK/mFlcJmwBhtHPq9/TJGQtQ4L7ddlV3s7oBpourWiEbYmm3Xg1HqS3y
         p1hzLPExUFJXzZ7hSriJU+5yn5zuMho0Bl2wgJa0cOQgq2UioyimbVtEwfayqtQ/MVJB
         fI0z4FXxh/EfoAs9Eo7kSTBy9pl9h+ig0GSBE8GRieagkt7EH5cVZVieUwKzRQL6Od4w
         7+Kw==
X-Gm-Message-State: AOJu0YwwxTLI+sszEu38uQgzPqiEZjMOe3lWPAwH747JV3P602cmM88H
	5K0DQ5rTr2ks/8k7nHL/xVMq5Iiglr+m1A==
X-Google-Smtp-Source: AGHT+IHcjuMk4x6VwgU6+La5VWEtgCsy/nnrZOGRN8xM4fnXCdb3wsBwptYHbAn1GJwFfXpcg4pERQ==
X-Received: by 2002:a5d:47a1:0:b0:32f:a48f:3654 with SMTP id 1-20020a5d47a1000000b0032fa48f3654mr9215164wrb.65.1699127220939;
        Sat, 04 Nov 2023 12:47:00 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:e018:7b08:28f0:78c5? ([2a02:168:6806:0:e018:7b08:28f0:78c5])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b00327bf4f2f14sm5126697wrd.88.2023.11.04.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 12:47:00 -0700 (PDT)
Message-ID: <9e9dad320a53864e6b5bd3ecaedd2dc3bc0ff0f1.camel@gmail.com>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is
 up
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev <netdev@vger.kernel.org>
Date: Sat, 04 Nov 2023 20:46:59 +0100
In-Reply-To: <ZUaCiGVPwcuTtjYW@shell.armlinux.org.uk>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
	 <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
	 <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
	 <970325157b7598b6367c293380cace3624e6cb88.camel@gmail.com>
	 <53f3e4ff-2afd-4acb-8cd4-55bdd1defd0d@lunn.ch>
	 <ZUaCiGVPwcuTtjYW@shell.armlinux.org.uk>
Autocrypt: addr=klaus.kudielka@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-11-04 at 17:42 +0000, Russell King (Oracle) wrote:
> On Sat, Nov 04, 2023 at 05:46:44PM +0100, Andrew Lunn wrote:
> > On Sat, Nov 04, 2023 at 05:32:19PM +0100, Klaus Kudielka wrote:
> > > On Sat, 2023-11-04 at 16:27 +0100, Klaus Kudielka wrote:
> > > >=20
> > > > phylink_start() is the first one that does netif_carrier_off() and =
thus
> > > > sets the NOCARRIER bit, but that only happens when bringing the dev=
ice up.
> > > >=20
> > > > Before that, I would not know who cares about setting the NOCARRIER=
 bit.
> > >=20
> > > A different, driver-specific solution could be like this (tested and =
working):
> > >=20
> > > --- a/drivers/net/ethernet/marvell/mvneta.c
> > > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > > @@ -5690,6 +5690,7 @@ static int mvneta_probe(struct platform_device =
*pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 9676 =3D=3D 9700 - 20 a=
nd rounding to 8 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->max_mtu =3D 9676;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_carrier_off(dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D register_netdev(de=
v);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "failed to register\n");
> > >=20
> > >=20
> > > Would that be the "correct" approach?
> >=20
> > Crossing emails.
> >=20
> > Its a better approach. But it fixes just one driver. If we can do this
> > in phylink_create(), we fix it in a lot of drivers with a single
> > change...
>=20
> ... and I think we should.
>=20

So, the patch below also results in correct behaviour of the netdev trigger
with eth2 down, but I'm not so sure whether it really covers all desired
cases. Any advice?

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1616,6 +1616,7 @@ struct phylink *phylink_create(struct phylink_config =
*config,
        pl->config =3D config;
        if (config->type =3D=3D PHYLINK_NETDEV) {
                pl->netdev =3D to_net_dev(config->dev);
+               netif_carrier_off(pl->netdev);
        } else if (config->type =3D=3D PHYLINK_DEV) {
                pl->dev =3D config->dev;
        } else {


Best regards, Klaus


