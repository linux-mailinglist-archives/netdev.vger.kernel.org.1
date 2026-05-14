Return-Path: <netdev+bounces-288002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGX9C8DhBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E61543838
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0BE312F213
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCC42188D;
	Thu, 14 May 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rkb7+eFV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJCcJsfc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9F40DFC7
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769859; cv=none; b=WJvx2v2INGSaEoP+TjroOyV/tyxLljVDY9iJ5D9QalEik7ejKpoV/93b8CcyUB7syK6WFEj+93V45w4q3o6TdRwQfMfkdeKSDD4VGH8hjS1uQ+qtApmMeCyLzDFP4sWye4YVnAvxxI6EUUMaKbHYogYU/IuQ/egj7v8H4xjtXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769859; c=relaxed/simple;
	bh=0b3Gh85Tv7Tr08PJAhpkGIi508l+sNtqLAghxEDQf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgGbj1BYSKpUUolT9ZM7ONL/hBRK4SF+W6DPNJewD/PfSneMVqDDZ392fV39se4JBVTY7RXDEloffRFrIvLm8/NRvFhESbG0j/mfJrxTcwrxl89Ey+KOb+MDD1OJ4geQnRtqHp6aN2bg6ouJzFQ2K+a5J/coYNJTq2i/fbCOao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rkb7+eFV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJCcJsfc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778769856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
	b=Rkb7+eFVhY7L/M14gKHM8UORFZQnmVc4lxffclM98A49lswcCgOJBH/yoVH+1jl9FOWrMa
	T5WjI0NwlI1ZUX+vbK0DB/SXcUbWnHLUP1x0h0VTB429h8cRjb5a6cGOYlUO20PXeQz8fA
	tHcptowZDgVakTZVPPneuX1bgRCgBhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-gU5uG1VqO5S34N6Ra1Om5g-1; Thu, 14 May 2026 10:44:15 -0400
X-MC-Unique: gU5uG1VqO5S34N6Ra1Om5g-1
X-Mimecast-MFC-AGG-ID: gU5uG1VqO5S34N6Ra1Om5g_1778769854
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdca5c638so4959645e9.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778769854; x=1779374654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
        b=IJCcJsfcavvLhZJfUCjHY+1b/1GSahhwDLeonatVoJ0DH6J0jJZDdwgH+LB43kpU2S
         OPwhYgEGUqJORMeSyfaNmn9vRrCkeiS+EpYZFvlBOFlKQRdt47QVMtS5hFxYuFnrOQHM
         JnoC41fIBDJ4OUz8r7aLQoD6tdDvyJja4YX/ehpD9arXShfo/CC+PdXcALx1shlq/K0m
         0dUjtKrAxrU++jxuD6gzTOqtzD7eMIAh50FjPU/rlTo67J/b82LYaC9Vg0ccYXF3rGWw
         HVcNI96jaX/Pu2Mtn2rC0flXgfPMaPUh5AuDh7vJMBJ6g2Zl3pLf/hOLyETbdRTWPay5
         a3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769854; x=1779374654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
        b=Pr13yPQ2qjRUxljM4xjdrF+Ejy4ZHHSlfQoq4FNwn77rCYyNGoXaeVD0cz3kWr3vTS
         k++MEs7Y9TR24heRVq9J0Iy6qWkdEyb2zk42a4CyiCC64qgY4a1t4Ompp8Gk3gsoXGhB
         p49JQwBq/XtEFlUHSw15FFUQZPJplyoEXHoUErmjSxfDcwLZ9kHtHaXc7Ar2UW5iEJSd
         XuYOHGtPXAGnCPOP4E2syfI0uGLeAMoc1DCcuAsGlTd9L8RPkvbVkXa+VVSVUJSx6scd
         i5GRJJ9jXQk79d2M5K4kAhToS4hI8bny0Q0lQBoXKB9+pkGOXSZGm0gMP/mOxqZ+Q2jB
         BKfw==
X-Gm-Message-State: AOJu0YxBMp1siWqK7OQNljA5ruGSScBcLXIzKnr/IQ68XL+e06om/er1
	CEdqhaiE+SdnJJk4iq9EYwLGUliWwuXf37u25EN5mhuZMRPKvsAoYSeLx+gp+2jG0+JvLqvPyvx
	BU5QA39qd9KSnytCySY+7DjDCUVoByztVA1SSByz6mdI/+Q1KPClTgKf/znbTvrxMD4MDu0xWrC
	bi4QlToBbJ5LUrJJZZ+cVq/0DrMMyf+Ml8Kbb56eA1VQ==
X-Gm-Gg: Acq92OH723Kjt4JKxyI1Nsfw6LD1qxHy32Sez5FYcbkLukXuVhDvJEvN2iJea7akwH4
	YIWDhTRqkRBz/Ap76QAa4+20n2qWyhNdey/6JaJMMtKzRDm4uD2wcMpY7A7VAt0BqvfkIFuNgii
	aNoze1Jns4srBGMB7VVoHFeq7Q3uiOO2eA8gru35oTiGd3IaFz4eIcvcusrYvJNKeKFHiWUn46c
	6JUc/v9Xz2ShZj4n3BzHuPAQmILvRI/x+F0FLePo6iAjJinW2e2+oiKet0wr4v8V9K2X+5CyZvc
	tnM8NlyA6Y1XbjnO5KhAc6V9VERCR327nfKmFvjsoDy5PWCk4HNViVJ+AzUlZIp8IDMEZtzeo2d
	OfmDkZPf2/o5tEbcuMxHiZOwtR8WFpnA/PiE4R//bUHeFTUSKSHf+HNkAdZE8aWWlm9axCCC7PG
	vj2YYuYsjS
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120385245e9.0.1778769853912;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120384805e9.0.1778769853516;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm7140850f8f.30.2026.05.14.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:44:12 -0700 (PDT)
Date: Thu, 14 May 2026 16:44:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agXe67XEf3O5YSko@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513105417.56761-3-sgarzare@redhat.com>
X-Rspamd-Queue-Id: 91E61543838
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288002-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:54:17PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>buf_alloc when checking whether a new packet fits. This reduces the
>effective receive buffer below what the user configured via
>SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>silently dropped and applications that rely on the full buffer size
>to deadlock.
>
>Also, the reduced space is not communicated to the remote peer, so
>its credit calculation accounts more credit than the receiver will
>actually accept, causing data loss (there is no retransmission).
>
>With this approach we currently have failures in
>tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>test 22 always fails in this way:
>    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
>    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>    Resource temporarily unavailable
>
>Fix this by using `buf_alloc * 2` as the total budget for payload plus
>skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>is doubled to reserve space for sk_buff metadata. This preserves the
>full buf_alloc for payload under normal operation, while still bounding
>the skb queue growth.
>
>With this patch, all tests in tools/testing/vsock/vsock_test.c are
>now passing again.
>
>Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4a4ac69d1ad1..e22117bf5dcd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> {
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
>-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
>+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>+	 */
>+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
> 		return false;

sashiko reported a potential overflow here:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll check the credit and overflow separately to ensure both are 
correct.

The portion relating to the user setting a buffer that is too small is a 
pre-existing issue and IMO an edge case that we can ignore.

Thanks,
Stefano


