Return-Path: <netdev+bounces-167797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA1A3C60F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19873A77E7
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86C211710;
	Wed, 19 Feb 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBvLWFrF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F574286284;
	Wed, 19 Feb 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985772; cv=none; b=TUSRuLr7ufO/RnNxGmyKtZypFeK14ZQZGE8MhMl98RtGZid3FXUVSZD4Cme0wMjc6lwe8yHQDyxwNg1l955hRYI4074mxfSmCzjMFRjEn5fOnXtByzcfQubt73r2ZtzGqMJB5J/eHiOTTapAPQQyh3ZIR4tM3S6zRxp/XdTmolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985772; c=relaxed/simple;
	bh=akhUxN+QxLEckZcxCpguN5EnjkBnD9oRnQSuFZ8ZKSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7zw4CUA8UKCmC1wNffn32d2UGag0zozPNsGKjlMP92/rYD9LdkAidIYakRi2J/CYj8gsGOu0ivmcTT/UQCqPCnc17Ua8PvCghBXT8dAiTlUmRHZUFQpXDT4cYw+A9XB/O+P2E9K5rO2P/amQbOdEftUo+BSEu+V+kAtKkcvrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBvLWFrF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985770; x=1771521770;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=akhUxN+QxLEckZcxCpguN5EnjkBnD9oRnQSuFZ8ZKSM=;
  b=HBvLWFrF0q9k7azTn2vzgHb/ko0I60FZl4WJnzike7VS3GTPGNe3LuQR
   mQC2DPzDPq32o4wgR0FeNedIREmPwEFt2XeWnH7zl1+wtiD0+YFz7EbPg
   nQi7ajk2tfMoElHjxSgTPvXE4mIzWXneBfNJWtVYjZRWLy3lNcycrXA2m
   iJXaThod454xChkpg9vFzHqNLi0xDjNh6jjfQT5MybczjznZ+vYYwR5/O
   2G+VOox7mKXO3o5UnuWxhmmTCYrR7ttr7eGKTRmeK70u/ZP/6tjW9IXJH
   4fipLDcRzaXVbU4ZT3Nx/PQa1B+i7yTkdBHICWt/p0emr6dHtHqjF9Ji6
   g==;
X-CSE-ConnectionGUID: eZsX1oNiReC5n5o0rxp7wA==
X-CSE-MsgGUID: Bror4W8QRCKD68IFQj6HzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51354824"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51354824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:22:49 -0800
X-CSE-ConnectionGUID: BRlidm1zTwmv/BO/vvlzuA==
X-CSE-MsgGUID: PHqqdaA9SB2DY4ysxBUtAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115432705"
Received: from iherna2-mobl4.amr.corp.intel.com ([10.125.110.29])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:01:22 -0800
Message-ID: <4cf99d5f9b63aec22c24c445dea9a80d71f5f024.camel@linux.intel.com>
Subject: Re: [PATCH net-next v7 3/7] arch: x86: add IPC mailbox accessor
 function and add SoC register access
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Dave Hansen <dave.hansen@intel.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Simon Horman <horms@kernel.org>, Jose
 Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Richard Cochran
 <richardcochran@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
Date: Wed, 19 Feb 2025 09:01:20 -0800
In-Reply-To: <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
	 <20250206131859.2960543-4-yong.liang.choong@linux.intel.com>
	 <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 08:46 -0800, Dave Hansen wrote:
> On 2/6/25 05:18, Choong Yong Liang wrote:
> >=20
> > - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> > - Add support to use IPC command allows host to access SoC registers=
=20
> > through PMC firmware that are otherwise inaccessible to the host due
> > to security policies.
> I'm not quite parsing that second bullet as a complete sentence.
>=20
> But that sounds scary! Why is the fact that they are "otherwise
> inaccessible" relevant here?

The PMC IPC mailbox is a host interface to the PMC. Its purpose is to allow=
 the
host to access certain areas of the PMC that are restricted from direct MMI=
O
access due to security policies. Other parts of the PMC are accessible via =
MMIO
(most of what the intel_pmc_core driver touches with is MMIO), so I think t=
he
original statement was trying to explain why the mailbox is needed instead =
of
MMIO in this case. However, I agree that the mention of security policies i=
s not
relevant to the change itself.

> ...
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 87198d957e2f..631c1f10776c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -688,6 +688,15 @@ config X86_AMD_PLATFORM_DEVICE
> > =C2=A0	=C2=A0 I2C and UART depend on COMMON_CLK to set clock. GPIO driv=
er is
> > =C2=A0	=C2=A0 implemented under PINCTRL subsystem.
> > =C2=A0
> > +config INTEL_PMC_IPC
> > +	tristate "Intel Core SoC Power Management Controller IPC mailbox"
> > +	depends on ACPI
> > +	help
> > +	=C2=A0 This option enables sideband register access support for Intel
> > SoC
> > +	=C2=A0 power management controller IPC mailbox.
> > +
> > +	=C2=A0 If you don't require the option or are in doubt, say N.
>=20
> Could we perhaps beef this up a bit to help users figure out if they
> want to turn this on? Really the only word in the entire help text
> that's useful is "Intel".
>=20
> I'm not even sure we *want* to expose this to users. Can we just leave
> it as:
>=20
> 	config INTEL_PMC_IPC
> 		def_tristate n
> 		depends on ACPI
>=20
> so that it only gets enabled by the "select" in the other patches?

I agree with this change Choong. This can be selected by the driver that's =
using
it. There's no need to expose it to users.

>=20
> > + * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 David E. Box =
<david.e.box@linux.intel.com>
>=20
> I'd probably just leave the authors bit out. It might have been useful
> in the 90's, but that's what git is for today.
>=20
> > +	obj =3D buffer.pointer;
> > +	/* Check if the number of elements in package is 5 */
> > +	if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.count =
=3D=3D
> > 5) {
> > +		const union acpi_object *objs =3D obj->package.elements;
> > +
>=20
> The comment there is just not super useful. It might be useful to say
> *why* the number of elements needs to be 5.
>=20
> > +EXPORT_SYMBOL(intel_pmc_ipc);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Intel PMC IPC Mailbox accessor");
>=20
> Honestly, is this even worth being a module? How much code are we
> talking about here?

Yeah, this doesn't need to be a module either.

David

>=20
> > diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h
> > b/include/linux/platform_data/x86/intel_pmc_ipc.h
> > new file mode 100644
> > index 000000000000..d47b89f873fc
> > --- /dev/null
> > +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Intel Core SoC Power Management Controller Header File
> > + *
> > + * Copyright (c) 2023, Intel Corporation.
> > + * All Rights Reserved.
> ...
>=20
> This copyright is a _bit_ funky. It's worth at least saying in the cover
> letter that this patch has been sitting untouched for over a year, thus
> the old copyright.
>=20
> Or, if you've done actual work with it, I'd assume the copyright needs
> to get updated.
>=20
> > +struct pmc_ipc_cmd {
> > +	u32 cmd;
> > +	u32 sub_cmd;
> > +	u32 size;
> > +	u32 wbuf[4];
> > +};
> > +
> > +/**
> > + * intel_pmc_ipc() - PMC IPC Mailbox accessor
> > + * @ipc_cmd:=C2=A0 struct pmc_ipc_cmd prepared with input to send
>=20
> You probably don't need to restate the literal type of ipc_cmd.
>=20
> > + * @rbuf:=C2=A0=C2=A0=C2=A0=C2=A0 Allocated u32[4] array for returned =
IPC data
>=20
> The "Allocated" thing here threw me a bit. Does this mean it *must* be
> "allocated" as in it comes from kmalloc()? Or can it be on the stack? Or
> part of a static variable?
>=20
> > + * Return: 0 on success. Non-zero on mailbox error
> > + */
> > +int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
>=20
> Also, if it can *only* be u32[4], then the best way to declare it is:
>=20
> struct pmc_ipc_rbuf {
> 	u32 buf[4];
> };
>=20
> and:
>=20
> int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd,
> 		=C2=A0 struct pmc_ipc_rbuf rbuf *rbuf);
>=20
> Then you don't need a comment saying that it must be a u32[4]. It's
> implied in the structure.


