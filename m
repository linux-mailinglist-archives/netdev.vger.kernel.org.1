Return-Path: <netdev+bounces-300932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K+ITJU5mOGqwbwcAu9opvQ
	(envelope-from <netdev+bounces-300932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:31:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2396ABC23
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:31:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dZmcz6vn;
	dkim=pass header.d=redhat.com header.s=google header.b=gdFTCl0h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300932-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300932-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6275230179E5
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C23793B3;
	Sun, 21 Jun 2026 22:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB2378D8D
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 22:31:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081096; cv=none; b=JbvoUoNOlF65j0XVnlNDpX2Z62TlIjwUBTLA22w7thus/B/HxWonjVoP/HdlVMj038NKEiPcrNqFl3Iu+rOk6EJApCy+nBeT5hNZPkNdTxf81EotfcpWFQXpwqFKPYBnqJLv8YDK/i6/MgaiaZauDGI0ccOmhFmAg16WdYMKHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081096; c=relaxed/simple;
	bh=gak6u5xVNKNtPy9SyiZwr828na6uRPsG4KNYGmdyl5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaXFfdsI6QSTM7rTdFwffASyrQOdURarAyZJ8ky14BhEjYmIqOQytnfZ+EuHAsw/+1TzZhVSkwMaCKGqPkUovD7vRCRNYvNOz822aO60zy8WV0RwEGuCHncVbdw1qvELnT8gQpUcStkyNbcD2aoefcGNw6yXY5a/XhoDXULip/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZmcz6vn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdFTCl0h; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782081093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hT6b+62UwE6IrhyySHAzdMAZ/HMl2D61nk6Amr5cc=;
	b=dZmcz6vn7AFKTIraII/bf2sh5mwR0+ZYf5mJETzQJQDfQcd2tb9PpFTfG89RCXdMdIJ+dw
	ipHaARthpSmm5S7aKQs+FyZQ4uQC7Lz58J5yiMMVYudDQC7ZYWYf7s/TOScsAJk5nY2v89
	OlgNmvrTDKvRZUEmS2YpmKUkGIwXBE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-b-qTOEQYNRic7RHH2JOjbA-1; Sun, 21 Jun 2026 18:31:32 -0400
X-MC-Unique: b-qTOEQYNRic7RHH2JOjbA-1
X-Mimecast-MFC-AGG-ID: b-qTOEQYNRic7RHH2JOjbA_1782081091
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4639f122c38so2657990f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782081091; x=1782685891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3hT6b+62UwE6IrhyySHAzdMAZ/HMl2D61nk6Amr5cc=;
        b=gdFTCl0hcul6M4TXsk0hppqQiwfCMludrBLXPkR1ysiA5yeAiElB7PWBxDCyBOR9uo
         w8lC7Hkh/x8QfXHg+BcauX3/hVVirOfMOVASwj4sZKRLY+Cs//CKTws8qBY4Afa9G94J
         BtgnZuECmkWN3aS1IGpyILq/BS5j9ZaBt9Hg5NQisJnAfqaFDulCDYNX9Ai1MgM4fsJE
         kq66C5iGSKfalj5tROXLQm8tcF/IYkPC9UWfyv86eUjOupieIB2dLtFY6KJepUpFcm/Z
         C3e0ANZ2J8GbxbzereyTLh/k2u1hts5evO0dXQCc/C7obkKtHreGZkWtahQvcSvnvNeF
         CmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782081091; x=1782685891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3hT6b+62UwE6IrhyySHAzdMAZ/HMl2D61nk6Amr5cc=;
        b=svaw+uayWMEzRtirWRrC9FzhWbMu8xXPSAdE6p5GOqAywogW9pLn8WJpN7etsMYB6L
         FkYC+YbyCI0gjUMRwQDCb+dHK0W/H906aBLbJdc3ceu5A8qvnqkq4uDZqQZ084JiESuV
         bzK7vriw8bS4X76vYJOTfL4agRMrXZAZoOMPZziVhMDHC7YefnzAFXJguyMrBL//cwdH
         29LE+GP1mvvZVe9cz4K2fvLlckjyFjYtWnXShfzutGuyCnh57oqPxoEN2yPdyPGEDXIW
         zrZc54AJr/NzfkBigHcdu4CPcCb+KLunBM51/fz/Q3g+5jpFqWmS9NtbfEKNTkl7HLgB
         dbfw==
X-Forwarded-Encrypted: i=1; AFNElJ8+jBwQkym1VOoJHTfhGR0gIl/031TjAHZSDpc2KZw4bVBI8AGYiCenFuDdQJWgWRCG7vXbTpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJtttPnyE1AkjR6evc9NTVothHd8fO0/EQwCOodkWf0XycyQb
	mI+qAWjnLHzS/81OSidjvrnB3hiunLY6RRxE6MyfozNudqia9V8s9AiiemngS8ysw17bxj+6w87
	mbDrh8om7X0oO2NHk19wCPinpRQ8Jjj7Q3QBpdosq6ratG4kgq+MALruU3w==
X-Gm-Gg: AfdE7cnlVO0PfC9vGrAA3k8YKMpzAPgk/WJRxzaqI2ECM8phw94LthUgiXEJXrWhhPV
	KWRxRNLNFSgno/C1EUx8ClMUH/M9GMDnhLLr3/dex9imdmKOUOLNBXEeaOzWA0JHrkm95xdjbEA
	Imlp5m1bpx1trBY8K5a+wvJe40KNDCCaF+l0u8qaDIFxG/ppPquHNpPZrJKH0CCoGnZnj4gH5S/
	d8+7dtXMHbI87PwXhWEc5bD4ZVRMwvlAxbEpjWX6cVLy7y7JeCJpFZkMpii3ljqt5fR5Puq22ow
	JLPR9TfPTZs7g+XXKSfnW5lNbv0lpCEO9ZR9w1wTj7gRbRy+ycahBPXl9v3WMgq9HGXV3W4Yll/
	gviLZry0Jzh1pi8XU768j71ymF7qm6cF4
X-Received: by 2002:a05:600c:3550:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-49249083bf1mr121077925e9.3.1782081091016;
        Sun, 21 Jun 2026 15:31:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3550:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-49249083bf1mr121077755e9.3.1782081090605;
        Sun, 21 Jun 2026 15:31:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm18451019f8f.3.2026.06.21.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 15:31:30 -0700 (PDT)
Date: Sun, 21 Jun 2026 18:31:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260621182119-mutt-send-email-mst@kernel.org>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300932-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC2396ABC23

On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
> 
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
> 
> Race condition is considered for tx path.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

thanks for the patch! yes something to improve.

> ---
> v3:
> - remove the confusing comment
> 
> v2:
> - add the Fixes tag
> ---
>  drivers/net/virtio_net.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..6e099edef6e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtnet_sq_free_stats stats = {};
>  	struct net_device *dev = vi->dev;
> +	int sent, vring_size;
> +	bool need_wakeup;
>  	u64 kicks = 0;
> -	int sent;
>  
>  	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
>  	 * free_old_xmit().
> @@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	if (stats.xsk)
>  		xsk_tx_completed(sq->xsk_pool, stats.xsk);
>  
> +	vring_size = virtqueue_get_vring_size(sq->vq);
> +	need_wakeup = xsk_uses_need_wakeup(pool);
> +
> +	if (need_wakeup && vring_size == sq->vq->num_free)
> +		xsk_set_tx_need_wakeup(pool);
> +

why are we doing this here?
the check after virtnet_xsk_xmit_batch not enough?
I vaguely think it's some kind of race we are closing?
Pls add a comment to explain.

>  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>  
> +	if (need_wakeup) {
> +		if (vring_size == sq->vq->num_free)
> +			/* we can't wake up by ourself, and it should be done
> +			 * by the user.
> +			 */
> +			xsk_set_tx_need_wakeup(pool);
> +		else
> +			/* we can wake up from skb_xmit_done() */
> +			xsk_clear_tx_need_wakeup(pool);

But what if we don't have get tx napi so no wakeup in skb_xmit_done?


> +	}
> +
>  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>  		check_sq_full_and_disable(vi, vi->dev, sq);
>  
> @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	u64_stats_add(&sq->stats.xdp_tx,  sent);
>  	u64_stats_update_end(&sq->stats.syncp);
>  
> -	if (xsk_uses_need_wakeup(pool))
> -		xsk_set_tx_need_wakeup(pool);
> -
>  	return sent;
>  }
>  
> -- 
> 2.54.0


