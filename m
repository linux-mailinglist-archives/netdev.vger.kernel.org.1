Return-Path: <netdev+bounces-36123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DC7AD729
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 13:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DBDAD2811F7
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E218E2F;
	Mon, 25 Sep 2023 11:43:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB03107A7
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 11:43:43 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1969F
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1695642214; bh=r1fsa7+cCULupS6t1HEbzNvGUbvXawaloStonX5bbvY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=oQK/rycvdE+xAVzCnGiISLp0GxU+p5p7+Ht3BHIUpoJFDd1DD5VFt7TVLpxhZN++a
	 ad1VDbV0FHzUdAZUaZ+zRajndSOfNnMIoHCOSitcDFrCNbod1VMDtNXOwPjYWAEVMX
	 VEwbOllOyKcnvn96ygch3FUOVnoIwKj1BhIFzgvJwm7KlmzgKNhJT7UZ32Uk/bTJiD
	 AhCvO04qclCkkNv+iQLQGbH20t+6Cltz6ORaSVKoBhoWepM5UEvYQZFkMKUov2vLn3
	 T/Qjd2aLotWx5IkgnFy2ftMbnrhGl8siN7qfs7E1NXex/6w+NW+/82XDT2MLCM+lF7
	 OVmS0V7AwG7LQ==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 35BBE11C00BE;
	Mon, 25 Sep 2023 13:43:34 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Mon, 25 Sep 2023 13:30:17 +0200
In-reply-to: <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
Message-ID: <87y1guv5p7.fsf@mkjws.danelec-net.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 25.09.2023 10:36, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>>> CC: Heiner
>>>
>>> On Wed, 09 Aug 2023 13:50:31 +0200 Martin Kj=C3=A6r J=C3=B8rgensen wrot=
e:
>>>
>>> There were some fix in r8169 for power management changes recently.
>>> Could you try the latest stable kernel? 6.4.9 ?
>>>
>>
>> Well, neither 6.4.11 nor current debian 'testing' kernel 6.5.3 solved th=
e problem.
>
> You can test with latest 5.15 and 6.1 LTS kernels. If either doesn't show=
 the error,
> please bisect. And you could test with vendor driver r8168 or r8125, depe=
nding on NIC
> version.
> The tx timeout error is very generic, based on just this info there's not=
 much we can
> do. According to the following log snippet you have 4 NIC's in your syste=
m.
>
> [    0.750649] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have AS=
PM control
> [    0.771525] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have AS=
PM control
> [    0.791797] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have AS=
PM control
> [    0.807683] r8169 0000:09:00.0: can't disable ASPM; OS doesn't have AS=
PM control
>
> Are some on PCIe extension cards?

There are no PCI extension cards.

> And does the problem occur with all of your NICs?

No, only the Realtek ones.

> The exact NIC type might provide a hint, best provide a full dmesg log.

[    0.000000] Linux version 6.5.0-1-amd64 (debian-kernel@lists.debian.org)=
 (gcc-13 (Debian 13.2.0-4) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #=
1 SMP PREEMPT_DYNAMIC Debian 6.5.3-1 (2023-09-13)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.5.0-1-amd64 root=3DUUI=
D=3D8510c66b-6961-4319-972e-0676c075dcf5 ro loglevel=3D3 usbcore.autosuspen=
d=3D-1 apparmor=3D0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006c32ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006c330000-0x0000000075252fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000075253000-0x00000000754d2fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000754d3000-0x00000000755fcfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000755fd000-0x0000000075dfefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000075dff000-0x0000000075efefff] type =
20
[    0.000000] BIOS-e820: [mem 0x0000000075eff000-0x0000000075efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075f00000-0x000000007dffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ec00000-0x000000007edfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007fa00000-0x000000008a7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000010757fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI=3D0x754d2000 ACPI 2.0=3D0x754d2014 TPMFinalLog=3D0=
x75547000 SMBIOS=3D0x75c3c000 SMBIOS 3.0=3D0x75c3b000 MEMATTR=3D0x67e25018 =
ESRT=3D0x6a068018 MOKvar=3D0x75c8a000
[    0.000000] efi: Remove mem67: MMIO range=3D[0xe0000000-0xefffffff] (256=
MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Not removing mem68: MMIO range=3D[0xfe000000-0xfe010fff=
] (68KB) from e820 map
[    0.000000] efi: Not removing mem69: MMIO range=3D[0xfec00000-0xfec00fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem70: MMIO range=3D[0xfed00000-0xfed00fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem72: MMIO range=3D[0xfee00000-0xfee00fff=
] (4KB) from e820 map
[    0.000000] efi: Remove mem73: MMIO range=3D[0xff000000-0xffffffff] (16M=
B) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/25/2023
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000000] tsc: Detected 2496.000 MHz TSC
[    0.000486] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000487] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000492] last_pfn =3D 0x1075800 max_arch_pfn =3D 0x400000000
[    0.000495] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000496] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000812] last_pfn =3D 0x75f00 max_arch_pfn =3D 0x400000000
[    0.006906] esrt: Reserving ESRT space from 0x000000006a068018 to 0x0000=
00006a0680c8.
[    0.006909] e820: update [mem 0x6a068000-0x6a068fff] usable =3D=3D> rese=
rved
[    0.006919] Using GB pages for direct mapping
[    0.007053] RAMDISK: [mem 0x32041000-0x35017fff]
[    0.007054] ACPI: Early table checksum verification disabled
[    0.007055] ACPI: RSDP 0x00000000754D2014 000024 (v02 LENOVO)
[    0.007058] ACPI: XSDT 0x00000000754D1728 000104 (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007061] ACPI: FACP 0x00000000754C9000 000114 (v06 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007065] ACPI: DSDT 0x0000000075465000 0637C4 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007066] ACPI: FACS 0x00000000755FA000 000040
[    0.007068] ACPI: MCFG 0x00000000754D0000 00003C (v01 LENOVO TC-S0A   00=
0013A0 MSFT 00000097)
[    0.007069] ACPI: SSDT 0x00000000754CA000 0055BB (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007071] ACPI: FIDT 0x0000000075464000 00009C (v01 LENOVO TC-S0A   00=
0013A0 AMI  00010013)
[    0.007073] ACPI: SSDT 0x0000000075463000 0003A4 (v01 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007074] ACPI: SSDT 0x0000000075460000 002629 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007076] ACPI: MSDM 0x000000007545F000 000055 (v03 LENOVO TC-S0A   00=
0013A0 AMI  00010013)
[    0.007077] ACPI: SSDT 0x000000007545A000 00440F (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007079] ACPI: SSDT 0x0000000075456000 003183 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007081] ACPI: HPET 0x0000000075455000 000038 (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007082] ACPI: APIC 0x0000000075454000 000164 (v04 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007084] ACPI: SSDT 0x0000000075453000 000D5E (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007085] ACPI: SSDT 0x0000000075452000 0008F8 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007087] ACPI: NHLT 0x0000000075451000 00002D (v00 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007089] ACPI: SSDT 0x000000007544E000 0022B1 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007090] ACPI: UEFI 0x000000007552A000 000048 (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007092] ACPI: LPIT 0x000000007544D000 0000CC (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007093] ACPI: DBGP 0x000000007544B000 000034 (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007095] ACPI: DBG2 0x000000007544A000 000054 (v00 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007096] ACPI: DMAR 0x0000000075449000 000088 (v02 LENOVO TC-S0A   00=
0013A0      01000013)
[    0.007098] ACPI: SSDT 0x0000000075448000 000144 (v02 LENOVO TC-S0A   00=
0013A0 INTL 20180209)
[    0.007100] ACPI: BGRT 0x0000000075447000 000038 (v01 LENOVO TC-S0A   00=
0013A0 AMI  00010013)
[    0.007101] ACPI: LUFT 0x0000000075412000 034CC2 (v01 LENOVO TC-S0A   00=
0013A0 AMI  00010013)
[    0.007103] ACPI: TPM2 0x0000000075411000 00004C (v04 LENOVO TC-S0A   00=
0013A0 AMI  00000000)
[    0.007105] ACPI: ASF! 0x0000000075410000 000074 (v32 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007106] ACPI: PTDT 0x000000007540F000 000D36 (v00 LENOVO TC-S0A   00=
0013A0 MSFT 0100000D)
[    0.007108] ACPI: WSMT 0x000000007544C000 000028 (v01 LENOVO TC-S0A   00=
0013A0 AMI  00010013)
[    0.007110] ACPI: FPDT 0x000000007540E000 000044 (v01 LENOVO TC-S0A   00=
0013A0 AMI  01000013)
[    0.007111] ACPI: Reserving FACP table memory at [mem 0x754c9000-0x754c9=
113]
[    0.007112] ACPI: Reserving DSDT table memory at [mem 0x75465000-0x754c8=
7c3]
[    0.007112] ACPI: Reserving FACS table memory at [mem 0x755fa000-0x755fa=
03f]
[    0.007112] ACPI: Reserving MCFG table memory at [mem 0x754d0000-0x754d0=
03b]
[    0.007113] ACPI: Reserving SSDT table memory at [mem 0x754ca000-0x754cf=
5ba]
[    0.007113] ACPI: Reserving FIDT table memory at [mem 0x75464000-0x75464=
09b]
[    0.007114] ACPI: Reserving SSDT table memory at [mem 0x75463000-0x75463=
3a3]
[    0.007114] ACPI: Reserving SSDT table memory at [mem 0x75460000-0x75462=
628]
[    0.007114] ACPI: Reserving MSDM table memory at [mem 0x7545f000-0x7545f=
054]
[    0.007115] ACPI: Reserving SSDT table memory at [mem 0x7545a000-0x7545e=
40e]
[    0.007115] ACPI: Reserving SSDT table memory at [mem 0x75456000-0x75459=
182]
[    0.007116] ACPI: Reserving HPET table memory at [mem 0x75455000-0x75455=
037]
[    0.007116] ACPI: Reserving APIC table memory at [mem 0x75454000-0x75454=
163]
[    0.007116] ACPI: Reserving SSDT table memory at [mem 0x75453000-0x75453=
d5d]
[    0.007117] ACPI: Reserving SSDT table memory at [mem 0x75452000-0x75452=
8f7]
[    0.007117] ACPI: Reserving NHLT table memory at [mem 0x75451000-0x75451=
02c]
[    0.007118] ACPI: Reserving SSDT table memory at [mem 0x7544e000-0x75450=
2b0]
[    0.007118] ACPI: Reserving UEFI table memory at [mem 0x7552a000-0x7552a=
047]
[    0.007118] ACPI: Reserving LPIT table memory at [mem 0x7544d000-0x7544d=
0cb]
[    0.007119] ACPI: Reserving DBGP table memory at [mem 0x7544b000-0x7544b=
033]
[    0.007119] ACPI: Reserving DBG2 table memory at [mem 0x7544a000-0x7544a=
053]
[    0.007120] ACPI: Reserving DMAR table memory at [mem 0x75449000-0x75449=
087]
[    0.007120] ACPI: Reserving SSDT table memory at [mem 0x75448000-0x75448=
143]
[    0.007120] ACPI: Reserving BGRT table memory at [mem 0x75447000-0x75447=
037]
[    0.007121] ACPI: Reserving LUFT table memory at [mem 0x75412000-0x75446=
cc1]
[    0.007121] ACPI: Reserving TPM2 table memory at [mem 0x75411000-0x75411=
04b]
[    0.007122] ACPI: Reserving ASF! table memory at [mem 0x75410000-0x75410=
073]
[    0.007122] ACPI: Reserving PTDT table memory at [mem 0x7540f000-0x7540f=
d35]
[    0.007122] ACPI: Reserving WSMT table memory at [mem 0x7544c000-0x7544c=
027]
[    0.007123] ACPI: Reserving FPDT table memory at [mem 0x7540e000-0x7540e=
043]
[    0.007269] No NUMA configuration found
[    0.007269] Faking a node at [mem 0x0000000000000000-0x00000010757fffff]
[    0.007273] NODE_DATA(0) allocated [mem 0x10757d5000-0x10757fffff]
[    0.007380] Zone ranges:
[    0.007381]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007382]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007383]   Normal   [mem 0x0000000100000000-0x00000010757fffff]
[    0.007384]   Device   empty
[    0.007384] Movable zone start for each node
[    0.007385] Early memory node ranges
[    0.007385]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.007386]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.007387]   node   0: [mem 0x0000000000100000-0x000000006c32ffff]
[    0.007387]   node   0: [mem 0x0000000075eff000-0x0000000075efffff]
[    0.007388]   node   0: [mem 0x0000000100000000-0x00000010757fffff]
[    0.007390] Initmem setup node 0 [mem 0x0000000000001000-0x00000010757ff=
fff]
[    0.007393] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007394] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007407] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.009108] On node 0, zone DMA32: 39887 pages in unavailable ranges
[    0.009269] On node 0, zone Normal: 8448 pages in unavailable ranges
[    0.009307] On node 0, zone Normal: 10240 pages in unavailable ranges
[    0.009443] Reserving Intel graphics memory at [mem 0x82800000-0x8a7ffff=
f]
[    0.009942] ACPI: PM-Timer IO Port: 0x1808
[    0.009946] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.009947] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.009948] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.009948] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.009948] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.009949] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.009949] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.009950] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.009950] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.009950] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.009951] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.009951] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.009951] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.009952] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.009952] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.009952] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.009953] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.009953] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.009953] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.009954] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.009992] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.009994] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.009995] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.009997] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.009998] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.010002] e820: update [mem 0x679dc000-0x67a24fff] usable =3D=3D> rese=
rved
[    0.010008] TSC deadline timer available
[    0.010009] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.010017] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.010018] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009efff]
[    0.010019] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.010020] PM: hibernation: Registered nosave memory: [mem 0x679dc000-0=
x67a24fff]
[    0.010021] PM: hibernation: Registered nosave memory: [mem 0x6a068000-0=
x6a068fff]
[    0.010022] PM: hibernation: Registered nosave memory: [mem 0x6c330000-0=
x75252fff]
[    0.010022] PM: hibernation: Registered nosave memory: [mem 0x75253000-0=
x754d2fff]
[    0.010022] PM: hibernation: Registered nosave memory: [mem 0x754d3000-0=
x755fcfff]
[    0.010023] PM: hibernation: Registered nosave memory: [mem 0x755fd000-0=
x75dfefff]
[    0.010023] PM: hibernation: Registered nosave memory: [mem 0x75dff000-0=
x75efefff]
[    0.010024] PM: hibernation: Registered nosave memory: [mem 0x75f00000-0=
x7dffffff]
[    0.010024] PM: hibernation: Registered nosave memory: [mem 0x7e000000-0=
x7ebfffff]
[    0.010025] PM: hibernation: Registered nosave memory: [mem 0x7ec00000-0=
x7edfffff]
[    0.010025] PM: hibernation: Registered nosave memory: [mem 0x7ee00000-0=
x7f9fffff]
[    0.010025] PM: hibernation: Registered nosave memory: [mem 0x7fa00000-0=
x8a7fffff]
[    0.010026] PM: hibernation: Registered nosave memory: [mem 0x8a800000-0=
xfdffffff]
[    0.010026] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.010027] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.010027] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.010027] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.010028] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed00fff]
[    0.010028] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0=
xfed1ffff]
[    0.010028] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]
[    0.010029] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfedfffff]
[    0.010029] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.010029] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.010030] [mem 0x8a800000-0xfdffffff] available for PCI devices
[    0.010031] Booting paravirtualized kernel on bare hardware
[    0.010032] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.012690] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 =
nr_node_ids:1
[    0.013100] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.013103] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=3D1*2097152
[    0.013104] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 1=
3 14 15
[    0.013117] Kernel command line: BOOT_IMAGE=3D/vmlinuz-6.5.0-1-amd64 roo=
t=3DUUID=3D8510c66b-6961-4319-972e-0676c075dcf5 ro loglevel=3D3 usbcore.aut=
osuspend=3D-1 apparmor=3D0 drm.edid_firmware=3DHDMI-A-2:edid/1920x1080.bin,=
DP-2:edid/1920x1080.bin video=3DHDMI-A-2:1920x1080@60D
[    0.013161] Unknown kernel command line parameters "BOOT_IMAGE=3D/vmlinu=
z-6.5.0-1-amd64", will be passed to user space.
[    0.013175] random: crng init done
[    0.016836] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, linear)
[    0.018680] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, linear)
[    0.018810] Fallback order for Node 0: 0
[    0.018812] Built 1 zonelists, mobility grouping on.  Total pages: 16392=
644
[    0.018813] Policy zone: Normal
[    0.018816] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.018821] software IO TLB: area num 16.
[    0.033125] Memory: 1725672K/66612028K available (14336K kernel code, 23=
45K rwdata, 10332K rodata, 3928K init, 18116K bss, 1380848K reserved, 0K cm=
a-reserved)
[    0.033266] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.033284] ftrace: allocating 42167 entries in 165 pages
[    0.037860] ftrace: allocated 165 pages with 4 groups
[    0.038244] Dynamic Preempt: voluntary
[    0.038270] rcu: Preemptible hierarchical RCU implementation.
[    0.038271] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D16.
[    0.038272] 	Trampoline variant of Tasks RCU enabled.
[    0.038272] 	Rude variant of Tasks RCU enabled.
[    0.038272] 	Tracing variant of Tasks RCU enabled.
[    0.038273] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.038273] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.039700] NR_IRQS: 524544, nr_irqs: 2184, preallocated irqs: 16
[    0.040065] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.040260] Console: colour dummy device 80x25
[    0.040261] printk: console [tty0] enabled
[    0.040283] ACPI: Core revision 20230331
[    0.040542] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.040543] APIC: Switch to symmetric I/O mode setup
[    0.040544] DMAR: Host address width 39
[    0.040545] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.040549] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660=
462 ecap 69e2ff0505e
[    0.040550] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.040554] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.040556] DMAR: RMRR base: 0x00000082000000 end: 0x0000008a7fffff
[    0.040557] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.040558] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.040559] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.042085] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.042086] x2apic enabled
[    0.042104] Switched APIC routing to cluster x2apic.
[    0.046172] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    0.046177] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4992.00 BogoMIPS (lpj=3D9984000)
[    0.046196] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.046257] process: using mwait in idle threads
[    0.046259] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.046260] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.046262] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.046264] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.046264] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.046264] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.046265] RETBleed: Mitigation: Enhanced IBRS
[    0.046265] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.046266] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.046270] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.046270] GDS: Vulnerable: No microcode
[    0.046275] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.046276] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.046276] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.046276] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.046277] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.046277] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.046278] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.046278] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.046279] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.046279] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.046280] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.046281] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.046281] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.046282] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.046282] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.046283] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.046283] x86/fpu: Enabled xstate features 0x2ff, context size is 2568=
 bytes, using 'compacted' format.
[    0.050175] Freeing SMP alternatives memory: 36K
[    0.050175] pid_max: default: 32768 minimum: 301
[    0.050175] LSM: initializing lsm=3Dlockdown,capability,landlock,yama,se=
linux,tomoyo,bpf,integrity
[    0.050175] landlock: Up and running.
[    0.050175] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.050175] SELinux:  Initializing.
[    0.050175] TOMOYO Linux initialized
[    0.050175] LSM support for eBPF active
[    0.050175] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.050175] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
[    0.050175] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i9-11900 @ 2.50GHz=
 (family: 0x6, model: 0xa7, stepping: 0x1)
[    0.050175] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.050175] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.050175] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.050175] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecat=
ed, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.050175] ... version:                5
[    0.050175] ... bit width:              48
[    0.050175] ... generic registers:      8
[    0.050175] ... value mask:             0000ffffffffffff
[    0.050175] ... max period:             00007fffffffffff
[    0.050175] ... fixed-purpose events:   4
[    0.050175] ... event mask:             0001000f000000ff
[    0.050175] signal: max sigframe size: 3632
[    0.050175] Estimated ratio of average max frequency by base frequency (=
times 1024): 2048
[    0.050175] rcu: Hierarchical SRCU implementation.
[    0.050175] rcu: 	Max phase no-delay instances is 1000.
[    0.050175] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.050175] smp: Bringing up secondary CPUs ...
[    0.050175] smpboot: x86: Booting SMP configuration:
[    0.050175] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14 #15
[    0.050377] MMIO Stale Data CPU bug present and SMT on, data leak possib=
le. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processo=
r_mmio_stale_data.html for more details.
[    0.050377] smp: Brought up 1 node, 16 CPUs
[    0.050377] smpboot: Max logical packages: 1
[    0.050377] smpboot: Total of 16 processors activated (79872.00 BogoMIPS)
[    0.098929] node 0 deferred pages initialised in 44ms
[    0.102877] devtmpfs: initialized
[    0.102877] x86/mm: Memory block size: 2048MB
[    0.102877] ACPI: PM: Registering ACPI NVS region [mem 0x754d3000-0x755f=
cfff] (1220608 bytes)
[    0.102877] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.102877] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.102877] pinctrl core: initialized pinctrl subsystem
[    0.102877] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.102936] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.103142] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.103346] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.103350] audit: initializing netlink subsys (disabled)
[    0.103355] audit: type=3D2000 audit(1695638302.056:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.103355] thermal_sys: Registered thermal governor 'fair_share'
[    0.103355] thermal_sys: Registered thermal governor 'bang_bang'
[    0.103355] thermal_sys: Registered thermal governor 'step_wise'
[    0.103355] thermal_sys: Registered thermal governor 'user_space'
[    0.103355] thermal_sys: Registered thermal governor 'power_allocator'
[    0.103355] cpuidle: using governor ladder
[    0.103355] cpuidle: using governor menu
[    0.103355] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.103355] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.103355] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.103355] PCI: not using MMCONFIG
[    0.103355] PCI: Using configuration type 1 for base access
[    0.103355] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.103355] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.103355] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.103355] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.103355] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.103355] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.103355] ACPI: Added _OSI(Module Device)
[    0.103355] ACPI: Added _OSI(Processor Device)
[    0.103355] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.103355] ACPI: Added _OSI(Processor Aggregator Device)
[    0.143974] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.S=
AT0], AE_NOT_FOUND (20230331/dswload2-162)
[    0.143980] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202303=
31/psobject-220)
[    0.143983] ACPI: Skipping parse of AML opcode: OpcodeName unavailable (=
0x0010)
[    0.149267] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.154402] ACPI: Dynamic OEM Table Load:
[    0.154403] ACPI: SSDT 0xFFFF997A01625A00 0001CB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20180209)
[    0.154939] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.156124] ACPI: Dynamic OEM Table Load:
[    0.156128] ACPI: SSDT 0xFFFF997A0167FC00 000394 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20180209)
[    0.156803] ACPI: Dynamic OEM Table Load:
[    0.156807] ACPI: SSDT 0xFFFF997A01D4C800 000560 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20180209)
[    0.157509] ACPI: Dynamic OEM Table Load:
[    0.157512] ACPI: SSDT 0xFFFF997A0167F400 000278 (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20180209)
[    0.158816] ACPI: Dynamic OEM Table Load:
[    0.158826] ACPI: SSDT 0xFFFF997A01695000 0008E7 (v02 PmRef  ApIst    00=
003000 INTL 20180209)
[    0.160434] ACPI: Dynamic OEM Table Load:
[    0.160443] ACPI: SSDT 0xFFFF997A01D4E000 00048A (v02 PmRef  ApHwp    00=
003000 INTL 20180209)
[    0.161919] ACPI: Dynamic OEM Table Load:
[    0.161928] ACPI: SSDT 0xFFFF997A01D4A800 0004D4 (v02 PmRef  ApPsd    00=
003000 INTL 20180209)
[    0.162804] ACPI: Dynamic OEM Table Load:
[    0.162808] ACPI: SSDT 0xFFFF997A01D4E800 00048A (v02 PmRef  ApCst    00=
003000 INTL 20180209)
[    0.168244] ACPI: Interpreter enabled
[    0.168275] ACPI: PM: (supports S0 S3 S4 S5)
[    0.168276] ACPI: Using IOAPIC for interrupt routing
[    0.168302] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.169633] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as ACP=
I motherboard resource
[    0.169639] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.169640] PCI: Ignoring E820 reservations for host bridge windows
[    0.170632] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.185975] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.186118] ACPI: \_SB_.PC00.SAT0.VOL0.V0PR: New power resource
[    0.186181] ACPI: \_SB_.PC00.SAT0.VOL1.V1PR: New power resource
[    0.186238] ACPI: \_SB_.PC00.SAT0.VOL2.V2PR: New power resource
[    0.189838] ACPI: \_TZ_.FN00: New power resource
[    0.189871] ACPI: \_TZ_.FN01: New power resource
[    0.189900] ACPI: \_TZ_.FN02: New power resource
[    0.189931] ACPI: \_TZ_.FN03: New power resource
[    0.189960] ACPI: \_TZ_.FN04: New power resource
[    0.190312] ACPI: \PIN_: New power resource
[    0.190408] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.190575] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.190579] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.192540] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    0.192540] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.193333] PCI host bridge to bus 0000:00
[    0.193334] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.193335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.193336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.193337] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.193338] pci_bus 0000:00: root bus resource [mem 0x8a800000-0xdffffff=
f window]
[    0.193338] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.193339] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.193461] pci 0000:00:00.0: [8086:4c43] type 00 class 0x060000
[    0.193539] pci 0000:00:01.0: [8086:4c01] type 01 class 0x060400
[    0.193595] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.193617] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.193920] pci 0000:00:02.0: [8086:4c8a] type 00 class 0x030000
[    0.193926] pci 0000:00:02.0: reg 0x10: [mem 0x6000000000-0x6000ffffff 6=
4bit]
[    0.193931] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 6=
4bit pref]
[    0.193934] pci 0000:00:02.0: reg 0x20: [io  0x7000-0x703f]
[    0.193944] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.193945] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.193947] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.194046] pci 0000:00:04.0: [8086:4c03] type 00 class 0x118000
[    0.194057] pci 0000:00:04.0: reg 0x10: [mem 0x6001010000-0x600101ffff 6=
4bit]
[    0.194239] pci 0000:00:06.0: [8086:4c09] type 01 class 0x060400
[    0.194316] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.194349] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.194694] pci 0000:00:14.0: [8086:43ed] type 00 class 0x0c0330
[    0.194711] pci 0000:00:14.0: reg 0x10: [mem 0x6001000000-0x600100ffff 6=
4bit]
[    0.194780] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.195719] pci 0000:00:14.2: [8086:43ef] type 00 class 0x050000
[    0.195736] pci 0000:00:14.2: reg 0x10: [mem 0x6001020000-0x6001023fff 6=
4bit]
[    0.195748] pci 0000:00:14.2: reg 0x18: [mem 0x6001026000-0x6001026fff 6=
4bit]
[    0.195871] pci 0000:00:16.0: [8086:43e0] type 00 class 0x078000
[    0.195891] pci 0000:00:16.0: reg 0x10: [mem 0x6001025000-0x6001025fff 6=
4bit]
[    0.195964] pci 0000:00:16.0: PME# supported from D3hot
[    0.196242] pci 0000:00:17.0: [8086:43d2] type 00 class 0x010601
[    0.196257] pci 0000:00:17.0: reg 0x10: [mem 0x8ad20000-0x8ad21fff]
[    0.196266] pci 0000:00:17.0: reg 0x14: [mem 0x8ad23000-0x8ad230ff]
[    0.196276] pci 0000:00:17.0: reg 0x18: [io  0x7090-0x7097]
[    0.196285] pci 0000:00:17.0: reg 0x1c: [io  0x7080-0x7083]
[    0.196294] pci 0000:00:17.0: reg 0x20: [io  0x7060-0x707f]
[    0.196304] pci 0000:00:17.0: reg 0x24: [mem 0x8ad22000-0x8ad227ff]
[    0.196345] pci 0000:00:17.0: PME# supported from D3hot
[    0.196662] pci 0000:00:1c.0: [8086:43bf] type 01 class 0x060400
[    0.196760] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.196797] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.197164] pci 0000:00:1f.0: [8086:438f] type 00 class 0x060100
[    0.197394] pci 0000:00:1f.4: [8086:43a3] type 00 class 0x0c0500
[    0.197416] pci 0000:00:1f.4: reg 0x10: [mem 0x6001024000-0x60010240ff 6=
4bit]
[    0.197443] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.197572] pci 0000:00:1f.5: [8086:43a4] type 00 class 0x0c8000
[    0.197588] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.197713] pci 0000:00:1f.6: [8086:15f9] type 00 class 0x020000
[    0.197741] pci 0000:00:1f.6: reg 0x10: [mem 0x8ad00000-0x8ad1ffff]
[    0.197881] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.198049] pci 0000:01:00.0: [1b21:1182] type 01 class 0x060400
[    0.198088] pci 0000:01:00.0: enabling Extended Tags
[    0.198136] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.198232] pci 0000:00:01.0: PCI bridge to [bus 01-04]
[    0.198234] pci 0000:00:01.0:   bridge window [io  0x5000-0x6fff]
[    0.198235] pci 0000:00:01.0:   bridge window [mem 0x8aa00000-0x8abfffff]
[    0.198278] pci 0000:02:03.0: [1b21:1182] type 01 class 0x060400
[    0.198320] pci 0000:02:03.0: enabling Extended Tags
[    0.198368] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    0.198438] pci 0000:02:07.0: [1b21:1182] type 01 class 0x060400
[    0.198479] pci 0000:02:07.0: enabling Extended Tags
[    0.198527] pci 0000:02:07.0: PME# supported from D0 D3hot D3cold
[    0.198602] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[    0.198606] pci 0000:01:00.0:   bridge window [io  0x5000-0x6fff]
[    0.198609] pci 0000:01:00.0:   bridge window [mem 0x8aa00000-0x8abfffff]
[    0.198659] pci 0000:03:00.0: [10ec:8125] type 00 class 0x020000
[    0.198679] pci 0000:03:00.0: reg 0x10: [io  0x6000-0x60ff]
[    0.198707] pci 0000:03:00.0: reg 0x18: [mem 0x8ab10000-0x8ab1ffff 64bit]
[    0.198724] pci 0000:03:00.0: reg 0x20: [mem 0x8ab20000-0x8ab23fff 64bit]
[    0.198735] pci 0000:03:00.0: reg 0x30: [mem 0x8ab00000-0x8ab0ffff pref]
[    0.198859] pci 0000:03:00.0: supports D1 D2
[    0.198860] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.198925] pci 0000:03:00.0: reg 0x1b4: [mem 0x00000000-0x0000ffff 64bi=
t]
[    0.198926] pci 0000:03:00.0: VF(n) BAR2 space: [mem 0x00000000-0x0006ff=
ff 64bit] (contains BAR2 for 7 VFs)
[    0.198943] pci 0000:03:00.0: reg 0x1bc: [mem 0x00000000-0x00003fff 64bi=
t]
[    0.198944] pci 0000:03:00.0: VF(n) BAR4 space: [mem 0x00000000-0x0001bf=
ff 64bit] (contains BAR4 for 7 VFs)
[    0.199205] pci 0000:02:03.0: PCI bridge to [bus 03]
[    0.199209] pci 0000:02:03.0:   bridge window [io  0x6000-0x6fff]
[    0.199212] pci 0000:02:03.0:   bridge window [mem 0x8ab00000-0x8abfffff]
[    0.199264] pci 0000:04:00.0: [10ec:8125] type 00 class 0x020000
[    0.199284] pci 0000:04:00.0: reg 0x10: [io  0x5000-0x50ff]
[    0.199312] pci 0000:04:00.0: reg 0x18: [mem 0x8aa10000-0x8aa1ffff 64bit]
[    0.199329] pci 0000:04:00.0: reg 0x20: [mem 0x8aa20000-0x8aa23fff 64bit]
[    0.199340] pci 0000:04:00.0: reg 0x30: [mem 0x8aa00000-0x8aa0ffff pref]
[    0.199465] pci 0000:04:00.0: supports D1 D2
[    0.199465] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.199531] pci 0000:04:00.0: reg 0x1b4: [mem 0x00000000-0x0000ffff 64bi=
t]
[    0.199532] pci 0000:04:00.0: VF(n) BAR2 space: [mem 0x00000000-0x0006ff=
ff 64bit] (contains BAR2 for 7 VFs)
[    0.199548] pci 0000:04:00.0: reg 0x1bc: [mem 0x00000000-0x00003fff 64bi=
t]
[    0.199549] pci 0000:04:00.0: VF(n) BAR4 space: [mem 0x00000000-0x0001bf=
ff 64bit] (contains BAR4 for 7 VFs)
[    0.199814] pci 0000:02:07.0: PCI bridge to [bus 04]
[    0.199818] pci 0000:02:07.0:   bridge window [io  0x5000-0x5fff]
[    0.199821] pci 0000:02:07.0:   bridge window [mem 0x8aa00000-0x8aafffff]
[    0.200052] pci 0000:05:00.0: [1e0f:0009] type 00 class 0x010802
[    0.200094] pci 0000:05:00.0: reg 0x10: [mem 0x8ac00000-0x8ac03fff 64bit]
[    0.200960] pci 0000:00:06.0: PCI bridge to [bus 05]
[    0.200962] pci 0000:00:06.0:   bridge window [mem 0x8ac00000-0x8acfffff]
[    0.201027] pci 0000:06:00.0: [1b21:1182] type 01 class 0x060400
[    0.201087] pci 0000:06:00.0: enabling Extended Tags
[    0.201160] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.201298] pci 0000:00:1c.0: PCI bridge to [bus 06-09]
[    0.201300] pci 0000:00:1c.0:   bridge window [io  0x3000-0x4fff]
[    0.201303] pci 0000:00:1c.0:   bridge window [mem 0x8a800000-0x8a9fffff]
[    0.201365] pci 0000:07:03.0: [1b21:1182] type 01 class 0x060400
[    0.201428] pci 0000:07:03.0: enabling Extended Tags
[    0.201501] pci 0000:07:03.0: PME# supported from D0 D3hot D3cold
[    0.201605] pci 0000:07:07.0: [1b21:1182] type 01 class 0x060400
[    0.201667] pci 0000:07:07.0: enabling Extended Tags
[    0.201740] pci 0000:07:07.0: PME# supported from D0 D3hot D3cold
[    0.201852] pci 0000:06:00.0: PCI bridge to [bus 07-09]
[    0.201858] pci 0000:06:00.0:   bridge window [io  0x3000-0x4fff]
[    0.201861] pci 0000:06:00.0:   bridge window [mem 0x8a800000-0x8a9fffff]
[    0.201931] pci 0000:08:00.0: [10ec:8125] type 00 class 0x020000
[    0.201957] pci 0000:08:00.0: reg 0x10: [io  0x4000-0x40ff]
[    0.201993] pci 0000:08:00.0: reg 0x18: [mem 0x8a910000-0x8a91ffff 64bit]
[    0.202016] pci 0000:08:00.0: reg 0x20: [mem 0x8a920000-0x8a923fff 64bit]
[    0.202030] pci 0000:08:00.0: reg 0x30: [mem 0x8a900000-0x8a90ffff pref]
[    0.202195] pci 0000:08:00.0: supports D1 D2
[    0.202196] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.202284] pci 0000:08:00.0: reg 0x1b4: [mem 0x00000000-0x0000ffff 64bi=
t]
[    0.202284] pci 0000:08:00.0: VF(n) BAR2 space: [mem 0x00000000-0x0006ff=
ff 64bit] (contains BAR2 for 7 VFs)
[    0.202306] pci 0000:08:00.0: reg 0x1bc: [mem 0x00000000-0x00003fff 64bi=
t]
[    0.202306] pci 0000:08:00.0: VF(n) BAR4 space: [mem 0x00000000-0x0001bf=
ff 64bit] (contains BAR4 for 7 VFs)
[    0.202656] pci 0000:07:03.0: PCI bridge to [bus 08]
[    0.202662] pci 0000:07:03.0:   bridge window [io  0x4000-0x4fff]
[    0.202665] pci 0000:07:03.0:   bridge window [mem 0x8a900000-0x8a9fffff]
[    0.202736] pci 0000:09:00.0: [10ec:8125] type 00 class 0x020000
[    0.202763] pci 0000:09:00.0: reg 0x10: [io  0x3000-0x30ff]
[    0.202799] pci 0000:09:00.0: reg 0x18: [mem 0x8a810000-0x8a81ffff 64bit]
[    0.202821] pci 0000:09:00.0: reg 0x20: [mem 0x8a820000-0x8a823fff 64bit]
[    0.202836] pci 0000:09:00.0: reg 0x30: [mem 0x8a800000-0x8a80ffff pref]
[    0.203001] pci 0000:09:00.0: supports D1 D2
[    0.203002] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.203090] pci 0000:09:00.0: reg 0x1b4: [mem 0x00000000-0x0000ffff 64bi=
t]
[    0.203090] pci 0000:09:00.0: VF(n) BAR2 space: [mem 0x00000000-0x0006ff=
ff 64bit] (contains BAR2 for 7 VFs)
[    0.203112] pci 0000:09:00.0: reg 0x1bc: [mem 0x00000000-0x00003fff 64bi=
t]
[    0.203112] pci 0000:09:00.0: VF(n) BAR4 space: [mem 0x00000000-0x0001bf=
ff 64bit] (contains BAR4 for 7 VFs)
[    0.203464] pci 0000:07:07.0: PCI bridge to [bus 09]
[    0.203470] pci 0000:07:07.0:   bridge window [io  0x3000-0x3fff]
[    0.203474] pci 0000:07:07.0:   bridge window [mem 0x8a800000-0x8a8fffff]
[    0.204866] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.204919] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.204970] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.205022] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.205073] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.205125] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.205176] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.205228] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.209796] iommu: Default domain type: Translated
[    0.209796] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.209796] pps_core: LinuxPPS API ver. 1 registered
[    0.209796] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.209796] PTP clock support registered
[    0.209796] EDAC MC: Ver: 3.0.0
[    0.210239] efivars: Registered efivars operations
[    0.210373] NetLabel: Initializing
[    0.210374] NetLabel:  domain hash size =3D 128
[    0.210375] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.210389] NetLabel:  unlabeled traffic allowed by default
[    0.210389] PCI: Using ACPI for IRQ routing
[    0.232619] PCI: pci_cache_line_size set to 64 bytes
[    0.233001] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010f=
ff]: no compatible bridge window
[    0.233372] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.233373] e820: reserve RAM buffer [mem 0x679dc000-0x67ffffff]
[    0.233373] e820: reserve RAM buffer [mem 0x6a068000-0x6bffffff]
[    0.233374] e820: reserve RAM buffer [mem 0x6c330000-0x6fffffff]
[    0.233375] e820: reserve RAM buffer [mem 0x75f00000-0x77ffffff]
[    0.233375] e820: reserve RAM buffer [mem 0x1075800000-0x1077ffffff]
[    0.233399] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.233399] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.233399] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.233399] vgaarb: loaded
[    0.233399] clocksource: Switched to clocksource tsc-early
[    0.233399] VFS: Disk quotas dquot_6.6.0
[    0.233399] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.233399] pnp: PnP ACPI init
[    0.233399] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[    0.233399] system 00:00: [io  0x0a10-0x0a9f] has been reserved
[    0.233399] system 00:00: [io  0x0aa0-0x0aaf] has been reserved
[    0.233399] system 00:00: [io  0x0ab0-0x0abf] has been reserved
[    0.233399] pnp 00:01: [dma 0 disabled]
[    0.233399] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.233399] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.233399] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.233399] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.233399] system 00:04: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.233399] system 00:04: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.233399] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.233399] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.233399] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.233399] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.233399] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.233399] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.233399] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.233399] system 00:05: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    0.233399] system 00:05: [mem 0xfe050000-0xfe0affff] has been reserved
[    0.233399] system 00:05: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    0.233399] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.233399] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.233399] system 00:05: [mem 0xfd000000-0xfd68ffff] has been reserved
[    0.233399] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.233399] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.233399] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.233399] system 00:07: [mem 0xfd6e0000-0xfd6effff] has been reserved
[    0.233399] system 00:07: [mem 0xfd6d0000-0xfd6dffff] has been reserved
[    0.233399] system 00:07: [mem 0xfd6b0000-0xfd6bffff] has been reserved
[    0.233399] system 00:07: [mem 0xfd6a0000-0xfd6affff] has been reserved
[    0.233399] system 00:07: [mem 0xfd690000-0xfd69ffff] has been reserved
[    0.233399] pnp: PnP ACPI: found 9 devices
[    0.238082] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.238112] NET: Registered PF_INET protocol family
[    0.238229] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.239845] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes, linear)
[    0.239877] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.240092] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, linear)
[    0.240426] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.240521] TCP: Hash tables configured (established 524288 bind 65536)
[    0.240667] MPTCP token hash table entries: 65536 (order: 8, 1572864 byt=
es, linear)
[    0.240799] UDP hash table entries: 32768 (order: 8, 1048576 bytes, line=
ar)
[    0.240893] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes,=
 linear)
[    0.240957] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.240962] NET: Registered PF_XDP protocol family
[    0.240966] pci_bus 0000:00: max bus depth: 3 pci_try_num: 4
[    0.240972] pci 0000:00:1f.5: BAR 0: assigned [mem 0x8ad24000-0x8ad24fff]
[    0.240992] pci 0000:03:00.0: BAR 9: assigned [mem 0x8ab30000-0x8ab9ffff=
 64bit]
[    0.240998] pci 0000:03:00.0: BAR 11: assigned [mem 0x8aba0000-0x8abbbff=
f 64bit]
[    0.241003] pci 0000:02:03.0: PCI bridge to [bus 03]
[    0.241005] pci 0000:02:03.0:   bridge window [io  0x6000-0x6fff]
[    0.241008] pci 0000:02:03.0:   bridge window [mem 0x8ab00000-0x8abfffff]
[    0.241014] pci 0000:04:00.0: BAR 9: assigned [mem 0x8aa30000-0x8aa9ffff=
 64bit]
[    0.241019] pci 0000:04:00.0: BAR 11: assigned [mem 0x8aaa0000-0x8aabbff=
f 64bit]
[    0.241024] pci 0000:02:07.0: PCI bridge to [bus 04]
[    0.241026] pci 0000:02:07.0:   bridge window [io  0x5000-0x5fff]
[    0.241029] pci 0000:02:07.0:   bridge window [mem 0x8aa00000-0x8aafffff]
[    0.241035] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[    0.241036] pci 0000:01:00.0:   bridge window [io  0x5000-0x6fff]
[    0.241039] pci 0000:01:00.0:   bridge window [mem 0x8aa00000-0x8abfffff]
[    0.241045] pci 0000:00:01.0: PCI bridge to [bus 01-04]
[    0.241046] pci 0000:00:01.0:   bridge window [io  0x5000-0x6fff]
[    0.241048] pci 0000:00:01.0:   bridge window [mem 0x8aa00000-0x8abfffff]
[    0.241052] pci 0000:00:06.0: PCI bridge to [bus 05]
[    0.241058] pci 0000:00:06.0:   bridge window [mem 0x8ac00000-0x8acfffff]
[    0.241063] pci 0000:08:00.0: BAR 9: assigned [mem 0x8a930000-0x8a99ffff=
 64bit]
[    0.241082] pci 0000:08:00.0: BAR 11: assigned [mem 0x8a9a0000-0x8a9bbff=
f 64bit]
[    0.241088] pci 0000:07:03.0: PCI bridge to [bus 08]
[    0.241090] pci 0000:07:03.0:   bridge window [io  0x4000-0x4fff]
[    0.241095] pci 0000:07:03.0:   bridge window [mem 0x8a900000-0x8a9fffff]
[    0.241104] pci 0000:09:00.0: BAR 9: assigned [mem 0x8a830000-0x8a89ffff=
 64bit]
[    0.241110] pci 0000:09:00.0: BAR 11: assigned [mem 0x8a8a0000-0x8a8bbff=
f 64bit]
[    0.241116] pci 0000:07:07.0: PCI bridge to [bus 09]
[    0.241118] pci 0000:07:07.0:   bridge window [io  0x3000-0x3fff]
[    0.241123] pci 0000:07:07.0:   bridge window [mem 0x8a800000-0x8a8fffff]
[    0.241131] pci 0000:06:00.0: PCI bridge to [bus 07-09]
[    0.241133] pci 0000:06:00.0:   bridge window [io  0x3000-0x4fff]
[    0.241138] pci 0000:06:00.0:   bridge window [mem 0x8a800000-0x8a9fffff]
[    0.241146] pci 0000:00:1c.0: PCI bridge to [bus 06-09]
[    0.241148] pci 0000:00:1c.0:   bridge window [io  0x3000-0x4fff]
[    0.241151] pci 0000:00:1c.0:   bridge window [mem 0x8a800000-0x8a9fffff]
[    0.241157] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.241158] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.241158] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.241159] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.241160] pci_bus 0000:00: resource 8 [mem 0x8a800000-0xdfffffff windo=
w]
[    0.241160] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.241161] pci_bus 0000:01: resource 0 [io  0x5000-0x6fff]
[    0.241162] pci_bus 0000:01: resource 1 [mem 0x8aa00000-0x8abfffff]
[    0.241163] pci_bus 0000:02: resource 0 [io  0x5000-0x6fff]
[    0.241163] pci_bus 0000:02: resource 1 [mem 0x8aa00000-0x8abfffff]
[    0.241164] pci_bus 0000:03: resource 0 [io  0x6000-0x6fff]
[    0.241165] pci_bus 0000:03: resource 1 [mem 0x8ab00000-0x8abfffff]
[    0.241165] pci_bus 0000:04: resource 0 [io  0x5000-0x5fff]
[    0.241166] pci_bus 0000:04: resource 1 [mem 0x8aa00000-0x8aafffff]
[    0.241167] pci_bus 0000:05: resource 1 [mem 0x8ac00000-0x8acfffff]
[    0.241167] pci_bus 0000:06: resource 0 [io  0x3000-0x4fff]
[    0.241168] pci_bus 0000:06: resource 1 [mem 0x8a800000-0x8a9fffff]
[    0.241168] pci_bus 0000:07: resource 0 [io  0x3000-0x4fff]
[    0.241169] pci_bus 0000:07: resource 1 [mem 0x8a800000-0x8a9fffff]
[    0.241170] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.241170] pci_bus 0000:08: resource 1 [mem 0x8a900000-0x8a9fffff]
[    0.241171] pci_bus 0000:09: resource 0 [io  0x3000-0x3fff]
[    0.241171] pci_bus 0000:09: resource 1 [mem 0x8a800000-0x8a8fffff]
[    0.241856] PCI: CLS 64 bytes, default 64
[    0.241867] DMAR: No ATSR found
[    0.241867] DMAR: No SATC found
[    0.241868] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.241869] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.241869] DMAR: IOMMU feature nwfs inconsistent
[    0.241869] DMAR: IOMMU feature pds inconsistent
[    0.241870] DMAR: IOMMU feature dit inconsistent
[    0.241870] DMAR: IOMMU feature eafs inconsistent
[    0.241870] DMAR: IOMMU feature prs inconsistent
[    0.241871] DMAR: IOMMU feature nest inconsistent
[    0.241871] DMAR: IOMMU feature mts inconsistent
[    0.241871] DMAR: IOMMU feature sc_support inconsistent
[    0.241872] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.241872] DMAR: dmar0: Using Queued invalidation
[    0.241874] DMAR: dmar1: Using Queued invalidation
[    0.241914] Trying to unpack rootfs image as initramfs...
[    0.242138] pci 0000:00:02.0: Adding to iommu group 0
[    0.242156] pci 0000:00:00.0: Adding to iommu group 1
[    0.242164] pci 0000:00:01.0: Adding to iommu group 2
[    0.242170] pci 0000:00:04.0: Adding to iommu group 3
[    0.242180] pci 0000:00:06.0: Adding to iommu group 4
[    0.242189] pci 0000:00:14.0: Adding to iommu group 5
[    0.242194] pci 0000:00:14.2: Adding to iommu group 5
[    0.242200] pci 0000:00:16.0: Adding to iommu group 6
[    0.242205] pci 0000:00:17.0: Adding to iommu group 7
[    0.242217] pci 0000:00:1c.0: Adding to iommu group 8
[    0.242230] pci 0000:00:1f.0: Adding to iommu group 9
[    0.242235] pci 0000:00:1f.4: Adding to iommu group 9
[    0.242240] pci 0000:00:1f.5: Adding to iommu group 9
[    0.242245] pci 0000:00:1f.6: Adding to iommu group 9
[    0.242251] pci 0000:01:00.0: Adding to iommu group 10
[    0.242256] pci 0000:02:03.0: Adding to iommu group 11
[    0.242262] pci 0000:02:07.0: Adding to iommu group 12
[    0.242265] pci 0000:03:00.0: Adding to iommu group 11
[    0.242268] pci 0000:04:00.0: Adding to iommu group 12
[    0.242278] pci 0000:05:00.0: Adding to iommu group 13
[    0.242285] pci 0000:06:00.0: Adding to iommu group 14
[    0.242292] pci 0000:07:03.0: Adding to iommu group 15
[    0.242299] pci 0000:07:07.0: Adding to iommu group 16
[    0.242301] pci 0000:08:00.0: Adding to iommu group 15
[    0.242303] pci 0000:09:00.0: Adding to iommu group 16
[    0.243141] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.243143] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.243143] software IO TLB: mapped [mem 0x000000005e400000-0x0000000062=
400000] (64MB)
[    0.243164] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23f=
a772cf26, max_idle_ns: 440795269835 ns
[    0.243196] clocksource: Switched to clocksource tsc
[    0.243212] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.243444] Initialise system trusted keyrings
[    0.243450] Key type blacklist registered
[    0.243472] workingset: timestamp_bits=3D36 max_order=3D24 bucket_order=
=3D0
[    0.243478] zbud: loaded
[    0.243661] integrity: Platform Keyring initialized
[    0.243662] integrity: Machine keyring initialized
[    0.243663] Key type asymmetric registered
[    0.243664] Asymmetric key parser 'x509' registered
[    0.424163] Freeing initrd memory: 48988K
[    0.426626] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[    0.426701] io scheduler mq-deadline registered
[    0.427254] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.427315] pcieport 0000:00:01.0: AER: enabled with IRQ 122
[    0.427340] pcieport 0000:00:01.0: DPC: enabled with IRQ 122
[    0.427340] pcieport 0000:00:01.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.427439] pcieport 0000:00:06.0: PME: Signaling with IRQ 123
[    0.427471] pcieport 0000:00:06.0: AER: enabled with IRQ 123
[    0.427495] pcieport 0000:00:06.0: DPC: enabled with IRQ 123
[    0.427495] pcieport 0000:00:06.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.427747] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    0.427827] pcieport 0000:00:1c.0: AER: enabled with IRQ 124
[    0.427857] pcieport 0000:00:1c.0: DPC: enabled with IRQ 124
[    0.427857] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.428580] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.428590] efifb: probing for efifb
[    0.428601] efifb: framebuffer at 0x4000000000, using 1920k, total 1920k
[    0.428602] efifb: mode is 800x600x32, linelength=3D3200, pages=3D1
[    0.428603] efifb: scrolling: redraw
[    0.428603] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.428681] Console: switching to colour frame buffer device 100x37
[    0.428906] fb0: EFI VGA frame buffer device
[    0.429025] Monitor-Mwait will be used to enter C-1 state
[    0.429039] Monitor-Mwait will be used to enter C-2 state
[    0.429056] Monitor-Mwait will be used to enter C-3 state
[    0.429059] ACPI: \_SB_.PR00: Found 3 idle states
[    0.430893] thermal LNXTHERM:00: registered as thermal_zone0
[    0.430894] ACPI: thermal: Thermal Zone [TZ00] (62 C)
[    0.431003] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.431271] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.432888] hpet_acpi_add: no address or irqs in _CRS
[    0.432901] Linux agpgart interface v0.103
[    0.437256] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
[    0.459252] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em - This is not a bug.
[    0.460467] i8042: PNP: No PS/2 controller found.
[    0.460611] mousedev: PS/2 mouse device common for all mice
[    0.460638] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.461590] rtc_cmos rtc_cmos: registered as rtc0
[    0.461789] rtc_cmos rtc_cmos: setting system clock to 2023-09-25T10:38:=
23 UTC (1695638303)
[    0.461833] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.461841] intel_pstate: Intel P-state driver initializing
[    0.463899] intel_pstate: HWP enabled
[    0.464104] ledtrig-cpu: registered to indicate activity on CPUs
[    0.473471] NET: Registered PF_INET6 protocol family
[    0.476092] Segment Routing with IPv6
[    0.476098] In-situ OAM (IOAM) with IPv6
[    0.476119] mip6: Mobile IPv6
[    0.476122] NET: Registered PF_PACKET protocol family
[    0.476184] mpls_gso: MPLS GSO support
[    0.477516] microcode: Microcode Update Driver: v2.2.
[    0.477519] IPI shorthand broadcast: enabled
[    0.478059] sched_clock: Marking stable (472002043, 5939167)->(498217501=
, -20276291)
[    0.478256] registered taskstats version 1
[    0.478303] Loading compiled-in X.509 certificates
[    0.490922] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f61=
49f3dd27dfcc5cbb419ea1'
[    0.490931] Loaded X.509 cert 'Debian Secure Boot Signer 2022 - linux: 1=
4011249c2675ea8e5148542202005810584b25f'
[    0.491894] Key type .fscrypt registered
[    0.491895] Key type fscrypt-provisioning registered
[    0.496410] Key type encrypted registered
[    0.496741] integrity: Loading X.509 certificate: UEFI:db
[    0.496784] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.496786] integrity: Loading X.509 certificate: UEFI:db
[    0.496823] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.496824] integrity: Loading X.509 certificate: UEFI:db
[    0.496845] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    0.496846] integrity: Loading X.509 certificate: UEFI:db
[    0.497160] integrity: Loaded X.509 cert 'Trust - Lenovo Certificate: bc=
19ccf68446c18b4a08dce9b1cb4deb'
[    0.497834] blacklist: Duplicate blacklisted hash bin:47ff1b63b140b6fc04=
ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
[    0.497838] blacklist: Duplicate blacklisted hash bin:5391c3a2fb112102a6=
aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
[    0.497913] blacklist: Duplicate blacklisted hash bin:80b4d96931bf0d02fd=
91a61e19d14f1da452e66db2408ca8604d411f92659f0a
[    0.497997] blacklist: Duplicate blacklisted hash bin:992d359aa7a5f789d2=
68b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
[    0.498083] blacklist: Duplicate blacklisted hash bin:c452ab846073df5ace=
25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
[    0.498144] blacklist: Duplicate blacklisted hash bin:e051b788ecbaeda530=
46c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
[    0.498447] ima: Allocated hash algorithm: sha256
[    0.540819] ima: No architecture policies found
[    0.540856] evm: Initialising EVM extended attributes:
[    0.540857] evm: security.selinux
[    0.540859] evm: security.SMACK64 (disabled)
[    0.540861] evm: security.SMACK64EXEC (disabled)
[    0.540862] evm: security.SMACK64TRANSMUTE (disabled)
[    0.540864] evm: security.SMACK64MMAP (disabled)
[    0.540865] evm: security.apparmor
[    0.540866] evm: security.ima
[    0.540867] evm: security.capability
[    0.540869] evm: HMAC attrs: 0x1
[    0.618318] RAS: Correctable Errors collector initialized.
[    0.618353] clk: Disabling unused clocks
[    0.621177] Freeing unused decrypted memory: 2036K
[    0.621595] Freeing unused kernel image (initmem) memory: 3928K
[    0.646095] Write protecting the kernel read-only data: 26624k
[    0.647161] Freeing unused kernel image (rodata/data gap) memory: 1956K
[    0.656905] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.656909] Run /init as init process
[    0.656910]   with arguments:
[    0.656911]     /init
[    0.656912]   with environment:
[    0.656912]     HOME=3D/
[    0.656912]     TERM=3Dlinux
[    0.656913]     BOOT_IMAGE=3D/vmlinuz-6.5.0-1-amd64
[    0.738739] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    0.738783] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    0.739550] cryptd: max_cpu_qlen set to 1000
[    0.740464] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    0.741062] i2c i2c-0: Successfully instantiated SPD at 0x51
[    0.741697] i2c i2c-0: Successfully instantiated SPD at 0x53
[    0.747135] ACPI: bus type USB registered
[    0.747153] usbcore: registered new interface driver usbfs
[    0.747158] usbcore: registered new interface driver hub
[    0.747167] usbcore: registered new device driver usb
[    0.749022] SCSI subsystem initialized
[    0.751050] e1000e: Intel(R) PRO/1000 Network Driver
[    0.751051] AVX2 version of gcm_enc/dec engaged.
[    0.751052] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.751095] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
[    0.751109] AES CTR mode by8 optimization enabled
[    0.751318] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    0.761634] ACPI: bus type drm_connector registered
[    0.762138] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.768229] libata version 3.00 loaded.
[    0.769309] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.769317] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.770423] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000000200009810
[    0.770661] nvme 0000:05:00.0: platform quirk: setting simple suspend
[    0.770693] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.770697] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.770699] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    0.770701] nvme nvme0: pci function 0000:05:00.0
[    0.770733] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.05
[    0.770735] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.770737] usb usb1: Product: xHCI Host Controller
[    0.770738] usb usb1: Manufacturer: Linux 6.5.0-1-amd64 xhci-hcd
[    0.770739] usb usb1: SerialNumber: 0000:00:14.0
[    0.770855] hub 1-0:1.0: USB hub found
[    0.770877] hub 1-0:1.0: 16 ports detected
[    0.771950] ahci 0000:00:17.0: version 3.0
[    0.772771] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.05
[    0.772773] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.772774] usb usb2: Product: xHCI Host Controller
[    0.772774] usb usb2: Manufacturer: Linux 6.5.0-1-amd64 xhci-hcd
[    0.772775] usb usb2: SerialNumber: 0000:00:14.0
[    0.772852] hub 2-0:1.0: USB hub found
[    0.772854] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
[    0.772857] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds
[    0.772867] hub 2-0:1.0: 10 ports detected
[    0.776206] nvme nvme0: Shutdown timeout set to 10 seconds
[    0.777502] nvme nvme0: 8/0/0 default/read/poll queues
[    0.779043]  nvme0n1: p1 p2 p3 p4 p5
[    0.779672] r8169 0000:03:00.0 eth0: RTL8125A, 00:13:3b:b0:3d:24, XID 60=
9, IRQ 141
[    0.779675] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    0.779770] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.799556] r8169 0000:04:00.0 eth1: RTL8125A, 00:13:3b:b0:3d:25, XID 60=
9, IRQ 142
[    0.799559] r8169 0000:04:00.0 eth1: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    0.799704] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.806191] scsi host0: ahci
[    0.806272] scsi host1: ahci
[    0.806324] scsi host2: ahci
[    0.806367] scsi host3: ahci
[    0.806391] ata1: SATA max UDMA/133 abar m2048@0x8ad22000 port 0x8ad2210=
0 irq 132
[    0.806393] ata2: SATA max UDMA/133 abar m2048@0x8ad22000 port 0x8ad2218=
0 irq 132
[    0.806394] ata3: SATA max UDMA/133 abar m2048@0x8ad22000 port 0x8ad2220=
0 irq 132
[    0.806396] ata4: SATA max UDMA/133 abar m2048@0x8ad22000 port 0x8ad2228=
0 irq 132
[    0.811549] r8169 0000:08:00.0 eth2: RTL8125A, 00:13:3b:b0:3d:54, XID 60=
9, IRQ 143
[    0.811551] r8169 0000:08:00.0 eth2: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    0.811658] r8169 0000:09:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.827693] r8169 0000:09:00.0 eth3: RTL8125A, 00:13:3b:b0:3d:55, XID 60=
9, IRQ 144
[    0.827695] r8169 0000:09:00.0 eth3: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    0.831644] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    0.902234] e1000e 0000:00:1f.6 eth4: (PCI Express:2.5GT/s:Width x1) d8:=
bb:c1:c3:4c:6f
[    0.902237] e1000e 0000:00:1f.6 eth4: Intel(R) PRO/1000 Network Connecti=
on
[    0.902342] e1000e 0000:00:1f.6 eth4: MAC: 14, PHY: 12, PBA No: FFFFFF-0=
FF
[    1.007497] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    1.007574] Console: switching to colour dummy device 80x25
[    1.007598] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.007634] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.009033] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.009061] i915 0000:00:02.0: firmware: direct-loading firmware i915/rk=
l_dmc_ver2_03.bin
[    1.009585] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
rkl_dmc_ver2_03.bin (v2.3)
[    1.009953] [drm] forcing HDMI-A-2 connector on
[    1.015414] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected c=
ontent support initialized
[    1.047594] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
[    1.049232] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    1.049711] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input0
[    1.120445] ata3: SATA link down (SStatus 4 SControl 300)
[    1.121947] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.124269] ata4: SATA link down (SStatus 4 SControl 300)
[    1.124290] ata2: SATA link down (SStatus 4 SControl 300)
[    1.124433] ata1: SATA link down (SStatus 4 SControl 300)
[    1.275769] usb 1-1: New USB device found, idVendor=3D2109, idProduct=3D=
2812, bcdDevice=3D d.a0
[    1.275772] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.275774] usb 1-1: Product: USB2.0 Hub
[    1.275775] usb 1-1: Manufacturer: VIA Labs, Inc.
[    1.276799] hub 1-1:1.0: USB hub found
[    1.276962] hub 1-1:1.0: 4 ports detected
[    1.402137] usb 2-9: new SuperSpeed USB device number 2 using xhci_hcd
[    1.657573] usb 2-9: New USB device found, idVendor=3D2109, idProduct=3D=
0812, bcdDevice=3D d.a1
[    1.657575] usb 2-9: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.657576] usb 2-9: Product: USB3.0 Hub
[    1.657578] usb 2-9: Manufacturer: VIA Labs, Inc.
[    1.658842] hub 2-9:1.0: USB hub found
[    1.659251] hub 2-9:1.0: 4 ports detected
[    1.785944] usb 1-3: new high-speed USB device number 3 using xhci_hcd
[    1.923189] fbcon: i915drmfb (fb0) is primary device
[    1.991906] Console: switching to colour frame buffer device 240x67
[    2.011779] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.029677] e1000e 0000:00:1f.6 eno1: renamed from eth4
[    2.029987] usb 1-1.1: new full-speed USB device number 4 using xhci_hcd
[    2.078233] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    2.122032] r8169 0000:04:00.0 enp4s0: renamed from eth1
[    2.150079] r8169 0000:08:00.0 enp8s0: renamed from eth2
[    2.151668] usb 1-1.1: New USB device found, idVendor=3D1050, idProduct=
=3D0406, bcdDevice=3D 5.43
[    2.151672] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    2.151673] usb 1-1.1: Product: YubiKey FIDO+CCID
[    2.151674] usb 1-1.1: Manufacturer: Yubico
[    2.167236] hid: raw HID events driver (C) Jiri Kosina
[    2.169211] usbcore: registered new interface driver usbhid
[    2.169213] usbhid: USB HID core driver
[    2.170021] hid-generic 0003:1050:0406.0001: hiddev0,hidraw0: USB HID v1=
.10 Device [Yubico YubiKey FIDO+CCID] on usb-0000:00:14.0-1.1/input0
[    2.198077] r8169 0000:09:00.0 enp9s0: renamed from eth3
[    2.253945] usb 1-1.4: new full-speed USB device number 5 using xhci_hcd
[    2.379061] usb 1-1.4: New USB device found, idVendor=3D24f0, idProduct=
=3D204a, bcdDevice=3D 1.00
[    2.379065] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    2.379067] usb 1-1.4: Product: Das Keyboard
[    2.379068] usb 1-1.4: Manufacturer: Metadot - Das Keyboard
[    2.384687] input: Metadot - Das Keyboard Das Keyboard as /devices/pci00=
00:00/0000:00:14.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:24F0:204A.0002/input/input1
[    2.393940] raid6: avx512x4 gen() 65911 MB/s
[    2.446043] hid-generic 0003:24F0:204A.0002: input,hidraw1: USB HID v1.1=
0 Keyboard [Metadot - Das Keyboard Das Keyboard] on usb-0000:00:14.0-1.4/in=
put0
[    2.447059] input: Metadot - Das Keyboard Das Keyboard System Control as=
 /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:24F0:204A.0=
003/input/input2
[    2.461940] raid6: avx512x2 gen() 65309 MB/s
[    2.505965] input: Metadot - Das Keyboard Das Keyboard Consumer Control =
as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:24F0:204A=
.0003/input/input3
[    2.505991] hid-generic 0003:24F0:204A.0003: input,hidraw2: USB HID v1.1=
0 Device [Metadot - Das Keyboard Das Keyboard] on usb-0000:00:14.0-1.4/inpu=
t1
[    2.529940] raid6: avx512x1 gen() 56404 MB/s
[    2.597940] raid6: avx2x4   gen() 43892 MB/s
[    2.665940] raid6: avx2x2   gen() 44278 MB/s
[    2.733940] raid6: avx2x1   gen() 35189 MB/s
[    2.733941] raid6: using algorithm avx512x4 gen() 65911 MB/s
[    2.801940] raid6: .... xor() 22563 MB/s, rmw enabled
[    2.801941] raid6: using avx512x2 recovery algorithm
[    2.802413] xor: automatically using best checksumming function   avx
[    2.802754] async_tx: api initialized (async)
[    2.831673] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.
[    2.831695] device-mapper: uevent: version 1.0.3
[    2.831739] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@redhat.com
[    4.161327] usb 1-3: New USB device found, idVendor=3D046d, idProduct=3D=
082d, bcdDevice=3D 0.11
[    4.161339] usb 1-3: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D1
[    4.161343] usb 1-3: Product: HD Pro Webcam C920
[    4.161347] usb 1-3: SerialNumber: 582A59AF
[    4.290056] usb 1-4: new full-speed USB device number 6 using xhci_hcd
[    4.444934] usb 1-4: New USB device found, idVendor=3D0403, idProduct=3D=
6001, bcdDevice=3D 6.00
[    4.444945] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    4.444950] usb 1-4: Product: TTL232R-3V3
[    4.444953] usb 1-4: Manufacturer: FTDI
[    4.444956] usb 1-4: SerialNumber: FTASY3R9
[    5.334059] usb 1-6: new full-speed USB device number 8 using xhci_hcd
[    5.484694] usb 1-6: New USB device found, idVendor=3D0b0e, idProduct=3D=
c0dd, bcdDevice=3D 1.06
[    5.484707] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    5.484711] usb 1-6: Product: Jabra Evolve2 65 Deskstand
[    5.484715] usb 1-6: Manufacturer: GN Audio A/S
[    5.484718] usb 1-6: SerialNumber: 07313249413802
[    5.491485] input: GN Audio A/S Jabra Evolve2 65 Deskstand as /devices/p=
ci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/0003:0B0E:C0DD.0004/input/input4
[    5.550556] jabra 0003:0B0E:C0DD.0004: input,hiddev1,hidraw3: USB HID v1=
.11 Device [GN Audio A/S Jabra Evolve2 65 Deskstand] on usb-0000:00:14.0-6/=
input0
[    5.614086] usb 1-7: new full-speed USB device number 9 using xhci_hcd
[    5.766971] usb 1-7: New USB device found, idVendor=3D0a12, idProduct=3D=
4010, bcdDevice=3D16.80
[    5.766983] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    5.769307] hub 1-7:1.0: USB hub found
[    5.770115] hub 1-7:1.0: 4 ports detected
[    5.898055] usb 1-8: new full-speed USB device number 10 using xhci_hcd
[    6.053612] usb 1-8: New USB device found, idVendor=3D0403, idProduct=3D=
6010, bcdDevice=3D 5.00
[    6.053624] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    6.053628] usb 1-8: Product: USB FAST SERIAL ADAPTER
[    6.053632] usb 1-8: Manufacturer: FTDI
[    6.053635] usb 1-8: SerialNumber: FT484151
[    6.126056] usb 1-7.1: new full-speed USB device number 11 using xhci_hcd
[    6.233524] usb 1-7.1: New USB device found, idVendor=3D0b0e, idProduct=
=3D24c8, bcdDevice=3D 1.16
[    6.233537] usb 1-7.1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    6.233542] usb 1-7.1: Product: Jabra Link 380
[    6.233545] usb 1-7.1: SerialNumber: 08C8C20490FA
[    6.242442] input: Jabra Link 380 as /devices/pci0000:00/0000:00:14.0/us=
b1/1-7/1-7.1/1-7.1:1.3/0003:0B0E:24C8.0005/input/input5
[    6.302619] jabra 0003:0B0E:24C8.0005: input,hiddev2,hidraw4: USB HID v1=
.11 Device [Jabra Link 380] on usb-0000:00:14.0-7.1/input3
[    6.354057] usb 1-9: new high-speed USB device number 12 using xhci_hcd
[    6.502852] usb 1-9: New USB device found, idVendor=3D0bda, idProduct=3D=
0129, bcdDevice=3D39.60
[    6.502864] usb 1-9: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    6.502868] usb 1-9: Product: USB2.0-CRW
[    6.502872] usb 1-9: Manufacturer: Generic
[    6.502875] usb 1-9: SerialNumber: 20100201396000000
[    6.515133] usbcore: registered new interface driver rtsx_usb
[    6.634086] usb 1-10: new full-speed USB device number 13 using xhci_hcd
[    6.785930] usb 1-10: New USB device found, idVendor=3D046d, idProduct=
=3Dc52b, bcdDevice=3D12.11
[    6.785964] usb 1-10: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    6.785969] usb 1-10: Product: USB Receiver
[    6.785972] usb 1-10: Manufacturer: Logitech
[    6.791081] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
14.0/usb1/1-10/1-10:1.0/0003:046D:C52B.0006/input/input6
[    6.850461] hid-generic 0003:046D:C52B.0006: input,hidraw5: USB HID v1.1=
1 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-10/input0
[    6.853583] input: Logitech USB Receiver Mouse as /devices/pci0000:00/00=
00:00:14.0/usb1/1-10/1-10:1.1/0003:046D:C52B.0007/input/input7
[    6.853918] input: Logitech USB Receiver Consumer Control as /devices/pc=
i0000:00/0000:00:14.0/usb1/1-10/1-10:1.1/0003:046D:C52B.0007/input/input8
[    6.914168] input: Logitech USB Receiver System Control as /devices/pci0=
000:00/0000:00:14.0/usb1/1-10/1-10:1.1/0003:046D:C52B.0007/input/input9
[    6.914584] hid-generic 0003:046D:C52B.0007: input,hiddev3,hidraw6: USB =
HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-10/input1
[    6.917242] hid-generic 0003:046D:C52B.0008: hiddev4,hidraw7: USB HID v1=
.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-10/input2
[    7.108082] logitech-djreceiver 0003:046D:C52B.0008: hiddev3,hidraw5: US=
B HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-10/input2
[    7.190054] usb 1-5: new full-speed USB device number 14 using xhci_hcd
[    7.229408] input: Logitech Wireless Device PID:4055 Mouse as /devices/p=
ci0000:00/0000:00:14.0/usb1/1-10/1-10:1.2/0003:046D:C52B.0008/0003:046D:405=
5.0009/input/input11
[    7.229576] hid-generic 0003:046D:4055.0009: input,hidraw6: USB HID v1.1=
1 Mouse [Logitech Wireless Device PID:4055] on usb-0000:00:14.0-10/input2:1
[    7.232237] input: Logitech Wireless Device PID:4076 Keyboard as /device=
s/pci0000:00/0000:00:14.0/usb1/1-10/1-10:1.2/0003:046D:C52B.0008/0003:046D:=
4076.000A/input/input15
[    7.232915] hid-generic 0003:046D:4076.000A: input,hidraw7: USB HID v1.1=
1 Keyboard [Logitech Wireless Device PID:4076] on usb-0000:00:14.0-10/input=
2:2
[    7.304669] input: Logitech Wireless Mouse as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-10/1-10:1.2/0003:046D:C52B.0008/0003:046D:4055.0009/input/inp=
ut19
[    7.305134] logitech-hidpp-device 0003:046D:4055.0009: input,hidraw6: US=
B HID v1.11 Mouse [Logitech Wireless Mouse] on usb-0000:00:14.0-10/input2:1
[    7.343059] usb 1-5: New USB device found, idVendor=3D0b0e, idProduct=3D=
2459, bcdDevice=3D 5.47
[    7.343080] usb 1-5: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D3
[    7.343084] usb 1-5: Product: Jabra SPORT PACE
[    7.343087] usb 1-5: SerialNumber: ABCDEF0123456789
[    7.348049] jabra 0003:0B0E:2459.000B: hiddev4,hidraw8: USB HID v1.11 De=
vice [Jabra SPORT PACE] on usb-0000:00:14.0-5/input0
[    7.480827] input: Logitech K540/K545 as /devices/pci0000:00/0000:00:14.=
0/usb1/1-10/1-10:1.2/0003:046D:C52B.0008/0003:046D:4076.000A/input/input20
[    7.481270] logitech-hidpp-device 0003:046D:4076.000A: input,hidraw7: US=
B HID v1.11 Keyboard [Logitech K540/K545] on usb-0000:00:14.0-10/input2:2
[   11.879365] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[   11.937396] EXT4-fs (dm-0): orphan cleanup on readonly fs
[   11.937538] EXT4-fs (dm-0): mounted filesystem 8510c66b-6961-4319-972e-0=
676c075dcf5 ro with ordered data mode. Quota mode: none.
[   11.969416] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   12.028695] systemd[1]: Inserted module 'autofs4'
[   12.065978] systemd[1]: systemd 254.1-3 running in system mode (+PAM +AU=
DIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +=
BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDIS=
K +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BP=
F_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[   12.065994] systemd[1]: Detected architecture x86-64.
[   12.068211] systemd[1]: Hostname set to <mkjws>.
[   12.271661] systemd[1]: Queued start job for default target graphical.ta=
rget.
[   12.310876] systemd[1]: Created slice machine.slice - Virtual Machine an=
d Container Slice.
[   12.313714] systemd[1]: Created slice system-getty.slice - Slice /system=
/getty.
[   12.315481] systemd[1]: Created slice system-modprobe.slice - Slice /sys=
tem/modprobe.
[   12.316748] systemd[1]: Created slice system-postfix.slice - Slice /syst=
em/postfix.
[   12.318016] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice=
 - Encrypted Volume Units Service Slice.
[   12.319488] systemd[1]: Created slice system-systemd\x2dfsck.slice - Sli=
ce /system/systemd-fsck.
[   12.320862] systemd[1]: Created slice system-systemd\x2dnetworkd\x2dwait=
\x2donline.slice - Slice /system/systemd-networkd-wait-online.
[   12.322114] systemd[1]: Created slice user.slice - User and Session Slic=
e.
[   12.322907] systemd[1]: Started systemd-ask-password-console.path - Disp=
atch Password Requests to Console Directory Watch.
[   12.323675] systemd[1]: Started systemd-ask-password-wall.path - Forward=
 Password Requests to Wall Directory Watch.
[   12.324671] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automou=
nt - Arbitrary Executable File Formats File System Automount Point.
[   12.325521] systemd[1]: Reached target integritysetup.target - Local Int=
egrity Protected Volumes.
[   12.326315] systemd[1]: Reached target nss-user-lookup.target - User and=
 Group Name Lookups.
[   12.327088] systemd[1]: Reached target slices.target - Slice Units.
[   12.327839] systemd[1]: Reached target stunnel.target - TLS tunnels for =
network services - per-config-file target.
[   12.328624] systemd[1]: Reached target veritysetup.target - Local Verity=
 Protected Volumes.
[   12.329525] systemd[1]: Listening on dm-event.socket - Device-mapper eve=
nt daemon FIFOs.
[   12.330898] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll da=
emon socket.
[   12.337286] systemd[1]: Listening on rpcbind.socket - RPCbind Server Act=
ivation Socket.
[   12.338752] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsck=
d communication Socket.
[   12.339831] systemd[1]: Listening on systemd-initctl.socket - initctl Co=
mpatibility Named Pipe.
[   12.340863] systemd[1]: Listening on systemd-journald-dev-log.socket - J=
ournal Socket (/dev/log).
[   12.341914] systemd[1]: Listening on systemd-journald.socket - Journal S=
ocket.
[   12.342871] systemd[1]: Listening on systemd-networkd.socket - Network S=
ervice Netlink Socket.
[   12.343861] systemd[1]: Listening on systemd-udevd-control.socket - udev=
 Control Socket.
[   12.344711] systemd[1]: Listening on systemd-udevd-kernel.socket - udev =
Kernel Socket.
[   12.345906] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File S=
ystem...
[   12.347182] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue =
File System...
[   12.348452] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug F=
ile System...
[   12.349423] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace=
 File System...
[   12.349920] systemd[1]: auth-rpcgss-module.service - Kernel Module suppo=
rting RPCSEC_GSS was skipped because of an unmet condition check (Condition=
PathExists=3D/etc/krb5.keytab).
[   12.349979] systemd[1]: Finished blk-availability.service - Availability=
 of block devices.
[   12.351100] systemd[1]: Starting keyboard-setup.service - Set the consol=
e keyboard layout...
[   12.352124] systemd[1]: Starting kmod-static-nodes.service - Create List=
 of Static Device Nodes...
[   12.353269] systemd[1]: Starting lvm2-monitor.service - Monitoring of LV=
M2 mirrors, snapshots etc. using dmeventd or progress polling...
[   12.354509] systemd[1]: Starting modprobe@configfs.service - Load Kernel=
 Module configfs...
[   12.355934] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel M=
odule dm_mod...
[   12.357233] systemd[1]: Starting modprobe@drm.service - Load Kernel Modu=
le drm...
[   12.358531] systemd[1]: Starting modprobe@efi_pstore.service - Load Kern=
el Module efi_pstore...
[   12.359930] systemd[1]: Starting modprobe@fuse.service - Load Kernel Mod=
ule fuse...
[   12.361337] systemd[1]: Starting modprobe@loop.service - Load Kernel Mod=
ule loop...
[   12.361504] pstore: Using crash dump compression: deflate
[   12.362453] systemd[1]: Starting nftables.service - nftables...
[   12.363055] systemd[1]: systemd-fsck-root.service - File System Check on=
 Root Device was skipped because of an unmet condition check (ConditionPath=
Exists=3D!/run/initramfs/fsck-root).
[   12.363927] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...
[   12.366213] loop: module loaded
[   12.366343] systemd[1]: Starting systemd-modules-load.service - Load Ker=
nel Modules...
[   12.367324] systemd[1]: Starting systemd-network-generator.service - Gen=
erate network units from Kernel command line...
[   12.367966] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID=
 Measurement was skipped because of an unmet condition check (ConditionPath=
Exists=3D/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6=
c7-440b29bb8c4f).
[   12.368477] systemd[1]: Starting systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems...
[   12.369620] systemd[1]: Starting systemd-udev-trigger.service - Coldplug=
 All udev Devices...
[   12.369803] fuse: init (API version 7.38)
[   12.371041] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File Sy=
stem.
[   12.371693] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue F=
ile System.
[   12.372304] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug Fi=
le System.
[   12.372934] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace =
File System.
[   12.373604] systemd[1]: Finished keyboard-setup.service - Set the consol=
e keyboard layout.
[   12.373619] systemd-journald[746]: Collecting audit messages is disabled.
[   12.374135] EXT4-fs (dm-0): re-mounted 8510c66b-6961-4319-972e-0676c075d=
cf5 r/w. Quota mode: none.
[   12.374654] systemd[1]: Finished kmod-static-nodes.service - Create List=
 of Static Device Nodes.
[   12.375016] pstore: Registered efi_pstore as persistent store backend
[   12.375441] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   12.375517] systemd[1]: Finished modprobe@configfs.service - Load Kernel=
 Module configfs.
[   12.376089] lp: driver loaded but no devices found
[   12.376276] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[   12.376339] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel M=
odule dm_mod.
[   12.377034] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   12.377092] systemd[1]: Finished modprobe@drm.service - Load Kernel Modu=
le drm.
[   12.377802] systemd[1]: modprobe@efi_pstore.service: Deactivated success=
fully.
[   12.377861] systemd[1]: Finished modprobe@efi_pstore.service - Load Kern=
el Module efi_pstore.
[   12.378493] ppdev: user-space parallel port driver
[   12.378571] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   12.378630] systemd[1]: Finished modprobe@fuse.service - Load Kernel Mod=
ule fuse.
[   12.379291] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   12.379348] systemd[1]: Finished modprobe@loop.service - Load Kernel Mod=
ule loop.
[   12.380040] systemd[1]: Finished systemd-network-generator.service - Gen=
erate network units from Kernel command line.
[   12.380712] systemd[1]: Finished systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems.
[   12.381919] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Co=
ntrol File System...
[   12.383212] systemd[1]: Mounting sys-kernel-config.mount - Kernel Config=
uration File System...
[   12.384224] systemd[1]: systemd-pstore.service - Platform Persistent Sto=
rage Archival was skipped because of an unmet condition check (ConditionDir=
ectoryNotEmpty=3D/sys/fs/pstore).
[   12.384761] systemd[1]: Starting systemd-random-seed.service - Load/Save=
 OS Random Seed...
[   12.385751] systemd[1]: systemd-repart.service - Repartition Root Disk w=
as skipped because no trigger condition checks were met.
[   12.386329] systemd[1]: Starting systemd-sysusers.service - Create Syste=
m Users...
[   12.387974] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Cr=
eate Static Device Nodes in /dev...
[   12.389062] systemd[1]: Finished systemd-modules-load.service - Load Ker=
nel Modules.
[   12.389694] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Con=
trol File System.
[   12.390313] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configu=
ration File System.
[   12.390975] systemd[1]: Finished systemd-random-seed.service - Load/Save=
 OS Random Seed.
[   12.392133] systemd[1]: Starting systemd-sysctl.service - Apply Kernel V=
ariables...
[   12.397500] systemd[1]: Finished systemd-sysctl.service - Apply Kernel V=
ariables.
[   12.399737] systemd[1]: Finished systemd-sysusers.service - Create Syste=
m Users.
[   12.400411] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Cr=
eate Static Device Nodes in /dev.
[   12.401613] systemd[1]: Starting systemd-udevd.service - Rule-based Mana=
ger for Device Events and Files...
[   12.408352] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[   12.418445] systemd-journald[746]: Received client request to flush runt=
ime journal.
[   12.428549] systemd-journald[746]: /var/log/journal/e150983afca344fc96c7=
51b8cfd263a1/system.journal: Boot ID changed since last record, rotating.
[   12.428551] systemd-journald[746]: Rotating system journal.
[   12.482728] intel_pmc_core INT33A1:00:  initialized
[   12.482783] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input21
[   12.485014] ACPI: button: Sleep Button [SLPB]
[   12.489670] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input22
[   12.491952] Consider using thermal netlink events interface
[   12.493928] ACPI: button: Power Button [PWRB]
[   12.498473] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input23
[   12.512035] usbcore: registered new interface driver usbserial_generic
[   12.512042] usbserial: USB Serial support registered for generic
[   12.514508] ACPI: button: Power Button [PWRF]
[   12.516799] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[   12.516906] ee1004 0-0053: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[   12.517095] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   12.517172] usbcore: registered new interface driver ftdi_sio
[   12.517309] usbserial: USB Serial support registered for FTDI USB Serial=
 Device
[   12.517652] ftdi_sio 1-4:1.0: FTDI USB Serial Device converter detected
[   12.517781] usb 1-4: Detected FT232R
[   12.518123] mc: Linux media interface: v0.10
[   12.518930] iTCO_vendor_support: vendor-support=3D0
[   12.520912] usb 1-4: FTDI USB Serial Device converter now attached to tt=
yUSB0
[   12.521009] ftdi_sio 1-8:1.0: FTDI USB Serial Device converter detected
[   12.521216] usb 1-8: Detected FT2232C/D
[   12.521340] usb 1-8: FTDI USB Serial Device converter now attached to tt=
yUSB1
[   12.521363] ftdi_sio 1-8:1.1: FTDI USB Serial Device converter detected
[   12.521385] usb 1-8: Detected FT2232C/D
[   12.521757] usb 1-8: FTDI USB Serial Device converter now attached to tt=
yUSB2
[   12.537590] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[   12.544076] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[   12.559475] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[   12.559594] videodev: Linux video capture interface: v2.00
[   12.560521] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[   12.710991] EXT4-fs (nvme0n1p3): mounted filesystem 6778c8e6-2117-44f3-9=
0f4-db5f38f3bbce r/w with ordered data mode. Quota mode: none.
[   12.714068] intel_rapl_common: Found RAPL domain package
[   12.714069] intel_rapl_common: Found RAPL domain core
[   12.714070] intel_rapl_common: Found RAPL domain uncore
[   12.733719] Adding 4105212k swap on /dev/mapper/swap.  Priority:-2 exten=
ts:1 across:4105212k SSFS
[   12.763726] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   12.763821] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7=
b54b4961b8b4fadf'
[   12.763909] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1=
b6016ab9d6cf71dd233f0328'
[   12.764000] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   12.764825] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db
[   12.765157] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db.p7s
[   12.779045] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   12.792705] r8169 0000:03:00.0: firmware: direct-loading firmware rtl_ni=
c/rtl8125a-3.fw
[   12.818019] RTL8226 2.5Gbps PHY r8169-0-300:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[   12.870548] usb 1-3: Found UVC 1.00 device HD Pro Webcam C920 (046d:082d)
[   12.872657] usbcore: registered new interface driver uvcvideo
[   13.018201] r8169 0000:03:00.0 enp3s0: Link is Down
[   13.046067] RTL8226 2.5Gbps PHY r8169-0-400:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[   13.059086] usbcore: registered new interface driver snd-usb-audio
[   13.246195] r8169 0000:04:00.0 enp4s0: Link is Down
[   13.247343] vdrbr0: port 1(enp8s0) entered blocking state
[   13.247352] vdrbr0: port 1(enp8s0) entered disabled state
[   13.247389] r8169 0000:08:00.0 enp8s0: entered allmulticast mode
[   13.247513] r8169 0000:08:00.0 enp8s0: entered promiscuous mode
[   13.248317] vdrbr0: port 2(enp9s0) entered blocking state
[   13.248324] vdrbr0: port 2(enp9s0) entered disabled state
[   13.248350] r8169 0000:09:00.0 enp9s0: entered allmulticast mode
[   13.248451] r8169 0000:09:00.0 enp9s0: entered promiscuous mode
[   13.469980] RTL8226 2.5Gbps PHY r8169-0-800:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-800:00, irq=3DMAC)
[   13.476924] RPC: Registered named UNIX socket transport module.
[   13.476925] RPC: Registered udp transport module.
[   13.476926] RPC: Registered tcp transport module.
[   13.476926] RPC: Registered tcp-with-tls transport module.
[   13.476926] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   13.690230] r8169 0000:08:00.0 enp8s0: Link is Down
[   13.690431] vdrbr0: port 1(enp8s0) entered blocking state
[   13.690438] vdrbr0: port 1(enp8s0) entered forwarding state
[   13.718095] RTL8226 2.5Gbps PHY r8169-0-900:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-900:00, irq=3DMAC)
[   13.930326] vdrbr0: port 2(enp9s0) entered blocking state
[   13.930338] vdrbr0: port 2(enp9s0) entered forwarding state
[   13.931344] r8169 0000:09:00.0 enp9s0: Link is Down
[   13.931383] vdrbr0: port 1(enp8s0) entered disabled state
[   13.931509] vdrbr0: port 2(enp9s0) entered disabled state
[   14.103894] msr: Write to unrecognized MSR 0x770 by x86_energy_perf (pid=
: 1123).
[   14.103898] msr: See https://git.kernel.org/pub/scm/linux/kernel/git/tip=
/tip.git/about for details.
[   14.410184] networkd-dispat[1095]: memfd_create() called without MFD_EXE=
C or MFD_NOEXEC_SEAL set
[   15.488457] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.519841] r8169 0000:04:00.0 enp4s0: Link is Down
[   15.554195] RTL8226 2.5Gbps PHY r8169-0-400:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[   15.746347] r8169 0000:04:00.0 enp4s0: Link is Down
[   15.828871] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.856227] r8169 0000:03:00.0 enp3s0: Link is Down
[   15.894168] RTL8226 2.5Gbps PHY r8169-0-300:00: attached PHY driver (mii=
_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[   16.098340] r8169 0000:03:00.0 enp3s0: Link is Down
[   16.284881] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: None
[   19.592594] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   19.899683] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   22.145832] NET: Registered PF_ALG protocol family
[   22.175648] alg: No test for xcbc(camellia) (xcbc(camellia-asm))
[   22.196634] alg: No test for rfc3686(ctr(camellia)) (rfc3686(ctr(camelli=
a-asm)))
[   22.203198] FS-Cache: Loaded
[   22.203951] Key type dns_resolver registered
[   22.250401] Key type cifs.spnego registered
[   22.250407] Key type cifs.idmap registered
[   22.311125] Initializing XFRM netlink socket
[   22.316412] IPsec XFRM device driver
[   22.396022] r8169 0000:03:00.0: invalid VPD tag 0x00 (size 0) at offset =
0; assume missing optional EEPROM
[   22.413083] r8169 0000:04:00.0: invalid VPD tag 0x00 (size 0) at offset =
0; assume missing optional EEPROM
[   22.442989] r8169 0000:08:00.0: invalid VPD tag 0x00 (size 0) at offset =
0; assume missing optional EEPROM
[   22.457711] Bridge firewalling registered
[   22.461072] r8169 0000:09:00.0: invalid VPD tag 0x00 (size 0) at offset =
0; assume missing optional EEPROM
[   23.528636] alg: No test for echainiv(authenc(hmac(sha256),cbc(aes))) (e=
chainiv(authenc(hmac(sha256-generic),cbc-aes-aesni)))
[   23.530700] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   68.037386] systemd-journald[746]: /var/log/journal/e150983afca344fc96c7=
51b8cfd263a1/user-1000.journal: Boot ID changed since last record, rotating.
[  132.990593] logitech-hidpp-device 0003:046D:4055.0009: HID++ 4.5 device =
connected.
[  171.840841] NET: Registered PF_VSOCK protocol family
[  171.920872] tun: Universal TUN/TAP device driver, 1.6
[  171.921231] virbr0: port 1(vnet0) entered blocking state
[  171.921233] virbr0: port 1(vnet0) entered disabled state
[  171.921241] vnet0: entered allmulticast mode
[  171.921305] vnet0: entered promiscuous mode
[  171.921435] virbr0: port 1(vnet0) entered blocking state
[  171.921438] virbr0: port 1(vnet0) entered listening state
[  173.949231] virbr0: port 1(vnet0) entered learning state
[  175.965182] virbr0: port 1(vnet0) entered forwarding state
[  175.965189] virbr0: topology change detected, propagating
[  216.677077] usb 1-1.1: USB disconnect, device number 4
[  217.952063] usb 1-1.1: new full-speed USB device number 15 using xhci_hcd
[  218.083710] usb 1-1.1: New USB device found, idVendor=3D1050, idProduct=
=3D0406, bcdDevice=3D 5.43
[  218.083714] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[  218.083714] usb 1-1.1: Product: YubiKey FIDO+CCID
[  218.083715] usb 1-1.1: Manufacturer: Yubico
[  218.102425] hid-generic 0003:1050:0406.000C: hiddev0,hidraw0: USB HID v1=
.10 Device [Yubico YubiKey FIDO+CCID] on usb-0000:00:14.0-1.1/input0
[ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
[ 1496.934060] usb 1-1.1: USB disconnect, device number 15
[ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[ 1512.295215] ------------[ cut here ]------------
[ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed out =
5368 ms
[ 1512.295227] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:525 dev_wa=
tchdog+0x232/0x240
[ 1512.295232] Modules linked in: mptcp_diag xsk_diag vsock_diag tcp_diag u=
dp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag tun vhost_=
vsock vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock snd_seq_dum=
my snd_hrtimer snd_seq xt_policy sha3_generic jitterentropy_rng drbg ansi_c=
prng authenc echainiv geniv crypto_null esp4 nf_conntrack_netlink xt_addrty=
pe br_netfilter xfrm_interface xfrm6_tunnel tunnel6 tunnel4 xfrm_user xfrm_=
algo xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 twofi=
sh_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_co=
mmon xt_tcpudp cmac nft_compat nls_utf8 serpent_avx2 serpent_avx_x86_64 cif=
s serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 blow=
fish_common cifs_arc4 cifs_md4 dns_resolver cast5_avx_x86_64 fscache cast5_=
generic cast_common netfs ctr ecb des_generic libdes algif_skcipher camelli=
a_generic camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 xcb=
c md4 algif_hash af_alg nvme_fabrics nft_fib_ipv6 nft_nat
[ 1512.295305]  nft_fib_ipv4 nft_fib overlay sunrpc binfmt_misc bridge stp =
llc cfg80211 nls_ascii nls_cp437 vfat fat rfkill intel_rapl_msr intel_rapl_=
common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel uvcvideo sn=
d_usb_audio videobuf2_vmalloc nft_masq uvc videobuf2_memops snd_usbmidi_lib=
 videobuf2_v4l2 kvm rtsx_usb_ms snd_hwdep memstick mei_pxp mei_hdcp mei_wdt=
 snd_rawmidi videodev snd_seq_device irqbypass snd_pcm intel_cstate intel_u=
ncore iTCO_wdt videobuf2_common think_lmi snd_timer intel_pmc_bxt intel_wmi=
_thunderbolt firmware_attributes_class iTCO_vendor_support wmi_bmof mc snd =
ftdi_sio mei_me watchdog ee1004 usbserial mei soundcore joydev int3400_ther=
mal intel_pmc_core acpi_thermal_rel acpi_pad acpi_tad button evdev nft_chai=
n_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables msr parpo=
rt_pc ppdev nfnetlink lp parport fuse loop efi_pstore configfs ip_tables x_=
tables autofs4 btrfs blake2b_generic hid_logitech_hidpp hid_logitech_dj rts=
x_usb_sdmmc mmc_core rtsx_usb hid_jabra dm_crypt dm_mod
[ 1512.295371]  efivarfs raid10 raid456 async_raid6_recov async_memcpy asyn=
c_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear=
 md_mod ext4 crc16 mbcache jbd2 crc32c_generic hid_generic usbhid hid i915 =
i2c_algo_bit drm_buddy ttm crc32_pclmul crc32c_intel drm_display_helper gha=
sh_clmulni_intel drm_kms_helper ahci sha512_ssse3 nvme libahci xhci_pci sha=
512_generic nvme_core libata xhci_hcd r8169 t10_pi drm aesni_intel crc64_ro=
cksoft_generic realtek scsi_mod e1000e crypto_simd mdio_devres crc64_rockso=
ft usbcore libphy cec cryptd crc_t10dif i2c_i801 crct10dif_generic rc_core =
crct10dif_pclmul i2c_smbus crc64 scsi_common usb_common crct10dif_common fa=
n video wmi
[ 1512.295429] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S                 6=
.5.0-1-amd64 #1  Debian 6.5.3-1
[ 1512.295431] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/25/2=
023
[ 1512.295432] RIP: 0010:dev_watchdog+0x232/0x240
[ 1512.295434] Code: ff ff ff 48 89 df c6 05 2e 7d 23 01 01 e8 06 33 fa ff =
45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 b8 a0 50 b5 e8 5e 8a 6e ff <0f=
> 0b e9 2d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[ 1512.295435] RSP: 0018:ffffbc024026ce70 EFLAGS: 00010286
[ 1512.295437] RAX: 0000000000000000 RBX: ffff997a697c4000 RCX: 00000000000=
00000
[ 1512.295438] RDX: 0000000000000104 RSI: 00000000000000f6 RDI: 00000000fff=
fffff
[ 1512.295439] RBP: ffff997a697c44c8 R08: 0000000000000000 R09: ffffbc02402=
6cd00
[ 1512.295440] R10: 0000000000000003 R11: ffffffffb5cd1f08 R12: ffff997a697=
ba200
[ 1512.295441] R13: ffff997a697c441c R14: 0000000000000000 R15: 00000000000=
014f8
[ 1512.295442] FS:  0000000000000000(0000) GS:ffff998935680000(0000) knlGS:=
0000000000000000
[ 1512.295443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1512.295444] CR2: 000055f150b12110 CR3: 0000000a93220004 CR4: 00000000007=
72ee0
[ 1512.295445] PKRU: 55555554
[ 1512.295446] Call Trace:
[ 1512.295447]  <IRQ>
[ 1512.295448]  ? dev_watchdog+0x232/0x240
[ 1512.295450]  ? __warn+0x81/0x130
[ 1512.295454]  ? dev_watchdog+0x232/0x240
[ 1512.295455]  ? report_bug+0x191/0x1c0
[ 1512.295457]  ? native_apic_msr_write+0x2b/0x40
[ 1512.295459]  ? handle_bug+0x3c/0x80
[ 1512.295462]  ? exc_invalid_op+0x17/0x70
[ 1512.295463]  ? asm_exc_invalid_op+0x1a/0x20
[ 1512.295467]  ? dev_watchdog+0x232/0x240
[ 1512.295468]  ? __pfx_dev_watchdog+0x10/0x10
[ 1512.295470]  call_timer_fn+0x24/0x130
[ 1512.295472]  ? __pfx_dev_watchdog+0x10/0x10
[ 1512.295474]  __run_timers+0x222/0x2c0
[ 1512.295476]  run_timer_softirq+0x2f/0x50
[ 1512.295477]  __do_softirq+0xf1/0x301
[ 1512.295480]  __irq_exit_rcu+0x83/0xf0
[ 1512.295482]  sysvec_apic_timer_interrupt+0xa2/0xd0
[ 1512.295484]  </IRQ>
[ 1512.295485]  <TASK>
[ 1512.295486]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1512.295488] RIP: 0010:cpuidle_enter_state+0xcc/0x440
[ 1512.295489] Code: ca 74 57 ff e8 b5 f0 ff ff 8b 53 04 49 89 c5 0f 1f 44 =
00 00 31 ff e8 c3 81 56 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
[ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 00000000000=
0001f
[ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ffffffffb54=
3bc32
[ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000=
00018
[ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ffffffffb5d=
981a0
[ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 00000000000=
00000
[ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
[ 1512.295499]  cpuidle_enter+0x2d/0x40
[ 1512.295501]  do_idle+0x217/0x270
[ 1512.295503]  cpu_startup_entry+0x1d/0x20
[ 1512.295505]  start_secondary+0x11a/0x140
[ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
[ 1512.295510]  </TASK>
[ 1512.295511] ---[ end trace 0000000000000000 ]---
[ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
[ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
[ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
[ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control

