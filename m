Return-Path: <netdev+bounces-279139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XIjPKUE84Wk1qwAAu9opvQ
	(envelope-from <netdev+bounces-279139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:45:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFB41445E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9045D31D9949
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3539B49C;
	Thu, 16 Apr 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg8mP3tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF828388E60;
	Thu, 16 Apr 2026 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368146; cv=none; b=DuY3YlEPEpfYbLaj5vuaiWR5FiNWUDWAquiq129n91vR8zlr81BiakNrQhGUsNCdmjcynUuFCKFgLkCLHyDZ2CEsVgkclRWLUGQFms725k931ht+0j3ayCTo2kIXJewYClJgQnXIXTkQy8aG1IsBAIDtxGUSrVKhsc6HM77nB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368146; c=relaxed/simple;
	bh=+C+qhdBNrVoLYtYUgnTeiK1qDnZjwl199+hcAHdCjEQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WidmLbZy8C/j0NEYKKr0Ey/Ta4StDI95MWsl8y5ieqb13u71jFLmS+qKgnJtR9NTL8+8Kd2n9/bDQo5sl0kPOSga2SLRFt62I1DeeRrqrDcYcoReniLXktZCjShoGlfTGzMwssygv9j8uwYRKBKSb8rlSKK66ixyfs7jhULLleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg8mP3tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D7C2BCAF;
	Thu, 16 Apr 2026 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776368146;
	bh=+C+qhdBNrVoLYtYUgnTeiK1qDnZjwl199+hcAHdCjEQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=qg8mP3tq4vh6uK1+Qzr5DoHQtiEVgXiRhYdrPzSAn+126UzusdESGcZ4p7Z0ZMvn0
	 Q/mC8Rt27qwbVqieVTVb+GHEYxRLh2pDS1a0QmgMoYRSht83WjKuvyqQJjw7hH02+J
	 nY4BR/MY8FLVKVoHrY9wtZkknJR7/HnTPlj11OMaJG6j+8xCZVlXxxzWBdNXrHak+A
	 L4DWZRpTo96jK/W/9PQTqr7Ksp4KjqkIPsxJ7/ckvgBJOa2c4kBfnqxsTUJki0ZKRm
	 6O2pGmQiOUM1rdqrSWg3UTeI5x0VrtowhAIMxFGMGLhOay2gboj/Ty0pSa9e4kphYO
	 quZH/o1RuvfnA==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Thu, 16 Apr 2026 22:35:41 +0300 (EEST)
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
cc: Stephen Hemminger <stephen@networkplumber.org>, 
    "victor@mojatatu.com" <victor@mojatatu.com>, 
    "hxzene@gmail.com" <hxzene@gmail.com>, 
    "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
    "kees@kernel.org" <kees@kernel.org>, 
    "gustavoars@kernel.org" <gustavoars@kernel.org>, 
    "jhs@mojatatu.com" <jhs@mojatatu.com>, 
    "jiri@resnulli.us" <jiri@resnulli.us>, 
    "davem@davemloft.net" <davem@davemloft.net>, 
    "edumazet@google.com" <edumazet@google.com>, 
    "kuba@kernel.org" <kuba@kernel.org>, 
    "pabeni@redhat.com" <pabeni@redhat.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "horms@kernel.org" <horms@kernel.org>, 
    "ncardwell@google.com" <ncardwell@google.com>, 
    "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
    "g.white@cablelabs.com" <g.white@cablelabs.com>, 
    "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
    "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
    "cheshire@apple.com" <cheshire@apple.com>, 
    "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
    "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
    "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
In-Reply-To: <PAXPR07MB7984FE65FF793F8E10F33871A3232@PAXPR07MB7984.eurprd07.prod.outlook.com>
Message-ID: <44dd0b98-244d-0059-9fe8-82c9f7c7ffca@kernel.org>
References: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com> <20260416105505.22383f01@phoenix.local>  <PAXPR07MB7984FE65FF793F8E10F33871A3232@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[networkplumber.org,mojatatu.com,gmail.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-279139-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ij@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0EFFB41445E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026, Chia-Yu Chang (Nokia) wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org> 
> > Sent: Thursday, April 16, 2026 7:55 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: victor@mojatatu.com; hxzene@gmail.com; linux-hardening@vger.kernel.org; kees@kernel.org; gustavoars@kernel.org; jhs@mojatatu.com; jiri@resnulli.us; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; horms@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> > Subject: Re: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit enforcement when dequeueing L-queue
> > 
> > 
> > CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> > 
> > 
> > 
> > On Thu, 16 Apr 2026 19:09:06 +0200
> > chia-yu.chang@nokia-bell-labs.com wrote:
> > 
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Fix dualpi2_change() to correctly enforce updated limit and memlimit 
> > > values after a configuration change of the dualpi2 qdisc.
> > >
> > > Before this patch, dualpi2_change() always attempted to dequeue 
> > > packets via the root qdisc (C-queue) when reducing backlog or memory 
> > > usage, and unconditionally assumed that a valid skb will be returned. 
> > > When traffic classification results in packets being queued in the 
> > > L-queue while the C-queue is empty, this leads to a NULL skb 
> > > dereference during limit or memlimit enforcement.
> > >
> > > This is fixed by first dequeuing from the C-queue path if it is non-empty.
> > > Once the C-queue is empty, packets are dequeued directly from the L-queue.
> > > Return values from qdisc_dequeue_internal() are checked for both 
> > > queues. When dequeuing from the L-queue, the parent qdisc qlen and 
> > > backlog counters are updated explicitly to keep overall qdisc statistics consistent.
> > >
> > > Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 
> > > qdisc")
> > > Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
> > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > ---
> > 
> > I was a little concerned about the complexity of managing qlen here.
> > But could not find anything obvious.
> 
> Hi Stephen,
> 
> This fix relies on some existing assmuptions of DualPI2.
> 
> > 
> > Turned to AI review and it found some things:
> > 
> > Right fix direction and the reported crash is real. A few issues before this is ready:
> > 
> > 1. The `c_len` construction is fragile. Declared `int`, initialized from a `u32 - u32`. If the invariant `qdisc_qlen(sch) >= qdisc_qlen(q->l_queue)` is ever violated, you get a large positive value, the C-queue branch is taken on an empty C-queue, `qdisc_dequeue_internal()` returns NULL, and the loop breaks out without draining the L-queue -- leaving the qdisc over limit. Simpler and more robust to just compare the two qlens directly and drop the delta variable entirely.
> > 
> 
> In current dequeue_packet() of DualPI2, we also calculate c_len via the same approach (line 524).
> 
> As we only have queue length of L-queue and both C- and L-queues, so this is the way we derive the queue length of C-queue.
> 
> > 2. Missing else/termination. If both branches' conditions are false 
> > (neither `c_len` nor `qdisc_qlen(q->l_queue)`) but the outer `while` 
> > still holds because `memory_used > memory_limit`, the loop spins 
> > forever.  An explicit `else break;` guards against an accounting 
> > desync becoming a hang. 
> 
> This shall not happen, but adding an extra else guard indeed is 
> definitely a good suggestion. 

Hi,

Maybe also add WARN_ON_ONCE() there so that such a problem would be 
exposed if it ever happens.

-- 
 i.


