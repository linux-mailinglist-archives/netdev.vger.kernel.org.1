Return-Path: <netdev+bounces-300037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvA7A6I0MmoEwwUAu9opvQ
	(envelope-from <netdev+bounces-300037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:46:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B139696A92
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:46:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=DWuHypBZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300037-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3345E3004C84
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638A3AFCF4;
	Wed, 17 Jun 2026 05:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC93563E1;
	Wed, 17 Jun 2026 05:46:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675163; cv=none; b=lSF/oIkcQFLLQ4OiU5yP7N13oQttTi7mSuZ6/3JUdfGEYZKFK9Pz2S2AFY4DVeCqyDLuSqouTZIq8qpEG1Za5sEPl9cwKfsBFCSYk0Tv8z8mlvdEqU6DsydpOy5K+BUUNn925GsWNAdHQfxWzEItZh1K4bvZCeEO+CLvkRzN3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675163; c=relaxed/simple;
	bh=zak31/UPPn7wczTf3FHwIm6NpdmEUTRwJiBle3YOpEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBMCu4/wsEbkvn8yOi70Yc+tj68GdLgSrh5tFKiiaYL8Lfc65vZtMoF0ZaLW0cY+5zXkbNV9DMDPOVonC/Fn2QPdNavnbLxqAjHlIHiMUv7K2VAPl1hJDH4TpT5VLdsxGaioUOiCJnaGgz9SHX5vFXlMJldHgv8VIVe46g0eOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DWuHypBZ; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLmgMc2724723;
	Wed, 17 Jun 2026 05:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7A7Nps
	A0dFdRmES8QeZ+5ivPRFA6wzmrJIcJc2w4Lz4=; b=DWuHypBZIV0pqVUYlm50SY
	eYENgtfZ/N3atCtZ6EKMeqZQpYPjdUdBPLHVbLy/o0UpMzMk+5HxEiywqu9l6cGZ
	hVOkoJ4P4t/mCqEdTmpQDCtAOYEcwt9sKzfYaeBJx4OjOZgmWyn/I67LcqJBuaRd
	jNRHlYeu4WMaODNWZ4o5qLKHPEfq2C59VMiZEPJhq/j9TgFViw36y8UvZ9HqH+Yv
	TreDbJpVSn5IjgOXmDnIAmH26W6bnvorBr2znzJ73657Y/1tI504M9/pAY2O8y9l
	Lw6KQxEAGRb0gGqmcoDLlHPO2h2yN+XClTz9ZHJsymLCbwdE43ZhAClww4N+0oMQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvsd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 05:45:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H5Yn1I028479;
	Wed, 17 Jun 2026 05:45:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva1puw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 05:45:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H5jrkJ17891938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 05:45:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97E35805F;
	Wed, 17 Jun 2026 05:45:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE09C58059;
	Wed, 17 Jun 2026 05:45:51 +0000 (GMT)
Received: from [9.123.6.235] (unknown [9.123.6.235])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 05:45:51 +0000 (GMT)
Message-ID: <9522eb6d-8751-46dc-8047-22e8a6304fbf@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:15:50 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: netdev@vger.kernel.org, venkat88@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
 <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
 <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
 <ajDshKtFNpQAtHQ0@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
In-Reply-To: <ajDshKtFNpQAtHQ0@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0NiBTYWx0ZWRfX8Z/p5gBfHRjW
 2kzbZDGk+c92iP5TzzV8Dmtp/mFmPR+RrIPtufa+XJ0I79NuDNJeV4QI+wZouy8d2jTFBni+2eB
 ncvnsOHs8MAq2kvDOgZ0Zid4hSxdUVw=
X-Proofpoint-GUID: 5Q8CXRBZqcAA_mVuI02siDijslm8R4MQ
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a323493 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=fQ7eh-DbEtEogAiaS8sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lyh8K7ThnGrGl1BXkAz8XubDr-4CbFzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0NiBTYWx0ZWRfX5uIfGZh9+Ss1
 p7Cj0mQYuCTBfZxN2fDkZEee0AXyXZKggTjW5Cn/QsfgLLkkYqsY+s4IaRLLyit6TQ5dQVQdoFX
 MbZkXalK8hqbbQxNgFqB9ApiMuMoYtdXT+s7yYRZ8DmrPx8+Wse1OCl1HxLgAfJw/DxR8dmIZsU
 In87p39/KNd+MdApnM1DuN65CBTs9UnGdNs4AtqMigHYLLQAiweezef6HFvjxSzXntbjoROnJgd
 VgPwqptwURA8h+J5pwNV+FMNwH/LIdEXHFQ55Cbgd80tzT75YHoCbJbUQJwBNhm+3MfIxLQqKRV
 6t3UIcg7aEG2fQ9VCE+T2jony+lm31dtM6b/s6dE2xM3gB/7bEqaKOHB7wAUXopC5DUQ+uk/CI9
 T3a3wh+NNQ6a1lANhTZrjRXK5YDQs6Nfi+KnGZqJDdNOde8xobS1pDlSHXJXj0J/vojyDjPjGzD
 hQrYUofGbYCUtNQx3yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkchauras@gmail.com,m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300037-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B139696A92

Me and Mukesh discussed offline he able to reproduce on latest kernel on 
my System but not on other systems need to see.

Regard,

Yeswanth

On 16/06/26 11:56 am, Mukesh Kumar Chaurasiya wrote:
> On Tue, Jun 16, 2026 at 11:38:37AM +0530, Yeswanth Krishna wrote:
>>> Please add below reported-by tag:
>>> Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>\
>>>
>>>
> I am also not able to reproduce it.
> Can you paste the full report of the crash?
>
> Regards,
> Mukesh

