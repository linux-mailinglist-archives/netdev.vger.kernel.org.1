Return-Path: <netdev+bounces-281285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKqjBXMw72mb8wAAu9opvQ
	(envelope-from <netdev+bounces-281285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8C4701AC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 076B2300AEC2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB13B38A4;
	Mon, 27 Apr 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Aj/Xs1H8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F353B3886;
	Mon, 27 Apr 2026 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283163; cv=none; b=erJWpGlsLpiVkE8QZfJEHwmUKcCwTWBQ6lUtXtjxWizDr5nZlVnmza4iygDEDEpxdtdIwtjTSO9dYRbvtEzTH7/GWH6MsC2sStCm4bxnimrh7V4SzPRl7nz/hqQ47Jjwea14bw2j+s61GY3hdpi5X8uJrNR3hI46XNQlWNteScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283163; c=relaxed/simple;
	bh=GKISB11NofBEJyFg/7+39pZ5zC20cEO5sg5O35AroI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gszn4gYVNXth+uYl2CZwXxbjXb362G6w8YwSSo3y8pUOFRIDPbYNopTGc9Zpfo6SRGg647s1+sxOkY8Kg8XZRd3sucIryP4pNjyuMTlmSUNgQXupK9uexJ/vGzZPevzvzgIhAr7O4OkoAlP9u8W1xOIcTu6QWNbVRVo3P6K6Wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Aj/Xs1H8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNnFKD2714762;
	Mon, 27 Apr 2026 02:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cv8Pd86VIJLFlJzvwdS4pUpsn
	ebgBEGw49EzIDaBZN8=; b=Aj/Xs1H8cuWXcoXOhzHBja8A9GvXer9w7xHtvGSJY
	s/Wb8YPpbmNUt/m6ztZq8MX6M6CQlK0Os6KCvE/Y90s7YQwQZIBBHyN6zGEZQwzf
	wjOdhiQ/rBZBprlRFEe2tpVZiLTeJTLTPK+mC5icLtcm+nQDtqGT9JlB7mgFTkKr
	j29/Y43yWHFxVUzss6gPm3h9Z62b2vkFPwPPrMmJeF3rcMkbVZ9V0hvkXWFQoWH+
	k2zyPZXFmSsQ8VqStpj/Sg4tuBZYLGPkkz1G8lK7Jci8AjwTvKda+QA7LYifu/Q9
	TYpdAezkWvNeuFpGcdoHuhV+rCWMdUC4+JdIU+BJ9i5gw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fkbxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:45:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Apr 2026 02:45:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Apr 2026 02:45:51 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D343B3F7051;
	Mon, 27 Apr 2026 02:45:47 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:15:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v4 net 01/10] octeontx2-af: npc: cn20k: Propagate MCAM
 key-type errors on cn20k
Message-ID: <ae8wSuXlBdTJBkbu@rkannoth-OptiPlex-7090>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
 <20260427063213.3937451-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427063213.3937451-2-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: yCFqwXi-1mW_EFk5t7bEx5CxWMxDt2iX
X-Proofpoint-GUID: yCFqwXi-1mW_EFk5t7bEx5CxWMxDt2iX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMiBTYWx0ZWRfX1yh0MdDHAI0N
 +0N5/0Q1t2Uymp6adrxHzFfmpy9AESq2HkSsc+dczP0ShV3hdmwfXu5e5RhgOF/AHdax1jTgSoW
 pKh3dmdQ6R2I408onyinIEpPg3uCL8xu14svkW3t/wvHMsMhVVkcHYddHYLX/YePmwsJkEKhwUA
 0ycmrToSY6FNA78qLGxtUM3J9hQyf/kdLSlIjR1YZ+LzCjwKHYNcprB4Efm6oI2iPfBGF38US/G
 FQ9mt3DD9mPDQ4adKbCX39WKPo2ptz2n0ADG36mhRJLqDi9jt8E8fsF+5TTDeQMydgZHscutX3F
 eu5CM7uWPnse3XyvY4kvIF+MB1knOUbZgxRzjFU1dvCP/e0nS0K4R2k9Pvp5kmY5RyTFUbVg3ig
 Ak7j5KkHsttu0eLFBkQWnDaS1yCNB1QbXJKzb5jHKiz8eUv0mtTtAMvkWBJOcCwpJmJyQlvBwdb
 zT9NbwCP6xnnSVRpV+w==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef304f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=myqBFw-2QgD3Hr5p_gkA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 7CF8C4701AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281285-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-27 at 12:02:04, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_mcam_idx_2_key_type() can fail; callers used to ignore it and still
> used kw_type when enabling, configuring, copying, and reading MCAM
> entries. That could program or decode hardware with an undefined key
> type.
>
> Return -EINVAL when key-type lookup fails. Return -EINVAL from
> npc_cn20k_copy_mcam_entry() when src and dest key types differ instead
> of failing silently.
>
> Change npc_cn20k_{enable,config,copy,read}_mcam_entry() to return int on
> success or error. Thread those errors through the cn20k MCAM write and
> read mbox handlers, the cn20k baseline steer read path, NPC defrag
> move (disable/copy/enable with dev_err and -EFAULT), and the DMAC
> update path in rvu_npc_fs.c.
>
> Make npc_copy_mcam_entry() return int so the cn20k branch can return
> npc_cn20k_copy_mcam_entry() without a void/int mismatch, and fail
> NPC_MCAM_SHIFT_ENTRY when copy fails.

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260427063213.3937451-1-rkannoth%40marvell.com

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 7291fdb89b03..8d5cee833af7 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>[ ... ]
>> @@ -1335,11 +1354,10 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
>>  	if (is_pffunc_af(req->hdr.pcifunc))
>>  		nix_intf = req->intf;
>>
>> -	npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
>> -				    &req->entry_data, req->enable_entry,
>> -				    req->hw_prio, req->req_kw_type);
>> +	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
>> +					 &req->entry_data, req->enable_entry,
>> +					 req->hw_prio, req->req_kw_type);
>>
>> -	rc = 0;
>>  exit:
>>  	mutex_unlock(&mcam->lock);
>>  	return rc;
>Is it intentional that this handler, and the other cn20k mbox handlers
>touched here, now return a bare -EINVAL from the new failure paths while
>every other error exit in the same handlers returns one of the
>NPC_MCAM_* enum codes defined in mbox.h (NPC_MCAM_INVALID_REQ,
>NPC_MCAM_PERM_DENIED, NPC_MCAM_ALLOC_FAILED)?
>A caller switching on those enum values would not match -EINVAL coming
>out of npc_cn20k_config_mcam_entry() or npc_cn20k_read_mcam_entry().

I agree, Error handler's need a lot of cleanup, and is a candidate for net-next.
This patch is to fix a smatch error; so dont want to address this comment as part of this change. will
do as a followup patch

> @@ -1361,11 +1379,13 @@ int rvu_mbox_handler_npc_cn20k_mcam_read_entry(struct rvu *rvu,
>>
>>  	mutex_lock(&mcam->lock);
>>  	rc = npc_mcam_verify_entry(mcam, pcifunc, req->entry);
>> -	if (!rc)
>> -		npc_cn20k_read_mcam_entry(rvu, blkaddr, req->entry,
>> -					  &rsp->entry_data, &rsp->intf,
>> -					  &rsp->enable, &rsp->hw_prio);
>> +	if (rc)
>> +		goto fail;
>>
>> +	rc = npc_cn20k_read_mcam_entry(rvu, blkaddr, req->entry,
>> +				       &rsp->entry_data, &rsp->intf,
>> +				       &rsp->enable, &rsp->hw_prio);
>> +fail:
>>  	mutex_unlock(&mcam->lock);
>>  	return rc;
>>  }
>When npc_cn20k_read_mcam_entry() fails here (and in the base-steer
>read handler below), rc is returned but rsp->entry_data and friends
>may be partially populated or untouched. Should the response buffer
>be zeroed on the error path, or is it documented elsewhere that
>callers must ignore rsp on error?
Callers won't use rsp upon error. So we can ignore this comment.

>> @@ -1415,14 +1435,14 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>>  	else
>>  		nix_intf = pfvf->nix_rx_intf;
>>
>> -	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
>> -				    &req->entry_data, req->enable_entry,
>> -				    req->hw_prio, req->req_kw_type);
>> +	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
>> +					 &req->entry_data, req->enable_entry,
>> +					 req->hw_prio, req->req_kw_type);
>>
>>  	mutex_unlock(&mcam->lock);
>>
>>  	rsp->entry = entry_rsp.entry;
>> -	return 0;
>> +	return rc;
>>  }
>Does this path now leak the MCAM entry on the new error?
>The entry was just obtained via rvu_mbox_handler_npc_mcam_alloc_entry()
>and its slot is recorded in entry_rsp. When npc_cn20k_config_mcam_entry()
>returns -EINVAL, the function returns rc without freeing the allocated
>entry, and it still writes rsp->entry = entry_rsp.entry so the caller
>gets an error alongside what looks like a valid entry index.
>Should a failure here release the entry (and likely clear rsp->

I agree; but this is also falls in same category of proper error handling; i believe
we can take this as part of follow up patch. Please suggest as this needs a lot of
code change to handle errors from all callers.

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> index c2ca5ed1d028..ecaf0946b852 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>[ ... ]
>> @@ -3266,7 +3270,10 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
>>  		npc_enable_mcam_entry(rvu, mcam, blkaddr, new_entry, false);
>>
>>  		/* Copy rule from old entry to new entry */
>> -		npc_copy_mcam_entry(rvu, mcam, blkaddr, old_entry, new_entry);
>> +		if (npc_copy_mcam_entry(rvu, mcam, blkaddr, old_entry, new_entry)) {
>> +			rc = NPC_MCAM_INVALID_REQ;
>> +			break;
>> +		}
>>
>>  		/* Copy counter mapping, if any */
>>  		cntr = mcam->entry2cntr_map[old_entry];
>> @@ -3284,7 +3291,8 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
>>
>>  	/* If shift has failed then report the failed index */
>>  	if (index != req->shift_count) {
>> -		rc = NPC_MCAM_PERM_DENIED;
>> +		if (!rc)
>> +			rc = NPC_MCAM_PERM_DENIED;
>>  		rsp->failed_entry_idx = index;
>>  	}
>Is NPC_MCAM_INVALID_REQ the intended code for a copy failure here?
>The sibling error paths in this loop propagate whatever
>npc_mcam_verify_entry() returns (NPC_MCAM_INVALID_REQ or
>NPC_MCAM_PERM_DENIED), and the post-loop block used to set
>NPC_MCAM_PERM_DENIED unconditionally. The copy-failure case picks
>NPC_MCAM_INVALID_REQ which is inconsistent with the existing codes
>for mid-shift failures in the same function.
Here rc was getting overwritten by previous rc. That is wrong. There is bigger
work to handle errors properly; that will be taken as a followup error code
handling. i believe, this fix change does not need to handle that. Please advise.

