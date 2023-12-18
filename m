Return-Path: <netdev+bounces-58499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C612816A8A
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC70B20EC8
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D712B97;
	Mon, 18 Dec 2023 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="utePmi09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6F12B7A
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c68c1990dso32123085e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894115; x=1703498915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo/CHEd7dbzAEsS6JzfIDLPp9KiSxgXCjh4CRPBuAoo=;
        b=utePmi09aIEVQB8t7vTMXuO3b0hju0UCL3mPEiql30OGDLHCO5V39hnVU1ynrib0G3
         G8bR1vK6RLET6vwrNOz/oO/hCvXYqbC1J3Q0UMbKsMn/QztshE+3Cb5p0SVEHxCgApv/
         grwWGHcjPiC9ghT3G2HnQPVXTgMz13ZF2PKwWMv8y5DIDs3l52iCP15XrDekyrf4I5qt
         BCuK4G3p1En5NgRApN2Ihr5VkdFgobGA+24P20q3W9gCtjE2x1sFc0uqZ5yYKsPB3NzX
         02eaKB61lyaRzgat7LqlJrvk/5Qa2kyG+5ggy8K/VxzqN0UhHb5auQImRXDhONNmQQ9L
         YZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894115; x=1703498915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo/CHEd7dbzAEsS6JzfIDLPp9KiSxgXCjh4CRPBuAoo=;
        b=ZFucBMRhbn8wO+i+hsJRwayDKA9QCJGdxafeTru2W6yGyiOs4YjgUixze4Ypv2B6r/
         55JPQE2uqEvVXBlasLOJvynNlcsCTSVoJJrCc3qkne+ZF4jZ/espnNZdjZa2wDXW0/f+
         44pWIpoREDewFmbncphpzVbNaK9MrTxpQ28xcRgehbP+ttHWtsYR8qWosZs/elB6lN6w
         9zzBjCeqayxqR3e1RIRVtG6ruDK0OWEX3FiBjJaE38q+V86vaM3x9K6zeXLcE7nd95R4
         RhP+WCuqfhs6lJo4TlQfwCIySYbcJv05VNptui2cxsuJ3Fwpycz0K3MZSqfN/YiCJTmv
         GV/g==
X-Gm-Message-State: AOJu0YyobGd9qILm12vSPutWzIstgW+zU4aPpBNgxpok8bae69lwhVv2
	q5YBWNPr1o0FoTA/Gcgm9T0iKw==
X-Google-Smtp-Source: AGHT+IHvNnO42mHLGvMXQ+SK7wM9O1aTKi43hk6h9sA8X/KxulNmawscwowIEzqbAcBgv3iTqUA57w==
X-Received: by 2002:a05:600c:244:b0:40c:2b4c:623f with SMTP id 4-20020a05600c024400b0040c2b4c623fmr5281222wmj.82.1702894115690;
        Mon, 18 Dec 2023 02:08:35 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:08:35 -0800 (PST)
Message-ID: <b6e0e7b2-4e94-434b-add5-4e05eddeecc4@blackwall.org>
Date: Mon, 18 Dec 2023 12:08:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] rtnetlink: bridge: Use a different policy
 for MDB bulk delete
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> For MDB bulk delete we will need to validate 'MDBA_SET_ENTRY'
> differently compared to regular delete. Specifically, allow the ifindex
> to be zero (in case not filtering on bridge port) and force the address
> to be zero as bulk delete based on address is not supported.
> 
> Do that by introducing a new policy and choosing the correct policy
> based on the presence of the 'NLM_F_BULK' flag in the netlink message
> header. Use nlmsg_parse() for strict validation.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



