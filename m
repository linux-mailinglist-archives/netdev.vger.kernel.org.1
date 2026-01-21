Return-Path: <netdev+bounces-251874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N7UOWLUcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:28:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9F57854
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F76C19E9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3A3C1963;
	Wed, 21 Jan 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="SnQQZQoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491083A0EA4;
	Wed, 21 Jan 2026 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001646; cv=none; b=n83J2Jv3YGJx6ixCLPPjPK3LUQEdLkSR2uBeLjXUKYty1zUYeUAQL9jUrxvaEWswWvdEKBUHOVmqeFLlZ755Mg3k7+pBP83k9QZi1FexGxbuM6xSwKNyCiHoVL9BmVJAtCHwUhuwJIcQRah0Jug8NFDbn7Zooh1ZDRwmvgv80cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001646; c=relaxed/simple;
	bh=l0PSNhejVGg92vLicGM6zM3cqqOU84Is2se+bSM/8QE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IbdlbWXIz+Vk5lpkjbUgwqObwk6Jtpc0OijEUQLmW4iaL5/1/gsyvhjxmA7gkVOidsCfRtRf0jMYkWduoMBUxlAv8e4GmYJZMwmfNcWcnpflHKu34nrPNQP+3ZRMp7dCHzH9I0wt+OmDWnT2lpW4A6sjRZYZ3MwM22yg3sCEtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=SnQQZQoq; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001636; x=1769260836;
	bh=HKH4mZFZzxv5eT9rm3dUb9CwA8jN+PAVhBqZXvjArSU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SnQQZQoqmG3nEs0syHMVX7zmMW2hQ3KvqeJ5Bm9sHHQlj3eq15av6VTSHy3i5xmdQ
	 SEJ778c8oa8HvkYHclrIZFNqiuDh7QgvbvaedFS16DSHECJlv2840ZQZLJQ4Cdz0AA
	 r01GtyDb7RvD8OeAasKDp1B5r5eJJ8UnVEq7pfn6FQ4sGZS29BefAxsFfffJPMwbD3
	 frIzhHpNMXKeluGmTySUg0gCim364DgGDWqnAKVJ/vpMiNPBZF4AJDXbrFj2VwY+oa
	 NsgiFUh4+fyhnjATgSpWMEKJkB6fOj4HPVkXnDKoMNQZvxizdgzR6ZUNm8Hxr+Lg5n
	 tOG2SIez2AO0g==
Date: Wed, 21 Jan 2026 13:20:30 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v3 0/7] net/sched: act_gate RCU schedule update fixes
Message-ID: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: caf6555e15f754c6aa0d908ebac8d38c82478b57
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251874-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,1g4.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 92A9F57854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a schedule lifetime race in `act_gate` between the
control-plane replace path and the running hrtimer callback (gate_timer_fun=
c).

Before this series, a gate action could be replaced via
`RTM_NEWACTION | NLM_F_REPLACE` while its hrtimer was armed or executing.
The replace path frees the existing schedule entries immediately, but
the timer callback may concurrently dereference and walk the old entry
list to compute the next expiry. This allows the timer to observe freed
memory, leading to UAF or NULL dereference depending on timing and reuse.

The fix publishes gate configuration updates using an RCU snapshot
pattern. A new parameter set (including the schedule list) is fully
constructed first and then swapped in atomically via an RCU-protected
pointer. Readers (timer, dump, and accessors) only dereference the
current snapshot under RCU, and the old snapshot is reclaimed via
`call_rcu()` after the swap. This ensures the timer never observes freed
or partially invalid schedules during a replace.

Additional hardening included in this series:

* Zero-initialize the netlink dump struct to avoid leaking stack padding
* Reject empty schedule lists, which result in undefined runtime behavior
* Guard against NULL parameters in accessors during teardown
* Cancel the hrtimer outside `tcf_lock` to avoid lock inversion with the
  timer callback; cancellation is limited to clockid changes to avoid
  unnecessary blocking

Stable relevance:

* Fixes UAF / NULL deref hazards when a gate action is replaced while the
  timer, dump, or accessors are active
* Fixes a potential deadlock when canceling the hrtimer under `tcf_lock`
* Fixes a padding information leak in netlink dumps
* Dependency chain: patches 2=E2=80=937 build on patch 1 and on each other

Changes since v2:
* Split patch into logical steps
* Split hardening into explicit empty-schedule rejection and NULL
  accessor guards
* Align `tcf_gate_init()` initialization with net/sched conventions
* Cancel the hrtimer only when the clockid changes on replace
* Allow basetime to advance correctly on REPLACE
* Make `tcf_gate_copy_entries()` leave cleanup to the caller on failure
* Initialize `parse_gate_list()` error handling defensively

Paul Moses (7):
  net/sched: act_gate: zero-initialize netlink dump struct
  net/sched: act_gate: add RCU support for parameter update
  net/sched: act_gate: build schedule and RCU-swap
  net/sched: act_gate: read schedule via RCU
  net/sched: act_gate: cancel timer outside tcf_lock
  net/sched: act_gate: reject empty schedule list
  net/sched: act_gate: guard NULL params in accessors

 include/net/tc_act/tc_gate.h |  65 ++++++--
 net/sched/act_gate.c         | 295 ++++++++++++++++++++++++++---------
 2 files changed, 268 insertions(+), 92 deletions(-)

--=20
2.52.GIT


