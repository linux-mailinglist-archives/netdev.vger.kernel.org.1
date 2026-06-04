Return-Path: <netdev+bounces-295022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YWcoFgzhIGo/8wAAu9opvQ
	(envelope-from <netdev+bounces-295022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3563C76E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="i/ZeAU5Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295022-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295022-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F498301FAAE
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EC33DEC8;
	Thu,  4 Jun 2026 02:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B718339705;
	Thu,  4 Jun 2026 02:19:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539603; cv=none; b=IwRz1XJ8mJxeoCAuVkWVkZ9G5CwKsQzl2NzGQiwE3vW2RM4PaZxesGGXSBfaKz+Rebiprr/2b4CZCQ7PyBy2J5thyOUyk6HSAoXU9Hf6WhSasGqe2x+Ei+mqUw/0Q48/TMMhwM7921rSlTVMB1cW4eO9yIdhGh+05/w/27nuVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539603; c=relaxed/simple;
	bh=vmckD8Tdpulu28xOxc11IGXXKvCwk+kNu2AeVVrwEN8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdJLld8amiUNNHatff8VCLPPGoNICGcp+nPWirExvYiEZCvBaWnOGD7sI/7sScQSDBacLsRHWXJvLc8i0DNfLSJw9c0lY8XNxczKwneGpREGmvi/Ib7HdOUQjGKgfEloNyUJmt2i17CU9qSEAmqoThlJh37+ovfffOoQHrAtAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i/ZeAU5Z; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JH91w024408;
	Wed, 3 Jun 2026 19:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oYUoxRxoQd/DVfOnvf6Stj0mP
	ZD4TfhthTFHXzi01MI=; b=i/ZeAU5Zciy8rY/iLuxLvPp23MMqMTZbZbxItiNlM
	xBUpu1I6l1jAJAlMlW02ZLcK5r8F4af+3SRkfF11D2XIKyzFmBPbWafHAGLIrCm2
	3csY8ftq4a+Rfq8V+Vwgji/wXSbyYDYX5hs5YSDrT0Vo2XmRH1tXycs03qRtnnLk
	o2dp+ArqdTe80rUJex1sdnsyIovR6FzHrTiKdTJBORjl1cx2kQRWZJmhys6XIo1/
	ztGYV6aQZP/itLTZRPnqjHB+wJJdGRWL4qR77DBbMwJ1Qx/ehVNKxrxNEDObpd+M
	Ic2hdtfINeIkSVzSjTordCEDnHxFymZxPxp5QNlGyJ//Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8v9cqpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 19:19:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 19:19:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 19:19:47 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id ACF7E3F70A2;
	Wed,  3 Jun 2026 19:19:44 -0700 (PDT)
Date: Thu, 4 Jun 2026 07:49:43 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 1/8] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aiDgvzA2pe8FXJOL@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-2-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: QahqpciJMAcJoUc0IulIHavSxiQ70SZk
X-Authority-Analysis: v=2.4 cv=JNQLdcKb c=1 sm=1 tr=0 ts=6a20e0c4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=xYWY-QBHG2NFp7g9jwEA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyMCBTYWx0ZWRfXw6QIdNjokXJe
 NxBv9fTxaLoYCdb4mzSNYH7p686phFTwSmsn6jPQ0H/LzOEYYA145uqIxTPVBHCcjPN6tB3mg17
 k+SelJa2qllULGaDhpYkRG2fOgkvAkC88XgkXppZ4SPDKKGqyAOMHApfOsMthqHzjbGbm7C7X96
 hGYKQyZOn1tkvP/sgAg/2j4jl9uT+1RoDI2WsLD5TjbMlSnTKtlmZkk1+JHiTJxZBrDsll2au3e
 BcB4Zf/J4RgkLFLiKVzpLr5/6t2iWo8Q48X1w6q6CEF7PKla+KkpvxAdoH4RhEKItaA8zBGPWZo
 97FXxkE36aLrEZJhavWyqJTGV+s7jGl+LNEpxTjC6dG93F3HqH9SoS936+f9rtjmZgWLTCXmFVB
 9hOy4x/RDFPtCV5/EcBRVO+3SDSRYpuZnOlYJ2smBLVtxD51rovwBcdSXV/GC0zG4E66ka5KoLA
 gt8w1mULO2TLuanOtnw==
X-Proofpoint-GUID: QahqpciJMAcJoUc0IulIHavSxiQ70SZk
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-295022-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,rkannoth-OptiPlex-7090:mid];
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
X-Rspamd-Queue-Id: C5D3563C76E

On 2026-06-02 at 11:33:52, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>> +static DEFINE_MUTEX(stats_lock);
>> +
>> +/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
>> + * hard limit on all silicon variants, preventing any possibility of
>> + * out-of-bounds access.
>> + */
>> +static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
>The dstats array is a file-scope static and is never reset on driver
>teardown. npc_cn20k_deinit() now clears npc_priv.en_map but leaves
>dstats alone:
>  void npc_cn20k_deinit(struct rvu *rvu)
>  {
>      ...
>      bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>                   MAX_SUBBANK_DEPTH);
>  }
>On a probe -> remove -> probe sequence (or after an NPC reset) within
>the same module load, do the stale baselines from the previous device
>incarnation remain in dstats[][]?
>The wrap-around guard only self-corrects when the new hardware counter
>is smaller than the stored baseline:
>  if (stats < dstats[bank][idx])
>      dstats[bank][idx] = 0;
>If the post-reinit counter is greater than the stale value, would the
>first read of dstats report stats - stale_baseline rather than the true
>post-init delta? The commit message states baselines are advanced
>"after each read", which seems to imply per-incarnation correctness.
>Note: this appears to be addressed later in the same series by the
>patch "octeontx2-af: npc: cn20k: Allocate npc_priv and dstats
>dynamically" (4767c16e8909), which moves dstats to a devm_kzalloc()
>allocation that is freshly zeroed at each probe.
There is only one AF device per system. So this case wont happen.

>> +	mutex_lock(&stats_lock);
>> +	seq_puts(s, "idx\tpfunc\tstats\n");
>> +	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>> +		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>> +			mcam_idx = bank * npc_priv->bank_depth + idx;
>> +
>> +			if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &key_type))
>> +				continue;
>> +
>> +			if (key_type == NPC_MCAM_KEY_X4 && bank != 0)
>> +				continue;
>> +
>> +			if (!test_bit(mcam_idx, npc_priv->en_map))
>> +				continue;
>> +
>> +			stats = rvu_read64(rvu, blkaddr,
>> +					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
>Can idx exceed the second dimension of dstats[][] here? The inner loop
>runs idx from npc_priv->bank_depth - 1 down to 0, but dstats is sized
>MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS (8192).
>In npc_priv_init() the new validation only constrains the quotient:
>  subbank_depth = bank_depth / num_subbanks;
>  if (subbank_depth > MAX_SUBBANK_DEPTH) {
>      ...
>      return -EINVAL;
>  }
>Because of integer truncation, bank_depth values in the range
>(MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH, MAX_NUM_SUB_BANKS *
>MAX_SUBBANK_DEPTH + num_subbanks - 1] (for example 8193..8223 with
>num_subbanks=32) pass this check while exceeding 8192.
>mcam->banksize is sourced from a 16-bit hardware-reported field, so the
>value is structurally allowed even if current silicon programs a
>power-of-2 banksize. With such a banksize, would the new
>set_bit(index, npc_priv.en_map) in npc_cn20k_enable_mcam_entry() (which
>only validates index < mcam->total_entries) and the dstats[bank][idx]
>indexing here write past the bitmap and array?
>The new comment in cn20k/npc.h states:
>  /* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
>   * hard limit on all silicon variants, preventing any possibility of
>   * out-of-bounds access on matrix defined using these values.
>   */
>Would an explicit check such as bank_depth > MAX_NUM_SUB_BANKS *
>MAX_SUBBANK_DEPTH (or mcam->total_entries against the bitmap size) make
>the comment match the code?
>> +			if (!stats)
>> +				continue;
>> +			if (stats == dstats[bank][idx])
>> +				continue;
>> +
>> +			if (stats < dstats[bank][idx])
>> +				dstats[bank][idx] = 0;
>> +
npc_priv_init() during probe() do check against limits MAX_SUBBANK_DEPTH, MAX_NUM_SUB_BANKS.
So the condition wont happen.

