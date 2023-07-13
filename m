Return-Path: <netdev+bounces-17436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A775193F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4A281AB8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC1568D;
	Thu, 13 Jul 2023 07:02:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B366
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:02:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66911BEC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:01:58 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689231716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5UV3imXyDD0W84+FU8YElLYZ6EsUx+p1o+3y73ukcm4=;
	b=kOB+CGM8Sbdtx1GLTVBQuNkhKer6anHTGFeXtvhBHfu5kzLG/erIYwPHyf83KHJgTCC+7Q
	EoXY3XF5EHMEi8jvyof0dy2uBxediGD+ndXC4mmlzPcoIy+8FkZ7cQwKu6du5YrcLioKWP
	zsEujZzLT3KdVpzsMA2MnRR1rZlyUhYPP+aUixCkA4iJiW6V4EW7oc6upV92XzV0ZSxneV
	ElwcXgY3calwht98mDwmdAfEVg1aVksbqd692yAt3A0jIfpDm12r79vboor4whA7nFWtQD
	u9qZY4bTtEk+jn84pm85ofpuuoQVwamuV+VqxnGQdCEBJkj3YXLNUdNaorPq/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689231716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5UV3imXyDD0W84+FU8YElLYZ6EsUx+p1o+3y73ukcm4=;
	b=AGwkjfmJNeLtDaiKaH/+smRHmU+Llvlat9EEGsOtFJdzVLn8sfJYbOAbwoNWZIfcQd2VdD
	ar84srMRIRfHt+Ag==
To: Heiner Kallweit <hkallweit1@gmail.com>, Tobias Klausmann
 <tobias.klausmann@freenet.de>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 netdev@vger.kernel.org
Subject: Re: r8169: transmit transmit queue timed out - v6.4 cycle
In-Reply-To: <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com>
References: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
 <CAFSsGVtiXSK_0M_TQm_38LabiRX7E5vR26x=cKags4ZQBqfXPQ@mail.gmail.com>
 <e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de>
 <f7ca15e8-2cf2-1372-e29a-d7f2a2cc09f1@leemhuis.info>
 <CAFSsGVuDLnW_7iwSUNebx8Lku3CGZhcym3uXfMFnotA=OYJJjQ@mail.gmail.com>
 <A69A7D66-A73A-4C4D-913B-8C2D4CF03CE2@freenet.de>
 <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com>
Date: Thu, 13 Jul 2023 09:01:55 +0200
Message-ID: <87a5w0cn18.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Heiner,

On Mon Jul 10 2023, Heiner Kallweit wrote:
> On 05.07.2023 00:25, Tobias Klausmann wrote:
>> Hi, top posting as well, as im on vacation, too. The system does not
>> allow disabling ASPM, it is a very constrained notebook BIOS, thus
>> the suggestion is nit feasible. All in all the sugesstion seems not
>> favorable for me, as it is unknown how many systems are broken the
>> same way. Having a workaround adviced as default seems oretty wrong
>> to me.
>>=20
>
> To get a better understanding of the affected system:
> Could you please provide a full dmesg log and the lspci -vv output?

I'm having the same problem as described by Tobias on a desktop
machine. v6.3 works; v6.4 results in transmit queue timeouts
occasionally. Reverting 2ab19de62d67 ("r8169: remove ASPM restrictions
now that ASPM is disabled during NAPI poll") "solves" the issue.

From=20dmesg:

|~ % dmesg | grep -i ASPM
|[    0.152746] ACPI FADT declares the system doesn't support PCIe ASPM, so=
 disable it
|[    0.905100] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Clo=
ckPM Segments MSI HPX-Type3]
|[    0.906508] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using =
BIOS configuration
|[    1.156585] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't hav=
e ASPM control
|[    1.300059] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASP=
M control

In addition, with commit 2ab19de62d67 in kernel regular messages like
this show up:

|[ 7487.214593] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:=
03:00.0

I'm happy to test any patches or provide more info if needed.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmSvoWMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpzUD/9Q6ni9gjwQ+JusCWY7kmtW0I0Qp+6C
zow+xfJTRg6r1yQHQaIttoBttp291sJlQlmqcdtPIOSE2OQgUephmMyakCxIylKT
nARVGSXBov+arV71QNE1qZF5ypPJtS4Jsag2jdfApcGLRXk0mke3LZlzWjJSvJ3U
fnB7IxtCtLYswdRoTOBV3sgkZTeJdY/Y663wNGVLG7YzdyNPIiHDCdTaGO31HNpR
YF0mnQ6+lgkZgN8ag9cdn089hS2eV8qP+1EQhESfo8iC9VWMH/yEflC1Q8478M+2
gZasLmWQSDq4Pg+k9MgZ5T1XZ+WtUjvomMD7x588mvFMEs+b8YJiNpqkGh+0NAp4
36NXLuZySLH6cNNt5j109MiFD8AC0okwNVe2TARDod9x7P30XvHqiO8IanCR/gOP
1I5YBWR428DdFDsm6C5ZAwj1ftRvrnVuAc+dPc+1Assb/LYNIWQvXLHIK9HueHDZ
eD+bjCJT+IKjno8VIBeyccFU1U40AxqceOCfs7DVAf0xyy2tukjKPYv1pM+pIewX
rHgo/A5wad+2XYYfG9p5gYRnVrGDW1wIp0Sg3qHSbSuwyWg/XJkdrDoLYHvgnUnp
JCJZsHXQ+wM82eQQqXzoXFGl2vp05ZjKLO0whEqF76W3qMuayE0P5jsjPEreKwmg
uy3KyGuixsZRgg==
=x6s2
-----END PGP SIGNATURE-----
--=-=-=--

