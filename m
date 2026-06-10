Return-Path: <netdev+bounces-297428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJzhNfHnKGoeNAMAu9opvQ
	(envelope-from <netdev+bounces-297428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:28:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B0665BE9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:28:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="ieJXoGc/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297428-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5145F30B6CEF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D33630A0;
	Wed, 10 Jun 2026 04:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94963451C1;
	Wed, 10 Jun 2026 04:28:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065710; cv=none; b=VxXiiSl2+LERZxtdPZFMxOrCw3byh+kSUdEueO+1fk8oTUfZyjKvXFDxFPmgZZEZ+V7fUk2xPnw64ahVJ1J1tHqewnSSaW5awbtKZXiGG67jo428H8QIYPmirzN3LjYYKiGb9BRZUaYn8sNDOWPaoia8fquHBLcXgI91S6yb9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065710; c=relaxed/simple;
	bh=0MK9QSxckQG39FnkMAMZw15nyDI4CnqM0OQfHOH+HyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=henqJIOTu4WczSFNrGGTpBSZyn8GLRXVTwY6Wr9zgX8f/oGHfxgpJEQ+FwF1Q/fQOLgvE+kVz9gVYAylGqMaeM4YFEcME7pKydP/ZfU0xUYYUHZzZYDWM3/T9cWTPQVrN3m445vV5wLCV5b8PY5SZU2b8rW7u7tDBSbsyy9K4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ieJXoGc/; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vDOo2132393;
	Tue, 9 Jun 2026 21:28:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gK+pmPzdUWKqkakBm3x9MXnOJ
	/5O9DYDIfPO4VTCpFg=; b=ieJXoGc/pY4bSM+9thAmMXlX9g7Qr1jBVZEuT/INL
	Ct5d/TinnwcbFNZRaYri7mYGuapBWzsMGdYlUHFpQKdPeVkGadKOpwxt35OFX5NX
	TbGYcuqe81T0/qfYtF/RCVuf1DBOQGcE9t4aYm06Q+fKuivYfVIfF6dY8OuBtEEN
	QE1vbitifsztSwW0m3lU1GIXWq+y4DixLRjEuvIankxA30GKaHU/Jc/45Z2NMM0I
	rY9UjA9RTrnY5s3i8rQ6SPXfM41sBy41Grpp5yTo+TLPvU1cfs2JU1EY99mHL/uI
	axT8FGDU9VcyvO0FEWVF9eJtpKpLHK8nCEv9trumP/M4Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps391nyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 21:28:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 21:28:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 21:28:05 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6F9A83F708D;
	Tue,  9 Jun 2026 21:28:01 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:58:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <aijn0C6m3CWW38Xg@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-6-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a28e7d6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=dCuOX9PjPCUG7w9EUSQA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: RNY3cHcq0RujwKNQjg6oAzSviw599ohL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzOCBTYWx0ZWRfX20iuIVF0X/x0
 IOJHTuqoQnQqRIZYXyxdECO25FQVaG80o+xLXbaaAe4CO/hEickL5FK+mqAhNOfe/CHxcsjxgGV
 vhV5UKt7ci+tiiiSu0YjGV9aQFpGXhX3Lx3uXTSe4XDxen21+5MrgW/cNzIOruaUrgpfUidcavz
 xD5Zf53vI5P2ttFORfIcJTVVcbVeZ0USb+j/JdmVSwAtZX97n6Ly75p4/a/RL+3rbAR3+dMH7j4
 EBe6v58tY/2B4WZ0F/ILMXEhXruIEDCaVIwt8eN/+sSS5xaKuUrP13VduZpxv4fyVCGcJCXdMF5
 9MXp/4P+fNcsakP9ZSzEOqeTM6dGr6IRSGltzFWGoNv/DtlWub93jOntEGipNU9AGDDof0SgSJK
 3mCL+qn2vFMWv90sHKNwV2idOUrKTCg7DPx0ujdPOcTNwOwtZGgKD9Z6LMqveIWmfRWxl9f9f8/
 TEL3PxvZ6kSOR47Xm3w==
X-Proofpoint-GUID: RNY3cHcq0RujwKNQjg6oAzSviw599ohL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297428-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D5B0665BE9

On 2026-06-09 at 09:34:49, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

https://sashiko.dev/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

>> @@ -3906,6 +3906,122 @@ static void npc_unlock_all_subbank(void)
>>  		mutex_unlock(&npc_priv.sb[i].lock);
>>  }
>>
>> +int npc_cn20k_search_order_set(struct rvu *rvu,
>> +			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
>> +{
>[ ... ]
>> +	for (prio = 0; prio < cnt; prio++) {
>> +		if (rsrc[FREE][prio] == -1)
>> +			xa_erase(&npc_priv.xa_sb_free, prio);
>> +
>> +		if (rsrc[USED][prio] == -1)
>> +			xa_erase(&npc_priv.xa_sb_used, prio);
>> +	}
>> +
>> +	for (int i = 0; i < cnt; i++)
>> +		subbank_srch_order[i] = (u32)narr[i];
>Does this change the semantic meaning of the subbank_srch_order array?
>During initialization in npc_create_srch_order(), subbank_srch_order is
>mapped as subbank_idx -> priority. The devlink parameter npc_srch_order
>expects an array ordered by priority (narr[priority] = subbank_idx),
>which is handled correctly by the earlier loops in this function.
>However, assigning subbank_srch_order[i] = narr[i] here silently changes
>the array in-place from mapping (idx -> priority) to mapping (priority -> idx).
Thank you. npc_create_srch_order() is creating it properly but npc_subbank_init() is
not settig this order properly. This is a bug. This patch did not introduce this bug.
Will post a patch to "net" tree.

>> +
>> +	restrict_valid = false;
>> +
>> +	npc_unlock_all_subbank();
>> +	mutex_unlock(&mcam->lock);
>> +
>> +	return 0;
>[ ... ]
>> +const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
>> +{
>> +	*restricted_order = restrict_valid;
>> +	*sz = npc_priv.num_subbanks;
>> +	return subbank_srch_order;
>Could this result in scrambled subbank search orders if a user space tool
>reads the default order and then writes it back?
>Since this directly returns subbank_srch_order, if it is called before any
>set operation occurs, it returns the original idx -> priority mapping.
>If called after a set operation, it returns a priority -> subbank_idx
>mapping.
>If the original default order is read by devlink and then written back
>unmodified, the set path will misinterpret the original idx -> priority
>array as a priority -> subbank_idx array, scrambling the search order.

Same comment as above.

