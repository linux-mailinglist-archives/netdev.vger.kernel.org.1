Return-Path: <netdev+bounces-163597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A5A2AE15
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627EC3A33E5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49D23536E;
	Thu,  6 Feb 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFCLfZYo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766D235361;
	Thu,  6 Feb 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860409; cv=none; b=g2IfAwgT5nklH0LjKhGgWDU3CCF8+i6DF0b+oGcAWRuqz5L4P/asLpKguMrNWH8bSir3AC29VilaLN781VIRq4PSXKRFHAFUZsljWWNyZPXv7+XjPm2oMKasZlREJ4jnoQtdg+YL4B3ypwF1dnIw+b76+4AbdkkgxIUf7j2boTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860409; c=relaxed/simple;
	bh=ATMIiU+Ci2luWIZJIX8XTUarrtJN3EZMmLUtcy7ySfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXdrdXk9fs1r2kOWxXRR338EfRPw1vEbaaQt3fYyHMiSuMDELI0MQDBSoAYczcUViYXr4lUmHGkhF8BC23qhYhHN1UehZeNtIcwGEgaxYaclTjgN0qKaSWISy4laFSJyn0qAPD/IDcbAyqIrhcyVYSHDF/9/B4CVRmtiUWE6iWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFCLfZYo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738860408; x=1770396408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ATMIiU+Ci2luWIZJIX8XTUarrtJN3EZMmLUtcy7ySfw=;
  b=eFCLfZYoIUcYaZuCR/V6K1S3EZ0ysEkQRW+iLJmdHJFMj1UHpU+Di0qv
   Z1okRRUaacmqXr05rCvcRFOduoXjJScyDfpN8QbFGrGvK7z+CC3F1oSBu
   xG3i1gmA0TTym71FUK+GJEY7ILyrD7r+RlF9hr+0ogUs5m+y8LI42+s9k
   A8r5dySER3GKTKdFouwps7tjAkETcyILKAdbKDpwloOyoqf8XoJlECr8S
   nThwwrEIT8U6bcQrfrOF7WOp1bZG32CXFSMxEsUtfSfAj2KWnjGITx+Q2
   7zcHgk+YYo4keyn0yopqre83MpQLTbyPHXT0N7OR8uEEsPK3XDHKR+QOk
   Q==;
X-CSE-ConnectionGUID: OrrKYed7SciGuQ2XLa3xog==
X-CSE-MsgGUID: qmLzls3zThy3NKxOGowl8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39346505"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39346505"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:46:26 -0800
X-CSE-ConnectionGUID: QIWgW/mPR46JvsO+fjSr2w==
X-CSE-MsgGUID: vTDDBNblR1GMyl+aqdgkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111176227"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.110.238]) ([10.125.110.238])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:46:23 -0800
Message-ID: <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>
Date: Thu, 6 Feb 2025 08:46:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/7] arch: x86: add IPC mailbox accessor
 function and add SoC register access
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 David E Box <david.e.box@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-4-yong.liang.choong@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250206131859.2960543-4-yong.liang.choong@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 05:18, Choong Yong Liang wrote:
> 
> - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> - Add support to use IPC command allows host to access SoC registers 
> through PMC firmware that are otherwise inaccessible to the host due
> to security policies.

I'm not quite parsing that second bullet as a complete sentence.

But that sounds scary! Why is the fact that they are "otherwise
inaccessible" relevant here?

...
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 87198d957e2f..631c1f10776c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -688,6 +688,15 @@ config X86_AMD_PLATFORM_DEVICE
>  	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
>  	  implemented under PINCTRL subsystem.
>  
> +config INTEL_PMC_IPC
> +	tristate "Intel Core SoC Power Management Controller IPC mailbox"
> +	depends on ACPI
> +	help
> +	  This option enables sideband register access support for Intel SoC
> +	  power management controller IPC mailbox.
> +
> +	  If you don't require the option or are in doubt, say N.

Could we perhaps beef this up a bit to help users figure out if they
want to turn this on? Really the only word in the entire help text
that's useful is "Intel".

I'm not even sure we *want* to expose this to users. Can we just leave
it as:

	config INTEL_PMC_IPC
		def_tristate n
		depends on ACPI

so that it only gets enabled by the "select" in the other patches?

> + * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> + *          David E. Box <david.e.box@linux.intel.com>

I'd probably just leave the authors bit out. It might have been useful
in the 90's, but that's what git is for today.

> +	obj = buffer.pointer;
> +	/* Check if the number of elements in package is 5 */
> +	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
> +		const union acpi_object *objs = obj->package.elements;
> +

The comment there is just not super useful. It might be useful to say
*why* the number of elements needs to be 5.

> +EXPORT_SYMBOL(intel_pmc_ipc);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intel PMC IPC Mailbox accessor");

Honestly, is this even worth being a module? How much code are we
talking about here?

> diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
> new file mode 100644
> index 000000000000..d47b89f873fc
> --- /dev/null
> +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Intel Core SoC Power Management Controller Header File
> + *
> + * Copyright (c) 2023, Intel Corporation.
> + * All Rights Reserved.
...

This copyright is a _bit_ funky. It's worth at least saying in the cover
letter that this patch has been sitting untouched for over a year, thus
the old copyright.

Or, if you've done actual work with it, I'd assume the copyright needs
to get updated.

> +struct pmc_ipc_cmd {
> +	u32 cmd;
> +	u32 sub_cmd;
> +	u32 size;
> +	u32 wbuf[4];
> +};
> +
> +/**
> + * intel_pmc_ipc() - PMC IPC Mailbox accessor
> + * @ipc_cmd:  struct pmc_ipc_cmd prepared with input to send

You probably don't need to restate the literal type of ipc_cmd.

> + * @rbuf:     Allocated u32[4] array for returned IPC data

The "Allocated" thing here threw me a bit. Does this mean it *must* be
"allocated" as in it comes from kmalloc()? Or can it be on the stack? Or
part of a static variable?

> + * Return: 0 on success. Non-zero on mailbox error
> + */
> +int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);

Also, if it can *only* be u32[4], then the best way to declare it is:

struct pmc_ipc_rbuf {
	u32 buf[4];
};

and:

int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd,
		  struct pmc_ipc_rbuf rbuf *rbuf);

Then you don't need a comment saying that it must be a u32[4]. It's
implied in the structure.

