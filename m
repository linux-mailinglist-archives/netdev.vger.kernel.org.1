Return-Path: <netdev+bounces-234328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C11C1F70B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328784EA589
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE234E777;
	Thu, 30 Oct 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCRCoZgA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hy/Ad1X4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9734E74B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818515; cv=none; b=iFWZMWfS3oXa2Ai2fKJUPVinIJBC4S3UL7WCBPiTYU0bHdRsf8XCrLAkH3MIjtBqLnyi0UA5q/bTxVHcHEdO8V8Y1mCLH0W0sNdjs3eevMukeN7nFWAJmfqn+BzS++8DaHJ2rUxu6ODRN6fGPWB0Ron/+akz/FgKGpB2h39E4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818515; c=relaxed/simple;
	bh=dXTC3SLxzp5wKcJKxLFNRweVNbKkU4TNi6Ad5nvL8nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuPcR3zi+/qmt4zCm/u1zDCov2+05ozmKqKXbZQ85cT9ptPzDZIrtYIK0MsYVFk65mLbI6yj6onqh8iWnQaJ09HSHKeIaEUvOtZSKIPIOo0GA3LWo1blKO5Y8LZNPj+15mF4P0LGGWYTujqC3/ed4W4PUOkaBwr9oFd2Xe5uqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCRCoZgA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hy/Ad1X4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9WU6A3117271
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32h5K3ewwycqfrD/0JMWOprkDGOg3ozbJGj35ETznY0=; b=RCRCoZgA56ns6yDd
	+yKBRhyBmEiRgH/A3pfEKSzWFhIR04h7Iz2FBrAGKfLc8PNTcxkcTOvIzbApPQnO
	zDTib+W4cS1qTj+QOlhY2vSJ3etZp+sTAEwLusnkHsPrzHDq4O1Z/pYMi79ythDq
	HtT/tGGuL+gK8LCKQW8g0luvCNoG+3ZxzKX1JCixIYksRw0511e+nmCkoUINzVe0
	fj/cqmy6hR+2cS7ZV1/an2juZI/oX1duW9iPspKJtHEbpHz18dmNN87yFf3SzUw2
	784rl2kTyWAGr9bq6ouvOMZgCqbnb8Kt/QF1esQkIyl0JK3hzK5uh+va+rxWJjwA
	qDOypA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45frg3dy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:01:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8934ae68aso2022991cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761818512; x=1762423312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32h5K3ewwycqfrD/0JMWOprkDGOg3ozbJGj35ETznY0=;
        b=hy/Ad1X4S9hsy6BorcZQAirjpATjozR2dVkjeDfnyheHjgSVKRiq3VcHjHvahYZNCi
         VW9fz7Uilj0gGCCZeeYNIeuMcxuOCqkK0N8BSXJM8A5zFQYkXNmtqjSQALQRQb8Qs0bR
         Dy5u2lGjXGexfHF9jOa+/mgeNui3IhaEtHW/mu5Nu8pOrPRaQ6Yr0mkeDa4Gte/7gAdW
         ejUIvdje7Es0AZVLrfQSlbDE1u2lpRjgKiwKmwA8mlvZGgqW+e7P4+PhZ+d1ZCaJfpJe
         aKI1d+MVvJSCnoOTkZhwOBEmR0yV6f1hGqizbm8Y+uP10mFliso6y8FfxOf/AXXm6xxa
         cJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818512; x=1762423312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32h5K3ewwycqfrD/0JMWOprkDGOg3ozbJGj35ETznY0=;
        b=iNcFeKiN0O+iwKtuLvyQlAvlw/x/g0binBoCUiE2Q6AXvhP5cqeaX5hon15Z3s8SeL
         yVRJSWhM8i265SrkI9HKX2zAO2KQMN3EBBk5sxlOyEyY0TtJ0h896xkhWqgY9LG8QPXU
         oapoiaTdLM9chqrjIw8/vFMtDFRXax9u62z7LqVeVdO9D1Wv6jC7MuefBxTsDe7joSOK
         7a/fL/uWE5zBZKv9Spn9qoL2nb+gmVCi9WVRyHbHx7CH1u35ts0LKnBtkWrkFsOrc/qh
         iIDda8Ij+1oR0eX1dCX7CSuKydsrggiAPVS6Q4gTWmj2bFpAh3xgLQ/gcKo9ejbkUoGY
         8HfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX86Q1He4Pn2ngOTIfn1i/+EB+OXWqFCnVgyv3WVsYN6zgxHlNUMbkVtZRP97ire3wy8sdf98w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsVAeAM5jBtFZHed75bx9/ZlaMLyS2C5uUhIwld5h5tvmoakr
	cFNZxt00Bb6hhich5MN/iUaGBpdCIa3jhoHtsG2lJq5utsIrs/WrQ9j4TfW5IIrTT2soyYc1eVX
	dz6wsECbFVCKZ3AxOdEmfMvM5KM3gLG+LR6agwoi+KwheBbu69P2okcnfKLY=
X-Gm-Gg: ASbGncsmK8+naY5agf+rKjX99ahPU7gLkaSC1ol8mJrnRBhNRcQyAMpk9NpAwfhSOJm
	yGeInIQd07VbjLJtHf5npd1EIQuM0ORgMtndm32oRuGYBgrQwFbZVAMX2Jk0rqluTaRg3WTarip
	to56HbuSEFDsBhv31t1y3LahLkeoRouhAjh6+asatqdcxQ16xlHwh7EZ2AMaa2oBt1NGgNW8+qh
	GMfk3ukFNfisLceE4IWAdl8M8yf5KLCBs8y6Yk3R8UWdhU6uCVF5kPPYa6ZltannX7C0vBRGGzU
	V36U/G6MbmYadvbxihOap/8mrXgPEZh2QjDFrsGwtfd80owFblHaY8aXAYd8u5WwftyBf6rt5+J
	3EhIi83HAyXWv5bSKuLzaqIaZ4qPMheb70BYxuWF0FHq9x825hgR7RaU0
X-Received: by 2002:ac8:5f0e:0:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4ed15c0e8f8mr55333831cf.9.1761818512274;
        Thu, 30 Oct 2025 03:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRkwzCLPCxSVHJgMpfb+sSifTWDoxG9G5XDKheZ5CxBk6Vcn9HesLaF6FBOsZzqqrVE4rY6g==
X-Received: by 2002:ac8:5f0e:0:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4ed15c0e8f8mr55333381cf.9.1761818511580;
        Thu, 30 Oct 2025 03:01:51 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7058770e28sm164872366b.13.2025.10.30.03.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:01:51 -0700 (PDT)
Message-ID: <7a774a6d-3f8f-4f77-9752-571eadd599bf@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:01:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: remove MAC_CTRL_REG
 modification
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <E1vE3GG-0000000CCuC-0ac9@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E1vE3GG-0000000CCuC-0ac9@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KupAGGWN c=1 sm=1 tr=0 ts=69033791 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YjBZYspd3xVaAZo-ivoA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: EoSBaCTIJ_Jm2kBQFOAsq5EnfTl9vQt0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4MSBTYWx0ZWRfXx+tVAkjbx4E0
 kWvfeOk1TAqnp/PggGsVZjYT0YMIpi610YYHJAnwnCsAjtTdMKU4wbt5nQ5SioeLKPT2KXhuz1i
 0OVT3dWmU0qkO+h1Bkm+D3XQJk1m2qCpTBJwXWU0cPurF4A26+ukU+969yjSDgbHMbgaDRBXB/+
 wXBvsDaHPs65GPwmCW9gzhu1zjqKS/2VSFhnKFs19VOYtIU4QOfV7n4kJZXQgBR2wLXGUvrE5bS
 VvAGcxCQF/GPiNSplQ+dN6O8wPcAXCbVLNxO54YpdkoJ+TOwjpM5xE6bZlFwOy5zxchGA4MvDMI
 I0TY14cJ0duaIeixyDKK84AjsnqpPBEKAOznpctJqZrm4kiUgnqmPf8FRIEG2pmdMlUeIk2e4Oh
 EOpj1maTnH5VBG7JonXiA492DzbbPA==
X-Proofpoint-GUID: EoSBaCTIJ_Jm2kBQFOAsq5EnfTl9vQt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300081

On 10/29/25 11:18 AM, Russell King (Oracle) wrote:
> When operating in "SGMII" mode (Cisco SGMII or 2500BASE-X), qcom-ethqos
> modifies the MAC control register in its ethqos_configure_sgmii()
> function, which is only called from one path:
> 
> stmmac_mac_link_up()
> +- reads MAC_CTRL_REG
> +- masks out priv->hw->link.speed_mask
> +- sets bits according to speed (2500, 1000, 100, 10) from priv->hw.link.speed*
> +- ethqos_fix_mac_speed()
> |  +- qcom_ethqos_set_sgmii_loopback(false)
> |  +- ethqos_update_link_clk(speed)
> |  `- ethqos_configure(speed)
> |     `- ethqos_configure_sgmii(speed)
> |        +- reads MAC_CTRL_REG,
> |        +- configures PS/FES bits according to speed
> |        `- writes MAC_CTRL_REG as the last operation
> +- sets duplex bit(s)
> +- stmmac_mac_flow_ctrl()
> +- writes MAC_CTRL_REG if changed from original read
> ...
> 
> As can be seen, the modification of the control register that
> stmmac_mac_link_up() overwrites the changes that ethqos_fix_mac_speed()
> does to the register. This makes ethqos_configure_sgmii()'s
> modification questionable at best.
> 
> Analysing the values written, GMAC4 sets the speed bits as:
> speed_mask = GMAC_CONFIG_FES | GMAC_CONFIG_PS
> speed2500 = GMAC_CONFIG_FES                     B14=1 B15=0
> speed1000 = 0                                   B14=0 B15=0
> speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS     B14=1 B15=1
> speed10 = GMAC_CONFIG_PS                        B14=0 B15=1
> 
> Whereas ethqos_configure_sgmii():
> 2500: clears ETHQOS_MAC_CTRL_PORT_SEL           B14=X B15=0
> 1000: clears ETHQOS_MAC_CTRL_PORT_SEL           B14=X B15=0
> 100: sets ETHQOS_MAC_CTRL_PORT_SEL |            B14=1 B15=1
>           ETHQOS_MAC_CTRL_SPEED_MODE
> 10: sets ETHQOS_MAC_CTRL_PORT_SEL               B14=0 B15=1
>     clears ETHQOS_MAC_CTRL_SPEED_MODE
> 
> Thus, they appear to be doing very similar, with the exception of the
> FES bit (bit 14) for 1G and 2.5G speeds.

Without any additional knowledge, the register description says:

2500: B14=1 B15=0
1000: B14=0 B15=0
 100: B14=1 B15=1
  10: B14=0 B15=1

(so the current state of this driver)

and it indeed seems to match the values set in dwmac4_setup()

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

