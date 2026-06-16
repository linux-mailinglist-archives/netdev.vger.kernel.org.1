Return-Path: <netdev+bounces-299749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44bNGdfoMGpxYgUAu9opvQ
	(envelope-from <netdev+bounces-299749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D268C605
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=XWbm+85g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299749-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299749-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78463311B83F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0883DA7C9;
	Tue, 16 Jun 2026 06:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8B3CF67F;
	Tue, 16 Jun 2026 06:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590127; cv=none; b=Uw3ww4T8bIe6Zb06y5PW6Z9S/dQ/tbGJe0eCct+oXNXTWaY3Kb8qakYZZEEaE5yVgfSSc41fz8G0TkcaHL5dc5f40lPcoP49Eq+sHWLwsUI/WogLg1GgMj9eQ4DzIxY3p/IgoJtO4WN8dD1p5bfaH1p6IK2oqgzBHpDAztkgXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590127; c=relaxed/simple;
	bh=LJgaGKqARjo0osqSDzi2xoWh/73ScAzrFZR5nlEU2T4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PV0rvsSP7Siee5bluUDrtJ5QDGomhsPFzdB3zS9L3z52ZxiENnVZO3u78n8pZdsSji9d1jlbjuRNXLbVP0FaB+DKhGbTpvCNe0hUeql95RIvjpBPW+zFBN8Q1O35I40gVV1X6Lp+U9501xqXmYbX2lGC7BMknL7P9tgqPpMOSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWbm+85g; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0mNNl3954925;
	Tue, 16 Jun 2026 06:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LJgaGK
	qARjo0osqSDzi2xoWh/73ScAzrFZR5nlEU2T4=; b=XWbm+85gkj5w3b3ouTjqUE
	9sf1wj6N4UzXn+1TRvMpHzyPc9tQyfGIbhSYw/n4iQPbyjF4oAL2j6myq/a6109N
	yiBv335Kulp9Oj220zCb5WvRvocA+tmcg/uwRQVSfkUa3efAldsryMkNcind0R4p
	AuptI9gs64BIOr/NN1K+vB9A2wvzlWaRbCY6qqeiOBmOtLBTrvz9jHK/zjuLpM7e
	iq66sF8CiZhgIQXaDOScnQu/FSKV4C3pNMf4ux3bNbh9wWzidKGMHcS9MTQ1Eb3Z
	1ZgwP+vBhmfsWjs9B+5c9r6wIcZyAgAh6v5MLDA1Qqp+y8t81eBte/B69C8cldpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm44s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:08:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G65qcI024278;
	Tue, 16 Jun 2026 06:08:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk1yt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:08:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G68eIY33882638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:08:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07A458062;
	Tue, 16 Jun 2026 06:08:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345B658061;
	Tue, 16 Jun 2026 06:08:39 +0000 (GMT)
Received: from [9.123.6.235] (unknown [9.123.6.235])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:08:38 +0000 (GMT)
Message-ID: <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
Date: Tue, 16 Jun 2026 11:38:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
 <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfXyx5aBLfS5m37
 yBYevPOebk64gRJgB6Fl7VLNa3Gwf7cTOnRKM6CRys8YqUtP6v+U05IFFokZE54amJm+xyeUd5I
 GR46aXhnNb8K0NNTUz6Sv+Or9qnAKvg=
X-Proofpoint-GUID: i6UJJ8rtR2tPLhfVKCZ1mFqV0o8fR6rL
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a30e86a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Tuhm9eAq2ABGGyuMaTQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfXx+pHnCzCqqh+
 4GgCdx7PKRRrTmxUTF/XidilF37REkopN6I5IPFkMb/+2mEn+nSOB+sjebK3c9XEp9KDAIA/z21
 totCVCP4CTTUfSr2F/K5kr4nhFqR4IXwBK6yX+zpbbUlWjz8ysZL7sswxzvPCtoTMEPu66lN7W+
 1PHjaVEf82dTvHeHsXnMeid1OoHXhSEbDX1E1ocI+yv6+SIaQ+Z9I+3tpjeh/1jR3ZahaQ3xyR1
 i5D/rqqQABWxIDYOZgkcYQfgd+UXdif5LKBG+q5FPkmHx2lx6sRO/axxteEG0XasKPzlm1JiNMC
 cE+AalVsRqATa6vzE52u/5JnhfUzTUbproRBW1Nuduq8nDR0rVCtQp9Rx8hSL2Wp0xmIEi3nPKA
 NbC5xBg7qlMEe/XmcYPAYE3MA+++X3RQuamiXqm1AQaHbXX8cHWxIF52p/SDjnY6zVdryr6ahqB
 XNHAn17qEDshv0JDJYg==
X-Proofpoint-ORIG-GUID: i6UJJ8rtR2tPLhfVKCZ1mFqV0o8fR6rL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF0D268C605


> Please add below reported-by tag:
> Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>\
>
>

