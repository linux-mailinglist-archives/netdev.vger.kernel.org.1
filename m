Return-Path: <netdev+bounces-240919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70147C7C119
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 341E934039B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580E1DF736;
	Sat, 22 Nov 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Ide80P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFB38F9C;
	Sat, 22 Nov 2025 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773707; cv=none; b=hrJwVK7QnN6GaP06xcIYMqR81S14gU4kdqn+uZ2cFdua+5+bGP7d7nxntrhZafZY/FLf674d6tklPkeDlj+8Gtsdvb+mkVMKtYtij7JF1UNDCM94wBkI9Z5AcTXVJxkGy1aPiOJ2O00Vz+y5/trLWQZeDPeyxl15dap2jhcxRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773707; c=relaxed/simple;
	bh=vF5qOA/PMpQo4KzrucMrEDXZiRGYqeVx1tqeKDogbVs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSR3DCwKg/D8MwZAKUagm8eHeLK7aALj+CqR/tvJEVLoiJ0YrQBvCaPuEG6LhBE6NwHU8D6O/WJcsg5yqLwx+XfYUfJmmhiqSC0/zQeAVVZh/GsillMWyfecM5Xm9kcYZmd+cjwoIRJMGUGqiHQYohM4u5B1nr7KHQ5z+C13tWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Ide80P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE32C4CEF1;
	Sat, 22 Nov 2025 01:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763773706;
	bh=vF5qOA/PMpQo4KzrucMrEDXZiRGYqeVx1tqeKDogbVs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=f9Ide80PZmGRxH2MqsPuE30kFXk2Ult8xHI4uCiLsprlGIK0hUvgCh+Plj/5jWj4s
	 mKbToycSucurDJXEyPSFYZL7UJEcFIA9l96a/aQiNPOcTiKq2rNnzfFnj2gRuypIYK
	 onwGud37gekYYA77zeN7tnPR/kQN1FO86UiCSxEDqRBjhOMIc5Qqn+EG7N4BubEL6i
	 19rj44XBAhMeHVceKi6eXspMdmSClQ/wlRZJe05XAoRnagCf8TXzlVmL2sX9TXt5Bm
	 rVpaxOhOTVtJg8TXrX1O1+p/EotwVPYkaMCXIg0/3IhQ2LHTxfUDB9pn1yeS9BdEO1
	 Y95Qw6SvUptVQ==
Message-ID: <6689415773004afd10b3a0035862dd4faaf78021.camel@kernel.org>
Subject: Re: [PATCH v21 00/23] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Date: Fri, 21 Nov 2025 17:08:25 -0800
In-Reply-To: <8d8cb631-1d72-436f-ac97-5449ba46ef42@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <e3d376c8a1ac1ee9b75d02f78bdc25f7c556bb20.camel@kernel.org>
	 <8d8cb631-1d72-436f-ac97-5449ba46ef42@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-21 at 10:40 +0000, Alejandro Lucero Palau wrote:
>=20
> On 11/21/25 06:41, PJ Waskiewicz wrote:
> > On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> > wrote:
> >=20
> > Hi Alejandro,
> >=20
> > Sorry it's been a bit since I've been able to comment.=C2=A0 I've been
> > trying to test these patchsets with varying degrees of success.=C2=A0
> > Still
> > haven't gotten things up and running fully.=C2=A0 One comment below.
>=20
>=20
> Hi,
>=20
>=20
> No worries!
>=20
>=20
> > > From: Alejandro Lucero <alucerop@amd.com>
> > >=20
> > > The patchset should be applied on the described base commit then
> > > applying
> > > Terry's v13 about CXL error handling. The first 4 patches come
> > > from
> > > Dan's
> > > for-6.18/cxl-probe-order branch with minor modifications.
> > >=20
> > > v21 changes;
> > >=20
> > > =C2=A0=C2=A0 patch1-2: v20 patch1 splitted up doing the code move in =
the
> > > second
> > > 	=C2=A0=C2=A0=C2=A0 patch in v21. (Jonathan)
> > > =C2=A0=20
> > > =C2=A0=C2=A0 patch1-4: adding my Signed-off tag along with Dan's
> > >=20
> > > =C2=A0=C2=A0 patch5: fix duplication of CXL_NR_PARTITION definition
> > >=20
> > > =C2=A0=C2=A0 patch7: dropped the cxl test fixes removing unused funct=
ion.
> > > It was
> > > 	=C2=A0 sent independently ahead of this version.
> > >=20
> > > =C2=A0=C2=A0 patch12: optimization for max free space calculation
> > > (Jonathan)
> > >=20
> > > =C2=A0=C2=A0 patch19: optimization for returning on error (Jonathan)
> > I cannot test these v21 patches or the v20 patches for the same
> > reason.
> > I suspect v19 is also affected, but I was stuck on v17 for awhile
> > (b4
> > was really not likely the prereq patches you required to get the
> > tree
> > into a usable state to apply your patchset).
> >=20
> > When I build and go to install the kernel mods, depmod fails:
> >=20
> > DEPMOD=C2=A0 /lib/modules/6.18.0-rc6+
> > depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_port ->
> > cxl_core
> > depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_core
> > depmod: ERROR: Found 3 modules in dependency cycles!
> >=20
> > I repro'd this on a few different systems, and just finally repro'd
> > this on a box outside of my work network.
> >=20
> > This is unusable unfortunately, so I can't test this if I wanted
> > to.
>=20
>=20
> I have been able to reproduce this, and I think after the changes=20
> introduced in patches 2 & 3, we also need this:
>=20
>=20
>=20
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 6b871cbbce13..94a3102ce86b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -1,6 +1,6 @@
> =C2=A0=C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0=C2=A0menuconfig CXL_BUS
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "CXL (Compute Express Link=
) Devices Support"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "CXL (Compute Express Link) De=
vices Support"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FW_LOADER
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FW_UPLOAD
>=20
>=20
> This changes implies neither CXL_BUS optionally being a module nor
> cxl_mem.
>=20
>=20
> This should be enough for at least you able to test the patchset.
>=20
>=20
> If this is agreed, I will send a v22 with it.

This seems reasonable to me to make things work.

I'd definitely want Dave or Dan to weigh in though since this does make
CXL no longer be modular, and it's either built-in or not.  Personally,
if this is the price to pay for the non-asynchronous nature of memdev
creation for a Type2 driver, I'm fine with that.

I'm rebuilding now and will rebase my drivers onto this, and hopefully
be testing again over the weekend.  If things start looking good, I'll
send some Tested-by: and also review more deeply.

Cheers,
-PJ

