Return-Path: <netdev+bounces-56720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96CF81097A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 06:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103631C20979
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4AC8C8;
	Wed, 13 Dec 2023 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtWYIOu6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B269DD5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:31:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfd7be487so7359685e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702445460; x=1703050260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ob5cwessIc+6R7Ja4pmtqH2FOjFq7wHkXRHGbeTzfk=;
        b=GtWYIOu6kzeGJ6S+nKucukgDiq8Ht2kXlGz7r4OGo7RFhp/12rYCs1l8xfbNqizYv7
         /y24R7tGQhF5dW3/ie/0nSRxoLMh4HaKEnZaOL5EyCaU+je/H9aqpkYa0OQMu5370hDe
         fxonqs68mEJdFmDOM70vW7k6LOBrFGWdHuJAa4ge86vAxJ8l4S0rK/2iWvAxfhRRuyfG
         +iplvz3ugNCCfWIKU6ublbrC0IatNZbA9RvAxa/UKn/GVi4B+Nr9uyk1GumrP8bDQTyA
         YRzPcGJchjD/t3NkiyLInvD7ufOyg8LwDx5gebRklEvOWOykZw3aDtuBxCjTmdH1kDhp
         +Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702445460; x=1703050260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ob5cwessIc+6R7Ja4pmtqH2FOjFq7wHkXRHGbeTzfk=;
        b=RV1D8bXKiJGwwSpNMC/amTaMY6zpyzJC71cH4Y7ewwuM2MEFuG9TQyDncCk/GK1mq1
         oJC7s4SxrOg7I8qzRkTW7fhJqfkMW21n4hnRF7z4GKR9blxSzKTe0vp2qdAZ+gwUS+oP
         1G3FKOkoYz125maEv6M70H2V1+CvwMWquh9rsIrzFW/dzHaDCC2iuOmYOb4XDPQYsuQ2
         gF12pQ88MwR2sb8FyCY+20Alzf8Bf236qFyQ0EFx6thpFFEtDJ5jlrMyPYRJmb2UNSia
         MwsiITEae2HUi2pIOE8Lm5TiQ7V48JxMx7jc4SRPrFIrcKgE2ZqN2we790EvaHqoSYqg
         3mSg==
X-Gm-Message-State: AOJu0YyjfVRCm4Rrob+cDwJZo6uWIAPFet15Hl7m4w+uBE8i1CePfG5q
	A2a9tyWCrV6mVPmZMWzH5KUi4zd9zgi0FyCbv0I=
X-Google-Smtp-Source: AGHT+IEog4gvugjvm+pgZ31h5eCVLDUDDQLmHxh/QmC/GTfi0HA2CqSPr93Gz2JsZnIarysor8fSd2MRrgmUBfJz/SM=
X-Received: by 2002:a05:6512:481:b0:50b:eb2f:42fe with SMTP id
 v1-20020a056512048100b0050beb2f42femr3263224lfq.74.1702445459630; Tue, 12 Dec
 2023 21:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com> <r247bmekxv2de7owpoam6kkscel25ugnneebzwsrv3j7u3lud7@ppuwdzwl4zi5>
 <20231211143513.n6ms3dlp6rrcqya6@skbuf>
In-Reply-To: <20231211143513.n6ms3dlp6rrcqya6@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 13 Dec 2023 02:30:48 -0300
Message-ID: <CAJq09z4_dY03AaFm=e4G7PU5LwBegGXmTCTaMp9C=izh7Ycj-g@mail.gmail.com>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus documentation
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Madhuri Sripada <madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Tobias Waldekranz <tobias@waldekranz.com>, 
	Arun Ramadoss <arun.ramadoss@microchip.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > +When using OF, the ``ds->user_mii_bus`` can be seen as a legacy feat=
ure, rather
> > > +than core functionality. Since 2014, the DSA OF bindings support the
> > > +``phy-handle`` property, which is a universal mechanism to reference=
 a PHY,
> > > +be it internal or external.
> > > +
> > > +New switch drivers are encouraged to require the more universal ``ph=
y-handle``
> > > +property even for user ports with internal PHYs. This allows device =
trees to
> > > +interoperate with simpler variants of the drivers such as those from=
 U-Boot,
> > > +which do not have the (redundant) fallback logic for ``ds->user_mii_=
bus``.
> >
> > Considering this policy, should we not emphasize that ds->user_mii_bus
> > and ds->ops->phy_{read,write}() ought to be left unpopulated by new
> > drivers, with the remark that if a driver wants to set up an MDIO bus,
> > it should store the corresponding struct mii_bus pointer in its own
> > driver private data? Just to make things crystal clear.
> >
> > Regardless I think this is good!
> >
> > Reviewed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> I think something that makes a limited amount of sense is for DSA to
> probe on OF, but not describe the MDIO controller in OF. Then, you'd
> need ds->user_mii_bus. But new drivers should probably not do that
> either; they should look into the MFD model and make the MDIO controller
> be separate from (not a child of) the DSA switch. Then use a phy-handle
> to it. So for new drivers, even this doesn't make too much sense, and
> neither is it best to allocate the mii_bus from driver private code.
>
> What makes no sense whatsoever is commit fe7324b93222 ("net: dsa:
> OF-ware slave_mii_bus"). Because DSA provides ds->user_mii_bus to do
> something reasonable when the MDIO controller isn't described in OF,
> but this change assumes that it _is_ described in OF!
>
> I'm not sure how and where to best put in words "let's not make DSA a
> library for everything, just keep it for the switch". I'll think about
> it some more.

Hello Vladimir,

Sorry for my lack of understanding but I still didn't get it.

You are telling us we should not use user_mii_bus when the user MDIO
is described in the OF. Is it only about the "generic DSA mii" or also
about the custom ones the current drivers have? If it is the latter, I
don't know how to connect the dots between phy_read/write functions
and the port.

We have some drivers that define ds->user_mii_bus (not the "generic
DSA mii") with the MDIO described in OF. Are they wrong?

Alvin asked if we should store the mii_bus internally and not in the
ds->user_mii_bus but I don't think you answered it. Is it about where
we store the bus (for dropping user_mii_bus in the future)?

You now also mention using the MFD model (shouldn't it be cited in the
docs too?) but I couldn't identify a DSA driver example that uses that
model, with mdio outside the switch. Do we have one already? Would the
OF compatible with the MDF model be something like this?

my_mfd {
    compatible "aaa";
    switch {
        compatible =3D "bbb";
        ports {
            port@0: {
              phy-handle =3D <&ethphy0>;
            }
        }
    }
    mdio {
         compatible =3D "ccc";
         ethphy0: ethernet-phy@0 {
         }
    }
}

And for MDIO-connected switches, something like this?

eth0 {
     mdio {
         my_mfd {
            switch{...}
            mdio{...}
         }
     }
}

Is it only a suggestion on how to write a new driver or should we
change the existing ones to fit both models?

Regards,

Luiz

