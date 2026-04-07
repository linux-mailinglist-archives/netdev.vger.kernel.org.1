Return-Path: <netdev+bounces-276079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGeaJW0v1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BF3B1C59
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E13300212A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C953C276E;
	Tue,  7 Apr 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAAIRVkZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rkhyfNt0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B23AB269
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578985; cv=none; b=U08eMJjxKzW+zvK1B9vx/geoOnrU2bMhzD+PJhqU5LG5HtD4szbAvccMgfWIdv3CkabzQA4E0H7s6zrL+pddlY+nvLof5pjFHDFH8vqGijS4hBITljocDyUJZHoBbHY6NaPTM+8S8Ojw94TiAK7FcadcQUlgN6Z2QwihEt225mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578985; c=relaxed/simple;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq8avCijrVoYaVLeMkB79rypCYS+qY71e7D6daz5YO3iz9iJbrwVP6uWDnWkkBLp1HfvH2pdkJLNAHPno4M+R975a73fkOOrO1Ps9IvcohCX8+zfqbwfZFQEPP7OX1O/PACGknfn53UksWCuk2fqW3NpO92nljfT0L1WHFWDZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAAIRVkZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rkhyfNt0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	b=IAAIRVkZ9KRCN+WREJaDU0SdEV73KpV/fzZ82XvRxXSLWkusULW4zKcIdbmwHYiQSB8Zf1
	2oNFxzIsb4d5lCrtsDdPMFU9E2FHhaMQexa7uvs2wiy6mK2Qub3qdkqgtQH1y2kIt3CtY3
	lNrLVLMruQSP4rFAo48V6wP6/mUlAgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-__NifrDPNKK5BiFqd6DLUg-1; Tue, 07 Apr 2026 12:23:02 -0400
X-MC-Unique: __NifrDPNKK5BiFqd6DLUg-1
X-Mimecast-MFC-AGG-ID: __NifrDPNKK5BiFqd6DLUg_1775578981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso10110935e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775578981; x=1776183781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
        b=rkhyfNt0DhhexR1fdlfDmdC9vdkAvvXrdHngl9fGv7ESfGJoaoWtC+ixm4G/UCWpkJ
         zwW2k5V87Qyu2ujp20BE+Pu9oEx9wxOM/5T8ecZxOxn/oa33eoqH2NUfYilRB5cIoN/N
         IXVsHhV1bgj8AjZow9120Fmr1ZDS3E4JvO6G8EgepeyRjLpqYvH8gIONBUeJKuuK+SLs
         ev8vdQ4DN8dj1QkB73muNyOWvS/ctfzlVf5QKcKxlGkXjvTtU4l9REG9nc5G3zX1zbfo
         iaKKHLxMuNwfIAMN22CPnI/2SQH83gD4f+87oXdOszaJzIIevoCpswL4x+OBhVpV9VPi
         /bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578981; x=1776183781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
        b=PFhQcnGUN5EZllULVKN3Nijv2rD+UQGGsCg0ODo4oSWTMXVcEd/RU+SladkBe6aeEB
         RkO01PdxYkof3HXw0Ze33M7siCooBvJHWJgRJgc3jMC7NnNJhQvOb1LHsp8pwcQ4G4VU
         9SM1Gsxlzh2stzsA51uLjPOMiEd4I5oeyZG/hjyk5KKHXUcxNfjKi4MyK+z3C8RD5DPA
         P+hP8fjgIopLKncXeYooSFUJNUoH8c+sHF2XDCLUaYgYgzSxV5o9jibsaqp5ogrV1XYm
         zBZEz45ioAze7K1yg9fY+BkZMgH6VwvsQkOrtoiy61G0PtT9Ot7N8CSr+V6Ogw2OG3Rw
         0YeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJwbOrqZL4bfmc/1MIIscblT840gaJwrUdBs2QQr5lPl5gF2e0CUxjYUf8GB77xJ5jB+sEHWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbFolxg+QA3/TFh6VYBmQyJsowttksZRBoumN15N3k599r9Wi
	eAvsCbesQN+eNUw8vw3ftwoWSZ6GSq+LpVeNwughbmuNg8PQwrCV+dNbsomf7jTkrA0+QVhXTy2
	PcIu8XWbFuBw0radZpa28ORdgoLMkjbqFwyagXArf9iLxwi7wjm4WGJ3rRw==
X-Gm-Gg: AeBDietNurGzgGfq9lLcH4hQGmPDINWZ2HO1+MDGfx+y4mh06EwjgRCubIwVYvzS/Mw
	wKXlcWhUpo/4GuLanCdjRBClbiA3lR9BL/8OUWuaxNmpcs4YfkAS87tUS7UBFm/9lIWbeG7vtpk
	/igsInfNGY/hD6Sw/GCLol7pXYeZgCrZYODPnfmrxj0SiReADrSOe+QFdfgFAOYfXcAZZyEE5VG
	njEzTIjEXBnd9OdJCRfE1GQ1TnLzaRIU1Brb+r0Qs/o/9sVZA/qVfY2EaN0ouGHdgLwGlufxaQV
	tmcin04nGthyR4pdMVCNNoSERcWp7QtBWnlnLy4KFEfjSbdXKxqhVb+CHDbcgmedk3t8ZqGbu9Y
	eKhE4CespYuInwSwh4TlESexEtMk=
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226451035e9.2.1775578980897;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226450755e9.2.1775578980501;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm60518000f8f.11.2026.04.07.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:22:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvRegULccN0hiL@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <20260407121515-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407121515-mutt-send-email-mst@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-276079-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 384BF3B1C59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:16:27PM -0400, Michael S. Tsirkin wrote:
>On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>>
>> Remove it.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>but I think we should drop the Fixes tag.

ok, should I send a v2 without the tag?

Thanks,
Luigi


