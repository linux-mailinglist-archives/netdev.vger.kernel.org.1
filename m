Return-Path: <netdev+bounces-296349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9clD9ooJmqaSwIAu9opvQ
	(envelope-from <netdev+bounces-296349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B796523C7
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:28:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ejtdx+Fu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296349-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839FA300651A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4C30FF21;
	Mon,  8 Jun 2026 02:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024E2BE63F;
	Mon,  8 Jun 2026 02:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885718; cv=none; b=reeHH/l7q7XGtr8PJU42wIZIMJfZhAWXtY00Sy0LpZqg6yHViiDSi81KCFx1WzAvv3mUomdGDCpndfCVIyaBGc3i3yjAAelbQCQeQ411+pJPaV1LPpEiWuckeZga1R7YKaNpKeRju1Q/WYBQ7OtkevAk4iTHqVwuREtipf8QeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885718; c=relaxed/simple;
	bh=7qGW2BLo50w5UWS8yp/xrjvQJ+tbsd4Fhg/BgDo20Bw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLK7KjxJB84ZyrmMU8xuU5rRNr9wnr6ZfDel4N0iF/LthMpm+8ZJz9SRro++nsDSk4BAKgzNyXrGvgFbcK7ImhllxeAXUfA90NbqgkUGHlmutYk31fBk0JX56tu2JXW3eHlIxgW9ivdXdhxwsiOoZgcy92ygQXW6Ov458k70qC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ejtdx+Fu; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EoxF1019743;
	Sun, 7 Jun 2026 19:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1yVz7wQ+NjNKnRgAetBth/hny
	b2IvXPFoTLNcWYhmLQ=; b=ejtdx+FuDDHhaCrw06jGT1Dp1tAM6/c1M+XAorwoc
	kH1jCiqbiTl3kAzOAVdHT//gF/4kSjQFfromMtYX35xjWULhttEk5XnsJ6ib7+Z9
	7eVQqL6Z205yTyZx+SgqxQ3Bv/GD9KUKU6aeO//71K9t1HIp7CRB3VlFWQUAgIyW
	sWxmddv4xbjlxwQ0JTvrBIpSv1pmCUQJs/ESqqYBz15N65j/i6UnAqZ941a5t0jV
	WxlIjITvoAMLVZhB9PyEttsWqdfWlQdv7KGzFej66j+4VqSGhWJYP3aSzSnOg63m
	21nHW+5kL/kal1vuzkRx7WM3QJJh/F+CAFUGEZGIeurFw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4emgwhw521-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:28:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:28:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:28:26 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 93E495B6933;
	Sun,  7 Jun 2026 19:28:23 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:58:22 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <aiYoxqoB8NKep-wI@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-6-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX4eTZGN+ZGi8Z
 T0axwQ5nrAlM96ObOiV7zLhyuQNGveHNa9eKF/3sbvG4LHIAsb2cWTQ5y/7pdxvJxGIq0e9gpXV
 4CgWPG0ChJ8iQn1VmT2WLbQ3O14//SRWJLsci8thnx1lGn/VzHz2fO9SfGwslofNc+yhwNPLwgX
 5NixjaJ1w2Rl4FO1QK1/7KaeS0tVx26ZV5G2uuOqXBN1ZscJUKjmrff/c/hRBl+/fGkDW7HjxMb
 AEOk+BocGsH90XYf9cj4zgHl2lARgy4aq9Lqs8gg1yFfwzqLuOc0K5JQqxA8iKbOAe2vaQCooPK
 wK4B6uyM3shY2kkOntrHUkLacH2Mbq4GgyjuR7boKBtuqG0eaVTcWCkMFjVleerIXMExKPXMJQp
 TEwlotIzyyrUsHyseZ+q91+I/NdsG9I3e3dNjGCmRFQfhsp44IqkxUijhW84e/3xY7n0Ixixrwr
 ieX7zdLGCpPEuEYBzyA==
X-Proofpoint-ORIG-GUID: is743qX5fhZQpOcMZX0Cpl5C0egTsWmF
X-Proofpoint-GUID: is743qX5fhZQpOcMZX0Cpl5C0egTsWmF
X-Authority-Analysis: v=2.4 cv=Pv2jqQM3 c=1 sm=1 tr=0 ts=6a2628cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=8jdBIKRhGUsF0k21ziUA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	TAGGED_FROM(0.00)[bounces-296349-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rkannoth-OptiPlex-7090:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
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
X-Rspamd-Queue-Id: A0B796523C7

On 2026-06-05 at 12:02:41, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>> +		USED = 1,
>> +	};
>> +
>> +	if (cnt != npc_priv.num_subbanks) {
>> +		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
>> +			cnt, npc_priv.num_subbanks);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&mcam->lock);
>> +	npc_lock_all_subbank();
>Can the encoding of subbank_srch_order[] be reconciled between
>initialization and this setter?
>The boot-time fill done by npc_create_srch_order() and npc_subbank_init()
>populates the array as subbank_srch_order[subbank_idx] = priority (i.e.
>indexed by subbank, value is priority). For cnt = 8 it produces
>[3, 5, 2, 6, 1, 7, 0, 4], whose actual hardware search order is
>sb6, sb4, sb2, sb0, sb7, sb1, sb3, sb5.
>The new setter writes the same array back as
>subbank_srch_order[priority] = subbank_idx (indexed by priority, value is
>subbank):
>    for (int i = 0; i < cnt; i++)
>        subbank_srch_order[i] = (u32)narr[i];
>If a user runs devlink dev param show (which calls the GET path returning
>the boot-time encoding) and then re-applies the same array via
>devlink dev param set, the SET path treats it as a permutation of subbank
>indices and produces search order sb3, sb5, sb2, sb6, sb1, sb7, sb0, sb4
>instead of the previous order.
>The validator also checks that arr[i] in 0..sz-1 occurs exactly once each,
>which matches the SET form but is also true of the boot-time content
>(subbank_srch_order[7] == 4 in the example), so the validator does not
>catch the round-trip mismatch.
>Should both writers agree on a single encoding so that show + set
>round-trips are stable?

Agree, but npc_create_srch_order() and npc_subbank_init() are not added by this function
and is preexisting issue. WIll send patch to "net" tree soon after this series
is merged.

> +			xa_erase(&npc_priv.xa_sb_used, prio);
>> +	}
>> +
>> +	for (int i = 0; i < cnt; i++)
>> +		subbank_srch_order[i] = (u32)narr[i];
>> +
>> +	restrict_valid = false;
>Is the unconditional restrict_valid = false here intentional, and is
>there a way to undo it?

No.
This is intentional.

>The cleanup loop directly above does not only erase newly-added entries.
>The check rsrc[FREE][prio] == 1 (and the USED counterpart) also fires for
>slots whose successful iteration replaced a pre-existing entry whose
>paired decrementing iteration never ran due to the failure.
>For example, with sb 0 FREE arr_idx = 0 and sb 1 FREE arr_idx = 1 and
>narr = [1, 0]:
>  - iter prio = 0 succeeds: xa_sb_free[0] is replaced from 0 to 1,
>    rsrc[FREE][0] becomes +1, rsrc[FREE][1] becomes -1.
>  - iter prio = 1 fails.
>  - cleanup loop sees rsrc[FREE][0] == 1 and erases xa_sb_free[0].
>The rollback loop then calls xa_store(xa_sb_free, save[0] = 0, sb 0)
>against an empty slot, which does need a fresh xarray node under
>GFP_KERNEL. If that allocation fails, the only response is WARN(!!err, ...)
>and the function returns the original error.
>After such a failure, sb->arr_idx is restored but the corresponding
>xa_sb_used / xa_sb_free entry is gone. Would future MCAM allocations via
>npc_subbank_noref_alloc() then silently skip those subbanks? Could
>xa_reserve() before the destructive phase, or not pre-erasing entries in
>the cleanup loop, make rollback unconditionally safe?

Suppose there are only two subbnaks and both are free.

When first loop runs.

rsrc[FREE][0] = 1 - 1 = 0
rsrc[FREE][1] = 1 - 1 = 0

xa_erse check if any value is positive, in this case nothing is positive, nothing
will be removed. So rollback will be safe.

>> +
>> +	npc_unlock_all_subbank();
>> +	mutex_unlock(&mcam->lock);
>> +
>> +	return rc;
>> +}
>Is the locking on the allocator side sufficient to make this setter
>atomic with respect to MCAM allocation?

Yes. allocation is done in mbox handler; which is protected by mcam->lock.

>Is the locking on the allocator side sufficient to make this setter
>atomic with respect to MCAM allocation?
>The setter takes mcam->lock plus all per-subbank locks and rewrites
>xa_sb_used / xa_sb_free, modifies every sb->arr_idx, and toggles
>restrict_valid.
>The allocation hot path
>rvu_mbox_handler_npc_mcam_alloc_entry()
>  -> npc_mcam_alloc_entries()
>    -> npc_cn20k_ref_idx_alloc()
>      -> npc_subbank_noref_alloc()
>iterates xa_for_each(&npc_priv.xa_sb_used, ...) and
>xa_for_each(&npc_priv.xa_sb_free, ...) without mcam->lock held
>(npc_mcam_alloc_entries() takes mcam->lock only after
>npc_cn20k_ref_idx_alloc() returns) and without holding any per-subbank
>lock between iterations (the per-subbank lock is taken inside
>npc_subbank_alloc() / npc_subbank_suits() and released before the next
>iteration step).
>xa_for_each is RCU-safe so this is not a use-after-free, but a concurrent
>SET can re-key xarray entries while the allocator is mid-walk, causing
>the allocator to visit some subbanks twice and skip others entirely.
>restrict_valid is also a plain bool read by npc_subbank_restrict_usage()
>and npc_defrag_skip_restricted_sb() and a plain bool write by the setter,
>with no READ_ONCE / WRITE_ONCE.
>Should the allocator iteration also hold mcam->lock (or the relevant
>subbank locks) for the duration of the walk, and should restrict_valid
>use READ_ONCE / WRITE_ONCE?
mcam_allocation() is done under mutex_unlock(&mcam->lock); in mbox handler.
Mbox are handled serially by AF. So this case wont' happen.

