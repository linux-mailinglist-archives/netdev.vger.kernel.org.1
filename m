Return-Path: <netdev+bounces-14045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17273EADF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B79280E6E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858C134D5;
	Mon, 26 Jun 2023 19:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7CC155
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:06:22 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08397
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:06:21 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QImC2i022881;
	Mon, 26 Jun 2023 19:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : subject; s=pp1;
 bh=nV3+4uIZ1t0ypUT6dt1g2EdpvmgastWw8MEPoThD0/I=;
 b=lz+lUbxLymACveCoxsvZcwMYBFBnXABdOwGOHMHEJ94RIMENK7m3iGKHXX69dRnigIwn
 3HGZ3WucuILaV3Gxhi8HPBXkyuMkcNdXoF0F6KfOOriySSJB1GqnWeRsmQBt6oChkmcQ
 mwojW2ywWOFikykvQVcitQwioPg+zMj7C16xngSSv97ENccFfvxkzUL8lTBskIhvz8XN
 BSBwtotcpnzQT5jjTKBIFq7k++G9HjazlqTOV3E6M+KipW/Oxt2at5W08ybSWmNfDgh4
 V/0cJGhP+kolV3/fcEsuL8KQjEVchoOpcMPzbxJ1bpxd1ctu980QrB+fwtVuuWxFkOgA Uw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfg96gf57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 19:06:14 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35QHMwW8020457;
	Mon, 26 Jun 2023 19:06:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
	by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rdr45ueuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 19:06:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35QJ6BbY63766994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jun 2023 19:06:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAD6E58052;
	Mon, 26 Jun 2023 19:06:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893255805D;
	Mon, 26 Jun 2023 19:06:10 +0000 (GMT)
Received: from [9.61.91.250] (unknown [9.61.91.250])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jun 2023 19:06:10 +0000 (GMT)
Message-ID: <277ca0b3-32df-532f-e82f-a7d42dce54ab@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2023 12:06:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
 <20230624151911.7442620c@kernel.org>
From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
In-Reply-To: <20230624151911.7442620c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFaNfZkHj9GqsZ9CZd7raymC4c2M-1hL
X-Proofpoint-ORIG-GUID: uFaNfZkHj9GqsZ9CZd7raymC4c2M-1hL
Subject: RE: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_16,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/24/23 15:19, Jakub Kicinski wrote:

> Why are you trying to clear this bit?
> 
> If the completions will still come the bit will be cleared (or not)
> during completion handling (netdev_tx_completed_queue() et al.)
> 
> Drivers shouldn't be poking into queue state bits directly.


+		if (adapter->reset_reason == VNIC_RESET_NON_FATAL)
+			clear_bit(__QUEUE_STATE_STACK_XOFF,
+				  &netdev_get_tx_queue(netdev, i)->state);
+		else
+			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));

The problem is the call to dql_reset() in netdev_tx_reset_queue().  If we reset dql stats,   we risk num_completed being greater than num_queued, which will cause a BUG_ON to fire in dql_completed().

     static inline void netdev_tx_reset_queue(struct netdev_queue *q)
     {
     #ifdef CONFIG_BQL
         clear_bit(__QUEUE_STATE_STACK_XOFF, &q->state);
         dql_reset(&q->dql);
     #endif
     }

Existing code calls  netdev_tx_reset_queue() unconditionally.  When the error is non-fatal, though, we were tripping over the BUG_ON on those occasions when a few skbs were already submitted.  The patch here is more about NOT calling dql_reset() than it is about clearing __QUEUE_STATE_STACK_XOFF.  That was only included because it-was-the-other-thing-the-function-did.  So ... maybe we don't care about __QUEUE_STATE_STACK_XOFF?

Nick, do we *need* to have __QUEUE_STATE_STACK_XOFF cleared?  If not, then do we need to call or emulate netdev_tx_reset_queue() at all on a non-fatal error?

