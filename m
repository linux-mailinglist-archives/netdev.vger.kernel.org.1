Return-Path: <netdev+bounces-220313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A56B45613
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2085C188253A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEEB34A326;
	Fri,  5 Sep 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEja0c3G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB29346A14
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070877; cv=none; b=lPC7WEC5PRfBJVLCWqZ5HO3DP7egEs2hG1wd4mCOnfx4ieuAMEyRVqLNfC50DM82faKWzBsA6S+h8Nswe8sAF76ixf08LPR5droH/YHKLuOFFfyhc8ldYI503MVEHobwfT2y8NgJzEVXoUxPP85oz9aTEWtdB9zWL1oXIfC16oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070877; c=relaxed/simple;
	bh=eMmQ9OoGm+P5E4eaGh3F1MRJISstesFzwHdqyCpi4pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAAPVI9NdLjXVJZcZi+upSM+1WeRdcqpinVy/zIm2iazLMiwiKY+yxlj1WzW7DZ1jrinTa7iB1NQC7s7xwpki6bi7C5FlBsp64RJhkb/CwkNQpgm+0Kb67GWdaax+h1Z3CipJv0t+IsfxOJg8F88Halct2mICV9JhEdYE7ZLMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEja0c3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857iopf023904
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 11:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/FpbTHZW4xFomqVXWX7ayTQvBYf6qoBXa0d+diUXkvY=; b=QEja0c3GC5hhIQb2
	fD9baFhbJ7Ms/iRoXZlJedqpURgY3oSaACrPnfba2EdQFzNkeTWIVxerLFDbesup
	WBz8YRPJ8ZC/4Kkx1DhO8p2gh+gjH3O9hD/EwkO+Sgt+0YCjrrkcqbaUXP+WMkoJ
	R3ApghoHAd/mSNCKhRSu2mV8b6Xj3sFh1e8K8ReVMswfAhNaYV2zOcdIKdpR+737
	9/DVisxAymcd6g3NsiHZ3eNFeqpdX8ig8AnXQNN/qA3P2nd3uiGuNOZzY3t9lIU7
	Xtu+KypdF7mkzV6hITjeNtfSe+zNmCaiv0YMNjPQO61bA3N1CprYrJSaFdeq8r7w
	imAKAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fts4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 11:14:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-804e9d31454so58653485a.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 04:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070874; x=1757675674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FpbTHZW4xFomqVXWX7ayTQvBYf6qoBXa0d+diUXkvY=;
        b=dkCnFqT3nDDoMR4Ldvpr4kwUUCntrmPofoBt026Uw8nMZiFuEbIeueTWnvCTm0JvAe
         +itwDIq6/AHLHNvYxY2VqwNZiXcXob+ZpldtZz60hnDGOyXm6aiWvmezjP9s4WhgMJ3R
         o7ZwoWXEbnQuoiNg2HtMof53RX8hrAq4GrUD6E2ehShJbUKnPyAkvxxZTCBNtFHRBEcp
         VV3CT4Xw6eq5zPxFCxwH0IbukiM9y8H9E1xZm0m/gjWvg+a9p2ZC2TasEQtoG/izY/nR
         e5+d5f1XQjcWpdMG9rta9LSGAup+opB6UnHORHtsjFCTEFGy6kc8Q1vPGp+13ZDIGmnY
         ETQg==
X-Forwarded-Encrypted: i=1; AJvYcCVx3nkBzsRW+uC4XwGYMKo82LBf3NvcEdfeotH+X2l0Qmi5y524LW5oM90omae+bU7AOqcGEO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcieB704T4d6Z1arB/0AJUrN6DIxT8AbVaBlQxQw9yMBbIdJE
	LxG89nV5T52H3hcSgqbwbuyF17ERwIGqxSK8zZtpBvHs9tSmJCrgC9hsNcBCGxpunKKE0Oe72pg
	qJeLM8RsKANN0HdX4iSj6JB8tXiNvamANk5/nvtvk4gOYyDICQ0jxl4htwZs=
X-Gm-Gg: ASbGnct7fBXBu0Qhh0mqIRAYrH085V0/85hst3PZif/eYYjaemgT5xip2+tBgV0n8Ls
	M8QbVaC7NPiYf+53rYIp4WD37tTVFxdAK3zr7msa3NNM0cmTe3FzOkI1305F+Gjq0zkV7C5qA/p
	ApqtD4Ia4rQKxS1Dm+nPZQsTFfrCQy5BRgOAv2xKBmNenbmyciY0NKYKcvDDq3a2cj8tJOlU4+k
	PZbGUhp5DI78TGbcdM1D2X/aDrUlg01lupooBCLDwgiQSbFlDjwmxf39+PaoGMv5+fZ43bvBxYX
	ubIp9gl4LEvQgCuffj8oQ6udIL+CB1DGqzrkhNwScxHHWpofAKT3pxDmB16d9aFhgQX4+988RUB
	gW2vb4fYuwcK2sqpE9DV/SQ==
X-Received: by 2002:a05:6214:2a88:b0:72b:880d:3bfc with SMTP id 6a1803df08f44-72b880d3c5amr24659086d6.2.1757070873571;
        Fri, 05 Sep 2025 04:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhxBIevK2sCdJCUPTxNgK1ElXc44o+jt15YDs8l2kK2RYkNbTjat2e9c4WHF0UaaGbTJuaiQ==
X-Received: by 2002:a05:6214:2a88:b0:72b:880d:3bfc with SMTP id 6a1803df08f44-72b880d3c5amr24658896d6.2.1757070872870;
        Fri, 05 Sep 2025 04:14:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03ab857474sm1508366066b.89.2025.09.05.04.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:14:32 -0700 (PDT)
Message-ID: <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 13:14:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX0TSQvUYPMx2I
 kguzCG0/dws1zjO4pph/WOmDhrfSRqPYjHZ0VVZ0tbuyxQi1YT4/Pj3zNq85zJEDbe6O9QWse7c
 VunyozUvHtHWYkJ/E2wInE+ZDjHm4xv5mGpwafAUw6flWGASGH7ltvdXC/Jx5UTeWxEyx8fa5uK
 ZWwiwRSw1hNxdYNgQCOxdGrZjHlF6ai/j8LMoUdxrok/F7A0SycbpycQU8sefDjY2+BldTGpTb6
 LWncGegqn3PfPrz1e2i3VonDeDKc6TVDs9eEdqW63+H+Ncz2OZPeJ78KEsjhOLQ6E40EAvR9EId
 g1JHrAw2iFFZD/1j/SJT0o0IccnU62Tp0Bm1uitfWIQnDqEe2oetlk09LMX4ETNZppZY7yu4zWp
 aJzkMK2R
X-Proofpoint-ORIG-GUID: ceYYZkpZmOXjlVuHdfra0LJkL-I6lAwb
X-Proofpoint-GUID: ceYYZkpZmOXjlVuHdfra0LJkL-I6lAwb
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bac61b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HgT1ff4I_b0h3GnEaV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>
>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>>>> This controller supports either eMMC or SD-card, but only one
>>>>>>> can be active at a time. SD-card is the preferred configuration
>>>>>>> on Lemans targets, so describe this controller.
>>>>>>>
>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>>>> to enable proper communication with the SDHC controller.
>>>>>>>
>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 70 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>>>  			};
>>>>>>>  		};
>>>>>>>  
>>>>>>> +		sdhc: mmc@87c4000 {
>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>>>> +
>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>>>> +
>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>>>> +			clock-names = "iface", "core";
>>>>>>> +
>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>>>> +
>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>>>> +			dma-coherent;
>>>>>>> +
>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>>>> +
>>>>>>> +			no-sdio;
>>>>>>> +			no-mmc;
>>>>>>> +			bus-width = <4>;
>>>>>>
>>>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>>>
>>>>> Unless the controller is actually incapable of doing non-SDCards
>>>>>
>>>>> But from the limited information I can find, this one should be able
>>>>> to do both
>>>>>
>>>>
>>>> It’s doable, but the bus width differs when this controller is used for
>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>>>> only what’s needed for each specific usecase on the board.
>>>
>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
>>> properties inside the board DT. I don't see a reason to deviate.
>>
>> Just to make sure we're clear
>>
>> I want the author to keep bus-width in SoC dt and move the other
>> properties to the board dt
> 
> I think bus-width is also a property of the board. In the end, it's a
> question of schematics whether we route 1 wire or all 4 wires. git-log
> shows that bus-width is being sent in both files (and probalby we should
> sort that out).

Actually this is the controller capability, so if it can do 8, it should
be 8 and the MMC core will do whatever it pleases (the not-super-sure
docs that I have say 8 for this platform)

Konrad

