Return-Path: <netdev+bounces-261806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNgBAANroWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:59:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297F1B5AAB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7625530593E2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46A39525E;
	Fri, 27 Feb 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="RxE+5H3D"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754621770A;
	Fri, 27 Feb 2026 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186364; cv=none; b=kGT1re4FVTYf4NOUWoG+ivjy+AYMunmsGmuFQlHtFtLamVTRKU/xkx6Tu16M171A0zGQFE4ZE426cfTMfPkbir9BnUm/E+dcRjiK4GDJtJ6IoLXKfBFgm3GlFOigfzYgvHKKSbhrl6Diri7XrKSA8R9maE57Dv87fdPwJrzZfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186364; c=relaxed/simple;
	bh=osg/KBiSHPE8q8+l4cSGrjz/3ljFNSwcPbponOZHnUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8lThX+eIUtqOcbWKJkwlztAV2bf2uZoUDoBQcNsbg3JtsiqASvrsN11gwoCRkfLIk8ixz3SsboZXFpau7mkT/byVwBHYClxMagCkCRVR0qRYDUsy2edr55IcFm7DKVLfw2JXhZl9p0x4+ebJgQTSnyRh0JNJIlWBE0pw1oTFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziswiler.com; spf=pass smtp.mailfrom=ziswiler.com; dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b=RxE+5H3D; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
	s=s1-ionos; t=1772186361; x=1772791161; i=marcel@ziswiler.com;
	bh=osg/KBiSHPE8q8+l4cSGrjz/3ljFNSwcPbponOZHnUQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RxE+5H3D+hjAwJeoIbw4vpt+sxfM/raHIKCHVPEstNVbxwhWS256pgGu0xcP+6LI
	 F3y+5GSLcSxApT6rMsP8hJVK3NGQcOaBPAha+DJGWU/PPm9QdivaQmmTbM2Gwz3W5
	 Z8dHwXq2g89Z6lfAjd39LEZ7nq/P8syluHoEPA7Q5wewjFS37q8/P/pw6uAhI02AX
	 VaBXXzytfeUR+81vfGG+Kl6Kg3oSQVMleCidjPVGmqjlwnPfuFpCnPVGhIIuzFHW7
	 L3P4Gm15PlAeZZ2c0svaId++Ow5TEe+13yw0O07aAiTiSz/urCXVlUqypAfZ8ce3+
	 PHeajIuhEiVee0Oobw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N4965-1vVGqJ3eDp-00rOlj; Fri, 27 Feb
 2026 10:53:07 +0100
Message-ID: <e2130fa8e18cdffb9be9426a8576e67675e87d55.camel@ziswiler.com>
Subject: Re: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
From: Marcel Ziswiler <marcel@ziswiler.com>
To: =?UTF-8?Q?=E6=9D=8E=E5=BF=97?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com, 
	dongxuyang@eswincomputing.com, ganboing@gmail.com,
 pritesh.patel@einfochips.com
Date: Fri, 27 Feb 2026 10:52:55 +0100
In-Reply-To: <6137cd6a.4859.19c97f5eb67.Coremail.lizhi2@eswincomputing.com>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
	 <5f99968ec561631852bfa72aea95a100dcad5324.camel@ziswiler.com>
	 <6137cd6a.4859.19c97f5eb67.Coremail.lizhi2@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:P7rtaATGEKMWJFkzUg8ddjiTxi9RHPpZ3eAD8g5GykxXsfTcBTX
 8RXzCrhmAc5Vm8vo5y1jI0txTBr30Z6MJfl46iwascAdegNwXLF6TXOAfQRWSJB2uYY9XWl
 dt0tvp3HLYBjkGuG+00bNoMDBoNn6gZOOikO9YDx/ihQDYDOvNeLt1z5PGKPi6KVwwkcFPm
 LWc7lQqLeeV8Xby4TQxWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e+tGgFVXqR4=;P4w55yIVSVGUVy00/3b4FKTCY6Y
 RTrug6CV9InDrBudF+MCINUZN1RCy6G5EmLGsmDldrYAKMshs11CcEonq2yjcl3mUCINDU66a
 DZDSMbUNWSM4rnZdpXEciw1JvzkllQyZk9TIixo1flKpyQbdnspyNME0aZsvxH3EiUGDg80S0
 toy/fVyUTg85AyLmOr1+xg5fIJu1itlg7xDQFxtWJpVoJH9DhW56QQqLE6EUH3jU4H7wAwB5N
 /6A2NVIA+dYJl8OfOyDWHtPxy2M+9x3uL9M/VUo2s8nZcnsnxiL8Vu5NTl0dqVqeMRiTaWdMp
 bBJdC6HjhvNh7nBG1jTvAeZiKC1yQKQbicXli9IhAkM3w2OqaKhySd0NvQpuyF3ZvQ3inqvRE
 GT8KaVHgNq1J+OmyMYufgIh1Rsd+nTaRHWM7Z6b0+aOox1WKm5nzt1DK7Z+NprHbmC0teC3Ug
 ONt/MlBs4yeUiIuq+Y0w0786/XTHeGQHMG4ivph9yyO9CbxcfLv2z4Ghvw56Z82uJZqnziHKl
 6yG8dCccLpIThofmp95Ld4vUjRyEgzTgkDuO4KIZan4CfJi6c+Tud/83bo/VSeBdpz96RGVWP
 cpukD4+Dj24wK9rKwed/l7tErBKuOwj79ezXd6Zi7NVzoUm5AvVn1dk6Jt7fpr6zCU30zluid
 UHSNAVtfY4cTbpdDrBWrd3y6Ap2ur6hRwn04a/eshhnM4tEY8ME9Gdoi0me/6j12yjHRw5x0L
 zIoP1I95u+YDQKoPABj/NPfTu7VM61UjIjyuLbemKbyxpjh5Mnx/VVPpWTL0QQGDvDF+OGf+G
 yl4scU/QwuwgbkTOx2udHxp87BGbA1AAMXnz5lBvGyW6ZsLkfNJy0/HbeXnDqPKhSpz7G6Sx8
 dmAoJKwWtdlPpYiHJkI3y96nXuw3fQ9bGqknguLlsscxnbx4kIb9WsMohI/pHzzTMSsY56Mb1
 ERg48Tiy+aZymu0zcRvV8u+Genx3l3nkzfk6h9EVLxtN3GCEzrwCY4foxVEZysqMGKIvm4Ia1
 y7Iyb6x4tRoIPjPAoEZkGwXhATXhxV/qlh4ZoElg+tykHWHgR0+Sp8basLK0BK2GmTD6C82Y+
 ia2+2qyByu+zAxeG2rtz6Q+ve/aFwLx5+iWc8I9RIOrTP94L5xx/2vZUjG4UM72iftA9iXS+R
 JJEclJZcULzwxTLpf8MgbKWLlQeo9Zvv7py7NzpOHH6Iv7+KqSQtC1uPuidsM5EZ0XFU/08xo
 iv28i87vGBcDBw3g513Wj0zyDUJE4sYybq5GA8Bbz9lDbVnxEeP5WaHZIcLjE5gPsSIu6zF71
 z5xIjY6AWXsQNhIZlHcdbbd4H5cDAAauK3U32q5rOuoDirFC5cnAj+TaRWMZf21g0tFocAdM/
 uSAAK3QKtJMRxfM0pR9FB0Lm8OVl9kdvcMR2VJho37yQNC48nGy8RiHvFpxvVeOK6sCfAV2TK
 cAmCg3mGTybbG/jERgD4nAI7qilHDixJ4ZrkS61Mf58O8OinX+aT7f40SlqAU6WL/f5CQYtpg
 rJH4vHfLsDriXTLRt8oS36vtqbPapdFxoFGv8u0fd7OBWpP5wHyCX9RJYAbHJ8pSdemHsTh+O
 SO+U7JbfRZymX6H0RorL/n43b25aADKx8pwbVIJkICtgi+KlTtIfZnJpe8owteU2pi+hGhRDO
 u65eULA5zs5NLIrpzV6ssPSMp7S8jEYEVXbMcbfdeKc1rBCwQVT1TTHHlwxZn7jNr1hSDjFsI
 yDd94N5Pzoed8i8BB3UJ6y+JFF1Lh5BHSFA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ziswiler.com,none];
	R_DKIM_ALLOW(-0.20)[ziswiler.com:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcel@ziswiler.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ziswiler.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9297F1B5AAB
X-Rspamd-Action: no action

Hi Zhi Li

On Thu, 2026-02-26 at 11:20 +0800, =E6=9D=8E=E5=BF=97 wrote:
> Hi Marcel,
>=20
> Thanks for sharing the details.
>=20
> 1. I checked your log and noticed that the kernel cmdline already include=
s
> =C2=A0=C2=A0 "clk_ignore_unused". Therefore, your issue does not appear t=
o be the
> =C2=A0=C2=A0 same as the one previously reported by Bo Gan.

Yes, that actually came from ESWIN's hifive-premier-p550_defconfig which I =
disabled now.

> 2. I also verified that v6.19.2 already contains the two eMMC fix patches=
:
> =C2=A0=C2=A0 https://lore.kernel.org/all/CAPDyKFqcMyM-=3Dx+2FWNLhHY=3Dgu5=
ApHNPQhp0xBKDJGr7BhEx4Q@mail.gmail.com/
> =C2=A0=C2=A0 https://lore.kernel.org/all/CAPDyKFrkEZDuMbGpfxismcx=3DvJkSS=
K_XbtB762+sUFocupT63w@mail.gmail.com/

Yes.

> =C2=A0=C2=A0 A likely cause is that the eMMC DTS node is missing the AXI =
clock definition.
> =C2=A0=C2=A0 Please refer to the DTS updates in the following pull reques=
t for reference:
> =C2=A0=C2=A0 https://github.com/eswincomputing/linux-next/pull/20

Ah, that one helped (;-p).

BTW: For CPU frequency scaling to actually work one may additionally need C=
ONFIG_RISCV_SBI_CPUIDLE=3Dy.

> 3. In addition, please check whether CONFIG_GPIO_DWAPB=3Dy is enabled in =
your
> =C2=A0=C2=A0 kernel configuration. Since GMAC is built-in by default, it =
depends on
> =C2=A0=C2=A0 GPIO being available during early initialization.

Yes, I also changed that from =3Dm to =3Dy (;-p).

> Hope this helps narrow things down. Please let me know what you find.

Yes, it all works now perfectly incl. CPU frequency scaling. See [1].

Next one would be working PCIe and USB. Unfortunately, for PCIe on EBC77 on=
e would likely need some sort of an
adapter cable/PCB. Maybe I can solder something together. Let's see...

Thank you very much!

[1] https://github.com/riscv/meta-riscv/pull/602

> Best regards,
> Zhi Li

Cheers

Marcel

> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Marcel Ziswiler" <marcel@ziswiler.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-02-21 02:37:57 (=E6=98=9F=E6=
=9C=9F=E5=85=AD)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: lizhi2@eswincomputing.com, devicetree@vger=
.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
> > edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.o=
rg, conor+dt@kernel.org,
> > netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, a=
lexandre.torgue@foss.st.com,
> > rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com, l=
inux-arm-kernel@lists.infradead.org,
> > linux-kernel@vger.kernel.org
> > =E6=8A=84=E9=80=81: ningyu@eswincomputing.com, linmin@eswincomputing.co=
m, pinkesh.vaghela@einfochips.com,
> > weishangjuan@eswincomputing.com, dongxuyang@eswincomputing.com
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC770=
0 eth1 RX sampling timing
> >=20
> > Hi Zhi Li
> >=20
> > Sorry, to steal this thread, but I do have a quick question concerning =
Ethernet on the EIC7700. Every time
> > I
> > enable gmac0 in the device tree my EBC7700 stops booting (e.g. SD card =
is no longer detected) while
> > Ethernet
> > does seem to at least get detected. This has been seen using next-20260=
219, stable v6.19.2 [1] as well as
> > 6.18.0-rc6 [2]. Any idea what could be going wrong?
> >=20
> > I admit so far I only do have one single EBC7700 at hand while waiting =
for further hardware to arrive.
> >=20
> > Thanks!
> >=20
> > [1] https://github.com/riscv/meta-riscv/pull/601
> > [2] https://github.com/eswincomputing/linux-next/tree/dev/test-upstream=
-v6.18-rc6
> >=20
> > Cheers
> >=20
> > Marcel
> >=20
> > [snip]

