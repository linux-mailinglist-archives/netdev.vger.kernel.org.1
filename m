Return-Path: <netdev+bounces-294002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAXPMctWHmrfigkAu9opvQ
	(envelope-from <netdev+bounces-294002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63919627FA2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF1BA3009148
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB838D415;
	Tue,  2 Jun 2026 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MLjCvUTj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193B24A078;
	Tue,  2 Jun 2026 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373193; cv=none; b=pg+beURwoxIKx+t0D3SEJdBYUnIz/eNrYpBFn95H5XFEyyUDtAGM3JYrs2ajr1GHjD7gauNQ34+gqEy5Tl7JI9jQK942dhAs20AaXlVot+Yv1qjLLzAXMPgKcRS2Aimto6i+lwmZJLSdN2bYh+wJCh9EZmo3Kb4L0z4NmCLFRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373193; c=relaxed/simple;
	bh=6eUfyqEMp0Yv6H+rPXHs1UHcRv2RoHh1PzoHQFO1S1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIEJopqOAVZyG9BNiB66LWfDR5vguWy8dM9XCqMbDxHDQwThBsxeO8Xo7BSw12+4src8HT8okopfu8G4DlUwXJECkRZaY9s8xs+oVPgkgAVBfSptkqMd6cgdU2fltTrY7pwbDZaHgOe+uf16WjJQRvVx6Y36gDcaBMqmUEbwTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MLjCvUTj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520KUhf2859173;
	Mon, 1 Jun 2026 21:06:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=GIdw2s17SGmCSolRpcEcVMeaC
	M/t5bHkS95eqQY+Wfc=; b=MLjCvUTjld4ZmfBVwx1dwi6+hkpWwI1gRtk2lfUwU
	fwHfSLffnzIpxQA79RdQ2FMO/pLRJfJuyYsdoRmOrdaCGvwY730/n7nzDQPadQ5j
	9jP3TtMCu0WgtvlS8zezMlD9MQvUddjcBYr5D/BUhbjjH/wmcfbAFWCvgx7IAzPd
	rBkou6GB2SPcjnDC6O1GZL3foji/GupLYyvY5XQouePUpEyZwKVe061b6rfvs5oG
	mgBowYDji0d8t8RQaN8amh4Vq9SqvP8Qr1GMqDpgSdpDY1DYUQXAji4gqdsPQrEW
	lw1ZmKXVKZJVdHfepFU1wEFCYoggJ27R0rIDrTxcrBZjA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxra6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 21:06:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 21:06:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 21:06:21 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 08E4C3F7062;
	Mon,  1 Jun 2026 21:06:17 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:36:16 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v17 net-next 4/8] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <ah5WuEABiQTsZkbd@rkannoth-OptiPlex-7090>
References: <20260601025844.865865-1-rkannoth@marvell.com>
 <20260601025844.865865-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601025844.865865-5-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1e56bd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=cNC3KKuftjskVx5isFoA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzNCBTYWx0ZWRfX1/GnqfpFHgZt
 7bo2QIwJ/R4BJW3Au4Jh7znzg8GtY0sOZ73ALtxyvsJrD37y3mr6krD4WVpuWqNljdRrjj46Acw
 3rRAsNSkAPfrbYNrtXRceoHX12bsEyyUqEQvrZujrMvfg4S4Ewip6SxwraL7afWZxweDEd86DIx
 QvHOUYoMJ9Sn4vh4ZDyIV6bprhAn1GK9VTtfJFQU3GrXPqIwnKDFy4VmVOM1HL5614Jt1ZvWlHa
 r6Ls9lyRREzO/qBO3Epft9TCLfgt9ZCCRIneUbW+iI6HFkInSBY0KTnWaEeiP3orMc0uamKFK6V
 K9lwcqfy9zTDcBXK/P8EZ5kyeLXNEYDP9i7PRqffxx//doJ8lbBdPIlf9jVl6bNqAovMiOzF04l
 jXob2OpuvSH3szO+YLos8Dfre+jkolYQ4u0yFhURCAJWi6hI9yP4TcdfYCbKAEIilvIUa/d0p1I
 1Jrm8Fbct9GtpWPQtnA==
X-Proofpoint-ORIG-GUID: LTXlCcMGXPF1EWVIxkXLqV1xJwMBk4TX
X-Proofpoint-GUID: LTXlCcMGXPF1EWVIxkXLqV1xJwMBk4TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_FROM(0.00)[bounces-294002-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 63919627FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 at 08:28:39, Ratheesh Kannoth (rkannoth@marvell.com) wrote:

>> +	enum {
>> +		FREE = 0,
>> +		USED = 1,
>> +	};
>> +
>> +	if (cnt != npc_priv.num_subbanks) {
>> +		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
>> +			cnt, npc_priv.num_subbanks);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&mcam->lock);
>> +	npc_lock_all_subbank();
>This is a pre-existing issue, but does calling npc_lock_all_subbank()
>here trigger a lockdep splat?
>

Need to use nested lock or lockdep_off() to supress this. Since this is preexistig issue
will post a seperate fix patch after this series is merged.

>> +const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
>> +{
>> +	*restricted_order = restrict_valid;
>> +	*sz = npc_priv.num_subbanks;
>> +	return subbank_srch_order;
>> +}
>This is a pre-existing issue, but does the getter return an array that
>differs from the actual hardware mapping initialized earlier?
>During driver initialization, npc_create_srch_order() creates an array
>mapping priority to subbank index. However, npc_subbank_init() accesses
>it as sb->arr_idx = subbank_srch_order[idx], treating the same array as
>mapping subbank index to priority.
>The new devlink getter returns the raw subbank_srch_order array, while
>the setter applies it correctly as sb->arr_idx = prio.
>Because the initial hardware state does not match the getter output,
>will a user-space application performing a devlink get followed by a
>set with the exact same array silently flip the hardware priorities from
>the inverted order to the intended order?
Preexisting issue, will be addressed as a patch to net tree after the series
is merged

