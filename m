Return-Path: <netdev+bounces-296514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbDDNmmzJmqPbQIAu9opvQ
	(envelope-from <netdev+bounces-296514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:19:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E1656136
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iKxSHvAk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296514-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ECFD3083199
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742A37B007;
	Mon,  8 Jun 2026 12:13:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C237DAAA
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:13:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920803; cv=none; b=b+6VvvnN45kN5Q9cyimy5OyW0vgfAAWY2OhtkhhHSp97rbt8ZzU8xsL8/ERsNS9NnxXY7e3ba1Giie1o1GMFelbHlbsidV1x71bOjn80yC4Y3hW2jwy4Zqzux28vMLmScgazkWiNt69+H15Bu5BbKj6dXr7n6ZcLYIg6PIoeUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920803; c=relaxed/simple;
	bh=8dlgKkPtRH8bHQoP4/9fEfoxo70konJSuU6dvzo3f9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjwrrF4Nq+fzC4W8JlbFadszF/5q7k54OdrozlRU3ztJVjMKsUUfyQWezk3xLWd/4Dy3EjaG7hosZZXC5ON+glX4yAHhkdSIpjQG3fvVq3MLzb8m7Ze4hhbHgETHulcKlN4YgRXx+KUgHulwIWCN+LNRElniDp7oUnw8y5/oSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iKxSHvAk; arc=none smtp.client-ip=91.218.175.180
Message-ID: <ca4a6111-084f-4ec9-b411-1f79ef0866b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780920789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qLdgQOFPoLS8lqIoVa/g3Pc5VZu6aAkccWsW+ROeqk=;
	b=iKxSHvAkcysM603Fp2Wxjc36dlEjWAl0aDr+suhXJdTAup683n1BjoCe5RgVWF+f/5wSvD
	h4QckvKraqhQAwTyt5LSwpp7/oSq7aJ/9VPJeXZhH9ZIfGxRb1W1te23qvFWqGZIZBl2+F
	/1p+jiCZIa8G0bMHp2xH241XFtYcaBY=
Date: Mon, 8 Jun 2026 20:12:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
To: Yeswanth Krishna <yeswanth@linux.ibm.com>, netdev@vger.kernel.org,
 venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yeswanth@linux.ibm.com,m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296514-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B3E1656136


On 6/8/26 6:00 PM, Yeswanth Krishna wrote:
> Hi Team ,
>
> I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
> on a POWER10 system. The crash occurs when adding a slave device to a
> team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.
>
> **System Information:**
> - Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
> - Architecture: powerpc64le (ppc64le)
> - Hardware: IBM POWER10 (9043-MRX), pSeries
> - Config: CONFIG_FORTIFY_SOURCE=y
>
> **Crash Location:**
>
> [ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
> [ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
> [ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
> team_add_slave+0xc60/0xcc0 [team]
>
>
> **Call Trace:**
>
> __fortify_panic+0x18/0x28
> team_add_slave+0xc60/0xcc0 [team]
> do_set_master+0x19c/0x240
> do_setlink.isra.0+0x388/0x1450
> rtnl_newlink+0xac8/0x1030
> rtnetlink_rcv_msg+0x450/0x530
> netlink_rcv_skb+0x74/0x1b0
> rtnetlink_rcv+0x24/0x40
> netlink_unicast+0x2e0/0x430
> netlink_sendmsg+0x210/0x580
> ____sys_sendmsg+0x30c/0x470
> ___sys_sendmsg+0x94/0xf0
> __sys_sendmsg+0x84/0x100
> system_call_exception+0x154/0x2b0
>
> **Reproducer:**
> The crash is 100% reproducible via selftests:
> ```bash
> cd tools/testing/selftests
> make -C drivers/net/team run_tests


I tried this under x86, but the warning was not triggered with 
CONFIG_FORTIFY_SOURCE.


Hope somebody who has a PPC system can test it.



