Return-Path: <netdev+bounces-17837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DD7532DB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8791C21558
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74946FDA;
	Fri, 14 Jul 2023 07:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AC6FD4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:16:06 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836F26B1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:16:04 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689318961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUAHTRd8c3CSu7cXSAALH6Qn7qntx8W9EcrdN/wA98k=;
	b=Z/RajePAIPnSQVa3vCjcBglOC723Hu3WgzrC1OzDPXNdulC8MuK0kQixHhtjivaCu9/J9U
	tV7LrcH8Zl2zoP8nNiALtE/FS1c7XvKod3Q1del8xHoEpIBn8lDXgXRfxn3AePE8YSSR5Z
	9B0E/7x+vfgbBTbHxuJhCYsHzn9XhvfLqNZD4AT5rzjZcISqrQDd4pAlbGX+vUFNoHsIqC
	U96YB97nrPemcSmgwOr71O1WVMdnkWA8uq6vknEIADGmpd0d81SOQH0MXfWdfeUEr0UEMI
	NMUYaSm3LmrayDI0zsPR1OQL+wiujna/khn7mbObMVGogS3tiu3ic1X0Fj+XgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689318961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUAHTRd8c3CSu7cXSAALH6Qn7qntx8W9EcrdN/wA98k=;
	b=94hq5OtFYpb2h/PEpEyrRp7gNwWtlKKobqJUtT15kKg+Wbc1fupFhLs4TpezGIeiuKJhE/
	xJDfSyajddaAfhDw==
To: Heiner Kallweit <hkallweit1@gmail.com>, Tobias Klausmann
 <tobias.klausmann@freenet.de>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 netdev@vger.kernel.org
Subject: Re: r8169: transmit transmit queue timed out - v6.4 cycle
In-Reply-To: <04dc4bbb-6bfd-4074-6d32-007dc8d213e5@gmail.com>
References: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
 <CAFSsGVtiXSK_0M_TQm_38LabiRX7E5vR26x=cKags4ZQBqfXPQ@mail.gmail.com>
 <e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de>
 <f7ca15e8-2cf2-1372-e29a-d7f2a2cc09f1@leemhuis.info>
 <CAFSsGVuDLnW_7iwSUNebx8Lku3CGZhcym3uXfMFnotA=OYJJjQ@mail.gmail.com>
 <A69A7D66-A73A-4C4D-913B-8C2D4CF03CE2@freenet.de>
 <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com> <87a5w0cn18.fsf@kurt>
 <04dc4bbb-6bfd-4074-6d32-007dc8d213e5@gmail.com>
Date: Fri, 14 Jul 2023 09:16:00 +0200
Message-ID: <87wmz3ezf3.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Jul 13 2023, Heiner Kallweit wrote:
> On 13.07.2023 09:01, Kurt Kanzenbach wrote:
>> Hello Heiner,
>>=20
>> On Mon Jul 10 2023, Heiner Kallweit wrote:
>>> On 05.07.2023 00:25, Tobias Klausmann wrote:
>>>> Hi, top posting as well, as im on vacation, too. The system does not
>>>> allow disabling ASPM, it is a very constrained notebook BIOS, thus
>>>> the suggestion is nit feasible. All in all the sugesstion seems not
>>>> favorable for me, as it is unknown how many systems are broken the
>>>> same way. Having a workaround adviced as default seems oretty wrong
>>>> to me.
>>>>
>>>
>>> To get a better understanding of the affected system:
>>> Could you please provide a full dmesg log and the lspci -vv output?
>>=20
>> I'm having the same problem as described by Tobias on a desktop
>> machine. v6.3 works; v6.4 results in transmit queue timeouts
>> occasionally. Reverting 2ab19de62d67 ("r8169: remove ASPM restrictions
>> now that ASPM is disabled during NAPI poll") "solves" the issue.
>>=20
>> From dmesg:
>>=20
>> |~ % dmesg | grep -i ASPM
>> |[    0.152746] ACPI FADT declares the system doesn't support PCIe ASPM,=
 so disable it
>> |[    0.905100] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI HPX-Type3]
>> |[    0.906508] acpi PNP0A08:00: FADT indicates ASPM is unsupported, usi=
ng BIOS configuration
>> |[    1.156585] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't =
have ASPM control
>> |[    1.300059] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have =
ASPM control
>>=20
>> In addition, with commit 2ab19de62d67 in kernel regular messages like
>> this show up:
>>=20
>> |[ 7487.214593] pcieport 0000:00:1c.2: AER: Corrected error received: 00=
00:03:00.0
>>=20
>> I'm happy to test any patches or provide more info if needed.
>>=20
> Thanks for the report. It's interesting that the issue seems to occur onl=
y on systems
> where BIOS doesn't allow OS to control ASPM. Maybe this results in the PC=
I subsystem
> not properly initializing something.
> Kurt/Klaus: Could you please boot with cmd line parameter pcie_aspm=3Dfor=
ce and see
> whether this changes something?
> This parameter lets Linux ignore the BIOS setting. You should see a messa=
ge
> "PCIe ASPM is forcibly enabled" in the dmesg log with this parameter.

Seems like this does not help. There are still PCIe errors:

|~ # dmesg | grep -i ASPM
|[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.4.2-gentoo-kurtOS roo=
t=3D/dev/nvme0n1p3 ro kvm-intel.nested=3D1 vga=3D794 pcie_aspm=3Dforce
|[    0.044016] Kernel command line: BOOT_IMAGE=3D/vmlinuz-6.4.2-gentoo-kur=
tOS root=3D/dev/nvme0n1p3 ro kvm-intel.nested=3D1 vga=3D794 pcie_aspm=3Dfor=
ce
|[    0.044048] PCIe ASPM is forcibly enabled
|[    0.153011] ACPI FADT declares the system doesn't support PCIe ASPM, so=
 disable it
|[    0.916341] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Clo=
ckPM Segments MSI HPX-Type3]
|[    0.917719] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using =
BIOS configuration
|~ # dmesg | grep -i r8169
|[    1.337417] r8169 0000:03:00.0 eth0: RTL8168h/8111h, 6c:3c:8c:2c:bd:de,=
 XID 541, IRQ 164
|[    1.337422] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes=
, tx checksumming: ko]
|[    2.833876] r8169 0000:03:00.0 enp3s0: renamed from eth0
|[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driv=
er (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
|[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
|[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow c=
ontrol off
|~ # dmesg | tail
|[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driv=
er (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
|[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
|[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow c=
ontrol off
|[   24.006568] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
|[   24.567803] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mi=
smatch - Found [Buffer], ACPI requires [Package] (20230331/nsarguments-61)
|[   41.563396] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:=
03:00.0
|[   47.065441] pcieport 0000:00:1c.2: AER: Multiple Corrected error receiv=
ed: 0000:03:00.0
|[   54.264285] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:=
03:00.0
|[   54.424210] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:=
03:00.0
|[   55.443439] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:=
03:00.0

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmSw9jATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguq+D/9WZWeb8/Ob9zj1Cf8VcxJrYKOH8nu+
LOmTElsTh3sflkXpyQSPWixgEbNxdSducxQUbQPaRKU+WCVXEzQwQunasIqaItZc
GX/rJWsdESkQQdohPJUQGDf+6K+6dS+mw105pbXIIjN6TSrxINqlh7wXlmP3lY9l
WQHu8BAeikiRyjpHbEYdkV5mKRCNUiTW5NxCnb3v/opIXrROz+QeNzqMiQoP5i7Y
DTjeSrU45SmT7BeYic/ebDZXs/eLscasgD5Ax/mqeD3DSf2oz3MbcAglNJSWTM9b
rhZYQ0KH27UfOuEmEJRveAgkkj1oYTM18qmcqKcPRjE4IwSY46uRTqOpc/LKbHEF
/+ltfOKu3HQCXwsUf6JsGz0fp7NN+/jTondn6aPDpamMhN/toM71OMvIfh+KVzHH
gIPObVdkT/i29efJEkhyq171MBNPO88Nf0Xh8e+A27nAkpndhJf0ZmEcEfjpbi5O
sYYN6qVq1gjHscYaoPmKh+XlwLmP6NZxpT90IeI1o0AkN+tFxWl3ywPQWlbs8r9Z
n7h+RPyC9UAdMfcQJ+rozDK0KGhz9OghOq1Zrh+AJQo6ryrIcenl8fPLqjOPfk98
5uMpPN6ShgfCgwXmUO/NSKEXHKUb/Dp7yhaLafAT5HNN/P51JSUcldKfzenJXUfo
ddqoQyoIaZgz2g==
=7uwp
-----END PGP SIGNATURE-----
--=-=-=--

