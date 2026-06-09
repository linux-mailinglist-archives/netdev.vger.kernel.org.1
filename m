Return-Path: <netdev+bounces-297084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id amveJAspKGow/QIAu9opvQ
	(envelope-from <netdev+bounces-297084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7249661615
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=QCzGJrcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297084-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297084-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A296B31A1025
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77934D4E2;
	Tue,  9 Jun 2026 14:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F834165B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:33:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015598; cv=none; b=pVRRZrpkyOYvT3o5ek2tMlQAd1MEv9GWA4lUb1NFJrrYZZPipkPKxhCV2DmP3JfMllAdo24SiiHljPg6Yfc5JfPPqvxRBEoRMRz7ZT0vrauR6QQ+lMC69TsyN94s58J93/pgzeniIEFI/Qa0KjMSJP+y74TEMubk3Q39CrEpSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015598; c=relaxed/simple;
	bh=zPgr6yEqFCItOp7qEwBbRG3Hy3JQh/qbZNkIEK5EN2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Umpf4i2URTOSpV0l0k9ogZFBzQKWM7vnP4Tofv5fIML/IMxD9loT5t/aZfTBb67NoLzBvBSECDmDiYF1YyFqi/9gpFvABiQyPguGwNJVK/PL3+V/J37/P2yh2JFl1uAxP7YA/dtTUm6nLa0Fv41scWebBJGvemTfW0BeWblloLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCzGJrcC; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595EfSA3019572;
	Tue, 9 Jun 2026 14:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GpS3vA
	aOTTDMmWjoOLBnXrI1AoDUD047jdcfwj6uSow=; b=QCzGJrcCg32n5PIMde6dP3
	SzeT63v9+c6s6YfSzhe4mhtMe6TpNjKS65IUdwjKYatuL93iB6goIGUqcez62eBU
	/Jcvk2L3Eo9ioLf8rZolDYT6ROAor6NUGFBEAnt/iOxBUEei5Bgw1mQZVDomIk2V
	dXyjwzSZb3nHI/W09y6tjqD6oBG82qzzW12mQeksb6Ls56caW8NsmItiCzHhusGM
	YZB8t0pJA+LjuDfj4rEpDpBsiGCw20wm95ZMk+qM1o+hy7UGRmfx7XZJAI18fe1w
	rBsFy5MsiHCQscgevdJE1ZZ3HA5M7wT8X0ta8NOlqkCsVlWogs5rcx/xoAn8e6Aw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qmm6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:33:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659EJaI5031182;
	Tue, 9 Jun 2026 14:33:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g273m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:33:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659EX7MU34734520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 14:33:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E8322004E;
	Tue,  9 Jun 2026 14:33:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F6D2004B;
	Tue,  9 Jun 2026 14:33:07 +0000 (GMT)
Received: from [9.111.155.143] (unknown [9.111.155.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 14:33:06 +0000 (GMT)
Message-ID: <4aa93507-8587-4b16-b81e-54a2a967c60c@linux.ibm.com>
Date: Tue, 9 Jun 2026 16:33:06 +0200
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
 <8b0ca410-491f-4fda-af67-41b1a78c5cf7@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <8b0ca410-491f-4fda-af67-41b1a78c5cf7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a282426 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=o8dFRQB0AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4QYngW9aaQOuVnSYWv8A:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=D5cU4ZU6l4KboW5xFU7l:22
X-Proofpoint-GUID: f4YYZk4vn5xJ9CEJHXzq0KUX6bsRkWtc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzNCBTYWx0ZWRfXxE8Zu720Fd3r
 e/zxtU8PCgsM8fJsWlBfwbFykXCkGNUXD7n0JARgqvAaqHZVzDUHjEorf2Ui3pdo/5UuxAMVaqb
 Rr/bJdjnkG6GmA8Dh27ltwaoSuvT6mCyBtJ0iZQNsxtbmGcFa8PdFaUTwe0CAQpKgapmFpgFlX3
 gh7mHpwrJqjFV2WOBmNkrBbaV143xZmRBBys3UBOcjKgVdrIxMSXTEiZFGgbWRaprBkJzOIQYAA
 Cxe3GoyM8BhRBebisFh+SPYzrTi95m/aA4Sqh8BSMxs8NKyf/xtNvO3CQ/kZGunusBcYZCtFz3e
 gyqY0JnnHyy8UXFt+mw4t+IRb25662ez4nocRaUfVzetMCdMOn7CQGqhyvaIhZLFDuLI5uoQRuo
 epUAzaHjFG2y7p2ztqO58wIbHfSmGqqq79dv1hkrLg3z0kNR1PhUa916bFaJNr1Bf/eiQ4Cla4j
 yPfE5HsDde4KgZQJpCw==
X-Proofpoint-ORIG-GUID: GB9-wJNeRzoZUTjSRTHC2AxqRDw8NF69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297084-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,rexion.ai:email];
	FORGED_SENDER(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rc@rexion.ai,m:netdev@vger.kernel.org,m:alibuda@linux.alibaba.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7249661615



On 01.06.26 15:51, Alexandra Winter wrote:
> 
> 
> On 29.05.26 15:11, Alexandra Winter wrote:
>>
>>
>> On 29.05.26 09:08, Rahul Chandelkar wrote:
>>> From 68f633e58deb6edffa435a3b2bdc4a12a5e36daf Mon Sep 17 00:00:00 2001
>>> From: Rahul Chandelkar <rc@rexion.ai>
>>> Date: Fri, 29 May 2026 12:32:34 +0530
>>> Subject: [PATCH net] dibs: fix use-after-free in dmb lookup functions
>>>
>>> dibs_lo_attach_dmb(), dibs_lo_detach_dmb(), and dibs_lo_unregister_dmb()
>>> all release read_lock_bh before operating on the dmb_node pointer found
>>> during hash table lookup. A concurrent unregister on the same token can
>>> kfree() the node in this window, causing a use-after-free when the
>>> original caller subsequently performs refcount_inc_not_zero() or
>>> refcount_dec_and_test() on the freed object.
>>
>> As discussed off-list, there is no such problem in the current kernel, as there
>> is no such caller.
>> I fully agree that this should be improved, but this should go to [net-next]
>> as an improvement without a Fixes tag. (This matters, because it removes
>> the burden of backporting, porting to Stable etc..)
>>
> 
> 
> Giving it some more thought, I think there could be such a race, when server and
> client shutdown the smcd connection at the same time.
> 
> 
>>>
>>> Fix by performing the refcount operation while still holding read_lock_bh,
>>> so the node cannot be freed between lookup and use. Release the lock
>>> before any code path that may call __dibs_lo_unregister_dmb(), since that
>>> function acquires write_lock_bh internally via hash_del().
>>>
>>> Fixes: cb990a45d7f6 ("dibs: Define dibs loopback")
> 
> Actually this mechanism was introduced with
> c3a910f2380f ("net/smc: implement DMB-merged operations of loopback-ism")
> 
> cb990a45d7f6 only moved it into the dibs layer.
> 
> With that:
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> 
>>> Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
>>> ---
>>
[...]
> 
> Future work:
> I think attach/detach_dmb() in dibs_lo have more scenarios where robustness
> could be improved. e.g. when a does unregister_dmb() but not detach_dmb().
> I don't like it, that in such a case, after successful unregister_dmb(),
> the dmb is still in the hash table,  can still receive data, trigger
> receive interrupts (move_data()), be target of attach_dmb(). Wen Gu, Tony
> Lu, what do you think about that? Maybe that can even happen in SMC-D
> today?
> 
> Maybe a get/put mechanism with release function would be appropriate, where
> dibs_lo_unregister_dmb() does everything but freeing the dmb_node.
> 
> 
> On a similar note, I think Shashiko is right with her second comment:
> Link: https://sashiko.dev/#/patchset/4gRZFl1CWvz2x9j%40mail.spacemail.com
> "Looking at dibs_lo_move_data(), it reads rmb_node->sba_idx while holding
> read_lock_bh(&ldev->dmb_ht_lock), then drops the read lock before acquiring
> spin_lock(&dibs->lock) to look up the client ID:
> drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
> 	...
> 	sba_idx = rmb_node->sba_idx;
> 	read_unlock_bh(&ldev->dmb_ht_lock);
> 	if (!sf)
> 		return 0;
> 	spin_lock(&dibs->lock);
> 	client_id = dibs->dmb_clientid_arr[sba_idx];
> 	...
> }
> Between dropping the read lock and acquiring the spinlock, could the dmb be
> completely unregistered by a concurrent thread, and its sba_idx reallocated
> for a new dmb belonging to a completely different client?
> If so, would the function read the new client's ID and erroneously call its
> handle_irq handler?"
> 
> 
> 

Rahul,
what are your plans with this patch? Will you send a v2?

See
https://patchwork.kernel.org/project/netdevbpf/patch/4gRZFl1CWvz2x9j@mail.spacemail.com/

the current version does not apply on net.



