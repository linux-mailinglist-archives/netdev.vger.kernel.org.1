Return-Path: <netdev+bounces-48373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C37EE2C6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C00280EB9
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404530CE3;
	Thu, 16 Nov 2023 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE1y3FGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2571E12F
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:29:27 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7781b176131so43770985a.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700144966; x=1700749766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aay8Gphj0/nuSHPq5fUJSvyLI5CGtbTCBmZdpjsgaw0=;
        b=vE1y3FGSC7UBHqSveR5bgfH/xKXllkTFdnpzwZlqnbR8238eDEavtF4Yb0haw3UqBb
         VwOVvw2eBA4q1Yb1xNNGWFp/n4WYZ/fnWI/uTOBF/lB/l4a67tgyqZnFVCWL6ohNv9bi
         FMTBD5BKW9YYsWkDs3/J7e1l5DfSYLvMahNH6DzMIUThbnK7rv+DaoDBTO689jTnSYto
         07iNzXhQ6YcP6JVmyR83FJ0jMNZNbCxff6WYAHK/w8fTPtlTnp+9hwfqB3vD2qwCTuyL
         cdOxVglbhksQFMxHzTXhT9fEN+dHyrqdVL2TkWrJ+gWggsF+UaHI6zpGDTf8MdykjetD
         FCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144966; x=1700749766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aay8Gphj0/nuSHPq5fUJSvyLI5CGtbTCBmZdpjsgaw0=;
        b=BHza5YIjPhpkCZdsSfR68TTudiF6eq9Kp/XCeFdIhoBNWbVVkplfcVCiIG3mqfcMcN
         JfxHsdXv5IcecRGE00GSpNdNHmTmFt0HPcP4B5fkCoER0+mgPljaksGlTDBXOnXaPgCv
         bE3jji3j7lAwc4IdropDy8cUlg4rDeR1MqIMIBTyxqxQYHLYS0ZXJV9cyDAtrQrzVTuO
         3DHLfA6F5A8wJSYkLPbNxNaJsYFI4AsioJ8qh0mjutRa7hJdcSjNDI2m9js8D5s84yRL
         I7ihwnT7LbXuKHwCZQs+HTEVUWz9tXcuzlGKLc0/8/set0mP3O3K9jhPD61WUVJU82fF
         uEKg==
X-Gm-Message-State: AOJu0YzXbB2wDZMeEtXpHP3eqWScrcSEZ9yMl9dEj4DhJmGO3vHR6dfR
	u8CXGIq0YobtIm01jlBZjYWlgQ==
X-Google-Smtp-Source: AGHT+IEYJFIUZmeG+D9pxidkhnHsrB1zDAS2whTr4lQ1Aomvs7qakikml6CMSPQnwA58Mn5GmtGUBA==
X-Received: by 2002:a05:620a:4489:b0:775:be7b:d9db with SMTP id x9-20020a05620a448900b00775be7bd9dbmr9514049qkp.37.1700144966184;
        Thu, 16 Nov 2023 06:29:26 -0800 (PST)
Received: from [10.50.4.74] ([50.201.115.146])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a130600b007742bc74184sm4317754qkj.110.2023.11.16.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:29:25 -0800 (PST)
Message-ID: <faea7171-31bf-43b7-a830-62f69002b823@linaro.org>
Date: Thu, 16 Nov 2023 15:29:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/11/2023 15:01, Kory Maincent wrote:
> Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
> This driver only support i2c communication for now.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  MAINTAINERS                  |    1 +
>  drivers/net/pse-pd/Kconfig   |   11 +
>  drivers/net/pse-pd/Makefile  |    1 +
>  drivers/net/pse-pd/pd692x0.c | 1049 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1062 insertions(+)

....

> +
> +err_fw_unregister:
> +	firmware_upload_unregister(priv->fwl);
> +	return ret;
> +}
> +
> +static void pd692x0_i2c_remove(struct i2c_client *client)
> +{
> +	struct pd692x0_priv *priv = i2c_get_clientdata(client);
> +
> +	firmware_upload_unregister(priv->fwl);
> +}
> +
> +static const struct i2c_device_id pd692x0_id[] = {
> +	{ PD692X0_PSE_NAME, 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, pd692x0_id);
> +
> +static const struct of_device_id pd692x0_of_match[] = {
> +	{ .compatible = "microchip,pd69200", },
> +	{ .compatible = "microchip,pd69210", },
> +	{ .compatible = "microchip,pd69220", },

So they are the same from driver point of view.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pd692x0_of_match);
> +
> +static struct i2c_driver pd692x0_driver = {
> +	.probe		= pd692x0_i2c_probe,
> +	.remove		= pd692x0_i2c_remove,
> +	.id_table	= pd692x0_id,
> +	.driver		= {
> +		.name		= PD692X0_PSE_NAME,
> +		.of_match_table = of_match_ptr(pd692x0_of_match),

Drop of_match_ptr, leads to warnings.


Best regards,
Krzysztof


