Return-Path: <netdev+bounces-39603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81A7C0051
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EABF1C20B9F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E82744A;
	Tue, 10 Oct 2023 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a0GFU1Ei"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668027442
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:24:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218993
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:24:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ACiYKq030607;
	Tue, 10 Oct 2023 15:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lTVEluWx030Oc2jZTr4bWE1/AeMQ61CXleEg+iNJBNk=;
 b=a0GFU1Ei8A2GehxC1bmrVwoGK88yPqicJFDdzlyQK/UwUsEOrOlkWFqYNv/dYrmeqv7X
 RXPawFFz0UhaSf+o6KeOBZ56OHo6z8jQfgkemvaHSZSnNXDDAkPUk37pdeAibHEj8Otu
 xz4LBz+q9v44pd7a0Vh4F4THud1JMJ15gm0BvMsc+6ljAyc8h86g+PN/Dj/1YDJqSD92
 U1eRizkUi3P1Vx2woAEZLCSCH+TY/dGzuhZR5WCoK1wotrMg0Jl3ao4+rS2TKqcqP8Qc
 pEXODjpDxBJqEEvxzPvdPnivzlSIUtgA+XCgHPZ9BBXnZzMIjOfxowMaIg48quZp4rTp tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj2ctsyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 15:23:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFNeZW027254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 15:23:42 GMT
Received: from [10.110.115.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 08:23:33 -0700
Message-ID: <b1efa230-b30b-0ace-5e99-fe8593eeb12e@quicinc.com>
Date: Tue, 10 Oct 2023 09:23:12 -0600
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
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20231010075655.2f8fbeb3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Vgl7x47hUem_RTtM7hlXm2yfQar_Bgj
X-Proofpoint-ORIG-GUID: _Vgl7x47hUem_RTtM7hlXm2yfQar_Bgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=783 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100113
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/2023 8:56 AM, Jakub Kicinski wrote:
> On Mon, 9 Oct 2023 22:00:40 -0600 Subash Abhinov Kasiviswanathan (KS)
> wrote:
>>> I don't understand why you need driver specific commands to do this.
>>> It should be easily achievable using existing TC qdisc infra.
>>> What's the gap?
>>
>> tc doesn't allow userspace to manipulate the flow state (allow /
>> disallow traffic) on a specific queue. As I understand, the traffic
>> dequeued / queued / dropped on a specific queue of existing qdiscs are
>> controlled by the implementation of the qdisc itself.
> 
> I'm not sure what you mean. Qdiscs can form hierarchies.
> You put mq first and then whatever child qdisc you want for individual
> queues.

There is no userspace interface exposed today currently to invoke 
netif_tx_stop_queue(dev, queue) / netif_tx_wake_queue(dev, queue). The 
API itself can only be invoked within kernel.

I was wondering if it would be acceptable to add a user accessible 
interface in core networking to stop_queue / wake_queue instead of the 
driver.

