Return-Path: <netdev+bounces-42910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBE7D0977
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F90DB2138B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B603D2E9;
	Fri, 20 Oct 2023 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="N51RZM0w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77893DDA2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:24:23 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E1D69
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:24:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso650322e87.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1697786659; x=1698391459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NKu6mUsoqfAL1uZvXUdGi9EKeYA/QVff2QYGWkp0uA=;
        b=N51RZM0wD5s6xge0oqtN3qu3moS0dZ58bdVWx5qeRmsXU075rdH11w4t1W8+iXgBFc
         sU0i9KCXIOuYIWelCc7JGi42KTmuc4HVhKIg8EMC41P05T2Fw2F1KebBZEpvCe2Ablp9
         g7seHF01PtMYQLxIg+8/qWt45WV7iro4TzdlyizRsPGs1qwZ0kKr4gcCSkF5JDfDDeCy
         DI2NKSq9eCq2ioCz/2qyQygyI5HS5WW5M6X8JibZjDYuAJFsbPUUmHDk8wVDdFgV/nN3
         tRNYTLp6Igee5SBCv+tdpYDoy/aCfOJiMK1mvt5zs79c9uvO7u11SUZPYm8QddlLaOkz
         JbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786659; x=1698391459;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NKu6mUsoqfAL1uZvXUdGi9EKeYA/QVff2QYGWkp0uA=;
        b=DvPHCzbOXbI6mhH6r3lYuZTM8buG21s6PFOB21EtR+Cqu5LuiGC7pax7Iv/gtLvfbx
         RO0EjDkT5DU3pInrVJnKtzdkcXZvLwrFudFdFnCm8J1cMRoiQc4iwTSdd8Xy61OrLo9N
         xVN/5Z4ATdu+5thhLYB5Fq4doHJ9f/kzXhtqJ9OenqBuMCnHfyv9OCa3GE6itQDRXL48
         PEdEcKvkwhK9f6LmmeN55GKeE8snVdyQquuwQGVnEPdo/N6Fec8D5tidrh7SxbLjJJeK
         ckKv29oCyOBxjXhbtDPvTJgtow0SW8KpxhciCRh2rqBe8NqP0itBoI3WDc6a3FqYinPF
         3c0Q==
X-Gm-Message-State: AOJu0YzV6aGfqTaNcPDCFuBOc1ZCnm4YiweuN8f6eiz4zknSrTIUsEWT
	nvYpqknxqP6UKZ+jC96aAHP0xN3zJwN3bQ00Zp9jcg==
X-Google-Smtp-Source: AGHT+IGvXcrwf5f5ZS8UTYdNYCBoBkQPavOrnnAtBUhiTMxEU6Cjs4uotlglmT1kg42yOtmGGHtRig==
X-Received: by 2002:ac2:52b0:0:b0:500:bd6f:a320 with SMTP id r16-20020ac252b0000000b00500bd6fa320mr570281lfm.42.1697786659332;
        Fri, 20 Oct 2023 00:24:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:4cb:3d1b:4444:11a6? ([2a01:e0a:b41:c160:4cb:3d1b:4444:11a6])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040775fd5bf9sm1508944wmq.0.2023.10.20.00.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:24:18 -0700 (PDT)
Message-ID: <ce718606-df08-4249-b29d-6ec30a4c4648@6wind.com>
Date: Fri, 20 Oct 2023 09:24:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/3] netlink: add variable-length / auto integers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20231018213921.2694459-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231018213921.2694459-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/10/2023 à 23:39, Jakub Kicinski a écrit :
> Add netlink support for "common" / variable-length / auto integers
> which are carried at the message level as either 4B or 8B depending
> on the exact value. This saves space and will hopefully decrease
> the number of instances where we realize that we needed more bits
> after uAPI is set is stone. It also loosens the alignment requirements,
> avoiding the need for padding.
> 
> This mini-series is a fuller version of the previous RFC:
> https://lore.kernel.org/netdev/20121204.130914.1457976839967676240.davem@davemloft.net/
Probably https://lore.kernel.org/all/20231011003313.105315-1-kuba@kernel.org/ ;-)

Nicolas

> No user included here. I have tested (and will use) it
> in the upcoming page pool API but the assumption is that
> it will be widely applicable. So sending without a user.
> 
> Jakub Kicinski (3):
>   tools: ynl-gen: make the mnl_type() method public
>   netlink: add variable-length / auto integers
>   netlink: specs: add support for auto-sized scalars
> 
>  Documentation/netlink/genetlink-c.yaml        |  3 +-
>  Documentation/netlink/genetlink-legacy.yaml   |  3 +-
>  Documentation/netlink/genetlink.yaml          |  3 +-
>  Documentation/userspace-api/netlink/specs.rst | 18 ++++-
>  include/net/netlink.h                         | 69 ++++++++++++++++++-
>  include/uapi/linux/netlink.h                  |  5 ++
>  lib/nlattr.c                                  | 22 ++++++
>  net/netlink/policy.c                          | 14 +++-
>  tools/net/ynl/lib/nlspec.py                   |  6 ++
>  tools/net/ynl/lib/ynl.c                       |  6 ++
>  tools/net/ynl/lib/ynl.h                       | 17 +++++
>  tools/net/ynl/lib/ynl.py                      | 14 ++++
>  tools/net/ynl/ynl-gen-c.py                    | 44 ++++++------
>  13 files changed, 192 insertions(+), 32 deletions(-)
> 

