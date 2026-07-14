Return-Path: <netdev+bounces-307475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+AOCac8VmoO2AAAu9opvQ
	(envelope-from <netdev+bounces-307475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:41:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5C755476
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:41:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=CzUeggFz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307475-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307475-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F455305D260
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452A46AEC5;
	Tue, 14 Jul 2026 13:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C532B100;
	Tue, 14 Jul 2026 13:36:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036181; cv=none; b=K+zPQqnu+puPEhTVT6NUYY1seZM2dZCrGpuu0mOuavowP3Tfu/GNHhQTjeNEYJ6CTv3Y8RU1wEDGKgxEmweJGy/Ywmhlt33PwDMWKwixS7ypielfllgL7svhJB0+YOLGaGxhLhmZDQtUXo4YgFWB7RW20/CQGpni4Y+rnoxtzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036181; c=relaxed/simple;
	bh=iEISZxKB1J+cljVDge7Bx3bDU0lKK2G8PuNVsmmAnC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLirN6+VPmUx3qqVMgZoEXLofWnZ6p1mPSyUUFWBqZ62OQFBauiRRDo9ukc2VbVSgxCWxaj6UAZdkz6XgzLP/Xp+1WYsHh129lJtjWSVMV0KhVUF9JeSBaOCpl17mo42ufxy+uvdjOwIgZtiA9AWmy4dcVYjuOrDQBji/nf063E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CzUeggFz; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBg3xh1129452;
	Tue, 14 Jul 2026 13:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9oClfizclD8sbY7Z4KNKeFZ5fLzIpR
	VOh4XFnC1HE7o=; b=CzUeggFzctv80EBG/84tHAJFeB6+cuJzyuqvE1FpDwJzuJ
	xFGm/MJYWgcLSLc7wgoyUAiUCqBRAmHOWzitb7iALWor3/qPIMzEMWDcCDFQ5eLI
	j4Zh7cZG66EFyaw9kgKBUzYwh0ACAo5VB8BkBlbz5Ur8k0vaKkHv692MWQg+muIN
	ZJjHNu9/TEiAWSWZSKfxaL6ujgdRVr7XGuoAgPxvDPEGYMLkHXVRJTnViHyRVjRk
	fPHy2GgWFMg7LfHdst2938FQIBYhhdhtLutMimmw8Y+X49FM7mcFlujg/csFiDEC
	sRftdyId1gOJCpDMutPjl2qklu+AgUeDmACDw/Pw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwnv3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:36:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EDYcxH005287;
	Tue, 14 Jul 2026 13:36:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q36y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:36:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EDa9iR61473246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:36:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8AD2004F;
	Tue, 14 Jul 2026 13:36:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA3720040;
	Tue, 14 Jul 2026 13:36:08 +0000 (GMT)
Received: from osiris (unknown [9.87.141.23])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 13:36:08 +0000 (GMT)
Date: Tue, 14 Jul 2026 15:36:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] s390/ptff: Export ptff_function_mask[]
Message-ID: <20260714133607.31731B6e-hca@linux.ibm.com>
References: <20260714130342.1971700-1-svens@linux.ibm.com>
 <20260714130342.1971700-2-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130342.1971700-2-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9-eM6cdiUJVxq7M8KYdnmP878qbFoMWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNyBTYWx0ZWRfX+k6V9fgDA3yD
 bZ+hq/+rwDX0Fi03A4LArIjUBbUFibxXFtFhDH6lhThy0V1LagY1lowTcipIwj095+1UX//91bu
 mQLB0kS3+xpzbJkuK1sWEM9HkQrYed5c5oxHlBZL2K83KBrZ+frVT8GxmrwVNnBH0S675NuKisv
 u9v1Hbzh0VeBM9g/68Piv9I41mTmwIT2C7d0B5IOx3ZZYE7mib2eJr/iavjKAogEsgIuYJRZvCY
 jZRf/XW1aoGxjsLdA8C8nCztauY1w4MV3WqqNN5E+DZRJVekQvNBTgzpgYhllIwMA1YeZLITuF/
 6W+Wq8Nm7zn9+4YPk8yVBDtLHQEnzZl/v6dOMq6zawE3LnkvN8b2q86LT1nHt5N0YR5bmWJ3eHj
 nx4wpF5Z3aGiUjzxyCVq4Rluw4Df/tw5gYCLRx/NwpwMX79SzULh3F9kJg+SvsCT2iqXZZItKw1
 re4ztLHRrZqkUGLmSpg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a563b4e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JzkDgRDL8IkiOmaNI1kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rjH5BTnmWTxOntJcZ9f03akp_JYmOmUo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNyBTYWx0ZWRfX2ruppqMx0akX
 3eRZ/EDu6MJHXv/SBbLkXVYeZLHwmkpnY8a5PE3GTbeu6ZFqL8pEflJMgn/iOTcFOru0EtsIKwX
 52nT9yTszE19vWB+FnXUNXPwFF84evY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140137
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-307475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B5C755476

On Tue, Jul 14, 2026 at 03:03:41PM +0200, Sven Schnelle wrote:
> Export the ptff_function_mask to make ptff_query() usable in modules.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/kernel/time.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

