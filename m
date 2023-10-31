Return-Path: <netdev+bounces-45372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF81B7DC55B
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 05:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41376B20D30
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359126AA9;
	Tue, 31 Oct 2023 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="esjKO9ry"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E926FA0;
	Tue, 31 Oct 2023 04:25:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDDBA9;
	Mon, 30 Oct 2023 21:25:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V3ScT5031400;
	Tue, 31 Oct 2023 04:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vAYy4D4qjOtcU60l74QA9ANtlKZOwFC4NyU3Mci+YF0=;
 b=esjKO9ryV3rvZzOXEVt6qJDWNx2nDI82bOgH6w2DRvqpCzBSU3/UuLZyCForPBIUMftj
 uep+AFhOxYhYjmPQ39VsdmBWy5AgPblDDysR1B4lu8Pin5dCleOc+/QoswhSWtqYAq4g
 AJIs/CjKvtIhpuzi/qMU7mrAn7m2U682UgokAgjUgF1kx3OKs2Mv6YduOaxFexnef6YV
 j47AunfzefCIHzUa1v0/jx2pro5QwAAGAnIDcBP78YNnecayn6aiYseasbkvVv5714jI
 /drc7npSXEQ878u/9UkMQAanhFf8BHTTkb1905/sfYtMV8IfMjg9QfUBPxGKSlC/CxLm YA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7wmsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:24:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4OtZk017242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:24:55 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:24:50 -0700
Message-ID: <04680b40-9d2d-403c-93af-9e91a491a053@quicinc.com>
Date: Tue, 31 Oct 2023 09:54:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob
 Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
 <20231030-ipq5332-nsscc-v1-4-6162a2c65f0a@quicinc.com>
 <ac223f97efea0d5077a4e3e4dbd805b4.sboyd@kernel.org>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <ac223f97efea0d5077a4e3e4dbd805b4.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1mwe49ikGPIjr72wVEXYuhyG2YPSFk0D
X-Proofpoint-GUID: 1mwe49ikGPIjr72wVEXYuhyG2YPSFk0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310032



On 10/31/2023 12:27 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:19)
>> Add support for gpll0_out_aux clock which acts as the parent for
>> certain networking subsystem (NSS) clocks.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq5332.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> index 235849876a9a..966bb7ca8854 100644
>> --- a/drivers/clk/qcom/gcc-ipq5332.c
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -87,6 +87,19 @@ static struct clk_alpha_pll_postdiv gpll0 = {
>>          },
>>   };
>>   
>> +static struct clk_alpha_pll_postdiv gpll0_out_aux = {
>> +       .offset = 0x20000,
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
>> +       .width = 4,
>> +       .clkr.hw.init = &(struct clk_init_data) {
> 
> const initdata


Thanks for pointing it out. Some of the clock structure doesn't have the 
"const" qualifier. Will fix all those in V2.

> 
>> +               .name = "gpll0_out_aux",
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                               &gpll0_main.clkr.hw },
>> +               .num_parents = 1,
>> +               .ops = &clk_alpha_pll_postdiv_ro_ops,
>> +       },
>> +};
>> +
>>   static struct clk_alpha_pll gpll2_main = {
>>          .offset = 0x21000,
>>          .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],

