Return-Path: <netdev+bounces-264259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJQWCjdSqWkj4wAAu9opvQ
	(envelope-from <netdev+bounces-264259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:51:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C393C20EF9A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0C6300D0EF
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA737A4B8;
	Thu,  5 Mar 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD0L1aHn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H021WMmf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E6288D2
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704306; cv=none; b=mqKz4wyWirFPj6BuGPbRcF+DuqzP0H6tRLAwE3VANufPI2zaNT8VSMQBoH6OsiQa5z5NuLhJn0RszXjXh6tojEjbUe03oS6kPke7HrUR2G1YFFdyijTlYSH/yiL6AruWWKcaV87MsZ9Fc5loV+NHqt5zmNdeANQItjt+TBIhx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704306; c=relaxed/simple;
	bh=FXKFzKWzjI52GgzmHNUOFYfH3/rjrQEHZljmfESAyPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz5bYR1FjkW3hbbGCkioN7UbrDAWG5aB7WBCGp/Zto2y8cHwlr1TiU5nsBP/Fz2oftZ1EoUXPVWOmGS/7e3hBDonk4VPpaRX3WsrJ/WodzQgoyJrvxceUC8fi3eAbb5AthDf7CNaxjFwhIo7+ASO7wOVrrD5E80KeKWNz3Fwl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RD0L1aHn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H021WMmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772704303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAP2D1giB2BB8maYBYz4xIYderWfSFnBx/vi02aaqOM=;
	b=RD0L1aHnT4Hr62HvMtWFdreEq7PwkNkwEjqNUsHI+16FAUj3E1uXPx9yDbvs0EGePH1KEQ
	t1LHJB3GiX8gPXRohKFtr75nHdSQvUTApvJWZzTsZSyI1QbZpLCCRTQ8+CfVvq0+FsjWWH
	l3IVaL1D04P1/aAf0jKetfv9aAWGT38=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Nt-9DqjLMTW6RD3uKJiMGg-1; Thu, 05 Mar 2026 04:51:42 -0500
X-MC-Unique: Nt-9DqjLMTW6RD3uKJiMGg-1
X-Mimecast-MFC-AGG-ID: Nt-9DqjLMTW6RD3uKJiMGg_1772704301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso66690475e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772704301; x=1773309101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAP2D1giB2BB8maYBYz4xIYderWfSFnBx/vi02aaqOM=;
        b=H021WMmfNLen6fuQH7scRj36BhDwq7dY7tA/07V4k8Ji7c0l2FL5SlGnnknpIXdLPJ
         JDv+nbSFpzvZeEtG6ftl/djIly0IVR9GzunfMEFeme1q12dXBqGg/zw7tB5Vac6tvxfD
         pzbpGG1lu3SZWyffbJIsdofx6++puo3FBYmEyfcpDLsc1O8HjucRLpnpoia7RXbN6sAS
         mGixnfPrXgJ2MjsxQ367J1jQ+fc1yEc3K6yDHi2N0s/N+ykPMAPbsbL7lKDSs2D38nz9
         uerEuJgjfckw1WiuGn/vP8+qnwV9cUK2tlliI64ERVA7BIZLWBic7NG2Uf3Hh6Y2a1Zc
         k/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704301; x=1773309101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAP2D1giB2BB8maYBYz4xIYderWfSFnBx/vi02aaqOM=;
        b=fXBVKuM8cCWjGb+zEJoOHTytO70szDB1aYZN+5Uopf6c/2E7Mmk9xW9PiMUrGO05Cw
         6n4C1W1mbSxIcff8P5WBigDZzgeMagutwUdC/heyoHs+mbmXGoDV2UZCVsID8eOXvwVV
         jUrDbuXoNwL1ZQ276udhO3U4hgSIZgfuOIdfTTInMlxRudT6ktiIj1cMzEmtuWqHx4Ud
         MPM6udoExpw6UQ3H02RBXcI37gEk/d4Yz+L9W1tF/BwYfRjDcxXL7TQoIzkA+HnA3XZr
         ZRgAoni+463d7W9Fd9CBTQ0iiXSk8MplFYYYBgfxxQB3HiuE184PJ3NotJLrF8zt8nUZ
         fuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXz8azVnNGb2s72ON3zx9CdNhzzfRpLUHQ1UhMSPWvUMis2Tjc2QQqV0mlks3OfUZvPaUtUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaqzA9Pw4XQTJ8WU+qICbSd7qgUbRUz5gWRXN+K4yQ4w/FaG2
	0HzIueJ/7RIWsNZSNIiNMA1kFQBCeZSqKqWdWaFmGmJ2RlRWET0ix2UlnKemOZLv1BctZ71+mYH
	o5vTlC3qsUtp6nDDxG5F4e3SQtUq0Dwt9jOOo1+F9J943oWOUuWF+4PuWvA==
X-Gm-Gg: ATEYQzylEwOk6/yiov37KstKgB33GlpPk+pQb/pHgnLrmnCpyuQJ+YxMW1Nhede3A41
	v2Y+GoZgBzYbLOqqTV6tDKoU+8P1Zj8oAC8pUdI2ilPHaeXaRbQ1mL7okFaAP2Oc9gkBmhg+auP
	p6IGZrDvngxDxs3zostl4hXEYJAlI+Lx9G6Bz+MbKe+vo7FudRSlcLKiWrxHYx/x/zZ52P/77MD
	mCMHXD1E7A4+u4NwbWw+yM2DzroC6fyMN5rdWm54+maQxroo4uE8Q/YQpwCor0o/jYQHhGXPWPw
	MAMKcOd9q1hSO8rJdx+9qLi5du59nWLYZo5XDIMAdfz5YHatuLTJTQDYdETgyL99CMN0ywusiF3
	q1z0mDTunJnjI/2n92/5OX0MW9k+OARRGo/FIDY5UmFiEEMWTjpdIy8muGVyGgv92VLHAAnI=
X-Received: by 2002:a05:600c:4f8b:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-48519856a67mr89432285e9.13.1772704300505;
        Thu, 05 Mar 2026 01:51:40 -0800 (PST)
X-Received: by 2002:a05:600c:4f8b:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-48519856a67mr89431665e9.13.1772704299890;
        Thu, 05 Mar 2026 01:51:39 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02eeesm28284255e9.19.2026.03.05.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:39 -0800 (PST)
Date: Thu, 5 Mar 2026 10:51:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>, mst@redhat.com, pabeni@redhat.com, 
	kuba@kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	nh-open-source@amazon.com, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4] vsock: add G2H fallback for CIDs not owned
 by H2G transport
Message-ID: <aalQditGLRMrlyV7@sgarzare-redhat>
References: <20260304230027.59857-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260304230027.59857-1-graf@amazon.com>
X-Rspamd-Queue-Id: C393C20EF9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:00:27PM +0000, Alexander Graf wrote:
>When no H2G transport is loaded, vsock currently routes all CIDs to the
>G2H transport (commit 65b422d9b61b ("vsock: forward all packets to the
>host when no H2G is registered"). Extend that existing behavior: when
>an H2G transport is loaded but does not claim a given CID, the
>connection falls back to G2H in the same way.
>
>This matters in environments like Nitro Enclaves, where an instance may
>run nested VMs via vhost-vsock (H2G) while also needing to reach sibling
>enclaves at higher CIDs through virtio-vsock-pci (G2H). With the old
>code, any CID > 2 was unconditionally routed to H2G when vhost was
>loaded, making those enclaves unreachable without setting
>VMADDR_FLAG_TO_HOST explicitly on every connect.
>
>Requiring every application to set VMADDR_FLAG_TO_HOST creates friction:
>tools like socat, iperf, and others would all need to learn about it.
>The flag was introduced 6 years ago and I am still not aware of any tool
>that supports it. Even if there was support, it would be cumbersome to
>use. The most natural experience is a single CID address space where H2G
>only wins for CIDs it actually owns, and everything else falls through to
>G2H, extending the behavior that already exists when H2G is absent.
>
>To give user space at least a hint that the kernel applied this logic,
>automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
>can determine the path taken via getpeername().
>
>Add a per-network namespace sysctl net.vsock.g2h_fallback (default 1).
>At 0 it forces strict routing: H2G always wins for CID > VMADDR_CID_HOST,
>or ENODEV if H2G is not loaded.
>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>Tested-by: syzbot@syzkaller.appspotmail.com
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
>
>v2 -> v3:
>
>  - Use has_remote_cid() on G2H transport to gate the fallback. This is
>    used by VMCI to indicate that it never takes G2H CIDs > 2.
>  - Move g2h_fallback into struct netns_vsock to enable namespaces
>    and fix syzbot warning
>  - Gate the !transport_h2g case on g2h_fallback as well, folding the
>    pre-existing no-H2G fallback into the new logic
>  - Remove has_remote_cid() from VMCI again. Instead implement it in
>    virtio.
>
>v3 -> v4:
>
>  - Fix commit reference format (checkpatch)
>  - vhost: use !!vhost_vsock_get() instead of != NULL (checkpatch)
>  - Add braces around final else branch (checkpatch)
>  - Replace 'vhost' with 'H2G transport' (Stefano)
>---
> Documentation/admin-guide/sysctl/net.rst | 28 +++++++++++++++++++
> drivers/vhost/vsock.c                    | 13 +++++++++
> include/net/af_vsock.h                   |  9 ++++++
> include/net/netns/vsock.h                |  2 ++
> net/vmw_vsock/af_vsock.c                 | 35 ++++++++++++++++++++----
> net/vmw_vsock/virtio_transport.c         |  7 +++++
> 6 files changed, 89 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index 3b2ad61995d4..0724a793798f 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -602,3 +602,31 @@ it does not modify the current namespace or any existing children.
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
>+vhost-vsock) does not serve, or if no H2G transport is loaded at all, the
>+connection is routed via the G2H transport (e.g. virtio-vsock) instead. This
>+allows a host running both nested VMs (via vhost-vsock) and sibling VMs
>+reachable through the hypervisor (e.g. Nitro Enclaves) to address both using
>+a single CID space, without requiring applications to set
>+``VMADDR_FLAG_TO_HOST``.
>+
>+When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
>+the remote address so that userspace can determine the path via
>+``getpeername()``.
>+
>+Note: With this sysctl enabled, user space that attempts to talk to a guest
>+CID which is not implemented by the H2G transport will create host vsock
>+traffic. Environments that rely on H2G-only isolation should set it to 0.
>+
>+Values:
>+
>+	- 0 - Connections to CIDs <= 2 or with VMADDR_FLAG_TO_HOST use G2H;
>+	  all others use H2G (or fail with ENODEV if H2G is not loaded).
>+	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..1d8ec6bed53e 100644
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
>+	found = !!vhost_vsock_get(cid, net);
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
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 533d8e75f7bb..4e40063adab4 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -179,6 +179,15 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Check if this transport serves a specific remote CID.
>+	 * For H2G transports: return true if the CID belongs to a registered
>+	 * guest. If not implemented, all CIDs > VMADDR_CID_HOST go to H2G.
>+	 * For G2H transports: return true if the transport can reach arbitrary
>+	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
>+	 * does not implement this as it only serves CIDs 0 and 2.
>+	 */
>+	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index dc8cbe45f406..7f84aad92f57 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -20,5 +20,7 @@ struct netns_vsock {
>
> 	/* 0 = unlocked, 1 = locked to global, 2 = locked to local */
> 	int child_ns_mode_locked;
>+
>+	int g2h_fallback;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682cb..50843a977878 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -545,9 +545,13 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>  * The vsk->remote_addr is used to decide which transport to use:
>  *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>  *    g2h is not loaded, will use local transport;
>- *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>- *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
>- *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
>+ *  - remote CID <= VMADDR_CID_HOST or remote flags field includes
>+ *    VMADDR_FLAG_TO_HOST, will use guest->host transport;
>+ *  - remote CID > VMADDR_CID_HOST and h2g is loaded and h2g claims that CID,
>+ *    will use host->guest transport;
>+ *  - h2g not loaded or h2g does not claim that CID and g2h claims the CID via
>+ *    has_remote_cid, will use guest->host transport (when g2h_fallback=1)
>+ *  - anything else goes to h2g or returns -ENODEV if no h2g is available
>  */
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> {
>@@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	case SOCK_SEQPACKET:
> 		if (vsock_use_local_transport(remote_cid))
> 			new_transport = transport_local;
>-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>+		else if (remote_cid <= VMADDR_CID_HOST ||
> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
> 			new_transport = transport_g2h;
>-		else
>+		else if (transport_h2g &&
>+			 (!transport_h2g->has_remote_cid ||
>+			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>+			new_transport = transport_h2g;
>+		else if (sock_net(sk)->vsock.g2h_fallback &&
>+			 transport_g2h && transport_g2h->has_remote_cid &&
>+			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>+			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>+			new_transport = transport_g2h;
>+		} else {
> 			new_transport = transport_h2g;
>+		}
> 		break;
> 	default:
> 		ret = -ESOCKTNOSUPPORT;
>@@ -2879,6 +2893,15 @@ static struct ctl_table vsock_table[] = {
> 		.mode		= 0644,
> 		.proc_handler	= vsock_net_child_mode_string
> 	},
>+	{
>+		.procname	= "g2h_fallback",
>+		.data		= &init_net.vsock.g2h_fallback,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= SYSCTL_ZERO,
>+		.extra2		= SYSCTL_ONE,
>+	},
> };
>
> static int __net_init vsock_sysctl_register(struct net *net)
>@@ -2894,6 +2917,7 @@ static int __net_init vsock_sysctl_register(struct net *net)
>
> 		table[0].data = &net->vsock.mode;
> 		table[1].data = &net->vsock.child_ns_mode;
>+		table[2].data = &net->vsock.g2h_fallback;
> 	}
>
> 	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>@@ -2928,6 +2952,7 @@ static void vsock_net_init(struct net *net)
> 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>
> 	net->vsock.child_ns_mode = net->vsock.mode;
>+	net->vsock.g2h_fallback = 1;

My last concern is what I mentioned in v3 [1].
Let me quote it here as well:

     @Michael @Paolo @Jakub
     I don't know what the sysctl policy is in general in net or virtio.
     Is this fine or should we inherit this from the parent and set the
     default only for init_ns?

I slightly prefer to inherit it, but I don't know what the convention 
is, it's not a strong opinion. Since I'll be away in a few days, 
regardless of this:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] https://lore.kernel.org/netdev/aahRzq5vS76rPI28@sgarzare-redhat/

> }
>
> static __net_init int vsock_sysctl_init_net(struct net *net)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 77fe5b7b066c..57f2d6ec3ffc 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -547,11 +547,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> 					     u32 remote_cid);
>
>+static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>+{
>+	/* The CID could be implemented by the host. Always assume it is. */
>+	return true;
>+}
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = virtio_transport_get_local_cid,
>+		.has_remote_cid           = virtio_transport_has_remote_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
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


