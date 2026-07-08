Return-Path: <netdev+bounces-305898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnGnJZeBTmpVOAIAu9opvQ
	(envelope-from <netdev+bounces-305898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A57728F51
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:57:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CR4kgh28;
	dkim=pass header.d=redhat.com header.s=google header.b=S2ZogioL;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305898-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305898-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E897430A8E89
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A244213B;
	Wed,  8 Jul 2026 16:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1A43E9C4
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:50:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529420; cv=none; b=CD88171qtL9lYsX5T9hNTZzZAqrI0/yUFfxvaTiJtvqyJybFl5shq07e7yHImD5J9eWxSObayaKZ81AyROrYeDe/cynXZ3gfDwz1rHjHmELmSMS+8TrAYVzChJy4u2ndrxBYfyTvWK/If98We92VmPmQG5p5SdeRrg7igyz1rUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529420; c=relaxed/simple;
	bh=HEXCS7+2myohc1YZaELPgANH9OaRCUzaJ5f7a6XuwhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POslLU3XJtpQestvJlkbGyPLspo4M17FnDDTIQFSc26IDEVmeJGbeLV2OrSZeEYEh4MG51gu9o+ioTDe0P8R3+9QRlyZzt3ZAIzhkmeSSlOnU5QaXzHswNMfNnf67at0P25qsyvXBgCWbaieDpAOjEgMu1dDWISVN/f+ObEKkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR4kgh28; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2ZogioL; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
	b=CR4kgh28GW2JJuQiQCOVOVDhBPPPsmGORpuY/MW4mG3wuiv0heukWHxKbFlw/xkVJDtt/T
	bKGnoa385Lg3sZvqbdRCx1HcmMSoZk08nIhLhBns/2aGWhjzszl4dNOuJtzVFHrd6h3jFc
	cHnaDydv4JPObgpL4tlCbJZmCHtI9as=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-n3j9NmLvMcm6CbgZOvWXTg-1; Wed, 08 Jul 2026 12:50:11 -0400
X-MC-Unique: n3j9NmLvMcm6CbgZOvWXTg-1
X-Mimecast-MFC-AGG-ID: n3j9NmLvMcm6CbgZOvWXTg_1783529410
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49244130073so55665e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783529410; x=1784134210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
        b=S2ZogioLkYQS9nC40/heiOWtv2tt+PBKqW9cyk5srBHMFR10DN1Wy7LiBG7QzZbs8r
         gRu6UiipzrgCGYvAjKgjTYNUTCZ3aZ0xPI8Dy7IRG6Wk/BprPcppjt5gGOHNkkcR/jLa
         gn3mCTT1OVtzNhfCyCQfRZvL5kl7BSl2qynNuD6lQ5Nn5PGiswMJsuDQcISTk1Q7B7MT
         nBCWwMo7VbhNVa7LyHJRsTd+G5Zp3MvEwMNttoJ36SHF0X9yXla9dcGYMPhXn37DHKzr
         qhL29zi80lzWVygg6Y9voFBqPAJ5Fa+pAZYVbAxa9WFJOfybPji9fqXEFQYThMihVoS7
         8pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529410; x=1784134210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
        b=L3Co716/zEHjbDM8zmgtfXPMNaxsa/gfy+r0/he4CXQGGZBwGUakd/w1r0kceGOOIV
         E+bts4fuOmH9XK54eUSFg4D7VyWaGBGYchU1/txWThPMDTWhmCz4gQZTSyGB3lSTfiNb
         WpdBtkMbn8l4RH3AG/47Qkwi6166C7h77O97LgfqClhZnVrfLbD4UwtNxAsYI2Tt1Z8c
         3Jw/cKvvlGOe5Lq70KLEvgRAVwvk+lB/dnoqNsdyFJUS35Wy2ij7T/rksoh7EuHgaXsD
         QJVsHXyuwVtfFp0CTit3unp+Jk7Ph0PZkurE/hPt4XUXwo1UGJIYXxAtryeo1dv8yv/G
         MeRw==
X-Forwarded-Encrypted: i=1; AHgh+RqM7TWWs7ieDPRGqIyCCYWSNNcYyjH4mtpPM8V2GJmnOT+FIQotRwg1TwhNsUidkVilC4qwfSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7xHXX+T32EoihXQWJAmkJmBAhsdHBNcfMkyMBfqYT+y0qUL+
	j1+UYbvv98rCfgdOM8dTLou6XBhP92UQHQSAafD1HN01OM82YMNevaCRWZAJhD8xy2cYnjCJc+7
	3n9q0MbIr4ikl4Ogrdz9dQyA9oSbtHOpUoT61SfK/xaQGbAcnU+XTgXRKRQ==
X-Gm-Gg: AfdE7cnX3tPOoaCvxtDtvsroPGrn5VmtB91afOKtlrC0b86r09MiAn1NS3b0tGwPxp6
	H66CRTflTp9PSCS8nYH4n34dBFmBZOp4WmDlApZOOQ8KE3RZpk8Lh7iArbi+3puK/eQslnHDa4y
	pCBasZ2ULqGJaHfYy4l9RFzQJBozlzpw1krmojzjIyhVYYx1GLnaV9KoSrw3wHdnAx9IQ+pfC33
	hhbDljo8/n14ShMGUa/eism9Rnda1FJZuZF+7UMHjowiX1H6/gc3tvuekZ6MTtjMiKegt0xRtDo
	g9x0wYSoOL6DR4Vc7kR3AT6RXH0E7hq5IndJMdjpyN1IQJxPaWRbuGaRO5LOaSM1EqGTDFCQXoV
	hfhQ0OQCEbopBG/Kpk38nUDaxcLSTjpML
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880575e9.4.1783529410059;
        Wed, 08 Jul 2026 09:50:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880225e9.4.1783529409552;
        Wed, 08 Jul 2026 09:50:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm44408115f8f.22.2026.07.08.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:50:08 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:50:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
Message-ID: <20260708124901-mutt-send-email-mst@kernel.org>
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708152242.2268848-1-enrico.zanda@arm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305898-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,kernel.org,redhat.com,arm.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.zanda@arm.com,m:jasowangio@gmail.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:nd@arm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9A57728F51

On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
> From: Enrico Zanda <enrico.zanda@arm.com>
> 
> When vhost owns the virtio-net header, i.e. when
> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
> meaning that no header will be forwarded to the TAP device.
> 
> In the current vhost_net_build_xdp() implementation,
> when sock_hlen == 0, the gso pointer can point at the start of the
> Ethernet frame instead of a virtio-net header.
> This results in a wrong interpretation of the destination MAC address
> bytes as struct virtio_net_hdr fields.
> 
> This can, for some MAC addresses, trigger -EINVAL and return early
> before the TX descriptor is completed, which can stall vhost-net TX.
> 
> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
> using it as a synthetic virtio-net header. Restore that behavior.
> 
> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>


The fix looks good:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko thinks there's something something security here, but I think
it is misguided. It's just guest hurting itself. driver breaks the
device it gets to keep both pieces.

> ---
>  drivers/vhost/net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..3e72b9c6af0c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -731,10 +731,12 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  		goto err;
>  	}
>  
> -	gso = buf + pad - sock_hlen;
> -
> -	if (!sock_hlen)
> +	if (!sock_hlen) {
>  		memset(buf, 0, pad);
> +		gso = buf;
> +	} else {
> +		gso = buf + pad - sock_hlen;
> +	}
>  
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
> -- 
> 2.43.0


