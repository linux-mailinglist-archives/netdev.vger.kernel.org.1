Return-Path: <netdev+bounces-304784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3fFKjtnSmoCCgEAu9opvQ
	(envelope-from <netdev+bounces-304784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86F70A456
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CKtiTnIs;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304784-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F04093019C9B
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34549381AFE;
	Sun,  5 Jul 2026 14:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B223815F1
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 14:16:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260985; cv=none; b=PjH8rZxLjqcEjM6ze/Jh9On1nCPmlw/22Z3uF8WBXsbK932hkVkLlGnjW5GBY+WpFf6760PL4LL6w+oQcoJVnPMmcOFJxx6MFGda2isZgbEz0e/lAGSlH39HKDQvcR2W3ISEZ75VI7eET9wMNfrJpSGsUVgn4Pr7TmNir9amcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260985; c=relaxed/simple;
	bh=haTkynxAOqe/YfGduuTTUWMreuoLlTQ2Qu07vsVgaVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfXpvwMok27faF2JImRZd60m8a6FMCeHzb7nrZNEVZYjAoMLkw450zukXGNcWjZuZo7ef278Hx8OHJfAS8I6TEMAFuHd4BmMLB6oiSe1JVG1LUCOZ6Fjs5XLqjjfOmR1/i5l37b9FoNd7l7U73qav/POgz5rYxLr/hMneHBTc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKtiTnIs; arc=none smtp.client-ip=95.215.58.183
Message-ID: <4e1ac57e-a127-4c43-a719-08b9d99cade6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783260971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLkErmE5LgOSLdN9cPaDzpscqqSBslDD7mRQkdPcKZg=;
	b=CKtiTnIsNMbFTCC/IwVzzLgel+PWyMryRne98J8WBkLGvzY3mugyFz2NFqwOz1cQf4no0y
	y0KuQRSVTvuJYAYcScwRqG290A8n8NJydayFdTT0YM9Wayi5CWBEXARWygcsKr0NNN+O8a
	YOmyeI4qN5BLqKpKl0WyLrZ4tT8ptTk=
Date: Sun, 5 Jul 2026 22:15:51 +0800
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
 <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
 <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:masashi.honma@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:masashihonma@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC86F70A456

On 2026/7/5 10:11, Masashi Honma wrote:
> 2026年7月4日(土) 22:28 Leon Hwang <leon.hwang@linux.dev>:
>> Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
>> kprobe+kretprobe or kprobe.session, if the extack is not NULL.
> 
> Thanks, that's a nice pointer -- dev_xdp_attach() has both the net_device
> (so the ifindex, which lets us correlate a failure to a specific attach)
> and the extack, and it avoids depending on the tracepoint you want to
> retire.
> 
> The tradeoff is that dev_xdp_attach() is a static internal function, so a
> probe on it can break across kernels (inlining/signature changes). For a
> best-effort error message that's tolerable with a graceful fallback, but
> it's a maintenance cost on our side.
> 
> Since this is ultimately just an error-message improvement, and your
> in-band BPF_LINK_CREATE work would solve it cleanly for all link types, I
> think we'd lean toward waiting for that rather than adding an internal
> kprobe to Cilium. Do you have a rough timeline for the BPF_LINK_CREATE
> series? That would help us decide whether a stopgap is worth it.


I will post the RFC around October.

Thanks,
Leon


