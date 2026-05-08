Return-Path: <netdev+bounces-286019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IApGEsJk/mmoqAAAu9opvQ
	(envelope-from <netdev+bounces-286019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B958E4FC602
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E15B3032CFD
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A33A1A5B;
	Fri,  8 May 2026 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiYOSPmM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB937700D
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279440; cv=none; b=KKVpRbwlKKenIuwX5CWig7Z8MlFQhMASwAkk2b7eDTkY9Qa97ZcC38J153pGehvebX4PnuQc1I8D4BncQOiIZMONTUPVHYIr9I5zjdi6Nad+ml//Xo8aG1lp0o4mJEhznVPUyoe42FMHgkW14AvN7Wc+UQgVHTOgBR8VpbarpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279440; c=relaxed/simple;
	bh=Wu5FDALBvzlDUGj+uhbPz25Y48g8JEEjaRm7yw3xXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKBJAqKNQl9CqUgU2kcc2TiVV1SkRiQTMMm+MzoiwNeLpSUHUf6w0WneOQGJUtz0w2OVdPTOWPhSKJnx0MhZVZe2pcyiumpKgSP+4AAoNIHRj4uOPTkwkNEX9MyfgVXBT+oWwo1JE2X0xTfMHSoLJQGCZ0ZRzFnusoOLJxvuibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiYOSPmM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ea8563c693so271319885a.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778279437; x=1778884237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AUaxYCPCqaIbXtU1GhIn25HX53q6rl1plD/MbJsm1Y=;
        b=FiYOSPmM4YgttiUU3CDnyv9jYdys/B6dBcUX2p1bJ4o1rLQg374U4uXhcjqWjPgOpx
         BThusN6G8ZUqxLrBJn1eEaExAjlSEF6OkbUwkvWOwVPuEkzD+cKFzcsK7d+9E+pvfPD6
         HrqdwZVDIvr9N56FOkZlqSMMp9AICF4cCmO3/tX62E0WCO5ZiQslGE9CXCS3oj0x+xWk
         pxJ52fBB9X0ka02ySEs6NvoctjAeh7jwpvqfl1Ku5iyT6JzZmPo+CO/4+HvWg0KREqsd
         E+O/wdmtKAUJh7bszODU2m7VW/CZxrF/ubSOhqUlJt8b081HZnhovARdOuOeHtjAYOgx
         U5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778279437; x=1778884237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AUaxYCPCqaIbXtU1GhIn25HX53q6rl1plD/MbJsm1Y=;
        b=S+MLCLz84JKwEaSeJrYQ+c+F6ToiDFywNqHEtdUW9j/t5cfTkM9m6NOfAEi+MKN6H0
         5FTJZ3+HDqOX/mWcd2Qkcno8vbvORNXGy6VddA/TLV5O62xNuaBaVOszJW1O4X21En6q
         pcCATpV1CETPKTnfd5ohwlbCiVzPADHPzIdqZmzAMizTxyxVDHttuD18s9nMnGBY4zJv
         ORkN9BXeybdZzYm0jO7SJHAHa77uKHggGqrqYmWxS2LSrglo1XGSryk3XdpQ02AhsbaY
         cf8dAI8pTZWp0aiu4c315xS7QaJIgK5Z7/TGoHH/SF1tu5ENBbrMeYgyTGv4LSNgo1Ed
         kDwA==
X-Gm-Message-State: AOJu0Yx32uMmgpYxoGroh7Ku/vC9CMSbKznxDEU9Cf8632zS6rsfQjiH
	1cMy/8g8a/SoDEM3xElrKiiQ/CiOwCvwzBQjnDxMnIVaELqkVNyyjszVJ04yR2zf
X-Gm-Gg: AeBDiesy5EUWlfh5R7OkDh9pgh4Zpekv4J73RmVUodMu+mHjMfMxxOQasd18mRxordt
	OE930DPBz5mrIb6Udlx9cxMYoFrUowa3pk5/xYgJT1GAIdD4IJol4VaKTuyFI9hnZSo4ZJKtBmi
	oKKub9wI1Bv5QThMy4DuUB23FLi2UrXOJ0IbCpxZbLp/VDxDWvYlm31GczAVwnMvIlnVaa/d7lj
	o8IIM/RKvVphfijFPmBMeogN6sJaiEL1vbr0jS+AVpSAgQeaENfqml7ZHEN7BaDjqidnz0YkHLN
	o6H/ZKmDHu3vUalMih7HmCJrVJwH281IGPpC2r4YPmWvdQV9bUtLHKnOybSMOUX5w2y1cRvvj/X
	kt6U+AfYKmMOD6XtvDtqJgHF/ZccfmiVuTwtr8RgzKLPbMFaGlnNjxAT0D+/ffUIzN3IdsFcBjE
	cMrwIi8utt6OH1AkBh6F0fDayVS+AzlIZHa+96zKwWBTyN4LA=
X-Received: by 2002:a05:620a:2684:b0:8ee:630e:350a with SMTP id af79cd13be357-904d72c239fmr2149865085a.58.1778279436728;
        Fri, 08 May 2026 15:30:36 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:38::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm2382574385a.46.2026.05.08.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:30:36 -0700 (PDT)
Date: Fri, 8 May 2026 15:30:32 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 2/2] vsock/virtio: fix empty payload in tap skb for
 non-linear buffers
Message-ID: <af5kCGWtjwGi4Y2E@devvm29614.prn0.facebook.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
 <20260508164411.261440-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-3-sgarzare@redhat.com>
X-Rspamd-Queue-Id: B958E4FC602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,redhat.com,kernel.org,meta.com,davemloft.net,lists.linux.dev,google.com,salutedevices.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-286019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:44:11PM +0200, Stefano Garzarella wrote:
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

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

