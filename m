Return-Path: <netdev+bounces-35444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909857A987A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E84F1C21186
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A12171AA;
	Thu, 21 Sep 2023 17:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11611168B7
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771135102F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:15:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LF7P3e008335;
	Thu, 21 Sep 2023 15:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k2kLLXvSLj5YVi4WtjW7nxi7sPiTyIKNDigk5CN1lEY=;
 b=HQ1gnIJYUEqzoJzsmq66Z6f0Ko5PRA2Zm5v+2Rs8L65gzqnQcmPVxdlCtnikrq3ie9dx
 Tud/sAB4JjG65RhLsIZQKIYiR6hNpqF89sVQxohJBRghQ/hBvJ3eYteVbZj0UkEaUtno
 wXnFByEGeW9NIEVpBgvky0M3tRHvzU8Yylsevvs3IFEa2xgrdaX5NQ8eVrEGPeUFoAyW
 kwSGfM+lndToBVcFOz3d2JeUDgKy6bIJV0JlfH3ASaOn5RsIrtg/3udMGscYo2u8puwl
 TOlI3bDBvao2Z1npSAvl1KZjl/AqYzf43DoXez1W8R4f23v5GK0XjQa9AKmOGGM+/Ekt RQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t82mqjrt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 15:38:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LFcId9013220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 15:38:18 GMT
Received: from [10.110.20.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 08:38:17 -0700
Message-ID: <5702613e-ea14-40db-2557-7f8363563e33@quicinc.com>
Date: Thu, 21 Sep 2023 09:38:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] net: qualcomm: rmnet: Add side band flow control
 support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>
CC: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20230920003337.1317132-1-quic_subashab@quicinc.com>
 <49fed647-f8aa-857c-4edc-d38cf6a793d7@linux.dev>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <49fed647-f8aa-857c-4edc-d38cf6a793d7@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CNCbkl8eMnZ4WcZjYwqn_sZm9f9XARRS
X-Proofpoint-ORIG-GUID: CNCbkl8eMnZ4WcZjYwqn_sZm9f9XARRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=790 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210134
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/21/2023 4:51 AM, Vadim Fedorenko wrote:
> On 20/09/2023 01:33, Subash Abhinov Kasiviswanathan wrote:
>> Individual rmnet devices map to specific network types such as internet,
>> multimedia messaging services, IP multimedia subsystem etc. Each of
>> these network types may support varying quality of service for different
>> bearers or traffic types.
>>
>                   should it be xa_to_value(p)? otherwise txq is always 1
> 

Agree, this does indeed need to be xa_to_value(p)

>> +static u16 rmnet_vnd_select_queue(struct net_device *dev,
>> +                  struct sk_buff *skb,
>> +                  struct net_device *sb_dev)
>> +{
>> +    struct rmnet_priv *priv = netdev_priv(dev);
>> +    void *p = xa_load(&priv->queue_map, skb->mark);
>> +    u8 txq;
>> +
>> +    if (!p && !xa_is_value(p))
>> +        return 0;
> 
> The check is meaningless. I believe you were thinking about
> 
> if (!p || !xa_is_value(p))
> 
> But the main question: is it even possible to get something from xarray
> that won't pass the check? queue_map is filled in the same code, there 
> is now way (I believe) to change it from anywhere else, right?
> 
>> +
>> +    txq = xa_to_value(p);
>> +
>> +    netdev_dbg(dev, "mark %u -> txq %u\n", skb->mark, txq);
>> +    return (txq < dev->num_tx_queues) ? txq : 0;
>> +}


I'll update these checks as well.
It is not possible for the txq value to exceed the tx_queue limit for a 
given rmnet device.

> 

