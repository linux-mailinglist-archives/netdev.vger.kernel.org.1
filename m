Return-Path: <netdev+bounces-45366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421887DC537
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 05:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D701C208CB
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF95698;
	Tue, 31 Oct 2023 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ge9ZRhHc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9D5672;
	Tue, 31 Oct 2023 04:16:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C0C0;
	Mon, 30 Oct 2023 21:16:37 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V1DlXX023759;
	Tue, 31 Oct 2023 04:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mr9UzqvLhnzLnqru6L2w2RDsyzGZuGqsh2flGIiGQxM=;
 b=Ge9ZRhHcKz1a5jEKuPbpJbXQpoN09ZD715A1ZfuaCHOcIv8FwbsOXsVa2sUqnaX/HBsW
 ewEwCasnzEievJCIyl669/RZ4tUYx4qPoRMLdSvW9O4iy/P2ktRWodMH6CobsmPnYaFY
 Vm+ySLl9joorm9mvUCtjzZ5/OEIBNktUUTkulCaHzj2DmIon+uSKXn5TeFNxd57vefMP
 HzPHuKNuuxgGY1SNxsfORbC2of6AQGAzi8+gXoSZFRi3v24UXOP8e6BApUtTE/as0ovr
 0sSmnbCRdouadcHLg1PallNgkkQCcas98Pde+MFsUFwrz9X4jmkXIbGVtyZvAb48R9Us yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcygkvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:16:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4GPUn001733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:16:25 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:16:19 -0700
Message-ID: <7904c396-c11e-40eb-b82c-eb187818b602@quicinc.com>
Date: Tue, 31 Oct 2023 09:46:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: defconfig: build NSS Clock Controller driver
 for IPQ5332
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
 <20231030-ipq5332-nsscc-v1-8-6162a2c65f0a@quicinc.com>
 <18ca181a-8aee-46f5-9e2d-bfba4c8bd99e@linaro.org>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <18ca181a-8aee-46f5-9e2d-bfba4c8bd99e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4BwK5Ub-NFxCi3ptb6Sgyu7ORcT8Q65h
X-Proofpoint-ORIG-GUID: 4BwK5Ub-NFxCi3ptb6Sgyu7ORcT8Q65h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=710 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310031



On 10/30/2023 4:38 PM, Krzysztof Kozlowski wrote:
> On 30/10/2023 10:47, Kathiravan Thirumoorthy wrote:
>> Build Qualcomm IPQ9574 NSSCC driver as module.
> 
> Why? Commit msg should answer this.


Sure, will fix it in V2.

> 
> Best regards,
> Krzysztof
> 

