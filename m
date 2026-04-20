Return-Path: <netdev+bounces-279719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MJJALkN5mkGrAEAu9opvQ
	(envelope-from <netdev+bounces-279719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:27:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C98429EA2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0FCB300E03F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDB346FA6;
	Mon, 20 Apr 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNrR7gOj"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403C19C54E;
	Mon, 20 Apr 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684468; cv=none; b=BU74M2v7NjoqC8C+orDXjeO58a4RF4U4aoCUimPIalhxD2ml+7SH5v9LNva0JGKax/lbrzlr/LIoZLMjDeq+f31ib3FDFWSe9D3ZAe3Yjd4IWjR+s9uLNfidsKUv6O3uKzwAkMsYE2UJJtCpFxS3oIi8o0zmMkqhj230ihJi44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684468; c=relaxed/simple;
	bh=lcuhLiK78fnxGY3DsHsyrjbNY2/wp+/JiF3BASxfRPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzRpkcpNtlgqS0xIcf9jxpEMLwWoRCai2e4bCQkYkXqiu65oyD32L5uoErmsY2fkOvtynjSBAraas+qsBU6XfDfXEEsumavNtNWKEPSv2QBvdpSOqqm9+KY+HilVZSKO1pDFUPZ5DocLbZUiNdL/mYWNUgzoSIdzsRT7IsfFLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNrR7gOj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776684462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FmNftTmL2q6GdFEvWpth7ujw9QbRkrMDpo5qvEDDvQ=;
	b=MNrR7gOj5MqmSHqSUcTnOT6xTypK/4X418TSV2T6ZdN0Egh3Jpy12vF7Dzv48x0MXpNSi9
	nk4VPQUq7HdR6WM7zw+L2yenHqNKxkLOMlf41LZUzlNJsnSzpLax2eF5lj1Wj6vSE+anXT
	xXqdM7Vw/sOocj99V197a/KmexXKAjU=
Date: Mon, 20 Apr 2026 19:27:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20260420105427.162816-1-kohei@enjuk.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260420105427.162816-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 93C98429EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/20/26 6:54 PM, Kohei Enju wrote:
> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
> skb->napi_id shares storage with sender_cpu. RX tracepoints using
> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
> report sender_cpu values as if they were NAPI IDs.
>
> For example, on the loopback path this can report 1 as napi_id, where 1
So I think veth_forward_skb->__netif_rx could be affected as well?
> comes from raw_smp_processor_id() + 1 in the XPS path:
>
>    # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
>    # taskset -c 0 ping -c 1 ::1
>
> Report only valid NAPI IDs in these tracepoints and use 0 otherwise.
>
> Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   include/trace/events/net.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index fdd9ad474ce3..dbc2c5598e35 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -10,6 +10,7 @@
>   #include <linux/if_vlan.h>
>   #include <linux/ip.h>
>   #include <linux/tracepoint.h>
> +#include <net/busy_poll.h>
>   
>   TRACE_EVENT(net_dev_start_xmit,
>   
> @@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>   	TP_fast_assign(
>   		__assign_str(name);
>   #ifdef CONFIG_NET_RX_BUSY_POLL
> -		__entry->napi_id = skb->napi_id;
> +		__entry->napi_id = napi_id_valid(skb->napi_id) ?
> +				   skb->napi_id : 0;
>   #else
>   		__entry->napi_id = 0;
>   #endif

