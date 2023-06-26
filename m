Return-Path: <netdev+bounces-14048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD3873EB2A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCC1280E5B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A213AD2;
	Mon, 26 Jun 2023 19:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52943134CE
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:24:00 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188CE74
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:23:59 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QJC1Pn021977;
	Mon, 26 Jun 2023 19:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=27OhXFcvAxtamd1NcYxGbbpWlDouwYp8jpIVmwLm82E=;
 b=m/QoCXWMT0Or/gm+/e6+TUJ29MUPs8zAMoLqWm0JU8UxPDVgye/RJeSljjn0LIMsHKkO
 wr/NQfho4JJgHsXBzOg05tz4UtTo/w9dwzhK5iIAs0WA4MnLKqHQrkVMZSdBB8QIidbC
 OW8sOpqFlTVkBiXybVy79tvc+/8DtFkTuqRElch2ahI6qEEqN+K0CaASScuMeWQAQ6FJ
 sRZ7OYMBiWKZmLqXdFBjfSINfCLgO0RwFMnBxgpV3wjXEkPeV9HrdL5vrZeN3lEP4Ddv
 JAmyEHQsCq8AQ9lOwo9cqvSPQC067FHHNLxO6/SgGiygjS9JkzSsHpSyVG7LYpTlw2oE 7w== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfgmc08ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 19:23:56 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35QJCquj027900;
	Mon, 26 Jun 2023 19:23:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
	by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45cm24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 19:23:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35QJNsGL50069850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jun 2023 19:23:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44AF258056;
	Mon, 26 Jun 2023 19:23:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A6225803F;
	Mon, 26 Jun 2023 19:23:54 +0000 (GMT)
Received: from [9.24.4.46] (unknown [9.24.4.46])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jun 2023 19:23:54 +0000 (GMT)
Message-ID: <73a55db3-1298-9db7-3a81-f34f86587bfe@linux.ibm.com>
Date: Mon, 26 Jun 2023 14:23:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
 <20230624151911.7442620c@kernel.org>
 <25e42e2a-4662-e00a-e274-a6887aaae9d6@linux.ibm.com>
 <20230626103305.3d8bb0b5@kernel.org>
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <20230626103305.3d8bb0b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c2ePt-j0pjHBwNxdNBJZhGLNafZSMpOb
X-Proofpoint-ORIG-GUID: c2ePt-j0pjHBwNxdNBJZhGLNafZSMpOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_16,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/26/23 12:33, Jakub Kicinski wrote:
> 
> If packets can get stuck in the driver that needs a dedicated fix.
> 
> You should only be doing the batching if xmit_more is set, really.
> And xmit_more will not be set if core is about to set
> __QUEUE_STATE_STACK_XOFF.
> 

I am not saying that packets can get stuck in the driver, if xmit_more 
is false or if the driver is hard resetting then the batch gets sent.

During nonfatal reset, we are simply reestablishing communications with 
the NIC and it is okay to keep the batch around. It is possible that 
there are batched skb's because xmit_more and the non fatal reset work 
independently of each-other and are not mutually exclusive. The upper 
level functions have no way of knowing when an issue from the NIC will 
occur.

> With a correctly written driver STACK_XOFF can only be set if we're
> expecting a completion.
> 
> AFAIU you shouldn't have to clear this flag. We need to reset DQL when
> hard resetting the queue because we may lose completions. But if no
> completions are lost, STACK_XOFF should be left alone.
> 
> Just clearing that flag is not valid either because qdiscs will not be
> rescheduled, so until some socket tries to xmit next packet the data
> already queued will not move.

This addresses my concern. So if STACK_XOFF gets set, then xmit_more 
will be false and our batch will get sent. This will eventually lead to 
a completion which will clear STACK_XOFF. Meaning the reset should not 
have to worry about clearing STACK_XOFF.

My worry was that STACK_XOFF would get set when the batch was only 
partially full and xmit_more was true. If a non fatal reset occurred 
here then there would be no expected completions and a partially filled 
batch. So I thought we would have to clear STACK_XOFF in order to get 
the queue to be usable again. Sounds like this is not possible due to 
xmit_more being false if STACK_XOFF gets set.

On 6/26/23 14:06, Rick Lindsley wrote:
 >
 > Nick, do we *need* to have __QUEUE_STATE_STACK_XOFF cleared?  If not,
 > then do we need to call or emulate netdev_tx_reset_queue() at all on a
 > non-fatal error?

After reading Jakubs review. I believe we should remove the part where 
we clear STACK_XOFF.

If there are no objections, I will test these changes and send a v2.

Thanks

