Return-Path: <netdev+bounces-274179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2fEzBLzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DA37E119
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91BCB300FFBE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3540369204;
	Wed,  1 Apr 2026 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVZAsx50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9739B951
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061247; cv=none; b=aLFjYJTKbm/78s9yDi02gU+bkhVifXz4hgqlcaAgfVSXOBEAxvUa7NKAugE/KXtKqoGLsi84iI6iA0V//J+hT1p8MAJM4AzFl6Ds7neSxOfUrw9idG1nIdeMHll075EhBnMTrn3HNw+UMsv4UKiJb7WTP07w/7ov9taJbkxBq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061247; c=relaxed/simple;
	bh=+OcjdzbsVS5n2WpHiH5AzE1B2okZQS9quvYX7YODvQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiX1QcmRrDespPkMcMs4g5pbQiIzdtVhiM/8xTf5EbpNH+AbjqN3rN3U3rVJgDsH7TI+UvPUcY1AEWl2/qcobTTRooNFCXgcMrThoUGBR4IKI89G51i4Ea/gT1Ff/YUYyPTAH+6aJD8yVR2ziNBQNfoqsAcLk7nk2JNs/oSII58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVZAsx50; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so9643933eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775061245; x=1775666045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdMpVTZuf6oWX3f0mlEuicX/hJ4K7vnvO6vekEBOAm0=;
        b=bVZAsx50sgRISknFsJkBzeV0zBAw/Td1rUgrckv4kS0tndO45oAUoyNzfq0iBHX56b
         mIRSSOaoVvcM2Xjb1jUm0o34D03dY7xyaRhiXKeBujDJ3C6FaoMMs9S7JQExVOqcBD4E
         sqgTRR8Bih3BuCjEACOhVzJ072pPZHP85/4XcBNSYdCkWtJ57r6OApIIIsukNcSaNeeU
         mN/qjEcNOHCCJAZZcrAuS0Jk/gtTlUhyDWp4VWXv2ySh0XEUJ4NWN1EEbK9fyvG8aJq0
         D6IQ3QWq2U5rqWk0ZpMmG+bNt8OF8lQfz9TxygSC4gcOlXxAOHsl9/teDY6dS8d4Yf3/
         NuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061245; x=1775666045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdMpVTZuf6oWX3f0mlEuicX/hJ4K7vnvO6vekEBOAm0=;
        b=GYiqzNk4BrOmgfHyNMB/D0aKq68TnDODw28CvHPxqDik5UO/JZWIDIaDuyXFyf4G1Z
         tTIA8di4l1q2Bu1kChRnKGFnCy6Id5qLC4mQ7jpHPOac0x12hNLPGsipPb6bz6SZ7US8
         LX7k0xE28D3nrZAJdhPeQQLuuM3EJi/aBG+YEEQMUXX8ZWi+Ig+z36uRtCja2M7g5h+L
         RU9Xm7W0ur9xdMyTA7Zvsmd6wnnvG8Eiw0PtuPT/4SN5w6T7olYBYnfVX1T66Ao110pr
         8Er5T3A+5cCw4YuDd4oxsSnhuRoDc/q2k7KDnXX8JFxBicJhVMd5RPnGv0UcP8qyRKWI
         eRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVApXYflx1Rq3hF7d6APx3l1+zUaJ4PPzvl6lFwa0geESDmYlg8PIZu152OBIWOJzyfkXRLrWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrboniSZYiyjxdiDvgoc9uLGf88iZYQAfP0p5vXuNSJUnBMXh
	Z3G+9tn9ZZZahN0sdB4w9aYEbFOJm+ZOU3zIBRj/jsaO0ZMTKjMPEVc=
X-Gm-Gg: ATEYQzwXirsopLi5t3L3Ig/61ShGTdRRFEVXfj70fesqmSDvGN91zcJEa7sp18AjpYG
	RqIEG2M/WfAn9kNHXvEtCiWRYd7UZ98/eSkpnq2h5d1nWtcqse9E/WA7h3aDQHOstXbq3+7n9zL
	hSNexz2ppKpPg2IDJooEXRuNwvusFPilZmz3s+N/uUaQ4gfeyFwucgv4kaqcGuK6IRqXnNY8o9V
	tg1Kq8eCxvKv5rLKS6DT1i+CjNviMbA92qWyRzTSaT8+5uuB1kupl33fqc2+94IWfYSRahsknvU
	ec6ou5SLlDNPS40wJtD6LgQz0wVZ9JBLPbDWXSes0Dqx5zsBc4lsAVZudcaZK0QJDocLiG8rCGp
	e1U2jPLMBWFTZPY8vOoXaN43GG4fVBod/smf5UtarFGCDuV0rZe4BGcdlUZokruAyZOdGPRXoBH
	jSNplx0b2iJxMFzIieym2ZWe9VetE3MfB1m/JD681socYSg9D2ku+erlsM74q0r9wASTWvq4kg2
	WRttUG7zO81rHt3vsg4mFHiCb6I
X-Received: by 2002:a05:7300:fd13:b0:2c1:161f:ac39 with SMTP id 5a478bee46e88-2c9325b1fddmr2057364eec.26.1775061244975;
        Wed, 01 Apr 2026 09:34:04 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm237887eec.14.2026.04.01.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:34:04 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:34:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, metze@samba.org,
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/4] net: call getsockopt_iter if available
Message-ID: <ac1I_CMr43XTpvHj@mini-arch>
References: <20260401-getsockopt-v2-0-611df6771aff@debian.org>
 <20260401-getsockopt-v2-2-611df6771aff@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-getsockopt-v2-2-611df6771aff@debian.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274179-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C24DA37E119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01, Breno Leitao wrote:
> Update do_sock_getsockopt() to use the new getsockopt_iter callback
> when available. Add do_sock_getsockopt_iter() helper that:
> 
> 1. Reads optlen from user/kernel space
> 2. Initializes a sockopt_t with the appropriate iov_iter (kvec for
>    kernel, ubuf for user buffers) and sets opt.optlen
> 3. Calls the protocol's getsockopt_iter callback
> 4. Writes opt.optlen back to user/kernel space
> 
> The optlen is always written back, even on failure. Some protocols
> (e.g. CAN raw) return -ERANGE and set optlen to the required buffer
> size so userspace knows how much to allocate.
> 
> The callback is responsible for setting opt.optlen to indicate the
> returned data size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/socket.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index ade2ff5845a0..4a74a4aa1bb4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -77,6 +77,7 @@
>  #include <linux/mount.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/security.h>
> +#include <linux/uio.h>
>  #include <linux/syscalls.h>
>  #include <linux/compat.h>
>  #include <linux/kmod.h>
> @@ -2349,6 +2350,44 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
>  INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>  							 int optname));
>  
> +static int do_sock_getsockopt_iter(struct socket *sock,
> +				   const struct proto_ops *ops, int level,
> +				   int optname, sockptr_t optval,
> +				   sockptr_t optlen)

If we want to eventually remove sockptr_t, why not make this new handler
work with iov_iters from the beginning? The callers can have some new temporary
sockptr_to_iter() or something?

> +{
> +	struct kvec kvec;
> +	sockopt_t opt;
> +	int koptlen;
> +	int err;
> +
> +	if (copy_from_sockptr(&koptlen, optlen, sizeof(int)))
> +		return -EFAULT;
> +
> +	if (optval.is_kernel) {
> +		kvec.iov_base = optval.kernel;
> +		kvec.iov_len = koptlen;
> +		iov_iter_kvec(&opt.iter, ITER_DEST, &kvec, 1, koptlen);
> +	} else {
> +		iov_iter_ubuf(&opt.iter, ITER_DEST, optval.user, koptlen);
> +	}
> +	opt.optlen = koptlen;
> +
> +	/* iter is initialized as ITER_DEST. Callbacks that need to read
> +	 * from optval (e.g. PACKET_HDRLEN) must flip data_source to
> +	 * ITER_SOURCE, then restore ITER_DEST before writing back.
> +	 */

Have you considered creating two iters? opt.iter_in and opt.iter_out.
That way you don't have to flip the source back and forth in the
handlers.

