Return-Path: <netdev+bounces-263214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NJ9AC/mpmm9ZQAAu9opvQ
	(envelope-from <netdev+bounces-263214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:46:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA01F09F4
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0E1310FACB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B52D248D;
	Tue,  3 Mar 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GAhQqWNO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C441282F3C;
	Tue,  3 Mar 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545121; cv=none; b=kjVoak4GVDnZz7mGeUNo2rDMtBwvT/1DuAmnn7wq2h+SfW9brW7iUssSqCX4IhjqJVyzluPnSZxcD/ofCvS40uEfVdmaGWFZyXLU1Z3eqI9nVw8G3nymSGJVWI3q/Q8yD6ixQpBpLJze8apw4t/xlexeHxwnlt1RDlBs7ZhGvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545121; c=relaxed/simple;
	bh=dRxbYiu11FHzPqlHYEk6Q8c2imItTbETOYBa8HG9viA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKiHsCKXI0bH2T3ZICHVzKlozWvbql8xs0qGIXWJjtIE3a/gSn3Mk+ZUG1nzLO4pxvFUI1kDWxFTOi75hGfWcrV889NVXL6WfGC+0JPyzvRsyOzDVsqO8LQLDEprxN1RKHt5XKjv6nl+WZJhVqbo0a6uSRo1Yj7XWVfZ3sbEq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GAhQqWNO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6230r8VL967095;
	Tue, 3 Mar 2026 13:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P3q9HF
	+q8t2IWWdLoFqHyvCQTjeob9FXKkDmecUXuME=; b=GAhQqWNOBvjnkm4/fZD/L4
	uZ0EhembMG+JuBlLQDxmlRaeVwbSbRCW4RkJK/dMczV4WdrS5Cu16wZDHnIBcCQW
	3uFIziKnZCw0RHXEot+aoPMlf2n47Ug3D7WMo05E7/zaZTgi4v4/qs/q4JGVCDbb
	0BVMJV0rgiJrEiBUJ0QF3N057Fwn23jkuG1JdE6/yR35AB8JJoBTzcgjEAV8dkeH
	hUUKinF9sLlsT/86yEwS4Z8nAGbl4LvrCGpnJBkMIAR3Pp/BesUgVqo5visYQa0W
	QAP72I71JsZsXwu74Jrjy89BjTCCRRhWHz+6gzYxgCxwEKlpVZJRxaR6NgYFtLFA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbtu5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:38:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6239794E003266;
	Tue, 3 Mar 2026 13:38:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y2juy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:38:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623DcZMG29753678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:38:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39EF2004B;
	Tue,  3 Mar 2026 13:38:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93BEE20040;
	Tue,  3 Mar 2026 13:38:35 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:38:35 +0000 (GMT)
Message-ID: <9354017b-36d6-4001-a28b-a3f777506909@linux.ibm.com>
Date: Tue, 3 Mar 2026 14:38:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dibs: change dibs_class to a const struct
To: Jori Koolstra <jkoolstra@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:DIBS (DIRECT INTERNAL BUFFER SHARING)"
 <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
 <2026030246-savor-hardener-6102@gregkh>
 <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
 <1787125475.222946.1772544235267@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1787125475.222946.1772544235267@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qh26Osdmxj4PK4Q9QOcCtMHoGqQKir-z
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a6e45e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VLcHgaP0IX_9u-gcQ8kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEwOCBTYWx0ZWRfX/vi1ufat/3kK
 PN1bS5ycomI2JSjcjIKf6L7HatGBKcGEg8/tP/nLsxAAHxbf95y9RZNZBO9fKd0WBHqDFcebd3l
 WW+wVw42fVz50MBuLv8mcv+ap6ydxDFnPUwLg5vs27xVmA6ZlqPkI5GLxMUJC/t0CJWkB7xq88I
 +V4jaMYj6CUXvIr4a56YmTjrJDKPXzPptA5oziw8/2eAT+0YNEbPR/EkhQXhBuBcoOIQ7Tvq7lR
 /crO/hR2qDysbF8xt11v9Wob/I54Ote11RpHGL9C4n50NoXMDE5b7fjf6B+eZ5oJYwAq8arG1va
 wKOFE17UVYjcJBsGEww0GrdJZv/1w84kqNaPX50Ys1W2c+ZKzr6XHDO4zJbv0CiGRNDw5rvFIZZ
 Mr4KEgvSUGARJ1Dokm3HwEkoBOqy0IBfaLD4QHTyf4yu+6uQTD+IFQDBpJXjeptkVNQBFCj3sl+
 X6jIOB9jKxpyAtQmx2g==
X-Proofpoint-GUID: Qh26Osdmxj4PK4Q9QOcCtMHoGqQKir-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030108
X-Rspamd-Queue-Id: 58BA01F09F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-263214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,linuxfoundation.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 03.03.26 14:23, Jori Koolstra wrote:
> Hi Alexandra,
> 
>>
>> Thank you for the patch Jori.
>> Would you mind adding a link to explain the "as the driver core now allows"?
>> Maybe
>> Link: https://lore.kernel.org/all/2023040248-outrage-obsolete-5a9a@gregkh/
>>
> 
> Yes, see this one indeed:
> https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/
> 

Thank you.
Would you mind sending a quick v2 with the link, so netdev maintainers can take this?

But I'm also fine with taking this version.





