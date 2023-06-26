Return-Path: <netdev+bounces-13979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7873E3D0
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C13280E23
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0208C2F6;
	Mon, 26 Jun 2023 15:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE8D2E7
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:46:01 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A51700
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:45:51 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QFeWVq026955;
	Mon, 26 Jun 2023 15:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PXd0zt9v4DLe8BgTWclPxjt5aWCb511wnx6MfMkAnGM=;
 b=jG/9AKWXTnMTLfxZaXvw/hCXvzfwaVGsqZIPYEiK7ohsn9dRDfqefq9+TUMPJcUsVc+H
 +OVSlFUp/kabQOvJRU/haYaG4zJcKoB9ZVO5k+jWpgBQsmFoev0NENx8bD2kduPmBgcB
 BjCBbRYoYzSnjoEusA1mbmXH6g7OA8pyJTXZ3ayQH/iB0iDjvojP2BO9DEtAJY4ImZ/h
 RlP/DfYO4p6+0gir44gnGskQ6j6vPaSfwozNmyygvOuCTBkMYTY6+ogmeRco+lZDPdYC
 h+wuspU/T3T8KJXvA6DGDazzFVcaX1El5ZmkBkwQFdLA51oTMdr8gVjzrvu6P2qpmWpk lQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfd618k06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 15:45:41 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35QF7UGk011033;
	Mon, 26 Jun 2023 15:45:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3rdr46j9h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 15:45:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35QFjcox27001348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jun 2023 15:45:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAD758056;
	Mon, 26 Jun 2023 15:45:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE0C5803F;
	Mon, 26 Jun 2023 15:45:38 +0000 (GMT)
Received: from [9.24.4.46] (unknown [9.24.4.46])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jun 2023 15:45:38 +0000 (GMT)
Message-ID: <25e42e2a-4662-e00a-e274-a6887aaae9d6@linux.ibm.com>
Date: Mon, 26 Jun 2023 10:45:38 -0500
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
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <20230624151911.7442620c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hlAS6s3Cw6IWlhpzYRGX2fgGyuQQEL2I
X-Proofpoint-ORIG-GUID: hlAS6s3Cw6IWlhpzYRGX2fgGyuQQEL2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_13,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/24/23 17:19, Jakub Kicinski wrote:
> On Thu, 22 Jun 2023 14:03:32 -0500 Nick Child wrote:
>> +		if (adapter->reset_reason == VNIC_RESET_NON_FATAL)
>> +			clear_bit(__QUEUE_STATE_STACK_XOFF,
>> +				  &netdev_get_tx_queue(netdev, i)->state);
> 
> Why are you trying to clear this bit?
> 
> If the completions will still come the bit will be cleared (or not)
> during completion handling (netdev_tx_completed_queue() et al.)
> 
> Drivers shouldn't be poking into queue state bits directly.

Most likely, yes there could be some bytes that will get a completion 
which would clear this bit.

That being said, it is also possible that all bytes sent to the NIC are 
already completed. In which case we would not get a completion. The 
ibmvnic driver sends its skb's to the NIC in batches, it makes a call to 
netdev_tx_sent_queue on every time an skb is added to the batch. This is 
not necessarily every-time that the batch is sent to the NIC.

I am not sure what number of bytes causes dql to set 
__QUEUE_STATE_STACK_XOFF but I do know that it is possible for up to 15 
skb's to be sitting in the queues batch. If there are no outstanding 
bytes on the NIC (ie not expecting a tx completion) and the internal 
batch has 15 references per queue, is this enough to enforce dql and set 
__QUEUE_STATE_STACK_XOFF? If so, then we must clear 
__QUEUE_STATE_STACK_XOFF when resetting.

I had a feeling this would raise some eyebrows. The main intent is to do 
everything that netdev_tx_reset_queue() does besides resetting 
statistics. Setting a "*STACK*" flag in driver code feels wrong 
(especially since a *DRV* flag exists) but I could not find an 
appropriate upper-level function. I suppose an alternative is to read 
this flag after the device finishes the reset and sending the batch if 
it is set. Is this any better?

As always, thanks for the review.
Nick

