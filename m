Return-Path: <netdev+bounces-277635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK86BYee2WmerQgAu9opvQ
	(envelope-from <netdev+bounces-277635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:06:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA993DDD0E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EB88303AB4B
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F5264A9D;
	Sat, 11 Apr 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9w/h6op"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F02238C1B
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869537; cv=none; b=URri44iX9cPcBeObbu/hG+AaA8UIvfh1bysb8DKPrukgOF6HyjUMWG1eFjZ3SrQg9gJ/RyIUVFvVWxoc09sKq/azt7gasxSZhtTCf/daetusSo3XT059gLhequY31GtYdi4h7f8GI/ucUbvBE+vJohO3n/JmTh6w5IJqz7mfPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869537; c=relaxed/simple;
	bh=Mj2JSPiQ7qUlq+UnF/pTR82EVW9XrkmLw85SNWcSttw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTr360nOwE+KBNruLnAfScHBwkoZdaZ9iZSbF0O3vmkbMcBVyCvlD7JQ6nk5/OBgjPksDC7zRtUkFI0P32EEBYstafJf7M7SWKLMvAwPSVpyJ6xCAPWovsemaxr/t9ZKEkcwDEgqa6OeA1X4WGDtEHrvU/x0ZPYOhesekxKrp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b9w/h6op; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce0aeb2f-55a5-4445-8a5a-e2a0fef75f4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775869523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzowawuhjssmOibz4u6Ng0JIXaca22FBMTkYloQqV0Q=;
	b=b9w/h6opH4wE5Izkc8DtGE6YAcekG3DmckRpJ+NMiyNbReKg+26PUTCFw34pJAb9OOE4KL
	XOqNjpx33W6m6/2GKQtsyzEFvFDzG4Vzwl08967kSthRU1sT48WGYyApnidLRNE8lNfy1L
	c0H0Mn90FmXAyYgQWT/s2JBjA1ucfD4=
Date: Sat, 11 Apr 2026 09:05:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1] net: add missing syncookie statistics for BPF
 custom syncookies
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260409124129.361777-1-jiayuan.chen@linux.dev>
 <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAA993DDD0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/11/26 6:31 AM, Kuniyuki Iwashima wrote:
>> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>>     cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>>     CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>>     true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>>     config for BPF program functionality.
>>
>> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>>     This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>>     net/core/filter.c which is compiled unconditionally, so wrapping
>>     the definition in a config guard could cause build failures when
>>     CONFIG_BPF_SYSCALL=n.
>>
>> 3. Fix mismatched declaration of cookie_bpf_check() between the
>>     CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>>     'struct net *net' but the declaration in the header did not.
>>     Add the net parameter to the declaration and all call sites.
>>
>> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>>     statistics in cookie_bpf_check(), so that BPF custom syncookie
>>     validation is accounted for in SNMP counters just like the
>>     non-BPF path.
>>
>> Compile-tested with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_SYSCALL
>> not set.
> Can you add SNMP test in tcp_custom_syncookie.c by checking
> the delta before connect_to_fd() and after accept() ?


Thanks for the suggestion. I've added the following to the existing test 
case and it works correctly:

+   recv_before = read_tcpext("SyncookiesRecv");
+   failed_before = read_tcpext("SyncookiesFailed");

    client = connect_to_fd(server, 0);
    if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
          goto close_server;

    child = accept(server, NULL, 0);
    if (!ASSERT_NEQ(child, -1, "accept"))
          goto close_client;

+   recv_after = read_tcpext("SyncookiesRecv");
+   failed_after = read_tcpext("SyncookiesFailed");

+   ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
+   ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delta");

Will include it in v2.


