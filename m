Return-Path: <netdev+bounces-280139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLbmCfiE52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:08:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B043BC68
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DBE73019392
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE483D6CB8;
	Tue, 21 Apr 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhXBuw5N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhPHT1W0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1563D6CD9
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780474; cv=none; b=Ooa0txaRk+QorbuQJkKD7s5Fhn3cv/djdT/xM14OxJ4G/18XaZ2AGmf7tPkGdGK+MwQykOWHxLWBYRNEjnH4TBXaA7mx15mppthJwPaOn8iJfKCnsaKFaCnzBiBsDDF0SU9Jh50fNcGoA1sVHP7vQ2Lfip5xmIjLUvhQay326ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780474; c=relaxed/simple;
	bh=4tp5roH/Z2qH2r2LvKfAcasyhBIhUWY9gp8glbVhxqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWYrI7HP5D0xfIe/aMjXiTY7rn6GgLVYNAEagw7D1UxtO9J1oJezAP1ORsnyowbtyq7DK7Yjlh9n3NV7bTVhEgF+5jzefHv5b5DSrOQZQzxR8J03HRCQthNnbmOghnm8fcnkP1sfRWPk4/HrGAOpMAc6K3mdMYn6dIYJ90icTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhXBuw5N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhPHT1W0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776780472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSScIqUsHMAHjVaXskG4pDzLdBKGemYppx+/o3rX1/w=;
	b=MhXBuw5NZGSIACw6GEhO6xa5WxlZ/zdX5lOLEaVoB/3Pz+apZV2t0uQ80qbvGmD5bUaDJE
	2NfJGxoF+ptYBlXpLDhNk70c7NceZY13vBKm4xAsLKvNneqhx0gxe7SMVKptis7lq0dYax
	7pSovCf85+LL1Q5kuLeW5p2b5dJ4qZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-ezPAxvQGNIyEPxOEzip6oA-1; Tue, 21 Apr 2026 10:07:50 -0400
X-MC-Unique: ezPAxvQGNIyEPxOEzip6oA-1
X-Mimecast-MFC-AGG-ID: ezPAxvQGNIyEPxOEzip6oA_1776780469
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c82b4701so24961455e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776780469; x=1777385269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSScIqUsHMAHjVaXskG4pDzLdBKGemYppx+/o3rX1/w=;
        b=EhPHT1W0WmDfZzQHgmye0J9qUnZHtECRx21lWien/NEcRBm2LRZdZOeO+PCKb7nToz
         vyE6m5b2jwkrhARF4Rspn5H6DjZgsG0ThV5t+V7jOON5Z7K+dguOjC8f5TGzeOilaDKf
         9uxomBmgyjU0CIKgHncUGlJY40oCFjxjU71CsgwB1L3KWsbY5xuoa4w/QRj+XVCRPg5d
         zPNn8jvvAyTuY4z5oeyyHahlE3RDHC0xkCMbO8JJ8xwl+CBtZRcJrkjxz3vrFVEyXA7r
         hDWM3rjz77xTFoxZTfc10gSaTTP6O9RaY6hcGNkg/bL8iNzhDUBNkaNoil18Q9oVA82E
         wZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780469; x=1777385269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSScIqUsHMAHjVaXskG4pDzLdBKGemYppx+/o3rX1/w=;
        b=nAuUxhqG8092FRo2LeJ4QcsSZyEeZOeeB93FQem6E0ma57lJKQ5WRKAeHIcpva2c4s
         z+BFU9yH4lMXp/iRaZkvQLjRKDFNjUu95dd793Y3V1S42X5kZxBJefuMg4aifAWgjAzY
         xMG1HwWPakkpdTVkrz936MRA0wFndoYGQiudXbKZdCQFtGN9G7qFMwyKTxxIc/zT3/fs
         8z1kL/JRxUsG8sfaxj8Seoyjxarz0nymwIXZY8xlSp7oGMPp9lzuTkFPOyKUseDL7XrL
         Mv5EgMcKP6oPZSr4RY5wAx5kMVgsax9w053hJ59mpxQlzezsgWeeagVFlC4lZznHsylA
         1LTw==
X-Forwarded-Encrypted: i=1; AFNElJ9r491lpY5J+kjotBWxi5VKBVoHJ5oWx8PiJwDdO4GRRAdsIBYW3WFxsTQth1S4FVg29jp9OoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/cobrsKq2cfJ1e9HWU2iYDr46bul4a8c7YKnJVdWfPSMfiXP
	g4xw04x8hXCJTwKjYPYyH0mRkIoER35I1+vn5v8jcgktM84uR1sV/RazxawvM4kCFf0nfIdYbzR
	0nIKLTBrf9u3qDCXQC1ErP0NhABcno4iN/A4w06LJ7j0uyQKFlap2yudgYw==
X-Gm-Gg: AeBDiesbE9fj4CCp6CkTD3vUhGucl8jvRrOAEVHqwoMteCsooxSz5f8ebfDEkp+6zjj
	vdD5XDdyxOmg5+6zng3MxUQx5SpKJP+C+w7rTqU1d+bOfiPqgBLplEnPzuCSrjbUcsQjpiGpX6H
	htyZ1K/+/+sV7gEwi2R3cK+Qg+LKIeZng1ucnzZSogw9cnoFKNsakSMn6dLJPJsuCqFpgZGx6QS
	LvFmpkytScycgi0mhCeCjZDvML2kNk5n55oDj+jTNgNObBpUEBFVS75OfxfEs2RQiGvFPRi1kmM
	aqxOvlQ6HfvAUUXx611ZjVLP6XAIQYxF/CEYhFoyeBND+5TB1JIAo3iuvyPb/d7bNJVukt8nd3K
	VzueeKZLtfDVZWReVFiqLNrs64gz0CHN5hwqdXyV6M8igUxJjHK50VQnqBe5GJJi8da7jaYfJDG
	HXoA0udw==
X-Received: by 2002:a05:600c:1444:b0:489:1c0d:c9cb with SMTP id 5b1f17b1804b1-4891c0dcaa5mr101015735e9.5.1776780468808;
        Tue, 21 Apr 2026 07:07:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1444:b0:489:1c0d:c9cb with SMTP id 5b1f17b1804b1-4891c0dcaa5mr101015175e9.5.1776780468295;
        Tue, 21 Apr 2026 07:07:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm36524369f8f.33.2026.04.21.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:07:47 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:07:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stefanha@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <aeeEXS0n3VpM791Y@sgarzare-redhat>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280139-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B5B043BC68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:35:12PM +0200, Luigi Leonardi wrote:
>parse_hostcond() uses get_u32() to parse the vsock port into the
>aafilter.port field, which is a long. On 64-bit systems, get_u32()
>only writes the lower 32 bits, leaving the upper 32 bits set from
>the -1 initialization. This causes the port comparison
>"a->port != s->rport" in run_ssfilter() to always fail, since the
>corrupted long value never matches the int rport.
>
>Fix by using get_long() instead, consistent with how AF_PACKET and
>AF_NETLINK handle the same field.
>
>Fixes: c759116a0b2b ("ss: add AF_VSOCK support")

Can this more related to commit 012cb515 ("ss: change aafilter port from 
int to long (inode support)") ?

I don't know this code at all, just asking.

Stefano

>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> misc/ss.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/misc/ss.c b/misc/ss.c
>index 14e9f27a..6e3321ac 100644
>--- a/misc/ss.c
>+++ b/misc/ss.c
>@@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
> 		port = find_port(addr, is_port);
>
> 		if (port && strcmp(port, "*") &&
>-		    get_u32((__u32 *)&a.port, port, 0))
>+		    get_long(&a.port, port, 0))
> 			return NULL;
>
> 		if (!is_port && addr[0] && strcmp(addr, "*")) {
>
>---
>base-commit: e0517e612199cacaf2dc4d54cbed52deec640c94
>change-id: 20260421-fix_vsock-40c2ef4928aa
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


