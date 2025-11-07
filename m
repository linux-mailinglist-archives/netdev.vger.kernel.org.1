Return-Path: <netdev+bounces-236892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9EC4192A
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071E03AFC94
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CA2D3EDC;
	Fri,  7 Nov 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBMC4zbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJxUZbi4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADF18E1F
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546811; cv=none; b=t3Ebcx7d0AItCJd6zEnKYIi73udg4yauJrOnmEbpB7kAaDyKpnalWU/9QQ0qKi52qZvpPtmXF9PQjYBw/Mi4aQkkxxnstJ6o2e497PZfZxW+GEbRCBDPmtYfl5ffZLJtARXmX1VxMZLvD7BoBBJa4BK8uxMRQeZcmKrnkNh8T9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546811; c=relaxed/simple;
	bh=mwg5t2qFuKb3CBJdAVY62UXJrqH3P6gsN7NgMRAFKBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPwQ9hPVH6aPY51l5vHzTzYNfU4bz4FXUZocsMNarNa4Bm9K6eOIRaozOrGPNGaiwgXRW8ea7TCeE2AG1f4naWN2QfnSEOJ/aVmeAQi4qyFfYOk8F8fS7nlyvh8pIuvu7p3WEFIAmJolchbUFL8eKnT3DOx4EFFYGnmC/TEAVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBMC4zbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJxUZbi4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7DSIu53291959
	for <netdev@vger.kernel.org>; Fri, 7 Nov 2025 20:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nRbsNOo6UJxtICpkZwkcsd0QvQyPYGLyJjw+iQFDDn8=; b=cBMC4zbrMT0si0ET
	yOXMUgL84VbkcX2xEYJ4v9v6sezYn+KehDPExpU9xBIIw1Mh0kzfi/67TWs8yylt
	GZBLInXuBeJPed5lUsMhy0SmMSrCN+m/5zWwC6FqYLAoZHw696P0TA0NzLxaBsKb
	xttqbTWQYdjOcKb9CJSxPbymaB+PV6pQc5jj9pFdoac1UHeWPEhfu/5Ec+Yfk20c
	VsJZgYXCCWN1WUlJ81Zprohqolu3IzeqBIgOY1pjXCjikT05z6UIpQUYGs/dj57+
	fTjfpZmLh0LbV2FK5EfPrX6yR143wGrYDHzVHXLDo3EBOZNF9GWJd6YWT3UMRT32
	NpKtTw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9hpbh4j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 20:20:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956cdcdc17so11760845ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 12:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762546807; x=1763151607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRbsNOo6UJxtICpkZwkcsd0QvQyPYGLyJjw+iQFDDn8=;
        b=WJxUZbi4sZwA6uQlJOq2RN4YRHvcOL4xqRuyaf4w6nkzC7NqttlqX7Ex0QX28RiBmK
         7eqMsUM3VfEh8Z5+3jc9RiLF4XZ1SQibqhPtSY2RgzdvDflYtBBvqgbtuevHyfCJjK7H
         r79RcHH20i4uc+k5L4R9GL95tl/VDVjXt9T5ANU0TaTsziE4I7dr8AGVOz6I7MzgHzJA
         iYViYJQmgH/YVi/df4+hnOPoNGR9OEnUq2WJr3wiRB/BWhaYz1IlVDi2MBjW3Mn6wnMD
         UDwxci6OF9Ac5IbEpj2kMGklmgIhPjYRfAIr/2ckhbL0rAH8NdaMU9O5bXlALnrS+9N6
         WOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546807; x=1763151607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRbsNOo6UJxtICpkZwkcsd0QvQyPYGLyJjw+iQFDDn8=;
        b=FqJ4qPz2A8TyxxKAScM6JEyRwi2x4xUHQ3cZVLDLdiCGcgGR3BjK5KO+a6otJuCcSw
         dvx3lM5VN/Pp9V3MqyJ9iwNrFLsdq1bveeV/FCl19hXXkisVUwzSo0vph4eA+e1yTmMJ
         giPEno4pFdLKUR3vYkOlQ21daMqjiEebmP2wHeqsnvphm/bDIbpmL6wZg7n4X07iKXv6
         qtQnWFc9r9Sr5SyajYSf1wxKLOqJAPw5Xz6HSUECu5EVl9WfPzt0WTePEoIrEhjOOEWf
         SCGiidJ5/qsMn3Y397LvzAKoJZWHSjUIIwU2KA3kma2tDR4692i4KDh1f9VLlh7liCO+
         K/1A==
X-Forwarded-Encrypted: i=1; AJvYcCUskVEoHeMVpec0Dv/4bMHMZb7M+MvpfjRfqrkO5PAvdzwDJ/rCNecfjCYuiWg9zuxVaYcXVmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJm+UWPLfGC9kclGJuPltVwk5yvx2PYezYcyfow2C9Ga0Tqdo8
	PSuymjdb4HymEGL/en11+oErdy2zWbhhbpSRkCB1p+Yp0YM/cF3ICnWNucecflZnK9mHV8McMv+
	jlR2WHmttRLRaEHsRVqjscbXUw1FVnACc1dpBTi0HNmw7dtpF6FSoVPc2yok=
X-Gm-Gg: ASbGnctppPIFT8xKW8Ehi9l7xnkNTzKw4sfAV1M/D/gr/c4rU2rWGKMSPXBd2mb6EUy
	Puj9YZ7SSKwoNY7X0J9jx+0B13cPPlvsRjIzIbqv4dzv7G5Wi3B/J1frAXd1JxFd2xEpsq3FYeP
	BvsfswP3zhPO3BI7xe592XKquoCxxy0ON3My8zqV6FCa+UJZ4Tf0uUP9Ymv5tbojAOOAwdGt89u
	kdFmljMa155MRZJ6js4eoNZdyin2bVp/5DMH2oPuNdSjSWnGC1xqVGMsscalzyK/Cz769zgxv0p
	kyZYzwfiSVSI7O4gmfP0/H3erV33mWsWaVAxAuubnshCk8LlXdixiVs3NE2CE9W86iPDycawwki
	5OLXh7oKWyMn4XWsBhlQxGvTYpRP+9ODfR8CLVemdac8Z8tHu23Xn+ADWq06ciA==
X-Received: by 2002:a17:902:fc4f:b0:295:595c:d002 with SMTP id d9443c01a7336-297e5643d62mr4435205ad.15.1762546807187;
        Fri, 07 Nov 2025 12:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjlIBWO8KYF6P/PNB+fj/0Z6Jmz8mLVHUG89yR435QivYEb+MO8cT71+Q6lnS/aYFc+tGslw==
X-Received: by 2002:a17:902:fc4f:b0:295:595c:d002 with SMTP id d9443c01a7336-297e5643d62mr4434865ad.15.1762546806655;
        Fri, 07 Nov 2025 12:20:06 -0800 (PST)
Received: from [10.226.49.150] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c701e9sm68086695ad.52.2025.11.07.12.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 12:20:06 -0800 (PST)
Message-ID: <7820644f-078a-4578-a444-5cc4b6844489@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 13:20:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Introduce DRM_RAS using generic netlink for RAS
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lukas Wunner <lukas@wunner.de>, Dave Airlie <airlied@gmail.com>,
        Simona Vetter <simona.vetter@ffwll.ch>,
        Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
References: <20250929214415.326414-4-rodrigo.vivi@intel.com>
 <c8caad3b-d7b9-4e0c-8d90-5b2bc576cabf@oss.qualcomm.com>
 <aQylrqUCRkkUYzQl@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <aQylrqUCRkkUYzQl@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDE2NyBTYWx0ZWRfX929tG+gG0VNY
 eeg1bUrmAgh9VxaUq0SsPZf2cw9EaWovgOoRJeq4SyMgHSJ2sPWSLZFHok6pTRo10wquZVP7kfx
 TCDBcUSyRc89PgfYQJUAivn/ZOYW0ltCIrvZMm2FyW+bA8wOOb4zC28nVplF+tng0+sXjwwp+Oq
 x6Zd77HSFu16KRxzgdMKyyYWC/YxibzBQat1SPaBOdtGZ18wz6XLAJTiRtkna322S9o1X4TZGqq
 DMNedMohu0AIrJ7U9NkXp1xzzGWho3RGJY5qciyzUihhqCGLBYTTiVJzhsuJOCRlArYTRlRkPKt
 gpfc840iV2Q7fi/ETwzG7D+ybZD4UUBBoobEfwUaPHG1NmGk/bAdNLJue56hJ/JTPShEd6lFbbT
 w11i3w+scLAoO2fK0wrIPOnlJUhC5A==
X-Proofpoint-GUID: i2pVgDByM9rBF-9IHtAhoo4dETY2h1Qk
X-Proofpoint-ORIG-GUID: i2pVgDByM9rBF-9IHtAhoo4dETY2h1Qk
X-Authority-Analysis: v=2.4 cv=GZcaXAXL c=1 sm=1 tr=0 ts=690e5478 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PTgRNUtVYmAdSUgUj-UA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070167



On 11/6/2025 6:42 AM, Rodrigo Vivi wrote:
>>
>>> Also, it is worth to mention that we have a in-tree pyynl/cli.py tool that entirely
>>> exercises this new API, hence I hope this can be the reference code for the uAPI
>>> usage, while we continue with the plan of introducing IGT tests and tools for this
>>> and adjusting the internal vendor tools to open with open source developments and
>>> changing them to support these flows.
>>
>> I think it would be nice to see some accompanying userspace code that makes
>> use of this implementation to have as a reference if at all possible.
> 
> We have some folks working on the userspace tools, but I just realized that
> perhaps we don't even need that and we could perhaps only using the
> kernel-tools/ynl as official drm-ras consumer?
> 
> $ sudo ynl --family drm_ras --dump list-nodes
> [{'device-name': '00:02.0',
>    'node-id': 0,
>    'node-name': 'non-fatal',
>    'node-type': 'error-counter'},
>   {'device-name': '00:02.0',
>    'node-id': 1,
>    'node-name': 'correctable',
>   'node-type': 'error-counter'}]
> 
> thoughts?
> 

I think this is probably ok for demonstrating this patch's 
functionality, but some userspace code would be helpful as a reference 
for applications that might want to integrate this directly instead of 
relying on CLI tools.

>>
>> As a side note, I will be on vacation for a couple of weeks as of this
>> weekend and my response time will be affected.
> 
> Thank you,
> Please let me know if you have further thoughts here, or if you see any blocker
> or an ack to move forward with this path.
> 
> Thanks,
> Rodrigo.
> 

No further thoughts on the patch contents, I think it looks good. I see 
that Jakub posted some TODOs while I was away, so I assume there will be 
another iteration that I will take a look at if/when that comes in.

>>
>> Thanks,
>>
>> Zack

