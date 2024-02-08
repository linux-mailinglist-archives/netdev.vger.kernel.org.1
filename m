Return-Path: <netdev+bounces-70129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A607B84DC73
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620E7282B2B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31D6A8DF;
	Thu,  8 Feb 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdI2cKLT"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE46931C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383413; cv=none; b=OATJl2QHAD0TjutuQ1eatAWRlFpJFgIc3/B1p2CArdjOao11M9UaS8J/WiNDC7lAi9BtqjLeq/3pHFIrCvl5yY1NL5gBT5zv70XruOloowbW2OP6FLQY13dXd0o066dI0A+WwUhHtvV6nssy06Uwx5hS/u2kDpAS6zz0Z83Dlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383413; c=relaxed/simple;
	bh=dN4H69GZOkk7/bvElbfvptAQLHh0Gvqauq3hWTaKVD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgQXUmmDScQrMeAraNzcefNJNFqNlalA4o+OatoIs1/q1YH8HTVSRprfg2dZ1uQS2haOgPM9B11CvJkIayK7EsBhFXrNI313uUbKG9wluo/lMb6lxVpZC2hkRTCeu2PCubGAP2wwoFP26KZKUtVUCzuKh8QUi/Z2n16jNrSwq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdI2cKLT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 301262000B;
	Thu,  8 Feb 2024 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707383408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNzozdjttYG8802H9znlXWvybw8vVoeSKCoGLjTcdVI=;
	b=WdI2cKLTjiN8lpRYx36wKOjdIVo5Pd/tL8k9hjunf7rfHBha2741iGSV1GC4quieHEHJQ8
	F4/ppTpeFyRP8aQGhhi8aqMDVzi25VFVgkuvQrbL37kpzv1v+qH7fFtPllW9oB1tbiOLeP
	Ne8tirgwAJfwGbyhutogB64Cr6GCD+9Cq10VPxn5NnLQQNkFBRiVdi7KbbqmqWsOsG4CsX
	JMbFjTqT6RdRk6wmAjc+M3kWM9+pDCT4NPTzAQ1t3kXEcQhdTSja+DXX3CauSXr8wv/bVY
	LI2Fche7hnxdP8JgnW72jhxRdVzTPpzltxqQ43Vh8tpRNTzxyUpg/lNAvE9QrQ==
Date: Thu, 8 Feb 2024 10:10:05 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>
Subject: Re: Prestera driver fail to probe twice
Message-ID: <20240208101005.29e8c7f3@kmaincent-XPS-13-7390>
In-Reply-To: <c70a4c93-909e-4a94-8e46-d3d62aa7b487@lunn.ch>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<c70a4c93-909e-4a94-8e46-d3d62aa7b487@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Andrew,

On Thu, 8 Feb 2024 00:32:43 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Feb 06, 2024 at 04:54:06PM +0100, K=C3=B6ry Maincent wrote:
> > Hello,
> >=20
> > It seems the prestera driver has never been tested as a module or in a
> > probe defer case: =20
>=20
> Hi K=C3=B6ry
>=20
> Could you hack a -EPROBE_DEFER failure? If you can show that does not
> work, the driver is clearly broken because phylink could return that.

That is how I have noticed the issue. I was trying to test my PSE pd692x0
driver as a module that prestera depends on (I will drop the PoE v3 soon).
The PSE core is returning -EPROBE_DEFER in case we can not find the PSE
provider.

Here is a boot dmesg for example:

[    1.898897] Prestera DX 0000:01:00.0: Loading mrvl/prestera/mvsw_prester=
a_fw-v4.1.img ...
[    1.907155] Prestera DX 0000:01:00.0: FW version '4.1.0'
[    5.535427] Prestera DX 0000:01:00.0: Prestera FW is ready
[   13.458823] Prestera DX 0000:01:00.0: using random base mac address
[   13.596594] prestera_port_sfp_bind : 403 -EPROBE_DEFER (The hack to get =
the PSE is in this function)
[   13.632517] ahci f2540000.sata: supply ahci not found, using dummy regul=
ator
[   13.639759] ahci f2540000.sata: supply phy not found, using dummy regula=
tor
[   13.646846] platform f2540000.sata:sata-port@0: supply target not found,=
 using dummy regulator
[   13.655866] platform f2540000.sata:sata-port@1: supply target not found,=
 using dummy regulator
[   13.666105] ahci f2540000.sata: masking port_map 0x3 -> 0x3
[   13.671960] ahci f2540000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0=
x3 impl platform mode
[   13.680598] ahci f2540000.sata: flags: 64bit ncq sntf led only pmp fbs p=
io slum part sxs=20
[   13.690393] scsi host1: ahci
[   13.693744] scsi host2: ahci
[   13.696789] ata1: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] por=
t 0x100 irq 40 lpm-pol 0
[   13.705640] ata2: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] por=
t 0x180 irq 40 lpm-pol 0
[   13.787389] mvpp2 f2000000.ethernet: using 8 per-cpu buffers
[   13.813450] mvpp2 f2000000.ethernet eth0: Using random mac address a2:00=
:a8:8c:7f:ca
[   13.862023] i2c i2c-2: Added multiplexed i2c bus 3
[   13.867101] i2c i2c-2: Added multiplexed i2c bus 4
[   13.872104] i2c i2c-2: Added multiplexed i2c bus 5
[   13.877181] i2c i2c-2: Added multiplexed i2c bus 6
[   13.882034] i2c-mux-gpio i2c-mux: 4 port mux on mv64xxx_i2c adapter adap=
ter
[   14.030349] ata2: SATA link down (SStatus 0 SControl 300)
[   14.195606] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   14.201982] ata1.00: ATA-9: M.2 (S42) 3TE7, S20730A, max UDMA/133
[   14.208142] ata1.00: 53742528 sectors, multi 16: LBA48 NCQ (depth 32)
[   14.214832] ata1.00: configured for UDMA/133
[   14.219477] scsi 1:0:0:0: Direct-Access     ATA      M.2 (S42) 3TE7   30=
A  PQ: 0 ANSI: 5
[   14.228723] sd 1:0:0:0: [sdb] 53742528 512-byte logical blocks: (27.5 GB=
/25.6 GiB)
[   14.236465] sd 1:0:0:0: [sdb] Write Protect is off
[   14.241341] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   14.250491] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[   14.259197]  sdb: sdb1 sdb2 sdb3 sdb4
[   14.263962] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   18.896377] Prestera DX 0000:01:00.0: waiting for FW loader is timed out
[   18.903242] Prestera DX: probe of 0000:01:00.0 failed with error -110


Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

