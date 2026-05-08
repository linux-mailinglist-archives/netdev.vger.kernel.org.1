Return-Path: <netdev+bounces-286017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNaQN3xi/mlrqAAAu9opvQ
	(envelope-from <netdev+bounces-286017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:23:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450454FC546
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB48303FFF2
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B433D6EA;
	Fri,  8 May 2026 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuizcXye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6F34165B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278966; cv=none; b=C+GXUaLS/Fz61Yshh+9Q+TmZTLuebk4WnkSfF8OxqRrDfQC0/3vZ4JLq8H1wUwk4i5H2DqU2NYL7r3SzAReeDwcIvfA32j7wOqliYYggPL05jy69tB+OQylis8qF9DOEkrJgA4lpGPzxVznzcjpkM3ticePrLsI8wHaEPBHI3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278966; c=relaxed/simple;
	bh=ybo2HK/PI6PDF5GbqOTLQGuk0Dq2WjaK+tSFJS3Pp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF2kMNN/0yHDCMixZO2eUMg2haMNjwOfP+ZI8530pJqEheOcJVQ+F3qk3wuD/jumjS7k5SIigQHrUcEICq1wQqxO5xR0UHVFmSTHrNX2VEzO5RAUZ470N+rD+QwloRc3w/23Ef392UrgoUuxdWB7mYkieDQpXUhv16hRgV5DBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuizcXye; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso26598066d6.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778278962; x=1778883762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=cuizcXyeDI2zPjB6uL1F5Lldbr9PBBUQtUKz/vc8IV0wN7ZABZ0g36M3xkjq5XQyNU
         w4rBEKFc/VTtOKe6DburFSrQicZX8quIPqnLa+nGjwukyUXGHV2rjQjf4hLVV35sNsEF
         vmrpXzQzv40NgqcGmFAY4CUcqVMuwyJMUYvgJmJAyCKt0+3oVmoUGmUGeD5FLv9V/WUO
         I9D2t5eUYDIUMOJ/+dokux8av2rVGvRb87WMJ/CorZLmXvMEmAwaS5hTuOi3VDMVrJLD
         zvtRdRw9UHZUv/pghA/f+vCVNnbSBWJK2Xb83dBvkoJvsMZTb145g8hNPiIZOOWzY7s0
         2wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278962; x=1778883762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=N8D7Yjr0dNZRP1bL0Mnvl1RnHc/Q9LmLZuUCHeyzYq/B6H0xqe/0GEQ3F33mCuwXKd
         OinkDT/EpoWhEFwv/nPVJG5IR/HPN72W/qZ407uVdH1GOFh5w2z/NhyQex+mIpTkRgyg
         nnjpvsYyHBFiSBxSZrBrjvYS6FuKPGv8VCBVUrYWdq0qu1WmXL0li52yHTKux3f1Yg1P
         YY+ZGpjuvW6GDu28J96hcZI0a34/C8VFVMgJ2OpDakl3zSJZhCtFmhEoNI/kf2wO6ymM
         8+WzJDyFBBxG8PQ0Y1R9QSuLIk1ki9XJlG0teOgQUedWdP8h8Z9l+sRQzsN4ECchxZNk
         0v6g==
X-Gm-Message-State: AOJu0YxY/S+2bIurQBMOSpRcK9CH3eWlsZmWnjWDSmAcKUPI5WLqmQyc
	1wh/V5B+WZXKusSlx/rAdGpWbRy9y8SvACC4lQ5txofbFLA3tjmgHdbtf2cwIKkY
X-Gm-Gg: Acq92OFGzlYR7koLXPh4VZL8K4HdWgg+1VHJ/L+phvR6WzWKun4O5jQsvxumz7vHn7F
	+B4XmXecVWQYAQRNcDfHvrsLCDmp/x+O6QF3rkFKJ19IbOMDphgSwgOmi2JfQZlKWqQeUPLANXc
	YEMlOqLQIQ6ZshBICBWzMnQ1orJYrzoIPpjuFqOS8phOuYnyy/i+gHnZBFDj1/yFrkw7Vx0ZeuP
	CVsat8xPSsogQDUXpmxltf8A6S5dO6+wHzPRx3xlvJgm1kFOgR4/dt4Npz2yhmpTvp28cRDLlSj
	KegLEeW0mqQP8GnT6Qg44cHYK6nwcR3+auKyO8IuZ0WqXDvGYg59FZVTuweSNfJVMVUyvNR8vc3
	e8sQXteA9lSYPq99zklbMz2x8db3pnUJKK2XnY9AwdoTHfTspZYCIX5TP2PKy/k3xGYf3y/zbOu
	mDQJ0ogfdJb3Q0oCoPu6JzU4kqemNYqIRzvvP8yzdQEw0Pq85jMTQxxQU=
X-Received: by 2002:a05:6214:258c:b0:8b0:2ae4:da26 with SMTP id 6a1803df08f44-8bc422a66f5mr208086466d6.10.1778278962004;
        Fri, 08 May 2026 15:22:42 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c81b3fsm30363126d6.29.2026.05.08.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:22:41 -0700 (PDT)
Date: Fri, 8 May 2026 15:22:37 -0700
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
Subject: Re: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb
 for split packets
Message-ID: <af5iLWLo4Kz+USum@devvm29614.prn0.facebook.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
 <20260508164411.261440-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-2-sgarzare@redhat.com>
X-Rspamd-Queue-Id: 450454FC546
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
	TAGGED_FROM(0.00)[bounces-286017-lists,netdev=lfdr.de];
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

On Fri, May 08, 2026 at 06:44:10PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_build_skb() builds a new skb to be delivered to the
> vsockmon tap device. To build the new skb, it uses the original skb
> data length as payload length, but as the comment notes, the original
> packet stored in the skb may have been split in multiple packets, so we
> need to use the length in the header, which is correctly updated before
> the packet is delivered to the tap, and the offset for the data.
> 
> This was also similar to what we did before commit 71dc9ec9ac7d
> ("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
> missed something during the skb conversion.
> 
> Also update the comment above, which was left stale by the skb
> conversion and still mentioned a buffer pointer that no longer exists.
> 
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..a678d5d75704 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	struct sk_buff *skb;
>  	size_t payload_len;
>  
> -	/* A packet could be split to fit the RX buffer, so we can retrieve
> -	 * the payload length from the header and the buffer pointer taking
> -	 * care of the offset in the original packet.
> +	/* A packet could be split to fit the RX buffer, so we use
> +	 * the payload length from the header, which has been updated
> +	 * by the sender to reflect the fragment size.
>  	 */
>  	pkt_hdr = virtio_vsock_hdr(pkt);
> -	payload_len = pkt->len;
> +	payload_len = le32_to_cpu(pkt_hdr->len);
>  
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>  			GFP_ATOMIC);
> @@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  
>  			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>  		} else {
> -			skb_put_data(skb, pkt->data, payload_len);
> +			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +				     payload_len);
>  		}
>  	}
>  
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

