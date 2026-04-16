Return-Path: <netdev+bounces-279106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGBdJ4Yi4WkBpgAAu9opvQ
	(envelope-from <netdev+bounces-279106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953A4135D9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA993304D977
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723AE31715A;
	Thu, 16 Apr 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wU1zd+S3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB1326928
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362114; cv=none; b=H1ciRLH4lBC7oXOqN941QgeejVV7ghN82BIKyy/WkFADXT5v8mH/ik9VXueFI3nJKynYoMrdMuUA/jJzrE1GG2toHfoZDOWsUJwnuPzDjOxF66WL8M+LDEPrNE+L/a1cZyXKPFJbAPyqnhAsLeBs9cZ3KZch22SDZX5iwfAKUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362114; c=relaxed/simple;
	bh=weTZRUMhn00reScjqQDzhSuXqozZ5F16/20bwvfN6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyFHJu+pKqkIniZETD4Z9/BBs42s0k8LjyG8FSmS94G5ZgS0LhZEmAa6PAqdFeQMHQ1Yr7jnwHlw3iB85PQFZIWM0mvInq653FAsTX3sF3j1mZG1QcC623P1vDLWxyeuRehj2qhdB0tn2tGTX30h/VJiqVMdvm48k3vOvNeE4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wU1zd+S3; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c55e3858cso7962548c88.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776362110; x=1776966910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7ps5CmpMQpmldkxYFQhE9/S6ubyJ5OkfZHPi2unonQ=;
        b=wU1zd+S34kra7EQrt1pBE8zig5ilnHd8JPXZe8mESGmRoSmRJL5YI6qPAr4emKL0vg
         u57c693kUI9jAijtIAkfiucdifnY8OB1lW/BYD6c6p1dqKfOWVhnjcaSD62Sz6lD6/f7
         HFpLSLcxZOemAHzlHOm4HsOcsMhHRJAkMTWMKXdaoKa/5GixhjuraqtbqVHhCVod+mpS
         S5wgSuuZFtaIIcOx04VIM9hxtfnbWJwEuK8SMMqisDDr2HzYaeB+q8hgPbbWHxvNT/yS
         Rzb4ZZKwHqt0uU1O3vAM3D4UyXeNtS/X17R36Q7gdsoNPBi53gv4/3etzDQslvNBwN1V
         Fmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362110; x=1776966910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7ps5CmpMQpmldkxYFQhE9/S6ubyJ5OkfZHPi2unonQ=;
        b=MtAS2NsYQbifKBoJJ3v7diC4iUAhZba3tJTql267y9LL0KyTeRzx0Q3wNrcSvdV2sl
         7Uy8I3xM4W3kZ6/9I4fv6j9a3bXdvcVczqHNk9xMRBQv8c+7P45gcUhTk0kxAO4aeckD
         w5UDDcHONmPbpSGWcbTc0jrmkuUgxvhcWPfhYQbx70iEsTC0u/5omUG85wji9yYLA2/Q
         PGpUsWXi/LHyRGBQ85PfaaJoA9TQCXIIjdQuu/Uio+J4kTjGuqkMNivKFpbOcxvqjQwQ
         ZcVLX+0JH7EoqeJIq2ICYhvOVzqFv9Ejb1Ac8VLzT0mL0Sv5HZFOPGWhwWn486EF1oZS
         UQVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/avVegYgz5Hr4Hb5UU97HtY5SY2QEwnc+JCM181EKydAsADEKygomkhdYaEpfph5940btLhiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6hx9NVGD4mGCCkKOeZJStKLZw6LkqS7wcxTMN0ddksImYt3U
	vivPGb+l1pCnJfvqQxcKK47exp9vtWHY4DWWliVs7s7Fb+wAzEs0PsTta1N9ixN8ZZk=
X-Gm-Gg: AeBDiev506+vewjVGmxdGqI5IcO0mquIr/WIyl9bhltBQAZ1mIdVpyXMlHOODTdVzzt
	PaR6hVA4TDmuE1ZGEDZ2NwJ9Kln+IlTZJYIrnCQRPcbR5JDjhk6XXn8yfcQ3nL5MhwIqhCIGACZ
	CvWKzMn4CXcfKvvy01H/x2ZmIcb2+ltaurcnK+J9wpDcxalk1DJn9OwO98eUOZlWQJkpmli5Jnh
	taamMe7iRWUkQ+4qyrDL1fEUfFDmAd0hvqZ9+geXS8zgOpN1VkeQGXZUAK9olZVxs+71rJLZYFP
	UKtKBOSa9bI2ywDeqx4Sxy6nsYs31D0ECtExbnoaC/1G3E8MJxQoH2WLY1Dh5IsdIWaIvGBLAzX
	5BaIZP9bx3G/jqADiRVIekwP1DVYJAME/8UFcJgJGhIFnpcw3FTChWyk5iKYRgjs6zNgYMJhUS6
	zR3Glk2ISqyOrLvq5b7+IBBS17MPVLUNVAmcmdzeHbr9AXpg==
X-Received: by 2002:a05:7022:6b97:b0:12b:ed30:5b85 with SMTP id a92af1059eb24-12c727e0883mr79884c88.2.1776362109363;
        Thu, 16 Apr 2026 10:55:09 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e61db6bsm6778975c88.1.2026.04.16.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:55:09 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:55:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: victor@mojatatu.com, hxzene@gmail.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Message-ID: <20260416105505.22383f01@phoenix.local>
In-Reply-To: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279106-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0953A4135D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 19:09:06 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Fix dualpi2_change() to correctly enforce updated limit and memlimit values
> after a configuration change of the dualpi2 qdisc.
> 
> Before this patch, dualpi2_change() always attempted to dequeue packets via
> the root qdisc (C-queue) when reducing backlog or memory usage, and
> unconditionally assumed that a valid skb will be returned. When traffic
> classification results in packets being queued in the L-queue while the
> C-queue is empty, this leads to a NULL skb dereference during limit or
> memlimit enforcement.
> 
> This is fixed by first dequeuing from the C-queue path if it is non-empty.
> Once the C-queue is empty, packets are dequeued directly from the L-queue.
> Return values from qdisc_dequeue_internal() are checked for both queues. When
> dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
> updated explicitly to keep overall qdisc statistics consistent.
> 
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---

I was a little concerned about the complexity of managing qlen here.
But could not find anything obvious.

Turned to AI review and it found some things:

Right fix direction and the reported crash is real. A few issues before this is ready:

1. The `c_len` construction is fragile. Declared `int`, initialized
from a `u32 - u32`. If the invariant `qdisc_qlen(sch) >=
qdisc_qlen(q->l_queue)` is ever violated, you get a large positive
value, the C-queue branch is taken on an empty C-queue,
`qdisc_dequeue_internal()` returns NULL, and the loop breaks out
without draining the L-queue -- leaving the qdisc over limit. Simpler
and more robust to just compare the two qlens directly and drop the
delta variable entirely.

2. Missing else/termination. If both branches' conditions are false
(neither `c_len` nor `qdisc_qlen(q->l_queue)`) but the outer `while`
still holds because `memory_used > memory_limit`, the loop spins
forever. An explicit `else break;` guards against an accounting desync
becoming a hang.

3. Whitespace: two lines in the L-queue branch use spaces instead of tabs --

+                        q->memory_used -= skb->truesize;
+                        rtnl_qdisc_drop(skb, q->l_queue);

checkpatch will flag this.

4. Comment style. The three-line comment at the end of the L-queue
branch doesn't follow the net subsystem multi-line comment style
(leading ' * ' on continuation lines, closing ' */' on its own line).
Once the code is cleaner, the comment could also just be dropped or
shortened to one line.

5. The accounting in the L-queue branch is correct, but only if you
trace the enqueue invariants carefully: L-queue packets are counted in
*both* `sch` and `q->l_queue` on enqueue (see dualpi2_enqueue_skb lines
413-423), `qdisc_dequeue_internal(q->l_queue, true)` adjusts l_queue's
side, and the explicit `--sch->q.qlen` + `qdisc_qstats_backlog_dec(sch,
skb)` adjusts sch's side. Separately, the C-queue branch now quietly
relies on the post-CVE-2025-39677 semantics of
`qdisc_dequeue_internal()` handling parent backlog -- which is why the
pre-patch `qdisc_qstats_backlog_dec(sch, skb)` could be removed.
Neither of these load-bearing invariants is documented in the code or
the commit message. Please add an inline comment in the L-queue branch
explaining the double-count-on-enqueue, and mention the
qdisc_dequeue_internal() dependency in the commit log.

6. Commit message / subject. Subject reads as if only the L-queue path
changed, but the whole drain loop was restructured. Something like
"sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()" would
describe it better. Also, on NULL return from qdisc_dequeue_internal()
the loop silently breaks -- if that ever triggers it means qdisc_qlen()
> 0 but dequeue returned NULL, which is a real invariant violation.
> Worth a WARN_ON_ONCE().

Suggested shape:

	while (qdisc_qlen(sch) > sch->limit ||
	       q->memory_used > q->memory_limit) {
		struct sk_buff *skb;

		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
			skb = qdisc_dequeue_internal(sch, true);
			if (!skb)
				break;
			q->memory_used -= skb->truesize;
			rtnl_qdisc_drop(skb, sch);
		} else if (qdisc_qlen(q->l_queue)) {
			skb = qdisc_dequeue_internal(q->l_queue, true);
			if (!skb)
				break;
			/* L-queue packets are counted in both sch and
			 * l_queue on enqueue; qdisc_dequeue_internal()
			 * handled l_queue, account sch here.
			 */
			sch->q.qlen--;
			qdisc_qstats_backlog_dec(sch, skb);
			q->memory_used -= skb->truesize;
			rtnl_qdisc_drop(skb, q->l_queue);
			qdisc_qstats_drop(sch);
		} else {
			break;
		}
	}


As with any AI feedback, expect it to generate hints but also be wrong.

