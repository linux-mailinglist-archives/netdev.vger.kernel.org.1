Return-Path: <netdev+bounces-280694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FuOCzn16WmepQIAu9opvQ
	(envelope-from <netdev+bounces-280694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E4E450BA4
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F8A3136770
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816633E639C;
	Thu, 23 Apr 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jWpDnwpO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEC3E51F3;
	Thu, 23 Apr 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939661; cv=none; b=r4pNcvGN4u1Qin6QMJU2//s2lca7GccArpa+mDX+Hckn9jTC8EBHJcYvvOV4SroeufEg/lFDN7LN1OWiVhgCo6EMfw0ZNdjOEFzMBYb2017xbF2ngWgPS9qOZL0K7/7Ex7u+vmQk8mXbKYavL2mHJPxwQ8mt0tfgEF5sJtd2huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939661; c=relaxed/simple;
	bh=QgRuKiLRi0Sq44P5Fbc3F7jo3L5tW7YoWKik5A/EXMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPzBHSn2DGANTQEefOlDA4Uzw+cJVpsGKD7inh4rDoeZ4XJB1c8FQtX0+3BU6iJ6AEdeB7tuBPf5ClB/fymDYpyfpX58YetAr7cDjYpK+qoX33hslfuRxLPrSlVD1uZnH9rdKHCVsuTrdzWSUcaH/02ixtT0gEhC8EOiiaEuB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jWpDnwpO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6SZSs693238;
	Thu, 23 Apr 2026 03:20:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NoEkTSoI5M8CPwvCKtRCSTfqV
	pSu+s/5uaBfskltk2A=; b=jWpDnwpOFhU1hUu60JDBBb7leChtdfRNu7GkFRBtc
	SW8JmKsAXKWX+otYRQM60mNiWH6Zo99q4aeydy3/x9Kk0kj81fEdFyKYufbAWTpR
	6GaFABDPp6ZwrD6Q00S0nvEOq0hhtBbf9NKJ7pXvF8KcW1tEmMpvONinQCZTfnJl
	mJNxMwUa0S4h4J5WNo+5Id/Uiaro2fTz50Me5o0qQgzyNEfr4SrFCIS80XJxM1Ce
	4NVvfVI47oH6fmQV7X7y9zUP9HlSL+zc7s64zJnE9peOu7roKe59wKap6qJyCULY
	W9YMe+BTYA7rMM8uDhyVaJw74FcROxA9nWxikiAPItz/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6je02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:20:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:20:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:20:36 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AC3B15B6A36;
	Thu, 23 Apr 2026 03:20:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:50:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 net 0/11] octeontx2-af: npc: cn20k: MCAM fixes
Message-ID: <aenycIVFXeB2oCcK@rkannoth-OptiPlex-7090>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
 <a93c34d6-8c9f-417e-9ed2-ff4a9f668d11@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a93c34d6-8c9f-417e-9ed2-ff4a9f668d11@redhat.com>
X-Proofpoint-ORIG-GUID: EbYetW9YvE6wrnY-UkthTSNNaVRdWajh
X-Proofpoint-GUID: EbYetW9YvE6wrnY-UkthTSNNaVRdWajh
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f276 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=yzluGeRJeY17FZvpks8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwMSBTYWx0ZWRfXx0A+ITeQEYp8
 fxcpRD21kxTMOoadJfTucFmYxfYrEcB6fMJE83NnFuPxXJ0TlbxTaZtq9dG2/coW5KDljwiLrcq
 yPcSALBdP4x/MWfxUNtNjftIkRiLEXwu4++a9KvJhzGUtKGRcnKBy5AJr20swuMeTc37vkKt8Hb
 R6wbisKBbMoauCOxRKHVOdDsWieULA2H79orB2AXJgvprPPmKdP3LoiNrbouP5vta+WkN+1SShO
 nRwdBx5ScrsucBhFx4wPkAuyN99yqcKLkJN72OwnIl73B6kJVe5RbSi8g+kscTEx2nebHXAJn0F
 jcpI4PWG3GzaFQgojFGW/IwCS5pOeRmOrhrmoRI+/mzcezqcoRIXZ3IeP2dBdE/uXsE/rQ0IRjb
 qUpaUR9eiCL95RWeHsFXzBXU/FhvNL8liDJUy41WkWffUpCG/sveIBr9xsZPsExYPrKJN0KWDjd
 0WJZ9G+vnZhKSSZPvZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280694-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 92E4E450BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-23 at 15:14:10, Paolo Abeni (pabeni@redhat.com) wrote:
> On 4/20/26 4:34 AM, Ratheesh Kannoth wrote:
> > This series tightens Marvell OcteonTX2 AF NPC support for CN20K
> > silicon around MCAM key typing, optional debugfs setup, defrag
> > allocation rollback, x2 versus x4 KEX profiles and default-rule
> > allocation, logical MCAM clear and configuration, default-rule index
> > bookkeeping and explicit teardown, and NIXLF reserved-slot lookup when
> > default rules are missing.
> >
> > Patches 1 through 3 focus on AF error handling: propagate
> > npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config,
> > copy, and read paths; treat cn20k NPC debugfs files as optional so
> > probe does not fail when debugfs is unavailable; and fix defrag MCAM
> > allocation rollback so allocation errno is not overwritten by subbank
> > index resolution.
> >
> > Patches 4 and 5 align default-rule and flow-install behaviour with the
> > loaded mkex profile: prefer x4 default entries when the profile is x4,
> > and reject x4 flow keys when the profile is strictly x2.
> >
> > Patches 6 through 8 refine cn20k MCAM programming: clear entries by
> > logical index and resolved key width, fix bank and CFG sequencing in
> > npc_cn20k_config_mcam_entry(), and read action metadata from the
> > correct bank in npc_cn20k_read_mcam_entry().
> >
> > Patches 9 through 11 complete default-rule lifecycle handling:
> > initialize all default-rule index outputs up front, tear down default
> > MCAM rules explicitly (coordinated with npc_mcam_free_all_entries()),
> > and reject USHRT_MAX sentinel indices in npc_get_nixlf_mcam_index()
> > for cn20k.
> >
> > Ratheesh Kannoth (11):
> >   octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
> >   octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in
> >   init
> >   octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc
> >   rollback
> >   octeontx2-af: npc: cn20k: Make default entries as x4.
> >   octeontx2-af: npc: cn20k: Reject request for x4 entries in x2
> >   profile.
> >   octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
> >   octeontx2-af: npc: cn20k: Fix bank value.
> >   octeontx2-af: npc: cn20k: Fix MCAM actions read
> >   octeontx2-af: npc: cn20k: Initialize default-rule index outputs up
> >   front
> >   octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on
> >   free
> >   octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices
> >
> > Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> >
> > --
> > v1 -> v2: Addressed simon comments. Added more patch fixes to this series.
> > 	https://lore.kernel.org/netdev/20260418162013.GG280379@horms.kernel.org/
>
> I strongly suggest avoid extending a series to address issues found by
> the AI review, unless such issues are actual regressions/problems
> introduced by the new code. Sashiko tends to find a lot of collateral
> problem and the series could easily expand beyond any hope of merging.
>
> Instead you should reply on the ML, commenting on sashiko's review,
> explain why or why not the outlined problems are valid and/or should be
> handled separately.
>
> Thanks,
>
> Paolo
>

Patch 1: [PATCH v2 net 01/11] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k

>Is it intentional to discard the return value of npc_cn20k_enable_mcam_entry()
>here?
>If disabling an entry fails during teardown (e.g., in
>rvu_npc_disable_mcam_entries()), this could silently leave stale, active packet
>steering rules in the hardware.

Yes, the return value of npc_cn20k_enable_mcam_entry() is
intentionally discarded in this context.

The primary reason is that the validity of the MCAM index is
already verified prior to this call, so the function is not
expected to fail under normal conditions.

Additionally, during
rvu_npc_disable_mcam_entries()), failure handling is
best-effort. At this stage, the system is already
transitioning state, and retrying or propagating errors
does not provide meaningful recovery.

Introducing strict error handling here would require
propagating return values through multiple call sites,
which would significantly increase the scope and
complexity of this change.

Any modification to the return type or contract of
npc_enable_mcam_entry() would involve a broader refactor
across the driver and is therefore intentionally deferred
to a separate, dedicated change.

Given these constraints, ignoring the return value here is
a deliberate design decision and does not introduce
functional risk beyond what is already accepted in
teardown scenarios.

>If npc_update_dmac_value() returns an error, its caller in rvu_npc_fs.c seems
>to ignore it:
>			if (rule->vfvlan_cfg)
>				npc_update_dmac_value(rvu, blkaddr, rule, pfvf);
>			if (rule->rx_action.op == NIX_RX_ACTION_DEFAULT) {
>				...
>			}
>			npc_enable_mcam_entry(rvu, mcam, blkaddr,
>					      rule->entry, true);
>Could this lead to the code continuing and activating the rule in hardware with
>an invalid or outdated MAC address?

Handling the error returned by npc_update_dmac_value() only
at this call site would not be sufficient.

For correctness, the error would need to be propagated to
higher-level callers, which would require changes across
multiple layers of the call chain. This significantly
increases the scope and complexity of the change.

Such propagation would also introduce additional handling
requirements in several paths, potentially leading to more
issues being flagged by static analysis tools.

Given that this patch is focused on a specific fix,
extending it to include broader error-handling changes is
out of scope.

Therefore, this is being treated as a separate enhancement
and is intentionally not addressed here.

Patch 4: [PATCH v2 net 04/11] octeontx2-af: npc: cn20k: Make default entries as x4.

>Does this in-place modification break the sorting invariant of the mcam_rules
>list?
>In rvu_mcam_add_rule(), the mcam->mcam_rules list appears to be strictly
>maintained in ascending order by entry. Modifying rule->entry in-place
>without removing and correctly re-inserting the node could leave the list
>unsorted.
>Could this cause subsequent rule insertions or debug routines that rely on
>the list order to behave incorrectly?

The mcam_rules list is not required to maintain a strict
sorting invariant for correctness.

Although rvu_mcam_add_rule() inserts entries in ascending
order, there is no functional dependency on this ordering
in subsequent operations.

All lookups and operations on the mcam_rules list iterate
over the entire list rather than relying on ordering.
Therefore, modifying rule->entry in place does not impact
correctness, even if the list becomes unsorted.

As a result, leaving the list temporarily or permanently
unsorted does not lead to incorrect behavior in rule
insertion, lookup, or debug routines.

>While this static structure predates this patch, can this design cause state
>contamination across multiple devices?
>Because pfl_info is static, it is shared globally across all network
>interfaces and physical NICs on the host. However, it is protected by
>mutex_lock(&pfvf->mbox.lock), which is a per-NIC lock.
>If multiple interfaces probe concurrently, they could acquire their own locks
>and race on this global struct. Additionally, if the host has multiple cards
>configured with different hardware profiles (such as one X2 and one X4), the
>first card to query the hardware will permanently cache its profile for all
>subsequent cards.
>Would it be safer to cache this hardware profile data in a device-private
> +			 */
> +			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
> +			     __func__, pcifunc, ptr[i]);
> +			return;
> +		}
AF processes mailbox (mbox) requests from PFs and VFs
serially. This guarantees that initialization of pfl_info
is not performed concurrently by multiple devices.

The profile information is populated once by AF during NPC
initialization and remains constant for the lifetime of the
DUT. There are no subsequent writes or updates to this data
after initialization.

As a result, pfl_info effectively becomes read-only after
being set. All later accesses from different PFs or VFs are
only reading the same stable value.

Even if multiple interfaces probe concurrently, they only
perform reads after initialization is complete. Concurrent
reads of immutable data do not introduce race conditions.

Regarding systems with multiple NICs or different hardware
profiles, the AF provides a consistent hardware view per
system. The profile data exposed through mbox is not
expected to vary dynamically per device after init.

Therefore, using a static structure here does not lead to
state contamination or incorrect behavior, and no
additional per-device storage is required in this context.

Patch 10: [PATCH v2 net 10/11] octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free

>> +		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
>> +		if (rc) {
>> +			/* Non recoverable error. Let us WARN and return. Keep system alive to
>> +			 * enable debugging
>> +			 */
>> +			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
>> +			     __func__, pcifunc, ptr[i]);
>> +			return;
>> +		}
>Does this early return on failure skip the software list cleanup and leak
>the rvu_npc_mcam_rule list nodes for both this index and any successfully
>freed indices?
>Since the final list cleanup loop is bypassed, it appears these software
>rules remain permanently. Also, does this skip hardware cleanup for any
>remaining default rules in the array?
Default MCAM rules are allocated upfront during
initialization, and their presence is required for correct
system operation. A failure during allocation itself would
already indicate a critical issue.

If npc_cn20k_idx_free() fails, it indicates that freeing of
previously allocated indices has failed. This suggests a
serious inconsistency in the allocation/free logic rather
than a recoverable runtime error.

In such a scenario, attempting partial cleanup (either
software list or remaining hardware entries) is unsafe, as
it can further corrupt the allocation state and make
debugging significantly harder.

Therefore, the function intentionally emits a WARN and
returns early to preserve the current state for debugging
purposes. This avoids masking the underlying issue.

While this does skip subsequent cleanup of software list
nodes and remaining hardware entries, continuing execution
after such a failure is not considered safe or meaningful.

This condition is treated as a non-recoverable error and
indicates a deeper issue in the allocation/free algorithm
that must be investigated separately.

>+	}
>x_handler_npc_cn20k_mcam_alloc_and_write_entry
>> +
>> +	mutex_lock(&mcam->lock);
>> +	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
>> +		for (int i = 0; i < 4; i++) {
>> +			if (ptr[i] != rule->entry)
>> +				continue;
>> +
>> +			list_del(&rule->list);
>> +			kfree(rule);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&mcam->lock);
>Can dropping mcam->lock during npc_cn20k_idx_free() lead to a race
>condition? When the hardware index is freed, a concurrent thread could
>immediately allocate it and insert a new rule into mcam->mcam_rules with
>the same entry ID.

>Later, when this thread re-acquires the lock to clean up the software
>rules, the inner loop break only exits the for loop, meaning the list
>traversal continues. Would this cause both the old rule and the newly
>allocated concurrent rule to be deleted and freed, leading to a
>use-after-free for the active thread?

No. There is no concurrent threads;
default indexes are allocated thru mbox messages to AF.
AF process mbox messages processed one by one. So there is no chance of concurrency.

