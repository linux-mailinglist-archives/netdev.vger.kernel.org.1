Return-Path: <netdev+bounces-304299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jTtUN9T5RmqSgAsAu9opvQ
	(envelope-from <netdev+bounces-304299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5E6FD826
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rXVeCXla;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304299-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3763046FC6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDE3D6479;
	Thu,  2 Jul 2026 23:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D53314D0D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:52:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036342; cv=pass; b=ZwnQuG1TsKef9/0H7RBPbwR/gl62q+zqilpRkXXsvpXkusc891wEW0J5JIKoJuJ7KpF8J34hZy14cV4+46vjgOBUK1pQhhup1HPjHdRjMe3S0PKEe0+qipSGLWEO4UT/Lt5hfeAR3CxFESyd5dHdUnMhb7Dr0mYD9XiGeNbEWHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036342; c=relaxed/simple;
	bh=qNOpQc3QGpcRBtaplnIR5dpn4gdaxEI2XoJtH5vsL2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5ldxRL9NupAMKjv6EjcrtTpl5Tynf4wtRIzu1JD70iYzqxovuLXSOPm6NAARbTqgYIMBDPAcPXJz3Tr8x2Z+ZftUwynI/a23n2vX6hzowKPQUY8e/Jtr+g1SUUkcroLbNgGfpUpXUp8EqJZBxo3gJFB022oq17pR/w6PBRO8RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXVeCXla; arc=pass smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1269e4721aso300509866b.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783036339; cv=none;
        d=google.com; s=arc-20260327;
        b=SSt+kNcDZskoIGwOoGEA4A/cU/RIwLFFxqcVbBepUPbNceS2pH/cuj4GZXBXloUWQI
         LWJOZ+mSa9FdkpMYrOogiG7LnHQdEBQEDrEBqxGTmUWOUxexVrfx0DpmgkoMXmMjib3F
         pdoBrfthXW9XOqkv8WmDC0Vk+cJ3nHtYsDxIwWR3OSfhhhfCa7X4QYqxVKRHDijg6MyM
         TJMtZ6B38C7NfmUrYT2QqDDf06OYUyMba2eBHfRLsHkTpy9AP2PtV1Gb36gC2zFX39mF
         ObA+e1oQRcpaUQJQ9G8at98So8mnExGKILNnV74WGQMJB1MlD9ZoYzjuTcPIAE7nE0iU
         BTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y8mXmJX+ZzpCqp/w7JpCSA6Qcw3BFMeXA6EyptAd3DY=;
        fh=jfDdDFVE8k3yuIrxlC12hamEzlLbfAQWBk595SSFbEo=;
        b=Zat+qce2MT0ivw+PhWxSO6bKO+HYvd/nbdHuADoR0R2YoM7g3i5TGsldo2jvVzpMkV
         NtRmB7bA8xYD2TAeYLE4ueD0i+JyD6PtL7FuNGfh23Dog/MEa4fW1xhzWCw9kMWzWhHl
         8xwfFyqS4GffMCMI2mUaQBpY+1LnvY6tEu2LU0BAXRVxi0HF/XoVkbrJmL/DZspd9eIR
         +OJNB5kGuRLVD5yrhk5Yfshl57mu5EjC3u/uggXiThqwY/iizxUOO0mh2Wb3BzO+F7iC
         70InmU+WxB/2KaqfLOGAEf9akhoFQvHp+/tuNmacoyqkaD5cIdPqc5Zo+i8gvjc02djW
         JgyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036339; x=1783641139; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8mXmJX+ZzpCqp/w7JpCSA6Qcw3BFMeXA6EyptAd3DY=;
        b=rXVeCXlaXvzeehfN8XsGNx6qeCwkpqZ3WUBwUPcoSNgfUTbbiqicVSvRMhhx7CwLcE
         /Htn/dQI1U6OFgp2sFttfXPaWx4Y9g9sOOqiXwLIOm5GA2XAs0Z206zdyKH6+7p1dwI0
         TKqZCohJbV+ave1MRqfuABcWLrpn946AQNWgmbk/T/92c3gLBLoELx3YW+uxu6HCGNxv
         NMyMSUHhFoiOrGsHWJPhs6e8EP4fwlwI/oewDJOmMggoqc03EDjqKBVWHp3XNKZHqKYe
         B32jncVlTUXIXPIVABfDzNU2yzxIoTOu/9Lj0uhT8PEkp3z7V8wlSXopX45EUId1/QcK
         H93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036339; x=1783641139;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8mXmJX+ZzpCqp/w7JpCSA6Qcw3BFMeXA6EyptAd3DY=;
        b=ScaxgsnBLjFwwQtbBh5qBrHsP2plsaJ3UeIiVchr01O8Fc9erOVmACEr9o5OMIQmiN
         joMZuJTEdMOYTfH2VJ/s/F2p35qIKiweaqpx/Ncwusb8QduoJZCKca8lF/hUh5pqJHtm
         9yOj4LXkSTiJVqQmJmIYxAHTF4h96l85jWnn25is9OjLI8Uru8ejFIGnlAwDyqfUOi+s
         y7X4Vnn9QmNH3UNPXJ5QeuKj+InvADOvR5lTLD5fzJf1EEBtAep5eHGK0ppPTl5lgS0O
         oi9q4RiVlzshWbKk6Vceip6nuSBmz7naSWFDuSh3t5KGQh5trvAhNl4LHwe9o5SU3iQc
         0fSw==
X-Forwarded-Encrypted: i=1; AFNElJ/8GOXUr98DnXaDL+cBY2rbg4kidYOPF0BplCJKr3uOXT3njpEimdKdJPbJwvMQ3T6rHrtdCso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsYzmV/SbLFdoRRnXo+0tsU6qu0Vn+uWb1qnSErYDtUe/J/0E
	qeSPFizPyk6UU9duP8FeuFGVTVjHTZ9SBJa78seseAUYw9e9X4USl87UfAkq+bshv7joIC1FMrz
	/+3jKAevTYaOxaUcI5NSExsPbtVxQAc/sLa7K
X-Gm-Gg: AfdE7clyUrFjmDvmpsHIO/NfwvoKunNoUgct8473a4AGseTvg5kPqCh8wsngAv6o/pA
	1XS5AHWQLLcv8J3tvE7bcd4Ca5iPvfxYIxLBB5aG2+BiNBFrV0H9t1xGMLnQhZh0R6I/yzqWTwU
	z07ZWw/fSOrInY0CWV39rjrO9+Ov8+XRv1JdAq4qaNLa6vrJODGWyGuw0V9EwfQ02pqs4Lavawf
	RgVXZiRKKASe7dQS1aJuNIUKf4RdTK418pE9mFvWknJQ47Ipr86GC07k6SqnqguoajGN8CRiw==
X-Received: by 2002:a17:906:6290:b0:c12:919f:f6e3 with SMTP id
 a640c23a62f3a-c12aa1d5f0dmr386999066b.57.1783036338723; Thu, 02 Jul 2026
 16:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630164623.3152625-1-syoshida@redhat.com>
In-Reply-To: <20260630164623.3152625-1-syoshida@redhat.com>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Fri, 3 Jul 2026 09:52:07 +1000
X-Gm-Features: AVVi8CdnT0IFD9ALngbaFY-xqzY4hDFoOfiwrX7N0prDeDJiU1rJrt_LQDxa-t8
Message-ID: <CAAvyFNhY2Jp5aH6YPrtfc0mBpwuSeT-8u8bODqq=pootpQffmw@mail.gmail.com>
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb failure
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matvey Kovalev <matvey.kovalev@ispras.ru>, Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304299-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syoshida@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F5E6FD826

On Wed, 1 Jul 2026 at 02:47, Shigeru Yoshida <syoshida@redhat.com> wrote:
>
> qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
> NULL return from qede_build_skb(). When it returns NULL under memory
> pressure, the functions still consume a BD from the ring before
> returning NULL. The callers then recycle additional BDs, resulting in
> one extra BD being consumed (off-by-one). This desynchronizes the BD
> ring, which can corrupt DMA page reference counts and lead to SLUB
> freelist corruption.

Good catch.

Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

> Commit 4e910dbe3650 ("qede: confirm skb is allocated before using")
> added a NULL check inside qede_build_skb() to prevent a NULL pointer
> dereference, but did not address the missing NULL checks in the
> callers, making this off-by-one reachable.
>
> Fix this by adding NULL checks for the return value of
> qede_build_skb() in both qede_rx_build_skb() and
> qede_tpa_rx_build_skb(), returning NULL immediately before any BD ring
> manipulation.
>
> Fixes: 4e910dbe3650 ("qede: confirm skb is allocated before using")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_fp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> index 33e18bb69774..c11e0d8f98aa 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> @@ -765,6 +765,9 @@ qede_tpa_rx_build_skb(struct qede_dev *edev,
>         struct sk_buff *skb;
>
>         skb = qede_build_skb(rxq, bd, len, pad);
> +       if (unlikely(!skb))
> +               return NULL;
> +
>         bd->page_offset += rxq->rx_buf_seg_size;
>
>         if (bd->page_offset == PAGE_SIZE) {
> @@ -812,6 +815,8 @@ qede_rx_build_skb(struct qede_dev *edev,
>         }
>
>         skb = qede_build_skb(rxq, bd, len, pad);
> +       if (unlikely(!skb))
> +               return NULL;
>
>         if (unlikely(qede_realloc_rx_buffer(rxq, bd))) {
>                 /* Incr page ref count to reuse on allocation failure so
> --
> 2.54.0
>

