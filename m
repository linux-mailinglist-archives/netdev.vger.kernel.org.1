Return-Path: <netdev+bounces-274197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODr1JEdPzWkWbwYAu9opvQ
	(envelope-from <netdev+bounces-274197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03137E500
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A067830B61C8
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE047AF6B;
	Wed,  1 Apr 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ciPsfua7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085647CC7E;
	Wed,  1 Apr 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062594; cv=none; b=jd1espSPOhXADpKkpguom2NqlCrCEAV6ORgE7hZD9KuCQdI+5S3MuwXyw18izwJzxiFrq6eSyC1enXtRjf4gQD7DHNbK+t/I5lVyttS2MNFzKgcc1kV8IhE2jTAe3s3//af8VeiipZ4gZQKaEF0besSGt+botl2ycQO9vTuuytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062594; c=relaxed/simple;
	bh=rGzIkMjGgut585CN3VOg0XUDnVimGxpKVxfZ7xuFWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz5Htra6LUK4rhm2syq6y7Hto7jfg87mqXXBcMVMAgBUcrxeQL4dlw6I5biYuW5gzHWnIxtRzPEqgn0fgHXpPTt9LHnv3c7rgs/9sYQzv9jyXfhp+d5k2E+nsZLKEFp4Hv9F+eh6oZ4wUU79A/qrFDzVCwJLYKhYDiOsFtaCoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ciPsfua7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319diBc4036177;
	Wed, 1 Apr 2026 16:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OnuL3r
	zlzIEr4MZtc6JVwkA/w4TfoM4dP2yVRbDVUTE=; b=ciPsfua7U5ucNGK+0Ki9oR
	XhPPjkLRkJ7+RfPAyW0buzl7l6B5gDLtunz9oO45LGKL4anCQ4V8d45yCs1JVcHS
	rtlBnzh4CfzkY7AHiteOntAuqxvkGpJJ35pG0Zeo0D7yjhzG7SWLlDlZkl2g+WhW
	gAuzTlFK3kWYMmo2SX3mrbjktw+wjV2L09PBI/4rClt436YwMojMj0n4C561+48i
	deuAvyoRsHrK9CSynXcdJV4puZ4K9+ps8g2ukn6hT8HmEIumyuxr4lgO4aXWL8pk
	V1dl0/7xMobGwdy+xrKoXRxo4acA8shEQhW0dmX6+pExXcT6JcBVT+xQmMbLYasQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms8dwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:56:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631EpJ65005910;
	Wed, 1 Apr 2026 16:56:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy6m2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:56:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631GuK5x31326796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 16:56:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114C65805F;
	Wed,  1 Apr 2026 16:56:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D8F958054;
	Wed,  1 Apr 2026 16:56:17 +0000 (GMT)
Received: from [9.111.188.215] (unknown [9.111.188.215])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 16:56:16 +0000 (GMT)
Message-ID: <007cd524-06c6-47b9-98b4-4ecf4d0ba421@linux.ibm.com>
Date: Wed, 1 Apr 2026 18:55:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] gcov: use atomic counter updates to fix concurrent
 access crashes
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Vasileios Almpanis
 <vasileios.almpanis@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
 <20260401142020.1434243-5-khorenko@virtuozzo.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260401142020.1434243-5-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd4e36 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=TYBLyS7eAAAA:8
 a=VnNF1IyMAAAA:8 a=GFBSSUJuQz_BDAv-O8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1NyBTYWx0ZWRfX5xbjruUR5NtP
 uZCMrRequfOXapSg5i/7qT2kpk8wRXzKBY5YSmI+mkJKs8Hp9b4V31ACY2BFHJbBfQov7AJyApI
 atexni3Oc+V7C7e9cPn0qkUCyisKsX2S+xF9gQxgMVCy1o1BjcpQJiylW1ty2NptolkZlR5kFip
 iy6knv8OXIj6F2S92RiPb5NRnPIc4RjeRhW5GMeWlZKIziKSkllGg+s1jZ2+L+DOxsp3X7O19yu
 bJ4bzp9W2ogZflz1cbiMqncJPt8UCYCkCub890x/5wjsg4cmFI6kG1J4FvWPk3FUdumugaWadg1
 i3k3HwnSu7hdLBWELD15xfW+mQj/pKkE51t3FtzL3MF6TYo5ERaPjF1QED3pjPe17SPAb+sZ4Xs
 39KV2nJXY4bz/NPDop5lA1a7tZFn8beL1VDeeTiBrXbCCLAjL3sbZi6pqKQHHVbDtOlTDjjPhA/
 9fu4uhxbXoztAsZVvqQ==
X-Proofpoint-GUID: FhHeyWQILF-ObIYtSUTAdW3_PzKFXe3x
X-Proofpoint-ORIG-GUID: d7DOFv_A9vaxFjF4Fz6xh6Qu4bWJCYax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010157
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-274197-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid,virtuozzo.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oberpar@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0D03137E500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01.04.2026 16:20, Konstantin Khorenko wrote:
> GCC's GCOV instrumentation can merge global branch counters with loop
> induction variables as an optimization.  In inflate_fast(), the inner
> copy loops get transformed so that the GCOV counter value is loaded
> multiple times to compute the loop base address, start index, and end
> bound.  Since GCOV counters are global (not per-CPU), concurrent
> execution on different CPUs causes the counter to change between loads,
> producing inconsistent values and out-of-bounds memory writes.
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
> At the crash point, the compiler generated three loads from the same
> global GCOV counter (__gcov0.inflate_fast+216) to compute base, start,
> and end for an indexed loop.  Another CPU modified the counter between
> loads, making the values inconsistent — the write went 3.4 MB past a
> 65 KB buffer.
> 
> Add -fprofile-update=atomic to CFLAGS_GCOV at the global level in the
> top-level Makefile.  This tells GCC that GCOV counters may be
> concurrently accessed, causing counter updates to use atomic
> instructions (lock addq) instead of plain load/store.  This prevents
> the compiler from merging counters with loop induction variables.
> 
> Applying this globally rather than per-subsystem not only addresses the
> observed crash in zlib but makes GCOV coverage data more consistent
> overall, preventing similar issues in any kernel code path that may
> execute concurrently.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Thanks, this looks good to me!

Successfully tested this series on s390 (except for patch 3 which
depends on x86) using GCC 15.2.0, GCC 10.1.0, and current Clang from git
(20260401).

Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

