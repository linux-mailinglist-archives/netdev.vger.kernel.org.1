Return-Path: <netdev+bounces-297431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ys8nJg3rKGrJNgMAu9opvQ
	(envelope-from <netdev+bounces-297431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF5665CC0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=cxTXfdCf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297431-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297431-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D713029771
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E52370D56;
	Wed, 10 Jun 2026 04:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40622370ADE;
	Wed, 10 Jun 2026 04:40:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066457; cv=none; b=ra/q9HqWB5HnJjvHFyl44EZKrljVzXbtIZJ8ykgpWjb70VkbK91RJHKGaBn7mQD+O4Zh7NGTG02igV50Wi3R+1f4AacPhPn81bIRNX+R9TadXyP4bdDwboceXt++9Jeo0saj6p5gKR/Q4xjsiq4excS2A2m8LdN7utXCE2qfx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066457; c=relaxed/simple;
	bh=3GLzMzMWzHcgWlHQSVS3lAMZrHIdlDxpq1gWarG2SQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzF966/NydKPIzU1l4PZkh+aOLaO/6BprUUaVrUDAhWCCg92ulshTxLfPnA3CUrXoDZkG91cD4OPWoVrqmnWfVJTu+/gdTquxPbF3qcNE9J/JcAX9mJCfxGB+iQBDz4U2ZiUTmxXiG7R7LUGXAJQz+0IpiN8UKCqAli6nWj+sIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cxTXfdCf; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vO6n2480503;
	Tue, 9 Jun 2026 21:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=s7dF2MRv6Jk+iHuZHEAKeXpCv
	F5Alk91ghd1FDl5/aA=; b=cxTXfdCfzuCgHiDOyELbzBw4VcfNBiOhOHJo8QSUJ
	SSnBWlx6aaXX2ALJ8xD6yTLEBboM+k4Ao7XP8nDRcfONCzuPwxyQa6nmyTGmTq1F
	xpfPJne94F+TkY06bT84Qai2ilzFXoeoYY7B/kB838BhCZRTTZbS9GzktR5Hrza0
	9HApz84vhQHouZAqDNNsaqyWb/JY71rkvvSChi6lwKPHQftdNhfsxcyCeSGP3oSE
	X9wfhbPSTRe88YFzgjytfN8EfT6UhFWb4CkqV1Oph01HPHoXUZu0MIuBTAWWnxL6
	7I5FJdt7YK6QGh5ivamnJL9YRVX99bW6LOmbAPxB5p3Uw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1m4fm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 21:40:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 21:40:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 21:40:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2C22B3F708C;
	Tue,  9 Jun 2026 21:40:32 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:10:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <aijqwB_I1wCuK-O7@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-10-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA0MCBTYWx0ZWRfX8+zCzuHp3kd8
 9Ag8KTXGHVw2J6JFaugTOKScVFaHDqIiPdIRxxRh6SiGhSw7n+LPTBOsht2UsL6AuIX4Il0dmK3
 oW1Ac35yrpKTPqu6Q4rl8Rpt/+BasNM30wyOJI0IlurSWG4iJWgxl/hItl+6wEYD3DUAkxrNYRH
 1k5T6Crx4hdyXKg5KJbKUpXzE2pPVDwEUvZDmrNct0igxeP9zdsyH/50Bv1TyqAToUkxslT4Sbq
 QgNsEjuGmwFmMmTo7aUvqGMxhZk2AF92gtv7+zAyBTeIUGHO31IREiwEFtSzOjlkDVw4w2dLuLg
 SgqF/77d2w9eVzWfducVLm0ooqJYrwEg+FbX7nSbsY6iUUbN4JVn4+LEn12xy1HM2HWnxXb1PrE
 cwqfaIvoTiNUaWjVSFV3rKCuPDPfuOonUmX2WZFdf4szeypeAhAoW9Kr4FMf5AUeaqjGTgvWfNf
 Fs1ibvN4wOgAqEzh2KA==
X-Proofpoint-ORIG-GUID: IUjMnVf57qqt1wusMBJzn2kkRxjFZozH
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a28eacd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=uPBvA63fQY4s203GtrEA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IUjMnVf57qqt1wusMBJzn2kkRxjFZozH
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297431-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:from_mime,sashiko.dev:url,rkannoth-OptiPlex-7090:mid];
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
X-Rspamd-Queue-Id: 1FDF5665CC0

On 2026-06-09 at 09:34:53, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://sashiko.dev/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

> @@ -397,6 +398,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
>>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>>  			    npc_priv, &npc_vidx2idx_map_fops);
>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>Does allocating this memory dynamically per-device but assigning it to a
>static global pointer break multi-device support?

Exist only one AF device per Soc

>If there are multiple RVU devices, the second device will overwrite the
>global dstats pointer, which leaks the devm-managed memory of the first
>device.
No.

>Also, because it uses devm_kzalloc(), if the specific device unbinds, the
>global pointer is freed and left dangling, potentially causing a
>Use-After-Free for the remaining active devices.

Next rvu probe() would allocate this memory again during probe(). Use will happen only after allocation.
As part of hardening series (post merge of this series), will plan to move this
pointer to "rvu" structure.

>>  	/* mcam_idx should be less than (2 * bank depth) */
>> -	if (mcam_idx >= npc_priv.bank_depth * 2) {
>> +	if (mcam_idx >= npc_priv->bank_depth * 2) {
>Can npc_priv be NULL here?
>If a mailbox message is processed before npc_cn20k_init() fully allocates
>npc_priv, or if initialization failed and left it NULL, this will cause a
>kernel panic. Should there be a check to ensure npc_priv is allocated
>before dereferencing?

mbox message is from PF/VF. PF/VF driver need AF driver to intialize properly. if npc_priv is NULL,
AF driver probe will fail as npc_priv is allocated during AF driver probe.

>> @@ -1825,37 +1823,37 @@ int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
>>  	int bank_off, sb_id;
>>
>>  	/* mcam_idx should be less than (2 * bank depth) */
>> -	if (mcam_idx >= npc_priv.bank_depth * 2) {
>> +	if (mcam_idx >= npc_priv->bank_depth * 2) {
>Can this crash if npc_priv is NULL here?
>Similar to the above, unconditionally dereferencing npc_priv here might
>lead to a NULL pointer dereference.
Same comment as above

>> @@ -4251,8 +4249,8 @@ int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
>>  		return -EOPNOTSUPP;
>>  	}
>>
>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>>  	return 0;
>Is it possible for rvu_mbox_handler_npc_get_pfl_info() to be called before
>npc_priv is successfully allocated?
No

>If this mailbox handler fires while npc_priv is NULL, it will panic. Before
>this patch, accessing the uninitialized static struct safely returned zeros.
Mailbox request is from PF. PF driver will fail if AF is not intialized properly.
npc_priv is allocated during AF driver probe().

>> -	npc_priv.num_subbanks = num_subbanks;
>> -	npc_priv.bank_depth = bank_depth;
>> -	npc_priv.subbank_depth = subbank_depth;
>> +	npc_priv = kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
>Could this overwrite the global npc_priv pointer if multiple RVU devices are
>present?
First patch in the series enforce only one AF device per system.

>
>> +	npc_defrag_list_clear();
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>Will setting the static global npc_priv to NULL during teardown crash other
>active devices?
>If multiple devices are present and one is unbound, it will free the shared
>global npc_priv pointer and set it to NULL. The other active devices will
>then crash the next time they attempt to dereference it.

Same comment as above.

