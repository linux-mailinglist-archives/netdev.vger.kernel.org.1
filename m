Return-Path: <netdev+bounces-59885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A881C888
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E13B22A7C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C48514A86;
	Fri, 22 Dec 2023 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfWlV3rK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DA1426C
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5545139bed4so621746a12.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703242114; x=1703846914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39vkABRiao9OfVY1+YaIx9imcFeTGCe85s1SnlHjjEU=;
        b=lfWlV3rKT6v/ksFxRjQ2lNu67krK9OqKbYfnQ9kMws4w3IGs9cR/M6/isBBEV+CvWS
         CiGe7ngMhkpZN+NEfCtHtOfOOMucahNXHtd6Btp1xyJ10cVIXtI9x8lORXdstD+haky5
         p/kvQeqlnZ7K/pnkaBUmJL5L3KAcy3Jv5T7prrSqK35lcV7AvR44RT1UailrBWXJUZoL
         CyZonO2IZInpWYU4qaxk0xYwgKhxOEAnzY0VAn0Y3y3ygMVzLg/zwoo1Pq3tNA2dbHVS
         STCLmzhEoMOEneR8rJHYMr8YrWF3xuXK9LKPMrrGscXdzimSEkUx5FtsviONUXSQWHlD
         NHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703242114; x=1703846914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39vkABRiao9OfVY1+YaIx9imcFeTGCe85s1SnlHjjEU=;
        b=FkQUi/Bhx5xX2bg8UhOYebL1BG6U9s3z2SHKOEDKXiwyxCZ9Xx/dhkQa/Pvj+1kjPw
         qUe193cRVA2xi3ck0VsNbP9fyOsTLTvkv5Mk5UWYAtKdO3hZyJX3P4M/fpII4u5uEfeU
         P65LOZzqN7j4MtwYB6FdpH9r4ujjH1UzwYriuOozS5BCoFcpzSSJTVNUSlG2MFQqO6MJ
         DWFl9PdlOGK9HmOsr/MNji4ejAYZWD+40+ciEie5BDooZeuU3kWHSV56hJ0RHVNfLQsP
         Tc037rWFFg7i+CCiQrTQXg7NQuQhmfvXzQClrSBad4tzP0qRrHiwJyna2d183CX4XHQ/
         rQ8Q==
X-Gm-Message-State: AOJu0Yyw0svBpwVkgQg6CsP3r3RIwHBrJzZzOmTLcl0lvDObnMyBW4/A
	N+I4q3VHAdQpaftJIntn86Y=
X-Google-Smtp-Source: AGHT+IG2TvwNEQWWnwjdgY1+iEWUVLwa6ONeE3twAxQQ9pl7b7QAHiARoZVhh1F1lXPrcNJqpBsWbA==
X-Received: by 2002:a50:9313:0:b0:54b:25e8:c00b with SMTP id m19-20020a509313000000b0054b25e8c00bmr578938eda.6.1703242113989;
        Fri, 22 Dec 2023 02:48:33 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7d905000000b0055269dac6e3sm2400149edr.95.2023.12.22.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:48:33 -0800 (PST)
Date: Fri, 22 Dec 2023 12:48:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Message-ID: <20231222104831.js4xiwdklazytgeu@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>

On Thu, Dec 21, 2023 at 09:34:52PM +0300, Arınç ÜNAL wrote:
> On 21.12.2023 20:47, Vladimir Oltean wrote:
> > ds->user_mii_bus helps when
> > (1) the switch probes with platform_data (not on OF), or
> > (2) the switch probes on OF but its MDIO bus is not described in OF
> > 
> > Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
> > if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
> > assignment is only ever executed when the bus has an OF node, aka when
> > it is not useful.
> 
> I don't like the fact that the driver bails out if it doesn't find the
> "mdio" child node. This basically forces the hardware design to use the
> MDIO bus of the switch. Hardware designs which don't use the MDIO bus of
> the switch are perfectly valid.
> 
> It looks to me that, to make all types of hardware designs work, we must
> not use ds->user_mii_bus for switch probes on OF. Case (2) is one of the
> cases of the ethernet controller lacking link definitions in OF so we
> should enforce link definitions on ethernet controllers. This way, we make
> sure all types of hardware designs work and are described in OF properly.
> 
> Arınç

The bindings for the realtek switches can be extended in compatible ways,
e.g. by making the 'mdio' node optional. If we want that to mean "there
is no internal PHY that needs to be used", there is no better time than
now to drop the driver's linkage to ds->user_mii_bus, while its bindings
still strictly require an 'mdio' node.

If we don't drop that linkage _before_ making 'mdio' optional, there
is no way to disprove the existence of device trees which lack a link
description on user ports (which is now possible). So the driver will
always have to pay the penalty of mdiobus_register(ds->user_mii_bus),
which will always enumerate the internal PHYs even if they will end up
unused, as you say should be possible. Listing the MDIO bus in OF
deactivates bus scanning, which speeds up probing and booting in most
cases.

There are other ways to reduce that PHY enumeration pain, like manually
setting the bus->phy_mask and moving code around such that it gets
executed only once in the presence of -EPROBE_DEFER. This is what Klaus
Kudielka had to go through with mv88e6xxx, all because the Turris Omnia
device tree lacks phy-handle to the internal PHYs, his boot time shot up
by a wide margin.
https://lore.kernel.org/lkml/449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com/
commit 2c7e46edbd03 ("net: dsa: mv88e6xxx: mask apparently non-existing phys during probing")
commit 2cb0658d4f88 ("net: dsa: mv88e6xxx: move call to mv88e6xxx_mdios_register()")

We support device trees with 'hidden' switch internal MDIO buses and it
would be unwise to break them. But they are a self-inflicted pain and it
would be even more unwise for me to go on record not discouraging their use.
Honestly, I don't want any more of them.

