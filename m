Return-Path: <netdev+bounces-296353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7urnHBsqJmrkSwIAu9opvQ
	(envelope-from <netdev+bounces-296353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E94652425
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:34:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=feh8QNO4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B436130154A5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CA31B824;
	Mon,  8 Jun 2026 02:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0A31A07B;
	Mon,  8 Jun 2026 02:33:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885984; cv=none; b=PSVwA6lobjWvEjfy3gzwfhFidef0MkLBYTD/p/F3AhQCmutFklUgyq2a3besjdzRsY9MRxi771mRIOcqhWF7IzN06IiB7YZzDVNYXc8Ae32yM4yl0v/PohIvhJU1yj7pReoNtDmf3TXSQ2pR6M2TsVBnhZq5GiIQpIFu9TOTegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885984; c=relaxed/simple;
	bh=hRYA1v6TONHkk8dVg1Eh0j2KTA8iUyHFjBl7fyU0mGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qURAe2J/HKiMSoNx1WMbS/xraMbZ+TgkDth5ms+iKzh439oWhoU25Aj2RL7VRvrcI7VWsZwHKGSBFxjL5XmkylOI7W00ZjHrYBOF7tvKBkHbVFvG9xlyMTNiEpJrgsXjZU9Ed6hSqvWu3z6pEjTK0O6lmJi3WPszUDGz/uDf+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=feh8QNO4; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580E8oS888595;
	Sun, 7 Jun 2026 19:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EO35ypFmyTTHdbX+vOV3YFL7O
	077t34zhTJgKFXPeF8=; b=feh8QNO4BQMe3BQyLd1XrLwMk+m2TMOoLeVN3IvB9
	/Nv1BAODC2FaB6UdVlAjJ8Z3NcdzQP7FpJOl/6l5/sN7k3F6ClkdzGh0BOuzQhdT
	D9Jcxj5LaOZ32Zl7h2IhNahoEFb6lmlY+akB7AX3V1+EaqWLsTrETyE6i0ZX81LJ
	Pgg19uQieaLZtWhIATKV36+2X2oeR/+cxYqaqd6/M25Q9jY+7r4/AjrdBYgocC5v
	EnKRnegeWN8qHTi6m2KVhtLXOWzzSE2xUI9JGuWYGSVTvE0VUx/XjNeWu8KJuMR1
	C90ue7k2T2CAjWQpepHNTbVDTjROJtmAHj3xc0ekSkvTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8st49-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:32:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:32:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:32:52 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 03CBF5B6932;
	Sun,  7 Jun 2026 19:32:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:02:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <aiYpz6XSjNXzFNtF@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-10-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAyMCBTYWx0ZWRfX/cNE3QrxZB/g
 HbY58fVdsT4APFIFwuys+mx8kFFlEt/d/rFN0NCkarWkZRqBE3dlyltOnnCaUoppspRRfBmqS6x
 5oa/b1+NdEMrvYBwyCOO9gim1PiRTYEneRXs5cEOJoqcIK59Mvi8CPQsKBvN/cmkYxAG7m8W7ZF
 a6s5sT2iw33sIIHeojpJ4Ck89KUUUKu/DUNrX7PyfP1p0cZXpjse6mtLG8i9cojIp+hWUOtvNBx
 O7U7SQFWFjd9tRaEi/LufPhS4Sv65RXjKFi2ntEsa0r6quBpnrbNqz/h+DupMjbm6qhMJiIoslY
 VGM1oZQdPEkWweEezyAlZwkphEuUly+SjjwknuNPLzrAcUO30MkOsYWlwBPb2ih+hyrDNxCJYV4
 Y4kvm5fJ+cvpNpbn1NzB5tj81JnD9axcRYZq7CeKvRgXGl7LTr8mDWpobQTEcootBFeV1AiYB1g
 e8qHMItUTdkANPjNaKA==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a2629d4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=gmVcXd00UEk1ZtStJLAA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hOg0ES5fkkfv8KEGNfylvHo16a9DH8fl
X-Proofpoint-GUID: hOg0ES5fkkfv8KEGNfylvHo16a9DH8fl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296353-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rkannoth-OptiPlex-7090:mid,linux.dev:url,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: D9E94652425

On 2026-06-05 at 12:02:45, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>
> Allocate MCAM debugfs dstats via devm_kzalloc instead of a static matrix,
> and use the allocated backing store consistently when computing deltas
> (including the counter rollover compare).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says
:

>> @@ -397,6 +398,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
>>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>>  			    npc_priv, &npc_vidx2idx_map_fops);
>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>> +
>>  	debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
>>  			    &npc_mcam_dstats_fops);
>What happens when this devm_kzalloc() fails?
>The only caller is rvu_dbg_npc_init() in
>drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c, which invokes
>npc_cn20k_debugfs_init() as a void call and discards the return value.
>By the time the new -ENOMEM path is taken, mcam_layout, mcam_default and
>vidx2idx have already been registered via debugfs_create_file(), and
>dstats, mismatch, idx2vidx and defrag are then skipped. Three of the
>four skipped files (mismatch, idx2vidx, defrag) have no relationship to
>dstats and seem to be dropped only as a side effect of where the
>allocation was placed.
>Would it be better to either move the dstats allocation up to
>npc_priv_init() (or to the very start of npc_cn20k_debugfs_init() before
>any debugfs_create_file()), or alternatively gate just the dstats
>debugfs_create_file() on the allocation success while still creating the
>unrelated files? In either case, should the caller also be updated to
>honor the return value?

if "dtstats" debugfs is missing, it is still fine as this debugfs entry is used
only for live debugging.

>>  #include "cn20k/reg.h"
>>  #include "rvu_npc_fs.h"
>>
>> -static struct npc_priv_t npc_priv = {
>> -	.num_banks = MAX_NUM_BANKS,
>> -};
>> +static struct npc_priv_t *npc_priv;
>With the previous code, init_done was set to true only at the very end
>of npc_cn20k_init(), after npc_setup_mcam_section() succeeded, so
>'init_done == true' implied both the struct fields were populated and
>the hardware had been programmed.
>The new gate is 'npc_priv != NULL', but npc_priv is assigned by
>kcalloc() near the start of npc_priv_init(), well before bank_depth, kw,
>sb[], the xarrays, the mutex and the list head are populated. Does
>'npc_priv != NULL' still carry the same 'fully initialized' meaning that
>init_done used to?

npc_priv is initialized in npc_priv_init() during probe(). if any of the initialization
fails, npc_priv is freed and set to NULL, and probe() returns with error.

>> @@ -4251,8 +4249,8 @@ int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
>>  		return -EOPNOTSUPP;
>>  	}
>>
>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>>  	return 0;
>>  }
>Should this handler also gain an 'if (!npc_priv)' guard?
>The other public entry points were updated to check for NULL:
>  npc_cn20k_vidx2idx()
>  npc_cn20k_idx2vidx()
>  npc_cn20k_dft_rules_idx_get()
>  npc_cn20k_dft_rules_alloc()
>  npc_cn20k_dft_rules_free()
>but rvu_mbox_handler_npc_get_pfl_info() now dereferences npc_priv->kw
>and npc_priv->bank_depth without a NULL check. Is that intentional, or
>is the asymmetry just an oversight?

If npc_priv initialization fails, probe itself will fail. So these handlers are invoked much later by PF, which
will be active only after AF is fully up.

>>
>> -	xa_destroy(&npc_priv.xa_sb_used);
>[ ... ]
>> +	if (!npc_priv)
>> +		return;
>>
>> -	for (i = 0; i < npc_priv.pf_cnt; i++)
>> -		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
>> +	xa_destroy(&npc_priv->xa_sb_used);
>[ ... ]
>> +	npc_defrag_list_clear();
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>Previously the storage was a file-scope static, so teardown only flipped
>init_done. Now the storage itself is freed and the pointer cleared
>without any synchronization (no synchronize_rcu(), no flush of the mbox
>workqueue, no lock).
>If a racing mbox handler such as rvu_mbox_handler_npc_get_pfl_info() (or
>any of the npc_cn20k_dft_rules_* helpers) has already passed its
>'if (!npc_priv) return;' check but has not yet read a field, can it now
>dereference freed memory?
>The probe ordering may make this hard to reach today, but does the new
>free-and-NULL pattern introduce a use-after-free window that the old
>init_done flag did not have?

rvu_remove() disables mbox first, so this case wont happen.

