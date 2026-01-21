Return-Path: <netdev+bounces-252041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB06Nbs2cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:27:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C25D365
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23DA036A862
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4783C1FF1;
	Wed, 21 Jan 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0ZyBtvy"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD63B9617
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022820; cv=none; b=jdIFZwplrZXaiWHh9V09S1qPawIolQ5/2AFcHu1ZMK7znKkXwXrM+HbcprGUdrCCW24wNC3jN31ZdZQkbBk7/kUyJkzb0aqrGGASnzeNYwtzEau6jYO4IhuXHKPA8qKSj9xLtG5tsKOiu80xcjsDmv+Fq57LXOVId6RwoCet6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022820; c=relaxed/simple;
	bh=vjOVXSo3T85HEyir+H+bPxqWVOrjA1RPvJMn1qN1v64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZpiboBqSAWXavJsrqAIUUXsmyOOaRpLhr4GgZmxVnDQk3eerYrQft3QtAN9jneGATggxTQBUyr7B596EeEbRijc+eEgJxPHSchsGytubUIiIpynuPQOFUC9EYrMp6HSKIER6VWKDYz3bpf3wpvssCDxdgpEACSVWlhrf0pxpuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0ZyBtvy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4423cc78-ec0c-4171-bf34-cc9b6596fa5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769022815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E99BhWiOtvsKj9LVOMwPQhY+2wWMRQYA7EVhZuxyw14=;
	b=V0ZyBtvyKJZdMGqTU0STyz8AP7VS5c8AEuDECKwstnTitLABAxUEHAO0njHeGLiKpo1twQ
	ya7whERJswcaLc3EURTQ6V8hrKIaShPgeu3eQw3MjLGYN9uyhuD0LpExN//l+7hqliPdAo
	Wkl6hFyh6efkq/Ly73mg86SKA7f4QSI=
Date: Wed, 21 Jan 2026 11:13:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, bpf@vger.kernel.org
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
 <d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev>
 <87o6mnthwf.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87o6mnthwf.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 402C25D365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 1:49 AM, Jakub Sitnicki wrote:
> On Tue, Jan 20, 2026 at 03:48 PM -08, Martin KaFai Lau wrote:
>> On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
>>> Remove pro_epilogue_with_kfunc test program and its supporting code in
>>> bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
>>> which is no longer supported after the switch to direct helper calls.
>>
>> Is it easy to change it to test calling helper in pro/epilogue?
> 
> I gave it a shot and the obstacle is that bpf_cgroup_from_id and
> bpf_cgroup_release are not exported symbols, so they can't be referred
> to from bpf_testmod. We'd have to move the whole thing to lib/test_bpf
> so it's a built-in.

I was thinking of creating a helper in bpf_testmod.c but then noticed it 
may fail in the JIT that needs bpf_jit_supports_far_kfunc_call(). A 
cleaner way could be to use the existing pro/epilogue in bpf_qdisc ops. 
I was wondering if the __xlated test here could be quickly adapted in 
patch 4 but it seems that's not the case. The existing bpf_qdisc is 
testing it quietly without the __xlated, so no need to hold up this set.

For patch 3 and 4,

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

