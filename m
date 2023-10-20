Return-Path: <netdev+bounces-42914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E297D09AD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7C2823E0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D1D527;
	Fri, 20 Oct 2023 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cXO/tL5R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A476112
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:45:02 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728FE8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:45:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso4252515e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1697787900; x=1698392700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qKxtPYNqhzbMv+OyAUcNdMaPdGfVggFVkm80lfmZK8M=;
        b=cXO/tL5RmsTTj2kxU+6W4LVhhomMk7LQDA73byeej8f0ZVopp3ruY9MDMzcADiRntc
         Jky25Ea67c362j8BXGF2Lue+GokUgImy2EUkJ0CXTS7sPONgD5rafCCM6D0Ts1IysouS
         3wGcMYuQK68WwkKAdrX9Ph/XRHYlxtdzCVwolflJtkvKBLRIXWh6tWG1wOXJvTCCG/1p
         JN2MyG4t89ObOu4iwXwlv44nMqE2Vrik+hIOQ2IcQdeJyOdH6cVk1WakTTotVOdC0fTM
         wPCaOdMf5ZQOIWTapM2G9Ph1PN2oFYULyt1Z7ZERGmvlEk882jsZGisvrvolpMAA7HVn
         s/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787900; x=1698392700;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKxtPYNqhzbMv+OyAUcNdMaPdGfVggFVkm80lfmZK8M=;
        b=Nv/4wINGxfFXUtEHcEbqtWvjSK2Q4oinMn0Eq6KadYlJktaEzid8mjbMA32VJ51dKm
         Ujd9yrW8xOzaFRhRh6Rog0kUtmFQYMYz2YGDM19jixr75/wi6ZFBVsKMYfoadq8uWgVC
         isyyZuhNQZ0RvvRRo+zgSUZF56/sH/ZklnZcvJADl3WeS8tBgeaGyNix2bFaJfbHOeaD
         gdoYV6yhJSGgpTXrrHSFZ1s0yGY71fmebr0Qhome58ED1VPxdgFFV+XoLyaikMsV1pFp
         yZuAvmJEXakb8SdsOe/AHyP2OzRRf6WukS9xKJvGgeHiwXhOBIXAIuIs92AIN7OkbCY5
         d4Cw==
X-Gm-Message-State: AOJu0Yx0eQHaMsekJNg+2WnaLNQyr0vvviO/9sd0hxdNA6Q+h9/l7IUk
	72p4o7mVYPaNXZtjiCZolKOr3Q==
X-Google-Smtp-Source: AGHT+IGYzHvlbnjMSL7afT8uFlziZ4lZ4q5Q7VqZpeURGAuSbNWHQ0Lgvl3pXp2dePb/agp3CGK8/g==
X-Received: by 2002:a05:600c:1c21:b0:402:8c7e:ba5 with SMTP id j33-20020a05600c1c2100b004028c7e0ba5mr865403wms.18.1697787900051;
        Fri, 20 Oct 2023 00:45:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:4cb:3d1b:4444:11a6? ([2a01:e0a:b41:c160:4cb:3d1b:4444:11a6])
        by smtp.gmail.com with ESMTPSA id n15-20020a7bcbcf000000b004060f0a0fdbsm6269768wmi.41.2023.10.20.00.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:44:59 -0700 (PDT)
Message-ID: <989659fd-c090-40c7-9966-eff8a424f94d@6wind.com>
Date: Fri, 20 Oct 2023 09:44:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/3] netlink: specs: add support for auto-sized
 scalars
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20231018213921.2694459-1-kuba@kernel.org>
 <20231018213921.2694459-4-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231018213921.2694459-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/10/2023 à 23:39, Jakub Kicinski a écrit :
> Support uint / sint types in specs and YNL.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
I'm not a ynl expert, but FWIW:
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[snip]


> +#ifndef MNL_HAS_AUTO_SCALARS
Is there a libmnl patch in flight?

> +static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
> +{
> +	if (mnl_attr_get_len(attr) == 4)
> +		return mnl_attr_get_u32(attr);
> +	return mnl_attr_get_u64(attr);
> +}
> +
> +static inline void
> +mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
> +{
> +	if ((uint32_t)data == (uint64_t)data)
> +		return mnl_attr_put_u32(nlh, type, data);
> +	return mnl_attr_put_u64(nlh, type, data);
> +}
> +#endif

