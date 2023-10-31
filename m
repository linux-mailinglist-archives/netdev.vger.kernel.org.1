Return-Path: <netdev+bounces-45369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244147DC54C
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A98B20CE7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1263B2;
	Tue, 31 Oct 2023 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cn974MEZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BCC611F;
	Tue, 31 Oct 2023 04:21:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20663C0;
	Mon, 30 Oct 2023 21:21:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V4IRhM001783;
	Tue, 31 Oct 2023 04:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OEmw8PzlKEkrpYgWprYSPN+594Bucf70BEOAxSUAv/M=;
 b=cn974MEZ5keIbw1PkL/fLl3NdElcp7pt/je3AjxmXas6EXSTmofjWdR7IJFgafT1Y2T5
 0HsWiCBLcaN/jVoDm3rh/WeL8WJ4NL6EyeRE+IackxfApIYxpmq3OKWRsg8nQ3E1RqZH
 WudSxToROyxdS/nVt1Nj6wgGxucowc9wEnuCpFuUf8TP2v2RoTTCKwyCFsu+wuvSHMgj
 i/MxrW/LvAJJoxwpFda+832knd05GtNlKxIFsYV03ekKjHz7DsHHM9IR43AA0+OtTkjW
 thi6ktGpx1EqH2g04e0D+lPOKZ9h+B/8/0E/G++F9pz3KmEOy1MpeF6JPig2NBnoqLZW iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jtfk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:21:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4L7o6006968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:21:07 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:21:02 -0700
Message-ID: <b20a1cf2-445b-493e-9c49-25cf854d429b@quicinc.com>
Date: Tue, 31 Oct 2023 09:50:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: clock: ipq5332: drop the few nss clocks
 definition
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
 <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
 <4ac6b9d1e6dc7859b39fa456cec70fc7.sboyd@kernel.org>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <4ac6b9d1e6dc7859b39fa456cec70fc7.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GtSSJD88rp9SZ8aU_kYwEVN1prSeSDR1
X-Proofpoint-ORIG-GUID: GtSSJD88rp9SZ8aU_kYwEVN1prSeSDR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=714
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310032



On 10/31/2023 12:26 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:17)
>> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
>> enabled by default and it's RCG is properly configured by bootloader.
>>
>> Some of the NSS clocks needs these clocks to be enabled. To avoid
>> these clocks being disabled by clock framework, drop these entries.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
> 
> Instead of this patch just drop the clks from the table and enable the
> clks during probe with register writes.


Thanks for the suggestion Stephen, will handle this way in V2. Between, 
I think still the entries in the dt-bindings can be dropped along with 
the entries in the clock table?

