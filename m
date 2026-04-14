Return-Path: <netdev+bounces-278552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JbxAXKB3mnkFAAAu9opvQ
	(envelope-from <netdev+bounces-278552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 742AD3FD689
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBBF308078E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97978386421;
	Tue, 14 Apr 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfR8JKlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F9318EF4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189443; cv=none; b=G87FiYQySRYVNEQu+UeXjX2JJVhgDeGJKcNrNMRhKL7Hzcj1RZHjlzoTVo6SuA0JQzAgMG7TiokHlcvre9vTg8atFRR5YO+bwKvKCOamooJ9FW28qqxuc8e96Sb8wCn5QbVJyXnrGeDQKB359iaPt4hne2vUf6PXoa2yFZa/i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189443; c=relaxed/simple;
	bh=RxLJJLLzEOf28UzybbeVMCDS56pJ/dqW9LsUPIaHKeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kopqq8hLDWXJqWTFAhO47msirglm+JB6kKBhLA4OIc/ASOfzmhzygDcfHOTlcJnJQx3yaN7B0hOV8XiWsPqMSZVIUDUP7ZdUZciSSTRBnawaJ/ZpUBmkDDPL5UNtp24szjfdK/IMe969q9p2jmJV9805To+OtLzJzFWrmIBDGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfR8JKlP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f1f6103afso1717282b3a.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776189442; x=1776794242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+1c4uO7iq2Fg7R/gMK90WQL2cE90NN7fs2Y4N4QIao=;
        b=hfR8JKlPlrpNNR1QmGGZVBwmumBU2MS6WIbhbEwoBrc3nEatsj5ZnjpBGtB/MGHbV8
         ZPo1nVPQ1/CJVbN34WF94xoBKsy185cegiozMjs9WGZ2EngajYWHvoFtrqPWJ/4elhNo
         1JbWJJtKJohbFdPqDqBl4onXvm17Y7aheBC3QlOGXByrHIHKXgQbXa+3JlN+O4w8jI7H
         +yd7dp5fdxQ8z+lhnLMx1WV3r3bycC152NfVrJGK2uC8+iB2tfj5cvnS3RqRApmGfjBs
         p6Shu4HREIhV8IhGIDRRuNwjdX3cV9i1Q/KLCdrjXMcU6s/MUVr46G1jryNjQVdFXaGT
         q7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189442; x=1776794242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+1c4uO7iq2Fg7R/gMK90WQL2cE90NN7fs2Y4N4QIao=;
        b=MPBjTMh+NcgfxH4tb1Qx7XKH1GiPcepE5UjiXCMDEXu+XBozmwohgP6xQHKayIrgS8
         Luba6Jr7G5yn6+l9P/CIqIdrDx3ezCKocqwV/1vYOiI1apVFIHVrU0rtd55CF4ZcryAN
         4kJmF65k2prb7YC6RIoz8Xqh7XdicLzj3ev2MCIl8g8n5d0ajsgXtrHE74xICKSGrGZ5
         lTis9AnoycB7T8YnTI5f4JesrDDdDoi2cac1G7Ln1wdewQXeU1NqmELKU+Cdj/z0HiYN
         nU7JrpfBiFsgJz+c5d/5Y4b1T3qU/Cf5XF2n49w23yf5L6qancLwZ0an6/uxRyuA+gvw
         SOZg==
X-Gm-Message-State: AOJu0YxSguiS1IFD/h9zVM/T+fMrYzqWsDEituogYKOwM/6AvJRf2vOD
	6RqRRlLMnNfh3Xq5vw85kIfjvtCu1RMZavjUGjQgyWTt1k5Gf6pteUu9QilYBg==
X-Gm-Gg: AeBDievlXdAm6j4okWNaQhqHobxKcNu/R3KY3tVrjEWbxjw7/cih0YZsd5J4QxHAgDA
	wPatenKs8u3CPe5gSwEHtejy9GomXqaUVDuch9B99+mV88xfAV64kDde8FgXZyk4+0rNy3PxdEp
	UAuk0cDlDAI2/uUDN27Ia3Vln5Mf1A9A43nlGZ75NHiySH70vdjJMDlp0ocR0kgbnjbAx2zDSFr
	FsMTUPhy7JCQdm1T+9WwH5NmjfocvlCZKjha88BkYmbZdPNw/s7q+JgmTntUpH53si1HdfiJ+Uo
	T24W52dFUWXs2Q9pu8mk9VHE2WTzq7xCdgH0ick6Wbd7/YHtN1rfiMARUSAfhvwT70GZrehTJa3
	BilYhfI1UTZJwbJILrqL/n+0GHkxnNNTw5QxZ29h3d959IQ4yv/I2kMYdt8DPPnRQCDAfFmbQuW
	nvcS1ON0x6YtmOVGSkZdjOHNT32Rkn2AV3hJUenTSGj3HrAQcSPRtDMwI=
X-Received: by 2002:a05:6a00:ad8d:b0:82f:316:3208 with SMTP id d2e1a72fcca58-82f0c35628bmr18240962b3a.29.1776189441624;
        Tue, 14 Apr 2026 10:57:21 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50cd34sm15616638b3a.54.2026.04.14.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:57:20 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:57:18 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, sgarzare@redhat.com,
	mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2] vsock/virtio: fix accept queue count leak on
 transport mismatch
Message-ID: <ad5//tvvMRGnX39R@devvm29614.prn0.facebook.com>
References: <20260413131409.19022-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413131409.19022-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Queue-Id: 742AD3FD689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:14:09PM +0800, Dudu Lu wrote:
> virtio_transport_recv_listen() calls sk_acceptq_added() before
> vsock_assign_transport(). If vsock_assign_transport() fails or
> selects a different transport, the error path returns without
> calling sk_acceptq_removed(), permanently incrementing
> sk_ack_backlog.
> 
> After approximately backlog+1 such failures, sk_acceptq_is_full()
> returns true, causing the listener to reject all new connections.
> 
> Fix by moving sk_acceptq_added() to after the transport validation,
> matching the pattern used by vmci_transport and hyperv_transport.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---

Just a heads up that version change lists are encouraged.

>  net/vmw_vsock/virtio_transport_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..e01d983488e5 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1560,8 +1560,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return -ENOMEM;
>  	}
>  
> -	sk_acceptq_added(sk);
> -
>  	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
>  
>  	child->sk_state = TCP_ESTABLISHED;
> @@ -1583,6 +1581,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> +	sk_acceptq_added(sk);
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> -- 
> 2.39.3 (Apple Git-145)
> 

This makes sense to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

