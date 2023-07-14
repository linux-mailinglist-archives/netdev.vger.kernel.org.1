Return-Path: <netdev+bounces-17860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E247534C6
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7701C215A0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4879F0;
	Fri, 14 Jul 2023 08:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46111D30A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:10:33 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674C3C2D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:10:12 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689322189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2joIjfhAmAJar1Quice1djLjK4m7sRAWwvV+OwS5g1U=;
	b=Ji4jqUM3fluLLf3Sr7Ppp9H7we4IEwZS+kSJAoX8OPLIIBZn/IHHx5H/iPTFV7OZ6t606X
	mlt2Djgs7mtaDpQyygpSrFZZwRYx3dLJyq165uXB/e78+gySIxDpMpuSaXOt8Ly2I03fXu
	HApqtToo/7Hr5tuzDnjo/oTNT7Ad1LJmHCGVmBDe4pf+Gxfx5SVtNHO2JI6CPwo8nraJX7
	+0yia3XW3tuAWgurLBh0lydFf9rzNUMiPFAyhSn/Q5j3tgSaQywtzhzHevxKU9/ygW/rbf
	z1nVfhe47gcoR9VRghwvu+IB6KtFCqnAFPKREUejup3aRFoPRgxJJnEzs9WqMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689322189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2joIjfhAmAJar1Quice1djLjK4m7sRAWwvV+OwS5g1U=;
	b=qJCImvb3VsIz3IaR99r36QO3EycL16tXg7xMyfOeI4gU9ngiX4VK6cyYmJykc+u1vIqquG
	4Zoppquk2lCO6DBg==
To: Heiner Kallweit <hkallweit1@gmail.com>, Tobias Klausmann
 <tobias.klausmann@freenet.de>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 netdev@vger.kernel.org
Subject: Re: r8169: transmit transmit queue timed out - v6.4 cycle
In-Reply-To: <ce802481-87c3-1bb8-2ee4-fc3cd73d889a@gmail.com>
References: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
 <CAFSsGVtiXSK_0M_TQm_38LabiRX7E5vR26x=cKags4ZQBqfXPQ@mail.gmail.com>
 <e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de>
 <f7ca15e8-2cf2-1372-e29a-d7f2a2cc09f1@leemhuis.info>
 <CAFSsGVuDLnW_7iwSUNebx8Lku3CGZhcym3uXfMFnotA=OYJJjQ@mail.gmail.com>
 <A69A7D66-A73A-4C4D-913B-8C2D4CF03CE2@freenet.de>
 <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com> <87a5w0cn18.fsf@kurt>
 <04dc4bbb-6bfd-4074-6d32-007dc8d213e5@gmail.com> <87wmz3ezf3.fsf@kurt>
 <ce802481-87c3-1bb8-2ee4-fc3cd73d889a@gmail.com>
Date: Fri, 14 Jul 2023 10:09:47 +0200
Message-ID: <87ttu6gbhw.fsf@kurt>
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

On Fri Jul 14 2023, Heiner Kallweit wrote:
>>> Thanks for the report. It's interesting that the issue seems to occur o=
nly on systems
>>> where BIOS doesn't allow OS to control ASPM. Maybe this results in the =
PCI subsystem
>>> not properly initializing something.
>>> Kurt/Klaus: Could you please boot with cmd line parameter pcie_aspm=3Df=
orce and see
>>> whether this changes something?
>>> This parameter lets Linux ignore the BIOS setting. You should see a mes=
sage
>>> "PCIe ASPM is forcibly enabled" in the dmesg log with this parameter.
>>=20
>> Seems like this does not help. There are still PCIe errors:
>>=20
>> |~ # dmesg | grep -i ASPM
>> |[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.4.2-gentoo-kurtOS =
root=3D/dev/nvme0n1p3 ro kvm-intel.nested=3D1 vga=3D794 pcie_aspm=3Dforce
>> |[    0.044016] Kernel command line: BOOT_IMAGE=3D/vmlinuz-6.4.2-gentoo-=
kurtOS root=3D/dev/nvme0n1p3 ro kvm-intel.nested=3D1 vga=3D794 pcie_aspm=3D=
force
>> |[    0.044048] PCIe ASPM is forcibly enabled
>> |[    0.153011] ACPI FADT declares the system doesn't support PCIe ASPM,=
 so disable it
>> |[    0.916341] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI HPX-Type3]
>> |[    0.917719] acpi PNP0A08:00: FADT indicates ASPM is unsupported, usi=
ng BIOS configuration
>> |~ # dmesg | grep -i r8169
>> |[    1.337417] r8169 0000:03:00.0 eth0: RTL8168h/8111h, 6c:3c:8c:2c:bd:=
de, XID 541, IRQ 164
>> |[    1.337422] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 by=
tes, tx checksumming: ko]
>> |[    2.833876] r8169 0000:03:00.0 enp3s0: renamed from eth0
>> |[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
>> |[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
>> |[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flo=
w control off
>> |~ # dmesg | tail
>> |[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
>> |[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
>> |[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flo=
w control off
>> |[   24.006568] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
>> |[   24.567803] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type=
 mismatch - Found [Buffer], ACPI requires [Package] (20230331/nsarguments-6=
1)
>> |[   41.563396] pcieport 0000:00:1c.2: AER: Corrected error received: 00=
00:03:00.0
>> |[   47.065441] pcieport 0000:00:1c.2: AER: Multiple Corrected error rec=
eived: 0000:03:00.0
>> |[   54.264285] pcieport 0000:00:1c.2: AER: Corrected error received: 00=
00:03:00.0
>> |[   54.424210] pcieport 0000:00:1c.2: AER: Corrected error received: 00=
00:03:00.0
>> |[   55.443439] pcieport 0000:00:1c.2: AER: Corrected error received: 00=
00:03:00.0
>>=20
>
> But no tx timeout (yet)?

No, not yet. It doesn't trigger immediately.

> Now that ASPM is forced, could you please disable ASPM L1.2?
> -> /sys/class/net/enp3s0/device/link/l1_2_aspm
> That's what we did until 6.3 for RTL8168h on systems where
> OS can control ASPM.

OK. Disabled ASPM L1.2. PCIe error messages stopped, but the NIC ran
into tx timeout:

|[Fri Jul 14 09:54:00 2023] ------------[ cut here ]------------
|[Fri Jul 14 09:54:00 2023] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue=
 0 timed out 9200 ms
|[Fri Jul 14 09:54:00 2023] WARNING: CPU: 5 PID: 0 at net/sched/sch_generic=
.c:525 dev_watchdog+0x176/0x1ea
|[...]
|[Fri Jul 14 09:54:03 2023] pcieport 0000:00:1c.2: Data Link Layer Link Act=
ive not set in 1000 msec
|[Fri Jul 14 09:54:03 2023] r8169 0000:03:00.0 enp3s0: Can't reset secondar=
y PCI bus, detach NIC

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmSxAssTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgq/pD/49KUJ6HGZJUCghT7V563Lg6yGyCQaz
D9dGgC7Alkq1Z3MUxrJpOW0s1UbzygvjVAOo0D+wzjxcYTraevHF01ExWgPL0l3/
828pKaI1UUXqcVidBHvpOqg9PByM2y8pjB59AxbPqGE7b7uWcuowKQVJQMKk0B1D
PrAaoxO9fsxwkQbJWDaGTJTr/sLoODwPBzoWq6ZfoGFF02dOozy4kwA7OlXOZyks
Q7OhLW/McbgNojM4fNjOCzn6AuW/MboJkscIVMGBy8FHUWyaFZzXM3DtJ/j5EQ3n
52u5dmdhXLnd5AUenHjbnOP4AX4VH2ZQI2McYWTRiZE18J8nSeSxwqb0tLr0U2AK
tbMDhX8mf77uky6ah0afRh4tCyXemb8sYOG8biHTT/TMzKkhCZ5HZyPlSFqishji
MPHLtm04QOUKVPn2Cs3uQdOU/I75f1QltVaOH1BOQmvZbVcrhLaTyNdxUXm3lHFi
Nn4ydoPnAjm7kzKBzoQLGrzWh7sq/oB54dUzs/K9KepF4B25gz554EB4/Fi86flr
rOMjeS5bwYGFyr4kFv9wQobhjRIQORVm+g5T6eZHgMYGp/sSMZ+l5RgUIlk9JNS/
TSFDc14BV2L6ab+IhaSwMnikjjgCia3vOVIcWdx7RzAO3DSFIzEz1wmiaR5UYkyG
icOy41YXhtsRow==
=XRPB
-----END PGP SIGNATURE-----
--=-=-=--

