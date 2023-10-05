Return-Path: <netdev+bounces-38439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889747BAEFD
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5F514B20987
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60641E58;
	Thu,  5 Oct 2023 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LoG/AmGB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7941A9B
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:53:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74552FB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:52:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395MgAM1028955;
	Thu, 5 Oct 2023 22:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=skMxIOFCafHXmctcavpjeSfnJgeomhtqCHvRRlrSJxs=;
 b=LoG/AmGBYJwbs4tGzfSedS2EuiwUOVwV/iah5sF49qesDnSwN/DaQUqxJ1VTxe0czk+t
 6gzMqU+f61f8iXZFDGaaSef61BbqcDVgERBY4YomoMbZpUkhjLNv93efRqpWPYO8j8d7
 EMzn142dNxWTZuQ8aMM/NpwcTx1XpjcLCnu/Zft6rXiOoFp/FViWAA1Zv6yl7Xw75Sme
 hucaF14dP65Ff5kuxjan317qRXmgJpNxJXYRzE7JlUkM39+rsY0m+GjHSAX6gAh7/SEY
 XlT/fe1PcbaKLzu9g0s2f2h2x9J6msdjx2pixJNVCLKjZvlL2V1zlDjZBWsvTA3Qdp9S Sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thrjdstyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Oct 2023 22:52:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395MqYT7015721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Oct 2023 22:52:34 GMT
Received: from [10.110.21.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 15:52:32 -0700
Message-ID: <e877c99a-072e-76d5-3c83-d552caf0c1f6@quicinc.com>
Date: Thu, 5 Oct 2023 16:52:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3] net: qualcomm: rmnet: Add side band flow
 control support
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <vadim.fedorenko@linux.dev>, <lkp@intel.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>
References: <20231004204320.1068010-1-quic_subashab@quicinc.com>
 <ZR6vxaot4AP7FXTg@kernel.org>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <ZR6vxaot4AP7FXTg@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZqFpVvqAjZqKJLbTodCjBOQZ5QmyaAVM
X-Proofpoint-GUID: ZqFpVvqAjZqKJLbTodCjBOQZ5QmyaAVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_17,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 mlxlogscore=704 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050174
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 10/5/2023 6:44 AM, Simon Horman wrote:
> On Wed, Oct 04, 2023 at 01:43:20PM -0700, Subash Abhinov Kasiviswanathan wrote:
>> Individual rmnet devices map to specific network types such as internet,
>> multimedia messaging services, IP multimedia subsystem etc. Each of
>> these network types may support varying quality of service for different
>> bearers or traffic types.
>>
> 
> Hi Subash and Sean,
> 
> a few comments on error handling from my side.
> 
> ...
> 
>> +	default:
>> +		NL_SET_ERR_MSG_MOD(extack, "unsupported operation");
>> +		return -EINVAL;
> 
> I'm wondering if EOPNOTSUPP is appropriate here.

Hi Simon

Sure, I can update this error code here and return the appropriate value 
through the caller functions.

> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void rmnet_unregister_bridge(struct rmnet_port *port)
>>   {
>>   	struct net_device *bridge_dev, *real_dev, *rmnet_dev;
>> @@ -175,8 +237,24 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
>>   	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
>>   	port->data_format = data_format;
>>   
>> +	if (data[IFLA_RMNET_QUEUE]) {
>> +		struct rmnet_queue_mapping *queue_map;
>> +
>> +		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
>> +		if (rmnet_update_queue_map(dev, queue_map->operation,
>> +					   queue_map->txqueue, queue_map->mark,
>> +					   extack))
> 
> Should the return value of rmnet_update_queue_map() be stored in err
> so that it is also the return value of this function?
> 
>> +			goto err3;
>> +
>> +		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
>> +			   queue_map->operation, queue_map->txqueue,
>> +			   queue_map->mark);
>> +	}
>> +
>>   	return 0;
>>   
>> +err3:
>> +	hlist_del_init_rcu(&ep->hlnode);
> 
> Is a call to netdev_upper_dev_unlink() needed here?

I'll update this missing API call in the cleanup.

> 
>>   err2:
>>   	unregister_netdevice(dev);
>>   	rmnet_vnd_dellink(mux_id, port, ep);
>> @@ -352,6 +430,20 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>>   		}
>>   	}
>>   
>> +	if (data[IFLA_RMNET_QUEUE]) {
>> +		struct rmnet_queue_mapping *queue_map;
>> +
>> +		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
>> +		if (rmnet_update_queue_map(dev, queue_map->operation,
>> +					   queue_map->txqueue, queue_map->mark,
>> +					   extack))
>> +			return -EINVAL;
> 
> I guess that with the current implementation of rmnet_update_queue_map()
> it makes no difference, but perhaps it would be better to return
> the return value of rmnet_update_queue_map() rather than hard coding
> -EINVAL here.
> 
>> +
>> +		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
>> +			   queue_map->operation, queue_map->txqueue,
>> +			   queue_map->mark);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
> 
> ...

