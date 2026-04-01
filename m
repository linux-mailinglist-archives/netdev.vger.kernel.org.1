Return-Path: <netdev+bounces-274017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANVDI/HszGknYAYAu9opvQ
	(envelope-from <netdev+bounces-274017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:01:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F637824D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0918E304B5AC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F43B7B98;
	Wed,  1 Apr 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dd4ae1l1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926B3AA1AF;
	Wed,  1 Apr 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036729; cv=none; b=irFkEQv4PMAy9gZeBGMJ1xLMyVsmjBGBA4kJidzCSZYULl0NZioUQuAYxTEyuTVyTDM6Q9/JeYHgc8cmUx8fEJjiIZNtpv1FlAeKEDBgDMZi/BTu5WSX69Ge4lwJuPKqfpeJxmw4CTEO56Xdvw5bFsgKNEZ1ao011KMlH9Dpfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036729; c=relaxed/simple;
	bh=61MHq/oSmTyfxROyxDxb2FLztK8J9aKtPb1TcmhRq6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjT+mh3LJgP0KzZhrOvkmkKDGDL5cceTECb5HDhiCZg2CDeeVp6CioTG9R4/IkvXifack+yOIO0wCIiZ9wfkMFyEjURfAce5cbDr/chEWjndLvjOwBaOtuXqWMCOaK9i69SMLU9wrhX5E+1CfkESekCbYKAAGGzBZBg8G9gdc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dd4ae1l1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VKXkSd503870;
	Wed, 1 Apr 2026 09:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DINzeq
	yQ1Za8+xRU681HKpBThDG4hkvfZE2EN49/ADU=; b=dd4ae1l1M/o6Fhhb0OWDun
	XtjN4t9BnL5QDpSb4ejaW/0nm6CUidJrelua/k/lFhz6Oo/GuxIwR1WyZ+oMrX6A
	taa80lTlBBL70VYgH/O73VNOJzufjAsHT3XJz38hxb6d1pEbH3QqifbeGNenNO9o
	fzqjUDOAM2Qv29MqL8Izmw5l8/Whj80m2LwrDnmOYKtJm6vet3UfqQyBZ1v9Pn2L
	ycJHzj39OVQA74psaa7z9WWsVxSZh2rALcf6ONRhR4dMF4mj94gCu14kf+PuuU/z
	RNeTrDum8ZV348VR/mphKicgNskKTuwqPr+qL7eaModgqYv5kQ+uMGy2Yc1VDmXQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q37esu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 09:45:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63182bEg030955;
	Wed, 1 Apr 2026 09:45:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjvtqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 09:45:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6319imAj19333840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 09:44:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2ACB5805D;
	Wed,  1 Apr 2026 09:45:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C3E5805A;
	Wed,  1 Apr 2026 09:45:11 +0000 (GMT)
Received: from [9.111.188.215] (unknown [9.111.188.215])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 09:45:11 +0000 (GMT)
Message-ID: <4482aca9-c789-433f-8e5e-614f1cda1041@linux.ibm.com>
Date: Wed, 1 Apr 2026 11:44:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/zlib: use atomic GCOV counters to prevent crash
 in inflate_fast
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Vasileios Almpanis
 <vasileios.almpanis@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260330143256.306326-1-khorenko@virtuozzo.com>
 <20260330143256.306326-2-khorenko@virtuozzo.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260330143256.306326-2-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0kRGXpwT1WuRhB0uYVM88_aZJf-hVcIc
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cce92a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=TYBLyS7eAAAA:8
 a=ls0vK1wJkvJ14NcqKr0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-ORIG-GUID: 0kRGXpwT1WuRhB0uYVM88_aZJf-hVcIc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4NCBTYWx0ZWRfX0OgtmSxLut0D
 vaIUIFMn3myuFiiLCJ/8E1CgRBvNNGre5mH7/jdHJgWTCsSRoqB+z3L9rXoe3W2at22B1N4SGaE
 sDLfB6kIAyFpZvSfFMgZ8Xs3NkBhQzWHjF9IxVCsXPSDcvSFhTSQ/9Zhim1AvE0bUrnP+u0DgdG
 VaWYMoCX1WaPzNjwuEJXWY4p581BprMPaHf5vFte1YSi8FlabgibOa+yzSnaVm4P+hZLiYUybMk
 VYuflET3chIqKgRqj2cC250du/pmdZ0FPsWxa91OXsJOO5Y/pdnYfnXgeFP8ulDHLC1dImhO9gd
 HEi0px8IOVv3UY4ft/z70AtMeAYPK91QY+J15TaSjRzflEgHBN2O5stKlk+H2wODIT960vqAmV5
 XDUCOwStJEDlz+RK28sn1qG63kFA+5oNaQh0pRQjefFDicVEa0Tgf/Nozz664OvrB4ZIOn/vzT7
 KiH1WRvTdCtnNsUv3zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010084
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274017-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,virtuozzo.com:email];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[oberpar@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 115F637824D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30.03.2026 16:32, Konstantin Khorenko wrote:
> GCC's GCOV instrumentation can merge global branch counters with loop
> induction variables as an optimization. In inflate_fast(), the inner
> copy loops can be transformed so that GCOV counter values participate
> in computing loop addresses and bounds. Since GCOV counters are global
> (not per-CPU), concurrent execution on different CPUs causes the counter
> to change mid-computation, producing inconsistent address calculations
> and out-of-bounds memory writes.
> 
> The crash manifests during IPComp (IP Payload Compression) processing
> when inflate_fast() runs concurrently on multiple CPUs:
> 
>   BUG: unable to handle page fault for address: ffffd0a3c0902ffa
>   RIP: inflate_fast+1431
>   Call Trace:
>    zlib_inflate
>    __deflate_decompress
>    crypto_comp_decompress
>    ipcomp_decompress [xfrm_ipcomp]
>    ipcomp_input [xfrm_ipcomp]
>    xfrm_input
> 
> In one observed case, the compiler merged a global GCOV counter with the
> loop induction variable that also indexed stores. Another CPU modified
> the counter between the setup and iteration phases, causing a write
> 3.4 MB past the end of a 65 KB buffer.
> 
> The kernel already uses -fno-tree-loop-im for GCOV builds (commit
> 2b40e1ea76d4) to prevent a different optimization issue. That flag
> prevents GCC from hoisting loop-invariant memory operations but does
> NOT prevent the IVopts pass from merging counters with induction
> variables.
> 
> Add -fprofile-update=atomic to zlib Makefiles. This tells GCC that
> GCOV counters may be concurrently accessed, causing counter updates to
> use atomic instructions (lock addq) instead of plain load/store.
> This prevents the compiler from merging counters with loop induction
> variables. The flag is scoped to zlib only to minimize performance
> overhead from atomic operations in the rest of the kernel.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> Reviewed-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

I'm all for introducing -fprofile-update=atomic to GCOV CFLAGS as it not
only addresses this bug, but makes coverage data more consistent
overall. My only suggestion would be to apply it at global scope
(top-level Makefile), not restricting it to zlib alone. Since
GCOV-instrumented kernels already have a significant performance hit due
to the added profiling code, this side-effect of using atomic
instructions can IMO be safely ignored.

Unfortunately, while compile-testing this suggested change to the global
Makefile, I ran into the following build assert which needs more
investigation:

net/core/skbuff.c:5163:9: note: in expansion of macro ‘BUILD_BUG_ON’
 5163 |         BUILD_BUG_ON(skb_ext_total_length() > 255);


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

