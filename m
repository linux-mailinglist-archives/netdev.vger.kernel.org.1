Return-Path: <netdev+bounces-302976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XJWvIs9aQ2qvXAoAu9opvQ
	(envelope-from <netdev+bounces-302976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C856E08C8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tz2Wpuk0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302976-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4305D3002508
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8125356742;
	Tue, 30 Jun 2026 05:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EC3CF211
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:57:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799043; cv=none; b=iICmCQyw6zQSYFmzY3QBChG5tnwWStPH4Y0hUQM4suceoX8XTn/j+v9eeeshp0XTPE9XPKrQh5ukhX2x4ho1TLGsqZOrUrNjac4cMGlrZtFb0HKE8+G6fu4ApLAiAs6cI7h34Lu9dLrY+oZL43LGEcxm9/5E7bThOlCc7nOYzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799043; c=relaxed/simple;
	bh=VUkzefoP3syEwjoxsM0jd/kwkWaM6ARSRGBzCCPvXC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGYtZEROLAwqz6AL93ALMXAMS/lGv4yGPp4Z8paGWF7t3cJuGb/08xNsIKugTtB7vt7U9BCwU6waX+VOnGkshvGvypw8rDw4sX/9ph+mFyv7oW2zsnbzNW/GY/TPMHrzAfTiW+jTuhNTETTIvCuloIfICwK5ncSI1fUoDkJY8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tz2Wpuk0; arc=none smtp.client-ip=91.218.175.182
Message-ID: <3b746d04-33f3-4d86-bc8c-292a341557ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782799040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa2f4+8S5Vvxa/LNjMGjEcrUuIesTqSX7RxqUJee4vI=;
	b=tz2Wpuk0Jrg+yFgC5g2nhNqrkcERbK82CyZS3N/BSOVMhqv0oAZ1F61ptkqPHZRW7L3NUV
	W7Oz0pl2AkAybIU4PYK+qB7EGtOrvbNTJ1nZ48gE/A7PNnEhZ7Po76AWlNsfS1qbq0/KvY
	tIoyTI7Tt3igjD7TWgrz6pOE78XPfWI=
Date: Tue, 30 Jun 2026 13:56:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local
 bind range
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, luoxuanqiang <luoxuanqiang@kylinos.cn>
References: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
 <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com>
 <F6AFD54C-1618-4501-80C2-88F796BA95C0@linux.dev>
 <CAAVpQUA+yKA773dtgr2E=mu4SbMCjWZk83sFYrWS6f1sDphdRQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUA+yKA773dtgr2E=mu4SbMCjWZk83sFYrWS6f1sDphdRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:edumazet@google.com,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77C856E08C8


在 2026/6/30 02:21, Kuniyuki Iwashima 写道:
> On Fri, Jun 26, 2026 at 7:00 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>> 2026年6月27日 07:40，Kuniyuki Iwashima <kuniyu@google.com> 写道：
>>>
>>> On Fri, Jun 26, 2026 at 2:40 AM <xuanqiang.luo@linux.dev> wrote:
>>>> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>>>>
>>>> IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral port
>>>> range on a per-socket basis.  __inet_hash_connect() already treats such a
>>>> range as an explicit application partition and scans it with step 1 [1].
>>>>
>>>> Do the same in inet_csk_find_open_port():
>>> What's the use case of IP_LOCAL_PORT_RANGE + bind(, 0)
>>> without IP_BIND_ADDRESS_NO_PORT ?
>> Hi Kuniyuki,
>>
>> Thanks for the question!
>>
>> The use case is when an application wants to restrict ephemeral port
>> allocation to a socket-local IP_LOCAL_PORT_RANGE, but still needs
>> bind(..., 0) to allocate and reserve a local port immediately.
> IP_LOCAL_PORT_RANGE was introduced for connect().
>
> Unlike connect(), bind() occupies the port without SO_REUSEADDR/PORT,
> so I don't think the step 1 or 2 makes any difference.
>
Hi Kuniyuki,

That's a fair point — bind() takes exclusive ownership of the port
without SO_REUSEADDR/PORT, so the parity split only changes the scan
order, not the set of ports bind() can pick.  Correctness-wise there is
no difference between step 1 and step 2 here.

There are a couple of smaller things that made me think it is still
worth aligning the two paths, though:

- inet_csk_find_open_port() already consumes the narrowed range from
   IP_LOCAL_PORT_RANGE since commit 91d0b78c5177f ("inet: Add
   IP_LOCAL_PORT_RANGE socket option"), so the bind path isn't
   insulated from the option.  It just didn't pick up the relaxed scan
   step that __inet_hash_connect() got in commit 207184853dbdb
   ("tcp/dccp: change source port selection at connect() time").  Eric
   even noted at the end of that commit:

     "A similar change can be done in inet_csk_find_open_port() if
      needed."

   So this felt more like completing the companion change than adding
   something new.

- The entropy argument from commit 207184853dbdb applies equally here:
   the parity split drops one bit of the 16-bit sport for RSS hashing.
   Whether the port came from connect() or bind() doesn't matter to the
   NIC, and losing that bit hurts more when the application has already
   shrunk its port space with IP_LOCAL_PORT_RANGE.

- When IP_BIND_ADDRESS_NO_PORT is not set, plain bind(, 0) reserves a
   port immediately through inet_csk_find_open_port().  If the same
   application also uses connect() on other sockets within the same
   IP_LOCAL_PORT_RANGE, connect() now scans the full range while bind()
   still biases toward odd ports — so the parity heuristic works against
   itself inside the application's own partition.

Does that make sense, or am I over-thinking the consistency angle?

Thanks,
Xuanqiang

>> IP_BIND_ADDRESS_NO_PORT is useful when the application can defer port
>> allocation until connect(), but it changes this behavior: bind(..., 0)
>> does not reserve a port in that case. So it is not a replacement for
>> applications that need the local port before connect(), for example to
>> publish it to another component or set up local policy.
>>
>> This patch is also intended to keep the bind(..., 0) path consistent with
>> Eric's earlier change in __inet_hash_connect().
>>
>> Thanks,
>> Xuanqiang

