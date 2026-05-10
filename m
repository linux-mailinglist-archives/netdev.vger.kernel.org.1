Return-Path: <netdev+bounces-286281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPVlIdZrAGoyIwEAu9opvQ
	(envelope-from <netdev+bounces-286281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:28:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08887503CEE
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A8F300764D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C0328611;
	Sun, 10 May 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="EjUNQa67"
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311464
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778412498; cv=none; b=t2fh9LBeYL9W3cLWnyUzUZwSmlTUEiLcFu9rI4SzRCtbyn1Mm6jaHgjdzc4A902+sNeV+rScaE7XYXYwQdv0P3Vfl9yAe6IQ9HV+4fMU7sF5omtLFttVE7FByEotoMktKydQt4icxCVJUj9jPCBnOtTaVEQ2i+1nXxdV179PXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778412498; c=relaxed/simple;
	bh=95KGUS+oDoYcdNHsAfXyvwh6RRCC0YrYMsCdYAMFx48=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:From:Subject:
	 Content-Type; b=eyDWtuaUx/a7SXeY5WiJ4iUTt+ZbTU6dki+kCTcjEhn1TCJhWQcYoEf2pai3hjLBRWD34NVHRYqw3+OjNIyqVMp6Rv2hqRnYFQwp2c3tprMHV/761XHGFVUU8zJgLQxgYJzrno8Wql/LDkczHvCNiAjqXRcmR/N0Eiqd4rA6UKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=EjUNQa67; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7233F1001B4
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 14:28:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1778412494; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to;
	bh=UO6/ViURK5mu5u5g5JstST8bdVF9mJN9INbsv+KxlZc=;
	b=EjUNQa67HEcWSb5XecT+eahCKU7Yk8A9H05x3FKDFqwhlh1WKOllJ2k5EkfKF0OiBaR1FM
	epfqrcbkmnI1JYZXY9Id1riDKh7/g769Xv2rCl9TMTb6EyCTdPkRJrtMKXaqQ4rhxesSC6
	Kzh6vHVMFbf7giCgfMCR5Dz39UlJFOB5Ygd2SqdUxMIci0w51a3Jm9XGvXs4gZJwLID7fh
	y4nzTZwPyBg2yrK0tIob0Mtw0jygZIrK4Jiax3a5VuQ8/xohNvpH9RJb4couaaZnH4vVXc
	1ObXZOFQbPe0WVtieWDk0cKsWW+SAyWV9VdNmoGqwykdLGntgJXTAb7TGiW9EQ==
Message-ID: <bd47b7de-df76-40dd-8fa7-ad2ad5ef0b7c@rulkc.org>
Date: Sun, 10 May 2026 14:28:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
In-Reply-To: <20260508164411.261440-3-sgarzare@redhat.com>
To: netdev@vger.kernel.org
From: Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: Arseniy Krasnov
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 08887503CEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286281-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rulkc.org:email,rulkc.org:mid,rulkc.org:dkim]
X-Rspamd-Action: no action

> From: Stefano Garzarella <sgarzare@redhat.com>
>
> For non-linear skbs, virtio_transport_build_skb() goes through
> virtio_transport_copy_nonlinear_skb() to copy the original payload
> in the new skb to be delivered to the vsockmon tap device.
> This manually initializes an iov_iter but does not set iov_iter.count.
> Since the iov_iter is zero-initialized, the copy length is zero and no
> payload is actually copied to the monitor interface, leaving data
> un-initialized.
>
> Fix this by removing the linear vs non-linear split and using
> skb_copy_datagram_iter() with iov_iter_kvec() for all cases, as
> vhost-vsock already does. This handles both linear and non-linear skbs,
> properly initializes the iov_iter, and removes the now unused
> virtio_transport_copy_nonlinear_skb().
>
> While touching this code, let's also check the return value of
> skb_copy_datagram_iter(), even though it's unlikely to fail.
>
> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> Reported-by: Yiqi Sun <sunyiqixm@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 40 ++++++++-----------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index a678d5d75704..989cc252d3d3 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -136,27 +136,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
>  	hdr->fwd_cnt	= cpu_to_le32(0);
>  }
>  
> -static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> -						void *dst,
> -						size_t len)
> -{
> -	struct iov_iter iov_iter = { 0 };
> -	struct kvec kvec;
> -	size_t to_copy;
> -
> -	kvec.iov_base = dst;
> -	kvec.iov_len = len;
> -
> -	iov_iter.iter_type = ITER_KVEC;
> -	iov_iter.kvec = &kvec;
> -	iov_iter.nr_segs = 1;
> -
> -	to_copy = min_t(size_t, len, skb->len);
> -
> -	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> -			       &iov_iter, to_copy);
> -}
> -
>  /* Packet capture */
>  static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  {
> @@ -214,13 +193,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>  
>  	if (payload_len) {
> -		if (skb_is_nonlinear(pkt)) {
> -			void *data = skb_put(skb, payload_len);
> -
> -			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
> -		} else {
> -			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> -				     payload_len);
> +		struct iov_iter iov_iter;
> +		struct kvec kvec;
> +		void *data = skb_put(skb, payload_len);
> +
> +		kvec.iov_base = data;
> +		kvec.iov_len = payload_len;
> +		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
> +
> +		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +					   &iov_iter, payload_len)) {
> +			kfree_skb(skb);
> +			return NULL;
>  		}
>  	}
>  
> -- 
> 2.54.0
>
Reviewed-by: Arseniy Krasnov <avkrasnov@rulkc.org>



