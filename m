Return-Path: <netdev+bounces-278028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLPSDEXG3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619A3EAB1B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 885DD30046AF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CD30FF05;
	Mon, 13 Apr 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV2EzTCO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJtTsRyd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D82D8DA3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076262; cv=none; b=n+wxUYR/iXF7E3M4HRogktgeCfiRSgjJq5htN/moa85659ft7es1N+dGTXjpxMit8eQVAG2nZN21f2hB6uat8BjkQq3vbrc2JnL1qTBxoKBuAe96e2Hsr+dPT3LLEQ34tAJcJx37ef9A9ppDJBXBYoVvXsFlhAUS2SVMtPjdUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076262; c=relaxed/simple;
	bh=fQ643Lv9J5G1foV+9PbsCurOJvsBQ+fx5gPlGfwiTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bijk8db+Uvb3Xrki5cKfquLukQIBy/NWv9npaKeLpaLNM7nH8HJLl5b+XvrSMgDNFMcIzFfMtnPL4mAksdLeBZFmg+KnKj3gxO317p7SPhJabK4eVwimcqglo9XDD9VcQ0NXKU7LxK1N8WAsRSMs3K+0HPI4DudCr0GyWPkawpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GV2EzTCO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJtTsRyd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776076259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeZdU2EOKDcewPx9OBUAInxEANs51PIGwZCoG7TPO40=;
	b=GV2EzTCO8IYQnWzRbqGJgl2e1FqQscEkd5PtQecve806qRG+/qk4mqavp3AnVC8StBb1ST
	80qstn+YgXy6Q225eUyyXfmYR5gyY3V+Uy8b8+h25qqdfvQY4Jcef2XG6TU3zeW5QzYI7B
	r6i/WjVo2BCLUfG9qRuFMfBlI8MQxn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-FmKnIRF3Nj-QHMWYcD_m9g-1; Mon, 13 Apr 2026 06:30:58 -0400
X-MC-Unique: FmKnIRF3Nj-QHMWYcD_m9g-1
X-Mimecast-MFC-AGG-ID: FmKnIRF3Nj-QHMWYcD_m9g_1776076257
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso20869755e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776076257; x=1776681057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeZdU2EOKDcewPx9OBUAInxEANs51PIGwZCoG7TPO40=;
        b=eJtTsRydLu5D/wKpUhH2bAAjMhyh2allhw2Tg4e4jkyOsN7+BNuRlb5FFAQWwYDNKn
         8zS35aBQQ1jEI3Udc2bQMCfasq7Y1RBznymgEfIsprvP/sk1d2OByyucpjmYLiyZ1I7E
         7u3VvHJopaZOikrjIiqOLtfP7C23dUZGEosVf+SWHxsJo+NTfEYwkuoEBVYVrwL0mC2B
         qOm+mIED7lf6thwMA7p0JA6PYtLWaZWSTPGBRfi33/QyrtS+jeu+McUw0Xz02yFoDGD0
         uV4o12+EpKnLbpxr8dlzjpYBBy1CVI/vuZ/Dwm1nDyAspe7YUMXyoVPD6Jsmlu/M610m
         v1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776076257; x=1776681057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeZdU2EOKDcewPx9OBUAInxEANs51PIGwZCoG7TPO40=;
        b=EEmZAhKqFsaYKsGBiIXtAOSIwH6yCknBHbHuv6OoNTBXNXUZ2HGAR5qy7bhXxQOY63
         ag0U7vmKiYe9d50/4pgRe3w+CQK6o9zqJYZpBHCX1Derse5oBhikuMz4E/16l2Qj/hI0
         BNHw+rPzypNXDGZp5Asu+L+Ah1fYt+iZZzWMCn3cXkACiyLHnVZ26eWOZZhslDSkUhbT
         t9wjY45+n6B1yPpfQNCk/JNuQ8ns+k3xzOw6rL5jIzy9s4jBevZutmsg6Ui3CcCEdXpn
         AE52AKfbiletvvjW6irBuF0QNBaRQPKPvVq23sTc6J7o6IOdXCMIdYQKAWuStKUwfafT
         LUpw==
X-Gm-Message-State: AOJu0YyReiksbSFor2vDZfZnpua4PCPloOvMDXuGTlESLqq5kpEgjsIt
	QxVw422YqDB9vBR0HmLB/vrzd1utIxmJ1KwhYC63GKJNGDYTgtp9XKgL4VTA4o+CmgPBgRxvu1V
	qwj8SrrL0s2BXYnqUnSHvG4uQlL1tGgZO0jEurWQRK1Ln8jTK2oAO6USNkA==
X-Gm-Gg: AeBDievvFdHNgQy+d9CI5ZmO+RKQFOjaif1ypQkcMA/SE5UhAq3JR8rmsLTdDQFBUl3
	3xlwkbnBdbI9qXn6iRQfVlR4yJ1+XCjulyyyjZd0w8aTRthc7uueePVla5vAvcdpqxrUyfrYSSd
	uxB543I/lLcWI1Ed1kI/w4ZUMgN8x8AidIj5ZW68xleB4puzbevsdzwdo1GBKJkccIbGnKNJkuY
	hkE4C5xhB/Ix6sgcrBniU8HP5R+dyUhtE/N1R5U4BUV9OWmv7lbZpZuvEVA/eGfcjdBlvNwoF5P
	xZzMVkaSQACdIxKCyfPwxOXD/TMKqqHmY9wM1GQJ6ifRIzVkOMjxvRqYz7UizZLtfaZ84CZtyp8
	qaBoUuED7FHc/fJFW6R32M3iUYzVEvWmuFKj9XMUk1RXdMNS1bdwy3TBmpMm3VngmFpsCtLU=
X-Received: by 2002:a05:600c:a401:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-488d6839be2mr137846915e9.9.1776076256840;
        Mon, 13 Apr 2026 03:30:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a401:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-488d6839be2mr137846655e9.9.1776076256355;
        Mon, 13 Apr 2026 03:30:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e51sm185534185e9.1.2026.04.13.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:30:54 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:30:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, mst@redhat.com, 
	jasowang@redhat.com
Subject: Re: [PATCH] vsock/virtio: fix accept queue count leak on transport
 mismatch in recv_listen
Message-ID: <adyxVoDApCYpDcLL@sgarzare-redhat>
References: <20260413085243.73200-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413085243.73200-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3619A3EAB1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 04:52:43PM +0800, Dudu Lu wrote:
>virtio_transport_recv_listen() calls sk_acceptq_added(sk) to increment
>the listener's accept queue counter before calling
>vsock_assign_transport(). When vsock_assign_transport() fails or selects
>a different transport than the one that received the packet, the error
>path returns without calling sk_acceptq_removed(sk), permanently
>incrementing sk_ack_backlog.
>
>A malicious VM peer can exploit this by sending repeated CONNECT
>requests that trigger the transport mismatch condition. Each such
>request permanently increments sk_ack_backlog. After approximately
>backlog+1 such requests (default backlog ~128), sk_acceptq_is_full()
>returns true, causing the listener to reject ALL new connections with
>-ENOMEM. The only recovery is closing and re-creating the listener
>socket.
>
>Compare with vmci_transport.c and hyperv_transport.c which correctly
>place sk_acceptq_added() AFTER the transport check, avoiding this
>issue entirely.
>
>Fix by moving sk_acceptq_added(sk) to after the transport validation
>check, matching the pattern used by the other transports.

The issue seems legitimate, but this patch doesn't do what you're 
describing here.

Out of curiosity, how did you generate it?

Stefano


>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e85..29e1d9833be4 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1,3 +1,4 @@
>+	sk_acceptq_added(sk);
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * common code for virtio vsock
>@@ -1560,8 +1561,9 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return -ENOMEM;
> 	}
>
>-	sk_acceptq_added(sk);
>
>+
>+	sk_acceptq_added(sk);
> 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
>
> 	child->sk_state = TCP_ESTABLISHED;
>-- 
>2.39.3 (Apple Git-145)
>


