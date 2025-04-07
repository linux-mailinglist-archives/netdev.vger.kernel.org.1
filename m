Return-Path: <netdev+bounces-179818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367BA7E92E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1078188354D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E9217F55;
	Mon,  7 Apr 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f66dLywR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D22163B8;
	Mon,  7 Apr 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048439; cv=none; b=G5S0iFzH4Ebv9vCim+MLU4Z+Qp7Bv/pck1TMQmbi/KPSd2mE2MY081vDEhopxWXV7kqnnM9YvIXqfxixb0fuDo7lMX8DIgRT5CvQQ5vtlMpfu5VIgl+1W+ImCeGZdBfVaG4EnsdkOgVwEfBn6Lruc3rykQYgg8loK2rj6mDsQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048439; c=relaxed/simple;
	bh=xNvsMA5KuahdV6GrJ8OI8sJo38Wk+r/4u7W6iwE+6P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpYxvEM8XzMSSRv+xiwRNkw2jKvatLM9c1tHK8ApKbFCiuKgG58JjYW594DbNO6aRCu+yuTrcRvygwMKttBJhKNySStQ+3hhRagFLuakqJWsQDpzrLH/ohAwimALFpDouRetfb51WXXPLVNsvG+BVpPAPmNbXXKD7lnjXiXEj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f66dLywR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B69C4CEE7;
	Mon,  7 Apr 2025 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048439;
	bh=xNvsMA5KuahdV6GrJ8OI8sJo38Wk+r/4u7W6iwE+6P8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f66dLywRuL//vqXKAd24lUb3o5bIe2aCZtIRJ6b/if5xhWewKkbg1aaKYcNOxQPWz
	 9X/fz5zyjyrIqi+x7ueOo9SZP3Q2+T+X2qMdbJQtLEscZRjqpKc9q8uuyI6QmvMNNa
	 vyhJOJRUR6/ZCG1wd8Ajv0F3XPtzjE69DMt8QTl1J4MLuQIiKacymMwwu0bH1HWfOF
	 TdMX48m8mgBsWqNj5TjEt+39M6b4z4KehaozgrwIUf6fk7iAK1Tzc/nFJNR/HhymZa
	 Mf0F8yf2HEDER9IrlZXAI8R3FIO7XTMH6zshIF04yn6z5TF14jk86vvqsegHj0xBK3
	 Ts9klsgOrHwMw==
Message-ID: <9b38d033-72aa-4fb0-b1ee-41bbe3884040@kernel.org>
Date: Mon, 7 Apr 2025 19:53:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250407172836.1009461-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/2025 19:28, Ivan Vecera wrote:
> This adds base MFD driver for Microchip Azurite ZL3073x chip family.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> These chips provide DPLL and PHC (PTP) functionality and they can
> be connected over I2C or SPI bus.
> 

...

> +/**
> + * zl3073x_get_regmap_config - return pointer to regmap config
> + *
> + * Returns pointer to regmap config
> + */
> +const struct regmap_config *zl3073x_get_regmap_config(void)
> +{
> +	return &zl3073x_regmap_config;
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
> +
> +struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
> +{
> +	struct zl3073x_dev *zldev;
> +
> +	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
> +
> +int zl3073x_dev_init(struct zl3073x_dev *zldev)
> +{
> +	devm_mutex_init(zldev->dev, &zldev->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
> +
> +void zl3073x_dev_exit(struct zl3073x_dev *zldev)
> +{
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");

Why do you add empty exports?



> diff --git a/drivers/mfd/zl3073x-spi.c b/drivers/mfd/zl3073x-spi.c
> new file mode 100644
> index 0000000000000..a6b9a366a7585
> --- /dev/null
> +++ b/drivers/mfd/zl3073x-spi.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +#include "zl3073x.h"
> +
> +static const struct spi_device_id zl3073x_spi_id[] = {
> +	{ "zl3073x-spi", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
> +
> +static const struct of_device_id zl3073x_spi_of_match[] = {
> +	{ .compatible = "microchip,zl3073x-spi" },


You need bindings. If they are somewhere in this patchset then you need
correct order so before users (see DT submitting patches).

> +static void zl3073x_spi_remove(struct spi_device *spidev)
> +{
> +	struct zl3073x_dev *zldev;
> +
> +	zldev = spi_get_drvdata(spidev);
> +	zl3073x_dev_exit(zldev);
> +}
> +
> +static struct spi_driver zl3073x_spi_driver = {
> +	.driver = {
> +		.name = "zl3073x-spi",
> +		.of_match_table = of_match_ptr(zl3073x_spi_of_match),

Drop of_match_ptr, you have warnings here.


> +	},
> +	.probe = zl3073x_spi_probe,
> +	.remove = zl3073x_spi_remove,
> +	.id_table = zl3073x_spi_id,
> +};
> +



Best regards,
Krzysztof

