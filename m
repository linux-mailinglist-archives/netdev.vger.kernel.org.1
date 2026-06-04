Return-Path: <netdev+bounces-295035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kv8kH1bkIGq/8wAAu9opvQ
	(envelope-from <netdev+bounces-295035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:35:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBE63C891
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="Q/4+E5O/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295035-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295035-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E39B301E3C2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67025228D;
	Thu,  4 Jun 2026 02:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C6305E19;
	Thu,  4 Jun 2026 02:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540498; cv=none; b=BZBJyP2CpO343oNrp49saj9oGHnhUr4zNQXRgFBR7HhAbMVhO8POsxcU3wcq6BlVQ/vgCWOlp53xxhDgteXiCyDlY76nxJ2a9+rEMpzHXjJXJBT9P9F8UD1rxXNjRM3mfYbNVY9E73fXgeyE7c8liNp9QwE2qRZNexpIetuCCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540498; c=relaxed/simple;
	bh=H90sG/Zk2IF1q2SnOw3VTS2EW6Q5akfAxNZX0x8sV7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq2hraXWs/9swvhZ6iJHMJhR1ngiq964ydZRZpYgY8hNlBaHfAwkiqqWBV3pL1w5SRwZjJzCYrIhAsPEf5rXsgYOl0xT1xi1TFaPRnlNSBTaYsSLm9vw8K/2YKOfDga4dVnn82zDmsy0Fm53TUALsMylcgenUFuBS/Vc+LTzi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Q/4+E5O/; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6542OOhN1140317;
	Wed, 3 Jun 2026 19:34:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=3r0DRFp7hOzTRzeyXiD3wlUCm
	PWmwnMfHYWySSErgQw=; b=Q/4+E5O/bTnr0i0PJILeTWTqXVDwT+r0u7HslzXBP
	b5e0fSQ2dMsq2yJj0hK3Are3DDaipIw3RmqO3bM5SznWNPWJ4LjTK/1gDokDHMEd
	j8ba/2D0hNSCHOmAZJiq+2D+PClMeJECmfHIAqJ5dLV0LF/lYMjg0sviwMWs4G80
	Vn+yzcRg6XV83H5ujGdmFP6NVe3wkuhZa/kasggrr+6v7la8Rq1xhAjEYZYhzPDr
	SU3S0b3oRHEuaMeE8L0j7fNdnPGHJyI98rdFwIH2MAHCunG88C61ew3oHRpxONKi
	wvqr3ZDcipSOz+LU54S1ZA7ntahDALsrsgC28YsNMGZdA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ejf1r3n8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 19:34:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 19:34:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 19:34:46 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 251933F70A2;
	Wed,  3 Jun 2026 19:34:42 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:04:42 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 4/8] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <aiDkQpm1EXHfJbXa@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-5-rkannoth@marvell.com>
X-Proofpoint-GUID: cJYAfRNRi8gPSFvEfnrHiXr-zj6LdBL3
X-Authority-Analysis: v=2.4 cv=Mv5iLWae c=1 sm=1 tr=0 ts=6a20e447 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=XbLZxbNFyJJysKvTIZAA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: cJYAfRNRi8gPSFvEfnrHiXr-zj6LdBL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyMyBTYWx0ZWRfXz1bxJMp8SBRJ
 CjY95hHPjNeC/UC6YZgcf0ilDF6j5G23bXyPqCyoeDPdKfasPKI+ODO+dGD4iTb6lc/hENVNRNN
 klKpyQOYdzhWpHMeQ6N6bq7YTDJNXthtI3Y0aJuh97RjFFNx0i+5fC/0ftwyldQ9TKonOdsAE6q
 JVQG5RKHdh1ExDPdYFC903kNbJk73RZPt6MZwGhYmIXnTfRQ6GZRsrQf7QGXlPstxKVpYtojqV7
 ugv1dPV+qCztyOG8RhX2IPnqeWRxQf7vWZKz2UTAzBIqgqvsJE800tByDB0/jLhBGK2yTtfTlSr
 7RY8+t3zX8mZK3sC0BDlZVAIZTwHv5+4JAzcCBnuJZIZdfLp80ObdMeIsKYG4pOsz98weUiq2w1
 1ckTKq26cUa5gaYJooa/k4tjsWxyVD+03hXlOOp639SAuGJUxe6vthRvcNVxnRvwr8IgDjGRugk
 IYEvelDdjCfdT6FiFFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-295035-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,rkannoth-OptiPlex-7090:mid,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: C3BBE63C891

On 2026-06-02 at 11:33:55, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

> @@ -3906,6 +3906,122 @@ static void npc_unlock_all_subbank(void)
>>  		mutex_unlock(&npc_priv.sb[i].lock);
>>  }
>>
>> +int npc_cn20k_search_order_set(struct rvu *rvu,
>> +			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
>> +{
>> +	struct npc_mcam *mcam = &rvu->hw->mcam;
>> +	int rsrc[2][MAX_NUM_SUB_BANKS] = { };
>> +	u8 save[MAX_NUM_SUB_BANKS] = { };
>> +	struct npc_subbank *sb;
>> +	struct xarray *xa;
>> +	int prio, rc, err;
>> +	int sb_idx;
>The rvu pointer is taken as an argument, but the state being mutated
>(subbank_srch_order, restrict_valid, npc_priv) lives in file-scope statics
>in cn20k/npc.c. The rvu parameter is used only for dev_err() and to grab
>mcam->lock. Devlink parameters are per-device, so what happens on systems
>with more than one CN20K AF instance? It looks like setting npc_srch_order
>on one instance would silently apply to all of them, and a get on any
>instance would return whatever the last writer set globally. Was this
>intended, or should the state be moved under struct rvu (or its hw/npc
>container)?
There is only one AF device per system.

>The save[] array stores sb->arr_idx, but arr_idx is u16 in struct
>npc_subbank while save[] is declared u8. With MAX_NUM_SUB_BANKS == 32
>today the values fit, but is a BUILD_BUG_ON or a u16 declaration
>appropriate so that a future bump of MAX_NUM_SUB_BANKS does not silently
>truncate restored values during rollback? The neighbouring rsrc[][] array
>is correctly typed int.
Maximum subbank available on highend SoC is 32.

>> +	for (int i = 0; i < cnt; i++)
>> +		subbank_srch_order[i] = (u32)narr[i];
>> +
>> +	restrict_valid = false;
>restrict_valid is unconditionally set to false here on every successful
>set, and there is no path elsewhere that sets it back to true. The flag
>gates several other behaviours in cn20k/npc.c:
>  - npc_subbank_restrict_usage() returns false once restrict_valid is
>    false (disabling the minimization of allocations from restricted
>    subbanks).
>  - The "Allocate from restricted subbanks" fallback loop is skipped.
>  - npc_defrag_skip_restricted_sb() always returns false.
>Is it intended that the first userspace set of npc_srch_order silently
>disables the restricted-subbank usage-minimization feature and the
>restricted-subbank allocation fallback for the remaining lifetime of the
>driver? If so, could that be documented and exposed through the same
>uAPI so userspace can observe and revert it?
This is intentional. Once user change srch orer, "restrict_valid" is invalid.

>> +fail:
>> +	for (prio = 0; prio < cnt; prio++) {
>> +		if (rsrc[FREE][prio] == 1)
>> +			xa_erase(&npc_priv.xa_sb_free, prio);
>> +
>> +		if (rsrc[USED][prio] == 1)
>> +			xa_erase(&npc_priv.xa_sb_used, prio);
>> +	}
>> +
>> +	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
>> +		sb = &npc_priv.sb[sb_idx];
>> +		sb->arr_idx = save[sb_idx];
>> +
>> +		if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> +			xa = &npc_priv.xa_sb_used;
>> +		else
>> +			xa = &npc_priv.xa_sb_free;
>> +
>> +		/* Since the entry already exists, xa_store() replaces
>> +		 * the value without a kmalloc(), making failure highly unlikely.
>> +		 */
>> +		err = xa_err(xa_store(xa, sb->arr_idx,
>> +				      xa_mk_value(sb->idx), GFP_KERNEL));
>> +		WARN(!!err, "Failed to rollback sb=%u idx=%u\n",
>> +		     sb->idx, sb->arr_idx);
>> +	}
>Is the comment above accurate on the failure path?
>The first loop in fail: erases keys where rsrc[FLAG][prio] == 1, which
>are exactly the prio slots written by completed iterations. When the
>rollback loop then writes the saved subbanks back to those keys via
>xa_store(xa, sb->arr_idx, ...), those keys are no longer present, so the
>xa_store has to allocate a new node and is not a simple replace.
>Under memory pressure that allocation can return -ENOMEM, and the only
>response here is WARN().
rsrc[FLAG][prio] == 1 indicate entries which are newly allocated. So rolling back
will delete those. Other slots do exist, so xa_store() wont fail due to memory pressure.

> +static int rvu_af_dl_npc_srch_order_get(struct devlink *devlink, u32 id,
>> +					struct devlink_param_gset_ctx *ctx,
>> +					struct netlink_ext_ack *extack)
>> +{
>> +	bool restricted_order;
>> +	const u32 *order;
>> +	u32 sz;
>> +
>> +	order = npc_cn20k_search_order_get(&restricted_order, &sz);
>> +	ctx->val.u64arr.size = sz;
>> +	for (int i = 0; i < sz; i++)
>> +		ctx->val.u64arr.val[i] = order[i];
>> +
>> +	return 0;
>> +}
>The restricted_order out parameter is written here but never read. The
>same is true in rvu_af_dl_npc_srch_order_validate() below. Is the
>intention to expose whether the default (restricted) order or a
>user-provided order is currently active to userspace, perhaps via a
>separate read-only param? As written, the value never leaves the local
>stack, so userspace has no way to learn it.
if default srch_order is modified, restrict_order will be false. No need
to read this value from userspace.

