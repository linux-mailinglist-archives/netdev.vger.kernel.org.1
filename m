Return-Path: <netdev+bounces-39707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7757C429E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C071C20B50
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222D29D0F;
	Tue, 10 Oct 2023 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DFuBHElt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2A186C
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:32:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2791
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:32:45 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ALTmeo013901;
	Tue, 10 Oct 2023 21:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s40dEpv7QutlEOm7el3jsUZjU5gk2Vsu+hBLiFSKmVg=;
 b=DFuBHEltCaA9QZw6Xi8cTEAyiW/Hhw5zMvyP05caWki1dYHjFvtcBVzwLDp5xlpWwMYL
 TEW+Dda/iaimdsE7qkFzbfbitcrug5bWZ/GUoSDoe1BlsNfuwBa4SZkPXVSiOFMd+Zhi
 ECF6PfCCtoHZpNTspWHpIvEzgIiUJXbWDxDE1m/gyPofgv/PLDoSjTth/VSwUKvlKOwu
 qQ/BNkIEDQclboPC/gEUsisiwca06vMi3/ADnadhfqJ1CL7eCrvSEupvtsLnYg86NjB0
 W3/l/lqJ3JMgTXYheSvrqUjuJY67Pfg8kWTkAihPKocc0YebpUCDe+MQPfvmS5yASH75 3g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tna9c8j3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 21:32:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ALWKkl031539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 21:32:21 GMT
Received: from [10.110.115.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 14:32:19 -0700
Message-ID: <e8ca04f4-08a1-0d79-7916-fa853e9aeda6@quicinc.com>
Date: Tue, 10 Oct 2023 15:32:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4] net: qualcomm: rmnet: Add side band flow
 control support
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>, <lkp@intel.com>,
        <horms@kernel.org>, Sean Tranchetti <quic_stranche@quicinc.com>
References: <20231006001614.1678782-1-quic_subashab@quicinc.com>
 <20231009194251.641e9134@kernel.org>
 <28518005-bb25-caed-1b12-bf12a3ded4bc@quicinc.com>
 <20231010075655.2f8fbeb3@kernel.org>
 <b1efa230-b30b-0ace-5e99-fe8593eeb12e@quicinc.com>
 <20231010112159.2e2e1b86@kernel.org>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20231010112159.2e2e1b86@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7jA6T3YKV0hfg48GeGMawSjPV2XCIIa
X-Proofpoint-ORIG-GUID: t7jA6T3YKV0hfg48GeGMawSjPV2XCIIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_17,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100166
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/2023 12:21 PM, Jakub Kicinski wrote:
> On Tue, 10 Oct 2023 09:23:12 -0600 Subash Abhinov Kasiviswanathan (KS)
> wrote:
>>
>> I was wondering if it would be acceptable to add a user accessible
>> interface in core networking to stop_queue / wake_queue instead of the
>> driver.
> 
> Maybe not driver queue control but if there's no qdisc which allows
> users to pause from user space, I think that would be a much easier
> sale.
> 
> That said the flow of the whole thing seems a bit complex.
> Can't the driver somehow be notified by the device directly?
> User space will suffer from all sort of wake up / scheduling
> latencies, it'd be better if the whole sleep / wake thing was
> handled in the kernel.

Our userspace module relies on various inputs from radio hardware and 
has proprietary logic to determine when to transmit / stop sending 
packets corresponding to a specific bearer. I agree that an in kernel 
scheme might be faster than an userspace - kernel solution. However, I 
believe that this latency impact could be reduced through schemes like 
setting process priority, pinning applications in isolated cores etc.

