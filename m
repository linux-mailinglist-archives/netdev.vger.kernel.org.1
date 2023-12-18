Return-Path: <netdev+bounces-58511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F61816AF3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F981F213EA
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74F13AF1;
	Mon, 18 Dec 2023 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="iv4RCRoV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0B13FF2
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336417c565eso2555450f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895126; x=1703499926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KPm0OJmVIXFG+d21U5Ot2/HuESUtNJS9snp3+0hCn8=;
        b=iv4RCRoVRw7SRZ/ZYDm2+f2Yqu6wVqS+jTCFWlHWbZkKXwj7vRBjD2113LQqyQKf3r
         BD73OaiA1OPKTn9te2z5n2xaGj40En97A41vA4IHa6eGBk53EMaFDFxjVGKYbianPqum
         A38AADd1F96otzanUbJlRijkvfmr0IXCdD7ObYk1vK/ns2+d7VHI3Ma+C0i2TEvqw8Uh
         LgCug4su2rhu9/agnzaCR+zD0hhlh7Ol4P9Cu7Ya7ypwy6h9KkyuB+Y+DSwzEHu7BF69
         +8CvzK3V6861cTOTbe+kUvzHhYa87YqLXBkmmwMBY58SkgQnzYiJyE+Yx0SphofchfPD
         SjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895126; x=1703499926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KPm0OJmVIXFG+d21U5Ot2/HuESUtNJS9snp3+0hCn8=;
        b=Hs2P8hKJ367M0M0nIGi0RB1Wu91XaDrmuC7QJX1m1SBR35Q/6Q5nWaRzi/B42bpqLP
         psa7FE4n9Jd0W11pECUN082XBOWjzooNRMbrL4wCUBqveM65lQSknZjVAwBfg6PFS7yd
         ZIfvqc/vKTyfqJ6QReFh9KTrumVb706WaRae5WMiB/cYYbudpTP45sb/Rp9yGtzYrz2b
         az71lEDDsaDqod/zPCUiDocOHvnKBle+znP7qfEFMdbP1xBN1Zlo9Mcz144wsEv9J/Ut
         g266v7StVpX/Nnj7miu/8qm62clEX7JuSssYmI6ROzxxU5r3pAhUnMU8VftzCnykZmAk
         uiEw==
X-Gm-Message-State: AOJu0YwpF0+yigpBhi2KwCDaSGhhdYKXRIYG7SWgNHOui7yh1jBRGEkI
	OjBRFZBxl59ZDXyd7QE7Q2FEiA==
X-Google-Smtp-Source: AGHT+IFlQE2Om1rufO3da32bBnZQM2d0oM2pEA0LNHroS62tTs5iEyRAZMUYhyD5SO3L09KiGqgeLg==
X-Received: by 2002:a7b:c8c8:0:b0:40b:5e59:99b7 with SMTP id f8-20020a7bc8c8000000b0040b5e5999b7mr5779742wml.215.1702895125824;
        Mon, 18 Dec 2023 02:25:25 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:25 -0800 (PST)
Message-ID: <50158735-e367-4dee-8515-12886ee810fe@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] selftests: bridge_mdb: Add MDB bulk deletion
 test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the bridge driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../selftests/net/forwarding/bridge_mdb.sh    | 191 +++++++++++++++++-
>   1 file changed, 189 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



