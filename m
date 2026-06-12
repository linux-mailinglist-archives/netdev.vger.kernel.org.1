Return-Path: <netdev+bounces-298703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v2iKLvwcLGqHLgQAu9opvQ
	(envelope-from <netdev+bounces-298703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B087867A576
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M3WOkHFX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0257300292D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AC31B10B;
	Fri, 12 Jun 2026 14:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E97283FDD
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275894; cv=none; b=OWGZx/nQ7PcmeGD7dZVDCMwHqg09oZfqCQGvhxaGa992P7E82G2Cm4wzYLihjcZu6tJJJEPfUq5wgCKzRGMMRIXFppUDpRp/G5Ec5gTRZGJvzOVVKE7ZsqY8a3GKGAUHCBZWNrJKJyYungyY1dbr6uH0F1WxAP16vRJl4whFVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275894; c=relaxed/simple;
	bh=7oTdwQB7busn3pIYd7uITFnQgXBQs1X1Bba/eQqqVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKpsxyS/NKsHG9hP+ZthF4gNyEegjJsGrhy7cOvCMevCrY5yKXinAx8bB5bWM58T0Twk1LrU3KluJZcnkKl33RX9DMEXGlJP9caZmwm6HFdgDqdlEfu91n6FYenkzv7eMdS3+J6tjT0HKiw2maFaG29ChgKrr00WXRwX9b54KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3WOkHFX; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so800199a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275893; x=1781880693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFB+L8FiAJWrQfjsmsxH8l7zj4U3yueBuDW7xXAiJHQ=;
        b=M3WOkHFXvlj8EbFk2lzl8R33lJj6caKn5G738v1XG0tOiZATPSxR63HjY3miXO6nkV
         OUY5CeT26RFLOpbYwmNyLinnIBgL4RIne6x0xft9OpDAQglSidpAr6hsIWgzVXWMyro5
         wHmAcZowI8bngsisSPRzO/Hcu7h9tCy4f1YctoqosM8G1Nq8YNvpGqqNxZNqcOzzwG7J
         JoF40G61BeIYZTGsDfhdWi4LgxQC9Mb9jYcckTbwoNFcxl/DSDRIN42SzpgdApUe603D
         ignxJEQFLXGAZZAZNtBgpz9b85jXHaREKgjP3QHVl1PnR0P1Q2UZwP44nUVDosNouhZN
         KliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275893; x=1781880693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFB+L8FiAJWrQfjsmsxH8l7zj4U3yueBuDW7xXAiJHQ=;
        b=HGZACGpeB7Hww0K/n+65OCgXcYyMM0ORB0ablAtEDl/S2Iqa+2JdfJE/3E58Y9jMQg
         rycu8rlbS5y83LvIqHIFNWCNDRbQ32KQGuvdSql652Xyj719+TSU4HMT2W4GBfmSWJmv
         G9cwj1m8TCYZywKt8hxiF/cBF/FJglmQzcczrrTXLaB2BDrAT0FyPrpuqiNWlLDiqkem
         5IgOuv6ZXfUEB69R0YNI5Ft6MTedAP72ZSdaJOXCUuiZ0sZVibhGyjcOtbhwyWiddwiW
         8RadnHrUGSHs0VU+p5NwmizzDdQyo3HEbXKkT54oXPkhO2so9NvkSuvtgqC1SjoPRzv7
         2IIg==
X-Gm-Message-State: AOJu0YyUalzJypt8eVye/cINMIYb4NqpMzO9y3LecJ7Ayds6siZN9pWv
	SQEPo1hphigysxI+QaILnyGX8TZ71Ai49vOUI0yT5Xgo0130AnlkGNty
X-Gm-Gg: Acq92OFYNP6UMhg6mwd4UEXy0GAM9Yb9qDuhb2zbGorVwCbXCF5BG1JAQcF79Bh3ZlG
	SZGUDgvDz/wlTIL6azJPMfIgaM6d95fF2jwi6HKV4Cd9/i4sxXRRpVCjmFW+Hx6Ya3Cm40LV3PU
	cFjJZNHUUb7D6/CoKi0782zg77GX1e3DG3v8lwiTcxVmQOAblvEdLtx2XsjAEOUHqZyXkiKx12f
	AZlAKaTbDJzUE04HVVnSaHlpJjaCvzN7R03pcd4xrsFWh+7Jg7/FX5Ka6f92leIzQqgURS015LL
	jsaHU7wwM1vBdBVYER8dTSbOAqhtb6cn8Uf8Ing+vCO7ETSkhni9XO2F0qfrli9oeXJu9u5veSI
	8F+AbsWqanyLUIxqCPCLcItrxMACEt8ZoI7Dke1MI9Mi5o9BagD8zcBZiZCRMeQ8Xr2LJdTxHyk
	sfBNb7H5S2kSufbkH028sjodL/5uyRjDZIIVMx7W7mNkAa
X-Received: by 2002:a17:90b:4d08:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-37a035ed628mr3288310a91.14.1781275893159;
        Fri, 12 Jun 2026 07:51:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a20dbd301sm2453885a91.10.2026.06.12.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:51:32 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:31 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiwc87mKwAWu2eJS@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298703-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B087867A576

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
> virtio and hyperv call sk_acceptq_added() immediately before
> vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
> itself so callers cannot forget it and the accounting is consistent.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c                | 1 +
>  net/vmw_vsock/hyperv_transport.c        | 1 -
>  net/vmw_vsock/virtio_transport_common.c | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 6cfa89b6f3..24916dd4e9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -518,6 +518,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  	sock_hold(connected);
>  	sock_hold(listener);
>  	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
> +	sk_acceptq_added(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index b3394946b2..0de8148877 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  
>  	if (conn_from_host) {
>  		new->sk_state = TCP_ESTABLISHED;
> -		sk_acceptq_added(sk);
>  
>  		hvs_new->vm_srv_id = *if_type;
>  		hvs_new->host_srv_id = *if_instance;
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b10666937c..4a39d48db9 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> -	sk_acceptq_added(sk);
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

