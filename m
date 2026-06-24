Return-Path: <netdev+bounces-301767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g0jYCwQ2PGpClQgAu9opvQ
	(envelope-from <netdev+bounces-301767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:54:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846186C11D8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:54:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OZjT31w4;
	dkim=pass header.d=redhat.com header.s=google header.b=swPeArCF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301767-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01C3E304F225
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638863CEB9B;
	Wed, 24 Jun 2026 19:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE93CDBC0
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 19:53:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330829; cv=none; b=g5iIia0+NZ4HSZxnVh6eay1qBTS3ZSHfWIl1U8CntGJDizeEdHwq51WTsz+l0fARHzaepQihstJwkyAF8YnX6xQ+3f9BjJQNJ/nEUFimZJAhWZC/P+LPq7wyHtPksZek0qTHonphr6hK8CzLuWyAUQauf7LUsLr+5hwzab3ncIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330829; c=relaxed/simple;
	bh=0sw9vdmmHIrg289S7LBhBP3TAeh5HlhPIfC0XvwKSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeA+dWoFuXKamVRuU3h1cEryUDDW6lMz4zp7DDS0seESHIt6feh4pA83vcqVXe5O/ULvjNWwyd48wQ75d9ZCXbsLb0Ob9f/wiTAfYkEBT1dBU+m+PthLR0S/6tlg4OX0fv3nnX5LGwRmazMF4F3zLTezm4Cxm0ZNIViqBSk0uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZjT31w4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=swPeArCF; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782330827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
	b=OZjT31w4T3Df9mAnHts2uNCc8bpuSSl+fa91lrXjNDaQEf3ygGjRjO0tiXGgjNhvJRWoaU
	rm2T+ERxQMHe3WoLI4fGKkjX6AU6CPOlEM7MKMySP240FPOg9fMlia8Sa3TJmFFSh69TmV
	SHsdRkUu1efdq5FBhdp8gGltGQOcoh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-ilIiAPJjOEaCa9q8WJN3nQ-1; Wed, 24 Jun 2026 15:53:44 -0400
X-MC-Unique: ilIiAPJjOEaCa9q8WJN3nQ-1
X-Mimecast-MFC-AGG-ID: ilIiAPJjOEaCa9q8WJN3nQ_1782330823
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a060eb84so9015205e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782330823; x=1782935623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
        b=swPeArCF1ipP67Vhjm78dHJ970rMBZ00ss9gJc1WKGlq5puf4NXjOqoPkHLB83YXLK
         vRtIHq0X3w1xngyrq6fRW78+AG1y+V7X2m7s4Jw0e8PMnYwA5ccU66wzziJVV4KyLCYT
         iZYxwZpUkVrvd/koVWHs7CAaZBFsPNRXAafDiF/tcEZF24zSV+eGADhi8eGm8fjgXW9L
         OHfa2E/rbmcUu0EySMu6AOdWwV1DQI8+Sl+XFpBXi6gSlnK4pd2Vhf6EsRbDdMXFoIwR
         oHQVdeHLHTxeX49D6ZvXIwl6W8bJ2JCX3Jg/LxtraEO386fWmKRWLPyWDYBNWsc3mKdU
         K8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330823; x=1782935623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
        b=HlL2a9t+4ZDCk9/9z5o7MjeSqu/sLgfzTol0/++drnVtJ/W0C5APi3rIqknb0/Lyel
         pSR1rmdt2VkrmzjFk854rMyjXJjTBzucyBr1EYSX/nPgkPX8K16YJRTXyLliVvteypvY
         UsE2MC0sHphXALoHfdMAsXxuy1ab0MlB3AfvzkRy7iLKymdKtgVF+FWRx4KwU8ipXR4O
         /D3VQikIUD4dRY7AOJY3Yx3/Nw/qwSwHf2vG0lwbawUg1nhAMNGc2LkZbHUyiUzpgmq2
         a1kRTFVsdJCGiVDg3kznSnAhjp0XPZozs4thS8grgV/pkPYcRUDEMaUgzaxpxGxpwJhY
         EUJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Tj0aT8KPQbFz3/3Lktgso/WnVziujAC5DlLbXicpb2a38PLkfEIrs/saZ9CbcNk3hXtqDhJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDA6yPt8FVgwrG/dvy73PNNNF1xW04MPu2e8uGU7yDkl0okchJ
	+V2yAsgcHx4aWCxlqx3Ijz8NyynIjpVk/aVEXcXdnQ7a+hocnei73qhosLiSfc4NtEhQddwPz/r
	YtvGYOlsoHX0YSa7N6mIT2MymU+VakU/EOkPrunwAoG3HOSQf8bf8qsVib/buBkiLig==
X-Gm-Gg: AfdE7ckSO8mCneG3MQpopjz2eghwMCJ7+jWuCNKoV4uyOelZ8ADibF6vAzRk+CAQ888
	GKHLnQfXIM52MLpG4QmfnbsZ0IT43Xah5dturKUZTvz4rtqFfB5T2jsGNFUwD6CFfKq/55wE/iY
	pYVmUGwC1Q+Tpnf7DcJsRET1U21ZbtVPdaXJzryDS2pXjByVpP130wJLD6cc+IsoTjU9S67kVzw
	miQWC7cm0YHzMTDnWE99LWoKaV2Q7APL7Nsyuc5cZl2CCCz4DATMU4xQfyXMF0/0MHR7RJb3f9P
	qISF5bkWMPGEGabnwZtDwHLNKQbsfyuzMoFWglm+wDzBnc0jzrpUcCV8L7HgAQqgwjuew70m0y2
	lGoC/sl3OVIUTo7pYD2YQ7niFlaEyosV9
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134949985e9.10.1782330822570;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134949745e9.10.1782330822030;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264011d5fsm16636315e9.1.2026.06.24.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:53:41 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:53:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Message-ID: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624190653.2893-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 846186C11D8

On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. If that addition wraps,
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the page-count calculation.

You should add "on 32 bit systems" - I do not see how it can
overflow on 64 bit.

> Also make the
> memlock check subtraction-based so a large page count cannot wrap the
> pinned page total.

I don't see how this can happen at all - pinned_vm is in units of pages.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/vhost/vdpa.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..090cb8693 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
> +	u64 pinned_vm;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
>  
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	mmap_read_lock(dev->mm);
>  
>  	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> +	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> +	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> -- 
> 2.54.0


