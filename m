Return-Path: <netdev+bounces-240328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B08C73477
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ED504ED4C6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988B304BD7;
	Thu, 20 Nov 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euxlg/KQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zw9fGu7l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C452FF156
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631731; cv=none; b=suGvDhDyr6qPi4Nxy7wXmkPq3tXmk+QWUZjtLP5ucucCiGueBjsAxPPeidYabonVS7Gmm1Px1KvUBK1ltyysL4bhpXqev9ENgBQ3JQLYHgRt2LXJW8f5jIDzaTWiQqgYOkuekJOnnG6x2Ape8tDCoa5jGuhFtbxdWlUa1pEKGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631731; c=relaxed/simple;
	bh=AAu1QF1nVEbCR8m664mmiKLqlR5foj412zlA2cpkct4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqHhiu/Q8splCHh0OlOuK4Y2K5sPnGrGibfHOFpYWDhgI6nInQeRrPmTLI4eYTHbBokSpyvrLQLlDs7VD5QPFjHle+EU/YgVVgBgPjYQPzfH3VxLXN7CkZAjJHlIOhEb2yv2/PYyGHuuwF6dQv3xEIYbZgb6X9rNQMeJS55FZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euxlg/KQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zw9fGu7l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4psiE4185005
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmvv4U22KcCKpsAjuusmY8TxLc3LF2rVDF+VedfD13g=; b=euxlg/KQV7qwq9ao
	hSnEp1QgwUXITPyg4MV40UIz1442kR/jN10jYxQlIAbG/8ewSI5izgQqwdPFYTMw
	dwPyU//tMYJRXcf26OWNpgh/lbTOZ52VrdUQWgPxpARTjQp5FLuKhVvIqFPKGOxb
	S0nXUH97NgT4uVKHd/vSe09zXJ6ffH2u1nfSpfKB11aWmDj1NIqFSc+GPmgW/HW2
	pbkcPucEF8+ojJPa8gwfugB01iEPEQxYh3WJi6m9EdfTfjKFA3ceFsEeoywFxCZK
	cnUiRpPOjRO0cJa4TnxXSpmtwAzINhzRWBquXcgryKfENqOmcRwNxKjEbSgrkpB1
	E4watA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahbt6uu61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:42:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edace8bc76so2030331cf.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763631728; x=1764236528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmvv4U22KcCKpsAjuusmY8TxLc3LF2rVDF+VedfD13g=;
        b=Zw9fGu7lg2RNUYAhgdMkDkdCfAfFpLgZIZimYVtklRtihhq8rZeLjRIvv14qOYkR36
         n5R6n29kjUB/SWPvuh7/NsmsWDZ59sOKLG1wm1cGs5Y/27zMfiGGg1WNK8HE+chzAZt7
         vh96UXk/ZacHU/9EK5AOCERd+rfMLRet8Ru7g1u7GxzCXkQJava0dMLqbm59kwpDbWWB
         QVZOzoTeE/YD1Di1v6/Yhjf1iYQacIuqVZK5/og1+A3Sg3GZppXn1cRVIS6kxDMXtBqD
         ZHqiT3EzF0NQpXZb4bw6KwZVKnHm64gUiA2dJkP/c93x4qK2/Ou4PVc9QWcLeYB1yCpV
         U4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763631728; x=1764236528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmvv4U22KcCKpsAjuusmY8TxLc3LF2rVDF+VedfD13g=;
        b=GUtN634TVcZ2mqTf+jwF23Ly9iFLdoBrp+uDQrrXxmWFBV8L8ZCj2cpeBw1j9tNsz/
         k1Y+tTYHUDg3g7Li/6+EZ4uhZv3bw6xE4rzeU0io+Zfgv2/2IXZhY/EJ1lU8cAH8TVRX
         sVuU+pyqwxwznZ7i+qEW4hWfXKCp+deSLQAxoi8shbHoL9hJHzx4rF9Nmy0X9wWyLg7I
         C+qwql2ibm7GWBtRnA+9d9jeCAmz4MX598K83yb0z2jpYbAkvxIBB/9OZayR8nR3+8CM
         Epgge7+GAu5Dzfmeq8par9dzkhegRNU+CJ0JBroaIifYfhZtFSRbI/0YbWpO6dxhLMkh
         fiiw==
X-Forwarded-Encrypted: i=1; AJvYcCW4bSKtbkSqup2lsDxQxLp3oUU9MqMMe3V1n+iVxj1AduPA/4GTfszRYfe8AFDDKmpCf2+oS9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuolv/xZMDw8O4DISsxMyC5130ge9gzLtv692cZYKkkdgUEGR
	lTWl+GwA8eZDAw7s00zh/Zn3b5cT1FHHGJJEn/7hAQ+dK4zVbSN4PIA24PCnosU7veTa+sAstgz
	sSvmFMILRgIwGQydsfI5FQnyvHrU36n9hop1lYE1i6vTAT5NvgQ2mG8zBFTU=
X-Gm-Gg: ASbGnctiy20KGDqDl/2V3ozsHwKO36eKKx6PxEPpqsmO/4spPCxWxMR3oOuIX1GsQIx
	8p/YK9MVM3KpZQ/ZZWS+Jjs1RqhOy+LqwUCTa5mxUvXl9p5slzBKqnlzw/oVIuP9ncaNXkbzjAv
	qOXdRYnubWq8fn2MTbHHU8CMv7S7YQEICZnwMPJr5+EQvYR4HmSbudCzzjmUJjCYSMT/H9HpIpq
	JrDEJj0Azm6t8Weoi80Em+2s75tX6voAIN6xN1ivip9ZCqA8FadVvrn9sDPcRVq+Jvhgh8qwU3T
	IeMzynZ0Tt7zIcOyiU2ACx85uGg5TtzTPTNTp/u+ASX4KTt5yu6hy0vWIv7jek5XOPxH2Ub1mlf
	cc07ojV2ILTkyyMMfJL2pBgFWk/QqfIOtWTq5M9InwgXicJyi4HkB4Kn9f/PT03GN5H8=
X-Received: by 2002:ac8:5809:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ee4946ddb9mr23360501cf.4.1763631728242;
        Thu, 20 Nov 2025 01:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoV+9O4ZHEVJcW6VptazFPrTitDoxk6d6Ewz7I+wTr7KAcVQVGIDHM/4EdK+mcnY60jQIeJw==
X-Received: by 2002:ac8:5809:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ee4946ddb9mr23360231cf.4.1763631727776;
        Thu, 20 Nov 2025 01:42:07 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f59sm162407366b.36.2025.11.20.01.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 01:42:07 -0800 (PST)
Message-ID: <b720570b-6576-41d7-a803-3d5524b685e4@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 10:42:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: qcom-ethqos: add rgmii
 set/clear functions
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
 <E1vLgSU-0000000FMrL-0EZT@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E1vLgSU-0000000FMrL-0EZT@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qShoxyKdJEfNweYHowfSsRWnNK5C-BA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA1OCBTYWx0ZWRfX5T0TlYNuGGdY
 Foh4sXaN7VVA8wpe2mzJkF6NDuXbMaPf7AeD8m/+HVau6SJaijYb2Y3mKlK500zU/bHvPExPsvd
 ircYtQClWi3VdDLZHPgDppE+kTknKZNecNod9GYNsPTO8IEqhRHk5vmpngBTod7IbzwlWfUnvqu
 bYjsR4Zl6ONxATbNdJnKlTi9TitReYFzWQa6PJJgTmYbsINeUhllaQt4/72YBcxLxFA14A+teTQ
 RD1ZZgc192UTZmcWgbBYkD/ZLQ3U/EuNPj0k0sETGn+FlKSRtD9ktaV+zA3ijOPg84R5Ke6SnVC
 RD1hOXghp6r7jHMl2oVfluhox6wW2Hv0tKt5gsezfHjbE24yv/U0pgmfU8airv3VpgQETlZ9IRN
 FMjGATm+A2C5F2NxOOoribdtf2cY0Q==
X-Proofpoint-ORIG-GUID: qShoxyKdJEfNweYHowfSsRWnNK5C-BA1
X-Authority-Analysis: v=2.4 cv=PJICOPqC c=1 sm=1 tr=0 ts=691ee270 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=EA-HfeqjSxqo7_82F5IA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200058

On 11/19/25 12:34 PM, Russell King (Oracle) wrote:
> The driver has a lot of bit manipulation of the RGMII registers. Add
> a pair of helpers to set bits and clear bits, converting the various
> calls to rgmii_updatel() as appropriate.
> 
> Most of the change was done via this sed script:
> 
> /rgmii_updatel/ {
> 	N
> 	/,$/N
> 	/mask, / ! {
> 		s|rgmii_updatel\(([^,]*,\s+([^,]*),\s+)\2,\s+|rgmii_setmask(\1|
> 		s|rgmii_updatel\(([^,]*,\s+([^,]*),\s+)0,\s+|rgmii_clrmask(\1|
> 		s|^\s+$||
> 	}
> }
> 
> and then formatting tweaked where necessary.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 187 +++++++++---------
>  1 file changed, 89 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ae3cf163005b..cdaf02471d3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -137,6 +137,18 @@ static void rgmii_updatel(struct qcom_ethqos *ethqos, u32 mask, u32 val,
>  	rgmii_writel(ethqos, temp, offset);
>  }
>  
> +static void rgmii_setmask(struct qcom_ethqos *ethqos, u32 mask,
> +			  unsigned int offset)
> +{
> +	rgmii_updatel(ethqos, mask, mask, offset);
> +}

It's almost unbelieveable there's no set/clr/rmw generics for
readl and friends

[...]
>  	/* Set DLL_EN */
> -	rgmii_updatel(ethqos, SDCC_DLL_CONFIG_DLL_EN,
> -		      SDCC_DLL_CONFIG_DLL_EN, SDCC_HC_REG_DLL_CONFIG);
> +	rgmii_setmask(ethqos, SDCC_DLL_CONFIG_DLL_EN,  SDCC_HC_REG_DLL_CONFIG);

double space

[...]

>  	/* Select RGMII, write 0 to interface select */
> -	rgmii_updatel(ethqos, RGMII_CONFIG_INTF_SEL,
> -		      0, RGMII_IO_MACRO_CONFIG);
> +	rgmii_clrmask(ethqos, RGMII_CONFIG_INTF_SEL,  RGMII_IO_MACRO_CONFIG);

and here

Everything else looks in tact

Konrad

