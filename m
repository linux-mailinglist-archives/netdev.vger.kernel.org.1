Return-Path: <netdev+bounces-297445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mJFoJeT2KGoKOQMAu9opvQ
	(envelope-from <netdev+bounces-297445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C590665F4B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kskjmTfS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297445-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297445-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7016C302290F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20540238150;
	Wed, 10 Jun 2026 05:32:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70D1A08A3;
	Wed, 10 Jun 2026 05:32:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069537; cv=none; b=fVFb1EAfKBxkUV53gopaXP0vNbesTUBDyUDoe/4CF8Sp21ZevLvAUA7xyimnscwJX75j7qrir1DeOxKrm4hSbNzYLy8v9vdrx8PtkS2hX3aZB7TW1JL0f517D1IIzArNdlkcYPh60BfYePyFGETAZtnEGjcrsjlwWD0ajxYCXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069537; c=relaxed/simple;
	bh=KvZtY84gc1g8ukY0q0ShH3IVH9UB/wNOr8rFXuwkoPk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaM+qCkugQDVVbS/+Vv74Fv+VPsC1D+GtXBaZjIfN+aX1aO/5N8Lm5GWnI+oGhCyf+PVluxpG8JalJBbQyoTbe6gmqPXYGukNViourVNgfdfqd1GXqp6jwfig7A7GYBJ/HZFpFPQKYzBH//aXSREpYFOzyzcUU9qYAHqNzAigr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kskjmTfS; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vd2k2896624;
	Tue, 9 Jun 2026 22:32:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/qXnOLRFCS0d1yfnAQb0QZDlN
	fqShFiluiSY5zNnVBs=; b=kskjmTfS/XWh1GCg82keuluI/JEte1cvZA8fA7wb5
	5mlWVViPPrCHXxV+UvUlI6hTn+35H5wft4LWP9OxCxJ3ojQpvYJWob4/zVXuTSyY
	1ZXmPvr8UBciSfCv3YAr6dwlnB8hTYt0NV6xtEe6BhcDE/V77vX73ki0TSfCkF1K
	UamT9Sc06H1Xpcnnhn4GWSDN8kWD7bZxrx9uYR5sOA5J199jljY8nA2mTsn06gSZ
	eft/qGVKiB7OCnYLaNr5OYp3vF4cTmWD+lIWMZh0rbjEWmEBesGTz6C8tDehjW6r
	otVHEiZMu52sHIqsvVffT9fyn5n9Md4ED3+DvyYFL0K3Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqpcumu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 22:32:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 22:32:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 22:32:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 894B73F708C;
	Tue,  9 Jun 2026 22:31:56 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:01:55 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <aij2y-F4MQjMP71Z@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-9-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfX3KAk2z4V3oW1
 +4LqWYbBgsVI37epsL6wGFbSyhJhrbY9OaBAwFd2iQcfBACyJDVMH50O6liffNs11IdLQ8LAOuq
 /aHxfgHgy/q8r5fZ/p/GtjAFXr82+ro2zIKmYEJZdp2d/a4QaoSJuPWhdaELLEuv1NbMAkC6vb5
 a+tkH4hkh9pKX3CuMnGIIRR31OCsaFyfg3oQJhnZhMY1k7W8L32qR9T2YzTdwDnzYUvVGGcsybb
 GLJTBHOEzgZnrEEHP7NfzO2LpW4EMIa5sWFXCIG1X8SThnW4sc6Jfze/muu6XnMWCM7g9XqkWGL
 nMu2eTgNX9SneQZMCPZpIdr4U9Sd2wl9j8j5v5sZ9Hb/raUMT1F/JpISzFSScGwVsg9vBHgQwL7
 E2iVORv0hUXc21Dtd7/XUK3x0P1ZCRBZvV1uWa6Tdcbd/pUq5v3Yvi+RUqeC9vETDlX4D1dRdrm
 Oa/QKNszC+CtbsBhFRA==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a28f6d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=Knl-tBO3iHv-3BrbUGwA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5Yguao-yj33UJD340fEOiec_wLQlmOFM
X-Proofpoint-ORIG-GUID: 5Yguao-yj33UJD340fEOiec_wLQlmOFM
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297445-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:from_mime,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,npc_priv.kw:url,linux.dev:url];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 2C590665F4B

On 2026-06-09 at 09:34:52, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>
> In the AF flow-install path, flows that need more than 256 key bits
> query the NPC profile; if the platform is fixed to X2 entries, fail
> with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
> MCAM alloc.
>
> On the PF, cache and pass the profile kw_type from npc_get_pfl_info
> through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
> entries for RSS/defaults and when installing ethtool flows on CN20K,
> including masking the reference index for X4 slot layout.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

>>  	pfvf = rvu_get_pfvf(rvu, pcifunc);
>>  	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
>>
>> +	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
>> +		req.kw_type = NPC_MCAM_KEY_X4;
>> +		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
>> +	} else {
>> +		req.kw_type = NPC_MCAM_KEY_X2;
>> +		req.ref_entry = eidx;
>> +	}
>> +
>How is the X1/DYN profile expected to be handled here?  In
>include/.../mbox.h the enum sets:
DYN profile can request X2/X4 entry.

>
>>  	*kw_type = NPC_MCAM_KEY_X2;
>> -	if (kw_bits > 256)
>> +	if (kw_bits > 256) {
>> +		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
>> +		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
>> +			dev_err(rvu->dev,
>> +				"Only X2 entries are supported in X2 profile\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		*kw_type = NPC_MCAM_KEY_X4;
>> +	}
>On a DYN-configured platform rsp.kw_type is NPC_MCAM_KEY_DYN (== 0), so
>the equality check rsp.kw_type == NPC_MCAM_KEY_X2 is false and the
>function proceeds to set *kw_type = NPC_MCAM_KEY_X4.
>The commit log says:
>    if the platform is fixed to X2 entries, fail with -EOPNOTSUPP
>    instead of requesting X4
>Is the intent for this rejection to also fire on DYN, or to only fire
>on X2?  As written, the dft-rule path in npc_cn20k_dft_rules_alloc()
>buckets DYN with X2, while this flow-install path treats DYN as X4-
>capable, so the same npc_priv.kw == DYN value drives different kw_type
>choices in the two callers.
>Could the patch handle DYN explicitly (or document why it cannot occur
>on the paths reached here) so the two sites agree?
This is intentional. if profile is X2, we can't alloc an X4 entry.

