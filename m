Return-Path: <netdev+bounces-297433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gAuMAn7xKGoJOAMAu9opvQ
	(envelope-from <netdev+bounces-297433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:09:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B2665DB1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:09:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=CRb+nUH1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297433-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9C2305A5D3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331873644CF;
	Wed, 10 Jun 2026 05:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CE33A9CF;
	Wed, 10 Jun 2026 05:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068102; cv=none; b=cRcn0SYQqN4H7jh5k893C3Lu0qfEgzUWSK+/JOXE4l2SR13eLyCAvO4QaQfVB67K9kPKkRvVQeM6wp/guJKTdYjIrVweVn/8t0YFPyj2yuSDNo3Wq0vF4WfKNOwMTrLglPS5PgHJ8NkldVJ6uiBsrQHDQF7V+ymK90ad7p8LqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068102; c=relaxed/simple;
	bh=56ykVSxhP4jJYDZxoiPuKDf82/tTDNLw+KCygLVGy8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRNtBVYk1K2Y0tYGh9qQ9Cs3z7ahpT78ixMrakdjbvNNlT0ZFvThltVKzJT9uy6CO2tlyWOYzAWK/9/QeMiawm0GyfniXFaXg6dFBEBFuhuf88sdP2t5Q7YVVisfb+F6j3M80/+LzgLHaeqNmrzxiVNct5JQt5ky++jxELEYYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CRb+nUH1; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vOY52480491;
	Tue, 9 Jun 2026 22:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=WBzB6/YmneL0QxPEVjfK94gOO
	szcvvcEGwK33bjdzOo=; b=CRb+nUH1gGN1wEqKTBt8wV4gkxWLsCUpKa2D+WLaR
	o35HwjHAjib5Csqnm1f5Ozf0TR3k/U7PaPdyJTOLqpvsFgzS9k+li/pjFq9bAOKY
	jRK6P3gvLtpLf2H146iC1OGgeh73aBfaawGABEgzIL8+rz9pI7kQ0gb9Hj41KNMb
	oPJD/JwWzsdos53NRetVAGEg00oGYv9UNvFKnBQ0Vb/JbQ7VestDC1O1BOfe0BQe
	ZMX7tKdKh7lmSAcZHwj2RKXeH9qnaw6lJQJemPYAIkPsVFbXQtuFl7BMHmwe4KEz
	Gviimju/+IrbmtluO0jjZGqQCYxFWDE63C50Y3SWN3VXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1m6m9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 22:08:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 22:08:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 22:08:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 43D213F708C;
	Tue,  9 Jun 2026 22:08:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:38:05 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 2/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aijxNS4BooInl2Si@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-3-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA0NSBTYWx0ZWRfXyfTEs/sxSK7m
 eQbyHkizCTqXejeL+qxlrG+E2w1ErVY04G4Wrdua5fbN3S/p6X4WhBVRptK/D3Nn9c4dE4TvinQ
 AsyCvrRPYU3CGy1w8uCNbj5ctCyHMwyLRvfUhoB+SLusNzLpW+oqXx/DazY0NW8OlHOhyo3vVEc
 XAK3dTQTSa6FUQeTfPkGQe7A1ESDKVT5Ap5bM5h7YCAOFmoI0NbUqryjjiSZN4Set55tYQkDmTa
 1o0JoEsIkbQno4rvLUIu8BocWK5GdPQh4A+rF4wPZtD7zIo+eHJ/RwrJIlLmuzsEARh21DjYrz/
 XIrN5Dc86J5F+unGnGzUcB4manuLjuDpB7hvdKHWqnSPL5MueYSlqpTrxdjTHWtbKVUYyxu9xfd
 HIiqeH7ljDOZI/UXNwo/xdmlwxOs0fItKCg89sWFOBMe6xpQpmi8QLJ/IjtQrofdfzd9R5vZQPM
 kXBhQxnS3nO1uiykbrA==
X-Proofpoint-ORIG-GUID: qbpRyo_6t2ZBg_q1AZn7hM0qynkIjzRb
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a28f13a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=Fkqlh9ncZL4VOkbnhOEA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: qbpRyo_6t2ZBg_q1AZn7hM0qynkIjzRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297433-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 507B2665DB1

On 2026-06-09 at 09:34:46, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.
>
> - Extend "mcam_layout" to show enabled (+) or disabled state per entry
>   so status can be verified without parsing the full "mcam_entry" dump.
> - Add "dstats" debugfs entry: for enabled MCAM indices, print hit deltas
>   since the prior read by comparing hardware counters to a per-entry
>   software baseline and advancing that baseline after each read (hardware
>   counters are not cleared).
> - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
>   but not explicitly allocated, helping diagnose allocation/field issues.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

> +				continue;
>> +			if (stats == dstats[bank][idx])
>> +				continue;
>> +
>> +			if (stats < dstats[bank][idx])
>> +				dstats[bank][idx] = 0;
>The dstats[][] array is module-global and the show handler both reads
>and writes it on every read.  A few observations about that contract,
>which the commit message describes as "hit deltas since the prior
>read":
>The baseline survives across npc_cn20k_enable_mcam_entry(..., false)
>followed by a re-enable with a different tenant.  If the new tenant's
>hardware counter happens to equal the cached baseline, this branch
>silently skips the entry:
>	if (stats == dstats[bank][idx])
>		continue;
>On counter rollback the code zeroes the baseline first and then
>computes the delta against zero:
>	if (stats < dstats[bank][idx])
>		dstats[bank][idx] = 0;
>	...
>	delta = stats - dstats[bank][idx];
>so the very next read after a rollback reports the full absolute
>counter value rather than a delta.  Is that the intended behaviour?
>Also, since dstats[][] is a single shared baseline, two concurrent
>readers (for example an operator session and a monitoring script)
>serialise on stats_lock but each read advances the baseline for the
>other, so each one sees only a fraction of the deltas.  Would
>per-open state (allocated in the open() callback rather than file
>scope) be more in line with what the commit message promises?

Thanks for pointing this out. The dstats matrix is intended purely
as a lightweight telemetry tool to identify which MCAM entries are
actively being hit by current traffic via debugfs, rather than
providing strict, transactionally guaranteed billing or accounting
metrics.
You are correct that a stale baseline could cause a transient
under-reporting on the very first read after a reallocation if the
hardware counter quickly surpasses the old baseline. However,
during that first read, the fallback logic will immediately catch
up and synchronize dstats[bank][idx] to the current hardware state
(stats). All subsequent reads will reflect completely accurate hit
increments.
Given that this is non-critical debugfs telemetry, i would like to
keep this as it is. or fix it as part of "net" tree.

>> +
>> +			pf = 0xFFFF;
>> +			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
>> +			if (map)
>> +				pf = xa_to_value(map);
>> +
>> +			delta = stats - dstats[bank][idx];
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&stats_lock);
>> +	return 0;
>> +}
>npc_mcam_dstats_show() calls npc_mcam_idx_2_key_type() and then uses
>key_type to decide whether to skip bank 1 for X4 entries, but it does
>not take sb->lock while doing so.  The existing npc_mcam_layout_show()
>in the same file holds sb->lock around exactly these field reads:
>	mutex_lock(&sb->lock);
>	...
>	if (sb->key_type == NPC_MCAM_KEY_X4) {
>	...
>The mutators __npc_subbank_mark_used() and __npc_subbank_free() update
>sb->key_type under sb->lock via their npc_subbank_alloc /
>npc_subbank_free wrappers.
>If a subbank is concurrently being retyped, can this reader observe a
>transient sb->key_type value (for example 0 mid-free, or X4 for a
>subbank being retyped to X2) and as a result drop or duplicate
>entries due to the "key_type == NPC_MCAM_KEY_X4 && bank != 0" filter?

The dstats matrix is intended purely
as a lightweight telemetry tool to identify which MCAM entries are
actively being hit by current traffic via debugfs, rather than
providing strict, transactionally guaranteed billing or accounting
metrics. So these concurrency issue wont defeat the purpose of this
mcam entry.

>> +static int npc_mcam_mismatch_show(struct seq_file *s, void *unused)
>> +{
>> +	struct npc_priv_t *npc_priv;
>> +	struct npc_subbank *sb;
>> +	int mcam_idx, sb_off;
>> +	struct rvu *rvu;
>> +	char buff[64];
>> +	void *map;
>> +	int rc;
>> +
>> +	npc_priv = npc_priv_get();
>> +	rvu = s->private;
>> +
>> +	seq_puts(s, "index\tsb idx\tkw type\n");
>> +	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>> +		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>> +			mcam_idx = bank * npc_priv->bank_depth + idx;
>> +
>> +			if (!test_bit(mcam_idx, npc_priv->en_map))
>> +				continue;
>> +
>> +			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
>> +			if (map)
>> +				continue;
>> +
>> +			rc = npc_mcam_idx_2_subbank_idx(rvu, mcam_idx,
>> +							&sb, &sb_off);
>> +			if (rc)
>> +				continue;
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%d\t%u\n",
>> +				 mcam_idx, sb->idx, sb->key_type);
>> +
>> +			seq_puts(s, buff);
>> +		}
>> +	}
>> +	return 0;
>> +}
>The same observation applies to npc_mcam_mismatch_show(): sb->idx and
>sb->key_type are read here without holding sb->lock, while the rest
>of npc.c serialises mutations of these fields under that lock.  Was
>sb->lock omitted intentionally for these debug paths?

This was omitted intentionally. npc_mcam_mismatch_show() is a debugfs dump
intended to provide a point-in-time snapshot. Acquiring sb->lock per subbank would
only protect that specific iteration and wouldn't guarantee full consistency
across the entire loop snapshot anyway. Therefore, we avoided the locks here.

