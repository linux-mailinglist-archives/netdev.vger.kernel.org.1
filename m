Return-Path: <netdev+bounces-260848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMdFCaHFnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:49:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA51954A0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06859302BDE6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D002304BB4;
	Wed, 25 Feb 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xG7D2YoJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEB33CE85
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012917; cv=none; b=Nyjcx8NW+hnB3PAOW0F21TQdBQ1TS790tPaILOxT9OIZxe3GAsywy5GdQGB+aS68rDkeRfHgQKcTCy1ctdZwEkImo35uJRq2YaMTPi3RX9vZa8AWmXcaq6HxoXwY6s6rpqWPV+24hu8uc/W9Ycf9avf6q7vNbxjHZRc2cYJVVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012917; c=relaxed/simple;
	bh=0vuh+UkammmyujgIvqj3KuIm9vzV56ONGePfocRu8yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9/w4l3tcAC4lWV/fCTUfwzlNPuZP36ownOLnT1Hk57PFhp3T6jrugtVSKziNhWoCh++mJVw/OAhAtMd4PRkd0vNoMALSD8WsoKt0USHwtLNjZ3Oon5CGm6tclmUc89AxcSbyvNpfGILh4EyBTJdbHdYi1EoghTei5FHznx8ReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xG7D2YoJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6eae6e1-b0ad-4027-ac53-26abbfabe2c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772012903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7F++bMkQXdIC4u8xt2NgZr7EX4XnUN5usbpMgsViBs=;
	b=xG7D2YoJxlHSSR2JyXaJ4MVXWyoaaDnDONqw3Z3mf21T9P9YNdfFXd5w7Wf9PPdd7ssVU2
	ChA1Ugzr+uYlYVcypAZP5F7CFsPqE6w3H3l9Ny5bIhN3U9iUqblNfr1JJ/g4pDVeayf1bJ
	K5KqMWOp2dqEsS7xXmgx0BckLrleofA=
Date: Wed, 25 Feb 2026 17:48:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <CANn89i+RZtN0wcyBUxKf83pkcbH4=nN_Cpc62tNwwS8T-LQR2A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CANn89i+RZtN0wcyBUxKf83pkcbH4=nN_Cpc62tNwwS8T-LQR2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4FA51954A0
X-Rspamd-Action: no action



On 25/2/26 16:31, Eric Dumazet wrote:
> On Wed, Feb 25, 2026 at 8:46 AM Leon Hwang <leon.huangfu@shopee.com> wrote:
>>
>> Introduce a new sysctl knob, net.ipv4.tcp_purge_receive_queue, to
>> address a memory leak scenario related to TCP sockets.
> 
> We use the term "memory leak" for a persistent loss of memory (until reboot)
> 

Thanks for the clarification.

> Lets not abuse it and confuse various AI/human agents which will
> declare emergency situations
> caused by an inexistent fatal error.
> 

I'll reword it in the next revision.

>>
>> Issue:
>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
>> current implementation does not clear the socket's receive queue. This
>> causes SKBs in the queue to remain allocated until the socket is
>> explicitly closed by the application. As a consequence:
>>
>> 1. The page pool pages held by these SKBs are not released.
> 
> This situation also applies for normal TCP_ESTABLISHED sockets, when
> applications
> do not drain the receive queue.
> 
> As long the application has not called close(), kernel should not
> assume the application
> will _not_ read the data that was received.
> 

Understood.

This patch provides an option to drain the receive queue in the
CLOSE_WAIT + RST case, instead of purging it unconditionally upon
receiving a RST packet.

> 
>> 2. The associated page pool cannot be freed.
>>
>> RFC 9293 Section 3.10.7.4 specifies that when a RST is received in
>> CLOSE_WAIT state, "all segment queues should be flushed." However, the
>> current implementation does not flush the receive queue.
> 
> Some buggy stacks send RST anyway after FIN. I think that forcingly
> purging good data
> received before the RST would add many surprises.
> 

Understood.

There is a tcp_write_queue_purge(sk) call in tcp_done_with_error(),
which means sk_write_queue is always purged when a RST packet is
received. I assume the reason for purging sk_write_queue is that any
pending transmissions become meaningless once a RST is received.

Would it be better to defer kb_queue_purge(&sk->sk_receive_queue) until
after tcp_done_with_error()?

[...]

>>
> 
> Please prepare a packetdrill test.

Ack.

I'll add a packetdrill test in the next revision.

Thanks,
Leon


