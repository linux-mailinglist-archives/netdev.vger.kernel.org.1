Return-Path: <netdev+bounces-240331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA36C73573
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A93C35B2A7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001B30E83D;
	Thu, 20 Nov 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cw+UqZJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUp0SCjM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDF30F544
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632611; cv=none; b=Qz15ZgntBnREpoouCjUkQ3HLCGbd3bwd1L13bTwd7moNd2ygwW405fzAqbAK0jB9dLgjl47WWbZR3lpooSUdyCx414QuaW01XpwjO0iHzKc2YXWtaVZsPOtReQsHHnmUEqhjxN7RcMY6OHAiDSf7FQylen1+Bpt3/mEmDW3mrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632611; c=relaxed/simple;
	bh=dYQiH+2A/ObcqUe1z38rEra1ddiQe7dNN/KIjKWyewo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjJxenRZ8GrF+lHVSStF/eDDJMt4+eyn5wEgEaTiTN1rJiIBwZFnXaTZdE3pH+a5ND2tVDHJl5KWiDTvvM85GtHK5S+zq7D6ufMvZkDRZ9bJDlqdkB3ZACeI6NIm5Icq+Yuc67r4xPiPrllBgy0NEKil7E30Apc1p132y9qJjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cw+UqZJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUp0SCjM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4pRXB3543749
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRPZWHGBPBxyuY6zaAiDYNG5oa18ExuZZpnv9szRLLQ=; b=Cw+UqZJCNsnBt1Zl
	QNbfmckNYUbx4cRRpsq4ISA6Jt092B1RDHSSgAt8QFsjfV4l3tczXECPsvC/5WPx
	I5xMA3lDThsXBtE3/Wuv6/iIr4DMg7MeVpimQA6/4Iyw7EN5E6AUg7jcIgSa2NvU
	800gpZTPMm6q1jbBCgBXS/y6QJ0H/eZqR9np+teeUY/2K6TG5jJM4Nk2MPZXcG7+
	9xFmPhaovdTH/SBq5K0XGXU1rK2F2Ws8pYfLQRCh4NN2a3/wShfIPTTkRU9WPO7r
	QVt9CuQPvtqcChlcLMW588nrggNNDtqZxnCjsVvaIfd6mFKpTSyGqRe9Rerw7bEO
	hbSsTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahh8t2web-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:56:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee07f794fcso2702801cf.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763632606; x=1764237406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRPZWHGBPBxyuY6zaAiDYNG5oa18ExuZZpnv9szRLLQ=;
        b=BUp0SCjMM4daxqu4qlNVTK17BRuLCQwrZVhmkf2sO3M2WtJTzHXy61+GNRRkEEl4U9
         ZxlgZ4hLTNSfQuFxZ+QRV1lE87HgnHRFBnT+EBCqH2WFqC6PaIfZQrH6y9pDNwZ2t+Yz
         0wMyOcRMdKhiautFBI/jmVeXTKTYiGIKzbZ5I/vJVUfCmnIpPKSvDC7dvCJyWD2QuFh2
         hczjnIlT0Q7kauCuDaPXFNKRQ/Zq8firu1FNfExR2QEwxnLwR5iLK7jd98U9fx645D65
         u5Dhf+MWWKp1E8XMLlKKMkpp0tPZLbvjGECELiTcsPgxZzjaTQaOS5oyXzfPcBJrHw/R
         khbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763632606; x=1764237406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRPZWHGBPBxyuY6zaAiDYNG5oa18ExuZZpnv9szRLLQ=;
        b=GTnPFt9sOk0y+Hb+T3cwISFjM8kXFhdDkSYjOerkFuy9YUpeMBaI/MCSeXAzQOAa+d
         udpO7a24plQHrrLFm6oTdW43nzJKrY6fFc4cS1lsfNvInBaINLHWS/Ojt9RW9sZ9TnZF
         qHhoPLrYbUfkQG6/UkGLukQ1wkTDZyjSjmOjaKXCAwSj6adY0kL4K1WZZkuWebRBpf3i
         snYfzbw0LJmDiurSUShqt+SIPd8It1zwxAoDeas7m+G0l5B9eOkXz8rL635qcM1OKo3K
         EdLaVnWeBvD3J//a+hSVz6jT7m8J3k53HE8erYCln/gT9XN3lTcWR9bvx/RFX7XUMVY/
         43Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVpmjdBpRwybbPsw9r8l8xwKiwHQHHOXt+KdjQ2hA+CWOS5sIMCuhNrc3GqbYwyUCrINYrVBpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUMnu/snTrwVHRdI0zwsy8VFzUQ9bYpBv7ci3hc0gR0JFqVQw
	4YqA2q7CeeyOiQoaznsXE61qbZAQBDnEARkktvZw89cAmoB2MBPg66Cqfdcxyhl6sC4hk3YwoYK
	YZGHnR9is19BkNpRdfXiBAFS1K8KVWqWcgm+aLvQHEXqOM61GAvoKSVDV/utr/4vgVaI=
X-Gm-Gg: ASbGnctkKJVR6y4sf8cpfWgvHY0TQi2hywxKHqFbIwtS2gvqT3DWSLKq8yrj4h+mzxa
	wAu7QivgvzoRhNj4BBUjJ7syJcXytH8edRDhQb8KRViAvGlYopTO/7J3VRnpP7aXlU/btvRFkPb
	ckjm8wv5C77pbvWVXNVmC6q7n2l3/59BJQcoF2Xi0HS3qL/2B8YkyIjBzfkDgYKKj+xDHuS+Mlz
	viv0q3qD6kbXk5XokWhxqiUZzFi6f2N1lL0rdv+vkHrfMsIxR93mN+TS4jTqKYguUNPOjTlk6ck
	sMX4l3dczt3OEs1ftZTb3wVKPFg0yV310kMx/w6EorqvjmNZlIBZgTWVG/pQMINHspBqRB4TdwK
	s8ueE4RA4i2euFBFOnaoKhO78k0k9VlgiRjP2pVPQYMFehsChu3Jqk7Dn2GFzU6NFZSc=
X-Received: by 2002:a05:622a:606:b0:4ee:2bff:2d5b with SMTP id d75a77b69052e-4ee4d3d9577mr9046021cf.5.1763632605803;
        Thu, 20 Nov 2025 01:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvX5tt7Qoa7/1Nd3zshKb3HAhHIfws6mxUCD1woH2NH2kWlspMcanmSVKJFvTHbTJGYjt4Sg==
X-Received: by 2002:a05:622a:606:b0:4ee:2bff:2d5b with SMTP id d75a77b69052e-4ee4d3d9577mr9045891cf.5.1763632605320;
        Thu, 20 Nov 2025 01:56:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d50328sm174027666b.20.2025.11.20.01.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 01:56:44 -0800 (PST)
Message-ID: <e099d1d4-7e8e-4212-a324-5e790ba7559a@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 10:56:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: qcom-ethqos: add rgmii
 set/clear functions
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <aR2rOKopeiNvOO-P@shell.armlinux.org.uk>
 <E1vLgSU-0000000FMrL-0EZT@rmk-PC.armlinux.org.uk>
 <b720570b-6576-41d7-a803-3d5524b685e4@oss.qualcomm.com>
 <aR7jZ4KkKE9nTsMh@shell.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aR7jZ4KkKE9nTsMh@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F59at6hN c=1 sm=1 tr=0 ts=691ee5df cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=ZmNGhu4S8FOEUr0570YA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-GUID: A6KedcLfK2oih_o8Lj-loErnn0pjyM_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA2MCBTYWx0ZWRfX+w03IfSaY2d3
 M2A/jsnlu2+A54Yrk7QYX74EFH62nrjIPkAjYKRbHAyOQF9Rp7bucIAOeXrJRb40xzJIqPn/VGr
 dr9BVRAwJCNOkzX7vRRD6lw+r8IGALMgTtxx4872l3LAz51udff8FSbRhn3CMOLb9aRM2yfXNnf
 9yq1JXWjA95hbeizvyl+4P1KUOy+A/vQeLGihrfYn1P+K+oUTXe8bEGIMXfmsF1kT6xww7jpApd
 6e5AjKF/gzJI4s1uVc//0hs+Pwrw5r7McyXPMcLbhJP8M+OvODpDquhBK+EU660CJFxdGe1mdgQ
 faY1vSAmBlfmrEFevkneC6bLEGC57jVgPJBx0cL0Ccf6wU3Vh6dtQH+agFckyYvFj6FWv8YsIrh
 nYAUjkyNZXXaxq4SuEHca/tSMvaxjA==
X-Proofpoint-ORIG-GUID: A6KedcLfK2oih_o8Lj-loErnn0pjyM_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200060

On 11/20/25 10:46 AM, Russell King (Oracle) wrote:
> On Thu, Nov 20, 2025 at 10:42:04AM +0100, Konrad Dybcio wrote:
>> On 11/19/25 12:34 PM, Russell King (Oracle) wrote:
>>> The driver has a lot of bit manipulation of the RGMII registers. Add
>>> a pair of helpers to set bits and clear bits, converting the various
>>> calls to rgmii_updatel() as appropriate.
>>>
>>> Most of the change was done via this sed script:
>>>
>>> /rgmii_updatel/ {
>>> 	N
>>> 	/,$/N
>>> 	/mask, / ! {
>>> 		s|rgmii_updatel\(([^,]*,\s+([^,]*),\s+)\2,\s+|rgmii_setmask(\1|
>>> 		s|rgmii_updatel\(([^,]*,\s+([^,]*),\s+)0,\s+|rgmii_clrmask(\1|
>>> 		s|^\s+$||
>>> 	}
>>> }
>>>
>>> and then formatting tweaked where necessary.
>>>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> ---
>>>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 187 +++++++++---------
>>>  1 file changed, 89 insertions(+), 98 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>> index ae3cf163005b..cdaf02471d3a 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>> @@ -137,6 +137,18 @@ static void rgmii_updatel(struct qcom_ethqos *ethqos, u32 mask, u32 val,
>>>  	rgmii_writel(ethqos, temp, offset);
>>>  }
>>>  
>>> +static void rgmii_setmask(struct qcom_ethqos *ethqos, u32 mask,
>>> +			  unsigned int offset)
>>> +{
>>> +	rgmii_updatel(ethqos, mask, mask, offset);
>>> +}
>>
>> It's almost unbelieveable there's no set/clr/rmw generics for
>> readl and friends
> 
> Consider what that would mean - such operations can not be atomic, but
> users would likely not realise, which means we get a load of new
> potential bugs. Not having these means that driver authors get to
> code this up, and because they realise they have to do separate read
> and write operations, it's more obvious that there may be races.

Right, I don't think that would show up a lot in practice, but the 1
case it did would be exhaustively painful to debug

Konrad

