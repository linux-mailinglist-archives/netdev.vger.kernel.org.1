Return-Path: <netdev+bounces-293780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP40Ll+QHWrFbwkAu9opvQ
	(envelope-from <netdev+bounces-293780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888F620698
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FED301703E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64B3A7D7A;
	Mon,  1 Jun 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RF/Azz/t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684137B00C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321898; cv=none; b=bWEf66uoYWx15Vs00s7Tm9CQhs0K2VWg9xsmsAV0UNf2V0t5vxc9lUtJ2M8/pTZVvlVMXC0BJrdJ5MYjjlmkKaGLrq1YmkK9l9CJe0VlsWmYreC+uLFEKqOovcRwMGadAx7KYgoW2I4rVksww4gtF/RbDNF2THDRzrt9Q0hIn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321898; c=relaxed/simple;
	bh=n/vuqvgmMRDc6a1lNpRqYtC3rfX78JPfkr/JRHkRO9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZPI9Q1urreACe1PYbBwvbdBjkJM/7+HO3tDIhlhCzDIIcdUQvvMmUqPlQgkL1RFvoDdEZvAza1FoKvEptYNDd/iM6u+FQ1w5grubEoT3Ho1fpNu4rf95NigFoX1Z/kFOVgQ5Jcx70/IeVjH+/BLNYWim75wM6hbZCDiJyG7O7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RF/Azz/t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518XBP03018752;
	Mon, 1 Jun 2026 13:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sg6+jA
	pEuLzKSz1txvwPGn2We5s6f6zV4pUj8XpphTY=; b=RF/Azz/tm7SOrBZHQSEUFg
	ZCKTbEV60InIVbAlh1qaQY4KGd5KOsovqAY5Fu2zOL0eT9OdlZnIYhezsV3j+ptE
	bWJtJgdIG/tfY7mBxpQYYvu5xrJKGF9RT6Y3oEQjS9CuPbM0id27zbSXboSSFMwj
	UJbYxxxiIR2TATfXXssV1RDXruTJ8Zlt+OPKtHEjntSlCahXuGMmE55hHQUgPqUQ
	eVWTs8wX+2ObLitXVC0hHDjcywrGiAYv7q9wk9n+oY2btEZNmtekgJkL0Ce2AzCK
	gd6LCX/9MJntdNSvI9xe9hLURakrDDL0rB9iJhP0++AXCKNJgWLrleP5JGwxFRDg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4ryqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:51:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Dd5GF004858;
	Mon, 1 Jun 2026 13:51:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxcm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:51:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DpM8W28967400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:51:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E46F2004B;
	Mon,  1 Jun 2026 13:51:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C5420043;
	Mon,  1 Jun 2026 13:51:22 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 13:51:22 +0000 (GMT)
Message-ID: <8b0ca410-491f-4fda-af67-41b1a78c5cf7@linux.ibm.com>
Date: Mon, 1 Jun 2026 15:51:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: fix use-after-free in dmb lookup functions
From: Alexandra Winter <wintera@linux.ibm.com>
To: Rahul Chandelkar <rc@rexion.ai>, netdev@vger.kernel.org
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
References: <4gRZFl1CWvz2x9j@mail.spacemail.com>
 <f664f9ca-30b5-404d-9b3c-268d8dbf2bcb@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <f664f9ca-30b5-404d-9b3c-268d8dbf2bcb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5BEhAsof6nzEHvltF5CrWWaqmzYqUu4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNiBTYWx0ZWRfX4pTA1qnqmVub
 GdkwQHld8WgHP9cX5RpeqJ3UOeDggoBO8a5xoGsXgOnjEnKYS88NVu2qCYj234AkZa/W7mytioz
 iA/CG7Bx2Xgm3iF8oz8qFG/OZ9e1CS4T+YfwcDPPhlsLWoVOIMUF45GTdCI8oXJr2bF3s6e0i5D
 52dSOjAf3WohT+Znn36GZM1fPgHa2Zp6Qx5M90RX8w3CKraMgjIew74QPEln2o0xfBxNX1VL/5E
 LcqPyFaAUIprcn5UyL39WqqjBjBWmXRUoWKf64rHPOhzXYKs21oU8GOcCdf9+G33JaLRlLIX4qm
 aaFua+lMEv5xq/Z1soX0KfhKLRJU7gVGyRjjWGK1jPVmmjZlFkxnZzcu7qAIAD1dFLa819AAcFv
 O2tyIM4MrQNCB9y1idVXG43zStLfx5QYY/LOsEtKIv+T2y2wJ6ijxS+zVgIZy13jj2jlB+IrxJA
 eYZeey6//FFAGrl06Cg==
X-Proofpoint-ORIG-GUID: OwmvcPWUDWrxUSc1Y_ri7niduE-jb_3S
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1d8e5e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=o8dFRQB0AAAA:8 a=VnNF1IyMAAAA:8 a=kKOoNwnkk6QzUYzkeeIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=D5cU4ZU6l4KboW5xFU7l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293780-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,sashiko.dev:url,rexion.ai:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1888F620698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 29.05.26 15:11, Alexandra Winter wrote:
> 
> 
> On 29.05.26 09:08, Rahul Chandelkar wrote:
>> From 68f633e58deb6edffa435a3b2bdc4a12a5e36daf Mon Sep 17 00:00:00 2001
>> From: Rahul Chandelkar <rc@rexion.ai>
>> Date: Fri, 29 May 2026 12:32:34 +0530
>> Subject: [PATCH net] dibs: fix use-after-free in dmb lookup functions
>>
>> dibs_lo_attach_dmb(), dibs_lo_detach_dmb(), and dibs_lo_unregister_dmb()
>> all release read_lock_bh before operating on the dmb_node pointer found
>> during hash table lookup. A concurrent unregister on the same token can
>> kfree() the node in this window, causing a use-after-free when the
>> original caller subsequently performs refcount_inc_not_zero() or
>> refcount_dec_and_test() on the freed object.
> 
> As discussed off-list, there is no such problem in the current kernel, as there
> is no such caller.
> I fully agree that this should be improved, but this should go to [net-next]
> as an improvement without a Fixes tag. (This matters, because it removes
> the burden of backporting, porting to Stable etc..)
> 


Giving it some more thought, I think there could be such a race, when server and
client shutdown the smcd connection at the same time.


>>
>> Fix by performing the refcount operation while still holding read_lock_bh,
>> so the node cannot be freed between lookup and use. Release the lock
>> before any code path that may call __dibs_lo_unregister_dmb(), since that
>> function acquires write_lock_bh internally via hash_del().
>>
>> Fixes: cb990a45d7f6 ("dibs: Define dibs loopback")

Actually this mechanism was introduced with
c3a910f2380f ("net/smc: implement DMB-merged operations of loopback-ism")

cb990a45d7f6 only moved it into the dibs layer.

With that:
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


>> Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
>> ---
> 
> 
> Thank you very much for this patch, please allow for some more days
> for me to review and test it.
> 
> 


Future work:
I think attach/detach_dmb() in dibs_lo have more scenarios where robustness
could be improved. e.g. when a does unregister_dmb() but not detach_dmb().
I don't like it, that in such a case, after successful unregister_dmb(),
the dmb is still in the hash table,  can still receive data, trigger
receive interrupts (move_data()), be target of attach_dmb(). Wen Gu, Tony
Lu, what do you think about that? Maybe that can even happen in SMC-D
today?

Maybe a get/put mechanism with release function would be appropriate, where
dibs_lo_unregister_dmb() does everything but freeing the dmb_node.


On a similar note, I think Shashiko is right with her second comment:
Link: https://sashiko.dev/#/patchset/4gRZFl1CWvz2x9j%40mail.spacemail.com
"Looking at dibs_lo_move_data(), it reads rmb_node->sba_idx while holding
read_lock_bh(&ldev->dmb_ht_lock), then drops the read lock before acquiring
spin_lock(&dibs->lock) to look up the client ID:
drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
	...
	sba_idx = rmb_node->sba_idx;
	read_unlock_bh(&ldev->dmb_ht_lock);
	if (!sf)
		return 0;
	spin_lock(&dibs->lock);
	client_id = dibs->dmb_clientid_arr[sba_idx];
	...
}
Between dropping the read lock and acquiring the spinlock, could the dmb be
completely unregistered by a concurrent thread, and its sba_idx reallocated
for a new dmb belonging to a completely different client?
If so, would the function read the new client's ID and erroneously call its
handle_irq handler?"






