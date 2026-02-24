Return-Path: <netdev+bounces-260559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIQGKWS/nWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:10:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7F188D5C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F1943054662
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0A3A1CF2;
	Tue, 24 Feb 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3a1PE79";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qtAZPZRs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4153A0B0C
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945819; cv=none; b=JiXBR/v15YoDVeUfLST41FJGiYsoHDwZ33oeLAX/GkjlpaTzufOASRiIHFnc/gY2qFfJ1H8omwdlJIRZ4KIPNDY6PXwfwfasTDbocOPgepywx/sdWZvAV2c+yDvvSWp/VsrtCUSREC8KsoGZRsmSgreOs3ENzBqcCsPa6vuIlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945819; c=relaxed/simple;
	bh=TAyHgBBI4ob9tTcrFegG2TRo7EKXGQuXyNpp/MzDVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8sa4XsVNqxd2YyaZf8D2FhjrKAUno2UYKaygH/1L+m5NqwTrD1Ti9MwJ1NS3pLODYCuReBXRgw0UqUzvs5dbAoyPq0rF+xBlbRHLyYfn/P87YiGhg2+SGNFqNVZBId7I/3G1VeiBwNGE8sq8oOXO63CznsZLAY2XKqFobVMV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3a1PE79; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qtAZPZRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCeOSff7eDNB7TgbEfprmGtaT8WW51aaIgrRBupCpNA=;
	b=X3a1PE79SJfVcGFsH24xsM2qXnosZ7M/+olugdnFTYfZOVe7OzJRNmQRWyasjGOiYrlUdU
	Wje7/4vLVaI73sALzhW+dCtXgLjLgdB5Gr7tIS2c69/JXLPNjTkmUU6pRZZLgzNBhk4JOb
	lwst7rHfQb+98KRIItG7n50fXZA33R8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-hTX62gxHPzWIeZv51Jn9sw-1; Tue, 24 Feb 2026 10:10:15 -0500
X-MC-Unique: hTX62gxHPzWIeZv51Jn9sw-1
X-Mimecast-MFC-AGG-ID: hTX62gxHPzWIeZv51Jn9sw_1771945814
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so57781975e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771945814; x=1772550614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCeOSff7eDNB7TgbEfprmGtaT8WW51aaIgrRBupCpNA=;
        b=qtAZPZRsazWcNEz1dpn43MRNn7EqFMH6VV6pZ87VafHbDrcQEQOfi02XT09VW5yhB1
         9XZ0xPalpY7hY8ePKM4De1ov9ZSJFRsVX/eQpvrCRu7ks1NvnkmVPJNOJyzYF/Xm2NXc
         ueZJ1mG7Kci4NBnwl4qRBJn2r9oud/asUA4diHCVzDZ1nYQLJQm1afF6n6B0qp9f+PHK
         sUiEIQ64rbteFK83QYFGG5Swrjs+PzBRF+/BReAINXBfgfqBwYvaLhrijhCPf+eA9iVC
         awSbBUKjSvCNldw6QPXub/8jEGw5ZyhzC5gYE7hG/FRJHl0vfDxZkRDBWA/z1K2yPLgN
         nBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945814; x=1772550614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCeOSff7eDNB7TgbEfprmGtaT8WW51aaIgrRBupCpNA=;
        b=v75hpiJDT4eHUsVMX2AAiw9VurCICifWWxWPxZZHwtzPoksjFXIp5pwbMZhevH8YEt
         zKRwFaVz0KR86N4AACABRk1hbUv9p7MZpMAoS5uMJ38eoIlhz/RJjVHw4VjFq+c6ecu2
         WyXe4XTtRw1B6Oa4X7ecavDAl+iu2z+/B0FxGLcS/bTwPhsRxFJfi15sIC6fAsGqyghQ
         D+f52fRbU8AuR25KejQcmZEh0hQklzs7ZcRH78xht3HeMrCOOTdWvjdxpaOfHrWEUXH4
         AcWjDMsHG/3i3lTkjOjx7thl+FdwBaXSbQfi7+uLtjfN5mneApWKwlIXeWrW40mFhoIM
         /R/A==
X-Forwarded-Encrypted: i=1; AJvYcCXNBcVFg2ObrGLInKguBbTOes90j6OeZEzg8j8LuVAYvLL0hT8ckr59GLw9zm+d9V0ClN7SK4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsseUF5ZxbrtCmhu1uy+NyZo9Qn4ydfpBoDXNsGNmtvn3NSvf
	b7Wyrrbt4ZF0FwoPS73UrI/Ms+j626/A0LFvaI0cVYpyQpDCW0jskW6LSMJAPbCK77U++Fx3iQO
	TQrcmNBKS6rRuN3bJqsIQO8C3KYmODP50vqPyU6ZJ0F7/Icv3OLsaQsSkoQ==
X-Gm-Gg: AZuq6aK1kkaaveFWbWB/uk6RVrwpxLhJRTh8U4VVaeWqWHlS6bnUwW0TJLz6Il9aKQc
	nevXTDxYJifGGoXsRwtoFoDQRAQkBynCIyCW6uTA+x+t1uUNXrmljl51H7ecorFQ64UhLS6V058
	rBbEJDWSXRIksCVKD9aBvt1+WmAA/qkA9IAv7GifNy+Bck2bsro8XU8kjvP33HBdwMhDbmHbR4i
	6Mavd0JurRqf1xDu09zHEOdPLJUvJB1HULjlCiaFY5kJOOLJfqnvugm8PeyDsZbDrecBrtR458+
	7uS1rLmeMbe48SdsfcOZy+yeHkhJ1NeoWs4e5pEqUnQ6Na9+C9NEIOwseJwNVBWyphtJ+oIuG4r
	Bo8JRdFV2chi7A7/wRTtfGKnGH5oHWfs9qtvIncmqDBynd+MiLUfdaqM1nnZMKVaNjlgNLiw=
X-Received: by 2002:a05:600c:3516:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-483a9637590mr181464225e9.26.1771945813982;
        Tue, 24 Feb 2026 07:10:13 -0800 (PST)
X-Received: by 2002:a05:600c:3516:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-483a9637590mr181463595e9.26.1771945813378;
        Tue, 24 Feb 2026 07:10:13 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8912fcasm19737805e9.27.2026.02.24.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:12 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZ2-yzyNKXNkvPVG@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260559-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,meta.com,lwn.net,linuxfoundation.org,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22B7F188D5C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:38:33PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Two administrator processes may race when setting child_ns_mode as one
>process sets child_ns_mode to "local" and then creates a namespace, but
>another process changes child_ns_mode to "global" between the write and
>the namespace creation. The first process ends up with a namespace in
>"global" mode instead of "local". While this can be detected after the
>fact by reading ns_mode and retrying, it is fragile and error-prone.
>
>Make child_ns_mode write-once so that a namespace manager can set it
>once and be sure it won't change. Writing a different value after the
>first write returns -EBUSY. This applies to all namespaces, including
>init_net, where an init process can write "local" to lock all future
>namespaces into local mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h    | 13 +++++++++++--
> include/net/netns/vsock.h |  3 +++
> net/vmw_vsock/af_vsock.c  | 15 ++++++++++-----
> 3 files changed, 24 insertions(+), 7 deletions(-)

I still slightly prefer the version I proposed here: 
https://lore.kernel.org/netdev/aZbR2H2oDyIAxDef@sgarzare-redhat/

But this definitely affects the code less, so for `net` I think this 
patch is better:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Eventually, we can discuss in net-next patch whether to change the 
implementation to the other one, but for the user nothing changes at 
all.

Thanks,
Stefano

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d3ff48a2fbe0..533d8e75f7bb 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -276,10 +276,19 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
> 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
> }
>
>-static inline void vsock_net_set_child_mode(struct net *net,
>+static inline bool vsock_net_set_child_mode(struct net *net,
> 					    enum vsock_net_mode mode)
> {
>-	WRITE_ONCE(net->vsock.child_ns_mode, mode);
>+	int new_locked = mode + 1;
>+	int old_locked = 0; /* unlocked */
>+
>+	if (try_cmpxchg(&net->vsock.child_ns_mode_locked,
>+			&old_locked, new_locked)) {
>+		WRITE_ONCE(net->vsock.child_ns_mode, mode);
>+		return true;
>+	}
>+
>+	return old_locked == new_locked;
> }
>
> static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index b34d69a22fa8..dc8cbe45f406 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -17,5 +17,8 @@ struct netns_vsock {
>
> 	enum vsock_net_mode mode;
> 	enum vsock_net_mode child_ns_mode;
>+
>+	/* 0 = unlocked, 1 = locked to global, 2 = locked to local */
>+	int child_ns_mode_locked;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9880756d9eff..50044a838c89 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -90,16 +90,20 @@
>  *
>  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
>  *     mode, which is set at namespace creation and immutable thereafter.
>- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
>+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
>  *     child namespaces will inherit when created. The initial value matches
>  *     the namespace's own ns_mode.
>  *
>  *   Changing child_ns_mode only affects newly created namespaces, not the
>  *   current namespace or existing children. A "local" namespace cannot set
>- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
>- *   from the parent's child_ns_mode.
>+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may be
>+ *   configured and locked down by a namespace manager. Writing a different
>+ *   value after the first write returns -EBUSY. At namespace creation, ns_mode
>+ *   is inherited from the parent's child_ns_mode.
>  *
>- *   The init_net mode is "global" and cannot be modified.
>+ *   The init_net mode is "global" and cannot be modified. The init_net
>+ *   child_ns_mode is also write-once, so an init process (e.g. systemd) can
>+ *   set it to "local" to ensure all new namespaces inherit local mode.
>  *
>  *   The modes affect the allocation and accessibility of CIDs as follows:
>  *
>@@ -2853,7 +2857,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 		    new_mode == VSOCK_NET_MODE_GLOBAL)
> 			return -EPERM;
>
>-		vsock_net_set_child_mode(net, new_mode);
>+		if (!vsock_net_set_child_mode(net, new_mode))
>+			return -EBUSY;
> 	}
>
> 	return 0;
>
>-- 
>2.47.3
>


