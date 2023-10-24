Return-Path: <netdev+bounces-43954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF407D5927
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913AB281B0A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D930FAB;
	Tue, 24 Oct 2023 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rmFYz1iO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEE219ED
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:50:11 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894F12B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:50:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-694ed847889so3956614b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1698166206; x=1698771006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oKCz+gES9ENr36vU8F+2Ihm5m3MOjMu8e8TQOShMnQ=;
        b=rmFYz1iOGAB4dv5Wdjp/Ij5HGNJcnv0fKIlttOPxn8MDROG80QX2WCuEa0RDuGo+NR
         OTEofCa9iklGSQsgo6/qY4Il/rCOD118b//UV/J6iF9EPZ3wO0zVJHYqbHHUFvf+dSkj
         Gfst5MkKjklIufobJVZhwSFrCznMfg/fG/CPOW1Ta0gEzbo7GLkb+uwceyGc2s04Pk68
         jF7CLk0mQZBVAjP54H1dEyczYaG0GJOOnQ0uyoiGqEuIJwDRHXHRhPqLazIlc3jEAY27
         aSaBAkn+NPJrKjnmwXPvdynRDcXNY4KY0IhXBkBhVqpblcGr8BPh1ZnZB5Yz+I1BM1eh
         WgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166206; x=1698771006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oKCz+gES9ENr36vU8F+2Ihm5m3MOjMu8e8TQOShMnQ=;
        b=lMoNUqI45tg77ZA8e9p8iErS68lVJkwOQA3UHy9pSuExqBNilmCt7uzIvexhAzfKuq
         3ezISLKqUWiJfsZSvjaeQEwIIiWPiJttB2LMb39Rdgac5D9MFtIIus9PtVzUrpO3P0Oj
         kf0e2BFes13b3KJbaf2Egru7s59ko3IGViKAxQBKZtvk8+Y1E2sEwZEzA5jbw1Fx1E0L
         FyoNb3U+CtdviLTZyByrbBZYYOLtgeqhbzjuQJjmWTNj52bP86XBNhMF+AoZlrMD8Vil
         qoTZhFzzGwMxRcEVJp+YD3JWfs9RN4myGhDjzhmveZgd/c7b07cFKBpCIVd4FuWDZsRV
         c3lA==
X-Gm-Message-State: AOJu0YwZf9xVbFB6TS32gpEsDExDuOFoCQo9GxXu9zYzbJbKrvmvlaJx
	JGcpjJ/rjh2ZrWYOtpg3rnAVUzxVu6sSMsPgdH4cgQ==
X-Google-Smtp-Source: AGHT+IGTEcjpi9RLGNBmpXQi1mcg5Alhj/JTK3OmS7gVU+H7MUVTLkga3R8mMsWOHtUoQkl/lusRI2tW9kh0vFamIrI=
X-Received: by 2002:a05:6a00:248b:b0:68f:cc0e:355d with SMTP id
 c11-20020a056a00248b00b0068fcc0e355dmr11561988pfv.25.1698166206034; Tue, 24
 Oct 2023 09:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-5-romain.gantois@bootlin.com> <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
 <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com> <4bde9110-c88d-4a22-8e67-e788db4673f3@lunn.ch>
In-Reply-To: <4bde9110-c88d-4a22-8e67-e788db4673f3@lunn.ch>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 24 Oct 2023 18:49:55 +0200
Message-ID: <CA+HBbNEMvijVFMKYTUopScwcMRwPFpdZ99GwY-Gb=hTLfgJx5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration
 procedure to the IPQESS driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Luka Perkov <luka.perkov@sartura.hr>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Yes, I'll add more detailed comments to the code in the v2. The calibra=
tion
> > procedure itself targets the PSGMII device, which is internal to the So=
C and can
> > be logically accessed as a PHY device on the MDIO bus. This component i=
s a
> > little opaque and has some nonstandard MII register definitions.
> >
> > The "testing" phase that follows the calibration accesses both the inte=
rnal
> > QCA8K switch ports and the external QCA8075 PHY. For example, it puts b=
oth the
> > switch ports and the PHY ports in loopback before starting packet gener=
ation on
> > the external PHYs. This is done to verify that the PSGMII link works co=
rrectly
> > after being calibrated.
> >
> > So this code interacts with both internal ESS devices and external PHYs=
, but
> > mostly the former, which is why I kept everything in the MAC/switch dri=
ver.
>
> Accessing the external PHYs i would suggest go over the normal phylib
> API. Somebody might build a board using a different PHY, with
> different registers. If all you need is loopback, there is a phylib
> call for that.
>
> Directly accessing the internal ESS is fine, it cannot be changed, but
> if there are phylib helpers which do the same thing, consider using
> them.

Hi,
This SoC is a bit special as it only supports using RGMII and PSGMII.
PSGMII is Qualcomm-s modification of SGMII with 5 SGMII lines to provide
1G of bandwidth from the switch to PHY-s.

However, PSGMII is also weird in the sense that it requires
calibration to be carried
on each boot, as otherwise packet loss will start to occur.
But for calibration to work, you must enable loopback on the switch ports a=
nd
on the PHY-s, both loopback and CRC verification must be enabled.
Then you can actually enable the PSGMII serdes calibration in the SoC but i=
t
must occur on all of the PHYs at the same time, hence why broadcast is used=
.

As far as the PHY-s go, there are only 2 PHY models supporting PSGMII,
QCA8072 and QCA8075, both from Qualcomm, and differing only in the
number of ports.
QCA8072 has 2 ports while QCA8075 has 5 ports.
Each of them also has a serdes PHY exposed over MDIO.
These PHY-s are still being used in IPQ8074 and IPQ6018 802.11ax SoC-s.

So in a nutshell, this is how stuff is connected (To the best of my knowled=
ge):
https://asciiflow.com/#/share/eJzVVktuwjAQvYrlFUggwk9p2fGHBVVoVAmkbAJxRSTjo=
GDUIMQtKg5T9TScpG4T8iEOARLaYs3iZTx%2B9oxnMt5Aos4RrJEVxjmI1TUyYQ1uFGgpsPZYKe=
UUuGaoJIoMUWRR9qFA4I79%2B%2BeloigksB606QyZBFFXE7JoGoSaBsbIjLIIDp5Fpi8N27Kcj=
baI5UjkKY%2FT0fUJZQFQMW%2Bu2J3olDfRYTcGWqsFRta5%2B8TqAufffVzh8q0l8tI8fBodLw=
oRSoZJgeDDRYZ%2BQAkcUNmbrXiwai8aGJr%2BqiMt9aOCxkrHNK%2BTcG43pZfsYUGxG4scZg8=
PVyqeGvN5%2BmceNusP5bL4lLSWflmA%2FKbT6SxUMbzoxEfkH9NcEJXdjfURUzH%2FaQAkuTvo=
94HUGxfk9nOrLXPDE0tTtWye6UwlBOElP8qxNJk6XhqAcWgYLcHzN2X2CpozRoKr%2FCPhJHCk1=
rlWd%2FJ8chtflnj3ILZT3LTZX%2FN7PoqWW0j%2BNrh3Ol7RRSe6IBuHRhgklpGpsWLwt519fK=
vyQ9BbT0xdC524N3bdahqLBXsgMnga%2BQw5WefrhOkEmzkxtTc0TLcjCmKpUE1vC0EQGuoS5Ue=
Foxc1i0%2F6u3RGgTtITNzRJ%2FbD3tHwi%2FfORYFbuP0C5MQClA%3D%3D)

Sorry for the external link, but I cannot get the ASCII diagram to
show properly via plain-text.

Regards,
Robert
>      Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

