Return-Path: <netdev+bounces-293116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFykGamQGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B4602B5A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FBC03006819
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247B30FF08;
	Fri, 29 May 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vn+7Nbq5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1D2E62AC
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060327; cv=none; b=sMLeGVpNdZkmASm1mWfRKZ+0Qp/lYW8fnvidnjJ4xxkKUnskh0YNjVSHj8eXlc9Xau54lEn3A+XjuDmjVeUU1HWxVwI+XPIAhsbDCicY8aWOVegSPTkgR4g21JAjw80Aj2NAnb38MHHxVHphL/XE5WH2M/1mOnynhtgVvi2ChuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060327; c=relaxed/simple;
	bh=GwEX9eJtbQ5wJgfzBC7aMO5ke+5Npe3dr7tSzbUM8vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPWznlRMiIj25VdVa3YgAdeOsyOp0wKMeh067UMR9WSPqOwTL85Qs0YFe2Hhj8J+xp3Sq1nST2oCdAtQKzngU5nwZtcZLQTfPdfSsG975llwQHptZoX2VgG9pgnYFJM0StGo4RZXnCP+kV3YhAXZeOOgUYexsDGSrcEGd10ok1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vn+7Nbq5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TB8QrT1684674;
	Fri, 29 May 2026 13:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bxcfn8
	qam8vTfArNXS1k+iRr/pG/sDyKUfOEy2BYxfk=; b=Vn+7Nbq5GZyoQIwSjd/HRO
	bOSMW8YSn05RZi91yxOKkfvRefr9n7lDxmSo4uHcLOk+qxn2LeOslzFnUmdo6aG9
	f+51MWoLsDhmDhfQYj85BjaeKgcOm000bBcYg9LLkl0BOVHyIivebmlEo/VyK+vU
	l+HVjvmhX1klXiPeJd2sJMcky20DHoinbEPoS8McmKyeSOCoruhublttQuyfMPWe
	kK63gTeqVqgP63GK57zcDdI/TjkJFiHQ+zkY4hiXtsMHTHnq/V/Mg5yH1/kbdP27
	G9rPGqtbF8EOpsLGJw4OSNAEmA5iH21n13sUcbkHqAWn+qO678wntJVwMT89DEvQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884gsp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:11:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TD99bA027224;
	Fri, 29 May 2026 13:11:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdq0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:11:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDBpE728770768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:11:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C763D2004D;
	Fri, 29 May 2026 13:11:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07C62004B;
	Fri, 29 May 2026 13:11:51 +0000 (GMT)
Received: from [9.111.212.140] (unknown [9.111.212.140])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:11:51 +0000 (GMT)
Message-ID: <f664f9ca-30b5-404d-9b3c-268d8dbf2bcb@linux.ibm.com>
Date: Fri, 29 May 2026 15:11:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: fix use-after-free in dmb lookup functions
To: Rahul Chandelkar <rc@rexion.ai>, netdev@vger.kernel.org
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
References: <4gRZFl1CWvz2x9j@mail.spacemail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <4gRZFl1CWvz2x9j@mail.spacemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19909a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=84fQ698N_ZbQe8IxvQMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3DjxdjLos7bGWS1RwbLW2vRcv5QZo-y8
X-Proofpoint-GUID: JJRGqGpWEkwJI3haBm71VP8eWgFbP04P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzMSBTYWx0ZWRfX6CTG5kVDMYU5
 QDZpY8bPhulWzPhPGbfKOBVJzx6/j3QZoBFG1GQSCj8JScI9FdafZWG0y+XvaWWHEqSHJsu57d5
 Tk94Lg9YWrdce40MTPSWqxFbEIkZwuv7PXjIPldVE7+q081MQIojHnnKz/nZpJsdta5YWq2je8o
 FZ8gJB295WvJSjl1nOYV++hTUQ3YTmpyAaPXAhPYJC0WXRhkVYh3tmuLkoHZ/YBm0R9ZNL7xJI4
 9QuXplKrYhR9WmdEfJjlh6qmvY2y106GL6fNFboJVUeJopkxT4vRJ2KHbjkOmfJruXq97FLWwIF
 pS7O/y4GisoIhPSWLvReZNNrnk1FDCYeOCc5JU5VWdlGFZD6qvkgTwW5a9aw/Y3E/0Atr0NBxEe
 FJu87ha3XPPxBlzzpr5+yDkz8D/4gtQ7lXR6l2zNeUu+jBMEsqI4tBDh5FyjPORrOsVDwl9BNuh
 z8AMFL+v7MXiPgyEGqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290131
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293116-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rexion.ai:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 059B4602B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 29.05.26 09:08, Rahul Chandelkar wrote:
> From 68f633e58deb6edffa435a3b2bdc4a12a5e36daf Mon Sep 17 00:00:00 2001
> From: Rahul Chandelkar <rc@rexion.ai>
> Date: Fri, 29 May 2026 12:32:34 +0530
> Subject: [PATCH net] dibs: fix use-after-free in dmb lookup functions
> 
> dibs_lo_attach_dmb(), dibs_lo_detach_dmb(), and dibs_lo_unregister_dmb()
> all release read_lock_bh before operating on the dmb_node pointer found
> during hash table lookup. A concurrent unregister on the same token can
> kfree() the node in this window, causing a use-after-free when the
> original caller subsequently performs refcount_inc_not_zero() or
> refcount_dec_and_test() on the freed object.

As discussed off-list, there is no such problem in the current kernel, as there
is no such caller.
I fully agree that this should be improved, but this should go to [net-next]
as an improvement without a Fixes tag. (This matters, because it removes
the burden of backporting, porting to Stable etc..)

> 
> Fix by performing the refcount operation while still holding read_lock_bh,
> so the node cannot be freed between lookup and use. Release the lock
> before any code path that may call __dibs_lo_unregister_dmb(), since that
> function acquires write_lock_bh internally via hash_del().
> 
> Fixes: cb990a45d7f6 ("dibs: Define dibs loopback")
> Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
> ---


Thank you very much for this patch, please allow for some more days
for me to review and test it.



