Return-Path: <netdev+bounces-239889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E06C6D93F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3C27E2BDCA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2823334695;
	Wed, 19 Nov 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9bwyRrI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TyLuLXFN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EF334686
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543124; cv=none; b=f8ugyG65hblNbloyowFU3T0CBVouEbxZnQQOWqr6GJGpwVuyW8+J0Q3Mh4roBiwX27J+P6eaX1XP72+fwf3cpkG6LApC7JU9fIfJjK1uN332n7amxmQ6ZKgZLZHBnEFhjKe/ZvBJV2ctuJjVaKVwf8UFEP1ul/ZwmNdQI3g7tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543124; c=relaxed/simple;
	bh=ezXtnxmmy4nKLRLUirnPsKAzx/wRLwitVXJfmH83Lpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epejNNPjpVPoeOYt8+L+DM+1riOpPJOi1nD2haN3B9ru0ahALmzdPCylHlNt3gQggeK7QgTKwZzjMGeaXxpx0TbEFVK39cCgRbSb0FpVvpf3dGIYAvVKpEqIUTHeLIraXBWRPDEbyzr/ISvcvyJRpam2dm6ERsYFMFf2v5mCk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9bwyRrI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TyLuLXFN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ4pCbH2926869
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oBAgJBWC5PELt9dF08F2H0pq
	iR9jG9unSRTCNbWqiMQ=; b=A9bwyRrIZe3RrEjd8qyp+x1YZQWMnIYRRv8haD/p
	laQQTqRN7yWDRWLLpw05m5f0N3B6is1xlVs7ivtt/sdpXDHNE9G/eHH4OSwiZ3BL
	ID8Xz/hMfJjSjbxBJwMZS+8tagDEgp/AhrIpz9y+93eSGqGIGuSGiUhwt0/78c6e
	Udor9GbxW9j6l8D9pY2JymUNyHLVVDll1JLL59tcHTaVnkBEZu+h7EYMd+zYzCz3
	I6cHXf4e/VFTLEYDRc3YSST8JpCC84Wlvs0VsB3brC4+HhEEBjVjsfqgPjtYdPJx
	/x/NXKgPAvgt3jaRNjQmdGurXxSmQ7HJJ0zCuLzFlmbUfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agq293kqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:05:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89ee646359cso2068693785a.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763543122; x=1764147922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBAgJBWC5PELt9dF08F2H0pqiR9jG9unSRTCNbWqiMQ=;
        b=TyLuLXFNuriy/6zQR1EskTHJ9Hy/oRQPE16jTYRkzHg7GDFZGwFFTUwqCqRlKBNpNH
         dUS4+d3YCUujw6tHr7QiUz8RK3a5KqHyCLHOLyKFy/FiLR+s94nEMpwXD+Iiz0RQroe6
         fsIJrFGHz7d6wD08yBLED9owUlgu4O+RxI4IbrDx431MWeJnWiZEfCEnjYgQ2bKIbywJ
         OQjg3axV4RwgDh9PrvedDe5pDVKzrJhyUtrYu/ESRITHpyLgQ0+An+ACCLL0tqZQ3ypI
         lVoI3lTy422moIDiF9qJ1ltkGs8xzYtYMwsNguzDmhq8rLLRKEWMdUvpUA2vCYTPW/uo
         pV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543122; x=1764147922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBAgJBWC5PELt9dF08F2H0pqiR9jG9unSRTCNbWqiMQ=;
        b=K0SaMDnmoWFqMmjukjGcsxlexXZhFDki8BzZf0Z522cm+ZC2GKDdR+Q+zoS45zdX9s
         pSkchMo/Hj9Sje8fWIbAjuqZjNjJN5O03EnneXG6VGsL/5bclIjpzprGePFhhAmeOFMq
         yeo75KCjlneTGiRbrXR/A6wsnBnce8XtGECSQr5FlNPF0GBvXzZ/4hBwbE5igS2QjWLj
         EN5iKYjEo74v3Ve7X2erEioACSf1L0wyYPHaqIwqqhK8Vbw8/DQfF/sMHtPnSqJ3rWU7
         qs/NA/3CgFbpPPNwJQ1VPglnXQxx2vCZqyEVSkSka1ADUQhm0B6ASqTBcVax0eVzebr2
         mTAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJhJllPGqAsbSN4zKDgG09zygSDYHI6zLvooa2FRyd27zeZZkRYHaF0pyxPJSTI8UowXFBbkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFAmiOpbKlqP4XDfjiqhEOkgt5PXbm1Kuu1SU4HpF/Q2JEe6u
	/o6XaAwCMuM/lo3mXGhEXJtNOIi+LQoIFGSINg6o3xCefkiJ6+hm9To1hcXTGpfPRFiMAwH50zt
	4plY0OKUzgl7GBJaheD3/2ZmITvwdd7F1eP9l6ewH4T3KXQOsPHyCN/iQo04=
X-Gm-Gg: ASbGncv4XVmYIsKwvVG+WGSB3axisXzB96XvTzFL0Ih5Sl355poX0FgBX3dhKNMFO4f
	3VaxnJUlTgRq+JEcAe5yOKUbAlyJayRarV3813/XYcJh4MJ2aiJfavALkhbdyiFIMA76Jmf3+th
	oRyuCk0wq0ZcI46Y/4EdIEl/Fw7CfoUvrGhHfGZz0czYOqVXMQ5q/RNTbaRRwbftfY+G9bZN1c8
	ycBnaV5FAyRbKx2UWejGLadmkGG4ZiVdAA5+wc6YZOdstYlDOnlNhkV0s+q/DC8420T6VW2dotk
	mIHFvAfpWy3sDzneHomXDD0Mh4SbQYKlHm1BHkEH5afUk74ZFVKaSCCAJj04P8CDEtOJc0V/kFL
	JK+pPtoZ8uFez4ssDR59Llv+3tby3FwDUdj6QTTBvgjyvbMOUQPyTb/b3OkZ/Sa98240qkVViii
	2LnkESeygefHFDZXCGsxPKg8w=
X-Received: by 2002:a05:620a:5ec6:b0:8b2:d26f:14a8 with SMTP id af79cd13be357-8b2d26f15fcmr1482717585a.9.1763543121631;
        Wed, 19 Nov 2025 01:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl0tVP0nruUET6azg14pcDZMW+9RwVCKQSB0MA+hirvaAaTc5VWCKGXZJPH/eYVd8nYtboXQ==
X-Received: by 2002:a05:620a:5ec6:b0:8b2:d26f:14a8 with SMTP id af79cd13be357-8b2d26f15fcmr1482715585a.9.1763543121100;
        Wed, 19 Nov 2025 01:05:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce25408sm39192991fa.20.2025.11.19.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:05:20 -0800 (PST)
Date: Wed, 19 Nov 2025 11:05:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: mhi: host: pci_generic: Add Foxconn T99W760
 modem
Message-ID: <aqhkk6sbsuvx5yoy564sd53blbb3fqcrlidrg3zuk3gsw64w24@hsxi4nj4t7vy>
References: <20251119084537.34303-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119084537.34303-1-slark_xiao@163.com>
X-Authority-Analysis: v=2.4 cv=FJgWBuos c=1 sm=1 tr=0 ts=691d8852 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Byx-y9mGAAAA:8 a=Zbds-apdPVEvrNjdMCwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: bu3uv8QBt5oFZEBjmDZNygLjNZZ2Bvsz
X-Proofpoint-GUID: bu3uv8QBt5oFZEBjmDZNygLjNZZ2Bvsz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MSBTYWx0ZWRfX1zRg/egc1KMi
 SrBY56M7ID2unNRYuMbtKqkBk/iRVR8z2DAzmydtdSvn37dYNIY05KAzpuZTSS05/cWQgO9nal+
 ghQXnYYhWVSOwGiveP/mMRHYz9FCGZotXoMbOAzwv9v+MSYjvyPVTpgPigFYnY/qI4C8ofd/nkO
 m7iaoehK7TLlJWHr4pYpYXsRtux/MjghhtcHodfzI1ZsDbBjK+JGLUJMkGpY+J+fAwIz5IU9Bkm
 HgecNndjSNWU4dpUIhv9TVq3ac7FXRS9qDjGzr2baJ6I/SiTIm+79MvjYiyaiyxB0vdGK09ZogW
 4+OMSAreGkGR44gYxZQe9G9qpFyL4vnr80peX7TypHJ7E1cOzy9uAkIk7dUj0JXvyC5UJvFJsZF
 cpFtLWO+INJoWyodcQHmvarMVF3P4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190071

On Wed, Nov 19, 2025 at 04:45:37PM +0800, Slark Xiao wrote:
> T99W760 modem is based on Qualcomm SDX35 chipset.
> It use the same channel settings with Foxconn SDX61.
> edl file has been committed to linux-firmware.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add net and MHI maintainer together
> ---
>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Note: only 1/2 made it to linux-arm-msm. Is it intentional or was there
any kind of an error while sending the patches?

-- 
With best wishes
Dmitry

