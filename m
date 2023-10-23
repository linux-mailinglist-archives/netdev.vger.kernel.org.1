Return-Path: <netdev+bounces-43365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944737D2B91
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B6428143C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0F101F5;
	Mon, 23 Oct 2023 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djfTkLLI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035363D6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:42:35 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF77D60;
	Mon, 23 Oct 2023 00:42:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso1382885a12.3;
        Mon, 23 Oct 2023 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698046953; x=1698651753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pa8Ycg4ZbuyhxwxZIcfT7kG/2CbPeVVKLuGjTYraxqk=;
        b=djfTkLLITNoscD9fr34i0a5IlX+alp64AsFOPiFdwoDwrXsGxTLQLFnGbqAGMhgEJ9
         uS8q8fL9e5IxXepG/y+Kz5InmK5ZOMi0AfuGOefWnWyEy5f+xZGxtmnqGxCxa3Mu0phB
         GyCOCArB82QjaCgqqabUvcl223Cx6l5L2OCqaAxWASKKpiKid+Ksumq3YfrQmSqvA9ge
         HwgVKaYC5/RkYdOdE8cVUsQl0z3dxBGFPyYCyPUg+BI5cp3tkmvDKNvxaROkUtbC387I
         9ZttynkniFycx+ljavV86D+SSRrQAC2gAPvyYujXo14VCLEr3P+gz/dpGzy/cwuoj+9B
         XBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698046953; x=1698651753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa8Ycg4ZbuyhxwxZIcfT7kG/2CbPeVVKLuGjTYraxqk=;
        b=E86gCOf56ssaR3/m9TKuFS4T3rIxc4hs4dOEVQUyOneX7TMd22MwLvqFWovBEblcQE
         v/wJN+SfznXBgxCrtLitYa71Xm4T2dXfPSuyV44T/ArjeX2zql/3i8CiT4uG5K1JSQYu
         6ZHlnRO7KazI10BZtfF/tqOC6O2EGl8h1PGXNzq0+96v2gnXEcLB3tWtqa/WbKTfj1xd
         vQDoKVb8sfMpgcupizy6uwH8b8J/zkbuvsdP6SNNRA+3QEWFwBd/kqnwfloCDCRYN8DI
         +Jg88CThLBbin6kwMoa1fpRDc6PlK2gTgUdNO9Lip8XxblNkfehqEbvmcZbLei1swrPm
         fykw==
X-Gm-Message-State: AOJu0YztCh9AJXOsf9h52wuxdv9zGMAxKBMBc90eorpEIwvgr+VDOpzM
	YHUpQM4HX4TluSBlRgD4pYKDPqSDBpY=
X-Google-Smtp-Source: AGHT+IEs7/8FcfO1BLY4N1AIr3dYPHCRPbKB0+2YYwmIFSVIC2Crej+Is3LJdco4cmwE80d3fxdVOA==
X-Received: by 2002:a05:6a20:1592:b0:12f:c0c1:d70 with SMTP id h18-20020a056a20159200b0012fc0c10d70mr7030892pzj.40.1698046953213;
        Mon, 23 Oct 2023 00:42:33 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a990200b0027758c7f585sm5021888pjp.52.2023.10.23.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:42:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id DD669818DF16; Mon, 23 Oct 2023 14:42:29 +0700 (WIB)
Date: Mon, 23 Oct 2023 14:42:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Jia, Fang" <fang.jia@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regression <regressions@lists.linux.dev>
Subject: Re: phy: fixed link 1000 or 100 set with autoneg off
Message-ID: <ZTYj5Wyg8qD7_Npd@debian.me>
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KNi0/Pi1fnSluti+"
Content-Disposition: inline
In-Reply-To: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>


--KNi0/Pi1fnSluti+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:01:10PM +0800, Jia, Fang wrote:
> Hi Experts,
>=20
> We use NXP LS1046 board and face an issue about the eth interface speed.
>=20
> 1) Scenario
>=20
> we set fixed link 1000Mb/s in device tree.
>=20
> However, after we set the auto-neg off, then the eth1's speed changed to =
10M
> and Duplex changed to Half.
> The value of /sys/class/net/eth1/speed is 10 and /sys/class/net/eth1/dupl=
ex
> is half
>=20
> 2) Log is as following.
>=20
> # ifconfig eth1 up
> # ethtool eth1
> Settings for eth1:
>         Supported ports: [ MII ]
>=20
>         Supported link modes:   1000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>=20
>=20
>         Supported FEC modes: Not reported
>=20
>=20
>         Advertised link modes:  1000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>=20
>=20
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: 1000Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: d
>         Wake-on: d
>         Current message level: 0xffffffff (-1)
>                                drv probe link timer ifdown ifup rx_err
> tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>         Link detected: yes
>=20
> # ethtool -s eth1 autoneg off
> # ethtool eth1
> Settings for eth1:
>         Supported ports: [ MII ]
>         Supported link modes:   1000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  1000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 10Mb/s
>         Duplex: Half
>         Port: MII
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: off
>         Supports Wake-on: d
>         Wake-on: d
>         Current message level: 0xffffffff (-1)
>                                drv probe link timer ifdown ifup rx_err
> tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>         Link detected: yes
>=20
> 3) After code tracing, we found that:
>=20
> phy_state_machine()
> 	state PHY_RUNNING: phy_check_link_status()
> 		phy_read_status()
> 			genphy_read_status()
> 				genphy_read_status_fixed()
>=20
> In genphy_read_status_fixed(), the speed and duplex changed.
> It seems like the bmcr value is always 0x1000 from swphy_read_reg().
>=20
> After revert the commit 726097d6d6d(net: phy: improve auto-neg emulation =
in
> swphy), then the Speed and Duplex shown comes back to 1000M and Full.
>=20

Thanks for the regression report. I'm adding it to regzbot

#regzbot ^introduced: 726097d6d6d8e9

--=20
An old man doll... just what I always wanted! - Clara

--KNi0/Pi1fnSluti+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTYj3QAKCRD2uYlJVVFO
oxlGAP9AXy3/h8cT+yMgk2wxRTXoknz4RCWC3o5I9Rg6TOIXwAEA+nlhPhUX/wl4
6atnTHxo3agKlgNdUhi76kpTfg5qDAI=
=cCKp
-----END PGP SIGNATURE-----

--KNi0/Pi1fnSluti+--

