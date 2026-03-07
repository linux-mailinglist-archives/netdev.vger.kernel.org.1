Return-Path: <netdev+bounces-265041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBZnL92bq2kJewEAu9opvQ
	(envelope-from <netdev+bounces-265041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:30:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838E229EBE
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAF23047538
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB2253340;
	Sat,  7 Mar 2026 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEXcuYIj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483330F529
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854206; cv=pass; b=NgatH7jnltdt206B0KJS5a/RR4q9jX5Z/GPfU9n7hp5n4OkB0CCqCzDr6qbksVRv30l4+XtQ/nQddI2fzOuRWARQqcaNCBhdm2XZYnZ/OpRebjeVgEbabObGI/3HfMMl4zNHKSNS5+kSHyUNjHh522dxID9izZtHmAQUYu49Clg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854206; c=relaxed/simple;
	bh=dvoJq25OvpD/Xk60DBZSv4vLrYpQuuw6VA1VafjxT34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfzqrrGy98kxVK+UnruzJkgz5xA0BEvI8PnLOKUDzkd5PQ/4N4d3T8UY1+nBNQEukyyrf2VQ2MxWsEU5dzXN0EsOHZaXBwxk6APUc2G3tpreB8s0foTX4d9A3JOQMWHkRuXHjAdzBVWQw1J57QPihptmWH8tahUWAnIqU5hlrjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEXcuYIj; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506989e8516so84096851cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 19:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772854204; cv=none;
        d=google.com; s=arc-20240605;
        b=FhDoRMafF33j5nZtibMCjVgd3HWPvqZXrauAha01kdJCei1KH6vCvdy6VYcx6W7GWg
         YGxGNzNucPz8tHAUfHd2I9ydD52W8dS3NQLKcXNd4LVYMVD2yH6UHxGZWb74kB/Qy4km
         gfMyRE7JnKkHb8LuQw/O07kyHyY/D7J/8ygPkZNV6nK3MZ8qy//cc314CLJ5rqjY0Mhp
         It+tEjWKGGWDnFswLfQWlfGRD5kK20lzsL7pG3XmA2NjYZBCdQdmnsNqNs9aPTmTJLbN
         3sonHuAVwQkwRgoDEe5zQZCnQ+tOSaU2NZIUze7LUgSF8a6KCm7JhNzkYY+yHcEyhvr+
         UIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        fh=cJSJo/HyTgq1PrPGPz+pCct0Wn2goWMAjAsAYm+P1pM=;
        b=YYUdbe4Q2KWuvq8CJr9Cfs6/ZEAUXmu4EW/gESQAIAoK4aOxV+XQ0o08RZkINsjBET
         Na8gA++GN7kntFjAxAka18slkTI08te1jPTQuKBhIA0rKNtvAE4UOyNvNX8Nfv9K7LZw
         yDrbagk9/4J/g41edu3FosRmgj9QCu4IclXv4V/GrkA5tmOjsL7yQxpb0FD4Rax8UL5a
         cZB5qwQRmqNoj0j3H/u5pe4c9D7BpqQt6R1GnqPhtIpZDbjn3V2+1tubpZ2MJpuwIwab
         CQg4DAbv71koRns6SbUB/g3pX/LlfJsi/XtR87D/+Wck0mk0N1ZNmGT8ToFP8l2PvnKO
         o9tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772854204; x=1773459004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        b=oEXcuYIjPsQRRMvWi0u8aQ4DPSWQihS70VnJ8w0N+fSyOUNZuI/Rq0KOZ6qagTkTrl
         RBiQWuKAmNze1si9XO/f0wZxhyNjf5cQr6db+h3ECma8xDJp3Zp0cHDxhRNRBARO3FyV
         rq4mys1SlHSHGM6pI+AYdSpUcuAJZS+6jYOhaXiKbjf7HLOfWVlSactBBcYw0Z4CSfqA
         48cx+r9PZTKXMnF0G6AjCC8taRmEGthIVFolQZkaqOzPNShzoiH2s5OTmqKxu3KrEiXT
         iwX4s9y7UXSgD9RQx7OP+Q9BPs/p09dZJkOorPTn0pFibYv4hBwSdrD4qjixe5AgQWuc
         nddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854204; x=1773459004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        b=twwSwFVQrs1ak6LsKr7z2OvHgOpc3BrdU409Xr7fcDbICdEX1QKwGdKiC4lQ8jwj+/
         APG5QxAt6lyYtmScrSY+mfbXb0eCwsxqxTkGS6v7+5gqL/FU2ECl2KIMSjLuhnN0VQEv
         cNbGHBGNFE47tN0BQ1n5utDAM6xKLSV6+41YITLtHKsJZsW0LqLXCOj3KEqAkQ+yq0tL
         j56EghWicQI/VhkVF4zR+tgnWiAncBCM21Uw5q+ecPJ93iFUq/i9fxv4c5J5T0enhwYF
         XkCda1ioljESwCnzRX5OeTCgVo/bxZRCxaHhxkbGB3wviIhKlGPL5Ib4n7IVzA8vCy3n
         7Glw==
X-Forwarded-Encrypted: i=1; AJvYcCXrsOaj6hJZLJMzgJNWWQUszFpFSmAa9sxLkB5fFB7ycws9kqPMz3U2aAprcuUfYOVUWeLvDCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgUdrecPYbMf5pMrDQkEosw1T+yNv700HKhkRMcytLL9yuCYf
	CFq0zt1kKawRKe8b3+GI6pkUi6nHdNc8JtuI/pS85dxtjvDpsRp/Mz0wTj3Tvydv9YCD7VIHrEK
	Xvwez+iBj9XX8Uy2CEeLp8Mjn2lbacz0Bx3715n7l
X-Gm-Gg: ATEYQzx5futQozv11H2YOsFKWaMjuBqEMGNJR8+5ij4SQGW32bkdQmAT5nUIPem6jMH
	Oj8bB5ccc6rogABDZZiYTe5lm5Qtk07uUJ+PkUjbobCwkS5jt0deZ3/M3A8P6IVptLD0sGda4rJ
	TL8m1AffyB/4o33/FdzSNOMV70Sa3LFPKq74q6SxfBQyh/3/3kyIkh8pNsDKCorUnAnenO+ep5z
	z03U3w4gtSquze1w8SwgjkDU3tTBtbjxKsdHLh6WEhguUuoTHQFaFDYOKQVDaJ8OxHuo0U1eeq8
	Mew14xaKCxaaULcQPlE=
X-Received: by 2002:ac8:7f47:0:b0:506:a43d:778f with SMTP id
 d75a77b69052e-508f4908ed0mr56284151cf.34.1772854203826; Fri, 06 Mar 2026
 19:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306185005.22120-1-mehulrao@gmail.com>
In-Reply-To: <20260306185005.22120-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:29:52 +0100
X-Gm-Features: AaiRm52j54ex_mqVI2RoTx84B4nBaTH85pbob3IqxXcFMgge_tbsq8gKtlrBBik
Message-ID: <CANn89iJA_rchh5mhRpLVgt8hN1q1NKA4WZ9OaixLngJZSCmOjg@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: fix divide-by-zero in tipc_sk_filter_connect()
To: Mehul Rao <mehulrao@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ying.xue@windriver.com, tung.q.nguyen@dektech.com.au, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2838E229EBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 7:50=E2=80=AFPM Mehul Rao <mehulrao@gmail.com> wrote=
:
>
> A user can set conn_timeout to any value via
> setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
> SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
> tipc_sk_filter_connect() executes:
>
>     delay %=3D (tsk->conn_timeout / 4);
>
> If conn_timeout is in the range [0, 3], the integer division yields 0,
> and the modulo operation triggers a divide-by-zero exception, causing a
> kernel oops/panic.
>
> Fix this by clamping conn_timeout to a minimum of 4 at the point of use
> in tipc_sk_filter_connect().
>

Could you please add symbols to the following trace, using
scripts/decode_stacktrace.sh ?

Thanks.

> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
> RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
> Call Trace:
>  tipc_sk_backlog_rcv+0xe4/0x1d0
>  __release_sock+0x1ef/0x2a0
>  release_sock+0x55/0x190
>  tipc_connect+0x140/0x510
>  __sys_connect+0x1bb/0x2e0
>
> Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>
> ---
> Changes in v2:
> - Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
>   instead of rejecting small values in tipc_setsockopt()
> - Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-mehu=
lrao@gmail.com/
> ---
>  net/tipc/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 4c618c2b871d..9329919fb07f 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock=
 *tsk, struct sk_buff *skb,
>                 if (skb_queue_empty(&sk->sk_write_queue))
>                         break;
>                 get_random_bytes(&delay, 2);
> +               if (tsk->conn_timeout < 4)
> +                       tsk->conn_timeout =3D 4;
>                 delay %=3D (tsk->conn_timeout / 4);
>                 delay =3D msecs_to_jiffies(delay + 100);
>                 sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
> --
> 2.53.0
>

