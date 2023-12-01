Return-Path: <netdev+bounces-52771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099DF800271
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 05:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D35B20E14
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 04:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEA79CD;
	Fri,  1 Dec 2023 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6YmYnBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EBB1719
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 20:19:51 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a9b393f53so185226d6.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 20:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701404390; x=1702009190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19iSZ3dg4qZNK3oPFoc534qI/hIcheOtDDFnjJagv6w=;
        b=I6YmYnBQ0vzwY2TtrgvbpDUXI5+lEYyTfs+opftuHoW+uvWnclxDA25kXQUh/5GYn1
         PJ0b4T4hS4mH7Tzps5lwiWaxeF3fxamx9H/HuzEt4/N+DQgDVblgkSkQXl5wMd8u8ltb
         duc4Xxru4hY0/63iV5WH5UFie2oylPhswrK6Z/8NMLswFA20qKGvgypTAqina0AW+fmE
         Jbf78ufsadQtoY1Ivui+rrosOCvmTvNqZv1Sb8iFEuTLuFKkIDVtYGRhaXIML6m1oGJd
         fFed6ckgPYX+7zu2WWn1/AzcOQLvAx8nt5ludKVzw7LLSupGenuzlCThDzeUu24ejt2H
         5SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701404390; x=1702009190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19iSZ3dg4qZNK3oPFoc534qI/hIcheOtDDFnjJagv6w=;
        b=Srp+QIiOtGnOF7NhYGa4DIXHJ6FFLg8m9HBDlSIiZ+sltkBhyh4dNfRNM60uRK8Sxv
         GF+QOzFG4FR3i2l2Hx7zdrcSZXsJQKsE6UxfKFrF4BokLZBfBufK3R49ScZXxXhhiuIw
         NearvMzubmE/HwgpHxqMnApfM15VrTQd0qPvrUc+8EcFOBR64z9pNCxqWHJxgftW8eTF
         DSqjjQ5x7aB8g2kRxxgDCmLDZM/zSgg0gR0NPuZxYW/FWt+Bhv8VpRa4EdCtIE5A6qq1
         mhAXEL0ERAbcu6lEEjGiAz/XUbR8aSrJBhPnzWeAEeWHYQzSE4RUzb7s/dSLs4tONg32
         38eQ==
X-Gm-Message-State: AOJu0Yx0zSOmAL0r10NU3no7hUSdk9EhMT1hKQ8Xxv3JpftDBmYqMu+F
	xCXrfiNsjQkerupZM29CGVM=
X-Google-Smtp-Source: AGHT+IFjYcjU/Hb4PdR6nFZoxZdZwLCcSY1PQfQ5yT+eAaSd4IiQD3PUFdbDaiRK2dhhnUfR3kimgA==
X-Received: by 2002:ad4:53a8:0:b0:67a:98d1:4954 with SMTP id j8-20020ad453a8000000b0067a98d14954mr576890qvv.22.1701404390620;
        Thu, 30 Nov 2023 20:19:50 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id mh10-20020a056214564a00b0067a9235d5f0sm501597qvb.105.2023.11.30.20.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 20:19:50 -0800 (PST)
Message-ID: <bb0bf95c-84c3-46f5-882f-23074a5e66c0@gmail.com>
Date: Thu, 30 Nov 2023 20:19:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] ionic: small driver fixes
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20231201000519.13363-1-shannon.nelson@amd.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/30/2023 4:05 PM, Shannon Nelson wrote:
> This is a collection of small fixes for the ionic driver,
> mostly code cleanup items.
> 
> Brett Creeley (5):
>    ionic: Use cached VF attributes
>    ionic: Don't check null when calling vfree()
>    ionic: Make the check for Tx HW timestamping more obvious
>    ionic: Fix dim work handling in split interrupt mode
>    ionic: Re-arrange ionic_intr_info struct for cache perf
> 
> Shannon Nelson (2):
>    ionic: fix snprintf format length warning
>    ionic: set ionic ptr before setting up ethtool ops

FWIW, for the whole series:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Clear and concise commit messages, nice!
-- 
Florian

