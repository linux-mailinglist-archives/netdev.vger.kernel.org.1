Return-Path: <netdev+bounces-293436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QYpXIWlMHGrJMAkAu9opvQ
	(envelope-from <netdev+bounces-293436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD29616BD4
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBEE4300C03D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7B343D8F;
	Sun, 31 May 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3/5qwYg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53319CC0C;
	Sun, 31 May 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239461; cv=none; b=h2LeR9lzXsaTFqPvOkCtOPtmhhXX9bupmbGfJezDRiwfxihu0BoCf01I3Iv5Tgqz5NkCj+/hj5d0mlz1xq62ZyuxWmqPRWzuVAGZkA2jODav2ScoPME+GHT6v2ojUVMWJ8F13LgVe49sBh7ITEq97OAsfWX8CoC2OKouPBGmclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239461; c=relaxed/simple;
	bh=iQGDn1Jf9dFMa9dzH1oFh4A0RCK1PAt/HAxfdvssJbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5tAR9RaWcz+pAnZl/CWzGi9Y9AgwjhMBC8rTuu1OeZT3gBDdmu4/XJ+kFKvejmh9lAzYWotstrav+pCwaB39IB+5t4jXhKjJKYOzBpyUCw97uHzwqfnSeFKMWwjWelS6KS1w0Ux1jTn0iHOR+ZWtOIbiw3hZsb4rVi7bIg/Z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3/5qwYg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VBj1a13166613;
	Sun, 31 May 2026 14:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pC+2Qh
	+ovfnAc07ZV0pUyfsLxOLfbOZo+ZNVyGQvnN4=; b=E3/5qwYgRVTzj9dxhkFI7u
	YuVV7zfuGJiPhaiaBqK4/xAlvVAYn5M4MWH6kMlscuO3ZIy7KoEpA19Z2LviJ8i+
	dfeANqRS79osrDoEC1d1YtAsMU2DGanqe/Q1lQt2+hgIqcHg8sPDmu/eWTD/ZVri
	4+592N0TMinGEJLExS95+3UABb96u5gXDeJZ1Oe478jdZ2DcQ4SvPQyDhjUiQ4ji
	VeCUULpXEaEHc/Nnwbdc/P/ljJmmwhu1gJgz1/z+N3UBziQr6dcFaF66LAEIFA6U
	OGirP3DMz1Rqfkw0LRboUusC75g+hiM4kTngidtWWs5KWoaqOimk7A+xjQqXPhzQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpadvs80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 14:56:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEs6T4020821;
	Sun, 31 May 2026 14:56:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy1t6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 14:56:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VEuDQj24511164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 14:56:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2EF58055;
	Sun, 31 May 2026 14:56:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519D65804B;
	Sun, 31 May 2026 14:56:04 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 14:56:03 +0000 (GMT)
Message-ID: <bd6963ce-0450-4dcc-80dd-6a849f56c82c@linux.ibm.com>
Date: Sun, 31 May 2026 20:26:02 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Meneghini <jmeneghi@redhat.com>,
        Randy Jennings
 <randyj@purestorage.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Hui Zhu <zhuhui@kylinos.cn>,
        Gang Yan <yangang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
 <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1c4c0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8 a=8XZj10ozE-2VC0O1gSAA:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: dIQ7UY_J24-FHRd5l7-r6U7F1O3UeEPJ
X-Proofpoint-ORIG-GUID: NWW-6RTQ4MecFcEN2S3xFZvSbZq2vD3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE1OSBTYWx0ZWRfX4rj5h2PXmnGI
 n9kkmv0EKeI4sodk1a1zKVcAk3JQk+pIWPvMMN/KakAlADg0g/OCPiHsX1R7j4N2okjIAoqNeXc
 1Vpby2UwgB9LFexOL3HKobXUdfx6O5JulZVw0GmPuLed8YG27vHADArUCflcM4vNl5s+KkxBANO
 /OwgGYtLGO5Wk9peyHgPFZqCJnXpdQu4EEsIQSBjX92JIm01H3EFoqzUbpxwxc5SS7pdFF6iUM8
 bVBoRfjtm8MR9A6pSqvt1daISfFQiXFjn+IpQ4fAh6cVr7mGCosMu5wzgzyyhsilyxBzE7HyIy1
 vVqs3LGwKabGxXNSx0Nth5sGH01hhgcHu+y7/6ZG1E4n0+dmQLZmV1FDq5X2RoSJPJVT2OfVqJt
 GN7wBfrXYLa9DDyxauPzYxKT+QN7+8I/lFAdm9/aaZGJG72DXUYaHfZVTmXtCWGk+bOkHGiex1g
 PXPAAGMfX6c1CY1pl2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310159
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-293436-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email,linux.ibm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: CAD29616BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 8:40 AM, Geliang Tang wrote:
> From: Geliang Tang<tanggeliang@kylinos.cn>
> 
> An MPTCP-specific version of struct nvmet_tcp_proto is implemented for
> accept sockets. It is assigned to queue->proto when the accepted socket
> protocol is IPPROTO_MPTCP.
> 
> Dedicated MPTCP helpers are introduced for setting accept socket options.
> These helpers (no_linger, set_priority, set_tos) set the values on all
> existing subflows using mptcp_for_each_subflow(). The values are then
> synchronized to other newly created subflows in sync_socket_options().
> 
> Cc: Hannes Reinecke<hare@suse.de>
> Cc: John Meneghini<jmeneghi@redhat.com>
> Cc: Randy Jennings<randyj@purestorage.com>
> Cc: Nilay Shroff<nilay@linux.ibm.com>
> Co-developed-by: zhenwei pi<zhenwei.pi@linux.dev>
> Signed-off-by: zhenwei pi<zhenwei.pi@linux.dev>
> Co-developed-by: Hui Zhu<zhuhui@kylinos.cn>
> Signed-off-by: Hui Zhu<zhuhui@kylinos.cn>
> Co-developed-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Geliang Tang<tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 16 ++++++++
>   include/net/mptcp.h       | 12 ++++++
>   net/mptcp/sockopt.c       | 79 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 107 insertions(+)

I'd recommend splitting this into two patches: the first patch shall
define and export mptcp_sock_xxx() APIs and then the another patch
specific to nvmet which uses those exported methods.

Thanks,
--Nilay


