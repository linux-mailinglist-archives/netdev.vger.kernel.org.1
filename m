Return-Path: <netdev+bounces-181093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C51A83A7C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F1C4A4203
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62733204C23;
	Thu, 10 Apr 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7eVjhap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4611D5CFE;
	Thu, 10 Apr 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269217; cv=none; b=O3yNGWfq6lCE4Ns+IxpmoTMGebwpf8g9dRaejWyZfg5Jk67n/qJyGEyDqIeSYVd+d/B6OrTXNYW9xh5DVwkOSVqJq9TlHp01f+M3Y3dbdhS60bAFlehuMkDbGgOqcrK32ICLWhg0WADYNIJyU4gPxEKnWBnWHUKoRAPgleT2XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269217; c=relaxed/simple;
	bh=wEprt1V9FwlRv54AeVzv/QmIKFbiUarPRZDJwhM3Qrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzaXKtAmrai5Re3jmtiSMZB/FXlbyJDggm4awH2VAqGcD6EOdxbpqVMyVOABWhz1poVRhVsx4LBZsp2hD0znZ+ZlG6oEvnyk1+MocsW+5dFtp/l8to4ENKaDNDwHijBhif5JxmRnXW/VD7t5lN/lI/6YayTA8v/Q2/qU2TjB4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7eVjhap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A267FC4CEDD;
	Thu, 10 Apr 2025 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744269216;
	bh=wEprt1V9FwlRv54AeVzv/QmIKFbiUarPRZDJwhM3Qrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j7eVjhapz6xOom/yV5R7ZMb5uI8G/cRGB+fn3rJA5bkidAdBPUjhNC4IqVO27dqsD
	 /fvJlKHN8zoruwhDiGxISslNVRBI0Sbc3GG1JkK8+woxm0nMAcwFIIcgLYODguM4be
	 1Mldtygh1RP/v1NpogiDsE9gEg+1le7Lg1Vx7kkr+kQYP1Su5sxpUKMFjljO+j027v
	 2e5U5vcLS+Sf1AFryIIEOxTdxn5cpH7v7ILVEbLkXWT+Q9Qw29NxbQh6IZO4VD/umm
	 YOM81fSF8eFKhTUbtMu1SrRXCrPBIW6xNX/yur5CKdpESgNqf3iiqJDQklOBQnZfSV
	 ry45YCIHYO5Yg==
Message-ID: <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
Date: Thu, 10 Apr 2025 09:13:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250409144250.206590-8-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 16:42, Ivan Vecera wrote:
> Add register definitions for components versions and report them
> during probe.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/mfd/zl3073x-core.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> index f0d85f77a7a76..28f28d00da1cc 100644
> --- a/drivers/mfd/zl3073x-core.c
> +++ b/drivers/mfd/zl3073x-core.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/array_size.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/dev_printk.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> @@ -13,6 +15,14 @@
>  #include <net/devlink.h>
>  #include "zl3073x.h"
>  
> +/*
> + * Register Map Page 0, General
> + */
> +ZL3073X_REG16_DEF(id,			0x0001);
> +ZL3073X_REG16_DEF(revision,		0x0003);
> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
> +
>  /*
>   * Regmap ranges
>   */
> @@ -196,7 +206,9 @@ static void zl3073x_devlink_unregister(void *ptr)
>   */
>  int zl3073x_dev_init(struct zl3073x_dev *zldev)
>  {
> +	u16 id, revision, fw_ver;
>  	struct devlink *devlink;
> +	u32 cfg_ver;
>  	int rc;
>  
>  	rc = devm_mutex_init(zldev->dev, &zldev->lock);
> @@ -205,6 +217,30 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev)
>  		return rc;
>  	}
>  
> +	/* Take device lock */

What is a device lock? Why do you need to comment standard guards/mutexes?

> +	scoped_guard(zl3073x, zldev) {
> +		rc = zl3073x_read_id(zldev, &id);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_revision(zldev, &revision);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
> +		if (rc)
> +			return rc;
> +	}

Nothing improved here. Andrew comments are still valid and do not send
v3 before the discussion is resolved.

> +
> +	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
> +		 id, revision, fw_ver);
> +	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));


Both should be dev_dbg. Your driver should be silent on success.

> +
>  	devlink = priv_to_devlink(zldev);
>  	devlink_register(devlink);
>  


Best regards,
Krzysztof

