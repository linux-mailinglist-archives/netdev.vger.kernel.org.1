Return-Path: <netdev+bounces-239900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7EC6DB35
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DDC2D2E25F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9394533E37B;
	Wed, 19 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jS1JNsBo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/AcjZx7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527242DE6E6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544101; cv=none; b=I6yYRFjHeoG/xRKBAkqWCAcu0Isx0E5GBm2vd3Eyx9VZjk6T36+6O7nfiM/s7ImC0yDI8nS9akqKN+98IYRgITnz0ImmCssQfCNNletm1quFtYyd2No5SyJNyYQh+aSb6SEQP8higY1MXVA8jq7yMa5iOVwEgriEPXkiItTc0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544101; c=relaxed/simple;
	bh=ZfYhmBz3xGG8TUF+q0CBzEzR+jURigJ0Wq12vttxGXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4V2Ve7JM30chq4eq5QxoQFr+fc88l94XFM+R7z5Bzt9xdIeNKM4zUrEfsBkZoU2hSIAPKG1gFXM6xSGf/9TGc+t7acStMswg3wRfriC9XCinSDSzaZjPmzZ7elO9wAipaFR4KYZinuFcLb0CTmM1iPIaSRGP9H8OPLmFj37s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jS1JNsBo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/AcjZx7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ9JqDX3412690
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MsasINejjR8g08Tdd6hEVHUhnhzo91JEEiJc6r9moRw=; b=jS1JNsBoI95sKzs4
	MqiTEZpwFEAIEUJbcbyRp97rjhf731FPMzj748RnXZfFmAX/bE35dx/tSG4hi4BN
	urT0yhlsAn8LgWFuU6QKTMN6uMPgvJmRUGNI3yflOtM3AgG3lQ+36sWm0QnjWuLH
	ToB/iSKBbhS2jA7NeiqJDSAuRyVqJKF9rrAW1fNs4EKKnutxSM5GUHrI5bmnInDU
	ok0pdU8mJNaCsn+5XzlnrRfF8gwMGu+NwPXMipwrNQcmJS9V2kBAeA4XwdE2fL90
	W2M7wbXU3acHCgEkAq3ZnH08ylfEljdLGu1mR491YAN+pvNsy3XDCOx3fVqWz+CG
	D8Nk0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agv0v2r5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:21:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b196719e0fso218591385a.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763544097; x=1764148897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsasINejjR8g08Tdd6hEVHUhnhzo91JEEiJc6r9moRw=;
        b=W/AcjZx7KQWkfqfR3p9SS/rqwgsML+3/1X4iYI8gFwsMOt1SkYBgCyI2OHw+ALEb0X
         fy83rolEgg9373c5tLIBTZFZrmqJJUQ1WtgoSehghckkkGTFIvMTnkaKPhU5O6Ot6LeW
         S/n8G/BoIl2i6mwZtK8IGpHNY7F6lRfjl12uLpIrqeyhW9wdvaMwpTGc2JA8Uc8DLHXj
         ZvSAgcSGZK75YJklOIwsNsODVnEc3X5cda8YjrMpv4SyGS7xDVf2kPsOD8BoWsCZtM/O
         hVwv0CRG7ECLbpF5678qRU0wAJxWoogmEtcBX/fcHZwQuvRMp6it6qlo3FLVFP80mmYI
         bJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544097; x=1764148897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsasINejjR8g08Tdd6hEVHUhnhzo91JEEiJc6r9moRw=;
        b=E4FAzW0UG+pIvIPrYel+J1S70wcROR68ZpFG/qTl5P3Ng3N75j9dKS48n2YVz22cVE
         /9kQi9Zxtemr1rEr8iLfBPiUqlsHv+7VBd7lWUyUN1jrKnPs8/jHiEFgowEJwHWdIwLQ
         4VlO3eHH5EfCJFu2NMYd8nA2njVt5OrhOtyb6M+QWCkAJExgUw5E9Llx639aJp/rPL0A
         qXZkPHK1XZRM0JlDwvy5CsLKouJf2WNI5e66gtgbSCVRppcKIHSbYtIZ26jewqnPrcED
         SqTjooGcVGbWVlF19U0JmSXsCH2YeMwimqerSFpI/zEdtjRmic40JHNn8McN37rDSH4o
         rNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUbQFq3xwEDBPzERrziN3wYx4g8wOHEVR/KL25j8dClEFc6O56boFupBG0sjpSBK3QupeBLmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WqH+xeJ6rE2dL423dY/Lyp7a3sMrS8txmqzOqzNaC+9jAVMv
	nbuma8gm9glO6q0sjn/xNir6IQx+Wq6zapW7ShxMFkaSP3rWM5vP/ohSKFex3Kx/qIrjIFSVc/e
	7mGo1dFzFNLNc4V5/shCB6JB4V1uhwQ3Ru8+Eri8LTGu5zSb9gpkGYmXyylE=
X-Gm-Gg: ASbGnctsnxfL/CHpyKk6uJhv1dglCh9tXg2nOubxaF8wZigwvlHmKjSyQqg3Y5Rsm/s
	cj49xE8zpVU1cpMbcGutVtq+xbaVTd4w6Q7v+pIQM7H97R+dnmT91QYRG7MqxEsrKBoekekPzTr
	Utx54hlJWiFcTezM++XUt72XuNPzfoxyWAZrxCUKWItjGf7FUgfAa/WR8EQeJs1yx+d17J0W7jO
	Rz1Chn2B9C7TZd3uHcmacHWsNMmYV4i43EqW9WQKBzwr1ohpEbgf+/fVFy25QVV8GNvjUQTLM1s
	aAc+77LI5IfUgpbIf219GpNdpzZlG2DqqwH4D1d7KbcZIkQwaUldgJTtqdumPmg3GOeTLLKuN8X
	HH/EcL8SUGMtBamOuTJMwoeUQ0iYuD8YYynrrDT2kdBa5fPA3OLPR0jnmaheot65VEdY=
X-Received: by 2002:a05:620a:318d:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8b2c3130cc8mr1747634385a.3.1763544097084;
        Wed, 19 Nov 2025 01:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsLJdReja/OXKbrpHJO47YoHvi536cH4Y8e7+wYlA7NU9eLvsGh1wk56IakY9aXYXxXYXOlQ==
X-Received: by 2002:a05:620a:318d:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8b2c3130cc8mr1747631285a.3.1763544096559;
        Wed, 19 Nov 2025 01:21:36 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d7335sm14545720a12.4.2025.11.19.01.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 01:21:36 -0800 (PST)
Message-ID: <8adcb880-a2d3-4987-88c8-c3441963fc53@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 10:21:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bus: mhi: host: pci_generic: Add Foxconn T99W760
 modem
To: Slark Xiao <slark_xiao@163.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251119084537.34303-1-slark_xiao@163.com>
 <aqhkk6sbsuvx5yoy564sd53blbb3fqcrlidrg3zuk3gsw64w24@hsxi4nj4t7vy>
 <7373f6c5.8783.19a9b62ad62.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7373f6c5.8783.19a9b62ad62.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MyBTYWx0ZWRfX2RtuVMUs/OL2
 WM5/6iMSGK7xDkeFwzsGyUXNVApwDkiEeXpLyhYiZ1AofRK+gOu9l34l1sdXh05tHHozVV3VKl7
 sLlpbLERHa3mUn3rIuRrhrddOHfHAalPmOe1qoh8baMOgvklS3kJzRp1gqAREb9020ytQ42SBiv
 JsZhoSzKVM6AzWEEonV27L5LjgB9azBLSdtT3qlZ+GsRXtGTHSz2YT/hSJEN90EAJnv1amW13uD
 aaT1EB8qvCpHMZNrpp8ktTaqCVhqFX+pMjUP2nvJWfdxG6UM6Fh4/aVU9wbzajfvs4o51aAl+IQ
 yUGCeo4zGCeqYXXURaCkeoc/E7mPkL7OoRCC3FGqtRk5rO2tTXr2sTFaX29IU2b4OVTf4viOklt
 5Mq9V3yEcyfmQFv45yAKAy2GiacC/Q==
X-Authority-Analysis: v=2.4 cv=S8XUAYsP c=1 sm=1 tr=0 ts=691d8c21 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Byx-y9mGAAAA:8
 a=G7VRq2ROR16SoJa6LKcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: KhXe82f4CRseP716LQO2Q_d7CpWfSear
X-Proofpoint-GUID: KhXe82f4CRseP716LQO2Q_d7CpWfSear
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190073

On 11/19/25 10:12 AM, Slark Xiao wrote:
> 
> At 2025-11-19 17:05:17, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com> wrote:
>> On Wed, Nov 19, 2025 at 04:45:37PM +0800, Slark Xiao wrote:
>>> T99W760 modem is based on Qualcomm SDX35 chipset.
>>> It use the same channel settings with Foxconn SDX61.
>>> edl file has been committed to linux-firmware.
>>>
>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>>> ---
>>> v2: Add net and MHI maintainer together
>>> ---
>>>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>
>> Note: only 1/2 made it to linux-arm-msm. Is it intentional or was there
>> any kind of an error while sending the patches?
>>
>> -- 
>> With best wishes
>> Dmitry
> Both patches have cc linux-arm-msm@vger.kernel.org.
> And now I can find both patches in:
> patchwork.kernel.org/project/linux-arm-msm/list/

It seems like they're there, but not part of the same thread

Please try using the b4 tool:

https://b4.docs.kernel.org/

which will help avoid such issues

Konrad

