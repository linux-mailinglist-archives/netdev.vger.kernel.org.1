Return-Path: <netdev+bounces-59972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460981CF3F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 21:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893D91C23016
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D062E841;
	Fri, 22 Dec 2023 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bitWPi3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F12EAE1
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so21266041fa.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276916; x=1703881716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8KCgAtJEhFigBqmWI4FasDDRgNNkyQ3i0vzuUXXhsw=;
        b=bitWPi3l54iH6gQqvopWQZ8Xlh1IGR+vZo5Zu3mgtyRGzI1Kne0usGB0vPKJHznOrj
         2XEJCiYkaEPkdrnwzgs4lmZ7d3vEcD6hRhmjMu77LIG+Fme8JS12KltorUiO4xoSWn1t
         xgWHZoLjN0Kf7Hhhb9f2N6LUKfrr/1KhJdzG3+DhhEsF7TAiG9Dno/4oZLXaq/c9/Zto
         t4WYyihI76+t0LFgUajB2WJjcO3Imj8hGm/mI7ipHdBMSVmVn0qEbzxbxCiYXXiT0KT1
         BKczGjvQ/I00fHiE0Y3wyEtRG4mWuqIjaKSB1wM3EmmPGjxqpJI+QZlZ5SH1GnRO62Ly
         5lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276916; x=1703881716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8KCgAtJEhFigBqmWI4FasDDRgNNkyQ3i0vzuUXXhsw=;
        b=Mer71zWnNPWJ8+p6/zH5BHKyx3geRjPqWQHx+xVEWmJ0Aejrnxd9//ZV48pcZdB0YM
         eT2OFvNzDlVfCDVQY9hDGf0esdP+5+xDOtlr3YtH+7iI9bpgL8eBimET13XmVt0awjoz
         X3eseYaCG9Eo22GwhKy5Ui+iZrdq6uD6SFRuFRcsUucQfH0MtrrDSSO5u6jpL5Oa0Pst
         /jguvVP+AC10PBbeZ/T4CfOnzHftoTaC+e0H6TYOtEdjDBOjV7r3HaFFZqfAWbdum0qX
         /wSq75ZseYEm8po+TkB6XBtmlGC5RakFP3wsEPjg0V1wLxxUD/3pWervkfIHStb1n+av
         +K0Q==
X-Gm-Message-State: AOJu0YwPJs2bJ0N7FHcWFZWhbmCD/fs2VNk28Trf129b+WiDh7WJg6w/
	WZAq0OYEvXeg6j0B4aFZaxJaBoejGIS6wbSd/Uw=
X-Google-Smtp-Source: AGHT+IEGG8NR93oVzHCzlSojpiagkapZLO7hVBJFJwGIw2IdGJ6YzF5hFybXChumNXzy5mzmQBKj442bacB/mBWmCPg=
X-Received: by 2002:a2e:904d:0:b0:2cc:803a:a8ac with SMTP id
 n13-20020a2e904d000000b002cc803aa8acmr2084588ljg.8.1703276916082; Fri, 22 Dec
 2023 12:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf> <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
 <20231222104831.js4xiwdklazytgeu@skbuf> <hs5nbkipaunm75s3yyoa2it3omumxotyzdudyzrzxeqopmnwal@z5zpbrxwfsqi>
 <2cf4c7c0-603d-4c06-a677-69410b02019b@arinc9.com>
In-Reply-To: <2cf4c7c0-603d-4c06-a677-69410b02019b@arinc9.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 22 Dec 2023 17:28:24 -0300
Message-ID: <CAJq09z4LKwkumhR2CiLzczoFM1Ut-yAr9zHZLypopes8t_nrew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Vladimir Oltean <olteanv@gmail.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >>>> ds->user_mii_bus helps when
> >>>> (1) the switch probes with platform_data (not on OF), or
> >>>> (2) the switch probes on OF but its MDIO bus is not described in OF
> >>>>
> >>>> Case (2) is also eliminated because realtek_smi_setup_mdio() bails o=
ut
> >>>> if it cannot find the "mdio" node described in OF. So the ds->user_m=
ii_bus
> >>>> assignment is only ever executed when the bus has an OF node, aka wh=
en
> >>>> it is not useful.
> >>>
> >>> I don't like the fact that the driver bails out if it doesn't find th=
e
> >>> "mdio" child node. This basically forces the hardware design to use t=
he
> >>> MDIO bus of the switch. Hardware designs which don't use the MDIO bus=
 of
> >>> the switch are perfectly valid.
> >>>
> >>> It looks to me that, to make all types of hardware designs work, we m=
ust
> >>> not use ds->user_mii_bus for switch probes on OF. Case (2) is one of =
the
> >>> cases of the ethernet controller lacking link definitions in OF so we
> >>> should enforce link definitions on ethernet controllers. This way, we=
 make
> >>> sure all types of hardware designs work and are described in OF prope=
rly.
> >>>
> >>> Ar=C4=B1n=C3=A7
> >>
> >> The bindings for the realtek switches can be extended in compatible wa=
ys,
> >> e.g. by making the 'mdio' node optional. If we want that to mean "ther=
e
> >> is no internal PHY that needs to be used", there is no better time tha=
n
> >> now to drop the driver's linkage to ds->user_mii_bus, while its bindin=
gs
> >> still strictly require an 'mdio' node.
> >>
> >> If we don't drop that linkage _before_ making 'mdio' optional, there
> >> is no way to disprove the existence of device trees which lack a link
> >> description on user ports (which is now possible).
> >
> > I strongly agree and I think that the direction you have suggested is
> > crystal clear, Vladimir. Nothing prohibits us from relaxing the binding=
s
> > later on to support whatever hardware Ar=C4=B1n=C3=A7 is describing.
> >
> > But for my own understanding - and maybe this is more a question for
> > Ar=C4=B1n=C3=A7 since he brought it up up - what does this supposed har=
dware look
> > like, where the internal MDIO bus is not used? Here are my two (probabl=
y
> > wrong?) guesses:
> >
> > (1) you use the MDIO bus of the parent Ethernet controller and access
> >      the internal PHYs directly, hence the internal MDIO bus goes unuse=
d;
> >
> > (2) none of the internal PHYs are actually used, so only the so-called
> >      extension ports are available.
> >
> > I don't know if (1) really qualifies. And (2) is also a bit strange,
> > because this family of switches has variants with up to only three
> > extension ports, most often two, which doesn't make for much of a
> > switch.
> >
> > So while I agree in theory with your remark Ar=C4=B1n=C3=A7, I'm just w=
ondering if
> > you had something specific in mind.
>
> I was speaking in the sense of all switches with CPU ports, which is
> controlled by the DSA subsystem on Linux.
>
> I am only stating the fact that if we don't take the literal approach wit=
h
> hardware descriptions on the driver implementation, there will always be
> cases where the drivers will fail to support certain hardware designs.

Hi Arin=C3=A7,

The old code was already requiring a single switch child node
describing the internal MDIO bus akin to binding docs. I believe what
we use to match it, being the name or the compatible string property,
wouldn't improve the diversity of HW we could support. This series
doesn't want to solve all issues and limitations nor prepare the
ground for different HWs. It's mostly a reorganization without nice
new stuff.

After this series, we could easily turn the mdio node optional,
skipping the MDIO bus when not found. Anyway, if such HW appears just
now, I believe we could simply workaround it by declaring an empty
mdio node.

Regards,

Luiz

