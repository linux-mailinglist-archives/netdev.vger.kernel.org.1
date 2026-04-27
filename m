Return-Path: <netdev+bounces-281305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKEgMfc172kD+QAAu9opvQ
	(envelope-from <netdev+bounces-281305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A89470A0F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1D73341FD8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE339FCC4;
	Mon, 27 Apr 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Jj8KHvTU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82D3B3C01;
	Mon, 27 Apr 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284130; cv=none; b=IKzCd0gh7AhInqF+CXe+E8scBpxZmjsA5lAIIoiBi9+aJSWAIRUYq7Y7f9PLLC2UxHTrhueL4Ho2eYhWIwpAwOpFhbABDanQL74aZj76M6VzoiUyLS6VJlWOmfGkbmGsYilYalxUX0hhVTYAaCdYp6H952M4DgYrXbByxbhAkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284130; c=relaxed/simple;
	bh=hTZx7pIQvb2P8FDWlYI68A2TASFgRxoa3HkEI9cVcu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fomVNwpRK600NUs7i8xXRg4VEupwBCa6CErMWvj/hTDuqSrdo1BmWR1TgG7YE67+ybCapnIDzYronMsnhEYAIW8tv7JZAv+/2YF+c6msm1OwzOqRT5A6pOhEZfnLn4G1eOJaoLUSLFCOsECdGwf5Fd1B0l3Rc19+kaH4NkGuisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Jj8KHvTU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNIbLD3346006;
	Mon, 27 Apr 2026 03:01:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=90Bzya3UrsI59UgOweMJL5OFd
	ICPv3+6fQLdc1WSBf0=; b=Jj8KHvTUpz+dutIuBXFNO+ORyoRlerLS1HZqE2LzK
	zWHHGFXbqX3Rgj1n4ecUe0ZZF4Hx3YINan28Ksb8yv+MJIdwFoefhyBp0otwpIr+
	mpH2NZOvrhAdpCRpRtwe1RkvK78ckbVSqAWMEhaXgT+x0HLbIK51Ehl63jhBDXl7
	4NUJfdE9uQq+a1lWyuTdkNKN5znte8SjSaRWVLBlWhCZ6RGehGWOfkxV1AaWd9xH
	vtPGiHjapapCRNGXKuGzVNfNXo5CzHyXiX1wH4sSECGWlD0sC/HdxrVmSmAO2Z2h
	43Zkd4ItIPqcIrYKTWFPodx7fKe4HmpIQKxZLFvl2EK0g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4drtypbk0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 03:01:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Apr 2026 03:01:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Apr 2026 03:01:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 341753F7048;
	Mon, 27 Apr 2026 03:01:53 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:31:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v4 net 05/10] octeontx2-af: npc: cn20k: Clear MCAM
 entries by index and key width
Message-ID: <ae80EJ-oWJtyj_Ce@rkannoth-OptiPlex-7090>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
 <20260427063213.3937451-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427063213.3937451-6-rkannoth@marvell.com>
X-Proofpoint-GUID: x2kjONn3iud1U1dHFPBoaZ9HcFd-DutB
X-Authority-Analysis: v=2.4 cv=UfJhjqSN c=1 sm=1 tr=0 ts=69ef3416 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=9G3cXIxSvH1rmDkfS7sA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: x2kjONn3iud1U1dHFPBoaZ9HcFd-DutB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwNCBTYWx0ZWRfX5Q5hVYv6fN8m
 KSw0hgko+hipmD5zZZ50rcH/3oAxXhySltwaL5oQUssis9rjj0nTayNm/0Lm6KDVcT4fCOrZsFe
 XMNf5GJtsfIc0wo7KYcJvLheMKkFEnMWdFm7s161/qFxmH4DOULyRScCCkQLJroRKNCRiRueImd
 LFcjT3TtSlCVAgasFWfi4czyE6rGkF+TBgoB3vyBXs4lZch1kaQby1FB1wwkg9GaMdMrNY6u+TI
 3JffA3/BtFThB9dgks42Z+2kPjogH/N9ksbY9a768FIQ7+0kThcIHsc82Y1fE0lAKZy1kN/fcE0
 0CNIIsMhN0ijSQzfLV3sbWmAk5JLkO8WnuOIXNd7tQQKIMDx1yDdPgpA3/MYp9jsosBP6m0r0m8
 vNRZz+sfp8oYxlDB6lwMjPBUZvVcFCCRIrMaQK8HlSqUO8ebPLpiRflbKpih31xh1SK1vqrBmFB
 6Io30sy2xKHMlsbV36g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 30A89470A0F
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
	TAGGED_FROM(0.00)[bounces-281305-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
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

On 2026-04-27 at 12:02:08, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the old four-argument CN20K MCAM clear with a per-bank static
> helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,
> resolves the key width via npc_mcam_idx_2_key_type(), and clears either
> one bank (X2) or every bank (X4).
> Call it from npc_clear_mcam_entry() on cn20k and log when key-type lookup
> fails. Use the per-bank helper from npc_cn20k_config_mcam_entry() for
> pre-program clears.
> For loopback VFs, use the promisc MCAM index as ucast_idx when copying
> RSS action for promisc, matching cn20k default-rule layout.
>
> Cc: Suman Ghosh <sumang@marvell.com>
> Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

>> @@ -755,9 +762,15 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
>>
>>  	/* If the corresponding PF's ucast action is RSS,
>>  	 * use the same action for promisc also
>> +	 * Please note that for lbk(s) "index" and "ucast_idx"
>> +	 * will be same.
>>  	 */
>> -	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>> -					     nixlf, NIXLF_UCAST_ENTRY);
>> +	if (is_lbk_vf(rvu, pcifunc))
>> +		ucast_idx = index;
>> +	else
>> +		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>> +						     nixlf, NIXLF_UCAST_ENTRY);
>> +
>The commit subject and the Fixes: tag reference a cn20k-only change,
>and the comment added above says the new layout matches cn20k
>default-rules, but is_lbk_vf() is silicon-agnostic:
>    static inline bool is_lbk_vf(struct rvu *rvu, u16 pcifunc)
>    {
>        return (!(pcifunc & ~RVU_PFVF_FUNC_MASK) &&
>            (rvu->vf_devid == RVU_LBK_VF_DEVID));
>    }
>Is it intentional that this branch fires on cn10k and otx2 LBK VFs as
>well?
>Previously, for any LBK VF, ucast_idx was obtained from
>npc_get_nixlf_mcam_index(..., NIXLF_UCAST_ENTRY), which on non-cn20k
>falls through to npc_get_ucast_mcam_index() and returns the ucast
>slot.  After this patch ucast_idx becomes the promisc slot for all
>LBK VFs.
>The subsequent is_mcam_entry_enabled(ucast_idx) and
>npc_get_mcam_action(ucast_idx) now read a different MCAM entry on
>non-cn20k silicon, which can change whether an RSS action is
>inherited for the LBK VF promisc rule.
>Should this hunk be gated by is_cn20k(rvu->pdev), or is the
>behavioural change on cn10k/otx2 LBK VFs intended and worth calling
>out in the commit message?
This is intentional change.

