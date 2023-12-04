Return-Path: <netdev+bounces-53417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A3F802E72
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F441C2098A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91571171B6;
	Mon,  4 Dec 2023 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YFAyG4e+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58983D2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:22:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66cso25425415e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701681747; x=1702286547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr4Vt64RYXhRYcPjjM40iMIdhnoStkhytq2aXTjQ4Bk=;
        b=YFAyG4e+JoYvfq87anD5wXI7MDNUP1o5iCo8B9zjwfyqYxyRbtAxsOoeOYNmdBCR47
         luQyyn9OQjL4Y/C/RdMNlqx8X+ZWEZQDcZzJmZ5NkFu8PgzA1YeVGM2jRD1ETBuijqcU
         lVsvRatKBYPL+uak+1G1CmIIwtZjLzurLUtP/2DJnp3u3m1zm9O2taYEjER3CWfLc4WF
         +g0F9rhgdC6RpvodY2gmW9yb9Jg7+vVd52fmtt+KCx9A4LT7sDtE3twba8g/VB7ifK1U
         vNcBebaHZhrMDidK4xkymw5tUkCu0GLRMS2WkHsf0McrxfE8N/AYsvXMMxS7kkKccIja
         CbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681747; x=1702286547;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr4Vt64RYXhRYcPjjM40iMIdhnoStkhytq2aXTjQ4Bk=;
        b=pVhsLMVYjrTlo/eBSLVqZRsJmfdin3DLTtJ1xg8Yd541Hst9/w/GDorkdmwDZZESgH
         nXJbgIXyYzROCljkF1XJ9BegMntogamDg36uL8SNONGuS7RJFcRunk6Ua/kbJfHekmCC
         8PgBaPkfYBUSIoCHCFEdA6JJtxlCjTwK5bgLMPLs/issPsSzIPsuh3G0FVs6nHImk99r
         X51j3A/k6r5t3GVsXoeES0yhyS4Lyo7SZlkY0rvjF7dEj78xj6UcGJ96aomSqk5oNFlg
         YKQOV9qnt6AwG0cLXBLFcgU+8elK0DvconR+O+1IZAdseFyCJVQvIeLtGzX+TLayboHU
         k53g==
X-Gm-Message-State: AOJu0Yw4+mnMlHP6PVibBBOCG90TRMWjX3dV9olzJEFWxxpDmY6f0WGU
	abPOb73mRsdakF0HfFEkpuZHSA==
X-Google-Smtp-Source: AGHT+IHc8ghBLDwEQZ9LHRTaRvJqKyyww6iDAhCA/KMKVHZLs237HfM1H6xRzFz1GtBS6dSD0eG9aw==
X-Received: by 2002:a05:600c:acd:b0:40b:38a8:6c65 with SMTP id c13-20020a05600c0acd00b0040b38a86c65mr1664855wmr.26.1701681746784;
        Mon, 04 Dec 2023 01:22:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6cba:8826:daed:6772? ([2a01:e0a:b41:c160:6cba:8826:daed:6772])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b0040b3d33ab55sm18093140wmb.47.2023.12.04.01.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:22:26 -0800 (PST)
Message-ID: <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
Date: Mon, 4 Dec 2023 10:22:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] netlink: Return unsigned value for nla_len()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>,
 Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231202202539.it.704-kees@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231202202539.it.704-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/12/2023 à 21:25, Kees Cook a écrit :
> The return value from nla_len() is never expected to be negative, and can
> never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> on the function. This will let GCC's value range optimization passes
> know that the return can never be negative, and can never be larger than
> u16. As recently discussed[1], this silences the following warning in
> GCC 12+:
> 
> net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
> 12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12893 |                        flex_array_size(cqm_config, rssi_thresholds,
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12894 |                                        n_thresholds));
>       |                                        ~~~~~~~~~~~~~~
> 
> A future change would be to clamp the subtraction to make sure it never
> wraps around if nla_len is somehow less than NLA_HDRLEN, which would
> have the additional benefit of being defensive in the face of nlattr
> corruption or logic errors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Max Schulze <max.schulze@online.de>
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  v2:
>  - do not clamp return value (kuba)
>  - adjust NLA_HDRLEN to be u16 also
>  v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
> ---
>  include/net/netlink.h        | 2 +-
>  include/uapi/linux/netlink.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 83bdf787aeee..7678a596a86b 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
>   * nla_len - length of payload
>   * @nla: netlink attribute
>   */
> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
>  	return nla->nla_len - NLA_HDRLEN;
>  }
> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> index f87aaf28a649..270feed9fd63 100644
> --- a/include/uapi/linux/netlink.h
> +++ b/include/uapi/linux/netlink.h
> @@ -247,7 +247,7 @@ struct nlattr {
>  
>  #define NLA_ALIGNTO		4
>  #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> -#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
> +#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
I wonder if this may break the compilation of some userspace tools with errors
like comparing signed and unsigned values.


Regards,
Nicolas

