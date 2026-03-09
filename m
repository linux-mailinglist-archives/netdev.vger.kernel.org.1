Return-Path: <netdev+bounces-265778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNGLN+c/r2mYSwIAu9opvQ
	(envelope-from <netdev+bounces-265778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE4241D97
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC5593037D71
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E102C0303;
	Mon,  9 Mar 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="n9ySCdok"
X-Original-To: netdev@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71C18871F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092837; cv=none; b=fkGw4viz1Vjwh/x3/mr46vhUK17hHJfAAEXoYV6RY3QxFwrZ0wKhL5G2srLqJqzBiOT3yknteFOWxYnkVbSNah8AE4KcX5F64c8waHiwDDWK9NPclR3a8eFKIcHksnHAlF3Eu/JU/rN8/UhQAVBJBIO5/Fl7aT820vnkuqQVxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092837; c=relaxed/simple;
	bh=n2ResMgKZ5qR2/oPHB/TAsovK03SthZFanAYgIrnoOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxbIZrkclNBXQ+uTCaFbyWe/gZ0ceJGYUQM5igwoZsDhJ9NgWkYnfmTljXygnpA1Za1Yv+LcygJ5KhKkm0lmtjs2uxCguFbzjQiqsPo9Sg4G2ZDGnyJb73ibufO9DesUj5aiQFRsyQgcGox7aP2K/dEEgdWT86eQy1N+00rrvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=n9ySCdok; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id S8y4b9Id9kXXUoJM; Mon, 09 Mar 2026 17:47:12 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=0AcrpPbZG7LzixIV6utLwE3BLP2ZvhqSvrs7tOKnr5M=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=n9ySCdokk0ZXXI/pV/He
	ry8/UC9+nAA5o57tXZb/CPApQmDyqm/hWVPqGUUD9aY5AfwVO3w4ez8leotu4YiCQ4utJWRIHpJSj
	OLXdkX/vI1Etnr4HowSUQwuQmLhZ8Uwa97Gim7iN4+cvqjqi0WNA9QvQPPVbCw0+kVlrIPvil8=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14451565; Mon, 09 Mar 2026 17:47:12 -0400
Message-ID: <146f94cd-e8c1-423c-8ca7-1f849b684785@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 9 Mar 2026 17:47:12 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Long delay in freeing skbs
Content-Language: en-US
X-ASG-Orig-Subj: Re: Long delay in freeing skbs
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com>
 <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com>
 <CANn89iJziPq9Au9A8DK8Um6Nn2F-xTcG3+r5x0tVMf+7TUJEMg@mail.gmail.com>
 <cb925a24-c4a2-46cd-98e8-2be5e2aa2152@cybernetics.com>
 <CANn89iKVarorgFqxpCp9C5r1_ntRDcz7Xn-kXxpfwWLQkN++BQ@mail.gmail.com>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <CANn89iKVarorgFqxpCp9C5r1_ntRDcz7Xn-kXxpfwWLQkN++BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1773092832
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2814
X-ASG-Debug-ID: 1773092832-1cf43940a6c05f0001-BZBGGp
X-Rspamd-Queue-Id: 3DBE4241D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cybernetics.com,quarantine];
	R_DKIM_ALLOW(-0.20)[cybernetics.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cybernetics.com:+];
	TAGGED_FROM(0.00)[bounces-265778-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonyb@cybernetics.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cybernetics.com:dkim,cybernetics.com:email,cybernetics.com:mid]
X-Rspamd-Action: no action

On 3/9/26 17:24, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 10:18 PM Tony Battersby <tonyb@cybernetics.com> wrote:
>> On 3/9/26 17:07, Eric Dumazet wrote:
>>> On Mon, Mar 9, 2026 at 10:00 PM Tony Battersby <tonyb@cybernetics.com> wrote:
>>>> I have some out-of-tree code that was broken by commit e20dfbad8aab
>>>> ("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I
>>>> retested with 7.0-rc3 with the same results.  I'm not sure if the change
>>>> in behavior that I am seeing is expected or if it is a bug, so I thought
>>>> I would ask.  Omitting irrelevant details, my kernel code does the
>>>> following:
>>>>
>>>> 1) allocate a buffer
>>>> 2) perform some network I/O using the buffer (cmd over iscsi_tcp)
>>>> 3) wait for the I/O to complete
>>>> 4) wait for the buffer page refcounts to drop back to their values for
>>>> idle I/O
>>>> 5) reuse the buffer for more I/O
>>>>
>>>> Step 4 is necessary in this case due to some of those irrelevant details
>>>> that I omitted, and that is where it trips up.  Commit e20dfbad8aab
>>>> seems to keep the page refcounts elevated long after the I/O has
>>>> completed (hours or longer), presumably because the deferred skb free
>>>> isn't happening for a long time.  So:
>>>>
>>>> 1) Is this long delay expected, or is this a bug?
>>>>
>>>> 2) If the delay is expected, is there a way for me to force the network
>>>> system to process the deferred skb frees on request?  e.g. write to a
>>>> file in /sys, or call a kernel function to flush the deferred frees?
>>>>
>>>> Worst case is that I can redesign my code to kfree() the buffer if it is
>>>> busy and allocate a new one, and let the old buffer be freed
>>>> asynchronously when the skb is freed at some indeterminate time in the
>>>> future.
>>>>
>>>> Thanks,
>>>> Tony Battersby
>>> If you are using zero copy, please look at:
>>>
>>> Maybe you should make sure your code is compatible with it.
>>>
>>> commit 0943404b1f3b178e1e54386dadcbf4f2729c7762
>>> Author: Eric Dumazet <edumazet@google.com>
>>> Date:   Mon Feb 16 19:36:53 2026 +0000
>>>
>>>     net: do not delay zero-copy skbs in skb_attempt_defer_free()
>>>
>>>     After the blamed commit, TCP tx zero copy notifications could be
>>>     arbitrarily delayed and cause regressions in applications waiting
>>>     for them.
>>>
>> The I/O is being sent by a userspace program via the SCSI generic driver
>> (drivers/scsi/sg.c) over iSCSI (drivers/scsi/iscsi_tcp.c).  I don't see
>> any mention of zero copy in iscsi_tcp.c.
> Set /proc/sys/net/core/skb_defer_max to 0 ?

Thanks; I should have grepped the docs harder.

That seems to work if I do it before sending the I/O but not after the
I/O has completed.  So I presume it would decrease performance?

Tony


