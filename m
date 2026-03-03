Return-Path: <netdev+bounces-263196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOpgB4PdpmkEYAAAu9opvQ
	(envelope-from <netdev+bounces-263196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:09:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777301EFECE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF18302F73D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD2421A11;
	Tue,  3 Mar 2026 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rmnz1WYf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368931F99D;
	Tue,  3 Mar 2026 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543267; cv=none; b=rFZfrka6lt5hBm8MRI9sENNrP4zGscB9hD5lsR6jJw3o2ddfS2ly2ZuvWtauCvFU8BqSDhNHAyR2IjLKtitAUYXli1vtGYPfWh+XqFRvaP819773kkPopiLJlyYv8AKKvou1SQ4K3pT1sVi6ubPYpFDfekgX55G1rnCjZfoBlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543267; c=relaxed/simple;
	bh=5U8N+SJCZS1ohDGXHs1ZqXFnCojx/Y2kWGft94MFJMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXECYOBA/j6KFrftLfNBHNDCdI1pk//al15zvORH86bH9VQdEllNl2rUR8HqIr1SXOjrFwW1Foqg7Zm/79KMif5OY0gMt1sblX1rvrbvxFuQUp3XMC5EZr9UdKugLKqIGMBp7YvRUtu1JXyTF/VyCTGzhxpuKd42llvgxGP19vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rmnz1WYf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236G1aL2154446;
	Tue, 3 Mar 2026 13:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MgQgLY
	g9ZexzRKTQk0t+U9i77xSjeYHUUdB7VkDNIcE=; b=Rmnz1WYf8+Uexox9G3W1BF
	uo1q7TgC8t9ZQh/IZ2NUc57w1EA8MQhteqXqRfgTIQXdJjZnaSSo+wmMiHummq+N
	EKre+2sRvOG5HsAKejfx+Qcr/7rHnxuoOWzrAnZRCrfbBf3NGTQrMqmsaC0ujYm5
	DBiIo5Wi+sFibhwijqJ4JUZJrN695XQrOTZa3BULz8BRfTHTbps4ANpBGsTfgtDu
	ZW/YjfVtNiIr957JkX9dX3xpzi9VR8gt30Y7+q+Eeg8UEB/MygCOsAeQs2xy/MVn
	IektTXtyaZSqhCUH1idHn51+hPsiqANqzlrEQum6PJsN04TTHJNokcV5sgc1xeJw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbtpqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:07:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6238YVvH028908;
	Tue, 3 Mar 2026 13:07:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps2eca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:07:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623D7gEN24248862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:07:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B08920043;
	Tue,  3 Mar 2026 13:07:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB0642004D;
	Tue,  3 Mar 2026 13:07:41 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:07:41 +0000 (GMT)
Message-ID: <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
Date: Tue, 3 Mar 2026 14:07:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dibs: change dibs_class to a const struct
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jori Koolstra <jkoolstra@xs4all.nl>
Cc: "open list:DIBS (DIRECT INTERNAL BUFFER SHARING)"
 <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
 <2026030246-savor-hardener-6102@gregkh>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2026030246-savor-hardener-6102@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UOviPD0LDMUB-TmffLad4mDrjDEI0BNC
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a6dd20 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=xOd6jRPJAAAA:8 a=VnNF1IyMAAAA:8 a=dFZGIeYmx-VExCoYgmoA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX5r5bpRvBFCvk
 gkzAZ5iKHeeg98RgxJC6jwqecnbEPFUZp+zhOhiJ1u2lfwv9TZbZQ7OfJ2z1xIWHtKxpD5E9ZSC
 6DVhxWODNqbZAlHY74oFzLzkUrqnonYsitAz1azHCXwpAsAJBFWkDfW0Cx9GjF8xf64h3+KVISq
 NDIOGvaMWVHy9qmTscmPlTjLx5IY+hB6fuCDpMIa5c+OCBsw8w4RXVgLQJEQ0Oqu9rmVAaBeJ9P
 GaUiORSi9ZN+5dxJoF3yKuznB3lZIK2zoXVHXx5i8LIK45n1CH7zYj/2QXBq+jcUpVClJE6Rz+k
 Ix39jIYRUWokEuO4n9W9kgJOLavb4GNy+aLif0Kyo+v57/e/4PjwwBq7W5sVabVHZih3LU+gTL4
 6SHFKIYLm9PA7g8VwtFubIkTw8CeEJPJwmtneA+kxyFm8E544wA/DZcm95yPhXwMrjeN+CYLiP4
 RsRrRC+xi0DK9FIMosA==
X-Proofpoint-GUID: UOviPD0LDMUB-TmffLad4mDrjDEI0BNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099
X-Rspamd-Queue-Id: 777301EFECE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,xs4all.nl:email,linuxfoundation.org:email];
	TAGGED_FROM(0.00)[bounces-263196-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,xs4all.nl];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 02.03.26 23:54, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2026 at 05:31:03PM +0100, Jori Koolstra wrote:
>> The class_create() call has been deprecated in favor of class_register()
>> as the driver core now allows for a struct class to be in read-only
>> memory. Change dibs_class to be a const struct class and drop the
>> class_create() call.
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>> ---
>>  drivers/dibs/dibs_main.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Thank you for the patch Jori.
Would you mind adding a link to explain the "as the driver core now allows"?
Maybe
Link: https://lore.kernel.org/all/2023040248-outrage-obsolete-5a9a@gregkh/


For my education: How could I have noticed that class_create() call has been deprecated?
Is that marked somewhere somehow?

