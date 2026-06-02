Return-Path: <netdev+bounces-294005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE7zNn1aHmoWiwkAu9opvQ
	(envelope-from <netdev+bounces-294005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0086280C9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A7C0307A7F3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948A3909A4;
	Tue,  2 Jun 2026 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JfXmo3vD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45438F94C;
	Tue,  2 Jun 2026 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374051; cv=none; b=KiWtnaGig+YWLBNAGLHFAeUlamcYr22OUwLiSCKz6ueGEMGsT/m9wyK0fQMEeF1OEfFzer0Ys6po381tsZisaCM9hOzdTWnNBMDTH3QCue8jBdFmUndD7MtuGYfFpF7irHz4Oh9v3Mzno5iOKYdveTpXs3hndD0zytuAkuI/ZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374051; c=relaxed/simple;
	bh=Kdkq8TqSgH5/GitlXilN0OQRiqPw42N/da+Gs/wQhqg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6CyL8ZTReaVTcLKkoFgqKk9GaRrSVj8BqSzeOZLHKJp2VlcSHeF/kyX+rogBoPU9t2qDKYAaghq97sYFtzuPUvB46d5Xj0k68U2eT64u8DaK+cR0BaX5WUG3p9tx0jE0M43/r3dtm7tjVldlO3BJ1x1zCF9SUydLgUlZgeoLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JfXmo3vD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651KreUW2822565;
	Mon, 1 Jun 2026 21:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6QVwi5+YD2Xd151pzvfXfS/4g
	f36o5dTNgxArtG4NtA=; b=JfXmo3vD23j5h9vCrvYPAZrEa0hw0sqH+f6Pud90x
	n3UL2SDILOusdizvlcsra8WDI9/+uzSvuYqqw4DgLbNzrF2srHNVEmdsJQAxbU7p
	W+K67S7YdtC0OrTcGU6YJB8uB8wU76BEcFrPzCIoyKsJa8Z5nv8qbLt3MJEKJ/oc
	0sRRijuGVak+1eNQBgG1JORknlRoL4VlfLAO1z4VlpAeVAF8L5Jf9W7IQtI51Kke
	TMptLrlKD+/CLkf+u1YtjqFCRGmy8+URTwee0GdHIwQin8DKrb1nzrxcdy/majPV
	/T938kZyeiIr3KNjSfvSuBSjXJOLaswPOeHItgCS4Z8WQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4egm56nx5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 21:20:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 21:20:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 21:20:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3ECF53F7062;
	Mon,  1 Jun 2026 21:20:36 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:50:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v17 net-next 8/8] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <ah5aE-oDgy7BzYEc@rkannoth-OptiPlex-7090>
References: <20260601025844.865865-1-rkannoth@marvell.com>
 <20260601025844.865865-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601025844.865865-9-rkannoth@marvell.com>
X-Proofpoint-GUID: 6m22LUdmqsmOw-2llUmzq6mqOW7MBy6O
X-Proofpoint-ORIG-GUID: 6m22LUdmqsmOw-2llUmzq6mqOW7MBy6O
X-Authority-Analysis: v=2.4 cv=ZeYt8MVA c=1 sm=1 tr=0 ts=6a1e5a18 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=UO200rvEumD2nOZpqV8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzNiBTYWx0ZWRfX3mmKiKxlYzp7
 R2dlBl2xAkgPs9tZf/wxPQ33B9rutZLd9wdYHvukRDtIKBazoBWLzGMNkrVxZ+ZuLDibGbWaUBt
 Ngbt7OzEpOG0eb3D3p4w+ngSO4O4KF6fM6icP8xstYL+zV/XzXRbG/ziygi5xO89LJG7jck55yc
 /QnoRkYyeMkWc+YdpiSlbk9anuidjbflWby5AIAKVG4GdY9KcoRsHWayV8V3nZyT4PT1BjLE4q2
 cqK9LZEnbc11nMG27H57rtrUasMPHe6+HOwCi8FaTr2ppvtEoFClS21eaejX21snbmvVt1gZjm9
 2kgUiIiuIJ+CfJOnmLuTQVSJjt0oeoUPaJGG978cLqoFZb8gRdCFhNu1hoiT2YUVmkyJdh3DqpX
 KMlT5VgsqaKGzUlShwZMpSZHbV9I0QMESbV1KrFG6TSgsJEMJj32zfI6rThkaZ1l6YdGohlA0fy
 Vn7i1Ev7v7cwWKE6phg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_FROM(0.00)[bounces-294005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 5B0086280C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 at 08:28:43, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.

>>  static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
>>  {
>>  	struct npc_priv_t *npc_priv;
>>  	int blkaddr, pf, mcam_idx;
>[ ... ]
>>  	npc_priv = npc_priv_get();
>>  	rvu = s->private;
>>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>>  	if (blkaddr < 0)
>>  		return 0;
>>
>>  	mutex_lock(&stats_lock);
>>  	seq_puts(s, "idx\tpfunc\tstats\n");
>> -	for (int bank = npc_priv.num_banks - 1; bank >= 0; bank--) {
>> -		for (int idx = npc_priv.bank_depth - 1; idx >= 0; idx--) {
>> +	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>> +		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>Could this unconditionally dereference a NULL pointer if debugfs is read
>after initialization fails? Since npc_priv is no longer a static structure,
>reading from it without checking for NULL will cause a crash here.

if memory allocation fails, debugfs entry wont be created in npc_cn20k_debugfs_init()

>  int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
>>  			    int prio, u16 *mcam_idx, int ref, int limit,
>>  			    bool contig, int count, bool virt)
>>  {
>>  	bool defrag_candidate = false;
>>  	int i, eidx, rc, bd;
>>  	bool ref_valid;
>>  	u16 vidx;
>>
>> -	bd = npc_priv.bank_depth;
>> +	bd = npc_priv->bank_depth;
>Does this function also need a NULL check for npc_priv before dereferencing
>it? If the NPC block fails to initialize, this will crash immediately upon
>entry.
No. if npc_priv allocation fails, probe() itself will fail.

>>  int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
>>  				      struct npc_get_pfl_info_rsp *rsp)
>>  {
>>  	if (!is_cn20k(rvu->pdev)) {
>>  		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
>>  		return -EOPNOTSUPP;
>>  	}
>>
>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>>  	return 0;
>>  }
>If the NPC block is disabled or fails to initialize, npc_priv will remain
>NULL. Since this mailbox handler doesn't check for NULL before dereferencing,
>will this cause a kernel panic when triggered by a VF? Previously, reading
>from the static structure safely yielded zeroes.
>
If the NPC block is disabled or fails to initialize, rvu af probe() itself will fail.

>>  int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
>>  				      struct npc_get_pfl_info_rsp *rsp)
>>  {
>>  	if (!is_cn20k(rvu->pdev)) {
>>  		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
>>  		return -EOPNOTSUPP;
>>  	}
>>
>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>>  	return 0;
>>  }
>If the NPC block is disabled or fails to initialize, npc_priv will remain
>NULL. Since this mailbox handler doesn't check for NULL before dereferencing,
>will this cause a kernel panic when triggered by a VF? Previously, reading
>from the static structure safely yielded zeroes.
There is only one AF device per system, so this case won't happen

