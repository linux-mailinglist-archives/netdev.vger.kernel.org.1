Return-Path: <netdev+bounces-33363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D179D935
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F7280E7A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C01A933;
	Tue, 12 Sep 2023 18:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848494435
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:55:10 +0000 (UTC)
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF47125
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:55:09 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.17.1.22/8.17.1.22) with ESMTP id 38CHtiDw029766;
	Tue, 12 Sep 2023 19:55:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=tOb3I3guzu0jbA7Yvi67vz4saKK9+5O/qQjEl3GWz+o=; b=
	DHjY8iSHktaFNDqGv/+oFXXds2K0DSPZrQJDQ8T1dLz1G87MMggsu9cQJTkLuzl7
	4E0fnN+b5/7hMQmiARFI6hLozod/bGhCccF2NEvh3T+vcMyMRW+EinvXZvCxPCn2
	K+ugJ14BiUyLF9G1l8zRVmBul5lxFDOQSGkJqMBJuEb79NN5RVjOjeD1AF3CvhkE
	Kjv775ViGEE4OOwR7j1wfpmP4h5SJOBmfuoSONkhXXDxjC1hhyo6IqT7XGvXwrv8
	2VFyhWbMgTVUlOjHHeMCI4adFJd0LEJH5G011aKxAeGoimVLNEVFrsv9uI6ufyyJ
	HU4cpnphnFx055JPbAJk3A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3t0dsdxkn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 19:55:01 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38CHZ9Ld013482;
	Tue, 12 Sep 2023 11:54:49 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 3t0ppa1sp3-1;
	Tue, 12 Sep 2023 11:54:49 -0700
Received: from [172.19.44.156] (bos-lpa4700a.bos01.corp.akamai.com [172.19.44.156])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 5D120315BB;
	Tue, 12 Sep 2023 18:54:49 +0000 (GMT)
Message-ID: <8cf748a6-cc8d-993f-9c2d-fbdf48b0e376@akamai.com>
Date: Tue, 12 Sep 2023 14:54:49 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next 1/2] inet_diag: export SO_REUSEADDR and SO_REUSEPORT
 sockopts
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <0b1deb44b8401042542a112e8235e039fc0a5f65.1694523876.git.jbaron@akamai.com>
 <20230912162644.60787-1-kuniyu@amazon.com>
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20230912162644.60787-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120158
X-Proofpoint-GUID: k52r5qp8XQkl6I3R7fuU0HwHSVEUFIy2
X-Proofpoint-ORIG-GUID: k52r5qp8XQkl6I3R7fuU0HwHSVEUFIy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309120159



On 9/12/23 12:26 PM, Kuniyuki Iwashima wrote:
> From: Jason Baron <jbaron@akamai.com>
> Date: Tue, 12 Sep 2023 10:31:48 -0400
>> Add the ability to monitor SO_REUSEADDR and SO_REUSEPORT for an inet
>> socket. These settings are currently readable via getsockopt().
>> We have an app that will sometimes fail to bind() and it's helpful to
>> understand what other apps are causing the bind() conflict.
> 
> If bind() fails with -EADDRINUSE, you can find the conflicting sockets
> with just the failing 2-tuple, no ?

True, yes one can figure out the conflicting socket as is I agree, but 
then the next step is what went wrong. For so_reuseport, you also need 
to match uid for it to work. Or if the socket is bound to different 
devices it is ok, regardless of the reuse/reuseport setting (if I read 
the code correctly)...And these other factors are currently exposed via 
sock_diag. So maybe you can deduce these via process of elimination but 
I think it could be nice to be more explicit about it.

> 
> Also, BPF iterator and bpf_sk_getsockopt() has the same functionality
> with more flexibility.  (See: sol_socket_sockopt() in net/core/filter.c)
> 
> 

True, yeah on one hand the fact that reuseport/reuseaddr are exposed via 
bpf means they are useful and reasonable to expose. On the other hand 
yeah there's an existing interface if you want to hook up bpf code. In 
the use case I had, we have a C++ application that wants to print debug 
information about the conflicting socket when the -EADDRINUSE happens 
and not necessarily have to invoke a bpf program.

Thanks,

-Jason


>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> ---
>>   include/linux/inet_diag.h      | 2 ++
>>   include/uapi/linux/inet_diag.h | 7 +++++++
>>   net/ipv4/inet_diag.c           | 7 +++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
>> index 84abb30a3fbb..d05a4c26b13d 100644
>> --- a/include/linux/inet_diag.h
>> +++ b/include/linux/inet_diag.h
>> @@ -77,6 +77,8 @@ static inline size_t inet_diag_msg_attrs_size(void)
>>   #endif
>>   		+ nla_total_size(sizeof(struct inet_diag_sockopt))
>>   						     /* INET_DIAG_SOCKOPT */
>> +		+ nla_total_size(sizeof(struct inet_diag_reuse))
>> +						    /* INET_DIAG_REUSE */
>>   		;
>>   }
>>   int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
>> index 50655de04c9b..f93eeea1faba 100644
>> --- a/include/uapi/linux/inet_diag.h
>> +++ b/include/uapi/linux/inet_diag.h
>> @@ -161,6 +161,7 @@ enum {
>>   	INET_DIAG_SK_BPF_STORAGES,
>>   	INET_DIAG_CGROUP_ID,
>>   	INET_DIAG_SOCKOPT,
>> +	INET_DIAG_REUSE,
>>   	__INET_DIAG_MAX,
>>   };
>>   
>> @@ -201,6 +202,12 @@ struct inet_diag_sockopt {
>>   		unused:5;
>>   };
>>   
>> +struct inet_diag_reuse {
>> +	__u8	reuse:4,
>> +		reuseport:1,
>> +		unused:3;
>> +};
>> +
>>   /* INET_DIAG_VEGASINFO */
>>   
>>   struct tcpvegas_info {
>> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
>> index e13a84433413..d6ebb1e612fc 100644
>> --- a/net/ipv4/inet_diag.c
>> +++ b/net/ipv4/inet_diag.c
>> @@ -125,6 +125,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>>   			     bool net_admin)
>>   {
>>   	const struct inet_sock *inet = inet_sk(sk);
>> +	struct inet_diag_reuse inet_reuse = {};
>>   	struct inet_diag_sockopt inet_sockopt;
>>   
>>   	if (nla_put_u8(skb, INET_DIAG_SHUTDOWN, sk->sk_shutdown))
>> @@ -197,6 +198,12 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>>   		    &inet_sockopt))
>>   		goto errout;
>>   
>> +	inet_reuse.reuse = sk->sk_reuse;
>> +	inet_reuse.reuseport = sk->sk_reuseport;
>> +	if (nla_put(skb, INET_DIAG_REUSE, sizeof(inet_reuse),
>> +		    &inet_reuse))
>> +		goto errout;
>> +
>>   	return 0;
>>   errout:
>>   	return 1;
>> -- 
>> 2.25.1

