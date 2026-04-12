Return-Path: <netdev+bounces-277885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFPRKBn222lTJgkAu9opvQ
	(envelope-from <netdev+bounces-277885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE53E5C4D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2E830071D5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAE364028;
	Sun, 12 Apr 2026 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="U2k8ZXxP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A031362136;
	Sun, 12 Apr 2026 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022890; cv=none; b=f3gGdAxbbzmQyYcZ8UIcAbXfRSAd498nXFsw1qJgGs/C9yJTedQGRL1DVjjoBm16xMI0O6OMFCc0UMXGk1ogtgBFIbDD3+WfhoPRujQfdkrFU18KJ2ZtYC7S6BdAs6bNjrqI0rObAOPwSUNdh7inNVByjC3aW/h1l5+TK8Bwf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022890; c=relaxed/simple;
	bh=B/A0eVdyffeEAwDBX96uPJ/O7S7dvrZYaibvZVA32Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFFmZmgxM1/pdTeVzpSxSqmkQwH74oxksfo9wRXkvPcNSQ/NiHJqjyYB0SvU7kGoRtjeOq/50Fl6kJpsGv6i4z76z1DwToU0uDan/bbdOj2XCeZ2osnGKEZBRD9aQI9tOhN79KrNDocp5MggC1tbUTYcJbGjZWHRdMmnRClxdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=U2k8ZXxP; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CD2CPC2384609;
	Sun, 12 Apr 2026 19:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=rYAHOUHF4tVSuhRxEulmlA7bJfQZG35LINctsMDZ3PQ=; b=U2k8
	ZXxPN4dlflTAPn8Dn3OYYxsWayO6LLvX8jtBr05jlWO65dQoMqqfjsRdNZtJlmCY
	qmDxK54adRD8UT6ns4NwsdFyXz1zGuFiSMGekbjQQI/O1zG3pcM/ctEhbIQhe7Ez
	pHaHmbO7jI94dBrFwDVl/XeCt5iITxYUiRSgepb40e3QamPbvIjrYy5TgitEp18B
	q5mWwOosfYPYQEp2wp6M+5RcPptfbbwbUp62HmwahUZUaxLCXCwrPCLChBe0lhKk
	tiFoTnKdjyHkqZX53r8B6QQ84yeqtRDcSPe75brWHyXkgNiU5/lA1gBk96yabKJ5
	tTnuIfILinePpM0D7Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dg2sbjb3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 19:40:53 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 12 Apr 2026 19:40:49 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <ameryhung@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
        <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <clm@meta.com>,
        <daniel@iogearbox.net>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
        <kernel-team@meta.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
        <netdev@vger.kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in local storage
Date: Mon, 13 Apr 2026 05:40:44 +1000
Message-ID: <20260412194044.13195-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
References: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: tu7Wg6oZs5niZ0kEPh5Ncgq1dSR_3y2j
X-Proofpoint-ORIG-GUID: tu7Wg6oZs5niZ0kEPh5Ncgq1dSR_3y2j
X-Authority-Analysis: v=2.4 cv=OIwXGyaB c=1 sm=1 tr=0 ts=69dbf545 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=sIHlx-zSKvd85TjScasA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE5MyBTYWx0ZWRfX9G/ksOHSezo7
 P86kwGwjV8F+FU8XV8+1/UD9GOyuKVJgR9301I2PBbqKbg6hr0tyLNosn3oVnZCD/CIFbg2VIBa
 hDP4wOJfHSMRGSJJlcOOwsW6Kc5jaARLZXALCLkV3oHUxuXscdY0RSypOLTe8OM7MMaV5r40C/4
 cusyS/kuVBjFI9ffsAYdyMT+CCzPiN0YNeG8W4AMjmHepgvTNA/VRBqB3XnpDtAtcYn5ET1O3U+
 rSfv/5We0++t9i5tgcS45Cr31UPFw6zfsabnovWVacvSFDrVV3dO6XEqqbq3OwZDqPAdofqA7MV
 avIYMNJC9Y0f5STwTp7M88s1z9HwgvmzXEnruNH1/x+ygS3LWjfG8CjHs7bbyf79lXNzzjVKvP+
 aj0IvNCXqjcEbkD9x4LAqPCd1K7ie1WRu5YwhsBTObhE6O4X0k0ajj3f1Vcxdm1QGwe2y4W+FBK
 b7HBE6lx/3IUapPHr2A==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11757
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120193
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-277885-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,meta.com,iogearbox.net,linux.dev];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04FE53E5C4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:39:00 -0700 Alexei Starovoitov wrote:
> >
> >
> > This allows value sizes up to ~65KB. Before this patch, socket and
> > inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> > which could handle those large sizes. After this patch, any
> > elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> > creation succeeds via bpf_local_storage_map_alloc_check() but every
> > element allocation returns NULL.
> >
> > Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> > KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> > storage types go through kmalloc_nolock()?
> >
> > Slava Imameev raised the same concern for task storage in
> > https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/
> 
> Right. Let's update it, but I don't think it's a regression.
> On a loaded system kmalloc_large() rarely succeeds for order 2+.
> That's why kmalloc_nolock() doesn't attempt to bridge that gap.
> One or two contiguous physical pages is the best one can expect.
> In early bpf days we picked KMALLOC_MAX_SIZE assuming that
> it's a realistic max for kmalloc().
> It turned out to be wishful thinking.
> kmalloc_large concept should really be removed.
> It deceives users into thinking that it's usable.

Do you think it would be viable to extend task storage to
support larger allocations, to restore support for 64KB or maybe
less value like 32 KB, using vmalloc or bpf_mem_cache_alloc,
with the obvious restrictions that vmalloc imposes? Perhaps we
could use bpf_mem_cache_alloc as the primary mechanism with
vmalloc as a fallback when the caller context permits?

We've found task storage allocations larger than 8KB quite
valuable for scenarios involving processing multiple file paths.
Currently, without large task storage support, we're forced to
preallocate maps with 12KB+ values and significantly
over-provision the number of entries to reduce the probability
of free entry depletion. This approach places unnecessary burden
on the memory subsystem since much of this pre-allocated memory
remains unused.

Even if task storage allocation fails due to lack of contiguous
physical memory and vmalloc is not possible, there's an option to
maintain an emergency preallocated map of much smaller size
compared to when this map serves as the primary mechanism.

With larger task storage allocations, we've implemented a simple
memory allocator that operates over task storage. For example, a
16KB task storage can accommodate multiple allocations, one big
and couple of small, which has substantially reduced our memory
footprint compared to the current map-based approach. We've also
experimented successfully with 32KB arenas for workloads
requiring even larger working sets.


