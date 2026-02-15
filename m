Return-Path: <netdev+bounces-258756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tf4OEg5GkWn2gwEAu9opvQ
	(envelope-from <netdev+bounces-258756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 05:05:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E413DF99
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 05:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5D53017039
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172451FCFEF;
	Sun, 15 Feb 2026 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcuetH33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AF12B143
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771128331; cv=none; b=ik6w6UTzPCuwduUJj+0KhyZrviOig6QApHZcNP6/wXJ/tHcpf5Q56WiQiJEgTvlg6S5Y244s07jV4t72VRwZ0ZcYwYEsYpcW3309k4CXBKyV8DarxvcrxLdkBA4lvlirlUqgSc/Ol5hzwxB9QUBxf1kfsv+h3v0eFLugYsNf7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771128331; c=relaxed/simple;
	bh=5MJcd4AMnnfPIA5d65g/k4Cloi8UbxIScz/7Y92TdPM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NzqlIcEXtRFCsKl6LnjKIqbeRnK7Bi7/9aet2LY5MUU0fPDe7TdoowKOZkCZiG9q1w4hjvFSK/OQYxN6Z59oWTqzos5VsZKJRlaR05MSWSQ6TRQRe8bkYGisnY5CxtGWC6f/eBTNJ6Gv6L89YroaUedIYcO4OeJqL7VSQpf32ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcuetH33; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64937edbc9eso1828107d50.2
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 20:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771128329; x=1771733129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQYZWDPndMRhuW8jxsLPE/AQFL26Ec+jDmgiM1CQOsc=;
        b=VcuetH33L4WA1dn9nEAdEGkBO44BLRHtTEI2axEkThih5p6JbxBHSTazDHpE/d+Ag0
         y/DNo1pbJVeYDtK4Pi8tRteM0w+N5zigyJZTQtOMm/6fxAGCg86sR9rsoV/CwfrUnd34
         OvWtTVWDlnc6snS2bdl0Eg13ww9cfo7DBBukkCx5rAwiyNW4Amm4/RmCnxXUIV1pvGRT
         EnrbkMRGz2a4uD9MpOJT7F2l6IzWvCWsuHu4X8ITDPvrak39E4i+Ts+PjNR0OjG1XQf0
         4OolG+di8xryK0S9+TBwLYrlGZ57IEBUdrwLko4Zg1dVsPrJiPY5ejsYXNBftJfAGQaF
         Nv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771128329; x=1771733129;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQYZWDPndMRhuW8jxsLPE/AQFL26Ec+jDmgiM1CQOsc=;
        b=oIrRfl14dLsDP3nEpctUgMqHe1mvCdsLqSdINp1z2sXvXgGtkhim117hg3mZ3VPP9T
         RhqhMrlArWQZ49pTrmluJVzan79FWg8DYLa/tdbjhOx0b4pSLIXZdlJzs5EUu8YANPCg
         1d4n9HVveIWqpmqtnODmeH3SsAkkx/l0K0hq7t7ZQc+HXn6/4w/A7XEZ9wHXpdFKh2R7
         pJmyVShOhgxx7KVJnbD86mUeKadp8RcVKtUl2CQwmqMebFXD6H9L0EEwpH6qJGqFxxW2
         9RBENVu8taWm4rxiQhGOdCGTLbWiiBILygujEw+DxW4xBh6D+ToUt4icwnWPQ3z4uCgv
         i7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUDtoHVCRyOxqr2LqQnx7JAvksYCUK+GVZEEXwEJEWQoIxnRFZ3N88ApFPQtI2pXZPN91B+r6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsDpRPTdn9DfQYwxPsT0v5kGYEPjeTQSFhPqMGX1iDE/csAqa
	IoJlomG2oyI3tLIX/fupCb+I9r4akJUF5Ofafo2HPAwy4DUyeMhJYPnW
X-Gm-Gg: AZuq6aIPIXsm1RDY/Y8L3BheEJvfjeM0gaHryhF76tEItE3Z8wVlxnqod3Zmby+J9rJ
	JD4MM9SZivqiQBbjQydP+Jwl9bZ0EoghTAdQMyYkNm1/7SF1YZIAGRvsrH3yIZQ2OPr/2CM/ER0
	4s8o+6tDQAaw6b4tLbJQiG0uDnw78AC+zHOLfye5B7ot8DDXkn1PQ58NZVkVST+KCV+acfjS2I1
	xyegficf6BQ1ABcoKAabtxv4xvM+Y//29v2ymZ6VtLHbjYQlhAGgMoCHbnRnREQqJ61Bf0aR61w
	ISg/7+4GKWQpSNBfO6FwY7dFiVPnWv4VCcoEFjxXCTGHqfyDewmOZmJHRJAZkTNyC7NanEjuIKL
	iAXzcP58Y12X7dP6i8g2qwrV3dxw5Yzqtxn9/wExH2OG6Z+djCY3rJnNvHz07u9GJxcNIWfmC2P
	kspRyTaYLv9M/x5Bm0so1hRZXTdHkbpjfr2mbcLOj9TDmzhOSChncmtl1y2ObGfk7hR6+F3To=
X-Received: by 2002:a05:690e:1403:b0:64a:f160:2376 with SMTP id 956f58d0204a3-64c21a99a27mr3399843d50.30.1771128328695;
        Sat, 14 Feb 2026 20:05:28 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64c22fb1d2fsm1915122d50.18.2026.02.14.20.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 20:05:27 -0800 (PST)
Date: Sat, 14 Feb 2026 23:05:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1682a93525c87@gmail.com>
In-Reply-To: <20260214232456.A37oV4KQ@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258756-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 929E413DF99
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
> 
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed and the IRQ and
> softirq handler qualify as a RCU-read section.
> 
> Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/skbuff.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 61746c2b95f63..a174010e334a1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
>  
>  static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
>  {
> -	bool ret;
> +	struct socket *sock;
> +	struct file *file;
>  
>  	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
>  		return true;
>  
> -	read_lock_bh(&sk->sk_callback_lock);
> -	ret = sk->sk_socket && sk->sk_socket->file &&
> -	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
> -	read_unlock_bh(&sk->sk_callback_lock);
> -	return ret;
> +	/* The sk pointer remains valid as long as the skb is. The sk_socket and
> +	 * file pointer may become NULL if the socket is closed. Both structures
> +	 * (including file->cred) are RCU freed which means they can be accessed
> +	 * within a RCU read section.

The fields are not __rcu annotated. Is this common knowledge or is
there clear documentation of this behavior? Not disputing it, just not
familiar with the rules around these fields.

It does seem that updates to sk_socket, in sock_orphan and
sock_graft, are protected by sk_callback_lock.
> +	 */
> +	lockdep_assert_in_rcu_reader();

This function can be called from process context outside an RCU read
side section, I think.

Such as a packet socket sending and hitting the __skb_tstamp_tx
SCM_TSTAMP_SCHED at the top of __dev_queue_xmit.

> +	sock = READ_ONCE(sk->sk_socket);
> +	if (!sock)
> +		return false;
> +	file = READ_ONCE(sock->file);
> +	if (!file)
> +		return false;
> +	return file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
>  }
>  
>  void skb_complete_tx_timestamp(struct sk_buff *skb,
> -- 
> 2.51.0
> 



