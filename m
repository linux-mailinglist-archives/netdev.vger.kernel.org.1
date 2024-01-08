Return-Path: <netdev+bounces-62523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC6F827A46
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E29B1C22B94
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6195644C;
	Mon,  8 Jan 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5Z4+kgL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896356744
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d8909a6feso28240595e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 13:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704749875; x=1705354675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isN5jUBrM+iggqV4bpNEI0CU7akVwD4K5/AWg3FrPq8=;
        b=S5Z4+kgLkq7iD+IlV2+ufFQtlbFIsuxA/TW7KCjTtHG4HkXKzySOjqtI1Psdkr2JR3
         QQkoOzWtM26VzZVNmbl88bW5uY+ulf9k9rSgJ2aLQOL5kJhW6zeItmxhQ8yOr+vSupxX
         zTFuT3DbroE7JFM8iXdh4NpYvnG72VzrIhlfeYswQDMfQjdpYyyMFXnVP4gjP0KgQKSc
         diV9ikz6OJY0+kK16oD/4eiUdarSBKmLUdMCh+z/4OUpnZ4A2q7I2z/pZhAUmKuvah/y
         NC6XGpSTrzQ5RzoPHtKN1fpmSo02t0zWnJTyGBBslqDoQV6TruKkwLZAZk+ksDMPnpEq
         JIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749875; x=1705354675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isN5jUBrM+iggqV4bpNEI0CU7akVwD4K5/AWg3FrPq8=;
        b=kHsIJDgrFTzATRQjAO37xQpqopiFHp/mbejho/dYEv9pQmZpylZhsDo5YHzX8rbxKA
         TymrMFHg92nfAN91k7N7oZ3TReRsmzA7MRfoTiAB+ZXlzu63Wd31+UXV1ny6PgC4EW8t
         XuDT53a5ZWMBO5vkmNK1By74AJabD2h0oHoPGowGIIGkjUmeLfHrAL9wA+99FnZJjmB3
         NcqNXz8w0AQY2IIVKuUuX5adJ6ezelfFALuPuS+4m5OkekRN9ALgznU9QUE0EoEtddFh
         4XyIeTC6H5oA5qRr/XxvmIJiwwrBYHfhl4wk0+T+xJR86+j8JBJuqjBcKwtJ2zPQevpQ
         3qXQ==
X-Gm-Message-State: AOJu0YwNblbb1UKqHOvIbuEGkILQyewhZh79pAeYn8QXxRVIjw/GUN/g
	CrQw6tmUXsRNrwdhUndx/ns=
X-Google-Smtp-Source: AGHT+IGIrHa/c6vA4ptpkgpGDHBEZTSFHa4CXik5IXPuK9Gs3Rt5Q/z0SA1WemrjD4NOuZWV05xaUA==
X-Received: by 2002:a7b:c84b:0:b0:40d:3afc:9263 with SMTP id c11-20020a7bc84b000000b0040d3afc9263mr1527333wml.104.1704749875357;
        Mon, 08 Jan 2024 13:37:55 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b0040d5c58c41dsm1091899wms.24.2024.01.08.13.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 13:37:54 -0800 (PST)
Message-ID: <875ef470-4cc0-4b68-bdcd-ea54e2ef5271@gmail.com>
Date: Mon, 8 Jan 2024 23:37:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for device
 state machine
Content-Language: en-US
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com,
 nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com,
 felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
 <MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.12.2023 11:44, Jinjian Song wrote:

[skipped]

> +	switch (mode) {
> +	case T7XX_READY:
> +		return sprintf(buf, "T7XX_MODEM_READY\n");
> +	case T7XX_RESET:
> +		return sprintf(buf, "T7XX_MODEM_RESET\n");
> +	case T7XX_FASTBOOT_DL_SWITCHING:
> +		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_SWITCHING\n");
> +	case T7XX_FASTBOOT_DL_MODE:
> +		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_MODE\n");
> +	case T7XX_FASTBOOT_DUMP_MODE:
> +		return sprintf(buf, "T7XX_MODEM_FASTBOOT_DUMP_MODE\n");
> +	default:
> +		return sprintf(buf, "T7XX_UNKNOWN\n");

Out of curiosity, what the purpose of this common prefix "T7XX_MODEM_"? 
Do you have a plan to support more then T7xx modems?

And BTW, can we use a lighter method of string copying like strncpy()?

--
Sergey

