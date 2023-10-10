Return-Path: <netdev+bounces-39423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE37BF1C7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE12819C7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157C4422;
	Tue, 10 Oct 2023 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="icd6RE7x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D24390
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:01:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FEAA9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 21:01:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A3pqWI012598;
	Tue, 10 Oct 2023 04:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L9Uy3+IvtE6Ycxz13IBM5KSCqwa4Eib+vVcNbzQctY8=;
 b=icd6RE7xDCEWUpTkp0oec/AXM1RX5nx4VOgnAHo1k0OlH4dgoLNBtqVIuJhQbTwIZCTj
 Da2PQMBb4X3fafo0WIRW/OcmIbdM5tlo7/CRpP0jXmEOvAk4Z82D9hV8M1iszOGMT4/i
 H7KDXMXtbNzV/WR0AjfQIRvlbdD4JanP7Cn48mERy97RYfxa3mZhtxn3OHuCvtQDLXiJ
 uHblMCXQ0wz/H+86qHBVfMYslyzHVyUsqAlfdqI730HoA0O9v10O9hV9qguEXz3eOw+c
 ZrqnaQTMO3pp1U02c7czqPIGPfEEmWlRliOIpquyrGVSDvLk6JIL1moyEYs8Frvg6y4n gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh6g43xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 04:00:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39A40ndw015526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 04:00:49 GMT
Received: from [10.110.115.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 21:00:48 -0700
Message-ID: <28518005-bb25-caed-1b12-bf12a3ded4bc@quicinc.com>
Date: Mon, 9 Oct 2023 22:00:40 -0600
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
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20231009194251.641e9134@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 14-Z-WMg8lDpgu8yBuxFImXllljQ77XN
X-Proofpoint-ORIG-GUID: 14-Z-WMg8lDpgu8yBuxFImXllljQ77XN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=588 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100027
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/9/2023 8:42 PM, Jakub Kicinski wrote:
> On Thu,  5 Oct 2023 17:16:14 -0700 Subash Abhinov Kasiviswanathan wrote:
>> Individual rmnet devices map to specific network types such as internet,
>> multimedia messaging services, IP multimedia subsystem etc. Each of
>> these network types may support varying quality of service for different
>> bearers or traffic types.
>>
>> The physical device interconnect to radio hardware may support a
>> higher data rate than what is actually supported by the radio network.
>> Any packets transmitted to the radio hardware which exceed the radio
>> network data rate limit maybe dropped. This patch tries to minimize the
>> loss of packets by adding support for bearer level flow control within a
>> rmnet device by ensuring that the packets transmitted do not exceed the
>> limit allowed by the radio network.
>>
>> In order to support multiple bearers, rmnet must be created as a
>> multiqueue TX netdevice. Radio hardware communicates the supported
>> bearer information for a given network via side band signalling.
>> Consider the following mapping -
>>
>> IPv4 UDP port 1234 - Mark 0x1001 - Queue 1
>> IPv6 TCP port 2345 - Mark 0x2001 - Queue 2
>>
>> iptables can be used to install filters which mark packets matching these
>> specific traffic patterns and the RMNET_QUEUE_MAPPING_ADD operation can
>> then be to install the mapping of the mark to the specific txqueue.
> 
> I don't understand why you need driver specific commands to do this.
> It should be easily achievable using existing TC qdisc infra.
> What's the gap?

tc doesn't allow userspace to manipulate the flow state (allow / 
disallow traffic) on a specific queue. As I understand, the traffic 
dequeued / queued / dropped on a specific queue of existing qdiscs are 
controlled by the implementation of the qdisc itself.

