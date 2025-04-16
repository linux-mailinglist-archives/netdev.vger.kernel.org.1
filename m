Return-Path: <netdev+bounces-183334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2527A90641
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B341747DD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B41946C8;
	Wed, 16 Apr 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="bfpjuiWG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EF156F20;
	Wed, 16 Apr 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813358; cv=none; b=g5qQnCgNpb5EefWKP+IQBPuLK+x3jAqH3JAQMEYDmmGiY9Mp0nSxDDIc5sEtmeRNRd+j0O0PYEJmrspCtfjS7fqUvqiLLcHPC7UabCmnX/Neox1anxg49KWNRL/KWiCG8Eoai1nZC+vUhDYCAPmWwccDuwuH8IdZZz9rUPtO/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813358; c=relaxed/simple;
	bh=8+GoWxq7yvEUmW4DxzjhxNNVZpipHBEKb7vgw++H6kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiGiFJa1tFtKXr3znFg+ZABrTaJewZHaM8trowgLAra44G2l9On7r+o/uudKdoHZ3CRwgdGlALQeCmWoP8tzSqp4mSnuVA0a4VTBNZfsa006u9STVmnCqN2RLdLLed7j0EMvrset/BwRKUcscr5Fqboq62v9q7DciFvhDzBOYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=bfpjuiWG; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1744813346; x=1745418146; i=christian@heusel.eu;
	bh=UYtkUs4BKES9Qqm9CMQgh+cRBPWhQPaybQ+iI7u08oI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bfpjuiWG/xWqtIkfDujgs3aSvEMK2r5dO/mYnIUqoeOMTpZ/NyAJAqK1XLTN/ppF
	 sA0zfxv/vDLeR0hTGAbvDnQ7ZZVsXXS6t74tKDExzjHEZ2Ge0S636kjL0RMZ0Rfeq
	 EbMT4HPZ9VIbIWI3giMOIJIoPcIlMmzwZVxcd7utVBwrxa2Iyys8nbumugpviGoKD
	 svB01+QfeGzAK64qEJMfWIfK8WNcLv+C0HRA7Q8hiW81x8By4qr583XbwXIBZmcmQ
	 IarYkHWOJVnprS8S7d/i/jsJXRTkqmT4no/klq3y5Q8CsGnolzmp5S7z14h57JM8E
	 CnkOxfTZnIrxWRRI3Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.65.171]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7sYM-1u05qd2lpC-00EI8x; Wed, 16 Apr 2025 16:22:26 +0200
Date: Wed, 16 Apr 2025 16:22:22 +0200
From: Christian Heusel <christian@heusel.eu>
To: ubomir Rintel <lkundrak@v3.sk>, Jakub Kicinski <kuba@kernel.org>
Cc: michal.pecio@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] USB tethering broken after 67d1a8956d2d
Message-ID: <fff4ac08-cab8-4b56-a4de-29de735d0942@heusel.eu>
References: <e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6w4gonr5mqqg4mr4"
Content-Disposition: inline
In-Reply-To: <e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu>
X-Provags-ID: V03:K1:j1ytyuts0XgdOgOwq0Sn33K2b6LMbHl9BjuldCzbFhS8yuCybvL
 0UYi0i7bweCbDJlLSZd73ajqwQ8zGIf3YK95BrNCaHwM3d706b7/tsZ0yzzz5O3H/7qBUOQ
 EEsEq7tRrR0j7/FujjCGgAWLyyuUvLlDigNJNCNaBLbXenUyBI43h35SItKq/oFqy1Ydd+D
 lKL+UKGhJI2SVdQ2q/Bpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6+UC9cj3ywk=;XUwKAjfMw6C9GcJD4iYSuZCeLVa
 86GtFk5hNa5ymyzpfSMShLjh+CZdO5CRPO0cvJ77v5yIeTjxCreItc8Qh5Cc43eORcosKMMPW
 iuQJ05bbL31u7LlfA4rFEb3HJAVx9I6FMr8SNJIr5rufLjKGhEvys+6tgzttfp1MQWFJ/bFd4
 4d6vb7qwQqz1VQRoirPj9LY59bCTOoWG81ezoQx8gq073MHyszyJIfOZphcS+XBDulDfLD6yJ
 LMMWT/dpH00KdpLqMOqA26pgfhVEWVPf6o9zT+ep1hEErhIL9Up3mkTx0JzpQmnkI7mzFhf09
 V9xpOWLXJcP/VipKali/OicsDrJ0Kzq9gaUtGdKa/aQmzcU9uQzIQPEyO6CG7H6ouC+zy2AvF
 96+vyMFdjR6GJ0ZpkmmnO7fFRdxoN0zkofXKZJCOS1vrjDHORViWXZTOduxG+T8d/PA6m+L7N
 A1QuOUOn1T0E/bvqBlF9BK6SpQOxv8jb36gAf30nHHWlUDmJiSFGMZ6nIHcwrXt6e04Wfqjnx
 x1tL+Namf760e2j8YmoEqefyUI/8Tuk7SgZGl16cr2VAQzLxawJmdKqGf0l2ihPg/ecjkiMxT
 fYaXe98UQTd0Wm40mSBI2I9WVoIM0V7YdgCA+lDHctiXBA/VzqZ0JWvbzHzpog+jjLR/KccIX
 urf0Tr2mVEm/OoGROJpeupCmtewCcHfVgKoFsamcarloJSx9bwu0GSO2rOZy56IUCfEg4R3n9
 8S8KR6B40DFXkMi2chvEqjnm21KjFSz8f3B5ct1C1SsAsf/ioVJqA8I3/ndvnQCyBjz5qtUh2
 SN0/dmvsz9GcUy9402ObighhvCq5Q+GWQEvQ4Ou5yJXbPpniizPvfQ/7U2KGY4Z7MeAOIpCMZ
 b0OpeDb89WCp3MK8aILtXmkHVFeBkUqD3PodsYeZ2p5kzAYgH3yM6LIwcRhQNas/Q91lrjJfG
 vzJvgnVjIguDfiwNWWM/vnNRVtag/ZBmcALpBaHHYnc0US7CsoCd2ZOI/H9citjn/bo+Oj4WS
 neIY5XUSGuc49gb4IdW/n6NlQ62HdvGiwnWFPmQVgQnq3aJysxGVKJb6HCGe0EI1aOdShpO2a
 ql05MdCuw6CzQpV7MteN70JHFsd4f3Oy3GdWweYPNkjn5psrm/vcYrQXI1ik5Yh88kGhaQLte
 XxccV6iaZy+sx17EnzHestIcUr9QLvYh8JL1AX8v959K7cZEmoiqdbhWynsWBP5CPhiD1j7Q4
 lfNztZ874JFe8MCwCBwGXINjyjBwytNpIsO8tEsMFzJKNLSx/nseClkqbTdBhbbyJc1y+Ldjr
 bFrm5/w38vu65BT1nG5Enp7+T7+KA0xKTlFDWJ+5q9oOY6vFwSr0Ug8CIJ4492Tq+7j+ko18K
 Kn4Qqx6ojvnQay6lT87lvlEX2OedwBfptNWnE=


--6w4gonr5mqqg4mr4
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="a5ukmz4hgjgovgad"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] USB tethering broken after 67d1a8956d2d
MIME-Version: 1.0


--a5ukmz4hgjgovgad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/04/16 04:15PM, Christian Heusel wrote:
> Hello everyone,
>=20
> I have recently noticed multiple issues popping up in the Arch Linux
> Support fora and in the Gentoo bugtracker (see links below) where people
> could not use USB tethering anymore after upgrading to 6.14.2.
>=20
> Micha=C5=82 Pecio on the Kernel Bugzilla eyeballed the issue within the
> mainline kernel tree to the following commit (that was backported to
> stable):
>=20
>     67d1a8956d2d ("rndis_host: Flag RNDIS modems as WWAN devices")
>=20
> The error is still present in the latest mainline release 6.15-rc2 and
> reverting the culprit on top of mainline fixes the issue.
>=20
> Also the issue (as stated above) is already reported on the Kernel
> Bugzilla but it seems like none of the actual developers has spotted it
> yet, hence I'm amplifying it to the mailing lists.
>=20
> I have attached a dmesg output from a good boot (6.15-rc2 with the patch
> reverted) and one from where the failure occurs (regular 6.15-rc2). I'm
> happy to test any debug patches or provide more information if needed.

=2E.. of course I forgot the attachment :p
Now added!

--a5ukmz4hgjgovgad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.15-rc2-1.1-GOOD.log"
Content-Transfer-Encoding: quoted-printable

Apr 16 15:55:34 meterpeter kernel: Linux version 6.15.0-rc2-1.1-mainline-di=
rty (linux-mainline@archlinux) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU Binu=
tils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed, 16 Apr 2025 11:48:34 +0000
Apr 16 15:55:34 meterpeter kernel: Command line: initrd=3D\initramfs-linux-=
mainline.img cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:arch=
linux root=3D/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D4 d=
rm.panic_screen=3Dqr_code
Apr 16 15:55:34 meterpeter kernel: BIOS-provided physical RAM map:
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000000000000-0x000=
000000009efff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x000000000009f000-0x000=
000000009ffff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000000e0000-0x000=
00000000fffff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000000100000-0x000=
0000009bfffff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000009c00000-0x000=
0000009da0fff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000009da1000-0x000=
0000009efffff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000009f00000-0x000=
0000009f0efff] ACPI NVS
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000009f0f000-0x000=
00000c4b7dfff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000c4b7e000-0x000=
00000cad7dfff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000cad7e000-0x000=
00000cc17dfff] ACPI NVS
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000cc17e000-0x000=
00000cc1fdfff] ACPI data
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000cc1fe000-0x000=
00000cdffffff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000ce000000-0x000=
00000cfffffff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000f8000000-0x000=
00000fbffffff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000fdc00000-0x000=
00000fdcfffff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000000fed80000-0x000=
00000fed80fff] reserved
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x0000000100000000-0x000=
00003ee2fffff] usable
Apr 16 15:55:34 meterpeter kernel: BIOS-e820: [mem 0x00000003ee300000-0x000=
000042fffffff] reserved
Apr 16 15:55:34 meterpeter kernel: NX (Execute Disable) protection: active
Apr 16 15:55:34 meterpeter kernel: APIC: Static calls initialized
Apr 16 15:55:34 meterpeter kernel: efi: EFI v2.7 by Lenovo
Apr 16 15:55:34 meterpeter kernel: efi: ACPI=3D0xcc1fd000 ACPI 2.0=3D0xcc1f=
d014 SMBIOS=3D0xc7c68000 SMBIOS 3.0=3D0xc7c5b000 TPMFinalLog=3D0xcb01e000 M=
EMATTR=3D0xc15bf018 ESRT=3D0xc3235518 RNG=3D0xcc1fcf18 INITRD=3D0x99b7bf98 =
TPMEventLog=3D0xcc1f1018=20
Apr 16 15:55:34 meterpeter kernel: random: crng init done
Apr 16 15:55:34 meterpeter kernel: efi: Remove mem62: MMIO range=3D[0xfdc00=
000-0xfdcfffff] (1MB) from e820 map
Apr 16 15:55:34 meterpeter kernel: e820: remove [mem 0xfdc00000-0xfdcfffff]=
 reserved
Apr 16 15:55:34 meterpeter kernel: efi: Not removing mem63: MMIO range=3D[0=
xfed80000-0xfed80fff] (4KB) from e820 map
Apr 16 15:55:34 meterpeter kernel: SMBIOS 3.3.0 present.
Apr 16 15:55:34 meterpeter kernel: DMI: LENOVO 20YDS00G00/20YDS00G00, BIOS =
R1OET26W (1.05 ) 04/28/2021
Apr 16 15:55:34 meterpeter kernel: DMI: Memory slots populated: 2/2
Apr 16 15:55:34 meterpeter kernel: tsc: Fast TSC calibration using PIT
Apr 16 15:55:34 meterpeter kernel: tsc: Detected 2095.984 MHz processor
Apr 16 15:55:34 meterpeter kernel: e820: update [mem 0x00000000-0x00000fff]=
 usable =3D=3D> reserved
Apr 16 15:55:34 meterpeter kernel: e820: remove [mem 0x000a0000-0x000fffff]=
 usable
Apr 16 15:55:34 meterpeter kernel: last_pfn =3D 0x3ee300 max_arch_pfn =3D 0=
x400000000
Apr 16 15:55:34 meterpeter kernel: MTRR map: 6 entries (3 fixed + 3 variabl=
e; max 20), built from 9 variable MTRRs
Apr 16 15:55:34 meterpeter kernel: x86/PAT: Configuration [0-7]: WB  WC  UC=
- UC  WB  WP  UC- WT =20
Apr 16 15:55:34 meterpeter kernel: last_pfn =3D 0xce000 max_arch_pfn =3D 0x=
400000000
Apr 16 15:55:34 meterpeter kernel: esrt: Reserving ESRT space from 0x000000=
00c3235518 to 0x00000000c32355c8.
Apr 16 15:55:34 meterpeter kernel: e820: update [mem 0xc3235000-0xc3235fff]=
 usable =3D=3D> reserved
Apr 16 15:55:34 meterpeter kernel: Using GB pages for direct mapping
Apr 16 15:55:34 meterpeter kernel: Secure boot disabled
Apr 16 15:55:34 meterpeter kernel: RAMDISK: [mem 0x91a28000-0x945d3fff]
Apr 16 15:55:34 meterpeter kernel: ACPI: Early table checksum verification =
disabled
Apr 16 15:55:34 meterpeter kernel: ACPI: RSDP 0x00000000CC1FD014 000024 (v0=
2 LENOVO)
Apr 16 15:55:34 meterpeter kernel: ACPI: XSDT 0x00000000CC1FB188 0000FC (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: FACP 0x00000000C5997000 000114 (v0=
6 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: DSDT 0x00000000C5982000 00F37E (v0=
1 LENOVO TP-R1O   00001050 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: FACS 0x00000000CB01A000 000040
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7C9B000 00094D (v0=
1 LENOVO UsbCTabl 00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7C8E000 007229 (v0=
2 LENOVO TP-R1O   00000002 MSFT 04000000)
Apr 16 15:55:34 meterpeter kernel: ACPI: IVRS 0x00000000C7C8D000 0001A4 (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7C3B000 000924 (v0=
1 LENOVO WmiTable 00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7BB6000 000632 (v0=
2 LENOVO Tpm2Tabl 00001000 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: TPM2 0x00000000C7BB5000 000034 (v0=
3 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: POAT 0x00000000C7BB2000 000055 (v0=
3 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: BATB 0x00000000C7B9D000 00004A (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: HPET 0x00000000C5996000 000038 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: APIC 0x00000000C5995000 000138 (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: MCFG 0x00000000C5994000 00003C (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: SBST 0x00000000C5993000 000030 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: WSMT 0x00000000C5992000 000028 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: VFCT 0x00000000C5974000 00D884 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C5970000 003E88 (v0=
2 LENOVO TP-R1O   00000001 AMD  00000001)
Apr 16 15:55:34 meterpeter kernel: ACPI: CRAT 0x00000000C596F000 000B80 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: CDIT 0x00000000C596E000 000029 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: FPDT 0x00000000C7B9E000 000034 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C596C000 000149 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C596A000 0014C3 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C5968000 0015A8 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C5964000 003979 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: BGRT 0x00000000C5963000 000038 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: UEFI 0x00000000CB019000 0000B2 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7C9A000 000090 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: SSDT 0x00000000C7C99000 0009BD (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving FACP table memory at [me=
m 0xc5997000-0xc5997113]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving DSDT table memory at [me=
m 0xc5982000-0xc599137d]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving FACS table memory at [me=
m 0xcb01a000-0xcb01a03f]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c9b000-0xc7c9b94c]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c8e000-0xc7c95228]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving IVRS table memory at [me=
m 0xc7c8d000-0xc7c8d1a3]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c3b000-0xc7c3b923]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7bb6000-0xc7bb6631]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving TPM2 table memory at [me=
m 0xc7bb5000-0xc7bb5033]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving POAT table memory at [me=
m 0xc7bb2000-0xc7bb2054]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving BATB table memory at [me=
m 0xc7b9d000-0xc7b9d049]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving HPET table memory at [me=
m 0xc5996000-0xc5996037]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving APIC table memory at [me=
m 0xc5995000-0xc5995137]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving MCFG table memory at [me=
m 0xc5994000-0xc599403b]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SBST table memory at [me=
m 0xc5993000-0xc599302f]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving WSMT table memory at [me=
m 0xc5992000-0xc5992027]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving VFCT table memory at [me=
m 0xc5974000-0xc5981883]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5970000-0xc5973e87]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving CRAT table memory at [me=
m 0xc596f000-0xc596fb7f]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving CDIT table memory at [me=
m 0xc596e000-0xc596e028]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving FPDT table memory at [me=
m 0xc7b9e000-0xc7b9e033]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc596c000-0xc596c148]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc596a000-0xc596b4c2]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5968000-0xc59695a7]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5964000-0xc5967978]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving BGRT table memory at [me=
m 0xc5963000-0xc5963037]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving UEFI table memory at [me=
m 0xcb019000-0xcb0190b1]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c9a000-0xc7c9a08f]
Apr 16 15:55:34 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c99000-0xc7c999bc]
Apr 16 15:55:34 meterpeter kernel: No NUMA configuration found
Apr 16 15:55:34 meterpeter kernel: Faking a node at [mem 0x0000000000000000=
-0x00000003ee2fffff]
Apr 16 15:55:34 meterpeter kernel: NODE_DATA(0) allocated [mem 0x3ee2d5280-=
0x3ee2fffff]
Apr 16 15:55:34 meterpeter kernel: Zone ranges:
Apr 16 15:55:34 meterpeter kernel:   DMA      [mem 0x0000000000001000-0x000=
0000000ffffff]
Apr 16 15:55:34 meterpeter kernel:   DMA32    [mem 0x0000000001000000-0x000=
00000ffffffff]
Apr 16 15:55:34 meterpeter kernel:   Normal   [mem 0x0000000100000000-0x000=
00003ee2fffff]
Apr 16 15:55:34 meterpeter kernel:   Device   empty
Apr 16 15:55:34 meterpeter kernel: Movable zone start for each node
Apr 16 15:55:34 meterpeter kernel: Early memory node ranges
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x0000000000001000-0x00=
0000000009efff]
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x0000000000100000-0x00=
00000009bfffff]
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x0000000009da1000-0x00=
00000009efffff]
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x0000000009f0f000-0x00=
000000c4b7dfff]
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x00000000cc1fe000-0x00=
000000cdffffff]
Apr 16 15:55:34 meterpeter kernel:   node   0: [mem 0x0000000100000000-0x00=
000003ee2fffff]
Apr 16 15:55:34 meterpeter kernel: Initmem setup node 0 [mem 0x000000000000=
1000-0x00000003ee2fffff]
Apr 16 15:55:34 meterpeter kernel: On node 0, zone DMA: 1 pages in unavaila=
ble ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone DMA: 97 pages in unavail=
able ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone DMA32: 417 pages in unav=
ailable ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone DMA32: 15 pages in unava=
ilable ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone DMA32: 30336 pages in un=
available ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone Normal: 8192 pages in un=
available ranges
Apr 16 15:55:34 meterpeter kernel: On node 0, zone Normal: 7424 pages in un=
available ranges
Apr 16 15:55:34 meterpeter kernel: ACPI: PM-Timer IO Port: 0x408
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x08] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x09] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0a] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0b] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0c] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0d] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0e] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0f] high edge=
 lint[0x1])
Apr 16 15:55:34 meterpeter kernel: IOAPIC[0]: apic_id 32, version 33, addre=
ss 0xfec00000, GSI 0-23
Apr 16 15:55:34 meterpeter kernel: IOAPIC[1]: apic_id 33, version 33, addre=
ss 0xfec01000, GSI 24-55
Apr 16 15:55:34 meterpeter kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 globa=
l_irq 2 dfl dfl)
Apr 16 15:55:34 meterpeter kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 globa=
l_irq 9 low level)
Apr 16 15:55:34 meterpeter kernel: ACPI: Using ACPI (MADT) for SMP configur=
ation information
Apr 16 15:55:34 meterpeter kernel: ACPI: HPET id: 0x43538210 base: 0xfed000=
00
Apr 16 15:55:34 meterpeter kernel: e820: update [mem 0xc0cdc000-0xc0d6cfff]=
 usable =3D=3D> reserved
Apr 16 15:55:34 meterpeter kernel: CPU topo: Max. logical packages:   1
Apr 16 15:55:34 meterpeter kernel: CPU topo: Max. logical dies:       1
Apr 16 15:55:34 meterpeter kernel: CPU topo: Max. dies per package:   1
Apr 16 15:55:34 meterpeter kernel: CPU topo: Max. threads per core:   2
Apr 16 15:55:34 meterpeter kernel: CPU topo: Num. cores per package:     6
Apr 16 15:55:34 meterpeter kernel: CPU topo: Num. threads per package:  12
Apr 16 15:55:34 meterpeter kernel: CPU topo: Allowing 12 present CPUs plus =
0 hotplug CPUs
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x00000000-0x00000fff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x0009f000-0x000fffff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x09c00000-0x09da0fff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x09f00000-0x09f0efff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc0cdc000-0xc0d6cfff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc3235000-0xc3235fff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc4b7e000-0xcc1fdfff]
Apr 16 15:55:34 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xce000000-0xffffffff]
Apr 16 15:55:34 meterpeter kernel: [mem 0xd0000000-0xf7ffffff] available fo=
r PCI devices
Apr 16 15:55:34 meterpeter kernel: Booting paravirtualized kernel on bare h=
ardware
Apr 16 15:55:34 meterpeter kernel: clocksource: refined-jiffies: mask: 0xff=
ffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Apr 16 15:55:34 meterpeter kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bi=
ts:12 nr_cpu_ids:12 nr_node_ids:1
Apr 16 15:55:34 meterpeter kernel: percpu: Embedded 62 pages/cpu s217088 r8=
192 d28672 u262144
Apr 16 15:55:34 meterpeter kernel: pcpu-alloc: s217088 r8192 d28672 u262144=
 alloc=3D1*2097152
Apr 16 15:55:34 meterpeter kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 =
[0] 08 09 10 11 -- -- -- --=20
Apr 16 15:55:34 meterpeter kernel: Kernel command line: initrd=3D\initramfs=
-linux-mainline.img cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec73115=
4b:archlinux root=3D/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw logleve=
l=3D4 drm.panic_screen=3Dqr_code
Apr 16 15:55:34 meterpeter kernel: Unknown kernel command line parameters "=
cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux", will =
be passed to user space.
Apr 16 15:55:34 meterpeter kernel: printk: log buffer data + meta data: 131=
072 + 458752 =3D 589824 bytes
Apr 16 15:55:34 meterpeter kernel: Dentry cache hash table entries: 2097152=
 (order: 12, 16777216 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: Inode-cache hash table entries: 1048576 =
(order: 11, 8388608 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: software IO TLB: area num 16.
Apr 16 15:55:34 meterpeter kernel: Fallback order for Node 0: 0=20
Apr 16 15:55:34 meterpeter kernel: Built 1 zonelists, mobility grouping on.=
  Total pages: 3885678
Apr 16 15:55:34 meterpeter kernel: Policy zone: Normal
Apr 16 15:55:34 meterpeter kernel: mem auto-init: stack:all(zero), heap all=
oc:on, heap free:off
Apr 16 15:55:34 meterpeter kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObje=
cts=3D0, CPUs=3D12, Nodes=3D1
Apr 16 15:55:34 meterpeter kernel: ftrace: allocating 55202 entries in 216 =
pages
Apr 16 15:55:34 meterpeter kernel: ftrace: allocated 216 pages with 4 groups
Apr 16 15:55:34 meterpeter kernel: Dynamic Preempt: full
Apr 16 15:55:34 meterpeter kernel: rcu: Preemptible hierarchical RCU implem=
entation.
Apr 16 15:55:34 meterpeter kernel: rcu:         RCU restricting CPUs from N=
R_CPUS=3D8192 to nr_cpu_ids=3D12.
Apr 16 15:55:34 meterpeter kernel: rcu:         RCU priority boosting: prio=
rity 1 delay 500 ms.
Apr 16 15:55:34 meterpeter kernel:         Trampoline variant of Tasks RCU =
enabled.
Apr 16 15:55:34 meterpeter kernel:         Rude variant of Tasks RCU enable=
d.
Apr 16 15:55:34 meterpeter kernel:         Tracing variant of Tasks RCU ena=
bled.
Apr 16 15:55:34 meterpeter kernel: rcu: RCU calculated value of scheduler-e=
nlistment delay is 100 jiffies.
Apr 16 15:55:34 meterpeter kernel: rcu: Adjusting geometry for rcu_fanout_l=
eaf=3D16, nr_cpu_ids=3D12
Apr 16 15:55:34 meterpeter kernel: RCU Tasks: Setting shift to 4 and lim to=
 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:55:34 meterpeter kernel: RCU Tasks Rude: Setting shift to 4 and l=
im to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:55:34 meterpeter kernel: RCU Tasks Trace: Setting shift to 4 and =
lim to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:55:34 meterpeter kernel: NR_IRQS: 524544, nr_irqs: 1064, prealloc=
ated irqs: 16
Apr 16 15:55:34 meterpeter kernel: rcu: srcu_init: Setting srcu_struct size=
s based on contention.
Apr 16 15:55:34 meterpeter kernel: kfence: initialized - using 2097152 byte=
s for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Apr 16 15:55:34 meterpeter kernel: Console: colour dummy device 80x25
Apr 16 15:55:34 meterpeter kernel: printk: legacy console [tty0] enabled
Apr 16 15:55:34 meterpeter kernel: ACPI: Core revision 20240827
Apr 16 15:55:34 meterpeter kernel: clocksource: hpet: mask: 0xffffffff max_=
cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Apr 16 15:55:34 meterpeter kernel: APIC: Switch to symmetric I/O mode setup
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR0, rdevid:0xa0
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR1, rdevid:0xa0
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR2, rdevid:0xa0
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR3, rdevid:0xa0
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: Using global IVHD EFR:0x206d73ef=
22254ade, EFR2:0x0
Apr 16 15:55:34 meterpeter kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D=
2 apic2=3D-1 pin2=3D-1
Apr 16 15:55:34 meterpeter kernel: clocksource: tsc-early: mask: 0xffffffff=
ffffffff max_cycles: 0x1e365ec32fc, max_idle_ns: 440795244491 ns
Apr 16 15:55:34 meterpeter kernel: Calibrating delay loop (skipped), value =
calculated using timer frequency.. 4191.96 BogoMIPS (lpj=3D2095984)
Apr 16 15:55:34 meterpeter kernel: x86/cpu: User Mode Instruction Preventio=
n (UMIP) activated
Apr 16 15:55:34 meterpeter kernel: LVT offset 1 assigned for vector 0xf9
Apr 16 15:55:34 meterpeter kernel: LVT offset 2 assigned for vector 0xf4
Apr 16 15:55:34 meterpeter kernel: Last level iTLB entries: 4KB 1024, 2MB 1=
024, 4MB 512
Apr 16 15:55:34 meterpeter kernel: Last level dTLB entries: 4KB 2048, 2MB 2=
048, 4MB 1024, 1GB 0
Apr 16 15:55:34 meterpeter kernel: process: using mwait in idle threads
Apr 16 15:55:34 meterpeter kernel: Spectre V1 : Mitigation: usercopy/swapgs=
 barriers and __user pointer sanitization
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : Mitigation: Retpolines
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : Spectre v2 / SpectreRSB: Fi=
lling RSB on context switch and VMEXIT
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : Enabling Speculation Barrie=
r for firmware calls
Apr 16 15:55:34 meterpeter kernel: RETBleed: Mitigation: untrained return t=
hunk
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : mitigation: Enabling condit=
ional Indirect Branch Prediction Barrier
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : Selecting STIBP always-on m=
ode to complement retbleed mitigation
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : User space: Mitigation: STI=
BP always-on protection
Apr 16 15:55:34 meterpeter kernel: Speculative Store Bypass: Mitigation: Sp=
eculative Store Bypass disabled via prctl
Apr 16 15:55:34 meterpeter kernel: Speculative Return Stack Overflow: Mitig=
ation: Safe RET
Apr 16 15:55:34 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x001:=
 'x87 floating point registers'
Apr 16 15:55:34 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x002:=
 'SSE registers'
Apr 16 15:55:34 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x004:=
 'AVX registers'
Apr 16 15:55:34 meterpeter kernel: x86/fpu: xstate_offset[2]:  576, xstate_=
sizes[2]:  256
Apr 16 15:55:34 meterpeter kernel: x86/fpu: Enabled xstate features 0x7, co=
ntext size is 832 bytes, using 'compacted' format.
Apr 16 15:55:34 meterpeter kernel: Freeing SMP alternatives memory: 52K
Apr 16 15:55:34 meterpeter kernel: pid_max: default: 32768 minimum: 301
Apr 16 15:55:34 meterpeter kernel: LSM: initializing lsm=3Dcapability,landl=
ock,lockdown,yama,bpf
Apr 16 15:55:34 meterpeter kernel: landlock: Up and running.
Apr 16 15:55:34 meterpeter kernel: Yama: becoming mindful.
Apr 16 15:55:34 meterpeter kernel: LSM support for eBPF active
Apr 16 15:55:34 meterpeter kernel: Mount-cache hash table entries: 32768 (o=
rder: 6, 262144 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: Mountpoint-cache hash table entries: 327=
68 (order: 6, 262144 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: smpboot: CPU0: AMD Ryzen 5 5500U with Ra=
deon Graphics (family: 0x17, model: 0x68, stepping: 0x1)
Apr 16 15:55:34 meterpeter kernel: Performance Events: Fam17h+ core perfctr=
, AMD PMU driver.
Apr 16 15:55:34 meterpeter kernel: ... version:                0
Apr 16 15:55:34 meterpeter kernel: ... bit width:              48
Apr 16 15:55:34 meterpeter kernel: ... generic registers:      6
Apr 16 15:55:34 meterpeter kernel: ... value mask:             0000ffffffff=
ffff
Apr 16 15:55:34 meterpeter kernel: ... max period:             00007fffffff=
ffff
Apr 16 15:55:34 meterpeter kernel: ... fixed-purpose events:   0
Apr 16 15:55:34 meterpeter kernel: ... event mask:             000000000000=
003f
Apr 16 15:55:34 meterpeter kernel: signal: max sigframe size: 1776
Apr 16 15:55:34 meterpeter kernel: rcu: Hierarchical SRCU implementation.
Apr 16 15:55:34 meterpeter kernel: rcu:         Max phase no-delay instance=
s is 400.
Apr 16 15:55:34 meterpeter kernel: Timer migration: 2 hierarchy levels; 8 c=
hildren per group; 2 crossnode level
Apr 16 15:55:34 meterpeter kernel: MCE: In-kernel MCE decoding enabled.
Apr 16 15:55:34 meterpeter kernel: NMI watchdog: Enabled. Permanently consu=
mes one hw-PMU counter.
Apr 16 15:55:34 meterpeter kernel: smp: Bringing up secondary CPUs ...
Apr 16 15:55:34 meterpeter kernel: smpboot: x86: Booting SMP configuration:
Apr 16 15:55:34 meterpeter kernel: .... node  #0, CPUs:        #2  #4  #6  =
#8 #10  #1  #3  #5  #7  #9 #11
Apr 16 15:55:34 meterpeter kernel: Spectre V2 : Update user space SMT mitig=
ation: STIBP always-on
Apr 16 15:55:34 meterpeter kernel: smp: Brought up 1 node, 12 CPUs
Apr 16 15:55:34 meterpeter kernel: smpboot: Total of 12 processors activate=
d (50303.61 BogoMIPS)
Apr 16 15:55:34 meterpeter kernel: Memory: 15076760K/15542712K available (1=
9381K kernel code, 2931K rwdata, 16404K rodata, 4552K init, 4860K bss, 4456=
36K reserved, 0K cma-reserved)
Apr 16 15:55:34 meterpeter kernel: devtmpfs: initialized
Apr 16 15:55:34 meterpeter kernel: x86/mm: Memory block size: 128MB
Apr 16 15:55:34 meterpeter kernel: ACPI: PM: Registering ACPI NVS region [m=
em 0x09f00000-0x09f0efff] (61440 bytes)
Apr 16 15:55:34 meterpeter kernel: ACPI: PM: Registering ACPI NVS region [m=
em 0xcad7e000-0xcc17dfff] (20971520 bytes)
Apr 16 15:55:34 meterpeter kernel: clocksource: jiffies: mask: 0xffffffff m=
ax_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Apr 16 15:55:34 meterpeter kernel: posixtimers hash table entries: 8192 (or=
der: 5, 131072 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: futex hash table entries: 4096 (order: 6=
, 262144 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: pinctrl core: initialized pinctrl subsys=
tem
Apr 16 15:55:34 meterpeter kernel: PM: RTC time: 13:55:17, date: 2025-04-16
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_NETLINK/PF_ROUTE prot=
ocol family
Apr 16 15:55:34 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL po=
ol for atomic allocations
Apr 16 15:55:34 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GF=
P_DMA pool for atomic allocations
Apr 16 15:55:34 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GF=
P_DMA32 pool for atomic allocations
Apr 16 15:55:34 meterpeter kernel: audit: initializing netlink subsys (disa=
bled)
Apr 16 15:55:34 meterpeter kernel: audit: type=3D2000 audit(1744811717.172:=
1): state=3Dinitialized audit_enabled=3D0 res=3D1
Apr 16 15:55:34 meterpeter kernel: thermal_sys: Registered thermal governor=
 'fair_share'
Apr 16 15:55:34 meterpeter kernel: thermal_sys: Registered thermal governor=
 'bang_bang'
Apr 16 15:55:34 meterpeter kernel: thermal_sys: Registered thermal governor=
 'step_wise'
Apr 16 15:55:34 meterpeter kernel: thermal_sys: Registered thermal governor=
 'user_space'
Apr 16 15:55:34 meterpeter kernel: thermal_sys: Registered thermal governor=
 'power_allocator'
Apr 16 15:55:34 meterpeter kernel: cpuidle: using governor ladder
Apr 16 15:55:34 meterpeter kernel: cpuidle: using governor menu
Apr 16 15:55:34 meterpeter kernel: ACPI FADT declares the system doesn't su=
pport PCIe ASPM, so disable it
Apr 16 15:55:34 meterpeter kernel: acpiphp: ACPI Hot Plug PCI Controller Dr=
iver version: 0.5
Apr 16 15:55:34 meterpeter kernel: PCI: ECAM [mem 0xf8000000-0xfbffffff] (b=
ase 0xf8000000) for domain 0000 [bus 00-3f]
Apr 16 15:55:34 meterpeter kernel: PCI: Using configuration type 1 for base=
 access
Apr 16 15:55:34 meterpeter kernel: kprobes: kprobe jump-optimization is ena=
bled. All kprobes are optimized if possible.
Apr 16 15:55:34 meterpeter kernel: HugeTLB: allocation took 0ms with hugepa=
ge_allocation_threads=3D3
Apr 16 15:55:34 meterpeter kernel: HugeTLB: registered 1.00 GiB page size, =
pre-allocated 0 pages
Apr 16 15:55:34 meterpeter kernel: HugeTLB: 16380 KiB vmemmap can be freed =
for a 1.00 GiB page
Apr 16 15:55:34 meterpeter kernel: HugeTLB: registered 2.00 MiB page size, =
pre-allocated 0 pages
Apr 16 15:55:34 meterpeter kernel: HugeTLB: 28 KiB vmemmap can be freed for=
 a 2.00 MiB page
Apr 16 15:55:34 meterpeter kernel: raid6: skipped pq benchmark and selected=
 avx2x4
Apr 16 15:55:34 meterpeter kernel: raid6: using avx2x2 recovery algorithm
Apr 16 15:55:34 meterpeter kernel: ACPI: Added _OSI(Module Device)
Apr 16 15:55:34 meterpeter kernel: ACPI: Added _OSI(Processor Device)
Apr 16 15:55:34 meterpeter kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Apr 16 15:55:34 meterpeter kernel: ACPI: Added _OSI(Processor Aggregator De=
vice)
Apr 16 15:55:34 meterpeter kernel: ACPI: 12 ACPI AML tables successfully ac=
quired and loaded
Apr 16 15:55:34 meterpeter kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) q=
uery ignored
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: EC started
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: interrupt blocked
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=
=3D0x62
Apr 16 15:55:34 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC=
 used to handle transactions
Apr 16 15:55:34 meterpeter kernel: ACPI: Interpreter enabled
Apr 16 15:55:34 meterpeter kernel: ACPI: PM: (supports S0 S3 S4 S5)
Apr 16 15:55:34 meterpeter kernel: ACPI: Using IOAPIC for interrupt routing
Apr 16 15:55:34 meterpeter kernel: PCI: Using host bridge windows from ACPI=
; if necessary, use "pci=3Dnocrs" and report a bug
Apr 16 15:55:34 meterpeter kernel: PCI: Using E820 reservations for host br=
idge windows
Apr 16 15:55:34 meterpeter kernel: ACPI: \_SB_.PCI0.GPP5.PXSX.WRST: New pow=
er resource
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI Root Bridge [PCI0] (domain 000=
0 [bus 00-ff])
Apr 16 15:55:34 meterpeter kernel: acpi PNP0A08:00: _OSC: OS supports [Exte=
ndedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Apr 16 15:55:34 meterpeter kernel: acpi PNP0A08:00: _OSC: platform does not=
 support [SHPCHotplug LTR DPC]
Apr 16 15:55:34 meterpeter kernel: acpi PNP0A08:00: _OSC: OS now controls [=
PCIeHotplug PME AER PCIeCapability]
Apr 16 15:55:34 meterpeter kernel: acpi PNP0A08:00: FADT indicates ASPM is =
unsupported, using BIOS configuration
Apr 16 15:55:34 meterpeter kernel: acpi PNP0A08:00: [Firmware Info]: ECAM [=
mem 0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially cover=
s this bridge
Apr 16 15:55:34 meterpeter kernel: PCI host bridge to bus 0000:00
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000effff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0xd0000000-0xf7ffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0xfc000000-0xfdffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0x430000000-0xffffffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [io  =
0x0000-0x0cf7 window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [io  =
0x0d00-0xffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: root bus resource [bus =
00-ff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:00.0: [1022:1630] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:00.2: [1022:1631] type 00 cl=
ass 0x080600 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:01.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1:   bridge window [mem 0=
xfd600000-0xfd6fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2:   bridge window [io  0=
x3000-0x3fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2:   bridge window [mem 0=
xfd500000-0xfd5fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3:   bridge window [io  0=
x2000-0x2fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
xfd400000-0xfd4fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: [1022:1635] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [io  0=
x1000-0x1fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
xfd000000-0xfd3fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
x460000000-0x4701fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:14.0: [1022:790b] type 00 cl=
ass 0x0c0500 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:14.3: [1022:790e] type 00 cl=
ass 0x060100 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.0: [1022:1448] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.1: [1022:1449] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.2: [1022:144a] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.3: [1022:144b] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.4: [1022:144c] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.5: [1022:144d] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.6: [1022:144e] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.7: [1022:144f] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:01:00.0: [144d:a809] type 00 cl=
ass 0x010802 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:01:00.0: BAR 0 [mem 0xfd600000-=
0xfd603fff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: [10ec:8168] type 00 cl=
ass 0x020000 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: BAR 0 [io  0x3000-0x30=
ff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: BAR 2 [mem 0xfd504000-=
0xfd504fff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: BAR 4 [mem 0xfd500000-=
0xfd503fff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: supports D1 D2
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: PME# supported from D0=
 D1 D2 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: [10ec:c822] type 00 cl=
ass 0x028000 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: BAR 0 [io  0x2000-0x20=
ff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: BAR 2 [mem 0xfd400000-=
0xfd40ffff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: supports D1 D2
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: PME# supported from D0=
 D1 D2 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: [1002:164c] type 00 cl=
ass 0x030000 PCIe Legacy Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: BAR 0 [mem 0x460000000=
-0x46fffffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: BAR 2 [mem 0x470000000=
-0x4701fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: BAR 4 [io  0x1000-0x10=
ff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: BAR 5 [mem 0xfd300000-=
0xfd37ffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: PME# supported from D1=
 D2 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: [1002:1637] type 00 cl=
ass 0x040300 PCIe Legacy Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: BAR 0 [mem 0xfd3c8000-=
0xfd3cbfff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: PME# supported from D1=
 D2 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.2: [1022:15df] type 00 cl=
ass 0x108000 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.2: BAR 2 [mem 0xfd200000-=
0xfd2fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.2: BAR 5 [mem 0xfd3cc000-=
0xfd3cdfff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.2: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: [1022:1639] type 00 cl=
ass 0x0c0330 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: BAR 0 [mem 0xfd000000-=
0xfd0fffff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: [1022:1639] type 00 cl=
ass 0x0c0330 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: BAR 0 [mem 0xfd100000-=
0xfd1fffff 64bit]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.5: [1022:15e2] type 00 cl=
ass 0x048000 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.5: BAR 0 [mem 0xfd380000-=
0xfd3bffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.5: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.5: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.6: [1022:15e3] type 00 cl=
ass 0x040300 PCIe Endpoint
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.6: BAR 0 [mem 0xfd3c0000-=
0xfd3c7fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.6: enabling Extended Tags
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.6: PME# supported from D0=
 D3hot D3cold
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKA configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKB configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKC configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKD configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKE configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKF configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKG configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: PCI: Interrupt link LNKH configure=
d for IRQ 0
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: interrupt unblocked
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: event unblocked
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=
=3D0x62
Apr 16 15:55:34 meterpeter kernel: ACPI: EC: GPE=3D0x3
Apr 16 15:55:34 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC=
 initialization complete
Apr 16 15:55:34 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to =
handle transactions and events
Apr 16 15:55:34 meterpeter kernel: iommu: Default domain type: Translated
Apr 16 15:55:34 meterpeter kernel: iommu: DMA domain TLB invalidation polic=
y: lazy mode
Apr 16 15:55:34 meterpeter kernel: SCSI subsystem initialized
Apr 16 15:55:34 meterpeter kernel: libata version 3.00 loaded.
Apr 16 15:55:34 meterpeter kernel: ACPI: bus type USB registered
Apr 16 15:55:34 meterpeter kernel: usbcore: registered new interface driver=
 usbfs
Apr 16 15:55:34 meterpeter kernel: usbcore: registered new interface driver=
 hub
Apr 16 15:55:34 meterpeter kernel: usbcore: registered new device driver usb
Apr 16 15:55:34 meterpeter kernel: EDAC MC: Ver: 3.0.0
Apr 16 15:55:34 meterpeter kernel: efivars: Registered efivars operations
Apr 16 15:55:34 meterpeter kernel: NetLabel: Initializing
Apr 16 15:55:34 meterpeter kernel: NetLabel:  domain hash size =3D 128
Apr 16 15:55:34 meterpeter kernel: NetLabel:  protocols =3D UNLABELED CIPSO=
v4 CALIPSO
Apr 16 15:55:34 meterpeter kernel: NetLabel:  unlabeled traffic allowed by =
default
Apr 16 15:55:34 meterpeter kernel: mctp: management component transport pro=
tocol core
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_MCTP protocol family
Apr 16 15:55:34 meterpeter kernel: PCI: Using ACPI for IRQ routing
Apr 16 15:55:34 meterpeter kernel: PCI: pci_cache_line_size set to 64 bytes
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0x0009f000=
-0x0009ffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0x09c00000=
-0x0bffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0x09f00000=
-0x0bffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0xc0cdc000=
-0xc3ffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0xc3235000=
-0xc3ffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0xc4b7e000=
-0xc7ffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0xce000000=
-0xcfffffff]
Apr 16 15:55:34 meterpeter kernel: e820: reserve RAM buffer [mem 0x3ee30000=
0-0x3efffffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: vgaarb: setting as boo=
t VGA device
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: vgaarb: bridge control=
 possible
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: vgaarb: VGA device add=
ed: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
Apr 16 15:55:34 meterpeter kernel: vgaarb: loaded
Apr 16 15:55:34 meterpeter kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Apr 16 15:55:34 meterpeter kernel: hpet0: 3 comparators, 32-bit 14.318180 M=
Hz counter
Apr 16 15:55:34 meterpeter kernel: clocksource: Switched to clocksource tsc=
-early
Apr 16 15:55:34 meterpeter kernel: VFS: Disk quotas dquot_6.6.0
Apr 16 15:55:34 meterpeter kernel: VFS: Dquot-cache hash table entries: 512=
 (order 0, 4096 bytes)
Apr 16 15:55:34 meterpeter kernel: pnp: PnP ACPI init
Apr 16 15:55:34 meterpeter kernel: system 00:00: [mem 0xfec00000-0xfec01fff=
] could not be reserved
Apr 16 15:55:34 meterpeter kernel: system 00:00: [mem 0xfee00000-0xfee00fff=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: system 00:00: [mem 0xf8000000-0xfbffffff=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0400-0x04cf] has be=
en reserved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x04d0-0x04d1] has be=
en reserved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x04d6] has been rese=
rved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0c00-0x0c01] has be=
en reserved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0c14] has been rese=
rved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0c50-0x0c52] has be=
en reserved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0c6c] has been rese=
rved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0c6f] has been rese=
rved
Apr 16 15:55:34 meterpeter kernel: system 00:02: [io  0x0cd0-0x0cdb] has be=
en reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0x000e0000-0x000fffff=
] could not be reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0x00000000-0x01ffffff=
] could not be reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0xfec10000-0xfec1001f=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0xfed00000-0xfed003ff=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0xfed61000-0xfed613ff=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: system 00:03: [mem 0xfed80000-0xfed80fff=
] has been reserved
Apr 16 15:55:34 meterpeter kernel: pnp: PnP ACPI: found 6 devices
Apr 16 15:55:34 meterpeter kernel: clocksource: acpi_pm: mask: 0xffffff max=
_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_INET protocol family
Apr 16 15:55:34 meterpeter kernel: IP idents hash table entries: 262144 (or=
der: 9, 2097152 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: tcp_listen_portaddr_hash hash table entr=
ies: 8192 (order: 5, 131072 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: Table-perturb hash table entries: 65536 =
(order: 6, 262144 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: TCP established hash table entries: 1310=
72 (order: 8, 1048576 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: TCP bind hash table entries: 65536 (orde=
r: 9, 2097152 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: TCP: Hash tables configured (established=
 131072 bind 65536)
Apr 16 15:55:34 meterpeter kernel: MPTCP token hash table entries: 16384 (o=
rder: 6, 393216 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: UDP hash table entries: 8192 (order: 7, =
524288 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: UDP-Lite hash table entries: 8192 (order=
: 7, 524288 bytes, linear)
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_UNIX/PF_LOCAL protoco=
l family
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_XDP protocol family
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: bridge window [mem 0x0=
0100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: bridge window [mem 0x4=
30000000-0x4301fffff 64bit pref]: assigned
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1:   bridge window [mem 0=
xfd600000-0xfd6fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2:   bridge window [io  0=
x3000-0x3fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2:   bridge window [mem 0=
xfd500000-0xfd5fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3:   bridge window [io  0=
x2000-0x2fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
xfd400000-0xfd4fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
x430000000-0x4301fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [io  0=
x1000-0x1fff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
xfd000000-0xfd3fffff]
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
x460000000-0x4701fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 4 [mem 0x000a0=
000-0x000effff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 5 [mem 0xd0000=
000-0xf7ffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 6 [mem 0xfc000=
000-0xfdffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 7 [mem 0x43000=
0000-0xffffffffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 8 [io  0x0000-=
0x0cf7 window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:00: resource 9 [io  0x0d00-=
0xffff window]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:01: resource 1 [mem 0xfd600=
000-0xfd6fffff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:02: resource 0 [io  0x3000-=
0x3fff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:02: resource 1 [mem 0xfd500=
000-0xfd5fffff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:03: resource 0 [io  0x2000-=
0x2fff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:03: resource 1 [mem 0xfd400=
000-0xfd4fffff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:03: resource 2 [mem 0x43000=
0000-0x4301fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:04: resource 0 [io  0x1000-=
0x1fff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:04: resource 1 [mem 0xfd000=
000-0xfd3fffff]
Apr 16 15:55:34 meterpeter kernel: pci_bus 0000:04: resource 2 [mem 0x46000=
0000-0x4701fffff 64bit pref]
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: D0 power state depends=
 on 0000:04:00.0
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: extending delay after =
power-on from D3hot to 20 msec
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: extending delay after =
power-on from D3hot to 20 msec
Apr 16 15:55:34 meterpeter kernel: PCI: CLS 32 bytes, default 64
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:00.2: AMD-Vi: IOMMU performa=
nce counters supported
Apr 16 15:55:34 meterpeter kernel: Trying to unpack rootfs image as initram=
fs...
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:00.0: Adding to iommu group 0
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:01.0: Adding to iommu group 1
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.0: Adding to iommu group 2
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.1: Adding to iommu group 3
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.2: Adding to iommu group 4
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:02.3: Adding to iommu group 5
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.0: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:08.1: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:14.0: Adding to iommu group 7
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:14.3: Adding to iommu group 7
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.0: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.1: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.2: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.3: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.4: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.5: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.6: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:00:18.7: Adding to iommu group 8
Apr 16 15:55:34 meterpeter kernel: pci 0000:01:00.0: Adding to iommu group 9
Apr 16 15:55:34 meterpeter kernel: pci 0000:02:00.0: Adding to iommu group =
10
Apr 16 15:55:34 meterpeter kernel: pci 0000:03:00.0: Adding to iommu group =
11
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.0: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.1: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.2: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.3: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.4: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.5: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: pci 0000:04:00.6: Adding to iommu group 6
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: Extended features (0x206d73ef222=
54ade, 0x0): PPR X2APIC NX GT IA GA PC GA_vAPIC
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: Interrupt remapping enabled
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: X2APIC enabled
Apr 16 15:55:34 meterpeter kernel: AMD-Vi: Virtual APIC enabled
Apr 16 15:55:34 meterpeter kernel: PCI-DMA: Using software bounce buffering=
 for IO (SWIOTLB)
Apr 16 15:55:34 meterpeter kernel: software IO TLB: mapped [mem 0x00000000b=
c19f000-0x00000000c019f000] (64MB)
Apr 16 15:55:34 meterpeter kernel: LVT offset 0 assigned for vector 0x400
Apr 16 15:55:34 meterpeter kernel: perf: AMD IBS detected (0x000003ff)
Apr 16 15:55:34 meterpeter kernel: perf/amd_iommu: Detected AMD IOMMU #0 (2=
 banks, 4 counters/bank).
Apr 16 15:55:34 meterpeter kernel: Initialise system trusted keyrings
Apr 16 15:55:34 meterpeter kernel: Key type blacklist registered
Apr 16 15:55:34 meterpeter kernel: workingset: timestamp_bits=3D36 max_orde=
r=3D22 bucket_order=3D0
Apr 16 15:55:34 meterpeter kernel: fuse: init (API version 7.43)
Apr 16 15:55:34 meterpeter kernel: integrity: Platform Keyring initialized
Apr 16 15:55:34 meterpeter kernel: integrity: Machine keyring initialized
Apr 16 15:55:34 meterpeter kernel: xor: automatically using best checksummi=
ng function   avx      =20
Apr 16 15:55:34 meterpeter kernel: Key type asymmetric registered
Apr 16 15:55:34 meterpeter kernel: Asymmetric key parser 'x509' registered
Apr 16 15:55:34 meterpeter kernel: Block layer SCSI generic (bsg) driver ve=
rsion 0.4 loaded (major 246)
Apr 16 15:55:34 meterpeter kernel: io scheduler mq-deadline registered
Apr 16 15:55:34 meterpeter kernel: io scheduler kyber registered
Apr 16 15:55:34 meterpeter kernel: io scheduler bfq registered
Apr 16 15:55:34 meterpeter kernel: ledtrig-cpu: registered to indicate acti=
vity on CPUs
Apr 16 15:55:34 meterpeter kernel: pcieport 0000:00:02.1: PME: Signaling wi=
th IRQ 28
Apr 16 15:55:34 meterpeter kernel: pcieport 0000:00:02.2: PME: Signaling wi=
th IRQ 29
Apr 16 15:55:34 meterpeter kernel: pcieport 0000:00:02.3: PME: Signaling wi=
th IRQ 30
Apr 16 15:55:34 meterpeter kernel: pcieport 0000:00:02.3: pciehp: Slot #0 A=
ttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoComp=
l+ IbPresDis- LLActRep+
Apr 16 15:55:34 meterpeter kernel: pcieport 0000:00:08.1: PME: Signaling wi=
th IRQ 31
Apr 16 15:55:34 meterpeter kernel: ACPI: AC: AC Adapter [AC] (off-line)
Apr 16 15:55:34 meterpeter kernel: input: Power Button as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0C:00/input/input0
Apr 16 15:55:34 meterpeter kernel: ACPI: button: Power Button [PWRB]
Apr 16 15:55:34 meterpeter kernel: input: Lid Switch as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0D:00/input/input1
Apr 16 15:55:34 meterpeter kernel: ACPI: button: Lid Switch [LID]
Apr 16 15:55:34 meterpeter kernel: input: Sleep Button as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0E:00/input/input2
Apr 16 15:55:34 meterpeter kernel: ACPI: button: Sleep Button [SLPB]
Apr 16 15:55:34 meterpeter kernel: input: Power Button as /devices/LNXSYSTM=
:00/LNXPWRBN:00/input/input3
Apr 16 15:55:34 meterpeter kernel: ACPI: button: Power Button [PWRF]
Apr 16 15:55:34 meterpeter kernel: Monitor-Mwait will be used to enter C-1 =
state
Apr 16 15:55:34 meterpeter kernel: Estimated ratio of average max frequency=
 by base frequency (times 1024): 1501
Apr 16 15:55:34 meterpeter kernel: Serial: 8250/16550 driver, 32 ports, IRQ=
 sharing enabled
Apr 16 15:55:34 meterpeter kernel: ACPI: battery: Slot [BAT0] (battery pres=
ent)
Apr 16 15:55:34 meterpeter kernel: Non-volatile memory driver v1.3
Apr 16 15:55:34 meterpeter kernel: Linux agpgart interface v0.103
Apr 16 15:55:34 meterpeter kernel: tpm_tis STM0125:00: 2.0 TPM (device-id 0=
x0, rev-id 78)
Apr 16 15:55:34 meterpeter kernel: Freeing initrd memory: 44720K
Apr 16 15:55:34 meterpeter kernel: ACPI: bus type drm_connector registered
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: xHCI Host Control=
ler
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: new USB bus regis=
tered, assigned bus number 1
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: hcc params 0x0268=
ffe5 hci version 0x110 quirks 0x0000020000000010
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: xHCI Host Control=
ler
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: new USB bus regis=
tered, assigned bus number 2
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.3: Host supports USB=
 3.1 Enhanced SuperSpeed
Apr 16 15:55:34 meterpeter kernel: usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15
Apr 16 15:55:34 meterpeter kernel: usb usb1: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:55:34 meterpeter kernel: usb usb1: Product: xHCI Host Controller
Apr 16 15:55:34 meterpeter kernel: usb usb1: Manufacturer: Linux 6.15.0-rc2=
-1.1-mainline-dirty xhci-hcd
Apr 16 15:55:34 meterpeter kernel: usb usb1: SerialNumber: 0000:04:00.3
Apr 16 15:55:34 meterpeter kernel: hub 1-0:1.0: USB hub found
Apr 16 15:55:34 meterpeter kernel: hub 1-0:1.0: 4 ports detected
Apr 16 15:55:34 meterpeter kernel: usb usb2: We don't know the algorithms f=
or LPM for this host, disabling LPM.
Apr 16 15:55:34 meterpeter kernel: usb usb2: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.15
Apr 16 15:55:34 meterpeter kernel: usb usb2: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:55:34 meterpeter kernel: usb usb2: Product: xHCI Host Controller
Apr 16 15:55:34 meterpeter kernel: usb usb2: Manufacturer: Linux 6.15.0-rc2=
-1.1-mainline-dirty xhci-hcd
Apr 16 15:55:34 meterpeter kernel: usb usb2: SerialNumber: 0000:04:00.3
Apr 16 15:55:34 meterpeter kernel: hub 2-0:1.0: USB hub found
Apr 16 15:55:34 meterpeter kernel: hub 2-0:1.0: 2 ports detected
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: xHCI Host Control=
ler
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: new USB bus regis=
tered, assigned bus number 3
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: hcc params 0x0268=
ffe5 hci version 0x110 quirks 0x0000020000000010
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: xHCI Host Control=
ler
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: new USB bus regis=
tered, assigned bus number 4
Apr 16 15:55:34 meterpeter kernel: xhci_hcd 0000:04:00.4: Host supports USB=
 3.1 Enhanced SuperSpeed
Apr 16 15:55:34 meterpeter kernel: usb usb3: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15
Apr 16 15:55:34 meterpeter kernel: usb usb3: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:55:34 meterpeter kernel: usb usb3: Product: xHCI Host Controller
Apr 16 15:55:34 meterpeter kernel: usb usb3: Manufacturer: Linux 6.15.0-rc2=
-1.1-mainline-dirty xhci-hcd
Apr 16 15:55:34 meterpeter kernel: usb usb3: SerialNumber: 0000:04:00.4
Apr 16 15:55:34 meterpeter kernel: hub 3-0:1.0: USB hub found
Apr 16 15:55:34 meterpeter kernel: hub 3-0:1.0: 4 ports detected
Apr 16 15:55:34 meterpeter kernel: usb usb4: We don't know the algorithms f=
or LPM for this host, disabling LPM.
Apr 16 15:55:34 meterpeter kernel: usb usb4: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.15
Apr 16 15:55:34 meterpeter kernel: usb usb4: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:55:34 meterpeter kernel: usb usb4: Product: xHCI Host Controller
Apr 16 15:55:34 meterpeter kernel: usb usb4: Manufacturer: Linux 6.15.0-rc2=
-1.1-mainline-dirty xhci-hcd
Apr 16 15:55:34 meterpeter kernel: usb usb4: SerialNumber: 0000:04:00.4
Apr 16 15:55:34 meterpeter kernel: hub 4-0:1.0: USB hub found
Apr 16 15:55:34 meterpeter kernel: hub 4-0:1.0: 2 ports detected
Apr 16 15:55:34 meterpeter kernel: usbcore: registered new interface driver=
 usbserial_generic
Apr 16 15:55:34 meterpeter kernel: usbserial: USB Serial support registered=
 for generic
Apr 16 15:55:34 meterpeter kernel: rtc_cmos 00:01: RTC can wake from S4
Apr 16 15:55:34 meterpeter kernel: rtc_cmos 00:01: registered as rtc0
Apr 16 15:55:34 meterpeter kernel: rtc_cmos 00:01: setting system clock to =
2025-04-16T13:55:17 UTC (1744811717)
Apr 16 15:55:34 meterpeter kernel: rtc_cmos 00:01: alarms up to one month, =
y3k, 114 bytes nvram
Apr 16 15:55:34 meterpeter kernel: simple-framebuffer simple-framebuffer.0:=
 [drm] Registered 1 planes with drm panic
Apr 16 15:55:34 meterpeter kernel: [drm] Initialized simpledrm 1.0.0 for si=
mple-framebuffer.0 on minor 0
Apr 16 15:55:34 meterpeter kernel: fbcon: Deferring console take-over
Apr 16 15:55:34 meterpeter kernel: simple-framebuffer simple-framebuffer.0:=
 [drm] fb0: simpledrmdrmfb frame buffer device
Apr 16 15:55:34 meterpeter kernel: hid: raw HID events driver (C) Jiri Kosi=
na
Apr 16 15:55:34 meterpeter kernel: drop_monitor: Initializing network drop =
monitor service
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_INET6 protocol family
Apr 16 15:55:34 meterpeter kernel: Segment Routing with IPv6
Apr 16 15:55:34 meterpeter kernel: RPL Segment Routing with IPv6
Apr 16 15:55:34 meterpeter kernel: In-situ OAM (IOAM) with IPv6
Apr 16 15:55:34 meterpeter kernel: NET: Registered PF_PACKET protocol family
Apr 16 15:55:34 meterpeter kernel: microcode: Current revision: 0x08608108
Apr 16 15:55:34 meterpeter kernel: microcode: Updated early from: 0x08608103
Apr 16 15:55:34 meterpeter kernel: resctrl: L3 allocation detected
Apr 16 15:55:34 meterpeter kernel: resctrl: MB allocation detected
Apr 16 15:55:34 meterpeter kernel: resctrl: L3 monitoring detected
Apr 16 15:55:34 meterpeter kernel: IPI shorthand broadcast: enabled
Apr 16 15:55:34 meterpeter kernel: sched_clock: Marking stable (732241219, =
349963)->(744640816, -12049634)
Apr 16 15:55:34 meterpeter kernel: registered taskstats version 1
Apr 16 15:55:34 meterpeter kernel: Loading compiled-in X.509 certificates
Apr 16 15:55:34 meterpeter kernel: Loaded X.509 cert 'Build time autogenera=
ted kernel key: 46d1992e0594fbdf8fceb48bf14156ba330620a7'
Apr 16 15:55:34 meterpeter kernel: zswap: loaded using pool zstd/zsmalloc
Apr 16 15:55:34 meterpeter kernel: Demotion targets for Node 0: null
Apr 16 15:55:34 meterpeter kernel: Key type .fscrypt registered
Apr 16 15:55:34 meterpeter kernel: Key type fscrypt-provisioning registered
Apr 16 15:55:34 meterpeter kernel: Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
Apr 16 15:55:34 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:55:34 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo Ltd=
=2E: ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
Apr 16 15:55:34 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:55:34 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo(Bei=
jing)Ltd: swqagent: 24b0bd0836b2f545edea93e058bd3a3c5a8f6a49'
Apr 16 15:55:34 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:55:34 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo UEF=
I CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
Apr 16 15:55:34 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:55:34 meterpeter kernel: integrity: Loaded X.509 cert 'Microsoft =
Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Apr 16 15:55:34 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:55:34 meterpeter kernel: integrity: Loaded X.509 cert 'Microsoft =
Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce21f31686689c
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e70136ace3e73
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:8ad64859f195b5f58dafaa940b6a6167acd67a886e8f469364177221c55945b9
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:aeebae3151271273ed95aa2e671139ed31a98567303a332298f83709a9d55aa1
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c94d856967df8e
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:992d359aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
Apr 16 15:55:34 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:e051b788ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
Apr 16 15:55:34 meterpeter kernel: PM:   Magic number: 5:459:938
Apr 16 15:55:34 meterpeter kernel: RAS: Correctable Errors collector initia=
lized.
Apr 16 15:55:34 meterpeter kernel: clk: Disabling unused clocks
Apr 16 15:55:34 meterpeter kernel: PM: genpd: Disabling unused power domains
Apr 16 15:55:34 meterpeter kernel: Freeing unused decrypted memory: 2028K
Apr 16 15:55:34 meterpeter kernel: Freeing unused kernel image (initmem) me=
mory: 4552K
Apr 16 15:55:34 meterpeter kernel: Write protecting the kernel read-only da=
ta: 38912k
Apr 16 15:55:34 meterpeter kernel: Freeing unused kernel image (text/rodata=
 gap) memory: 1096K
Apr 16 15:55:34 meterpeter kernel: Freeing unused kernel image (rodata/data=
 gap) memory: 2028K
Apr 16 15:55:34 meterpeter kernel: x86/mm: Checked W+X mappings: passed, no=
 W+X pages found.
Apr 16 15:55:34 meterpeter kernel: rodata_test: all tests were successful
Apr 16 15:55:34 meterpeter kernel: Run /init as init process
Apr 16 15:55:34 meterpeter kernel:   with arguments:
Apr 16 15:55:34 meterpeter kernel:     /init
Apr 16 15:55:34 meterpeter kernel:   with environment:
Apr 16 15:55:34 meterpeter kernel:     HOME=3D/
Apr 16 15:55:34 meterpeter kernel:     TERM=3Dlinux
Apr 16 15:55:34 meterpeter kernel:     cryptdevice=3DUUID=3D8913bf3e-3df0-4=
78e-b072-f7bec731154b:archlinux
Apr 16 15:55:34 meterpeter kernel: fbcon: Taking over console
Apr 16 15:55:34 meterpeter kernel: Console: switching to colour frame buffe=
r device 240x67
Apr 16 15:55:34 meterpeter kernel: usb 3-3: new full-speed USB device numbe=
r 2 using xhci_hcd
Apr 16 15:55:34 meterpeter kernel: usb 1-3: new high-speed USB device numbe=
r 2 using xhci_hcd
Apr 16 15:55:34 meterpeter kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD=
,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Apr 16 15:55:34 meterpeter kernel: Key type psk registered
Apr 16 15:55:34 meterpeter kernel: ACPI: video: Video Device [VGA] (multi-h=
ead: yes  rom: no  post: no)
Apr 16 15:55:34 meterpeter kernel: input: Video Bus as /devices/LNXSYSTM:00=
/LNXSYBUS:00/PNP0A08:00/device:0a/LNXVIDEO:00/input/input4
Apr 16 15:55:34 meterpeter kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 16 15:55:34 meterpeter kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 16 15:55:34 meterpeter kernel: ccp 0000:04:00.2: enabling device (0000 =
-> 0002)
Apr 16 15:55:34 meterpeter kernel: ccp 0000:04:00.2: ccp: unable to access =
the device: you might be running a broken BIOS.
Apr 16 15:55:34 meterpeter kernel: cryptd: max_cpu_qlen set to 1000
Apr 16 15:55:34 meterpeter kernel: ccp 0000:04:00.2: tee enabled
Apr 16 15:55:34 meterpeter kernel: ccp 0000:04:00.2: psp enabled
Apr 16 15:55:34 meterpeter kernel: nvme nvme0: pci function 0000:01:00.0
Apr 16 15:55:34 meterpeter kernel: nvme nvme0: D3 entry latency set to 8 se=
conds
Apr 16 15:55:34 meterpeter kernel: nvme nvme0: allocated 64 MiB host memory=
 buffer (1 segment).
Apr 16 15:55:34 meterpeter kernel: usb 1-3: New USB device found, idVendor=
=3D13d3, idProduct=3D56fb, bcdDevice=3D20.04
Apr 16 15:55:34 meterpeter kernel: usb 1-3: New USB device strings: Mfr=3D3=
, Product=3D1, SerialNumber=3D2
Apr 16 15:55:34 meterpeter kernel: usb 1-3: Product: Integrated Camera
Apr 16 15:55:34 meterpeter kernel: usb 1-3: Manufacturer: Azurewave
Apr 16 15:55:34 meterpeter kernel: usb 1-3: SerialNumber: 0000
Apr 16 15:55:34 meterpeter kernel: usb 3-3: New USB device found, idVendor=
=3D06cb, idProduct=3D00fd, bcdDevice=3D 0.00
Apr 16 15:55:34 meterpeter kernel: usb 3-3: New USB device strings: Mfr=3D0=
, Product=3D0, SerialNumber=3D1
Apr 16 15:55:34 meterpeter kernel: usb 3-3: SerialNumber: 3b39bbc4a1e6
Apr 16 15:55:34 meterpeter kernel: nvme nvme0: 12/0/0 default/read/poll que=
ues
Apr 16 15:55:34 meterpeter kernel:  nvme0n1: p1 p2
Apr 16 15:55:34 meterpeter kernel: nvme nvme0: Failed to get ANA log: 2
Apr 16 15:55:34 meterpeter kernel: input: AT Translated Set 2 keyboard as /=
devices/platform/i8042/serio0/input/input5
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.26
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: ThinkPad BIOS R1OET26W (1=
=2E05 ), EC R1OHT26W
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: Lenovo ThinkPad E14 Gen 3=
, model 20YDS00G00
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: radio switch found; radio=
s are enabled
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: This ThinkPad has standar=
d ACPI backlight brightness control, supported by the ACPI video driver
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: Disabling thinkpad-acpi b=
rightness events by default...
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: rfkill switch tpacpi_blue=
tooth_sw: radio is unblocked
Apr 16 15:55:34 meterpeter kernel: usb 1-4: new high-speed USB device numbe=
r 3 using xhci_hcd
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: Standard ACPI backlight i=
nterface available, not loading native one
Apr 16 15:55:34 meterpeter kernel: usb 3-4: new full-speed USB device numbe=
r 3 using xhci_hcd
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: secondary fan control det=
ected & enabled
Apr 16 15:55:34 meterpeter kernel: thinkpad_acpi: battery 1 registered (sta=
rt 95, stop 100, behaviours: 0x7)
Apr 16 15:55:34 meterpeter kernel: ACPI: battery: new hook: ThinkPad Batter=
y Extension
Apr 16 15:55:34 meterpeter kernel: input: ThinkPad Extra Buttons as /device=
s/platform/thinkpad_acpi/input/input6
Apr 16 15:55:34 meterpeter kernel: usb 1-4: New USB device found, idVendor=
=3D05c6, idProduct=3D9024, bcdDevice=3D 4.19
Apr 16 15:55:34 meterpeter kernel: usb 1-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
Apr 16 15:55:34 meterpeter kernel: usb 1-4: Product: Fairphone 4 5G
Apr 16 15:55:34 meterpeter kernel: usb 1-4: Manufacturer: Fairphone
Apr 16 15:55:34 meterpeter kernel: usb 1-4: SerialNumber: f1ed3888
Apr 16 15:55:34 meterpeter kernel: usb 3-4: New USB device found, idVendor=
=3D0bda, idProduct=3Dc123, bcdDevice=3D 0.00
Apr 16 15:55:34 meterpeter kernel: usb 3-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
Apr 16 15:55:34 meterpeter kernel: usb 3-4: Product: Bluetooth Radio
Apr 16 15:55:34 meterpeter kernel: usb 3-4: Manufacturer: Realtek
Apr 16 15:55:34 meterpeter kernel: usb 3-4: SerialNumber: 00e04c000001
Apr 16 15:55:34 meterpeter kernel: tsc: Refined TSC clocksource calibration=
: 2112.070 MHz
Apr 16 15:55:34 meterpeter kernel: clocksource: tsc: mask: 0xffffffffffffff=
ff max_cycles: 0x1e71baaaca9, max_idle_ns: 440795240322 ns
Apr 16 15:55:34 meterpeter kernel: clocksource: Switched to clocksource tsc
Apr 16 15:55:34 meterpeter kernel: clocksource: timekeeping watchdog on CPU=
3: Marking clocksource 'tsc' as unstable because the skew is too large:
Apr 16 15:55:34 meterpeter kernel: clocksource:                       'hpet=
' wd_nsec: 499779371 wd_now: 1b89f6a wd_last: 14b6e8f mask: ffffffff
Apr 16 15:55:34 meterpeter kernel: clocksource:                       'tsc'=
 cs_nsec: 495991580 cs_now: 69bd43440 cs_last: 65d6391ef mask: ffffffffffff=
ffff
Apr 16 15:55:34 meterpeter kernel: clocksource:                       Clock=
source 'tsc' skewed -3787791 ns (-3 ms) over watchdog 'hpet' interval of 49=
9779371 ns (499 ms)
Apr 16 15:55:34 meterpeter kernel: clocksource:                       'tsc'=
 is current clocksource.
Apr 16 15:55:34 meterpeter kernel: tsc: Marking TSC unstable due to clockso=
urce watchdog
Apr 16 15:55:34 meterpeter kernel: TSC found unstable after boot, most like=
ly due to broken BIOS. Use 'tsc=3Dunstable'.
Apr 16 15:55:34 meterpeter kernel: sched_clock: Marking unstable (212008342=
2, 350016)<-(2132482884, -12049634)
Apr 16 15:55:34 meterpeter kernel: clocksource: Checking clocksource tsc sy=
nchronization from CPU 4 to CPUs 0,3,6,8-9.
Apr 16 15:55:34 meterpeter kernel: clocksource: Switched to clocksource hpet
Apr 16 15:55:34 meterpeter kernel: [drm] amdgpu kernel modesetting enabled.
Apr 16 15:55:34 meterpeter kernel: amdgpu: Virtual CRAT table created for C=
PU
Apr 16 15:55:34 meterpeter kernel: amdgpu: Topology: Add CPU node
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: enabling device (00=
06 -> 0007)
Apr 16 15:55:34 meterpeter kernel: [drm] initializing kernel modesetting (R=
ENOIR 0x1002:0x164C 0x17AA:0x5097 0xC2).
Apr 16 15:55:34 meterpeter kernel: [drm] register mmio base: 0xFD300000
Apr 16 15:55:34 meterpeter kernel: [drm] register mmio size: 524288
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 0 <soc15_common>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 1 <gmc_v9_0>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 2 <vega10_ih>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 3 <psp>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 4 <smu>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 5 <dm>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 6 <gfx_v9_0>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 7 <sdma_v4_0>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 8 <vcn_v2_0>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 9 <jpeg_v2_0>
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Fetched VBI=
OS from VFCT
Apr 16 15:55:34 meterpeter kernel: amdgpu: ATOM BIOS: 113-LUCIENNE-016
Apr 16 15:55:34 meterpeter kernel: Console: switching to colour dummy devic=
e 80x25
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: vgaarb: deactivate =
vga console
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Trusted Mem=
ory Zone (TMZ) feature enabled
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset
Apr 16 15:55:34 meterpeter kernel: [drm] vm size is 262144 GB, 4 levels, bl=
ock size is 9-bit, fragment size is 9-bit
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: VRAM: 1024M=
 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: GART: 1024M=
 0x0000000000000000 - 0x000000003FFFFFFF
Apr 16 15:55:34 meterpeter kernel: [drm] Detected VRAM RAM=3D1024M, BAR=3D1=
024M
Apr 16 15:55:34 meterpeter kernel: [drm] RAM width 128bits DDR4
Apr 16 15:55:34 meterpeter kernel: [drm] amdgpu: 1024M of VRAM memory ready
Apr 16 15:55:34 meterpeter kernel: [drm] amdgpu: 7398M of GTT memory ready.
Apr 16 15:55:34 meterpeter kernel: [drm] GART: num cpu pages 262144, num gp=
u pages 262144
Apr 16 15:55:34 meterpeter kernel: [drm] PCIE GART of 1024M enabled.
Apr 16 15:55:34 meterpeter kernel: [drm] PTB located at 0x000000F43FC00000
Apr 16 15:55:34 meterpeter kernel: [drm] Loading DMUB firmware via PSP: ver=
sion=3D0x0101002B
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Found VCN f=
irmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: reserve 0x4=
00000 from 0xf43f800000 for PSP TMR
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: RAS: option=
al ras ta ucode is not available
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: RAP: option=
al rap ta ucode is not available
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: psp gfx com=
mand LOAD_TA(0x1) failed and response status is (0x7)
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: psp gfx com=
mand INVOKE_CMD(0x3) failed and response status is (0x4)
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Secure disp=
lay: Generic Failure.
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SECUREDISPL=
AY: query securedisplay TA failed. ret 0x0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SMU is init=
ialized successfully!
Apr 16 15:55:34 meterpeter kernel: [drm] Display Core v3.2.325 initialized =
on DCN 2.1
Apr 16 15:55:34 meterpeter kernel: [drm] DP-HDMI FRL PCON supported
Apr 16 15:55:34 meterpeter kernel: [drm] DMUB hardware initialized: version=
=3D0x0101002B
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: [drm] Using=
 ACPI provided EDID for eDP-1
Apr 16 15:55:34 meterpeter kernel: [drm] kiq ring mec 2 pipe 1 q 0
Apr 16 15:55:34 meterpeter kernel: kfd kfd: amdgpu: Allocated 3969056 bytes=
 on gart
Apr 16 15:55:34 meterpeter kernel: kfd kfd: amdgpu: Total number of KFD nod=
es to be created: 1
Apr 16 15:55:34 meterpeter kernel: amdgpu: Virtual CRAT table created for G=
PU
Apr 16 15:55:34 meterpeter kernel: amdgpu: Topology: Add dGPU node [0x164c:=
0x1002]
Apr 16 15:55:34 meterpeter kernel: kfd kfd: amdgpu: added device 1002:164c
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH pe=
r SE 1, CU per SH 8, active_cu_number 7
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx us=
es VM inv eng 0 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E0.0 uses VM inv eng 1 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E1.0 uses VM inv eng 4 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E2.0 uses VM inv eng 5 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E3.0 uses VM inv eng 6 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E0.1 uses VM inv eng 7 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E1.1 uses VM inv eng 8 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E2.1 uses VM inv eng 9 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E3.1 uses VM inv eng 10 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring kiq_0.=
2.1.0 uses VM inv eng 11 on hub 0
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0 =
uses VM inv eng 0 on hub 8
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_de=
c uses VM inv eng 1 on hub 8
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_en=
c0 uses VM inv eng 4 on hub 8
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_en=
c1 uses VM inv eng 5 on hub 8
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_d=
ec uses VM inv eng 6 on hub 8
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Runtime PM =
not available
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: [drm] Using=
 custom brightness curve
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: [drm] Registered 4 =
planes with drm panic
Apr 16 15:55:34 meterpeter kernel: [drm] Initialized amdgpu 3.63.0 for 0000=
:04:00.0 on minor 1
Apr 16 15:55:34 meterpeter kernel: fbcon: amdgpudrmfb (fb0) is primary devi=
ce
Apr 16 15:55:34 meterpeter kernel: [drm] pre_validate_dsc:1601 MST_DSC dsc =
precompute is not needed
Apr 16 15:55:34 meterpeter kernel: Console: switching to colour frame buffe=
r device 240x67
Apr 16 15:55:34 meterpeter kernel: amdgpu 0000:04:00.0: [drm] fb0: amdgpudr=
mfb frame buffer device
Apr 16 15:55:34 meterpeter kernel: device-mapper: uevent: version 1.0.3
Apr 16 15:55:34 meterpeter kernel: device-mapper: ioctl: 4.49.0-ioctl (2025=
-01-17) initialised: dm-devel@lists.linux.dev
Apr 16 15:55:34 meterpeter kernel: Key type trusted registered
Apr 16 15:55:34 meterpeter kernel: Key type encrypted registered
Apr 16 15:55:34 meterpeter kernel: BTRFS: device label archlinux-btrfs devi=
d 1 transid 651459 /dev/mapper/archlinux (253:0) scanned by mount (502)
Apr 16 15:55:34 meterpeter kernel: BTRFS info (device dm-0): first mount of=
 filesystem 924db749-b786-4970-9fed-688cccb609e9
Apr 16 15:55:34 meterpeter kernel: BTRFS info (device dm-0): using crc32c (=
crc32c-x86) checksum algorithm
Apr 16 15:55:34 meterpeter kernel: BTRFS info (device dm-0): using free-spa=
ce-tree
Apr 16 15:55:34 meterpeter systemd[1]: systemd 257.5-1-arch running in syst=
em mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +=
GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +=
LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +Q=
RENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +U=
TMP -SYSVINIT +LIBARCHIVE)
Apr 16 15:55:34 meterpeter systemd[1]: Detected architecture x86-64.
Apr 16 15:55:34 meterpeter systemd[1]: Hostname set to <meterpeter>.
Apr 16 15:55:34 meterpeter systemd[1]: bpf-restrict-fs: LSM BPF program att=
ached
Apr 16 15:55:34 meterpeter systemd[1]: Queued start job for default target =
Graphical Interface.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/dirmngr.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/getty.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-browser.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-extra.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-ssh.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/keyboxd.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/modprobe.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice Slice /system/systemd-=
fsck.
Apr 16 15:55:34 meterpeter systemd[1]: Created slice User and Session Slice.
Apr 16 15:55:34 meterpeter systemd[1]: Started Dispatch Password Requests t=
o Console Directory Watch.
Apr 16 15:55:34 meterpeter systemd[1]: Started Forward Password Requests to=
 Wall Directory Watch.
Apr 16 15:55:34 meterpeter systemd[1]: Set up automount Arbitrary Executabl=
e File Formats File System Automount Point.
Apr 16 15:55:34 meterpeter systemd[1]: Expecting device /dev/disk/by-uuid/9=
24db749-b786-4970-9fed-688cccb609e9...
Apr 16 15:55:34 meterpeter systemd[1]: Expecting device /dev/disk/by-uuid/F=
ABC-FA07...
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Local Encrypted Volum=
es.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Local Integrity Prote=
cted Volumes.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Preparation for Netwo=
rk.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Path Units.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Remote File Systems.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Slice Units.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Local Verity Protecte=
d Volumes.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on Device-mapper event dae=
mon FIFOs.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on LVM2 poll daemon socket.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on Process Core Dump Socke=
t.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on Credential Encryption/D=
ecryption.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on Journal Socket (/dev/lo=
g).
Apr 16 15:55:34 meterpeter systemd[1]: Listening on Journal Sockets.
Apr 16 15:55:34 meterpeter systemd[1]: TPM PCR Measurements was skipped bec=
ause of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:55:34 meterpeter systemd[1]: Make TPM PCR Policy was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:55:34 meterpeter systemd[1]: Listening on udev Control Socket.
Apr 16 15:55:34 meterpeter systemd[1]: Listening on udev Kernel Socket.
Apr 16 15:55:34 meterpeter systemd[1]: Mounting Huge Pages File System...
Apr 16 15:55:34 meterpeter systemd[1]: Mounting POSIX Message Queue File Sy=
stem...
Apr 16 15:55:34 meterpeter systemd[1]: Mounting Kernel Debug File System...
Apr 16 15:55:34 meterpeter systemd[1]: Mounting Kernel Trace File System...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Create List of Static Devic=
e Nodes...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Monitoring of LVM2 mirrors,=
 snapshots etc. using dmeventd or progress polling...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Module configfs=
=2E..
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Module dm_mod...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Module drm...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Module fuse...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Module loop...
Apr 16 15:55:34 meterpeter systemd[1]: Clear Stale Hibernate Storage Info w=
as skipped because of an unmet condition check (ConditionPathExists=3D/sys/=
firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67=
).
Apr 16 15:55:34 meterpeter systemd[1]: Starting Journal Service...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load Kernel Modules...
Apr 16 15:55:34 meterpeter systemd[1]: TPM PCR Machine ID Measurement was s=
kipped because of an unmet condition check (ConditionSecurity=3Dmeasured-uk=
i).
Apr 16 15:55:34 meterpeter systemd[1]: Starting Remount Root and Kernel Fil=
e Systems...
Apr 16 15:55:34 meterpeter systemd[1]: Early TPM SRK Setup was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load udev Rules from Creden=
tials...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Coldplug All udev Devices...
Apr 16 15:55:34 meterpeter systemd[1]: Mounted Huge Pages File System.
Apr 16 15:55:34 meterpeter systemd[1]: Mounted POSIX Message Queue File Sys=
tem.
Apr 16 15:55:34 meterpeter systemd[1]: Mounted Kernel Debug File System.
Apr 16 15:55:34 meterpeter systemd[1]: Mounted Kernel Trace File System.
Apr 16 15:55:34 meterpeter kernel: loop: module loaded
Apr 16 15:55:34 meterpeter systemd[1]: Finished Create List of Static Devic=
e Nodes.
Apr 16 15:55:34 meterpeter systemd[1]: modprobe@configfs.service: Deactivat=
ed successfully.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Module configfs.
Apr 16 15:55:34 meterpeter systemd[1]: modprobe@dm_mod.service: Deactivated=
 successfully.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Module dm_mod.
Apr 16 15:55:34 meterpeter systemd[1]: modprobe@drm.service: Deactivated su=
ccessfully.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Module drm.
Apr 16 15:55:34 meterpeter systemd[1]: modprobe@fuse.service: Deactivated s=
uccessfully.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Module fuse.
Apr 16 15:55:34 meterpeter systemd[1]: modprobe@loop.service: Deactivated s=
uccessfully.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Module loop.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load Kernel Modules.
Apr 16 15:55:34 meterpeter systemd-journald[571]: Collecting audit messages=
 is disabled.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Remount Root and Kernel Fil=
e Systems.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load udev Rules from Creden=
tials.
Apr 16 15:55:34 meterpeter systemd[1]: Activating swap /swap/swapfile...
Apr 16 15:55:34 meterpeter systemd[1]: Mounting FUSE Control File System...
Apr 16 15:55:34 meterpeter systemd[1]: Mounting Kernel Configuration File S=
ystem...
Apr 16 15:55:34 meterpeter systemd[1]: Rebuild Hardware Database was skippe=
d because no trigger condition checks were met.
Apr 16 15:55:34 meterpeter systemd[1]: Starting Load/Save OS Random Seed...
Apr 16 15:55:34 meterpeter systemd[1]: Repartition Root Disk was skipped be=
cause no trigger condition checks were met.
Apr 16 15:55:34 meterpeter systemd[1]: Starting Apply Kernel Variables...
Apr 16 15:55:34 meterpeter systemd[1]: Starting Create Static Device Nodes =
in /dev gracefully...
Apr 16 15:55:34 meterpeter systemd[1]: TPM SRK Setup was skipped because of=
 an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:55:34 meterpeter systemd[1]: Finished Monitoring of LVM2 mirrors,=
 snapshots etc. using dmeventd or progress polling.
Apr 16 15:55:34 meterpeter kernel: Adding 16777212k swap on /swap/swapfile.=
  Priority:-2 extents:33 across:450363392k SS
Apr 16 15:55:34 meterpeter systemd[1]: Activated swap /swap/swapfile.
Apr 16 15:55:34 meterpeter systemd[1]: Mounted FUSE Control File System.
Apr 16 15:55:34 meterpeter systemd[1]: Mounted Kernel Configuration File Sy=
stem.
Apr 16 15:55:34 meterpeter systemd[1]: Reached target Swaps.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Load/Save OS Random Seed.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Apply Kernel Variables.
Apr 16 15:55:34 meterpeter systemd[1]: Finished Create Static Device Nodes =
in /dev gracefully.
Apr 16 15:55:34 meterpeter systemd[1]: Starting Create System Users...
Apr 16 15:55:34 meterpeter systemd[1]: Started Journal Service.
Apr 16 15:55:35 meterpeter kernel: piix4_smbus 0000:00:14.0: SMBus Host Con=
troller at 0xb00, revision 0
Apr 16 15:55:35 meterpeter kernel: piix4_smbus 0000:00:14.0: Using register=
 0x02 for SMBus port selection
Apr 16 15:55:35 meterpeter kernel: i2c i2c-5: Successfully instantiated SPD=
 at 0x50
Apr 16 15:55:35 meterpeter kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBu=
s Host Controller at 0xb20
Apr 16 15:55:35 meterpeter kernel: RAPL PMU: API unit is 2^-32 Joules, 2 fi=
xed counters, 163840 ms ovfl timer
Apr 16 15:55:35 meterpeter kernel: RAPL PMU: hw unit of domain package 2^-1=
6 Joules
Apr 16 15:55:35 meterpeter kernel: RAPL PMU: hw unit of domain core 2^-16 J=
oules
Apr 16 15:55:35 meterpeter kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Ti=
mer Driver
Apr 16 15:55:35 meterpeter kernel: sp5100-tco sp5100-tco: Using 0xfeb00000 =
for watchdog MMIO address
Apr 16 15:55:35 meterpeter kernel: sp5100-tco sp5100-tco: initialized. hear=
tbeat=3D60 sec (nowayout=3D0)
Apr 16 15:55:35 meterpeter kernel: cfg80211: Loading compiled-in X.509 cert=
ificates for regulatory database
Apr 16 15:55:35 meterpeter kernel: Loaded X.509 cert 'sforshee: 00b28ddf47a=
ef9cea7'
Apr 16 15:55:35 meterpeter kernel: Loaded X.509 cert 'wens: 61c038651aabdcf=
94bd0ac7ff06c7248db18c600'
Apr 16 15:55:35 meterpeter kernel: ee1004 5-0050: 512 byte EE1004-compliant=
 SPD EEPROM, read-only
Apr 16 15:55:35 meterpeter kernel: snd_rn_pci_acp3x 0000:04:00.5: enabling =
device (0000 -> 0002)
Apr 16 15:55:35 meterpeter kernel: r8169 0000:02:00.0: can't disable ASPM; =
OS doesn't have ASPM control
Apr 16 15:55:35 meterpeter kernel: r8169 0000:02:00.0 eth0: RTL8168gu/8111g=
u, 38:f3:ab:58:be:e8, XID 509, IRQ 68
Apr 16 15:55:35 meterpeter kernel: r8169 0000:02:00.0 eth0: jumbo features =
[frames: 9194 bytes, tx checksumming: ko]
Apr 16 15:55:35 meterpeter kernel: r8169 0000:02:00.0 enp2s0: renamed from =
eth0
Apr 16 15:55:35 meterpeter kernel: kvm_amd: TSC scaling supported
Apr 16 15:55:35 meterpeter kernel: kvm_amd: Nested Virtualization enabled
Apr 16 15:55:35 meterpeter kernel: kvm_amd: Nested Paging enabled
Apr 16 15:55:35 meterpeter kernel: kvm_amd: LBR virtualization supported
Apr 16 15:55:35 meterpeter kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
Apr 16 15:55:35 meterpeter kernel: kvm_amd: Virtual GIF supported
Apr 16 15:55:35 meterpeter kernel: snd_hda_intel 0000:04:00.1: enabling dev=
ice (0000 -> 0002)
Apr 16 15:55:35 meterpeter kernel: snd_hda_intel 0000:04:00.1: Handle vga_s=
witcheroo audio client
Apr 16 15:55:35 meterpeter kernel: snd_hda_intel 0000:04:00.6: enabling dev=
ice (0000 -> 0002)
Apr 16 15:55:35 meterpeter kernel: snd_hda_intel 0000:04:00.1: bound 0000:0=
4:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Apr 16 15:55:35 meterpeter kernel: rtw_8822ce 0000:03:00.0: enabling device=
 (0000 -> 0003)
Apr 16 15:55:35 meterpeter kernel: rtw_8822ce 0000:03:00.0: Firmware versio=
n 9.9.15, H2C version 15
Apr 16 15:55:35 meterpeter kernel: rtw_8822ce 0000:03:00.0: WOW Firmware ve=
rsion 9.9.4, H2C version 15
Apr 16 15:55:35 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D3 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input11
Apr 16 15:55:35 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D7 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input12
Apr 16 15:55:35 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D8 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input13
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: assuming hardw=
are version 4 (with firmware version 0x5f3001)
Apr 16 15:55:35 meterpeter kernel: amd_atl: AMD Address Translation Library=
 initialized
Apr 16 15:55:35 meterpeter kernel: intel_rapl_common: Found RAPL domain pac=
kage
Apr 16 15:55:35 meterpeter kernel: intel_rapl_common: Found RAPL domain core
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: Synaptics capa=
bilities query result 0x90, 0x18, 0x0d.
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0: ALC25=
7: picked fixup  for PCI SSID 17aa:0000
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0: autoc=
onfig for ALC257: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    sp=
eaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    hp=
_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    mo=
no: mono_out=3D0x0
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    in=
puts:
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:      =
Internal Mic=3D0x12
Apr 16 15:55:35 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:      =
Mic=3D0x19
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: Elan sample qu=
ery result 00, 0d, a7
Apr 16 15:55:35 meterpeter kernel: rtw_8822ce 0000:03:00.0 wlp3s0: renamed =
=66rom wlan0
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: Elan ic body: =
0x11, current fw version: 0x4
Apr 16 15:55:35 meterpeter kernel: input: HD-Audio Generic Mic as /devices/=
pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input14
Apr 16 15:55:35 meterpeter kernel: input: HD-Audio Generic Headphone as /de=
vices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input15
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: Trying to set =
up SMBus access
Apr 16 15:55:35 meterpeter kernel: psmouse serio1: elantech: SMbus companio=
n is not ready yet
Apr 16 15:55:35 meterpeter kernel: input: ETPS/2 Elantech TrackPoint as /de=
vices/platform/i8042/serio1/input/input16
Apr 16 15:55:35 meterpeter kernel: input: ETPS/2 Elantech Touchpad as /devi=
ces/platform/i8042/serio1/input/input10
Apr 16 15:55:35 meterpeter kernel: mousedev: PS/2 mouse device common for a=
ll mice
Apr 16 15:55:35 meterpeter systemd-journald[571]: Received client request t=
o flush runtime journal.
Apr 16 15:55:36 meterpeter kernel: mc: Linux media interface: v0.10
Apr 16 15:55:36 meterpeter kernel: Bluetooth: Core ver 2.22
Apr 16 15:55:36 meterpeter kernel: NET: Registered PF_BLUETOOTH protocol fa=
mily
Apr 16 15:55:36 meterpeter kernel: Bluetooth: HCI device and connection man=
ager initialized
Apr 16 15:55:36 meterpeter kernel: Bluetooth: HCI socket layer initialized
Apr 16 15:55:36 meterpeter kernel: Bluetooth: L2CAP socket layer initialized
Apr 16 15:55:36 meterpeter kernel: Bluetooth: SCO socket layer initialized
Apr 16 15:55:36 meterpeter kernel: usbcore: registered new interface driver=
 cdc_ether
Apr 16 15:55:36 meterpeter kernel: videodev: Linux video capture interface:=
 v2.00
Apr 16 15:55:36 meterpeter kernel: rndis_host 1-4:1.0 usb0: register 'rndis=
_host' at usb-0000:04:00.3-4, RNDIS device, 3a:2a:e2:bb:37:14
Apr 16 15:55:36 meterpeter kernel: usbcore: registered new interface driver=
 rndis_host
Apr 16 15:55:36 meterpeter kernel: rndis_host 1-4:1.0 enp4s0f3u4: renamed f=
rom usb0
Apr 16 15:55:36 meterpeter kernel: usbcore: registered new interface driver=
 btusb
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: examining hci_ver=
=3D0a hci_rev=3D000c lmp_ver=3D0a lmp_subver=3D8822
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: rom_version status=
=3D0 version=3D3
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl=
8822cu_fw.bin
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl=
8822cu_config.bin
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: cfg_sz 6, total sz=
 37346
Apr 16 15:55:36 meterpeter kernel: usb 1-3: Found UVC 1.10 device Integrate=
d Camera (13d3:56fb)
Apr 16 15:55:36 meterpeter kernel: usb 1-3: Found UVC 1.50 device Integrate=
d Camera (13d3:56fb)
Apr 16 15:55:36 meterpeter kernel: usbcore: registered new interface driver=
 uvcvideo
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: RTL: fw version 0xaed66=
dcb
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: AOSP extensions version=
 v1.00
Apr 16 15:55:36 meterpeter kernel: Bluetooth: hci0: AOSP quality report is =
supported
Apr 16 15:55:37 meterpeter kernel: Generic FE-GE Realtek PHY r8169-0-200:00=
: attached PHY driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
Apr 16 15:55:37 meterpeter kernel: r8169 0000:02:00.0 enp2s0: Link is Down
Apr 16 15:55:37 meterpeter kernel: tun: Universal TUN/TAP device driver, 1.6
Apr 16 15:55:55 meterpeter kernel: nvme nvme0: using unchecked data buffer
Apr 16 15:57:27 meterpeter kernel: traps: electron[1244] trap invalid opcod=
e ip:562e6ecf9293 sp:7ffd61691da0 error:0 in electron[5914293,562e6a81e000+=
92bc000]

--a5ukmz4hgjgovgad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.15-rc2-1-BAD.log"
Content-Transfer-Encoding: quoted-printable

Apr 16 15:58:05 meterpeter kernel: Linux version 6.15.0-rc2-1-mainline (lin=
ux-mainline@archlinux) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU Binutils) 2.=
44) #1 SMP PREEMPT_DYNAMIC Sun, 13 Apr 2025 21:49:32 +0000
Apr 16 15:58:05 meterpeter kernel: Command line: initrd=3D\initramfs-linux-=
mainline.img cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:arch=
linux root=3D/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D4 d=
rm.panic_screen=3Dqr_code
Apr 16 15:58:05 meterpeter kernel: BIOS-provided physical RAM map:
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000000000000-0x000=
000000009efff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x000000000009f000-0x000=
000000009ffff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000000e0000-0x000=
00000000fffff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000000100000-0x000=
0000009bfffff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000009c00000-0x000=
0000009da0fff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000009da1000-0x000=
0000009efffff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000009f00000-0x000=
0000009f0efff] ACPI NVS
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000009f0f000-0x000=
00000c4b7dfff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000c4b7e000-0x000=
00000cad7dfff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000cad7e000-0x000=
00000cc17dfff] ACPI NVS
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000cc17e000-0x000=
00000cc1fdfff] ACPI data
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000cc1fe000-0x000=
00000cdffffff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000ce000000-0x000=
00000cfffffff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000f8000000-0x000=
00000fbffffff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000fdc00000-0x000=
00000fdcfffff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000000fed80000-0x000=
00000fed80fff] reserved
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x0000000100000000-0x000=
00003ee2fffff] usable
Apr 16 15:58:05 meterpeter kernel: BIOS-e820: [mem 0x00000003ee300000-0x000=
000042fffffff] reserved
Apr 16 15:58:05 meterpeter kernel: NX (Execute Disable) protection: active
Apr 16 15:58:05 meterpeter kernel: APIC: Static calls initialized
Apr 16 15:58:05 meterpeter kernel: efi: EFI v2.7 by Lenovo
Apr 16 15:58:05 meterpeter kernel: efi: ACPI=3D0xcc1fd000 ACPI 2.0=3D0xcc1f=
d014 SMBIOS=3D0xc7c68000 SMBIOS 3.0=3D0xc7c5b000 TPMFinalLog=3D0xcb01e000 M=
EMATTR=3D0xc15bf018 ESRT=3D0xc323a018 RNG=3D0xcc1fcf18 INITRD=3D0x99b7bf98 =
TPMEventLog=3D0xcc1f1018=20
Apr 16 15:58:05 meterpeter kernel: random: crng init done
Apr 16 15:58:05 meterpeter kernel: efi: Remove mem62: MMIO range=3D[0xfdc00=
000-0xfdcfffff] (1MB) from e820 map
Apr 16 15:58:05 meterpeter kernel: e820: remove [mem 0xfdc00000-0xfdcfffff]=
 reserved
Apr 16 15:58:05 meterpeter kernel: efi: Not removing mem63: MMIO range=3D[0=
xfed80000-0xfed80fff] (4KB) from e820 map
Apr 16 15:58:05 meterpeter kernel: SMBIOS 3.3.0 present.
Apr 16 15:58:05 meterpeter kernel: DMI: LENOVO 20YDS00G00/20YDS00G00, BIOS =
R1OET26W (1.05 ) 04/28/2021
Apr 16 15:58:05 meterpeter kernel: DMI: Memory slots populated: 2/2
Apr 16 15:58:05 meterpeter kernel: tsc: Fast TSC calibration using PIT
Apr 16 15:58:05 meterpeter kernel: tsc: Detected 2096.000 MHz processor
Apr 16 15:58:05 meterpeter kernel: e820: update [mem 0x00000000-0x00000fff]=
 usable =3D=3D> reserved
Apr 16 15:58:05 meterpeter kernel: e820: remove [mem 0x000a0000-0x000fffff]=
 usable
Apr 16 15:58:05 meterpeter kernel: last_pfn =3D 0x3ee300 max_arch_pfn =3D 0=
x400000000
Apr 16 15:58:05 meterpeter kernel: MTRR map: 6 entries (3 fixed + 3 variabl=
e; max 20), built from 9 variable MTRRs
Apr 16 15:58:05 meterpeter kernel: x86/PAT: Configuration [0-7]: WB  WC  UC=
- UC  WB  WP  UC- WT =20
Apr 16 15:58:05 meterpeter kernel: last_pfn =3D 0xce000 max_arch_pfn =3D 0x=
400000000
Apr 16 15:58:05 meterpeter kernel: esrt: Reserving ESRT space from 0x000000=
00c323a018 to 0x00000000c323a0c8.
Apr 16 15:58:05 meterpeter kernel: e820: update [mem 0xc323a000-0xc323afff]=
 usable =3D=3D> reserved
Apr 16 15:58:05 meterpeter kernel: Using GB pages for direct mapping
Apr 16 15:58:05 meterpeter kernel: Secure boot disabled
Apr 16 15:58:05 meterpeter kernel: RAMDISK: [mem 0x91a2e000-0x945d6fff]
Apr 16 15:58:05 meterpeter kernel: ACPI: Early table checksum verification =
disabled
Apr 16 15:58:05 meterpeter kernel: ACPI: RSDP 0x00000000CC1FD014 000024 (v0=
2 LENOVO)
Apr 16 15:58:05 meterpeter kernel: ACPI: XSDT 0x00000000CC1FB188 0000FC (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: FACP 0x00000000C5997000 000114 (v0=
6 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: DSDT 0x00000000C5982000 00F37E (v0=
1 LENOVO TP-R1O   00001050 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: FACS 0x00000000CB01A000 000040
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7C9B000 00094D (v0=
1 LENOVO UsbCTabl 00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7C8E000 007229 (v0=
2 LENOVO TP-R1O   00000002 MSFT 04000000)
Apr 16 15:58:05 meterpeter kernel: ACPI: IVRS 0x00000000C7C8D000 0001A4 (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7C3B000 000924 (v0=
1 LENOVO WmiTable 00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7BB6000 000632 (v0=
2 LENOVO Tpm2Tabl 00001000 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: TPM2 0x00000000C7BB5000 000034 (v0=
3 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: POAT 0x00000000C7BB2000 000055 (v0=
3 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: BATB 0x00000000C7B9D000 00004A (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: HPET 0x00000000C5996000 000038 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: APIC 0x00000000C5995000 000138 (v0=
2 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: MCFG 0x00000000C5994000 00003C (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: SBST 0x00000000C5993000 000030 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: WSMT 0x00000000C5992000 000028 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: VFCT 0x00000000C5974000 00D884 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C5970000 003E88 (v0=
2 LENOVO TP-R1O   00000001 AMD  00000001)
Apr 16 15:58:05 meterpeter kernel: ACPI: CRAT 0x00000000C596F000 000B80 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: CDIT 0x00000000C596E000 000029 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: FPDT 0x00000000C7B9E000 000034 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C596C000 000149 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C596A000 0014C3 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C5968000 0015A8 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C5964000 003979 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: BGRT 0x00000000C5963000 000038 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: UEFI 0x00000000CB019000 0000B2 (v0=
1 LENOVO TP-R1O   00001050 PTEC 00000002)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7C9A000 000090 (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: SSDT 0x00000000C7C99000 0009BD (v0=
1 LENOVO TP-R1O   00000001 INTL 20180313)
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving FACP table memory at [me=
m 0xc5997000-0xc5997113]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving DSDT table memory at [me=
m 0xc5982000-0xc599137d]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving FACS table memory at [me=
m 0xcb01a000-0xcb01a03f]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c9b000-0xc7c9b94c]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c8e000-0xc7c95228]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving IVRS table memory at [me=
m 0xc7c8d000-0xc7c8d1a3]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c3b000-0xc7c3b923]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7bb6000-0xc7bb6631]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving TPM2 table memory at [me=
m 0xc7bb5000-0xc7bb5033]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving POAT table memory at [me=
m 0xc7bb2000-0xc7bb2054]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving BATB table memory at [me=
m 0xc7b9d000-0xc7b9d049]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving HPET table memory at [me=
m 0xc5996000-0xc5996037]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving APIC table memory at [me=
m 0xc5995000-0xc5995137]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving MCFG table memory at [me=
m 0xc5994000-0xc599403b]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SBST table memory at [me=
m 0xc5993000-0xc599302f]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving WSMT table memory at [me=
m 0xc5992000-0xc5992027]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving VFCT table memory at [me=
m 0xc5974000-0xc5981883]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5970000-0xc5973e87]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving CRAT table memory at [me=
m 0xc596f000-0xc596fb7f]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving CDIT table memory at [me=
m 0xc596e000-0xc596e028]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving FPDT table memory at [me=
m 0xc7b9e000-0xc7b9e033]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc596c000-0xc596c148]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc596a000-0xc596b4c2]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5968000-0xc59695a7]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc5964000-0xc5967978]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving BGRT table memory at [me=
m 0xc5963000-0xc5963037]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving UEFI table memory at [me=
m 0xcb019000-0xcb0190b1]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c9a000-0xc7c9a08f]
Apr 16 15:58:05 meterpeter kernel: ACPI: Reserving SSDT table memory at [me=
m 0xc7c99000-0xc7c999bc]
Apr 16 15:58:05 meterpeter kernel: No NUMA configuration found
Apr 16 15:58:05 meterpeter kernel: Faking a node at [mem 0x0000000000000000=
-0x00000003ee2fffff]
Apr 16 15:58:05 meterpeter kernel: NODE_DATA(0) allocated [mem 0x3ee2d5280-=
0x3ee2fffff]
Apr 16 15:58:05 meterpeter kernel: Zone ranges:
Apr 16 15:58:05 meterpeter kernel:   DMA      [mem 0x0000000000001000-0x000=
0000000ffffff]
Apr 16 15:58:05 meterpeter kernel:   DMA32    [mem 0x0000000001000000-0x000=
00000ffffffff]
Apr 16 15:58:05 meterpeter kernel:   Normal   [mem 0x0000000100000000-0x000=
00003ee2fffff]
Apr 16 15:58:05 meterpeter kernel:   Device   empty
Apr 16 15:58:05 meterpeter kernel: Movable zone start for each node
Apr 16 15:58:05 meterpeter kernel: Early memory node ranges
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x0000000000001000-0x00=
0000000009efff]
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x0000000000100000-0x00=
00000009bfffff]
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x0000000009da1000-0x00=
00000009efffff]
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x0000000009f0f000-0x00=
000000c4b7dfff]
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x00000000cc1fe000-0x00=
000000cdffffff]
Apr 16 15:58:05 meterpeter kernel:   node   0: [mem 0x0000000100000000-0x00=
000003ee2fffff]
Apr 16 15:58:05 meterpeter kernel: Initmem setup node 0 [mem 0x000000000000=
1000-0x00000003ee2fffff]
Apr 16 15:58:05 meterpeter kernel: On node 0, zone DMA: 1 pages in unavaila=
ble ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone DMA: 97 pages in unavail=
able ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone DMA32: 417 pages in unav=
ailable ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone DMA32: 15 pages in unava=
ilable ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone DMA32: 30336 pages in un=
available ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone Normal: 8192 pages in un=
available ranges
Apr 16 15:58:05 meterpeter kernel: On node 0, zone Normal: 7424 pages in un=
available ranges
Apr 16 15:58:05 meterpeter kernel: ACPI: PM-Timer IO Port: 0x408
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x08] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x09] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0a] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0b] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0c] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0d] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0e] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: ACPI: LAPIC_NMI (acpi_id[0x0f] high edge=
 lint[0x1])
Apr 16 15:58:05 meterpeter kernel: IOAPIC[0]: apic_id 32, version 33, addre=
ss 0xfec00000, GSI 0-23
Apr 16 15:58:05 meterpeter kernel: IOAPIC[1]: apic_id 33, version 33, addre=
ss 0xfec01000, GSI 24-55
Apr 16 15:58:05 meterpeter kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 globa=
l_irq 2 dfl dfl)
Apr 16 15:58:05 meterpeter kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 globa=
l_irq 9 low level)
Apr 16 15:58:05 meterpeter kernel: ACPI: Using ACPI (MADT) for SMP configur=
ation information
Apr 16 15:58:05 meterpeter kernel: ACPI: HPET id: 0x43538210 base: 0xfed000=
00
Apr 16 15:58:05 meterpeter kernel: e820: update [mem 0xc0cdc000-0xc0d6cfff]=
 usable =3D=3D> reserved
Apr 16 15:58:05 meterpeter kernel: CPU topo: Max. logical packages:   1
Apr 16 15:58:05 meterpeter kernel: CPU topo: Max. logical dies:       1
Apr 16 15:58:05 meterpeter kernel: CPU topo: Max. dies per package:   1
Apr 16 15:58:05 meterpeter kernel: CPU topo: Max. threads per core:   2
Apr 16 15:58:05 meterpeter kernel: CPU topo: Num. cores per package:     6
Apr 16 15:58:05 meterpeter kernel: CPU topo: Num. threads per package:  12
Apr 16 15:58:05 meterpeter kernel: CPU topo: Allowing 12 present CPUs plus =
0 hotplug CPUs
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x00000000-0x00000fff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x0009f000-0x000fffff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x09c00000-0x09da0fff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0x09f00000-0x09f0efff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc0cdc000-0xc0d6cfff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc323a000-0xc323afff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xc4b7e000-0xcc1fdfff]
Apr 16 15:58:05 meterpeter kernel: PM: hibernation: Registered nosave memor=
y: [mem 0xce000000-0xffffffff]
Apr 16 15:58:05 meterpeter kernel: [mem 0xd0000000-0xf7ffffff] available fo=
r PCI devices
Apr 16 15:58:05 meterpeter kernel: Booting paravirtualized kernel on bare h=
ardware
Apr 16 15:58:05 meterpeter kernel: clocksource: refined-jiffies: mask: 0xff=
ffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Apr 16 15:58:05 meterpeter kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bi=
ts:12 nr_cpu_ids:12 nr_node_ids:1
Apr 16 15:58:05 meterpeter kernel: percpu: Embedded 62 pages/cpu s217088 r8=
192 d28672 u262144
Apr 16 15:58:05 meterpeter kernel: pcpu-alloc: s217088 r8192 d28672 u262144=
 alloc=3D1*2097152
Apr 16 15:58:05 meterpeter kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 =
[0] 08 09 10 11 -- -- -- --=20
Apr 16 15:58:05 meterpeter kernel: Kernel command line: initrd=3D\initramfs=
-linux-mainline.img cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec73115=
4b:archlinux root=3D/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw logleve=
l=3D4 drm.panic_screen=3Dqr_code
Apr 16 15:58:05 meterpeter kernel: Unknown kernel command line parameters "=
cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux", will =
be passed to user space.
Apr 16 15:58:05 meterpeter kernel: printk: log buffer data + meta data: 131=
072 + 458752 =3D 589824 bytes
Apr 16 15:58:05 meterpeter kernel: Dentry cache hash table entries: 2097152=
 (order: 12, 16777216 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: Inode-cache hash table entries: 1048576 =
(order: 11, 8388608 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: software IO TLB: area num 16.
Apr 16 15:58:05 meterpeter kernel: Fallback order for Node 0: 0=20
Apr 16 15:58:05 meterpeter kernel: Built 1 zonelists, mobility grouping on.=
  Total pages: 3885678
Apr 16 15:58:05 meterpeter kernel: Policy zone: Normal
Apr 16 15:58:05 meterpeter kernel: mem auto-init: stack:all(zero), heap all=
oc:on, heap free:off
Apr 16 15:58:05 meterpeter kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObje=
cts=3D0, CPUs=3D12, Nodes=3D1
Apr 16 15:58:05 meterpeter kernel: ftrace: allocating 55202 entries in 216 =
pages
Apr 16 15:58:05 meterpeter kernel: ftrace: allocated 216 pages with 4 groups
Apr 16 15:58:05 meterpeter kernel: Dynamic Preempt: full
Apr 16 15:58:05 meterpeter kernel: rcu: Preemptible hierarchical RCU implem=
entation.
Apr 16 15:58:05 meterpeter kernel: rcu:         RCU restricting CPUs from N=
R_CPUS=3D8192 to nr_cpu_ids=3D12.
Apr 16 15:58:05 meterpeter kernel: rcu:         RCU priority boosting: prio=
rity 1 delay 500 ms.
Apr 16 15:58:05 meterpeter kernel:         Trampoline variant of Tasks RCU =
enabled.
Apr 16 15:58:05 meterpeter kernel:         Rude variant of Tasks RCU enable=
d.
Apr 16 15:58:05 meterpeter kernel:         Tracing variant of Tasks RCU ena=
bled.
Apr 16 15:58:05 meterpeter kernel: rcu: RCU calculated value of scheduler-e=
nlistment delay is 100 jiffies.
Apr 16 15:58:05 meterpeter kernel: rcu: Adjusting geometry for rcu_fanout_l=
eaf=3D16, nr_cpu_ids=3D12
Apr 16 15:58:05 meterpeter kernel: RCU Tasks: Setting shift to 4 and lim to=
 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:58:05 meterpeter kernel: RCU Tasks Rude: Setting shift to 4 and l=
im to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:58:05 meterpeter kernel: RCU Tasks Trace: Setting shift to 4 and =
lim to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D12.
Apr 16 15:58:05 meterpeter kernel: NR_IRQS: 524544, nr_irqs: 1064, prealloc=
ated irqs: 16
Apr 16 15:58:05 meterpeter kernel: rcu: srcu_init: Setting srcu_struct size=
s based on contention.
Apr 16 15:58:05 meterpeter kernel: kfence: initialized - using 2097152 byte=
s for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Apr 16 15:58:05 meterpeter kernel: Console: colour dummy device 80x25
Apr 16 15:58:05 meterpeter kernel: printk: legacy console [tty0] enabled
Apr 16 15:58:05 meterpeter kernel: ACPI: Core revision 20240827
Apr 16 15:58:05 meterpeter kernel: clocksource: hpet: mask: 0xffffffff max_=
cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Apr 16 15:58:05 meterpeter kernel: APIC: Switch to symmetric I/O mode setup
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR0, rdevid:0xa0
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR1, rdevid:0xa0
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR2, rdevid:0xa0
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB=
=2EFUR3, rdevid:0xa0
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: Using global IVHD EFR:0x206d73ef=
22254ade, EFR2:0x0
Apr 16 15:58:05 meterpeter kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D=
2 apic2=3D-1 pin2=3D-1
Apr 16 15:58:05 meterpeter kernel: clocksource: tsc-early: mask: 0xffffffff=
ffffffff max_cycles: 0x1e366dea90d, max_idle_ns: 440795276822 ns
Apr 16 15:58:05 meterpeter kernel: Calibrating delay loop (skipped), value =
calculated using timer frequency.. 4192.00 BogoMIPS (lpj=3D2096000)
Apr 16 15:58:05 meterpeter kernel: x86/cpu: User Mode Instruction Preventio=
n (UMIP) activated
Apr 16 15:58:05 meterpeter kernel: LVT offset 1 assigned for vector 0xf9
Apr 16 15:58:05 meterpeter kernel: LVT offset 2 assigned for vector 0xf4
Apr 16 15:58:05 meterpeter kernel: Last level iTLB entries: 4KB 1024, 2MB 1=
024, 4MB 512
Apr 16 15:58:05 meterpeter kernel: Last level dTLB entries: 4KB 2048, 2MB 2=
048, 4MB 1024, 1GB 0
Apr 16 15:58:05 meterpeter kernel: process: using mwait in idle threads
Apr 16 15:58:05 meterpeter kernel: Spectre V1 : Mitigation: usercopy/swapgs=
 barriers and __user pointer sanitization
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : Mitigation: Retpolines
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : Spectre v2 / SpectreRSB: Fi=
lling RSB on context switch and VMEXIT
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : Enabling Speculation Barrie=
r for firmware calls
Apr 16 15:58:05 meterpeter kernel: RETBleed: Mitigation: untrained return t=
hunk
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : mitigation: Enabling condit=
ional Indirect Branch Prediction Barrier
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : Selecting STIBP always-on m=
ode to complement retbleed mitigation
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : User space: Mitigation: STI=
BP always-on protection
Apr 16 15:58:05 meterpeter kernel: Speculative Store Bypass: Mitigation: Sp=
eculative Store Bypass disabled via prctl
Apr 16 15:58:05 meterpeter kernel: Speculative Return Stack Overflow: Mitig=
ation: Safe RET
Apr 16 15:58:05 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x001:=
 'x87 floating point registers'
Apr 16 15:58:05 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x002:=
 'SSE registers'
Apr 16 15:58:05 meterpeter kernel: x86/fpu: Supporting XSAVE feature 0x004:=
 'AVX registers'
Apr 16 15:58:05 meterpeter kernel: x86/fpu: xstate_offset[2]:  576, xstate_=
sizes[2]:  256
Apr 16 15:58:05 meterpeter kernel: x86/fpu: Enabled xstate features 0x7, co=
ntext size is 832 bytes, using 'compacted' format.
Apr 16 15:58:05 meterpeter kernel: Freeing SMP alternatives memory: 52K
Apr 16 15:58:05 meterpeter kernel: pid_max: default: 32768 minimum: 301
Apr 16 15:58:05 meterpeter kernel: LSM: initializing lsm=3Dcapability,landl=
ock,lockdown,yama,bpf
Apr 16 15:58:05 meterpeter kernel: landlock: Up and running.
Apr 16 15:58:05 meterpeter kernel: Yama: becoming mindful.
Apr 16 15:58:05 meterpeter kernel: LSM support for eBPF active
Apr 16 15:58:05 meterpeter kernel: Mount-cache hash table entries: 32768 (o=
rder: 6, 262144 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: Mountpoint-cache hash table entries: 327=
68 (order: 6, 262144 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: smpboot: CPU0: AMD Ryzen 5 5500U with Ra=
deon Graphics (family: 0x17, model: 0x68, stepping: 0x1)
Apr 16 15:58:05 meterpeter kernel: Performance Events: Fam17h+ core perfctr=
, AMD PMU driver.
Apr 16 15:58:05 meterpeter kernel: ... version:                0
Apr 16 15:58:05 meterpeter kernel: ... bit width:              48
Apr 16 15:58:05 meterpeter kernel: ... generic registers:      6
Apr 16 15:58:05 meterpeter kernel: ... value mask:             0000ffffffff=
ffff
Apr 16 15:58:05 meterpeter kernel: ... max period:             00007fffffff=
ffff
Apr 16 15:58:05 meterpeter kernel: ... fixed-purpose events:   0
Apr 16 15:58:05 meterpeter kernel: ... event mask:             000000000000=
003f
Apr 16 15:58:05 meterpeter kernel: signal: max sigframe size: 1776
Apr 16 15:58:05 meterpeter kernel: rcu: Hierarchical SRCU implementation.
Apr 16 15:58:05 meterpeter kernel: rcu:         Max phase no-delay instance=
s is 400.
Apr 16 15:58:05 meterpeter kernel: Timer migration: 2 hierarchy levels; 8 c=
hildren per group; 2 crossnode level
Apr 16 15:58:05 meterpeter kernel: MCE: In-kernel MCE decoding enabled.
Apr 16 15:58:05 meterpeter kernel: NMI watchdog: Enabled. Permanently consu=
mes one hw-PMU counter.
Apr 16 15:58:05 meterpeter kernel: smp: Bringing up secondary CPUs ...
Apr 16 15:58:05 meterpeter kernel: smpboot: x86: Booting SMP configuration:
Apr 16 15:58:05 meterpeter kernel: .... node  #0, CPUs:        #2  #4  #6  =
#8 #10  #1  #3  #5  #7  #9 #11
Apr 16 15:58:05 meterpeter kernel: Spectre V2 : Update user space SMT mitig=
ation: STIBP always-on
Apr 16 15:58:05 meterpeter kernel: smp: Brought up 1 node, 12 CPUs
Apr 16 15:58:05 meterpeter kernel: smpboot: Total of 12 processors activate=
d (50304.00 BogoMIPS)
Apr 16 15:58:05 meterpeter kernel: Memory: 15076768K/15542712K available (1=
9381K kernel code, 2931K rwdata, 16404K rodata, 4552K init, 4860K bss, 4456=
28K reserved, 0K cma-reserved)
Apr 16 15:58:05 meterpeter kernel: devtmpfs: initialized
Apr 16 15:58:05 meterpeter kernel: x86/mm: Memory block size: 128MB
Apr 16 15:58:05 meterpeter kernel: ACPI: PM: Registering ACPI NVS region [m=
em 0x09f00000-0x09f0efff] (61440 bytes)
Apr 16 15:58:05 meterpeter kernel: ACPI: PM: Registering ACPI NVS region [m=
em 0xcad7e000-0xcc17dfff] (20971520 bytes)
Apr 16 15:58:05 meterpeter kernel: clocksource: jiffies: mask: 0xffffffff m=
ax_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Apr 16 15:58:05 meterpeter kernel: posixtimers hash table entries: 8192 (or=
der: 5, 131072 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: futex hash table entries: 4096 (order: 6=
, 262144 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: pinctrl core: initialized pinctrl subsys=
tem
Apr 16 15:58:05 meterpeter kernel: PM: RTC time: 13:57:51, date: 2025-04-16
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_NETLINK/PF_ROUTE prot=
ocol family
Apr 16 15:58:05 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL po=
ol for atomic allocations
Apr 16 15:58:05 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GF=
P_DMA pool for atomic allocations
Apr 16 15:58:05 meterpeter kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GF=
P_DMA32 pool for atomic allocations
Apr 16 15:58:05 meterpeter kernel: audit: initializing netlink subsys (disa=
bled)
Apr 16 15:58:05 meterpeter kernel: audit: type=3D2000 audit(1744811871.173:=
1): state=3Dinitialized audit_enabled=3D0 res=3D1
Apr 16 15:58:05 meterpeter kernel: thermal_sys: Registered thermal governor=
 'fair_share'
Apr 16 15:58:05 meterpeter kernel: thermal_sys: Registered thermal governor=
 'bang_bang'
Apr 16 15:58:05 meterpeter kernel: thermal_sys: Registered thermal governor=
 'step_wise'
Apr 16 15:58:05 meterpeter kernel: thermal_sys: Registered thermal governor=
 'user_space'
Apr 16 15:58:05 meterpeter kernel: thermal_sys: Registered thermal governor=
 'power_allocator'
Apr 16 15:58:05 meterpeter kernel: cpuidle: using governor ladder
Apr 16 15:58:05 meterpeter kernel: cpuidle: using governor menu
Apr 16 15:58:05 meterpeter kernel: ACPI FADT declares the system doesn't su=
pport PCIe ASPM, so disable it
Apr 16 15:58:05 meterpeter kernel: acpiphp: ACPI Hot Plug PCI Controller Dr=
iver version: 0.5
Apr 16 15:58:05 meterpeter kernel: PCI: ECAM [mem 0xf8000000-0xfbffffff] (b=
ase 0xf8000000) for domain 0000 [bus 00-3f]
Apr 16 15:58:05 meterpeter kernel: PCI: Using configuration type 1 for base=
 access
Apr 16 15:58:05 meterpeter kernel: kprobes: kprobe jump-optimization is ena=
bled. All kprobes are optimized if possible.
Apr 16 15:58:05 meterpeter kernel: HugeTLB: allocation took 0ms with hugepa=
ge_allocation_threads=3D3
Apr 16 15:58:05 meterpeter kernel: HugeTLB: registered 1.00 GiB page size, =
pre-allocated 0 pages
Apr 16 15:58:05 meterpeter kernel: HugeTLB: 16380 KiB vmemmap can be freed =
for a 1.00 GiB page
Apr 16 15:58:05 meterpeter kernel: HugeTLB: registered 2.00 MiB page size, =
pre-allocated 0 pages
Apr 16 15:58:05 meterpeter kernel: HugeTLB: 28 KiB vmemmap can be freed for=
 a 2.00 MiB page
Apr 16 15:58:05 meterpeter kernel: raid6: skipped pq benchmark and selected=
 avx2x4
Apr 16 15:58:05 meterpeter kernel: raid6: using avx2x2 recovery algorithm
Apr 16 15:58:05 meterpeter kernel: ACPI: Added _OSI(Module Device)
Apr 16 15:58:05 meterpeter kernel: ACPI: Added _OSI(Processor Device)
Apr 16 15:58:05 meterpeter kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Apr 16 15:58:05 meterpeter kernel: ACPI: Added _OSI(Processor Aggregator De=
vice)
Apr 16 15:58:05 meterpeter kernel: ACPI: 12 ACPI AML tables successfully ac=
quired and loaded
Apr 16 15:58:05 meterpeter kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) q=
uery ignored
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: EC started
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: interrupt blocked
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=
=3D0x62
Apr 16 15:58:05 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC=
 used to handle transactions
Apr 16 15:58:05 meterpeter kernel: ACPI: Interpreter enabled
Apr 16 15:58:05 meterpeter kernel: ACPI: PM: (supports S0 S3 S4 S5)
Apr 16 15:58:05 meterpeter kernel: ACPI: Using IOAPIC for interrupt routing
Apr 16 15:58:05 meterpeter kernel: PCI: Using host bridge windows from ACPI=
; if necessary, use "pci=3Dnocrs" and report a bug
Apr 16 15:58:05 meterpeter kernel: PCI: Using E820 reservations for host br=
idge windows
Apr 16 15:58:05 meterpeter kernel: ACPI: \_SB_.PCI0.GPP5.PXSX.WRST: New pow=
er resource
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI Root Bridge [PCI0] (domain 000=
0 [bus 00-ff])
Apr 16 15:58:05 meterpeter kernel: acpi PNP0A08:00: _OSC: OS supports [Exte=
ndedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Apr 16 15:58:05 meterpeter kernel: acpi PNP0A08:00: _OSC: platform does not=
 support [SHPCHotplug LTR DPC]
Apr 16 15:58:05 meterpeter kernel: acpi PNP0A08:00: _OSC: OS now controls [=
PCIeHotplug PME AER PCIeCapability]
Apr 16 15:58:05 meterpeter kernel: acpi PNP0A08:00: FADT indicates ASPM is =
unsupported, using BIOS configuration
Apr 16 15:58:05 meterpeter kernel: acpi PNP0A08:00: [Firmware Info]: ECAM [=
mem 0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially cover=
s this bridge
Apr 16 15:58:05 meterpeter kernel: PCI host bridge to bus 0000:00
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000effff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0xd0000000-0xf7ffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0xfc000000-0xfdffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [mem =
0x430000000-0xffffffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [io  =
0x0000-0x0cf7 window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [io  =
0x0d00-0xffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: root bus resource [bus =
00-ff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:00.0: [1022:1630] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:00.2: [1022:1631] type 00 cl=
ass 0x080600 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:01.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1:   bridge window [mem 0=
xfd600000-0xfd6fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2:   bridge window [io  0=
x3000-0x3fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2:   bridge window [mem 0=
xfd500000-0xfd5fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: [1022:1634] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3:   bridge window [io  0=
x2000-0x2fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
xfd400000-0xfd4fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.0: [1022:1632] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: [1022:1635] type 01 cl=
ass 0x060400 PCIe Root Port
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [io  0=
x1000-0x1fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
xfd000000-0xfd3fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
x460000000-0x4701fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:14.0: [1022:790b] type 00 cl=
ass 0x0c0500 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:14.3: [1022:790e] type 00 cl=
ass 0x060100 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.0: [1022:1448] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.1: [1022:1449] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.2: [1022:144a] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.3: [1022:144b] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.4: [1022:144c] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.5: [1022:144d] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.6: [1022:144e] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.7: [1022:144f] type 00 cl=
ass 0x060000 conventional PCI endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:01:00.0: [144d:a809] type 00 cl=
ass 0x010802 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:01:00.0: BAR 0 [mem 0xfd600000-=
0xfd603fff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: [10ec:8168] type 00 cl=
ass 0x020000 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: BAR 0 [io  0x3000-0x30=
ff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: BAR 2 [mem 0xfd504000-=
0xfd504fff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: BAR 4 [mem 0xfd500000-=
0xfd503fff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: supports D1 D2
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: PME# supported from D0=
 D1 D2 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: [10ec:c822] type 00 cl=
ass 0x028000 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: BAR 0 [io  0x2000-0x20=
ff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: BAR 2 [mem 0xfd400000-=
0xfd40ffff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: supports D1 D2
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: PME# supported from D0=
 D1 D2 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: [1002:164c] type 00 cl=
ass 0x030000 PCIe Legacy Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: BAR 0 [mem 0x460000000=
-0x46fffffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: BAR 2 [mem 0x470000000=
-0x4701fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: BAR 4 [io  0x1000-0x10=
ff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: BAR 5 [mem 0xfd300000-=
0xfd37ffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: PME# supported from D1=
 D2 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: [1002:1637] type 00 cl=
ass 0x040300 PCIe Legacy Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: BAR 0 [mem 0xfd3c8000-=
0xfd3cbfff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: PME# supported from D1=
 D2 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.2: [1022:15df] type 00 cl=
ass 0x108000 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.2: BAR 2 [mem 0xfd200000-=
0xfd2fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.2: BAR 5 [mem 0xfd3cc000-=
0xfd3cdfff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.2: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: [1022:1639] type 00 cl=
ass 0x0c0330 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: BAR 0 [mem 0xfd000000-=
0xfd0fffff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: [1022:1639] type 00 cl=
ass 0x0c0330 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: BAR 0 [mem 0xfd100000-=
0xfd1fffff 64bit]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.5: [1022:15e2] type 00 cl=
ass 0x048000 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.5: BAR 0 [mem 0xfd380000-=
0xfd3bffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.5: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.5: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.6: [1022:15e3] type 00 cl=
ass 0x040300 PCIe Endpoint
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.6: BAR 0 [mem 0xfd3c0000-=
0xfd3c7fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.6: enabling Extended Tags
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.6: PME# supported from D0=
 D3hot D3cold
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKA configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKB configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKC configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKD configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKE configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKF configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKG configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: PCI: Interrupt link LNKH configure=
d for IRQ 0
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: interrupt unblocked
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: event unblocked
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=
=3D0x62
Apr 16 15:58:05 meterpeter kernel: ACPI: EC: GPE=3D0x3
Apr 16 15:58:05 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC=
 initialization complete
Apr 16 15:58:05 meterpeter kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to =
handle transactions and events
Apr 16 15:58:05 meterpeter kernel: iommu: Default domain type: Translated
Apr 16 15:58:05 meterpeter kernel: iommu: DMA domain TLB invalidation polic=
y: lazy mode
Apr 16 15:58:05 meterpeter kernel: SCSI subsystem initialized
Apr 16 15:58:05 meterpeter kernel: libata version 3.00 loaded.
Apr 16 15:58:05 meterpeter kernel: ACPI: bus type USB registered
Apr 16 15:58:05 meterpeter kernel: usbcore: registered new interface driver=
 usbfs
Apr 16 15:58:05 meterpeter kernel: usbcore: registered new interface driver=
 hub
Apr 16 15:58:05 meterpeter kernel: usbcore: registered new device driver usb
Apr 16 15:58:05 meterpeter kernel: EDAC MC: Ver: 3.0.0
Apr 16 15:58:05 meterpeter kernel: efivars: Registered efivars operations
Apr 16 15:58:05 meterpeter kernel: NetLabel: Initializing
Apr 16 15:58:05 meterpeter kernel: NetLabel:  domain hash size =3D 128
Apr 16 15:58:05 meterpeter kernel: NetLabel:  protocols =3D UNLABELED CIPSO=
v4 CALIPSO
Apr 16 15:58:05 meterpeter kernel: NetLabel:  unlabeled traffic allowed by =
default
Apr 16 15:58:05 meterpeter kernel: mctp: management component transport pro=
tocol core
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_MCTP protocol family
Apr 16 15:58:05 meterpeter kernel: PCI: Using ACPI for IRQ routing
Apr 16 15:58:05 meterpeter kernel: PCI: pci_cache_line_size set to 64 bytes
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0x0009f000=
-0x0009ffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0x09c00000=
-0x0bffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0x09f00000=
-0x0bffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0xc0cdc000=
-0xc3ffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0xc323a000=
-0xc3ffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0xc4b7e000=
-0xc7ffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0xce000000=
-0xcfffffff]
Apr 16 15:58:05 meterpeter kernel: e820: reserve RAM buffer [mem 0x3ee30000=
0-0x3efffffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: vgaarb: setting as boo=
t VGA device
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: vgaarb: bridge control=
 possible
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: vgaarb: VGA device add=
ed: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
Apr 16 15:58:05 meterpeter kernel: vgaarb: loaded
Apr 16 15:58:05 meterpeter kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Apr 16 15:58:05 meterpeter kernel: hpet0: 3 comparators, 32-bit 14.318180 M=
Hz counter
Apr 16 15:58:05 meterpeter kernel: clocksource: Switched to clocksource tsc=
-early
Apr 16 15:58:05 meterpeter kernel: VFS: Disk quotas dquot_6.6.0
Apr 16 15:58:05 meterpeter kernel: VFS: Dquot-cache hash table entries: 512=
 (order 0, 4096 bytes)
Apr 16 15:58:05 meterpeter kernel: pnp: PnP ACPI init
Apr 16 15:58:05 meterpeter kernel: system 00:00: [mem 0xfec00000-0xfec01fff=
] could not be reserved
Apr 16 15:58:05 meterpeter kernel: system 00:00: [mem 0xfee00000-0xfee00fff=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: system 00:00: [mem 0xf8000000-0xfbffffff=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0400-0x04cf] has be=
en reserved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x04d0-0x04d1] has be=
en reserved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x04d6] has been rese=
rved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0c00-0x0c01] has be=
en reserved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0c14] has been rese=
rved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0c50-0x0c52] has be=
en reserved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0c6c] has been rese=
rved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0c6f] has been rese=
rved
Apr 16 15:58:05 meterpeter kernel: system 00:02: [io  0x0cd0-0x0cdb] has be=
en reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0x000e0000-0x000fffff=
] could not be reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0x00000000-0x01ffffff=
] could not be reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0xfec10000-0xfec1001f=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0xfed00000-0xfed003ff=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0xfed61000-0xfed613ff=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: system 00:03: [mem 0xfed80000-0xfed80fff=
] has been reserved
Apr 16 15:58:05 meterpeter kernel: pnp: PnP ACPI: found 6 devices
Apr 16 15:58:05 meterpeter kernel: clocksource: acpi_pm: mask: 0xffffff max=
_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_INET protocol family
Apr 16 15:58:05 meterpeter kernel: IP idents hash table entries: 262144 (or=
der: 9, 2097152 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: tcp_listen_portaddr_hash hash table entr=
ies: 8192 (order: 5, 131072 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: Table-perturb hash table entries: 65536 =
(order: 6, 262144 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: TCP established hash table entries: 1310=
72 (order: 8, 1048576 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: TCP bind hash table entries: 65536 (orde=
r: 9, 2097152 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: TCP: Hash tables configured (established=
 131072 bind 65536)
Apr 16 15:58:05 meterpeter kernel: MPTCP token hash table entries: 16384 (o=
rder: 6, 393216 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: UDP hash table entries: 8192 (order: 7, =
524288 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: UDP-Lite hash table entries: 8192 (order=
: 7, 524288 bytes, linear)
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_UNIX/PF_LOCAL protoco=
l family
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_XDP protocol family
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: bridge window [mem 0x0=
0100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: bridge window [mem 0x4=
30000000-0x4301fffff 64bit pref]: assigned
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: PCI bridge to [bus 01]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1:   bridge window [mem 0=
xfd600000-0xfd6fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: PCI bridge to [bus 02]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2:   bridge window [io  0=
x3000-0x3fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2:   bridge window [mem 0=
xfd500000-0xfd5fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: PCI bridge to [bus 03]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3:   bridge window [io  0=
x2000-0x2fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
xfd400000-0xfd4fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3:   bridge window [mem 0=
x430000000-0x4301fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: PCI bridge to [bus 04]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [io  0=
x1000-0x1fff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
xfd000000-0xfd3fffff]
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1:   bridge window [mem 0=
x460000000-0x4701fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 4 [mem 0x000a0=
000-0x000effff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 5 [mem 0xd0000=
000-0xf7ffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 6 [mem 0xfc000=
000-0xfdffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 7 [mem 0x43000=
0000-0xffffffffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 8 [io  0x0000-=
0x0cf7 window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:00: resource 9 [io  0x0d00-=
0xffff window]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:01: resource 1 [mem 0xfd600=
000-0xfd6fffff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:02: resource 0 [io  0x3000-=
0x3fff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:02: resource 1 [mem 0xfd500=
000-0xfd5fffff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:03: resource 0 [io  0x2000-=
0x2fff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:03: resource 1 [mem 0xfd400=
000-0xfd4fffff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:03: resource 2 [mem 0x43000=
0000-0x4301fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:04: resource 0 [io  0x1000-=
0x1fff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:04: resource 1 [mem 0xfd000=
000-0xfd3fffff]
Apr 16 15:58:05 meterpeter kernel: pci_bus 0000:04: resource 2 [mem 0x46000=
0000-0x4701fffff 64bit pref]
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: D0 power state depends=
 on 0000:04:00.0
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: extending delay after =
power-on from D3hot to 20 msec
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: extending delay after =
power-on from D3hot to 20 msec
Apr 16 15:58:05 meterpeter kernel: PCI: CLS 32 bytes, default 64
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:00.2: AMD-Vi: IOMMU performa=
nce counters supported
Apr 16 15:58:05 meterpeter kernel: Trying to unpack rootfs image as initram=
fs...
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:00.0: Adding to iommu group 0
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:01.0: Adding to iommu group 1
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.0: Adding to iommu group 2
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.1: Adding to iommu group 3
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.2: Adding to iommu group 4
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:02.3: Adding to iommu group 5
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.0: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:08.1: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:14.0: Adding to iommu group 7
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:14.3: Adding to iommu group 7
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.0: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.1: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.2: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.3: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.4: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.5: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.6: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:00:18.7: Adding to iommu group 8
Apr 16 15:58:05 meterpeter kernel: pci 0000:01:00.0: Adding to iommu group 9
Apr 16 15:58:05 meterpeter kernel: pci 0000:02:00.0: Adding to iommu group =
10
Apr 16 15:58:05 meterpeter kernel: pci 0000:03:00.0: Adding to iommu group =
11
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.0: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.1: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.2: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.3: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.4: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.5: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: pci 0000:04:00.6: Adding to iommu group 6
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: Extended features (0x206d73ef222=
54ade, 0x0): PPR X2APIC NX GT IA GA PC GA_vAPIC
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: Interrupt remapping enabled
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: X2APIC enabled
Apr 16 15:58:05 meterpeter kernel: AMD-Vi: Virtual APIC enabled
Apr 16 15:58:05 meterpeter kernel: PCI-DMA: Using software bounce buffering=
 for IO (SWIOTLB)
Apr 16 15:58:05 meterpeter kernel: software IO TLB: mapped [mem 0x00000000b=
c19f000-0x00000000c019f000] (64MB)
Apr 16 15:58:05 meterpeter kernel: LVT offset 0 assigned for vector 0x400
Apr 16 15:58:05 meterpeter kernel: perf: AMD IBS detected (0x000003ff)
Apr 16 15:58:05 meterpeter kernel: perf/amd_iommu: Detected AMD IOMMU #0 (2=
 banks, 4 counters/bank).
Apr 16 15:58:05 meterpeter kernel: Initialise system trusted keyrings
Apr 16 15:58:05 meterpeter kernel: Key type blacklist registered
Apr 16 15:58:05 meterpeter kernel: workingset: timestamp_bits=3D36 max_orde=
r=3D22 bucket_order=3D0
Apr 16 15:58:05 meterpeter kernel: fuse: init (API version 7.43)
Apr 16 15:58:05 meterpeter kernel: integrity: Platform Keyring initialized
Apr 16 15:58:05 meterpeter kernel: integrity: Machine keyring initialized
Apr 16 15:58:05 meterpeter kernel: xor: automatically using best checksummi=
ng function   avx      =20
Apr 16 15:58:05 meterpeter kernel: Key type asymmetric registered
Apr 16 15:58:05 meterpeter kernel: Asymmetric key parser 'x509' registered
Apr 16 15:58:05 meterpeter kernel: Block layer SCSI generic (bsg) driver ve=
rsion 0.4 loaded (major 246)
Apr 16 15:58:05 meterpeter kernel: io scheduler mq-deadline registered
Apr 16 15:58:05 meterpeter kernel: io scheduler kyber registered
Apr 16 15:58:05 meterpeter kernel: io scheduler bfq registered
Apr 16 15:58:05 meterpeter kernel: ledtrig-cpu: registered to indicate acti=
vity on CPUs
Apr 16 15:58:05 meterpeter kernel: pcieport 0000:00:02.1: PME: Signaling wi=
th IRQ 28
Apr 16 15:58:05 meterpeter kernel: pcieport 0000:00:02.2: PME: Signaling wi=
th IRQ 29
Apr 16 15:58:05 meterpeter kernel: pcieport 0000:00:02.3: PME: Signaling wi=
th IRQ 30
Apr 16 15:58:05 meterpeter kernel: pcieport 0000:00:02.3: pciehp: Slot #0 A=
ttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoComp=
l+ IbPresDis- LLActRep+
Apr 16 15:58:05 meterpeter kernel: pcieport 0000:00:08.1: PME: Signaling wi=
th IRQ 31
Apr 16 15:58:05 meterpeter kernel: ACPI: AC: AC Adapter [AC] (off-line)
Apr 16 15:58:05 meterpeter kernel: input: Power Button as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0C:00/input/input0
Apr 16 15:58:05 meterpeter kernel: ACPI: button: Power Button [PWRB]
Apr 16 15:58:05 meterpeter kernel: input: Lid Switch as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0D:00/input/input1
Apr 16 15:58:05 meterpeter kernel: ACPI: button: Lid Switch [LID]
Apr 16 15:58:05 meterpeter kernel: input: Sleep Button as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0E:00/input/input2
Apr 16 15:58:05 meterpeter kernel: ACPI: button: Sleep Button [SLPB]
Apr 16 15:58:05 meterpeter kernel: input: Power Button as /devices/LNXSYSTM=
:00/LNXPWRBN:00/input/input3
Apr 16 15:58:05 meterpeter kernel: ACPI: button: Power Button [PWRF]
Apr 16 15:58:05 meterpeter kernel: Monitor-Mwait will be used to enter C-1 =
state
Apr 16 15:58:05 meterpeter kernel: Estimated ratio of average max frequency=
 by base frequency (times 1024): 1501
Apr 16 15:58:05 meterpeter kernel: Serial: 8250/16550 driver, 32 ports, IRQ=
 sharing enabled
Apr 16 15:58:05 meterpeter kernel: ACPI: battery: Slot [BAT0] (battery pres=
ent)
Apr 16 15:58:05 meterpeter kernel: Non-volatile memory driver v1.3
Apr 16 15:58:05 meterpeter kernel: Linux agpgart interface v0.103
Apr 16 15:58:05 meterpeter kernel: tpm_tis STM0125:00: 2.0 TPM (device-id 0=
x0, rev-id 78)
Apr 16 15:58:05 meterpeter kernel: Freeing initrd memory: 44708K
Apr 16 15:58:05 meterpeter kernel: ACPI: bus type drm_connector registered
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: xHCI Host Control=
ler
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: new USB bus regis=
tered, assigned bus number 1
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: hcc params 0x0268=
ffe5 hci version 0x110 quirks 0x0000020000000010
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: xHCI Host Control=
ler
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: new USB bus regis=
tered, assigned bus number 2
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.3: Host supports USB=
 3.1 Enhanced SuperSpeed
Apr 16 15:58:05 meterpeter kernel: usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15
Apr 16 15:58:05 meterpeter kernel: usb usb1: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:58:05 meterpeter kernel: usb usb1: Product: xHCI Host Controller
Apr 16 15:58:05 meterpeter kernel: usb usb1: Manufacturer: Linux 6.15.0-rc2=
-1-mainline xhci-hcd
Apr 16 15:58:05 meterpeter kernel: usb usb1: SerialNumber: 0000:04:00.3
Apr 16 15:58:05 meterpeter kernel: hub 1-0:1.0: USB hub found
Apr 16 15:58:05 meterpeter kernel: hub 1-0:1.0: 4 ports detected
Apr 16 15:58:05 meterpeter kernel: usb usb2: We don't know the algorithms f=
or LPM for this host, disabling LPM.
Apr 16 15:58:05 meterpeter kernel: usb usb2: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.15
Apr 16 15:58:05 meterpeter kernel: usb usb2: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:58:05 meterpeter kernel: usb usb2: Product: xHCI Host Controller
Apr 16 15:58:05 meterpeter kernel: usb usb2: Manufacturer: Linux 6.15.0-rc2=
-1-mainline xhci-hcd
Apr 16 15:58:05 meterpeter kernel: usb usb2: SerialNumber: 0000:04:00.3
Apr 16 15:58:05 meterpeter kernel: hub 2-0:1.0: USB hub found
Apr 16 15:58:05 meterpeter kernel: hub 2-0:1.0: 2 ports detected
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: xHCI Host Control=
ler
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: new USB bus regis=
tered, assigned bus number 3
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: hcc params 0x0268=
ffe5 hci version 0x110 quirks 0x0000020000000010
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: xHCI Host Control=
ler
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: new USB bus regis=
tered, assigned bus number 4
Apr 16 15:58:05 meterpeter kernel: xhci_hcd 0000:04:00.4: Host supports USB=
 3.1 Enhanced SuperSpeed
Apr 16 15:58:05 meterpeter kernel: usb usb3: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15
Apr 16 15:58:05 meterpeter kernel: usb usb3: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:58:05 meterpeter kernel: usb usb3: Product: xHCI Host Controller
Apr 16 15:58:05 meterpeter kernel: usb usb3: Manufacturer: Linux 6.15.0-rc2=
-1-mainline xhci-hcd
Apr 16 15:58:05 meterpeter kernel: usb usb3: SerialNumber: 0000:04:00.4
Apr 16 15:58:05 meterpeter kernel: hub 3-0:1.0: USB hub found
Apr 16 15:58:05 meterpeter kernel: hub 3-0:1.0: 4 ports detected
Apr 16 15:58:05 meterpeter kernel: usb usb4: We don't know the algorithms f=
or LPM for this host, disabling LPM.
Apr 16 15:58:05 meterpeter kernel: usb usb4: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.15
Apr 16 15:58:05 meterpeter kernel: usb usb4: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Apr 16 15:58:05 meterpeter kernel: usb usb4: Product: xHCI Host Controller
Apr 16 15:58:05 meterpeter kernel: usb usb4: Manufacturer: Linux 6.15.0-rc2=
-1-mainline xhci-hcd
Apr 16 15:58:05 meterpeter kernel: usb usb4: SerialNumber: 0000:04:00.4
Apr 16 15:58:05 meterpeter kernel: hub 4-0:1.0: USB hub found
Apr 16 15:58:05 meterpeter kernel: hub 4-0:1.0: 2 ports detected
Apr 16 15:58:05 meterpeter kernel: usbcore: registered new interface driver=
 usbserial_generic
Apr 16 15:58:05 meterpeter kernel: usbserial: USB Serial support registered=
 for generic
Apr 16 15:58:05 meterpeter kernel: rtc_cmos 00:01: RTC can wake from S4
Apr 16 15:58:05 meterpeter kernel: rtc_cmos 00:01: registered as rtc0
Apr 16 15:58:05 meterpeter kernel: rtc_cmos 00:01: setting system clock to =
2025-04-16T13:57:52 UTC (1744811872)
Apr 16 15:58:05 meterpeter kernel: rtc_cmos 00:01: alarms up to one month, =
y3k, 114 bytes nvram
Apr 16 15:58:05 meterpeter kernel: simple-framebuffer simple-framebuffer.0:=
 [drm] Registered 1 planes with drm panic
Apr 16 15:58:05 meterpeter kernel: [drm] Initialized simpledrm 1.0.0 for si=
mple-framebuffer.0 on minor 0
Apr 16 15:58:05 meterpeter kernel: fbcon: Deferring console take-over
Apr 16 15:58:05 meterpeter kernel: simple-framebuffer simple-framebuffer.0:=
 [drm] fb0: simpledrmdrmfb frame buffer device
Apr 16 15:58:05 meterpeter kernel: hid: raw HID events driver (C) Jiri Kosi=
na
Apr 16 15:58:05 meterpeter kernel: drop_monitor: Initializing network drop =
monitor service
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_INET6 protocol family
Apr 16 15:58:05 meterpeter kernel: Segment Routing with IPv6
Apr 16 15:58:05 meterpeter kernel: RPL Segment Routing with IPv6
Apr 16 15:58:05 meterpeter kernel: In-situ OAM (IOAM) with IPv6
Apr 16 15:58:05 meterpeter kernel: NET: Registered PF_PACKET protocol family
Apr 16 15:58:05 meterpeter kernel: microcode: Current revision: 0x08608108
Apr 16 15:58:05 meterpeter kernel: microcode: Updated early from: 0x08608103
Apr 16 15:58:05 meterpeter kernel: resctrl: L3 allocation detected
Apr 16 15:58:05 meterpeter kernel: resctrl: MB allocation detected
Apr 16 15:58:05 meterpeter kernel: resctrl: L3 monitoring detected
Apr 16 15:58:05 meterpeter kernel: IPI shorthand broadcast: enabled
Apr 16 15:58:05 meterpeter kernel: sched_clock: Marking stable (736919018, =
346819)->(749081873, -11816036)
Apr 16 15:58:05 meterpeter kernel: registered taskstats version 1
Apr 16 15:58:05 meterpeter kernel: Loading compiled-in X.509 certificates
Apr 16 15:58:05 meterpeter kernel: Loaded X.509 cert 'Build time autogenera=
ted kernel key: 7dfb3eb74a5ed1dd30c882bd378468a81715fe46'
Apr 16 15:58:05 meterpeter kernel: zswap: loaded using pool zstd/zsmalloc
Apr 16 15:58:05 meterpeter kernel: Demotion targets for Node 0: null
Apr 16 15:58:05 meterpeter kernel: Key type .fscrypt registered
Apr 16 15:58:05 meterpeter kernel: Key type fscrypt-provisioning registered
Apr 16 15:58:05 meterpeter kernel: Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
Apr 16 15:58:05 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:58:05 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo Ltd=
=2E: ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
Apr 16 15:58:05 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:58:05 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo(Bei=
jing)Ltd: swqagent: 24b0bd0836b2f545edea93e058bd3a3c5a8f6a49'
Apr 16 15:58:05 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:58:05 meterpeter kernel: integrity: Loaded X.509 cert 'Lenovo UEF=
I CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
Apr 16 15:58:05 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:58:05 meterpeter kernel: integrity: Loaded X.509 cert 'Microsoft =
Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Apr 16 15:58:05 meterpeter kernel: integrity: Loading X.509 certificate: UE=
FI:db
Apr 16 15:58:05 meterpeter kernel: integrity: Loaded X.509 cert 'Microsoft =
Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce21f31686689c
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e70136ace3e73
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:8ad64859f195b5f58dafaa940b6a6167acd67a886e8f469364177221c55945b9
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:aeebae3151271273ed95aa2e671139ed31a98567303a332298f83709a9d55aa1
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c94d856967df8e
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:992d359aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
Apr 16 15:58:05 meterpeter kernel: blacklist: Duplicate blacklisted hash bi=
n:e051b788ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
Apr 16 15:58:05 meterpeter kernel: PM:   Magic number: 5:12:989
Apr 16 15:58:05 meterpeter kernel: machinecheck machinecheck2: hash matches
Apr 16 15:58:05 meterpeter kernel: memory memory32: hash matches
Apr 16 15:58:05 meterpeter kernel: RAS: Correctable Errors collector initia=
lized.
Apr 16 15:58:05 meterpeter kernel: clk: Disabling unused clocks
Apr 16 15:58:05 meterpeter kernel: PM: genpd: Disabling unused power domains
Apr 16 15:58:05 meterpeter kernel: Freeing unused decrypted memory: 2028K
Apr 16 15:58:05 meterpeter kernel: Freeing unused kernel image (initmem) me=
mory: 4552K
Apr 16 15:58:05 meterpeter kernel: Write protecting the kernel read-only da=
ta: 38912k
Apr 16 15:58:05 meterpeter kernel: Freeing unused kernel image (text/rodata=
 gap) memory: 1096K
Apr 16 15:58:05 meterpeter kernel: Freeing unused kernel image (rodata/data=
 gap) memory: 2028K
Apr 16 15:58:05 meterpeter kernel: x86/mm: Checked W+X mappings: passed, no=
 W+X pages found.
Apr 16 15:58:05 meterpeter kernel: rodata_test: all tests were successful
Apr 16 15:58:05 meterpeter kernel: Run /init as init process
Apr 16 15:58:05 meterpeter kernel:   with arguments:
Apr 16 15:58:05 meterpeter kernel:     /init
Apr 16 15:58:05 meterpeter kernel:   with environment:
Apr 16 15:58:05 meterpeter kernel:     HOME=3D/
Apr 16 15:58:05 meterpeter kernel:     TERM=3Dlinux
Apr 16 15:58:05 meterpeter kernel:     cryptdevice=3DUUID=3D8913bf3e-3df0-4=
78e-b072-f7bec731154b:archlinux
Apr 16 15:58:05 meterpeter kernel: fbcon: Taking over console
Apr 16 15:58:05 meterpeter kernel: Console: switching to colour frame buffe=
r device 240x67
Apr 16 15:58:05 meterpeter kernel: usb 1-3: new high-speed USB device numbe=
r 2 using xhci_hcd
Apr 16 15:58:05 meterpeter kernel: usb 3-3: new full-speed USB device numbe=
r 2 using xhci_hcd
Apr 16 15:58:05 meterpeter kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD=
,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Apr 16 15:58:05 meterpeter kernel: ACPI: video: Video Device [VGA] (multi-h=
ead: yes  rom: no  post: no)
Apr 16 15:58:05 meterpeter kernel: input: Video Bus as /devices/LNXSYSTM:00=
/LNXSYBUS:00/PNP0A08:00/device:0a/LNXVIDEO:00/input/input4
Apr 16 15:58:05 meterpeter kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 16 15:58:05 meterpeter kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 16 15:58:05 meterpeter kernel: Key type psk registered
Apr 16 15:58:05 meterpeter kernel: ccp 0000:04:00.2: enabling device (0000 =
-> 0002)
Apr 16 15:58:05 meterpeter kernel: ccp 0000:04:00.2: ccp: unable to access =
the device: you might be running a broken BIOS.
Apr 16 15:58:05 meterpeter kernel: ccp 0000:04:00.2: tee enabled
Apr 16 15:58:05 meterpeter kernel: ccp 0000:04:00.2: psp enabled
Apr 16 15:58:05 meterpeter kernel: cryptd: max_cpu_qlen set to 1000
Apr 16 15:58:05 meterpeter kernel: nvme nvme0: pci function 0000:01:00.0
Apr 16 15:58:05 meterpeter kernel: input: AT Translated Set 2 keyboard as /=
devices/platform/i8042/serio0/input/input5
Apr 16 15:58:05 meterpeter kernel: nvme nvme0: D3 entry latency set to 8 se=
conds
Apr 16 15:58:05 meterpeter kernel: usb 1-3: New USB device found, idVendor=
=3D13d3, idProduct=3D56fb, bcdDevice=3D20.04
Apr 16 15:58:05 meterpeter kernel: usb 1-3: New USB device strings: Mfr=3D3=
, Product=3D1, SerialNumber=3D2
Apr 16 15:58:05 meterpeter kernel: usb 1-3: Product: Integrated Camera
Apr 16 15:58:05 meterpeter kernel: usb 1-3: Manufacturer: Azurewave
Apr 16 15:58:05 meterpeter kernel: usb 1-3: SerialNumber: 0000
Apr 16 15:58:05 meterpeter kernel: nvme nvme0: allocated 64 MiB host memory=
 buffer (1 segment).
Apr 16 15:58:05 meterpeter kernel: usb 3-3: New USB device found, idVendor=
=3D06cb, idProduct=3D00fd, bcdDevice=3D 0.00
Apr 16 15:58:05 meterpeter kernel: usb 3-3: New USB device strings: Mfr=3D0=
, Product=3D0, SerialNumber=3D1
Apr 16 15:58:05 meterpeter kernel: usb 3-3: SerialNumber: 3b39bbc4a1e6
Apr 16 15:58:05 meterpeter kernel: nvme nvme0: 12/0/0 default/read/poll que=
ues
Apr 16 15:58:05 meterpeter kernel:  nvme0n1: p1 p2
Apr 16 15:58:05 meterpeter kernel: nvme nvme0: Failed to get ANA log: 2
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.26
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: ThinkPad BIOS R1OET26W (1=
=2E05 ), EC R1OHT26W
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: Lenovo ThinkPad E14 Gen 3=
, model 20YDS00G00
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: radio switch found; radio=
s are enabled
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: This ThinkPad has standar=
d ACPI backlight brightness control, supported by the ACPI video driver
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: Disabling thinkpad-acpi b=
rightness events by default...
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: rfkill switch tpacpi_blue=
tooth_sw: radio is unblocked
Apr 16 15:58:05 meterpeter kernel: usb 1-4: new high-speed USB device numbe=
r 3 using xhci_hcd
Apr 16 15:58:05 meterpeter kernel: usb 3-4: new full-speed USB device numbe=
r 3 using xhci_hcd
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: Standard ACPI backlight i=
nterface available, not loading native one
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: secondary fan control det=
ected & enabled
Apr 16 15:58:05 meterpeter kernel: thinkpad_acpi: battery 1 registered (sta=
rt 95, stop 100, behaviours: 0x7)
Apr 16 15:58:05 meterpeter kernel: ACPI: battery: new hook: ThinkPad Batter=
y Extension
Apr 16 15:58:05 meterpeter kernel: input: ThinkPad Extra Buttons as /device=
s/platform/thinkpad_acpi/input/input7
Apr 16 15:58:05 meterpeter kernel: usb 1-4: New USB device found, idVendor=
=3D18d1, idProduct=3D4ee2, bcdDevice=3D 4.19
Apr 16 15:58:05 meterpeter kernel: usb 1-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
Apr 16 15:58:05 meterpeter kernel: usb 1-4: Product: Fairphone 4 5G
Apr 16 15:58:05 meterpeter kernel: usb 1-4: Manufacturer: Fairphone
Apr 16 15:58:05 meterpeter kernel: usb 1-4: SerialNumber: f1ed3888
Apr 16 15:58:05 meterpeter kernel: usb 3-4: New USB device found, idVendor=
=3D0bda, idProduct=3Dc123, bcdDevice=3D 0.00
Apr 16 15:58:05 meterpeter kernel: usb 3-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
Apr 16 15:58:05 meterpeter kernel: usb 3-4: Product: Bluetooth Radio
Apr 16 15:58:05 meterpeter kernel: usb 3-4: Manufacturer: Realtek
Apr 16 15:58:05 meterpeter kernel: usb 3-4: SerialNumber: 00e04c000001
Apr 16 15:58:05 meterpeter kernel: tsc: Refined TSC clocksource calibration=
: 2112.068 MHz
Apr 16 15:58:05 meterpeter kernel: clocksource: tsc: mask: 0xffffffffffffff=
ff max_cycles: 0x1e71b8a16ff, max_idle_ns: 440795226841 ns
Apr 16 15:58:05 meterpeter kernel: clocksource: Switched to clocksource tsc
Apr 16 15:58:05 meterpeter kernel: clocksource: timekeeping watchdog on CPU=
3: Marking clocksource 'tsc' as unstable because the skew is too large:
Apr 16 15:58:05 meterpeter kernel: clocksource:                       'hpet=
' wd_nsec: 499779720 wd_now: 1b8bcdb wd_last: 14b8bfb mask: ffffffff
Apr 16 15:58:05 meterpeter kernel: clocksource:                       'tsc'=
 cs_nsec: 495992467 cs_now: 67fa96fd0 cs_last: 64138ca4c mask: ffffffffffff=
ffff
Apr 16 15:58:05 meterpeter kernel: clocksource:                       Clock=
source 'tsc' skewed -3787253 ns (-3 ms) over watchdog 'hpet' interval of 49=
9779720 ns (499 ms)
Apr 16 15:58:05 meterpeter kernel: clocksource:                       'tsc'=
 is current clocksource.
Apr 16 15:58:05 meterpeter kernel: tsc: Marking TSC unstable due to clockso=
urce watchdog
Apr 16 15:58:05 meterpeter kernel: TSC found unstable after boot, most like=
ly due to broken BIOS. Use 'tsc=3Dunstable'.
Apr 16 15:58:05 meterpeter kernel: sched_clock: Marking unstable (212108668=
0, 346876)<-(2133247558, -11816036)
Apr 16 15:58:05 meterpeter kernel: clocksource: Checking clocksource tsc sy=
nchronization from CPU 4 to CPUs 0,2-3,6-7,11.
Apr 16 15:58:05 meterpeter kernel: clocksource: Switched to clocksource hpet
Apr 16 15:58:05 meterpeter kernel: [drm] amdgpu kernel modesetting enabled.
Apr 16 15:58:05 meterpeter kernel: amdgpu: Virtual CRAT table created for C=
PU
Apr 16 15:58:05 meterpeter kernel: amdgpu: Topology: Add CPU node
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: enabling device (00=
06 -> 0007)
Apr 16 15:58:05 meterpeter kernel: [drm] initializing kernel modesetting (R=
ENOIR 0x1002:0x164C 0x17AA:0x5097 0xC2).
Apr 16 15:58:05 meterpeter kernel: [drm] register mmio base: 0xFD300000
Apr 16 15:58:05 meterpeter kernel: [drm] register mmio size: 524288
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 0 <soc15_common>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 1 <gmc_v9_0>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 2 <vega10_ih>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 3 <psp>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 4 <smu>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 5 <dm>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 6 <gfx_v9_0>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 7 <sdma_v4_0>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 8 <vcn_v2_0>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: detected ip=
 block number 9 <jpeg_v2_0>
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Fetched VBI=
OS from VFCT
Apr 16 15:58:05 meterpeter kernel: amdgpu: ATOM BIOS: 113-LUCIENNE-016
Apr 16 15:58:05 meterpeter kernel: Console: switching to colour dummy devic=
e 80x25
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: vgaarb: deactivate =
vga console
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Trusted Mem=
ory Zone (TMZ) feature enabled
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset
Apr 16 15:58:05 meterpeter kernel: [drm] vm size is 262144 GB, 4 levels, bl=
ock size is 9-bit, fragment size is 9-bit
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: VRAM: 1024M=
 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: GART: 1024M=
 0x0000000000000000 - 0x000000003FFFFFFF
Apr 16 15:58:05 meterpeter kernel: [drm] Detected VRAM RAM=3D1024M, BAR=3D1=
024M
Apr 16 15:58:05 meterpeter kernel: [drm] RAM width 128bits DDR4
Apr 16 15:58:05 meterpeter kernel: [drm] amdgpu: 1024M of VRAM memory ready
Apr 16 15:58:05 meterpeter kernel: [drm] amdgpu: 7398M of GTT memory ready.
Apr 16 15:58:05 meterpeter kernel: [drm] GART: num cpu pages 262144, num gp=
u pages 262144
Apr 16 15:58:05 meterpeter kernel: [drm] PCIE GART of 1024M enabled.
Apr 16 15:58:05 meterpeter kernel: [drm] PTB located at 0x000000F43FC00000
Apr 16 15:58:05 meterpeter kernel: [drm] Loading DMUB firmware via PSP: ver=
sion=3D0x0101002B
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Found VCN f=
irmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: reserve 0x4=
00000 from 0xf43f800000 for PSP TMR
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: RAS: option=
al ras ta ucode is not available
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: RAP: option=
al rap ta ucode is not available
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: psp gfx com=
mand LOAD_TA(0x1) failed and response status is (0x7)
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: psp gfx com=
mand INVOKE_CMD(0x3) failed and response status is (0x4)
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Secure disp=
lay: Generic Failure.
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SECUREDISPL=
AY: query securedisplay TA failed. ret 0x0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SMU is init=
ialized successfully!
Apr 16 15:58:05 meterpeter kernel: [drm] Display Core v3.2.325 initialized =
on DCN 2.1
Apr 16 15:58:05 meterpeter kernel: [drm] DP-HDMI FRL PCON supported
Apr 16 15:58:05 meterpeter kernel: [drm] DMUB hardware initialized: version=
=3D0x0101002B
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: [drm] Using=
 ACPI provided EDID for eDP-1
Apr 16 15:58:05 meterpeter kernel: [drm] kiq ring mec 2 pipe 1 q 0
Apr 16 15:58:05 meterpeter kernel: kfd kfd: amdgpu: Allocated 3969056 bytes=
 on gart
Apr 16 15:58:05 meterpeter kernel: kfd kfd: amdgpu: Total number of KFD nod=
es to be created: 1
Apr 16 15:58:05 meterpeter kernel: amdgpu: Virtual CRAT table created for G=
PU
Apr 16 15:58:05 meterpeter kernel: amdgpu: Topology: Add dGPU node [0x164c:=
0x1002]
Apr 16 15:58:05 meterpeter kernel: kfd kfd: amdgpu: added device 1002:164c
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH pe=
r SE 1, CU per SH 8, active_cu_number 7
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx us=
es VM inv eng 0 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E0.0 uses VM inv eng 1 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E1.0 uses VM inv eng 4 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E2.0 uses VM inv eng 5 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E3.0 uses VM inv eng 6 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E0.1 uses VM inv eng 7 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E1.1 uses VM inv eng 8 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E2.1 uses VM inv eng 9 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1=
=2E3.1 uses VM inv eng 10 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring kiq_0.=
2.1.0 uses VM inv eng 11 on hub 0
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0 =
uses VM inv eng 0 on hub 8
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_de=
c uses VM inv eng 1 on hub 8
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_en=
c0 uses VM inv eng 4 on hub 8
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_en=
c1 uses VM inv eng 5 on hub 8
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_d=
ec uses VM inv eng 6 on hub 8
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: Runtime PM =
not available
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: amdgpu: [drm] Using=
 custom brightness curve
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: [drm] Registered 4 =
planes with drm panic
Apr 16 15:58:05 meterpeter kernel: [drm] Initialized amdgpu 3.63.0 for 0000=
:04:00.0 on minor 1
Apr 16 15:58:05 meterpeter kernel: fbcon: amdgpudrmfb (fb0) is primary devi=
ce
Apr 16 15:58:05 meterpeter kernel: [drm] pre_validate_dsc:1601 MST_DSC dsc =
precompute is not needed
Apr 16 15:58:05 meterpeter kernel: Console: switching to colour frame buffe=
r device 240x67
Apr 16 15:58:05 meterpeter kernel: amdgpu 0000:04:00.0: [drm] fb0: amdgpudr=
mfb frame buffer device
Apr 16 15:58:05 meterpeter kernel: device-mapper: uevent: version 1.0.3
Apr 16 15:58:05 meterpeter kernel: device-mapper: ioctl: 4.49.0-ioctl (2025=
-01-17) initialised: dm-devel@lists.linux.dev
Apr 16 15:58:05 meterpeter kernel: Key type trusted registered
Apr 16 15:58:05 meterpeter kernel: Key type encrypted registered
Apr 16 15:58:05 meterpeter kernel: BTRFS: device label archlinux-btrfs devi=
d 1 transid 651464 /dev/mapper/archlinux (253:0) scanned by mount (500)
Apr 16 15:58:05 meterpeter kernel: BTRFS info (device dm-0): first mount of=
 filesystem 924db749-b786-4970-9fed-688cccb609e9
Apr 16 15:58:05 meterpeter kernel: BTRFS info (device dm-0): using crc32c (=
crc32c-x86) checksum algorithm
Apr 16 15:58:05 meterpeter kernel: BTRFS info (device dm-0): using free-spa=
ce-tree
Apr 16 15:58:05 meterpeter systemd[1]: systemd 257.5-1-arch running in syst=
em mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +=
GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +=
LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +Q=
RENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +U=
TMP -SYSVINIT +LIBARCHIVE)
Apr 16 15:58:05 meterpeter systemd[1]: Detected architecture x86-64.
Apr 16 15:58:05 meterpeter systemd[1]: Hostname set to <meterpeter>.
Apr 16 15:58:05 meterpeter systemd[1]: bpf-restrict-fs: LSM BPF program att=
ached
Apr 16 15:58:05 meterpeter systemd[1]: Queued start job for default target =
Graphical Interface.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/dirmngr.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/getty.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-browser.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-extra.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/gpg-agen=
t-ssh.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/keyboxd.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/modprobe.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice Slice /system/systemd-=
fsck.
Apr 16 15:58:05 meterpeter systemd[1]: Created slice User and Session Slice.
Apr 16 15:58:05 meterpeter systemd[1]: Started Dispatch Password Requests t=
o Console Directory Watch.
Apr 16 15:58:05 meterpeter systemd[1]: Started Forward Password Requests to=
 Wall Directory Watch.
Apr 16 15:58:05 meterpeter systemd[1]: Set up automount Arbitrary Executabl=
e File Formats File System Automount Point.
Apr 16 15:58:05 meterpeter systemd[1]: Expecting device /dev/disk/by-uuid/9=
24db749-b786-4970-9fed-688cccb609e9...
Apr 16 15:58:05 meterpeter systemd[1]: Expecting device /dev/disk/by-uuid/F=
ABC-FA07...
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Local Encrypted Volum=
es.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Local Integrity Prote=
cted Volumes.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Preparation for Netwo=
rk.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Path Units.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Remote File Systems.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Slice Units.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Local Verity Protecte=
d Volumes.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on Device-mapper event dae=
mon FIFOs.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on LVM2 poll daemon socket.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on Process Core Dump Socke=
t.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on Credential Encryption/D=
ecryption.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on Journal Socket (/dev/lo=
g).
Apr 16 15:58:05 meterpeter systemd[1]: Listening on Journal Sockets.
Apr 16 15:58:05 meterpeter systemd[1]: TPM PCR Measurements was skipped bec=
ause of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:58:05 meterpeter systemd[1]: Make TPM PCR Policy was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:58:05 meterpeter systemd[1]: Listening on udev Control Socket.
Apr 16 15:58:05 meterpeter systemd[1]: Listening on udev Kernel Socket.
Apr 16 15:58:05 meterpeter systemd[1]: Mounting Huge Pages File System...
Apr 16 15:58:05 meterpeter systemd[1]: Mounting POSIX Message Queue File Sy=
stem...
Apr 16 15:58:05 meterpeter systemd[1]: Mounting Kernel Debug File System...
Apr 16 15:58:05 meterpeter systemd[1]: Mounting Kernel Trace File System...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Create List of Static Devic=
e Nodes...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Monitoring of LVM2 mirrors,=
 snapshots etc. using dmeventd or progress polling...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Module configfs=
=2E..
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Module dm_mod...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Module drm...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Module fuse...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Module loop...
Apr 16 15:58:05 meterpeter systemd[1]: Clear Stale Hibernate Storage Info w=
as skipped because of an unmet condition check (ConditionPathExists=3D/sys/=
firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67=
).
Apr 16 15:58:05 meterpeter systemd[1]: Starting Journal Service...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load Kernel Modules...
Apr 16 15:58:05 meterpeter systemd[1]: TPM PCR Machine ID Measurement was s=
kipped because of an unmet condition check (ConditionSecurity=3Dmeasured-uk=
i).
Apr 16 15:58:05 meterpeter systemd[1]: Starting Remount Root and Kernel Fil=
e Systems...
Apr 16 15:58:05 meterpeter systemd[1]: Early TPM SRK Setup was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load udev Rules from Creden=
tials...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Coldplug All udev Devices...
Apr 16 15:58:05 meterpeter systemd[1]: Mounted Huge Pages File System.
Apr 16 15:58:05 meterpeter systemd[1]: Mounted POSIX Message Queue File Sys=
tem.
Apr 16 15:58:05 meterpeter kernel: loop: module loaded
Apr 16 15:58:05 meterpeter systemd[1]: Mounted Kernel Debug File System.
Apr 16 15:58:05 meterpeter systemd[1]: Mounted Kernel Trace File System.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Create List of Static Devic=
e Nodes.
Apr 16 15:58:05 meterpeter systemd[1]: modprobe@configfs.service: Deactivat=
ed successfully.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Module configfs.
Apr 16 15:58:05 meterpeter systemd[1]: modprobe@dm_mod.service: Deactivated=
 successfully.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Module dm_mod.
Apr 16 15:58:05 meterpeter systemd-journald[574]: Collecting audit messages=
 is disabled.
Apr 16 15:58:05 meterpeter systemd[1]: modprobe@drm.service: Deactivated su=
ccessfully.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Module drm.
Apr 16 15:58:05 meterpeter systemd[1]: modprobe@fuse.service: Deactivated s=
uccessfully.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Module fuse.
Apr 16 15:58:05 meterpeter systemd[1]: modprobe@loop.service: Deactivated s=
uccessfully.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Module loop.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load Kernel Modules.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Remount Root and Kernel Fil=
e Systems.
Apr 16 15:58:05 meterpeter systemd[1]: Finished Load udev Rules from Creden=
tials.
Apr 16 15:58:05 meterpeter systemd[1]: Activating swap /swap/swapfile...
Apr 16 15:58:05 meterpeter systemd[1]: Mounting FUSE Control File System...
Apr 16 15:58:05 meterpeter systemd[1]: Mounting Kernel Configuration File S=
ystem...
Apr 16 15:58:05 meterpeter systemd[1]: Rebuild Hardware Database was skippe=
d because no trigger condition checks were met.
Apr 16 15:58:05 meterpeter systemd[1]: Starting Load/Save OS Random Seed...
Apr 16 15:58:05 meterpeter systemd[1]: Repartition Root Disk was skipped be=
cause no trigger condition checks were met.
Apr 16 15:58:05 meterpeter systemd[1]: Starting Apply Kernel Variables...
Apr 16 15:58:05 meterpeter systemd[1]: Starting Create Static Device Nodes =
in /dev gracefully...
Apr 16 15:58:05 meterpeter systemd[1]: TPM SRK Setup was skipped because of=
 an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Apr 16 15:58:05 meterpeter kernel: Adding 16777212k swap on /swap/swapfile.=
  Priority:-2 extents:33 across:450363392k SS
Apr 16 15:58:05 meterpeter systemd[1]: Finished Monitoring of LVM2 mirrors,=
 snapshots etc. using dmeventd or progress polling.
Apr 16 15:58:05 meterpeter systemd[1]: Activated swap /swap/swapfile.
Apr 16 15:58:05 meterpeter systemd[1]: Mounted FUSE Control File System.
Apr 16 15:58:05 meterpeter systemd[1]: Mounted Kernel Configuration File Sy=
stem.
Apr 16 15:58:05 meterpeter systemd[1]: Reached target Swaps.
Apr 16 15:58:05 meterpeter systemd[1]: Started Journal Service.
Apr 16 15:58:06 meterpeter kernel: piix4_smbus 0000:00:14.0: SMBus Host Con=
troller at 0xb00, revision 0
Apr 16 15:58:06 meterpeter kernel: piix4_smbus 0000:00:14.0: Using register=
 0x02 for SMBus port selection
Apr 16 15:58:06 meterpeter kernel: i2c i2c-5: Successfully instantiated SPD=
 at 0x50
Apr 16 15:58:06 meterpeter kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBu=
s Host Controller at 0xb20
Apr 16 15:58:06 meterpeter kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Ti=
mer Driver
Apr 16 15:58:06 meterpeter kernel: sp5100-tco sp5100-tco: Using 0xfeb00000 =
for watchdog MMIO address
Apr 16 15:58:06 meterpeter kernel: sp5100-tco sp5100-tco: initialized. hear=
tbeat=3D60 sec (nowayout=3D0)
Apr 16 15:58:06 meterpeter kernel: RAPL PMU: API unit is 2^-32 Joules, 2 fi=
xed counters, 163840 ms ovfl timer
Apr 16 15:58:06 meterpeter kernel: RAPL PMU: hw unit of domain package 2^-1=
6 Joules
Apr 16 15:58:06 meterpeter kernel: RAPL PMU: hw unit of domain core 2^-16 J=
oules
Apr 16 15:58:06 meterpeter kernel: cfg80211: Loading compiled-in X.509 cert=
ificates for regulatory database
Apr 16 15:58:06 meterpeter kernel: snd_rn_pci_acp3x 0000:04:00.5: enabling =
device (0000 -> 0002)
Apr 16 15:58:06 meterpeter kernel: Loaded X.509 cert 'sforshee: 00b28ddf47a=
ef9cea7'
Apr 16 15:58:06 meterpeter kernel: Loaded X.509 cert 'wens: 61c038651aabdcf=
94bd0ac7ff06c7248db18c600'
Apr 16 15:58:06 meterpeter kernel: ee1004 5-0050: 512 byte EE1004-compliant=
 SPD EEPROM, read-only
Apr 16 15:58:06 meterpeter kernel: r8169 0000:02:00.0: can't disable ASPM; =
OS doesn't have ASPM control
Apr 16 15:58:06 meterpeter kernel: r8169 0000:02:00.0 eth0: RTL8168gu/8111g=
u, 38:f3:ab:58:be:e8, XID 509, IRQ 68
Apr 16 15:58:06 meterpeter kernel: r8169 0000:02:00.0 eth0: jumbo features =
[frames: 9194 bytes, tx checksumming: ko]
Apr 16 15:58:06 meterpeter kernel: r8169 0000:02:00.0 enp2s0: renamed from =
eth0
Apr 16 15:58:06 meterpeter kernel: snd_hda_intel 0000:04:00.1: enabling dev=
ice (0000 -> 0002)
Apr 16 15:58:06 meterpeter kernel: snd_hda_intel 0000:04:00.1: Handle vga_s=
witcheroo audio client
Apr 16 15:58:06 meterpeter kernel: snd_hda_intel 0000:04:00.6: enabling dev=
ice (0000 -> 0002)
Apr 16 15:58:06 meterpeter kernel: kvm_amd: TSC scaling supported
Apr 16 15:58:06 meterpeter kernel: kvm_amd: Nested Virtualization enabled
Apr 16 15:58:06 meterpeter kernel: kvm_amd: Nested Paging enabled
Apr 16 15:58:06 meterpeter kernel: kvm_amd: LBR virtualization supported
Apr 16 15:58:06 meterpeter kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
Apr 16 15:58:06 meterpeter kernel: kvm_amd: Virtual GIF supported
Apr 16 15:58:06 meterpeter kernel: snd_hda_intel 0000:04:00.1: bound 0000:0=
4:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Apr 16 15:58:06 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D3 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input9
Apr 16 15:58:06 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D7 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input10
Apr 16 15:58:06 meterpeter kernel: input: HD-Audio Generic HDMI/DP,pcm=3D8 =
as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input11
Apr 16 15:58:06 meterpeter kernel: rtw_8822ce 0000:03:00.0: enabling device=
 (0000 -> 0003)
Apr 16 15:58:06 meterpeter kernel: rtw_8822ce 0000:03:00.0: WOW Firmware ve=
rsion 9.9.4, H2C version 15
Apr 16 15:58:06 meterpeter kernel: rtw_8822ce 0000:03:00.0: Firmware versio=
n 9.9.15, H2C version 15
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0: ALC25=
7: picked fixup  for PCI SSID 17aa:0000
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0: autoc=
onfig for ALC257: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    sp=
eaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    hp=
_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    mo=
no: mono_out=3D0x0
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:    in=
puts:
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:      =
Internal Mic=3D0x12
Apr 16 15:58:06 meterpeter kernel: snd_hda_codec_realtek hdaudioC1D0:      =
Mic=3D0x19
Apr 16 15:58:06 meterpeter kernel: amd_atl: AMD Address Translation Library=
 initialized
Apr 16 15:58:06 meterpeter kernel: intel_rapl_common: Found RAPL domain pac=
kage
Apr 16 15:58:06 meterpeter kernel: intel_rapl_common: Found RAPL domain core
Apr 16 15:58:06 meterpeter kernel: rtw_8822ce 0000:03:00.0 wlp3s0: renamed =
=66rom wlan0
Apr 16 15:58:06 meterpeter kernel: psmouse serio1: elantech: assuming hardw=
are version 4 (with firmware version 0x5f3001)
Apr 16 15:58:07 meterpeter kernel: input: HD-Audio Generic Mic as /devices/=
pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input12
Apr 16 15:58:07 meterpeter kernel: input: HD-Audio Generic Headphone as /de=
vices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input13
Apr 16 15:58:07 meterpeter kernel: psmouse serio1: elantech: Synaptics capa=
bilities query result 0x90, 0x18, 0x0d.
Apr 16 15:58:07 meterpeter kernel: psmouse serio1: elantech: Elan sample qu=
ery result 00, 0d, a7
Apr 16 15:58:07 meterpeter kernel: psmouse serio1: elantech: Elan ic body: =
0x11, current fw version: 0x4
Apr 16 15:58:07 meterpeter kernel: psmouse serio1: elantech: Trying to set =
up SMBus access
Apr 16 15:58:07 meterpeter kernel: psmouse serio1: elantech: SMbus companio=
n is not ready yet
Apr 16 15:58:07 meterpeter kernel: input: ETPS/2 Elantech TrackPoint as /de=
vices/platform/i8042/serio1/input/input14
Apr 16 15:58:07 meterpeter kernel: input: ETPS/2 Elantech Touchpad as /devi=
ces/platform/i8042/serio1/input/input8
Apr 16 15:58:07 meterpeter systemd-journald[574]: Received client request t=
o flush runtime journal.
Apr 16 15:58:07 meterpeter kernel: mousedev: PS/2 mouse device common for a=
ll mice
Apr 16 15:58:07 meterpeter kernel: mc: Linux media interface: v0.10
Apr 16 15:58:07 meterpeter kernel: Bluetooth: Core ver 2.22
Apr 16 15:58:07 meterpeter kernel: NET: Registered PF_BLUETOOTH protocol fa=
mily
Apr 16 15:58:07 meterpeter kernel: Bluetooth: HCI device and connection man=
ager initialized
Apr 16 15:58:07 meterpeter kernel: Bluetooth: HCI socket layer initialized
Apr 16 15:58:07 meterpeter kernel: Bluetooth: L2CAP socket layer initialized
Apr 16 15:58:07 meterpeter kernel: Bluetooth: SCO socket layer initialized
Apr 16 15:58:07 meterpeter kernel: videodev: Linux video capture interface:=
 v2.00
Apr 16 15:58:07 meterpeter kernel: usbcore: registered new interface driver=
 btusb
Apr 16 15:58:07 meterpeter kernel: Bluetooth: hci0: RTL: examining hci_ver=
=3D0a hci_rev=3D000c lmp_ver=3D0a lmp_subver=3D8822
Apr 16 15:58:07 meterpeter kernel: Bluetooth: hci0: RTL: rom_version status=
=3D0 version=3D3
Apr 16 15:58:07 meterpeter kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl=
8822cu_fw.bin
Apr 16 15:58:07 meterpeter kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl=
8822cu_config.bin
Apr 16 15:58:07 meterpeter kernel: Bluetooth: hci0: RTL: cfg_sz 6, total sz=
 37346
Apr 16 15:58:07 meterpeter kernel: usb 1-3: Found UVC 1.10 device Integrate=
d Camera (13d3:56fb)
Apr 16 15:58:07 meterpeter kernel: usb 1-3: Found UVC 1.50 device Integrate=
d Camera (13d3:56fb)
Apr 16 15:58:07 meterpeter kernel: usbcore: registered new interface driver=
 uvcvideo
Apr 16 15:58:08 meterpeter kernel: Bluetooth: hci0: RTL: fw version 0xaed66=
dcb
Apr 16 15:58:08 meterpeter kernel: Bluetooth: hci0: AOSP extensions version=
 v1.00
Apr 16 15:58:08 meterpeter kernel: Bluetooth: hci0: AOSP quality report is =
supported
Apr 16 15:58:09 meterpeter kernel: Generic FE-GE Realtek PHY r8169-0-200:00=
: attached PHY driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
Apr 16 15:58:09 meterpeter kernel: r8169 0000:02:00.0 enp2s0: Link is Down
Apr 16 15:58:09 meterpeter kernel: tun: Universal TUN/TAP device driver, 1.6
Apr 16 15:58:18 meterpeter kernel: nvme nvme0: using unchecked data buffer
Apr 16 15:58:39 meterpeter kernel: usb 1-4: USB disconnect, device number 3
Apr 16 15:58:39 meterpeter kernel: usb 1-4: new high-speed USB device numbe=
r 4 using xhci_hcd
Apr 16 15:58:39 meterpeter kernel: usb 1-4: New USB device found, idVendor=
=3D05c6, idProduct=3D9024, bcdDevice=3D 4.19
Apr 16 15:58:39 meterpeter kernel: usb 1-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
Apr 16 15:58:39 meterpeter kernel: usb 1-4: Product: Fairphone 4 5G
Apr 16 15:58:39 meterpeter kernel: usb 1-4: Manufacturer: Fairphone
Apr 16 15:58:39 meterpeter kernel: usb 1-4: SerialNumber: f1ed3888
Apr 16 15:58:40 meterpeter kernel: usbcore: registered new interface driver=
 cdc_ether
Apr 16 15:58:40 meterpeter kernel: rndis_host 1-4:1.0 wwan0: register 'rndi=
s_host' at usb-0000:04:00.3-4, Mobile Broadband RNDIS device, a6:d0:9d:46:1=
3:fc
Apr 16 15:58:40 meterpeter kernel: usbcore: registered new interface driver=
 rndis_host
Apr 16 15:58:40 meterpeter kernel: rndis_host 1-4:1.0 wwp4s0f3u4: renamed f=
rom wwan0
Apr 16 15:59:21 meterpeter kernel: wlp3s0: authenticate with 42:d1:17:af:50=
:55 (local address=3Dcc:6b:1e:3d:f9:f7)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: send auth to 42:d1:17:af:50:55 (=
try 1/3)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: authenticate with 42:d1:17:af:50=
:55 (local address=3Dcc:6b:1e:3d:f9:f7)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: send auth to 42:d1:17:af:50:55 (=
try 1/3)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: authenticated
Apr 16 15:59:21 meterpeter kernel: wlp3s0: associate with 42:d1:17:af:50:55=
 (try 1/3)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: RX AssocResp from 42:d1:17:af:50=
:55 (capab=3D0x1131 status=3D0 aid=3D1)
Apr 16 15:59:21 meterpeter kernel: wlp3s0: associated
Apr 16 15:59:21 meterpeter kernel: wlp3s0: Limiting TX power to 23 (23 - 0)=
 dBm as advertised by 42:d1:17:af:50:55
Apr 16 15:59:21 meterpeter kernel: warning: `ThreadPoolForeg' uses wireless=
 extensions which will stop working for Wi-Fi 7 hardware; use nl80211
Apr 16 16:00:10 meterpeter kernel: usb 1-4: USB disconnect, device number 4
Apr 16 16:00:10 meterpeter kernel: rndis_host 1-4:1.0 wwp4s0f3u4: unregiste=
r 'rndis_host' usb-0000:04:00.3-4, Mobile Broadband RNDIS device
Apr 16 16:02:56 meterpeter kernel: /proc/cgroups lists only v1 controllers,=
 use cgroup.controllers of root cgroup for v2 info

--a5ukmz4hgjgovgad--

--6w4gonr5mqqg4mr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmf/vR4ACgkQwEfU8yi1
JYWEQxAApQGSAU2EiKC0Zrsd5zK4H1LeX1amR6iJTJh5J7N30WjG/K/ZssodFR1i
uAYBnXKBJV3meMHLX2xLDQtOfpkUL2srABFbuH6M5WN9RVdE/6tWZSOikazkF3Vc
RUcXoL0Hyw834bALbTRHjZ4dahJextZbb5sN8C9ht8rlNTw1NTeBZTNREqALSwDz
YEwhORKFRQsj15hmsE4PHk68zUX15mgrk6hVB1Cou7Hoa94sDD+S5AOVa65XUeY5
JuROCti9d1M2XeNz14WTSe7Kpc2+DIjcb2dLCBxq6uE9w6bdbAB33pneygJCuD8i
k3MTctt3w+8h7Uf5sHwuKs98gU7qjNNFjLRzsiD8SM6abyRG6ovXwIUk1II8yrWm
QdeJrbdtMPI+HyY8IpY6Ydyy1ercVZOO672tt46gqghrQd8TmVHtiAE7yLpANuUW
jVNPiKTxHYDix58ZDETqiHW7O6025BxwffL80IniUja/9dtJGEORMP83tR99ui/U
5VGGT24kTIqb9dJSOdE8NfwJPzDhXbahrFtkFVfE53YXvrYXh0WKi6daqREAHxgB
xdNSCLzW2V7OjXXuujhM9IsUZaEV/7AzvYMKXL/H2NqNSnHd68rVbrLxesu0Fdfj
Edz4l2i1aO5PUufBxQ72BpkVmehd6XYuEAV6qfXUA1qF9VzmtLo=
=TD60
-----END PGP SIGNATURE-----

--6w4gonr5mqqg4mr4--

