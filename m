Return-Path: <netdev+bounces-251705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEMWF743cGmWXAAAu9opvQ
	(envelope-from <netdev+bounces-251705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:19:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E94FA6D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80450ACFD34
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75563191B8;
	Wed, 21 Jan 2026 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LRlzRqs9"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85929D294;
	Wed, 21 Jan 2026 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961920; cv=none; b=QSJzoW88jLZLmZ0nootaFEP4+YFDujOgL10YzPPNRKIX/Plf463dNP8ijqfkERES6WerI8GNUkiqaGYivYQIUPrdZsvEogAvnjsbJe3F3iX7+kSwMQNP1V+iGnC1xHRVYddHXGj0BSNoBNI6WnFTXEBafGvmfCLHI59XUcOPeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961920; c=relaxed/simple;
	bh=07BX9o9SLO8HRKhiwp4zA6ivI1oU39geghZ9J038ynA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxfK00rpVVVnGFKMv9ZTflXAMkVA2/F2idlSRvNCuCUO5fsfA0BWy8/39szZBf3aYdLsyK1lmq8qujT5BrHVKj5vZdlJtQfDxY7T8iczuJkikmdnAnkDFGn4eOYKchaJQb5lTRl766Gsa37hnZC0tQCTEK63lye9+OIdwpjbLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LRlzRqs9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15c40e1a-4207-4de5-9a22-e991368310f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768961903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0tTgYPrUXivE1Yi64PmDgTM3l1/blEcZfIr3XsO4Uw=;
	b=LRlzRqs9TxNHAGW1cxDa9+/9+EKL128TawyeRb/XFbxVZ7s3z3Gm4VQv6CGAFWYvX0fmHi
	9iG0s0xa04LJhHEFeIU9AmBGPxLCvjNxQVcpJYH1I/OoUc5dc3M1TZytbJEa2/26xfBi0l
	iViy/Gwf7GivIjvuh6SfoMgGUlxMXQc=
Date: Wed, 21 Jan 2026 10:17:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] page_pool: Add page_pool_release_stalled
 tracepoint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
 <20260119083759.5deeaa3c@kernel.org>
 <b676baa0-2044-4a74-900d-f471620f2896@linux.dev>
 <20260120152934.2eb16a11@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260120152934.2eb16a11@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linaro.org,goodmis.org,efficios.com,davemloft.net,google.com,redhat.com,gmail.com,linux.dev,shopee.com];
	TAGGED_FROM(0.00)[bounces-251705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 697E94FA6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/1/26 07:29, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 11:16:20 +0800 Leon Hwang wrote:
>> I encountered the 'pr_warn()' messages during Mellanox NIC flapping on a
>> system using the 'mlx5_core' driver (kernel 6.6). The root cause turned
>> out to be an application-level issue: the IBM/sarama “Client SeekBroker
>> Connection Leak” [1].
> 
> The scenario you are describing matches the situations we run into 
> at Meta. With the upstream kernel you can find that the pages are
> leaking based on stats, and if you care use drgn to locate them
> (in the recv queue).
> 

Thanks, that makes sense.

drgn indeed sounds helpful for locating the pages once it is confirmed
that the inflight pages are being held by the socket receive queue.

Before reaching that point, however, it was quite difficult to pinpoint
where those inflight pages were stuck. I was wondering whether there is
any other handy tool or method to help locate them earlier.

> The 6.6 kernel did not have page pool stats. I feel quite odd about
> adding more uAPI because someone is running a 2+ years old kernel 
> and doesn't have access to the already existing facilities.

After checking the code again, I realized that the 6.6 kernel does
have page pool stats support.

Unfortunately, CONFIG_PAGE_POOL_STATS was not enabled in our Shopee
deployment, which is why those facilities were not available to us.

In any case, I understand your concern. I won’t pursue adding this
tracepoint further if it’s not something you’d like to see upstream.

Thanks,
Leon


