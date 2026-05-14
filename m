Return-Path: <netdev+bounces-287914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKirGDOnBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:42:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2F54085C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA7F302497B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52515387341;
	Thu, 14 May 2026 10:39:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21563859DC
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755142; cv=none; b=DCq6/mdkfYhK/NhSdzF3hDu6GNmKWZdmUGOYIi9exh3U5ZmiD2q6TW+gdEA7+f/AJTVpgLkZg9VJyD41W4qfBVY92xaLqhCOpNzUmjtw1S6JBtzSIGa1RIJeMMFQ2j7u5IPZUAWDyGw+wKql4AAvVHzD3Q64ZgD9lCtmdSAzDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755142; c=relaxed/simple;
	bh=Dp7wpANo6hZOELEjCTDK5fabhzCycxcBtPvddLI6s0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgrkMKEYWictEf6mEVBoRCodjs0Vnnj3Td8JCD1kX0P0oLqqt57VVTvQaiFgbifOo5yGjfq18es7qX7l0wrEZRmjiYHIH4bXKxAF/2J1Lwf4UCzaz4x0ptEs6CBZWfKj8+O6ZvDEJ+nar1cEOjcwVWwJJAQzTkkb/uICGHFZxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64EAcNhl011106;
	Thu, 14 May 2026 19:38:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64EAcNEP011103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 19:38:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <260a0064-0fa2-40cc-bb8c-1ee29f12dd1d@I-love.SAKURA.ne.jp>
Date: Thu, 14 May 2026 19:38:19 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering
 devices
To: Xu Rao <raoxu@uniontech.com>, idosch@nvidia.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
        willemb@google.com
References: <20260513073031.GA344043@shredder>
 <16DB33EB3B04B258+20260514094412.1497787-1-raoxu@uniontech.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <16DB33EB3B04B258+20260514094412.1497787-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Queue-Id: BCB2F54085C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287914-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On 2026/05/14 18:44, Xu Rao wrote:
> The reproducer is the syz repro from the syzbot report:
> 
> https://syzkaller.appspot.com/x/repro.syz?x=103f3dba580000
> 
> I don't have a standalone C reproducer. I asked syzbot to test the patch
> against the original report tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> 
> The reproducer did not trigger the issue with this patch applied:

Will you test your patch with

-		if (dev->reg_state == NETREG_UNREGISTERING)
-			break;
-
+		WARN_ON(dev->reg_state == NETREG_UNREGISTERING);

and confirm that WARN_ON() fires, for nobody knows whether this refcount
was obtained after dev->reg_state became NETREG_UNREGISTERING ?

Please be aware that the stack traces that follow

  unregister_netdevice: waiting for netdevsim1 to become free. Usage count = 2

do not indicate that these references are obtained after the

  unregister_netdevice: waiting for netdevsim1 to become free. Usage count = 2

message was printed. The stack traces indicates only where the leaking refcount
was obtained.

>> The kernel repeatedly sends NETDEV_UNREGISTER notifications when it's
>> waiting for the reference count to drop.

It is true that the kernel repeatedly sends NETDEV_UNREGISTER notifications,
but it is not always true that the NETDEV_UNREGISTER handlers works for
every notification. Some NETDEV_UNREGISTER handlers do something for only
the first NETDEV_UNREGISTER notification and is do nothing for the subsequent
NETDEV_UNREGISTER notifications, for a NETDEV_UNREGISTER handler might
unregister cleanup functions (and fails to cleanup resources obtained
afterwards).

My experience says that operations which are not serialized by the RTNL lock is
more prone to this refcount race than the netdev handlers which are serialized
by the RTNL lock. To close such race, we need to check operations which are not
serialized by the RTNL lock. An example was commit 5d5602236f5d ("can: j1939:
make j1939_session_activate() fail if device is no longer registered").

> The guard only affects the MTU / UP / CHANGE paths. The problem I was
> trying to avoid is creating new IPv6 state once the device is already in
> NETREG_UNREGISTERING. In the syzbot trace, addrconf_notify() is reached
> from a NETDEV_CHANGE path and then creates a link-local address and its
> route while unregister is already in progress. The route then holds a
> netdev reference via fib6_nh_init().
> 
> So the patch does not rely on suppressing unregister processing; it only
> prevents late autoconf from adding new state during unregister.

Unless you confirmed that WARN_ON() fires, a single successful "#syz test" response
is not sufficient for believing that your patch actually fixes this problem.

I think that we want some debug printk() patches like
https://lore.kernel.org/all/e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp/T/
in order to get more debug information.


