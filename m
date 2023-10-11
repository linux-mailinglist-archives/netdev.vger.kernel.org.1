Return-Path: <netdev+bounces-39768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F123C7C46C7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B18281A82
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CEA19D;
	Wed, 11 Oct 2023 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EREGsfet"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006E7F9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:36:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93D92
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:36:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B0VLEU004877;
	Wed, 11 Oct 2023 00:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=epqR3ZJtCUGZeL4exWXYotabWWbEtj7gPFIO6ttrYjk=;
 b=EREGsfetNAeEhnBK9+R46Xw3tSj4qZEUtm+bWNMqb3l85TGLk9lo2Rw65lDEuZzgR53S
 eDGiZvCbupUTFtzWHd78JwEEuiaqZXvtqKOoytK0qplXHzPY05fx25xf7KawJB5d8D0X
 797/3MyRN4T9diHU61R0eIEnzBzsyu3ziTulhT+E0BaT6moj73RzeF0MCZ63SMk9uO/l
 pL+k/hbW42XURvdNsnQuCNLhP0zLJCWTI6iE4cRBZ+sC/PYOQ5wUWh2TZdR/Ykrq6rly
 Q9P+QyU+WaDjYzsAWghcvA9Mv3LJRd3kkH3a5ooeIuHi+TtlnGtWjfHCbMriRRc/zyzc KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tne0q096a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 00:35:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B0Zdm8023040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 00:35:39 GMT
Received: from [10.110.115.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 17:35:38 -0700
Message-ID: <0a2595e5-972b-e73e-6221-85c37419ac6b@quicinc.com>
Date: Tue, 10 Oct 2023 18:35:37 -0600
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
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
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
 <e8ca04f4-08a1-0d79-7916-fa853e9aeda6@quicinc.com>
In-Reply-To: <e8ca04f4-08a1-0d79-7916-fa853e9aeda6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0D3YC5IjXMvJxbr-YPojPAsvLQbbt_wc
X-Proofpoint-ORIG-GUID: 0D3YC5IjXMvJxbr-YPojPAsvLQbbt_wc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110003
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/2023 3:32 PM, Subash Abhinov Kasiviswanathan (KS) wrote:
> 
> 
> On 10/10/2023 12:21 PM, Jakub Kicinski wrote:
>> On Tue, 10 Oct 2023 09:23:12 -0600 Subash Abhinov Kasiviswanathan (KS)
>> wrote:
>>>
>>> I was wondering if it would be acceptable to add a user accessible
>>> interface in core networking to stop_queue / wake_queue instead of the
>>> driver.
>>
>> Maybe not driver queue control but if there's no qdisc which allows
>> users to pause from user space, I think that would be a much easier
>> sale.
>>
>> That said the flow of the whole thing seems a bit complex.
>> Can't the driver somehow be notified by the device directly?
>> User space will suffer from all sort of wake up / scheduling
>> latencies, it'd be better if the whole sleep / wake thing was
>> handled in the kernel.
> 
> Our userspace module relies on various inputs from radio hardware and 
> has proprietary logic to determine when to transmit / stop sending 
> packets corresponding to a specific bearer. I agree that an in kernel 
> scheme might be faster than an userspace - kernel solution. However, I 
> believe that this latency impact could be reduced through schemes like 
> setting process priority, pinning applications in isolated cores etc.

After reviewing the qdisc set closer, it appears that my understanding 
was incorrect as tc-plug provides userspace controllable queuing. Thanks 
for the help and discussion!

