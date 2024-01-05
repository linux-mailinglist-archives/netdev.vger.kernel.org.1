Return-Path: <netdev+bounces-62028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C104B825974
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5596F1F24416
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0C321B8;
	Fri,  5 Jan 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RwSGVtCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BF328D1
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e3712d259so11666305e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704477185; x=1705081985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMKUrW+SGHc5m8pr5MaYnDjxSxXA2LuB1vCwhgWO8Kg=;
        b=RwSGVtCH3rQTsQntSARrYK69h30GhkeGYbTRRByesAv5nd4Ayjt4HqP9XHLTo3eoFW
         gz4naL93dN5y8YUG+TbkFFyXMvjLNa2CEwcT3LlB4A4HVpZ1vD7eoVDCY4QKwxCLTaqo
         4nd8qeLd2fiq7orFB6USWi/DCf/gDStZgfXrBKwrXs4CNbmCrZnE9p2skPFSPXxuhrT/
         awuh4PiX8S5/ALsqqHYsq6zskgfSRqm3Dst8z6TvyKQrJJiKJfUxDbaRdqqHUKLWtaZg
         vA1EV6bynL9OLD6bAQBnkBL+ZBUYwDPleo4jvJv1FMPDkVlbugFfvQi2iiJftRwrNUNK
         KnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477185; x=1705081985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMKUrW+SGHc5m8pr5MaYnDjxSxXA2LuB1vCwhgWO8Kg=;
        b=dgjBNFrAvHwqFAID+fy1sYinmVf1th/xr+jwA8+HulaVl7GFg6VQSYJHToIDi40UzY
         Mmu53TD5cPip5V5oBh6kofJIamZ/Wst9OoLPGP/e/9Ap8nKjKft5wozvR3GO6siX4F6M
         Q0sSO76BaL1ImoVokVEQxsJD6PX0yoDbiFwB5Xjb0KFJk8xLrYICEojKKVZ2lNDj+r3j
         7/8VGeH4O/JThoEwdsfla2I55x0txbVVeib+gUbbJ/JoJOBQw/DqJ+cKZeglyYDwbspS
         RhWbPWZsb2oy1iQqSXf39OEAox85omGQjz9oTxxtj6+t/E2MfFHvE0dlm4WxQfLVHiRY
         9iag==
X-Gm-Message-State: AOJu0YyN+G2y2/ZpH32okCpZM9059y96qCe2iGkqQ+8lMncfWfaMlU8i
	saXBAA8UnJJKKamjUKO0ickvs0ZAdMfeIQ==
X-Google-Smtp-Source: AGHT+IHhxmGhOS9RO3aRAOTAraXs4zoro6fOAFluwf2bf7i+NWpsrAahcb8Q3jZxiEx19UcwhH0jdA==
X-Received: by 2002:a05:600c:2b10:b0:40d:85a5:8bce with SMTP id y16-20020a05600c2b1000b0040d85a58bcemr1010862wme.105.1704477185183;
        Fri, 05 Jan 2024 09:53:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b0040d934f48d3sm2240864wmn.32.2024.01.05.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:53:04 -0800 (PST)
Date: Fri, 5 Jan 2024 18:53:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	michal.michalik@intel.com, rrameshbabu@nvidia.com
Subject: Re: [patch net-next 0/3] dpll: expose fractional frequency offset
 value to user
Message-ID: <ZZhB_vWTb3VZGWBK@nanopsycho>
References: <20240103132838.1501801-1-jiri@resnulli.us>
 <71ab339e-0d6e-4a9d-93fd-d9d291e5e3ae@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ab339e-0d6e-4a9d-93fd-d9d291e5e3ae@linux.dev>

Fri, Jan 05, 2024 at 12:44:23PM CET, vadim.fedorenko@linux.dev wrote:
>On 03/01/2024 13:28, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Allow to expose pin fractional frequency offset value over new DPLL
>> generic netlink attribute. Add an op to get the value from the driver.
>> Implement this new op in mlx5 driver.
>> 
>> Jiri Pirko (3):
>>    dpll: expose fractional frequency offset value to user
>>    net/mlx5: DPLL, Use struct to get values from
>>      mlx5_dpll_synce_status_get()
>>    net/mlx5: DPLL, Implement fractional frequency offset get pin op
>> 
>>   Documentation/netlink/specs/dpll.yaml         | 11 +++
>>   drivers/dpll/dpll_netlink.c                   | 24 +++++
>>   .../net/ethernet/mellanox/mlx5/core/dpll.c    | 94 ++++++++++++-------
>>   include/linux/dpll.h                          |  3 +
>>   include/uapi/linux/dpll.h                     |  1 +
>>   5 files changed, 98 insertions(+), 35 deletions(-)
>> 
>
>Interesting attribute, it's good that hardware can expose this info.
>
>Did you think about building some monitoring/alerts based on it?

The deamon we use internally just exposes this to user mainly for
debugging purposes now. Not sure about another plans with this.


>
>For the series (I'm not sure if it's enough for mlx5, but the
>refactoring looks nice):
>
>Acked-By: Vadim Fedorenko <vadim.fedorenko@linux.dev>

