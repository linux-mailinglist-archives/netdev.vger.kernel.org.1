Return-Path: <netdev+bounces-58498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5A816A87
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F0EB20B9F
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666B12B75;
	Mon, 18 Dec 2023 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Aeb7gbD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788013AC9
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so26818465e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894040; x=1703498840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgSaHLgLTodWC2yz9NpazNVGTJRi7IzB1/Q/gA4W3IA=;
        b=Aeb7gbD5flh22ltA724ckdA4Qjh85gcQVYX4p+roQkUfX2zL5IKT76SQrQOdPFzSy3
         WY8CHX1f8oYg9EkgkN3aJud8JtNhYfiud/C0Ytdy9XiTiwuvxudLWbM8gQftm5bdsoI5
         qlsNPJ3Wp6+bYkF7ENnJKpU3704vYdXAXHqKj8kh/BTo+uo3im1k4g6Il6VJjGlF/sdl
         +m5X++Ag19mgN4ozlUZ0jFIYennwI841KMC/m7LaHEaHwqEB5hYatT07zmFKGzLpghQK
         ECJN55rDJx51YWXClaS/VqwnziSxBh7O1oDWfrvNlny+SoIPancdc1/ue/xxyoV2CWF6
         VKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894040; x=1703498840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgSaHLgLTodWC2yz9NpazNVGTJRi7IzB1/Q/gA4W3IA=;
        b=Cw7q173ny90wgQhV2j4bvUIKJh/o58uPudgZSpXtsqL2oz0RPD2qh9uz49dIL5EEEC
         byDsFnSYSQSpWn1BjWE0wiTjQ4M7iYrgDiBmE1b/qheESJWlYLxiFKLibjigXwgXspej
         mizDly/fhkbKsdQcs15rBwy916WzfI6g5dQwhZJDpRLqtJxIIkcRFyNdoUzHx4K357jA
         8YBfNyATROERl9/ynOUFyxg1NNKITeVGAhW+HWzjJMOQrpbGaWWGlA4OzR9UrDE7uetX
         9NB119GCAncpLm3J0TNwA52xL8P+LREwTjpYAqscuH4dQnz6DZijBAP0fXfWqo4+AyYG
         ohXg==
X-Gm-Message-State: AOJu0YzycaV59bhRPmzu0IKbez7j+m5No13eXT3BosZW9WUK0DO5BxoO
	SYTSLCKswS74ZaZdaCrViU1UXg==
X-Google-Smtp-Source: AGHT+IFZ5DOHfPejP2r4NdgO3Ho+kff8z8GEToJyblH512W1+JmsUPr1ACnRBwBIbILc84wi8MiuGQ==
X-Received: by 2002:a1c:7c07:0:b0:40c:62be:4fe7 with SMTP id x7-20020a1c7c07000000b0040c62be4fe7mr1868633wmc.118.1702894039977;
        Mon, 18 Dec 2023 02:07:19 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:07:19 -0800 (PST)
Message-ID: <8527ed96-8d91-40cf-b1dc-4a99e732872d@blackwall.org>
Date: Mon, 18 Dec 2023 12:07:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] bridge: add MDB state mask uAPI attribute
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Currently, the 'state' field in 'struct br_port_msg' can be set to 1 if
> the MDB entry is permanent or 0 if it is temporary. Additional states
> might be added in the future.
> 
> In a similar fashion to 'NDA_NDM_STATE_MASK', add an MDB state mask uAPI
> attribute that will allow the upcoming bulk deletion API to bulk delete
> MDB entries with a certain state or any state.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   include/uapi/linux/if_bridge.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 2e23f99dc0f1..a5b743a2f775 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -757,6 +757,7 @@ enum {
>   	MDBE_ATTR_VNI,
>   	MDBE_ATTR_IFINDEX,
>   	MDBE_ATTR_SRC_VNI,
> +	MDBE_ATTR_STATE_MASK,
>   	__MDBE_ATTR_MAX,
>   };
>   #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



