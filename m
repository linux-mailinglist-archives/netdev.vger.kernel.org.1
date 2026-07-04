Return-Path: <netdev+bounces-304710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D3Z2G54KSWqnxwAAu9opvQ
	(envelope-from <netdev+bounces-304710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 15:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2E707B3E
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 15:29:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=BaSpW3Aq;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304710-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FEE63013A6C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A63A9619;
	Sat,  4 Jul 2026 13:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE09202C48
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 13:28:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783171737; cv=none; b=dMzCg4mykXMqnLlDu3Q/j759sXK69MRFcsrx6jQvE5IHrq8SsrZ3RKRcKvw2S7YV8JA3mPfNV/8EPfoInQxyFyJAMXzDLmMUogiWo9I6zKIBK1A6c5oIQAFiD6HAsa24X1n/UOeEz9ht7grvh30GPt16M7GF8qzo/1ET5D0yVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783171737; c=relaxed/simple;
	bh=k0K06vKwyQw3fWCt/Wz07XfXY9ixM9oTAZwy7Pg0p6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZeVbW/SBt+R/KmB/NeTX5DnGoSx/tigSV5pr6xo78kpFodWPM30IR87Qh1dZixKiitG938w7LWMH1h4tH8koIhGLiGgHLqe1ETuwtkruiLbkbIHs4luvOj1mZeaZ6P0CwkDMaAWKGgJAKz+HPo/08IEshjMlWtsm3i9NijfBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BaSpW3Aq; arc=none smtp.client-ip=95.215.58.188
Message-ID: <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783171724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR3dxjgK7pL4YTT2MquE2rbdmcrJvmHTMmrgvUy8wrY=;
	b=BaSpW3Aqg8mn3WJD0OGNvHXRbfG7moyF5TyeLfnuG7qfH6aDfOLJHqEofbRNAFZFc51lOw
	lpyaTwJ0PEwEQY5tctIDoLdvo88YTw6dSJu87T6SRMTu7RLlQv5ZBPanCky4tiIVkkSx3M
	T0p7Kvfi+eONeb75NuoGD0IyWTr+Pio=
Date: Sat, 4 Jul 2026 21:28:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed
 tracepoint
To: Masashi Honma <masashi.honma@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
 <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-304710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:masashi.honma@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:masashihonma@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F2E707B3E

Pls do not top-post.

See
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions.

On 2026/7/4 13:50, Masashi Honma wrote:
> Thank you Leon. I think this is a much better direction than my RFC, so I'll
> drop my tracepoint proposal and support your approach instead.
> 
> Since a user-space dependency on the existing tracepoint would make it hard
> for you to retire it, I'll make sure the Cilium PR doesn't rely on the
> tracepoint either.


Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
kprobe+kretprobe or kprobe.session, if the extack is not NULL.

> 
> Is there anything I can help with on the new approach?


You are welcome to review the series in the future.

Thanks,
Leon

[...]


