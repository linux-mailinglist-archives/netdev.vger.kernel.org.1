Return-Path: <netdev+bounces-265777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BDbK9g9r2mDSgIAu9opvQ
	(envelope-from <netdev+bounces-265777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:38:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70C241CFA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459EB3112066
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA4344056;
	Mon,  9 Mar 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="qWDNv+x5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4E220F2D
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092080; cv=none; b=p7ptbC6yzrPy7X0craNxWS0S78Bp3vWtO4MDub+xKO9ZV8FEPybVCQFj4NyXsIsuPBRJM68TR4f4Ndu5TrVwILEXmz/+Gzu/Es17sDUM1G96ByHEknJcSb7jY//TKL2OeHISlCAr+jrEdwbzO9yLPDD4pzwbZBhr2SBltlt2I/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092080; c=relaxed/simple;
	bh=Ok6eF+GftazIxpYrdRG70Q2VyR3xpD0Cdi9/4UF5+l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZgmpIUA7VYTDXV3Zi7Rxz0CBO1n29vNFbftfotfMfr0Q9jwPST+rHiy9SZXtNWBu+og0O0hG9Yzbh5NdpSST7QUzXcJCOtroZSXHJMT1fVOEO9zjdlMpqdMSWaTuRBYx7IHcjlNdY9+ws8jHVYV6BiCEFVJosZCb2NIVEWvOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=qWDNv+x5; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id Yjth4GmSgi4SVCY0; Mon, 09 Mar 2026 17:18:35 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=juwwqoR0TQdvhEwmLjJNiRO2kvCT0d1TyAi3AmiRBWo=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=qWDNv+x5oxQ+jfTee9vw
	slKh615rjUJI6lzUt6SBZFXwWYnTHpKw0q6CiRSTJAi362LkMciIfahxjUoETZZVJMMasF0K7SYk3
	rBLzpbPGMADnMztqPd3b/V9UmQd+BrOcRF4iaIxR1CnwORe+jjNDrfXojloG2dCjZw64ZD2lYI=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14451450; Mon, 09 Mar 2026 17:18:35 -0400
Message-ID: <cb925a24-c4a2-46cd-98e8-2be5e2aa2152@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 9 Mar 2026 17:18:35 -0400
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
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <CANn89iJziPq9Au9A8DK8Um6Nn2F-xTcG3+r5x0tVMf+7TUJEMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1773091115
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2352
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1773091115-1cf43940a6bfa00001-BZBGGp
X-Rspamd-Queue-Id: 3B70C241CFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cybernetics.com,quarantine];
	R_DKIM_ALLOW(-0.20)[cybernetics.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cybernetics.com:+];
	TAGGED_FROM(0.00)[bounces-265777-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonyb@cybernetics.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cybernetics.com:dkim,cybernetics.com:email,cybernetics.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 17:07, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 10:00 PM Tony Battersby <tonyb@cybernetics.com> wrote:
>> I have some out-of-tree code that was broken by commit e20dfbad8aab
>> ("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I
>> retested with 7.0-rc3 with the same results.  I'm not sure if the change
>> in behavior that I am seeing is expected or if it is a bug, so I thought
>> I would ask.  Omitting irrelevant details, my kernel code does the
>> following:
>>
>> 1) allocate a buffer
>> 2) perform some network I/O using the buffer (cmd over iscsi_tcp)
>> 3) wait for the I/O to complete
>> 4) wait for the buffer page refcounts to drop back to their values for
>> idle I/O
>> 5) reuse the buffer for more I/O
>>
>> Step 4 is necessary in this case due to some of those irrelevant details
>> that I omitted, and that is where it trips up.  Commit e20dfbad8aab
>> seems to keep the page refcounts elevated long after the I/O has
>> completed (hours or longer), presumably because the deferred skb free
>> isn't happening for a long time.  So:
>>
>> 1) Is this long delay expected, or is this a bug?
>>
>> 2) If the delay is expected, is there a way for me to force the network
>> system to process the deferred skb frees on request?  e.g. write to a
>> file in /sys, or call a kernel function to flush the deferred frees?
>>
>> Worst case is that I can redesign my code to kfree() the buffer if it is
>> busy and allocate a new one, and let the old buffer be freed
>> asynchronously when the skb is freed at some indeterminate time in the
>> future.
>>
>> Thanks,
>> Tony Battersby
>
> If you are using zero copy, please look at:
>
> Maybe you should make sure your code is compatible with it.
>
> commit 0943404b1f3b178e1e54386dadcbf4f2729c7762
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Feb 16 19:36:53 2026 +0000
>
>     net: do not delay zero-copy skbs in skb_attempt_defer_free()
>
>     After the blamed commit, TCP tx zero copy notifications could be
>     arbitrarily delayed and cause regressions in applications waiting
>     for them.
>
The I/O is being sent by a userspace program via the SCSI generic driver
(drivers/scsi/sg.c) over iSCSI (drivers/scsi/iscsi_tcp.c).  I don't see
any mention of zero copy in iscsi_tcp.c.

Tony


