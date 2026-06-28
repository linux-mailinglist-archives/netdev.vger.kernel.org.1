Return-Path: <netdev+bounces-302400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 34wZDTM9QWrOmgkAu9opvQ
	(envelope-from <netdev+bounces-302400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C796D449D
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:26:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=EuRa5dRq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302400-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAB2C3002D19
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC6352007;
	Sun, 28 Jun 2026 15:26:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AA5A79B
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 15:26:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782660395; cv=none; b=CXf81Uea8Sr3xn1WcuDw7p+WUBKTXLDVfO1SVue2363Eo4a7QIbcpIU23hnoZgi6BIXZ0W4N2TtdFYroFe1L/pJXIerD695du7Y4Uf2a7q+x7pGly9eOQHsdZNBe7hIie3Yp/wZFtl/a6xoR7OcQKs3qZBpHlgi/mMhen8ftFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782660395; c=relaxed/simple;
	bh=WBai87XxH2KfdCNpP6IHXulByZKLLRxdxBssMrSpXNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyZzfkXsh38FHfmqOZho1096MXLv1nmcQk824o8uSXQKudOJgVank72OCyvdreB/f+2yo36IXG5HpQx7OZOnEwPPbUFHYrsDWxUgdKXpxIDRLnrrtfpmt3PKK4DR9n/AOd6yDaHSVjZR4YTrai3w7DKvU5wUg+1lb593nojsAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EuRa5dRq; arc=none smtp.client-ip=95.215.58.186
Message-ID: <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782660391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeK+Cvyg2fOloDs+N1O69MAGfndJD1u5V/csmGaI8cE=;
	b=EuRa5dRqExJZ5UWWWpG3KNz3LC4YymuAcLyPVwXcWvk6v+WIf0+qUlzYOcpbQcRpg1o2b0
	uoZGboFK/NySptMEb4a+oiOJmd6P6J4NAq6AS/bYavpSS9HwDAi3pMtEX/sGfM3Dq2hf6i
	NuUNlLXayuDoGU9fV1dhH08a3DkUZjQ=
Date: Sun, 28 Jun 2026 23:26:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed
 tracepoint
To: Masashi Honma <masashi.honma@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, kuba@kernel.org, hawk@kernel.org,
 andrii@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:masashi.honma@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:masashihonma@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3C796D449D

On 2026/6/28 19:39, Masashi Honma wrote:
> Hello, I am re-posting this mail because I forget to add [RFC].
> 
> The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
> "xdp: Add tracepoint for xdp attaching failure") exposes the netlink
> extack message produced when attaching an XDP program via BPF_LINK_CREATE
> fails. This is useful because, unlike the netlink attach path, the

I really appreciate that the XDP tracepoint helped someone.

> bpf_link attach path does not return the extack to userspace -- the caller
> only gets an errno (e.g. EINVAL/ERANGE).
> 
> We would like to use this in Cilium [1][2]: when attaching the XDP
> datapath program fails, surface the kernel's reason (e.g. "single-buffer
> XDP requires MTU less than ...") in the agent logs instead of an opaque
> errno, so operators don't have to inspect dmesg on the host.
> 
> The limitation we hit is that the tracepoint only carries the message
> string, so a consumer cannot tell which device a failure belongs to.
> This matters for two reasons:
> 
>   1. Correlation: with only the message, a consumer cannot reliably
>       attribute a failure to a specific attach, particularly if multiple
>       XDP attaches happen concurrently.
>   2. Scoping: a consumer watching this tracepoint sees XDP attach
>       failures system-wide and cannot limit them to the devices it
>       manages.
> 
> At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_device
> is in scope, so exposing it looks straightforward:
> 
>   TRACE_EVENT(bpf_xdp_link_attach_failed,
>       TP_PROTO(const char *msg, const struct net_device *dev),
>       TP_ARGS(msg, dev),
>       TP_STRUCT__entry(
>           __string(msg, msg)
>           __field(int, ifindex)
>       ),
>       TP_fast_assign(
>           __assign_str(msg);
>           __entry->ifindex = dev->ifindex;
>       ),
>       TP_printk("ifindex=%d errmsg=%s", __entry->ifindex, __get_str(msg))
>   );
> 
>   - trace_bpf_xdp_link_attach_failed(extack._msg);
>   + trace_bpf_xdp_link_attach_failed(extack._msg, dev);
> 
> Before sending a formal patch I'd appreciate guidance on a few points:
> 
>   - Should the tracepoint take const struct net_device *dev (consistent
>     with the other tracepoints in this file, and lets TP_printk show the
>     device), or just the ifindex as an int (simpler for raw_tp BPF
>     consumers, which otherwise read dev->ifindex via CO-RE)?
> 
>   - For raw_tp consumers the argument order is effectively ABI: prepending
>     dev would shift the existing msg argument. I've appended dev above to
>     keep msg at args[0]. Is preserving the existing argument position the
>     right call, or is reordering acceptable given how new and rarely
>     consumed this tracepoint is?
> 

Good concerns. I'm not sure about these parts.

>   - Is extending the existing tracepoint preferred, or would you rather
>     keep it as-is and expose the device context some other way?
> 

I'm planning to retire this tracepoint. But I think I cannot do it, if
there's user space application relied on the tracepoint.

I'm planning to add BPF syscall common attributes support for
BPF_LINK_CREATE, including XDP link. By that way, the kernel will be
able to back-propagate the 'extack._msg' to user space, when fail to
create XDP link. Thereafter, the user space library will be able to get
the error message alongside the errno.

Thanks,
Leon

> This would be my first XDP/BPF tracepoint change, so any direction is
> welcome. I'm happy to send a proper patch once the shape is agreed.
> 
> Regards,
> Masashi Honma
> 
> [1] https://github.com/cilium/cilium/issues/40777
> [2] https://github.com/cilium/cilium/pull/46546


