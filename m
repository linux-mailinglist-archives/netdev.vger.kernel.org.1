Return-Path: <netdev+bounces-263114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLKqCtW3pmk7TAAAu9opvQ
	(envelope-from <netdev+bounces-263114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB51ECA96
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9363044B86
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272439A068;
	Tue,  3 Mar 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6UIhuAm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6sYbg51"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF5391822
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533713; cv=none; b=GKOitGQJjH7GNVFRD+esmyK0EbAUIkVcAAb/6f1l4daI939eiw2ewW4BfqqMbWTIT4ndyl8/o5n4twAhKDXVXsYzmQpFT/os9Mvj5pxUVIAbzAmiTxZrJ6AfmMSFDukUTLaiYEfah3dc8AY6sTWDCHZRDkYhxmzSynTL3m+rR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533713; c=relaxed/simple;
	bh=EnoOjqFTpHE2jXovEB1Z4TyWU6J5+Ynfts2T5MKu1x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptH4W+wkbGYaJqrbA+p53WOI09njHaNT1WorXRV5Tglh1rzi877BtqAcwNIWiHv6p3iOhx0qmfclgqecH2iEDO3jgy98Q7AZ9rtHXjdkEQom+W+azIm1VrvjoenOan6m6LXzNILG/7fZepfdYrpgzuH3I74mjVpLk4IqxGiKS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6UIhuAm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6sYbg51; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772533711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bi5bbv5Jxdjs71+aClGaoRoAtGS5fPKO2LWip4z/On0=;
	b=X6UIhuAmZu2i168hzPdre1XswFkn8WL6EZSMwibx9U5rDB4s87AzYVo5RRqxhAZI4bADPI
	P+VD7rql1eghZANQUCdrso/0Tcrn+RdCb/UmWKtvNqtbCoR+BlM+Y3mOthgE8K9STgSA3s
	LWxpRibeAdQ/qyU6yOPIcriY430qUuU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-JP0jwcprP_GGsll0lDNKMQ-1; Tue, 03 Mar 2026 05:28:29 -0500
X-MC-Unique: JP0jwcprP_GGsll0lDNKMQ-1
X-Mimecast-MFC-AGG-ID: JP0jwcprP_GGsll0lDNKMQ_1772533709
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so42972265e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772533708; x=1773138508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bi5bbv5Jxdjs71+aClGaoRoAtGS5fPKO2LWip4z/On0=;
        b=Q6sYbg510oul/RwXilKQIVjw4ptrwkJYXnhjrfRO/sDWPNSBD0YMjl3a1lIcRa8dBo
         K+Lbt2/urCdSezNb8QiCLYoV0vFeLZAJPZPH7HTKCn2UeduoE75E+hUr/d4zLZnHQ2fy
         KkMHN9ThX2JJaAhk5aJG2EoEoT2mpeZt1BrS6ZVSOSIH2HCAUSNlE/ybMHygoT3fMkDF
         JDs0GNtKJhVK/Gse/rskdpOQ6CqRNHjjG8wX2lcGO85lHuef4OZepIH732751OFypZoH
         IND+IJhUpd4TPMPlfiO6GaQWhN5lDzeja81vtS00ZqWNyCuSeVYHSdBABTNUILaCQA7+
         NNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772533708; x=1773138508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi5bbv5Jxdjs71+aClGaoRoAtGS5fPKO2LWip4z/On0=;
        b=h6/RdFdshBggxYJbojuDfCLassN0zwD5DqRTf2K5+ws3V07j7GHg7Chp8/vYrqdvMF
         L2jBbu/t1ZeBLNEE3qclHMeqkkDsP0K+H5ubPL6/iy/7ZpROSZ4zmNVs4/iTee6M/KPg
         jrje6tTBHn9mCuiQaxMs8B06wBz7IMQxiUw588Slwq9eTd1Lua4zRWVjsik3/Iw/uCjq
         AhSRhq3VOlcO7jPeFPQHSeEeT7dJ7gO2cd5AwSwMuU4BYJOAd9DYuQuZLe7CecNwdFPh
         ERfRpNegcZKZl+pN9PLxxRtPN2iS1oUriAFsTL2e/np1Bv0XSbageFJd6WzqI0TWd1HO
         hNjg==
X-Forwarded-Encrypted: i=1; AJvYcCUh05R3p/61aeqzCKRohgAYqqj1ew1U2gbVY6m6Na7efkM9D5TAYrIWydx5hWdkjVnUCpLgYY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OalkAsLKrNsDyW6xjQ9CqMj/g4nN1ZPYxpkOTepmgcRuLIsh
	kYnqcR47bB1aExHRl4NZPAxHQgY+8Q2Anqo0yWr+ksu2yHCUb0exhaZbzHA+OkNj//gS9WxetEa
	R5AMv8+Bo+wdH69mdZS80e5fE5fQPn6BtuC4xviFj8uukCd1ywnphnew7GQ==
X-Gm-Gg: ATEYQzxzvaISZcXQ1U4Qq5pNowjGka0zncwMGslJrEb/Gv2YXQsqPzriijqxvtl7VQq
	KLaXLzQfW764uQRYtmn8SG9rqdgU7/FFry/3y/VD2fI3aBbUgt/44dQHs8K1dfI3EBxvoaW1AbJ
	TMRe/n+9pZAZAes0OqpGo0v9ceUD2qnYvkLMMtw+Fi8/f3Nh8OcGwyMxibXeLBsAXl72dgS2MKG
	aXwiCt3av/9xl/4LAviGtmSKbb8vEMjdSr6XF5OGZTl0MeoTNO+8Hl5e6d9eUlXGQNwqC/pBs4y
	9eM8eFbWpYrL/G79i4/gfx1ExP5CwCuGx/bw5GOmcV2nTFPLKVkBqpR4aCxGfwuGGPtzSFfhx4E
	OB5veSr9q1xN0vwuE260mNIv2KWj0rBobfO6hJXheM06P1t29P5zYrdcVZYbO8VJWozI1Gd4=
X-Received: by 2002:a05:600c:458b:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-483c9bdb6a8mr244174445e9.30.1772533708519;
        Tue, 03 Mar 2026 02:28:28 -0800 (PST)
X-Received: by 2002:a05:600c:458b:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-483c9bdb6a8mr244174045e9.30.1772533707936;
        Tue, 03 Mar 2026 02:28:27 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126b35fbsm13837005e9.11.2026.03.03.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:28:26 -0800 (PST)
Date: Tue, 3 Mar 2026 11:28:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock: add G2H fallback for CIDs not owned by H2G
 transport
Message-ID: <aaa0UCkzFRyuVp4N@sgarzare-redhat>
References: <20260302194926.90378-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260302194926.90378-1-graf@amazon.com>
X-Rspamd-Queue-Id: 84DB51ECA96
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-263114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Please mark this as `net-next` material. AF_VSOCK core changes are 
queued by net maintainers and that will help them to get the right tree:
https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

On Mon, Mar 02, 2026 at 07:49:26PM +0000, Alexander Graf wrote:
>Vsock maintains a single CID number space which can be used to
>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>assumes that G2H is only relevant for CID <= 2 because these target the
>hypervisor. However, in environments like Nitro Enclaves, an instance
>that hosts vhost_vsock powered VMs may still want to communicate to
>Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>
>Vsock introduced VMADDR_FLAG_TO_HOST to allow user space applications
>to clearly express a desire to talk to the host instead of a guest via
>the passed target CID. However, users may not actually know which one
>they want to talk to and the application ecosystem has not picked up a
>way for users to specify that desire.
>
>Instead, make it easy for users and introduce a G2H fallback mechanism:
>when user space attempts to connect to a CID and the H2G transport
>(vhost-vsock / VMCI) does not own it, automatically route the connection
>through the G2H transport. This provides a single unified CID address
>space where vhost-registered CIDs go to nested VMs and all other CIDs
>are routed to the hypervisor.
>
>To give user space at least a hint that the kernel applied this logic,
>automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
>can determine the path taken via getpeername().
>
>To force the system back into old behavior, provide a sysctl
>(net.vsock.g2h_fallback, defaults to 1).

I'm still concerned about this change. Perhaps we should document the 
fact that if H2G is not loaded, we already behave in this way, and 
sysctl helps us definitively to better define this behavior.

>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>
>---
>
>v1 -> v2:
>
>  - Rebase on 7.0, include namespace support
>  - Add net.vsock.g2h_fallback sysctl
>  - Rework description
>  - Set VMADDR_FLAG_TO_HOST automatically
>  - Add VMCI support
>  - Update vsock_assign_transport() comment
>---
> Documentation/admin-guide/sysctl/net.rst | 22 ++++++++++++++++++++++
> drivers/misc/vmw_vmci/vmci_context.c     |  1 +
> drivers/vhost/vsock.c                    | 13 +++++++++++++
> include/linux/vmw_vmci_api.h             |  1 +
> include/net/af_vsock.h                   |  3 +++
> net/vmw_vsock/af_vsock.c                 | 20 +++++++++++++++++++-
> net/vmw_vsock/vmci_transport.c           |  6 ++++++
> 7 files changed, 65 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index 3b2ad61995d4..cc364baa9021 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -602,3 +602,25 @@ it does not modify the current namespace or any existing children.
>
> A namespace with ``ns_mode`` set to ``local`` cannot change
> ``child_ns_mode`` to ``global`` (returns ``-EPERM``).
>+
>+g2h_fallback
>+------------
>+
>+Controls whether connections to CIDs not owned by the host-to-guest (H2G)
>+transport automatically fall back to the guest-to-host (G2H) transport.
>+
>+When enabled, if a connect targets a CID that the H2G transport (e.g.
>+vhost-vsock) does not serve, the connection is routed via the G2H transport
>+(e.g. virtio-vsock) instead. This allows a host running both nested VMs
>+(via vhost-vsock) and sibling VMs reachable through the hypervisor (e.g.
>+Nitro Enclaves) to address both using a single CID space, without requiring
>+applications to set ``VMADDR_FLAG_TO_HOST``.
>+
>+When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
>+the remote address so that userspace can determine the path via
>+``getpeername()``.
>+
>+Values:
>+
>+	- 0 - Connections to CIDs < 3 get handled by G2H, others by H2G.
>+	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
>index 19ca00feed6e..577296784df5 100644
>--- a/drivers/misc/vmw_vmci/vmci_context.c
>+++ b/drivers/misc/vmw_vmci/vmci_context.c
>@@ -364,6 +364,7 @@ bool vmci_ctx_exists(u32 cid)
> 	rcu_read_unlock();
> 	return exists;
> }
>+EXPORT_SYMBOL_GPL(vmci_ctx_exists);
>
> /*
>  * Retrieves VMCI context corresponding to the given cid.
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..319e3a690108 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -91,6 +91,18 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> 	return NULL;
> }
>
>+static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>+{
>+	struct sock *sk = sk_vsock(vsk);
>+	struct net *net = sock_net(sk);
>+	bool found;
>+
>+	rcu_read_lock();
>+	found = vhost_vsock_get(cid, net) != NULL;
>+	rcu_read_unlock();
>+	return found;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -424,6 +436,7 @@ static struct virtio_transport vhost_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vhost_transport_get_local_cid,
>+		.has_remote_cid           = vhost_transport_has_remote_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/include/linux/vmw_vmci_api.h b/include/linux/vmw_vmci_api.h
>index 41764a684423..c412d17c572f 100644
>--- a/include/linux/vmw_vmci_api.h
>+++ b/include/linux/vmw_vmci_api.h
>@@ -37,6 +37,7 @@ int vmci_doorbell_create(struct vmci_handle *handle, u32 flags,
> int vmci_doorbell_destroy(struct vmci_handle handle);
> u32 vmci_get_context_id(void);
> bool vmci_is_context_owner(u32 context_id, kuid_t uid);
>+bool vmci_ctx_exists(u32 cid);
> int vmci_register_vsock_callback(vmci_vsock_cb callback);
>
> int vmci_event_subscribe(u32 event,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 533d8e75f7bb..0aeb25642827 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -179,6 +179,9 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Check if this transport serves a specific remote CID. */
>+	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682cb..b41bc734d6c0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -210,6 +210,8 @@ static const struct vsock_transport *transport_dgram;
> static const struct vsock_transport *transport_local;
> static DEFINE_MUTEX(vsock_register_mutex);
>
>+static int vsock_g2h_fallback = 1;
>+
> /**** UTILS ****/
>
> /* Each bound VSocket is stored in the bind hash table and each connected
>@@ -547,7 +549,8 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>  *    g2h is not loaded, will use local transport;
>  *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>  *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
>- *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
>+ *  - remote CID > VMADDR_CID_HOST will use host->guest transport if h2g has
>+ *    registered that CID, otherwise will use guest->host transport (overlay);
>  */
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> {
>@@ -584,6 +587,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
> 			new_transport = transport_g2h;
>+		else if (vsock_g2h_fallback &&

IMO `vsock_g2h_fallback` should also control the fallback when 
transport_h2g == NULL. In this way is easiest to justify why the default 
is to have the fallback enabled.

>+			 transport_h2g->has_remote_cid &&
>+			 !transport_h2g->has_remote_cid(vsk, remote_cid)) {
>+			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>+			new_transport = transport_g2h;
>+		}
> 		else
> 			new_transport = transport_h2g;
> 		break;
>@@ -2879,6 +2888,15 @@ static struct ctl_table vsock_table[] = {
> 		.mode		= 0644,
> 		.proc_handler	= vsock_net_child_mode_string
> 	},
>+	{
>+		.procname	= "g2h_fallback",
>+		.data		= &vsock_g2h_fallback,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= SYSCTL_ZERO,
>+		.extra2		= SYSCTL_ONE,
>+	},

syzbot is reporting a warning with this change:
https://lore.kernel.org/netdev/69a6940b.a70a0220.135158.0007.GAE@google.com/
     sysctl net/vsock/g2h_fallback: data points to kernel global data: 
     vsock_g2h_fallback

IIUC because vsock_table is per-netns stuff, while `g2h_fallback` is a 
global setting, so I guess we need to use another ctl_table for that.

Thanks,
Stefano

> };
>
> static int __net_init vsock_sysctl_register(struct net *net)
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 4296ca1183f1..de3dff52c566 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -2045,6 +2045,11 @@ static u32 vmci_transport_get_local_cid(void)
> 	return vmci_get_context_id();
> }
>
>+static bool vmci_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>+{
>+	return vmci_ctx_exists(cid);
>+}
>+
> static struct vsock_transport vmci_transport = {
> 	.module = THIS_MODULE,
> 	.init = vmci_transport_socket_init,
>@@ -2074,6 +2079,7 @@ static struct vsock_transport vmci_transport = {
> 	.notify_send_post_enqueue = vmci_transport_notify_send_post_enqueue,
> 	.shutdown = vmci_transport_shutdown,
> 	.get_local_cid = vmci_transport_get_local_cid,
>+	.has_remote_cid = vmci_transport_has_remote_cid,
> };
>
> static bool vmci_check_transport(struct vsock_sock *vsk)
>-- 
>2.47.1
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Tamara-Danz-Str. 13
>10243 Berlin
>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597
>
>


