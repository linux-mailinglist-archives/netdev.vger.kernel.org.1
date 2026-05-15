Return-Path: <netdev+bounces-288390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AAyFxFgB2pa0QIAu9opvQ
	(envelope-from <netdev+bounces-288390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4BB555DEC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D4532B141E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287E3D9025;
	Fri, 15 May 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="bMjmi7p3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CA3D88EC;
	Fri, 15 May 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865526; cv=none; b=Kc8w4U8lvvvEXh1wYTW96/eDgCmViUeHX7rZEeCnm0afxVFOByE5PDOuLJYPpuG1mMSL3CrcGhu9LsSc3i23I8DLKn6VrGP1375dePSAhw3oy7rVnlpAhYpx5+JUWKnYuforRc7BsFa4c+bt9KZriTnUApaERsze9LZZLpL2GA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865526; c=relaxed/simple;
	bh=AThb4VcvVIl2q1HLSzrRx+pOQEogMqaBF6o78sY7O9k=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=gdcErAGZDc+f4cenwtMCTl+Hedle1W+fCSHJZrMGgo74xIJfQ3VwaYzxIHxH4xnkv5rKe9QOJnmsyQUnO9uqDoKwTurs+tQQ8s9GARFMRzKmwYaGIUMX2ll5LDEtyFjyO39HYu8ipwfPwRF4PAMiNdytMHumcts7AuYEzBUyuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=bMjmi7p3; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18E0310113F;
	Fri, 15 May 2026 20:18:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1778865514; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to;
	bh=y4uy4Pn148gEWMp6CsBHAvnIqyb+WyfkRqF4BSbh4/E=;
	b=bMjmi7p3G3dFTYfn9vrSaMz3B4xgHlRxlpV/RN1261UCXil+PYgyODOy8Fsdo0qFG2p9hQ
	ykboWeIQBNEhnUTG1AIrWpk1KPoB8bbx2KnpXNKUQI3wohBPlA9m34jr9d63oe3kEapVaZ
	jSyV2bNO9YKyQhkDgjJKvyAsN++/CAjnkjEPU54gIwUi+qPhDF5J/EqOmLG8od0x4MpvSp
	mQLOoCCekeefOpefQCWsqXBuMnAYrqezaDw0sycVuFNct/RA/vxir36l35FeAQZIwe70VL
	WlJoS0AxqtjZ6kzufsdF+KOqaJ2cCcj1NY+e9crweb8KF62BsTeB10kSc06gZQ==
Message-ID: <1546ca10-e85b-4a67-a5b9-cf2623d11e7c@rulkc.org>
Date: Fri, 15 May 2026 20:18:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
In-Reply-To: <20260514092948.268720-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "Paolo Abeni," <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "Xuan Zhuo,"
 <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 "David S., Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org, Maher Azzouzi <maherazz04@gmail.com>,
 eperezma@redhat.com
From: Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BC4BB555DEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288390-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rulkc.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rulkc.org:mid,rulkc.org:dkim]
X-Rspamd-Action: no action

> From: Stefano Garzarella <sgarzare@redhat.com>
>
> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse. If the loop breaks early the uarg is never allocated at all,
> leaking pinned pages with no completion notification.
>
> Fix this by following the approach used by TCP: allocate the zerocopy
> uarg (if not provided by the caller) before the send loop and attach
> it to every skb via skb_zcopy_set(), which takes a reference per skb.
> Each skb's completion properly decrements the refcount, and the
> notification only fires after the last skb is freed.
> On failure, if no data was sent, the uarg is cleanly aborted via
> net_zcopy_put_abort().
>
> This issue was initially discovered by sashiko while reviewing commit
> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> but was pre-existing.
>
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>


> ---
>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 989cc252d3d3..1e3409d28164 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  	return true;
>  }
>  
> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> -					   struct sk_buff *skb,
> -					   struct msghdr *msg,
> -					   size_t pkt_len,
> -					   bool zerocopy)
> -{
> -	struct ubuf_info *uarg;
> -
> -	if (msg->msg_ubuf) {
> -		uarg = msg->msg_ubuf;
> -		net_zcopy_get(uarg);
> -	} else {
> -		struct ubuf_info_msgzc *uarg_zc;
> -
> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    pkt_len, NULL, false);
> -		if (!uarg)
> -			return -1;
> -
> -		uarg_zc = uarg_to_msgzc(uarg);
> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> -	}
> -
> -	skb_zcopy_init(skb, uarg);
> -
> -	return 0;
> -}
> -
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	u32 src_cid, src_port, dst_cid, dst_port;
>  	const struct virtio_transport *t_ops;
>  	struct virtio_vsock_sock *vvs;
> +	struct ubuf_info *uarg = NULL;
>  	u32 pkt_len = info->pkt_len;
>  	bool can_zcopy = false;
> +	bool have_uref = false;
>  	u32 rest_len;
>  	int ret;
>  
> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> +
> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> +		    info->op == VIRTIO_VSOCK_OP_RW) {
> +			uarg = info->msg->msg_ubuf;
> +
> +			if (!uarg) {
> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> +							    pkt_len, NULL, false);
> +				if (!uarg) {
> +					virtio_transport_put_credit(vvs, pkt_len);
> +					return -ENOMEM;
> +				}
> +
> +				if (!can_zcopy)
> +					uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +				have_uref = true;
> +			}
> +		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		/* We process buffer part by part, allocating skb on
> -		 * each iteration. If this is last skb for this buffer
> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> -		 * completion for the current syscall.
> -		 *
> -		 * Pass pkt_len because msg iter is already consumed
> -		 * by virtio_transport_fill_skb(), so iter->count
> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> -		 * accounting done by msg_zerocopy_realloc().
> -		 */
> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> -							    info->msg,
> -							    pkt_len,
> -							    can_zcopy)) {
> -				kfree_skb(skb);
> -				ret = -ENOMEM;
> -				break;
> -			}
> -		}
> +		skb_zcopy_set(skb, uarg, NULL);
>  
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  	virtio_transport_put_credit(vvs, rest_len);
>  
> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> +	 * initial reference to keep it balanced.
> +	 */
> +	if (have_uref) {
> +		if (rest_len == pkt_len)
> +			/* No data sent, abort the notification. */
> +			net_zcopy_put_abort(uarg, true);
> +		else
> +			net_zcopy_put(uarg);
> +	}
> +
>  	/* Return number of bytes, if any data has been sent. */
>  	if (rest_len != pkt_len)
>  		ret = pkt_len - rest_len;
> -- 
> 2.54.0
>
>


