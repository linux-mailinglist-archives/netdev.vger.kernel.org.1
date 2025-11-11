Return-Path: <netdev+bounces-237571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A392C4D49E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E6189F9F4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE240357703;
	Tue, 11 Nov 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZE9KAt0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+UnbB4E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0E3570BF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858483; cv=none; b=kAezOToh93NtEzcXwa4lBpyOECsw+4Pb2Fkbdu38rEqCtDtUm8tYjS0CPtn6kgwLc8a7kH5aPULAH/XgMbV6ONww5Tb75hrFMfIf5m21UiJxkspPwgpUrpDx7yV1hh8bSL7Mm7kkTJayCutmFr9hFszpMr04KTSzdN5QujEOlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858483; c=relaxed/simple;
	bh=uX2FRXbwwZCCv1tYbHwS7dtnDr3CH51sdbhNp9wWUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc4CgINp++1UThzQhgBol6CAM6BZF46VXtsDzmVwwh8MkajhDCC/7yJWRkJdDl9S+5lDsHkJdbgPWT0Bo7Ta3UhCxSuKDPWuhlFSoTLOO+4NcwHL0+DZoCmmErd28kikLg5qUbbWFFk4nPijLofLWBu/PuyGolFrK2kcJEhbdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZE9KAt0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+UnbB4E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7k85k1583025
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bjzJGvDc5zRS1OfTZQSifCpq
	YpVSEVlEOhF0L9KjMqA=; b=VZE9KAt0/uqTpHpUQlsHtUrGzV2Xaiq2acFdXg9B
	0Oldk1XNUX+M1FOafQpV5D6QJ3w7vkE3cuvA4gyK0ZaWgcnfsbRbLDqWuydJgUSD
	TUwTc7wXaXDRna/cAp+lomRL8nBE5FmtQokVflqaVpOufdXbfX3PAdSl1BP+qeQ4
	gInKNEuGfpxRdqveezwIyNsQoWkxys2ksQh2mu0KL8Gc2yIArPBAgMObTxnc8o6H
	CUq29WUP4BccXcwNsc72oo7yfgMws46TrdCv0uPKImHQyhKAEr1EV5Kw8B2uT7Ct
	Kr4hhxoosmF8uKkkZZhjGFGSDyBAEwM7XSB48SLrxiDYDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac11x0j3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:54:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6855557aso16431151cf.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762858479; x=1763463279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjzJGvDc5zRS1OfTZQSifCpqYpVSEVlEOhF0L9KjMqA=;
        b=Q+UnbB4Ewj2XeOZajBcSkjqCzmU4qlhJZkbBDIcJ4bUqtniuBEJ9lOJMnNLIw92FAr
         VtueYJeLxyh+pc8bDLDyaDK+o0dmbDLHAuf5P1ZoPGbJ5jyKGDOK3SD1pBjdwx9WqFk6
         MTFM0K4nuJypr3CwvJkDQYUTCbIEV2OUMu2hP/gqL7Rq6Zhhk9UObdgYVq+HXe3+siNQ
         1cvV0xulJiMPNQ4kX3PfssHujeO0lG+i3DnljgLjF9kqrCEHcLYPSYS3jZnJ67qwip60
         DKz7kMsBU8b2o3/bYcI9RIwR0PLxuTaqJS/8wbbwnjFt0XTabzOhuG21j9I4ph0ew0LZ
         qQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858479; x=1763463279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjzJGvDc5zRS1OfTZQSifCpqYpVSEVlEOhF0L9KjMqA=;
        b=JsAV8Ad4p+WYOT5eZoKH8HFMdq/VYHPbW2prBSYKJ53S8kresY1nQq2GlMLLN/yfwy
         s1XEESVfzOyb/W/pPtVESaJ5BvSCllxDiRKuDIxuTZ0RnkxaEZJwgY0rsN8NypYH1+VS
         aHRKaLabm3iqadODDXwi97Sr/f7SDpEW9DvEfXv0ENDqIGiM/uEWYqMRDhtJ+42jZD//
         0cpxFMg/Io2JlaejRr0+0m3vBl+lzEGonQMByrvFGPG8j1zGINtqoBdiLHh+iginXyaf
         trNrFuEyZ7bQqJVKxaupYkrBVaMuZqfDmSmytvhiEdcf1xI7PwYEi45rfJN8BmadoRpA
         deow==
X-Forwarded-Encrypted: i=1; AJvYcCUkixdoo53yxUdO0plAEkq7N3W+OKXMOP3kCYtt/i0x6jsIu7U2AqSNgQxWujfdpEZO6fPIfwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgopRbIXFm+OUEBtexjR2HPDqWy5FSnb5tGYuM3INJ+V5PzBR6
	+3l1bmmV96yViPczs53owyloczlhqChf/fsATEDD1dWp4CSojjBi7ld8rrQQfqoQg/Iyvpj1Cf5
	MTmBUutDiFpYsvC+MJo3RB8TfYuB2oVIPeJunvDlXxQ3PLgnUXZoMwvJQyrs=
X-Gm-Gg: ASbGncsKo4GZVRaF+bYn8R9xnjn2Kp3mZ2txQrprylswHNuxKD945inbkVwZslg9AUv
	DE7+i+nKLSdewY4TCYfPi2qzxoQ2MULKSHi9pLXJUmruspD7driiB0rzNwJBdgM49rm6lRDNEge
	8fDxkOzOkNkJWVV84Gskrm/WNmqWr1LrvOHWmRHpl4IT76DPg1owKhs3c96rHG+zXWDOT5Z976k
	d9pqEnzJaWlZGwNR8FEn5w93/aekAiSLPRmgRMpj1zhMQn4Ftv0RRaL38knSnQ4CVuwthYU5MsY
	qYVl3PU3kBxg3USrJ2AeEMzzE+jdj6QEAxMngJDwAhsRpfIDlYtB7hXq88DMC/0hVvpGpN7PAWP
	E2yCAQMnii5pVT1CRy02xGZ9zeQO3buyUsvmjOcee0y2KCBMDy65M+Rwq9d7Wm0l/h8y2V2sjlh
	9/8feXzqSRmLa8
X-Received: by 2002:a05:622a:188e:b0:4e6:ded9:6b29 with SMTP id d75a77b69052e-4edcaaa3ea4mr32888441cf.3.1762858479352;
        Tue, 11 Nov 2025 02:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlDf0js8yY75bKRYmabDEAq0elXP2pI/iZd6RI90nqeKsx02RoVZL9jJHhTzE+f6l/HKMiwg==
X-Received: by 2002:a05:622a:188e:b0:4e6:ded9:6b29 with SMTP id d75a77b69052e-4edcaaa3ea4mr32888181cf.3.1762858478897;
        Tue, 11 Nov 2025 02:54:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b74b6sm4784539e87.64.2025.11.11.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:54:38 -0800 (PST)
Date: Tue, 11 Nov 2025 12:54:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] net: mhi: Add MHI IP_SW1, ETH0 and ETH1 interface
Message-ID: <ljrvtl447meb34zfgzef3dw4oqfp6j3ixxwoooewxxvqsi23tz@fbg4zkpctddn>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
 <20251106-vdev_next-20251106_eth-v5-2-bbc0f7ff3a68@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-2-bbc0f7ff3a68@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NSBTYWx0ZWRfXxG6qib3ruNgw
 jIWtmQ88d6m6I9PF5os+BKz4srMLEHPgfJW16Ro4d8N1Hdzrdjf6KGBgG3svW4Wb0dnj1yeHTYs
 NyuEdLRo2qSSc+/naAjxWaJtDlinlMt6tNiNELnjKSKx5p7gKqBMxwLUzyLR4yWkBpQEP5/3joT
 jfiwThUhgYXKXaQnGcMas5Z/ZPvYumfu/zPcn8CNqeSEU0sA42aI0T0OUwi1cV1g2leT761HCRr
 DCheXLQP5i4yqR3fv9/N+gjZ6a8VyrbQCjepjt5rUFdlU7qEYqW9EjP/0IBM4dGnAlFZPWVx4b1
 L311GrUj5IzaS9VWERU/xvExwpEd4vPsyfqM188cVbA0lcTNjaByO2d1BXglkAJxwXn5UZmMwhx
 PtOelJOhWaxVCvT8w/F6EXqoE2pt5g==
X-Proofpoint-ORIG-GUID: tkIWbVgU4exdz5W3zOv0Hlhy6kj3UDxl
X-Authority-Analysis: v=2.4 cv=L94QguT8 c=1 sm=1 tr=0 ts=691315f0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bC9JWDkrhmRD4PJ24AEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: tkIWbVgU4exdz5W3zOv0Hlhy6kj3UDxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110085

On Thu, Nov 06, 2025 at 06:58:09PM +0530, Vivek Pernamitta wrote:
> From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> 
> Add IP_SW1, ETH0 and ETH1 network interfaces are required
> for M-plane, Nefconf and S-plane component.

This is a very useful, totally uncryptic message.

> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
>  drivers/net/mhi_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index aeb2d67aeb238e520dbd2a83b35602a7e5144fa2..7fca7b1ec7b8250fca5b99ba6d1be470fed87995 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -449,6 +449,9 @@ static const struct mhi_device_id mhi_net_id_table[] = {
>  	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
>  	/* Software data PATH (to modem CPU) */
>  	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
> +	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
> +	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
> +	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

