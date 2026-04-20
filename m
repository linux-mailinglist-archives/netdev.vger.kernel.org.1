Return-Path: <netdev+bounces-279898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGCpA8Fx5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:34:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B2432EA0
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7341300E01C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6B3B27CD;
	Mon, 20 Apr 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUKROWVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6C3B0AFC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710071; cv=none; b=BXYS1pTTrup32qK7X+h5MMRpt9ggVFhhT3avmtZJyT2QZtTA5xrM/FEjiuD33ZxHfpBpqO2+ppPi415bpl6Pqj1glTyZmcYBKwjXqGRsluI1gxU3AK/CUz2Myc/oRJgtHLh5TxgvoO0jr/nvpjsgN3whUH7FyOLIuzTp8bIX8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710071; c=relaxed/simple;
	bh=ienUfESzt6vNzLdl8pNwfDx7dxAyw+aVjIBPr3f4Yec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbGxkmJ87sEu+dMauTq1sH9NxN4ROSXczqOeo/NRpvzrLq/5/vEvzSjaPvwZbb+r5GizgkVl7/ivaXMtRvfdUDm6MxkQHLk1wNQ+kWmYxgMHi2XuSaxhSoTZ4SaNI/Ar46NEohY6+WMnTdh/p/amBB+yCNGVNBJjijlQpbSqsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUKROWVE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso2365258b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710068; x=1777314868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=FUKROWVE9PkJqNZ8v1dPScvL7r2iebaRXT+GE74V3ahoVdLcfcDee2F++rXyxPAtKh
         VU9Xg11PdM7iw+Iy78jZNcs90e275ZiWfC6Hd5QSzUbCdCYmvDXw43lB1bPw1ZzTpPzb
         2ySX1d4ouMRlX7qlbC72iBJT4c5i9fsYyYY6wUtBidGZI43Ehw8CzLSf9skn+demJaXH
         rrzKz75HXJ5DLRwbt2KgyuiEIEtisslfwzzz16QKHdRwToNP0gTp7dKVzVQGFg2lN7b9
         ezm6yxsnwIoKqbKofe4soZDGT4T88Bdsz+Kw7LaGczIw5GdmPWU4Nq9y7mVW9AZQsQB/
         muGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710068; x=1777314868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=l5qJy0fEocYGpAuHzTrbT2pXAGnFeUVBtCmFVSWTLvQu9lfbL+JMkmyslsEd/7xqS7
         xC74pEjfTxcCtcuf2rfe049GXT6RbCROmBuc6w9j8wHsVCtbC+CAfcbLBt/xLqBSzkVx
         a6xGvSKQnsal4CLA4Xj8OeSkADEQg5P6Xy0WzC3JaT8HIWEkW4w+07nZo1g1iegMq8Rm
         f1xYr1Un8T/7X0r306VUxugv68hkZqXOH+J+CBOsbJbKiRCLU3S8zF9/jUZUfownX3VW
         mKYmewX6FlcvCDKMQhPYvQyVrQLpE7UcCrH6RR7M9U3qU3RQme5Oiv153wb/Q0d8LeFF
         ek9w==
X-Gm-Message-State: AOJu0YzGsml2uLDLobD7EYvnApurGaSdb5XwcMvpfp4BNgrUSrUYsP/Y
	aRpUREzk5ROze1DNuAjwX4UJgh8f375MFPn/wXB5RukIyMM4svgLj5xe
X-Gm-Gg: AeBDiesDchil5+N64BiIPJWZ8VwbdbuRgPUTa4+mJdE+rWELxEi/1+KjrmC7F3PDd5F
	orYKsKgrilkT9OUxBPzxCfwk1mAa7R4NssfWFN/AAbcrtDrRHfpJ9vL+GmiU9xoimIvFYd9S+IM
	ZuWKAFlDruJyyXsFMPZO1cX0EgmwJygdMIhph4yz93v59emP4ipNkocCHLxtQpEdzr692FvyyIc
	KreZl22wNcViGz/hm9/2ucasF+IiC3ZU/DyMErXZErTuRES1FK5K5fkqPmkxUtaN5Jyxi5arN5S
	rbcCQXnaUBkCcnLdaGy/SHuNXv+hbtws0WhVaCUQJYnSCFeNtx1O19SaRIN9oU6PmN+lKh4P14i
	tEvg5cGKnk7UhHlele47+rPxSlbElkQbgKYsRcH25DzmA3IRPTLaOf+Y6GEhf6xzKoBTEnweRM9
	6jDR3gyGQIZNNKnAFQ7U+z/JuWbiTH0ngME2G3UxqvrO0DKJx4BaDAkw==
X-Received: by 2002:a05:6a00:4c82:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-82f8b384f1amr11355701b3a.11.1776710068332;
        Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm11798580b3a.15.2026.04.20.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:34:27 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:34:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages
 accounting
Message-ID: <aeZxscYXyE6BE0tY@devvm29614.prn0.facebook.com>
References: <20260420132051.217589-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132051.217589-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,salutedevices.com,davemloft.net,redhat.com,lists.linux.dev,linux.alibaba.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-279898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E95B2432EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:20:51PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_init_zcopy_skb() uses iter->count as the size argument
> for msg_zerocopy_realloc(), which in turn passes it to
> mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
> function is called after virtio_transport_fill_skb() has already consumed
> the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
> will be 0, skipping the RLIMIT_MEMLOCK enforcement.
> 
> Pass pkt_len (the total bytes being sent) as an explicit parameter to
> virtio_transport_init_zcopy_skb() instead of reading the already-consumed
> iter->count.
> 
> This matches TCP and UDP, which both call msg_zerocopy_realloc() with
> the original message size.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 0742091beae7..416d533f493d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  					   struct sk_buff *skb,
>  					   struct msghdr *msg,
> +					   size_t pkt_len,
>  					   bool zerocopy)
>  {
>  	struct ubuf_info *uarg;
> @@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  		uarg = msg->msg_ubuf;
>  		net_zcopy_get(uarg);
>  	} else {
> -		struct iov_iter *iter = &msg->msg_iter;
>  		struct ubuf_info_msgzc *uarg_zc;
>  
>  		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    iter->count,
> -					    NULL, false);
> +					    pkt_len, NULL, false);
>  		if (!uarg)
>  			return -1;
>  
> @@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		 * each iteration. If this is last skb for this buffer
>  		 * and MSG_ZEROCOPY mode is in use - we must allocate
>  		 * completion for the current syscall.
> +		 *
> +		 * Pass pkt_len because msg iter is already consumed
> +		 * by virtio_transport_fill_skb(), so iter->count
> +		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> +		 * accounting done by msg_zerocopy_realloc().
>  		 */
>  		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>  		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>  			if (virtio_transport_init_zcopy_skb(vsk, skb,
>  							    info->msg,
> +							    pkt_len,
>  							    can_zcopy)) {
>  				kfree_skb(skb);
>  				ret = -ENOMEM;
> -- 
> 2.53.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

