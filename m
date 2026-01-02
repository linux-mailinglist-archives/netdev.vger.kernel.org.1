Return-Path: <netdev+bounces-246602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68157CEEE72
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26EB530213DB
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445C283FE5;
	Fri,  2 Jan 2026 15:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF05281520;
	Fri,  2 Jan 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368703; cv=none; b=O7qWOcO/tP8ge2KPqSG8qj5dZX/Ej9XlK7YaH6P5WoLE1jY9GN/w0dFUTXaB+u0NbpepIESGViVSwh6ubojggxzzE/X+5ct8W4j7imSZM5JlYB4tqtZN66jK/etzD0TJw7UpHraq0isVVS02dl+lQ0QHYyPavrW1IReP7O25ENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368703; c=relaxed/simple;
	bh=ztK/SHX/BiO/oiADAkJXmliB9RQa31ujGybwP7gL+Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFijXCTOz19H/aY/hTM+56sbjC9/k+2xfH4kqHXXQZmQzU5CLhzHcUwY/MpvgXNr3l388kc5ZM4Ak4R/MDFmXntNNh7BPDPyS+m3jhbHpQ+V2KSqnz7Lc7lVVOGMG9jiybBuCHEV3fKSrHBafkB4gmTuInR/DTOZ2twWo+En4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4AEDA13B37C;
	Fri,  2 Jan 2026 15:44:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 00E9120025;
	Fri,  2 Jan 2026 15:44:49 +0000 (UTC)
Date: Fri, 2 Jan 2026 10:45:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>
Subject: Re: [PATCH net-next v2] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260102104504.7f593441@gandalf.local.home>
In-Reply-To: <20260102061718.210248-1-leon.hwang@linux.dev>
References: <20260102061718.210248-1-leon.hwang@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 6hn7egwt7n55e5qq1uq8pupnrtskg47s
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 00E9120025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18q2up05vvFcEPaWY1s1zcEcy9YoKQMHKY=
X-HE-Tag: 1767368689-497005
X-HE-Meta: U2FsdGVkX1/3xGv2dWPVkUaJRSRWD94NNa3kgsh2NaUsb9FqI6uE4uheQrD7Xl5YDGG58WdO2uZ6nIK1zV63evZ2PDR/oJ53baywzVHEWnUFGk4dKSQeZRjAPILFCOKYwkWdZnrLAMSGzbnxhnRZvRaol1D4NIUF5kFuZXQ18mCH8wbLlkZuhTY7oP7aJuiq/9YJufKBu0UL+ovSz4h0KuYtQ+p7jjn4SEo+tS5GKDfpMBQ1JTXjBplJbW3vW2GBRMGq1+VsxrVfXuDLUUnO6s6vesmnAgSVkQi6hcwwCJosa2CrG5EaRM5I9jMu9m+KWGGUeB0BJf+d4dZ1jB1TTXB2KHYsB9nv8tTel1NWSdSkNu0F6SjfhX+3IQsmIuuY

On Fri,  2 Jan 2026 14:17:18 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> diff --git a/include/trace/events/page_pool.h b/include/trace/events/page=
_pool.h
> index 31825ed30032..c34de6a5ae80 100644
> --- a/include/trace/events/page_pool.h
> +++ b/include/trace/events/page_pool.h
> @@ -113,6 +113,30 @@ TRACE_EVENT(page_pool_update_nid,
>  		  __entry->pool, __entry->pool_nid, __entry->new_nid)
>  );
> =20
> +TRACE_EVENT(page_pool_release_stalled,
> +
> +	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
> +
> +	TP_ARGS(pool, inflight, sec),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct page_pool *, pool)
> +		__field(u32,			  id)
> +		__field(int,			  inflight)
> +		__field(int,			  sec)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pool		=3D pool;
> +		__entry->id		=3D pool->user.id;
> +		__entry->inflight	=3D inflight;
> +		__entry->sec		=3D sec;
> +	),
> +
> +	TP_printk("page_pool=3D%p id=3D%d inflight=3D%d sec=3D%d",
> +		  __entry->pool, __entry->id, __entry->inflight, __entry->sec)
> +);
> +
>  #endif /* _TRACE_PAGE_POOL_H */

=46rom a tracing POV, I see nothing wrong with this.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

