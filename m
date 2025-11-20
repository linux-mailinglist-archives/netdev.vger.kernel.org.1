Return-Path: <netdev+bounces-240329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A203C73420
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 311912A161
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD82E719B;
	Thu, 20 Nov 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkocuJ4Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TqMS2NMG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416D23C8C7
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631791; cv=none; b=KJTJIy8iW4E0YkBlbt+hU7eWGbL1A/yWiOAGhO9EQR4O1ureXsrIvdSFeaXilmY20LGO8br7E7KrYDa+ArBtvzbFy3fVkBWlYdRXXOo+fv9TWgowN1N5FhjXn2fnjYUJW0OjxVzv0T4W38v9/I8TxgMooOTuvyWxvImtTOzZgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631791; c=relaxed/simple;
	bh=A5PCemrFCzeN5dykRncX1mML7+uP7qyqc+kB3HxOA28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biQ+p9jbqcz+f9+nE9053YZdLb0pQ7u9p7BiSgpKUyurZ9JGJNXfWSR+xSBT7nfrB2w9QG86Uhu7oWg9iFJN4F1dZ+mfynKS0gIoZsvHeW+/81396ueDDRYWbCQpEX4n7OLxqm27lXP8rswtI2CJ3md9wF7jhWhE4rkssGYOWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkocuJ4Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TqMS2NMG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK7avdh082059
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LkyzTXeZYMSp/bdyDfMh+rWB60QOoYeXnsoTS3SL938=; b=hkocuJ4ZWK85qWo+
	s0wPA0FzDYrKQywcYqNCHNVP3nscP6gVXuSku7GtewMtk+eF7Hc48x6VAdZ1/TXf
	Jx/3kTd8tVU9FPktqjVMpK7NZEuHCmlP2vJXQ6/L8o9neG9ygrST9RAiVRMfTHjP
	Ch+Ru2t/9lfHZ4jJcxUj9Zq9im1rf2LoTUKZbL81T5nPc3DvH/kRR/NZOgfHcM8a
	s7kh3wOUI4TGLJmcmjOVPZ1bHdfuVTK7f/6bWAtwAj+5F5GcK/4wuEBeaJZfwvT1
	nH7TGTXYVoVsglJdF1V8sQXerroM5mKac9lUr9i8o7UUfRMKZx8vuVbaPa0QXYgt
	nFfNXQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahxrn8d2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:43:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed767bf637so862721cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763631787; x=1764236587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkyzTXeZYMSp/bdyDfMh+rWB60QOoYeXnsoTS3SL938=;
        b=TqMS2NMGvUrXzMEkRy9KU4Njg1aKjucaZvJpZ2IHaaCB2emHEZx045bFTzNJfZClH5
         zafToAURhLU4p25NqI4Kbr4SDfcd8vXz2OFAwNSxCSgTTyp57/2T8J7P/Yt6hpA2hfMp
         fVdmBK2tkf6p0S7wep4GGFGhiCntvgxwdcnMslCBrgge1gqQr1CHIx25d9QlH9ZWdNHc
         HhmyFV9kXCBtSN09ibshpKA+RKw9Ek+R13o3zM/53HC3N/77UjjdlGpVaUSU4uwUSket
         gjHEPCFKlgV6o/LEKy78LEabNa8iafL4zJXJ+6MZgW/TUUHjThPyWoKoDGN8M34qkZD5
         4k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763631787; x=1764236587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkyzTXeZYMSp/bdyDfMh+rWB60QOoYeXnsoTS3SL938=;
        b=eqtm7Lrb35I3vtny3RqhU0bbSug8LbE2adxViIiMZLef48lF31nXkYxhYPSr73UW+z
         1lj5rOGUxRJlwXGL0cXmEsKSqfXG3DwCGiPv7//gdnv/8mS4JNNNJd/dhbefZKA7l3km
         z/FizOGgAaccJsJBgPIQsrKRoAeG1AkJpFxtejOEjdX/9apjuNqyaEosvTb4vdanFB/a
         0S/QTZ5zre3jtnX/AmtIqLmLriHBxDaj7N1b/P8PBOEXb1Ua40W9pBYk6Dt91CgpnF3c
         v7JKr1UAVNxns9f70utigzMY1v8G3W4yM6eMpbdqFG25DDaMKJXXJX8WDzWPmprvy5Bg
         57Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV/7aQ5LHUO9UDZJPyB2lQ4PKxWHgOTLJyli5p2OoPQFAZ1+2B2/aCx2X+h+8qbChanDeTP+mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKCevnVR839BeMztlKhY4zDGI9I5yzzqa9/QYr1YGdctr3Zya
	s/F5DVGfYu8E+Ed3YEH67X8hiA3duk9nBKZEuvaJe7kpUP/7T0e04LS6e7XVrStJhPQQ+wApmn1
	J/Tqef8Qk4SOepcEDCTgemUMvOy/jd40WJMXRGZLTH9SK/NAawAWl8HEuhsA=
X-Gm-Gg: ASbGncvQi5uh87QAr9WhwlCpfSREG/71ZczhTl9tbY+U+iYTZmKXgUNrY7RcYLye9vU
	D2+4v9rUY6SfH5yKO4xyXopnfloaSydUDIuOFKy+2RV05vJ/xkeANSq3sUXZ7SJp899rwCQczkC
	Ne57FKhV2RNqFgn+W00zZ/BbMRAPQaEAbs9UhnC+JG6Sj8Ox7P947Dc7S6gQCK9uR+mncZOR+NE
	xZjEhEanJ6FQPbmVEk2SkskLwC5bnCymgWS+w/3MIlKWLgIRcXyckLAVlvr4tzBLHkW/piSJVF9
	gs1pXbv86aZGNPC1G2SP5pgY/KfQuWn8FvIwldVr04JXurqo/1kG4K3UO736TIV6OjthM/VwGqI
	h+GXa3JK5m+oTkkBVu4GbqeSiXyLvNpnjjRat1tvDfxXpcqQEFWbvtJ9dgFermGbU5fI=
X-Received: by 2002:a05:622a:1882:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ee4943ffe2mr24836111cf.2.1763631786962;
        Thu, 20 Nov 2025 01:43:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuygrM15eYuuL+Eseo+gEcRRrz8pankqv3+qIrqVyy6fDxxjo0USx1x43jtWRb6reybm1ooQ==
X-Received: by 2002:a05:622a:1882:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ee4943ffe2mr24835991cf.2.1763631786581;
        Thu, 20 Nov 2025 01:43:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43b1sm163235466b.38.2025.11.20.01.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 01:43:06 -0800 (PST)
Message-ID: <b8e5d6a8-c6bd-49bb-8308-a8b5c390897c@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 10:43:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: qcom-ethqos: use
 read_poll_timeout_atomic()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <aR2rOKopeiNvOO-P@shell.armlinux.org.uk>
 <E1vLgSZ-0000000FMrW-0cEu@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E1vLgSZ-0000000FMrW-0cEu@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AUp_OcuGJDBR_aSFa_rGnDqc0JoOiWT7
X-Proofpoint-GUID: AUp_OcuGJDBR_aSFa_rGnDqc0JoOiWT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA1OCBTYWx0ZWRfX/uK6PeQhKg+N
 pn2bwdwRSHIHS7WDB3h7wbKJUit/iuNIiIF4ClSVEwI5LBdqIxI6B39x8e6u6kHc5kRKRIbeKlZ
 /cNDnyGhJ3+noR7lb77BVaP530pnrR82mcu24Zn+gwJ4GLLpd/nhBSlhxpCFFkBZ+KXuteM1i4Y
 kLknOTsvf/sbQ+vxBqvTdA+fXuiD2RDPK+OlJiVJbFuLxNl1rAdpOFGxAXsH3b6r2P4NVn/SbgO
 2Aun6XJbCYVeXhVyp4X/ysVA86BT6RizfCF8GGO0hdTht7fW8Cy3rXkqD07dVZXUi8uKFDnevu9
 1vXPCK7dfjp+T4/H/aVFdziwpQ4e86jAjX6fZXoKfE5Yu7MJAk6Gz2y4cgUXakqi7osZHvbnySy
 ctiFsColQ/MA3T7CZyu17h2Or25aRw==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=691ee2ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8
 a=OSBbO3HZz-0BpLb1nxYA:9 a=QEXdDO2ut3YA:10 a=THfFRngN91AA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200058

On 11/19/25 12:34 PM, Russell King (Oracle) wrote:
> Use read_poll_timeout_atomic() to poll the rgmii registers rather than
> open-coding the polling.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

