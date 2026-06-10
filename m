Return-Path: <netdev+bounces-297427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hk/xNwrmKGo+MgMAu9opvQ
	(envelope-from <netdev+bounces-297427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0B665B94
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Nw3rM6x7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1338306EB24
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932A3546E3;
	Wed, 10 Jun 2026 04:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82635C1B0;
	Wed, 10 Jun 2026 04:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065223; cv=none; b=ppdq4PR+ClJ+Xln7jQtEKosayf7QvvcOMtJMOZZQprY0VpniUPMhDGLcUBh29SumU/kNnf/aBQEmMGd65R2023Pzx75cOFhGFTgHiFWcMLGbc4RDjsik6VzUrJIrL7H5xjIcJN+91Tt1kSH1OnGpJc5Sf6/9JMoqZDhLe+89fuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065223; c=relaxed/simple;
	bh=zGKvMWqy886QwZqGL6EsS5+YbwYm8j+kEH5hHaAz3T8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDh1ac9iZtZDT3HUg2sJIqfHrVlJgYiQHlU7HbhoN+b2sGTjb7pdGoNIeoHRBGJ+GeMghJb0tlQOmdcbhEbeJzrnYv2XaaOp4yYpySFFUWR0KRzlc1zyToo2AiPhOP2QVzFhu0lqbOHY+NtzwsTVXWg8ACzGTfMNdjrcWqwMuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nw3rM6x7; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vcmJ2896552;
	Tue, 9 Jun 2026 21:19:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NwbWjuvZUU6l+353QuphsA44e
	J/pGyZySj3/gtb6Rmc=; b=Nw3rM6x7F3IHTfmnvwuyeU/LNPQGGhwfGpG8+I1BJ
	bAqRkRS8vnIJh6wS7BB4ja/+HjGKnTTwUlIbSN3BNVhd8ValjE2QuXSWi2KNlGey
	IorqeFmowz8+Gk/ZQTY6lrvMWTblHd7lm+Nxvos0PupNMZDyWbyiQ3QGdK4IZhCq
	mE46mrj4lh3ROOPOkXYJJLFM9YFT4S8f198x1lkMWwZZkq8ToDXsnnsqvrhRrrWD
	2H2I+dv5KQnWAbkT8hLH/NmoKOZ2ncqtiIbrgtIgUlMA6txqSrkSrv4BlFDMhHGB
	46otOk081knO0BvJPTz8/ereYIcAydbyrO3i4RMGkkgWQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqpcmnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 21:19:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 21:19:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 21:19:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 673523F704A;
	Tue,  9 Jun 2026 21:19:52 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:49:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 2/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aijl57679XwZAV_r@rkannoth-OptiPlex-7090>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzNiBTYWx0ZWRfXzPfRkOBXllYU
 B74HGozEOdLEXKneAKkNss/1n+cn+ZfQB86oMK/D3gAlUjydtOfkIbVGoN0rnjgkfjXjQVxNfEW
 fpw3nhA7xHt9w0FAHSOOhBapjy4xfwT/hgKDuZvBOENyuO99jEHxtK58gKIpx0jPV9mvx8eNxQ4
 lKPYprqzsGh6SeFONwRkXF4h5KNOfdpZPcBfPFKg+/eZgClkSOZvmDiIdO4/DJbxis5Ub2NbVQT
 S+/jswB8501ds3E6PcAMMnj5S88W2cwpqhnb5JUUwEb3WHaakIdiXgfCHRemeVXsdUrNIlpCete
 22CKWabP/Pft3hZWTPun4xzfPp1Vph3ekUWZC+H1dwlGK06D344WUaicNGqr7t65lKUuGOhOB27
 GqWY3y5X8PcMZI+wrlHipO68MzD5IqsWBAtYqaW204ImxRTPpoVGKmybUvwc7XPkl9D3EL7mQnb
 IMPj/ht9uiBqKDWqgrg==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a28e5ed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=xYWY-QBHG2NFp7g9jwEA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: u7PrVZISWEQrqalhnGeAMAhVwGr-hGxb
X-Proofpoint-ORIG-GUID: u7PrVZISWEQrqalhnGeAMAhVwGr-hGxb
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297427-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,marvell.com:dkim,marvell.com:email,marvell.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3AF0B665B94

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

https://sashiko.dev/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says

>> +static DEFINE_MUTEX(stats_lock);
>> +
>> +/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
>> + * hard limit on all silicon variants, preventing any possibility of
>> + * out-of-bounds access.
>> + */
>> +static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
>> +static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
>> +{
>[ ... ]
>> +			stats = rvu_read64(rvu, blkaddr,
>> +					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
>> +			if (!stats)
>> +				continue;
>> +			if (stats == dstats[bank][idx])
>> +				continue;
>> +
>> +			if (stats < dstats[bank][idx])
>> +				dstats[bank][idx] = 0;
>Can stale dstats baselines persist across MCAM entry reallocation and
>silently corrupt hit telemetry?
>The dstats array maintains a per-entry software baseline. When an entry is
>freed, its hardware hit counter is reset to 0 in npc_clear_x2_entry(), but
>its corresponding dstats baseline is never cleared.
>If the entry is later reallocated and its hardware counter accumulates more
>hits than the old stale baseline before the next debugfs read, this fallback
>logic evaluates to false. The calculation will then incorrectly subtract
>the stale baseline, massively under-reporting the actual hits.
>Should the baseline be explicitly cleared synchronously when the entry
>is freed?

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
>Does this global baseline destructively corrupt telemetry under concurrent
>reads?
>When any process reads the debugfs file, it updates dstats[bank][idx],
>destructively advancing the baseline for all other readers. If a monitoring
>daemon reads the file periodically and a user manually reads it, the manual
>read consumes the delta and resets the baseline, causing the monitoring
>daemon to miss all hits that occurred in between.
>Should telemetry exposed to userspace either provide raw cumulative counters
>or track baselines per-file-descriptor context?

Same comment as above.

>> +	mutex_unlock(&stats_lock);
>> +	return 0;
>> +}
>> +
>> +/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
>> +#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH * 64)
>> +DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);
>Does this bypass the chunking design of seq_file and cause unconditionally
>large allocations?
>By calling single_open_size() with a hardcoded TOTAL_SZ of roughly 1MB
>(16,384 entries * 64 bytes), this unconditionally allocates 1MB of kernel
>memory via kvmalloc every time the file is opened.
>Instead of dumping everything in a single show() call, would it be better
>to implement the seq_file iterator callbacks (start, next, show, stop) to
>process the MCAM entries in page-sized chunks?

I dont see any issue with current approach and would like to keep it.

