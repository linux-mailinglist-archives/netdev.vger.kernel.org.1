Return-Path: <netdev+bounces-36660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6D7B1135
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 05:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 99580281853
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 03:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231276ABC;
	Thu, 28 Sep 2023 03:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E21C3E
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:32:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEEB94
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 20:32:17 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S3JYGj006915;
	Thu, 28 Sep 2023 03:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mHNRkCEOtSjnaNw6l9cVI6oEcAxDQWdqYDYN/GRpQ+g=;
 b=msJc0U4al7V25lnaJGvjPiSWRrQREzFGnacggutC/QmKiJhpjZ79z9Q+iO/WArsadgvI
 QuCH5toCUwA1SWeAKy+ufCMBmS5K5WlFcMW1hhHPQ55eZ3irSn1D1+mhsfHIu53a4f5M
 lhTycq6OrR8Qsj9mzeK3fTXcgAM85syeS8UQzELQyUmlrLRyJF0NkRFIAAzHsCIATFTF
 SeZp8y45QvRnPhgn5MZ5samwkn0NlYXeYbOsWj+Aa6j86Jcwzv9otzSRZX2FTRRNQN9N
 WAxJCsqHQDFcXLBhJD4PZ3MTX0B7YxjLD+XudT32Ael+fipk6pEPQWgRNiWNAfb647JK Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcvg98mcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 03:32:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S3VxF0018442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 03:31:59 GMT
Received: from [10.110.119.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 20:31:58 -0700
Message-ID: <1f0069a7-8581-acc0-1ab8-bd5dd95cdb49@quicinc.com>
Date: Wed, 27 Sep 2023 21:31:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2] net: qualcomm: rmnet: Add side band flow
 control support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <lkp@intel.com>
CC: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20230926182407.964671-1-quic_subashab@quicinc.com>
 <8cbd0969-0c1f-3c19-778b-4af9b3ad6417@linux.dev>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <8cbd0969-0c1f-3c19-778b-4af9b3ad6417@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cdUIC4GyqV6Ez7m2-v9rYzEYk2tJsSjR
X-Proofpoint-GUID: cdUIC4GyqV6Ez7m2-v9rYzEYk2tJsSjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=917 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280030
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 6:12 PM, Vadim Fedorenko wrote:
> On 26/09/2023 19:24, Subash Abhinov Kasiviswanathan wrote:
>> Individual rmnet devices map to specific network types such as internet,
>> multimedia messaging services, IP multimedia subsystem etc. Each of
>> these network types may support varying quality of service for different
>> bearers or traffic types.
>>
> 
>> +static u16 rmnet_vnd_select_queue(struct net_device *dev,
>> +                  struct sk_buff *skb,
>> +                  struct net_device *sb_dev)
>> +{
>> +    struct rmnet_priv *priv = netdev_priv(dev);
>> +    void *p = xa_load(&priv->queue_map, skb->mark);
> 
> Reverse X-mas tree, please.

We need to get priv first though. Alternatively, i could do the 
following but it is just more verbose for the sake of the formatting.

	struct rmnet_priv *priv;
	void *p;

	priv = netdev_priv(dev);
	p = xa_load(&priv->queue_map, skb->mark);

> 
>> +    u8 txq;
>> +
>> +    if (!p || !xa_is_value(p))
>> +        return 0;
>> +
>> +    txq = xa_to_value(p);
>> +
>> +    netdev_dbg(dev, "mark %08x -> txq %02x\n", skb->mark, txq);
>> +    return txq;
>> +}
>> +
> 
> 

