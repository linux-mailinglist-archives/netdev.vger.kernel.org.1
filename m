Return-Path: <netdev+bounces-281308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F8OCbM472mD+gAAu9opvQ
	(envelope-from <netdev+bounces-281308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E445470DD9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0587530465E2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF93B47D9;
	Mon, 27 Apr 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DsmIitmc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246730B50F;
	Mon, 27 Apr 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284810; cv=none; b=W8ijb3lz4cNpaw/xl6bMD0vbWl8RdWaJJRIKbRCwP9oa4jcjNjWYVgzr4pm6xIe46aXol8OmfKYgL0Sf0QZKd4tIfVEM0uz7OtaEeeFYrtS0gaUd1nVQExGEMW/Z0eY2r2Zhw6RAMwgFuuZxjMiGg6es6JSP2RB/z8Ntkoqh0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284810; c=relaxed/simple;
	bh=UeqCMMzoG9CELW2fZlC+nmLBUqur/Y4vHS2JDjP2CEQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8QfFFTJtzbaBm1JOgpLkkF3nQLYUZr8SIfOubMn+HdkTQheSC4YaCWZn62cTzXE+sDlJvWIwGUpg+ChUFaWNCYr5vQTIOyMjSDqfiG5HvvcSj1MRJYkLLyfj7SB+kuqIw1ccyGOjtJPbdsp3F58pgz35JLyHA5zpyKfp80kV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DsmIitmc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNwP382731787;
	Mon, 27 Apr 2026 03:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=lbqSsMu7yqY94yEngqATffO5H
	YrE4Qxg9hsIjTc50so=; b=DsmIitmcfU3UwbFNKkesgoPqwlLoDbiT0Wz0sA9Ey
	9ZWU750S+NT1E58sfBHuiyZ3T1/ghDztXjZdV35UJh/XsQbdoYT+hcWDGxz0uIUz
	snc4LP1lpncHaeO32GoTwcxZfgs4pfxCKT2CGZ/blF+hHX5yiYLNPfPuCRNYakuJ
	MY0f7k6UG2x3qWZJrnToIR0kp3tX/j6lJ2HFqR11R5DLRXCsdvDSxyUeiIkrBbDM
	UWbcPDRSbseMwaXtrKDzOSExSpbkUGmyylEPpS24V0j9CSKr9paTucWO09hnDYWn
	rF0XkZzJtVGybvJljTCO15jH7Eb2kVv4WIp9qpwFk7BpQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fkem1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 03:13:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Apr 2026 03:13:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Apr 2026 03:13:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AA8D43F7048;
	Mon, 27 Apr 2026 03:13:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:43:16 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v4 net 10/10] octeontx2-af: npc: cn20k: Reject missing
 default-rule MCAM indices
Message-ID: <ae82vNpsiqKQh18V@rkannoth-OptiPlex-7090>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
 <20260427063213.3937451-11-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427063213.3937451-11-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: 0eDBqiNGonHpP0aUCH3wzEftjykO7ALI
X-Proofpoint-GUID: 0eDBqiNGonHpP0aUCH3wzEftjykO7ALI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwOCBTYWx0ZWRfX38pN0lndO4YS
 ngFg6ef2a63PFuFxOaiUVIuc709JpoEAOaW94vTuTZ/gXYANRfc4igOQPoiWmr0FO1g7U90uXJE
 ONDtfElmfQIEOnpugHXgOmbwCnS7CdnL4IP6cCHgMttHwaQmdjdYNWzepoxeVil0Q/04FOTiMzu
 Ah3vY7v4aV/qJ/sYLCCPS7xvUSq4aIQ6fPBd5sDATPpyp3xWMCnx4iXUfvq2yB3C+w5g5D5M/ru
 8mUEDuosbp/52lY/np+iCIYCKnxBx/A2cJ7nurXgkBYQMgn6fyw6XDUEw1phXEVQX8VMsNStMaE
 PZJfj1JQTzO4FfaDxwop5w8QPk2EZutUjtjX1pg0pUrFN/1CUwQ9J1kzC2YDhSGn1mcdueDs5Ms
 jsdiKAnP5z/KcirYHbEO5V4kHeVFimDmfRTcCH2UsMh5GYC4zYvVycfkvJc2VvhE1W8wp2nY8I7
 cYEkvOkR43kxu4AX6DQ==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef36c1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=D3U6KnTYFKdaAklCq_8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 7E445470DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281308-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-27 at 12:02:13, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> When cn20k default L2 rules are not installed,
> npc_cn20k_dft_rules_idx_get() leaves broadcast, multicast,
> promiscuous, and unicast slots at USHRT_MAX.
> npc_get_nixlf_mcam_index() previously returned that sentinel as a

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 5d349d131fdb..9e6c79d6fadf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
[ ... ]
>> @@ -3897,6 +4006,14 @@ int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
>>  	/* Read the default ucast entry if there is no pkt steering rule */
>>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
>>  					 NIXLF_UCAST_ENTRY);
>> +	if (index < 0) {
>> +		mutex_unlock(&mcam->lock);
>> +		dev_err(rvu->dev,
>> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
>> +			__func__, pcifunc);
>> +		goto out;
>> +	}
>> +
>Should this path set rc before jumping to out?
>Looking at the surrounding function, rc is initialized to 0 and the out
>label simply returns rc:
>    int index, blkaddr, nixlf, rc = 0;
>    ...
>    out:
>        return rc;
>The adjacent nix_get_nixlf() failure path assigns rc before the goto,
>and other error paths in this file use return NPC_MCAM_INVALID_REQ.
>On this new error path rc stays 0, npc_read_mcam_entry() is skipped, and
>the handler returns success with rsp->entry left zero-filled. Would the
>requester be unable to distinguish this failure from a legitimate reply?
>Would assigning rc = NPC_MCAM_INVALID_REQ (or another negative errno)
>before goto out be more appropriate here?
>> read_entry:
>>  	/* Read the mcam entry */
>>  	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,

pw-bot: changes-requested

ACK. will set rc for this error path.

