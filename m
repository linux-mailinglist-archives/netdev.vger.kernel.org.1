Return-Path: <netdev+bounces-263171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNRCD2PPpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:09:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A82DE1EF0C0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3604B30E9881
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA41933EAE6;
	Tue,  3 Mar 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Byh9Yczm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbE5tnmW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15A317165
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539165; cv=none; b=FdfOoYLeTCF1LDlWZpNqc8jW1Up5LMzRgo661/pPbX9C5K26sE2e01CjPUWgWkJHJBLBLX0/Dhww8BR6ctlrmSGC7ZixO3MuqbRtRvmhwilJEoNhY00PbniiC/iIbamuystkZIJM1WPLcTFXMO2y+aSl7401unQzuWdAFGAWcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539165; c=relaxed/simple;
	bh=R+ICJC5kvyPyHzF/GkiaD+DfOTKgqmV2Y0qKy6BUs8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AebpKBdUbScf5HYKQ3xU17mi84zqUxhq+hxa6/0xbb01kOHtY5FL60D16shr2Mzwz2kx7sU8tgBpSxGtdHXaAo09OWD2u0M9BlrNc5oQlEXbc6Cwy73f7Ww1yaDFD9JfTMTrg13Tq09fH9fDhpZSvaXTW4V4f9hEqspaEuAHUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Byh9Yczm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbE5tnmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772539161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oWPwCsPzitUHXWWxGP6yJXH2v1abjhp3h0HfDhumHuM=;
	b=Byh9YczmpWmtFm+bnpOS/+6BX/A+tbb3rRM5H9MrlWntleiE7IQP6hfOFcjpSSVLLdF1Gc
	MZFPSJAtxg/b0T0e0EU4F2IkuZUW9bZ2Ng96Mrn1vkooC0ifgdIS2JLVHbv69ngSGPlKWG
	D4vFJCkmdeXwVD5lL75L3RPXLH8RVfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-I8_z1tGvNMGXptIuphShjA-1; Tue, 03 Mar 2026 06:59:20 -0500
X-MC-Unique: I8_z1tGvNMGXptIuphShjA-1
X-Mimecast-MFC-AGG-ID: I8_z1tGvNMGXptIuphShjA_1772539160
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48379489438so53964385e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 03:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772539159; x=1773143959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWPwCsPzitUHXWWxGP6yJXH2v1abjhp3h0HfDhumHuM=;
        b=bbE5tnmWagZ2DzWq9CXiAaM3Umgen7E88DwlrXf9hU4wWJnD4Z7wC5AYp1OUY45dLT
         gh3jpdeYRuD8Pm3/ut8AZWyNi2NWzYoje9QOtTQS0vGV4n0CmjJCJwBFyGKO8EayPRiI
         CsMrDoNj+ENTmoalzJc9lPdIsIreh7UkaianTM4lNIlvR2Xnw5znfChy+YKx5PdXAIab
         xl2Fztp0zo/zjahpQWKflxOh8JoGU1/9z53yVK9CP9JsFCC7R9ARPstzsPJKBr6KnkXK
         d9UmC2qfOXzUfExQtqfpkqcSCpguQ6C5sfeKuam8cfKAc5aOfeXLMrLEp5yR2iBCyITN
         RUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539159; x=1773143959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWPwCsPzitUHXWWxGP6yJXH2v1abjhp3h0HfDhumHuM=;
        b=vr9L0maaGuhl6q4WqA0qnPM3LopXQi8GSSLnVxylhSkb10YfEJJM95OOAFdhVWXMOC
         YA8rSgaOIm1k+GSZBPFZ2Zkd3lGZssv7t1W9CqFWeJBsIFlu/0nAJH0Qw9K06Rgo4S3D
         /z5PWl9YuNRVLc+5VKBT+X5cYyYmpuO3J4jEmRkSaW+jYmv87CdvDtjxDoKR/RrzLaj0
         kL2gPYmljca/1hF/XY0xbPsBJuUsxMUl54b+4dm7l0fXyKWYSwisYz2Y9IHHw6F2KFL3
         hk9Cz+g7mrhMmp5y3OynY0cpIUs+l3ab5am9GIA7YcyEhGjxs2IkqKr7E2YM8n+676V4
         QYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3xQv/AYWVLuC739uN/1Zo35LDndBmYovCX5M0w7MWcrfJ4PGlmem/hJreSTUTae+MS30Hn3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZI6M7x0as5jUQPvsHiebTsMG8mFPL6XUDizTODb3v1dc5ceK
	w4V3xxL3dBc+ENNfyl0Z/Sq1hCDwKp7jNuaipwwj+zk6NVrhDWqTru/wyYG558r57RmnlpIosld
	7ydanByJUF0qS0N1zwYe1eZr8yVd3PbFpvLuIBFQ8RuV+6YMrdwAKYLAQAw==
X-Gm-Gg: ATEYQzzE/gvkRfVljSSqMhXzZt3nSbTkBn6gSOKwZtBMQdpQe4r2VqU1x7ySj7zMm7d
	SRQXMkNcxOySbGuZ5eVXzO6+M6OxziP69+XO3OwE6Q1DyxVFcg1QGDS0/MgGzWpmM8n7rPGon3x
	ZkDrHq/H+xGLCetIJqwSdvtLaUgPOU1uoCc2gihvte9X3KEQEVjex8GIpw7V5EosA2NKlmT0Ung
	q0RNucpXydhhTnXawkwGYBr6RIt676cYQlK3zxjDW961wrkwnb3v2whlRxZv0VvLZNCptHEWh9Q
	zYnZ3VCI0KieorVR57la9fN3CgF3HQDKh1aSyFJGPoIy2JtJywHo4WqMMQn3LHMXe7NHjuMuzyb
	lilUzh+IP+bzrWumaZnqpxH2dL8aEHm/WpmKBStx0t46y2A==
X-Received: by 2002:a05:600c:138d:b0:483:361b:deff with SMTP id 5b1f17b1804b1-483c9bb2c10mr275305625e9.14.1772539159450;
        Tue, 03 Mar 2026 03:59:19 -0800 (PST)
X-Received: by 2002:a05:600c:138d:b0:483:361b:deff with SMTP id 5b1f17b1804b1-483c9bb2c10mr275305025e9.14.1772539158852;
        Tue, 03 Mar 2026 03:59:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851334f9edsm23797215e9.4.2026.03.03.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:59:18 -0800 (PST)
Date: Tue, 3 Mar 2026 06:59:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>, nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock: add G2H fallback for CIDs not owned by H2G
 transport
Message-ID: <20260303065604-mutt-send-email-mst@kernel.org>
References: <20260302194926.90378-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302194926.90378-1-graf@amazon.com>
X-Rspamd-Queue-Id: A82DE1EF0C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 07:49:26PM +0000, Alexander Graf wrote:
> Vsock maintains a single CID number space which can be used to
> communicate to the host (G2H) or to a child-VM (H2G). The current logic
> assumes that G2H is only relevant for CID <= 2 because these target the
> hypervisor. However, in environments like Nitro Enclaves, an instance
> that hosts vhost_vsock powered VMs may still want to communicate to
> Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
> 
> Vsock introduced VMADDR_FLAG_TO_HOST to allow user space applications
> to clearly express a desire to talk to the host instead of a guest via
> the passed target CID. However, users may not actually know which one
> they want to talk to and the application ecosystem has not picked up a
> way for users to specify that desire.
> 
> Instead, make it easy for users and introduce a G2H fallback mechanism:
> when user space attempts to connect to a CID and the H2G transport
> (vhost-vsock / VMCI) does not own it, automatically route the connection
> through the G2H transport. This provides a single unified CID address
> space where vhost-registered CIDs go to nested VMs and all other CIDs
> are routed to the hypervisor.

So as usual we have security/convenience tradeoff, if someone wanted
to block this, we might be opening a security hole.
I am not saying it's a big issue but I feel the security implications
should at least be documented better.


> To give user space at least a hint that the kernel applied this logic,
> automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
> can determine the path taken via getpeername().
> 
> To force the system back into old behavior, provide a sysctl
> (net.vsock.g2h_fallback, defaults to 1).

Given it affects routing, this sysctl should be per netns?


> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - Rebase on 7.0, include namespace support
>   - Add net.vsock.g2h_fallback sysctl
>   - Rework description
>   - Set VMADDR_FLAG_TO_HOST automatically
>   - Add VMCI support
>   - Update vsock_assign_transport() comment
> ---
>  Documentation/admin-guide/sysctl/net.rst | 22 ++++++++++++++++++++++
>  drivers/misc/vmw_vmci/vmci_context.c     |  1 +
>  drivers/vhost/vsock.c                    | 13 +++++++++++++
>  include/linux/vmw_vmci_api.h             |  1 +
>  include/net/af_vsock.h                   |  3 +++
>  net/vmw_vsock/af_vsock.c                 | 20 +++++++++++++++++++-
>  net/vmw_vsock/vmci_transport.c           |  6 ++++++
>  7 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index 3b2ad61995d4..cc364baa9021 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -602,3 +602,25 @@ it does not modify the current namespace or any existing children.
>  
>  A namespace with ``ns_mode`` set to ``local`` cannot change
>  ``child_ns_mode`` to ``global`` (returns ``-EPERM``).
> +
> +g2h_fallback
> +------------
> +
> +Controls whether connections to CIDs not owned by the host-to-guest (H2G)
> +transport automatically fall back to the guest-to-host (G2H) transport.
> +
> +When enabled, if a connect targets a CID that the H2G transport (e.g.
> +vhost-vsock) does not serve, the connection is routed via the G2H transport
> +(e.g. virtio-vsock) instead. This allows a host running both nested VMs
> +(via vhost-vsock) and sibling VMs reachable through the hypervisor (e.g.
> +Nitro Enclaves) to address both using a single CID space, without requiring
> +applications to set ``VMADDR_FLAG_TO_HOST``.
> +
> +When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
> +the remote address so that userspace can determine the path via
> +``getpeername()``.
> +
> +Values:
> +
> +	- 0 - Connections to CIDs < 3 get handled by G2H, others by H2G.
> +	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> index 19ca00feed6e..577296784df5 100644
> --- a/drivers/misc/vmw_vmci/vmci_context.c
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -364,6 +364,7 @@ bool vmci_ctx_exists(u32 cid)
>  	rcu_read_unlock();
>  	return exists;
>  }
> +EXPORT_SYMBOL_GPL(vmci_ctx_exists);
>  
>  /*
>   * Retrieves VMCI context corresponding to the given cid.
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 054f7a718f50..319e3a690108 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -91,6 +91,18 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>  	return NULL;
>  }
>  
> +static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
> +{
> +	struct sock *sk = sk_vsock(vsk);
> +	struct net *net = sock_net(sk);
> +	bool found;
> +
> +	rcu_read_lock();
> +	found = vhost_vsock_get(cid, net) != NULL;
> +	rcu_read_unlock();
> +	return found;
> +}
> +
>  static void
>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  			    struct vhost_virtqueue *vq)
> @@ -424,6 +436,7 @@ static struct virtio_transport vhost_transport = {
>  		.module                   = THIS_MODULE,
>  
>  		.get_local_cid            = vhost_transport_get_local_cid,
> +		.has_remote_cid           = vhost_transport_has_remote_cid,
>  
>  		.init                     = virtio_transport_do_socket_init,
>  		.destruct                 = virtio_transport_destruct,
> diff --git a/include/linux/vmw_vmci_api.h b/include/linux/vmw_vmci_api.h
> index 41764a684423..c412d17c572f 100644
> --- a/include/linux/vmw_vmci_api.h
> +++ b/include/linux/vmw_vmci_api.h
> @@ -37,6 +37,7 @@ int vmci_doorbell_create(struct vmci_handle *handle, u32 flags,
>  int vmci_doorbell_destroy(struct vmci_handle handle);
>  u32 vmci_get_context_id(void);
>  bool vmci_is_context_owner(u32 context_id, kuid_t uid);
> +bool vmci_ctx_exists(u32 cid);
>  int vmci_register_vsock_callback(vmci_vsock_cb callback);
>  
>  int vmci_event_subscribe(u32 event,
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 533d8e75f7bb..0aeb25642827 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -179,6 +179,9 @@ struct vsock_transport {
>  	/* Addressing. */
>  	u32 (*get_local_cid)(void);
>  
> +	/* Check if this transport serves a specific remote CID. */
> +	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
> +
>  	/* Read a single skb */
>  	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2f7d94d682cb..b41bc734d6c0 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -210,6 +210,8 @@ static const struct vsock_transport *transport_dgram;
>  static const struct vsock_transport *transport_local;
>  static DEFINE_MUTEX(vsock_register_mutex);
>  
> +static int vsock_g2h_fallback = 1;
> +
>  /**** UTILS ****/
>  
>  /* Each bound VSocket is stored in the bind hash table and each connected
> @@ -547,7 +549,8 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>   *    g2h is not loaded, will use local transport;
>   *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>   *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
> - *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
> + *  - remote CID > VMADDR_CID_HOST will use host->guest transport if h2g has
> + *    registered that CID, otherwise will use guest->host transport (overlay);
>   */
>  int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  {
> @@ -584,6 +587,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>  			 (remote_flags & VMADDR_FLAG_TO_HOST))
>  			new_transport = transport_g2h;
> +		else if (vsock_g2h_fallback &&
> +			 transport_h2g->has_remote_cid &&
> +			 !transport_h2g->has_remote_cid(vsk, remote_cid)) {
> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
> +			new_transport = transport_g2h;
> +		}
>  		else
>  			new_transport = transport_h2g;
>  		break;
> @@ -2879,6 +2888,15 @@ static struct ctl_table vsock_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= vsock_net_child_mode_string
>  	},
> +	{
> +		.procname	= "g2h_fallback",
> +		.data		= &vsock_g2h_fallback,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  };
>  
>  static int __net_init vsock_sysctl_register(struct net *net)
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 4296ca1183f1..de3dff52c566 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -2045,6 +2045,11 @@ static u32 vmci_transport_get_local_cid(void)
>  	return vmci_get_context_id();
>  }
>  
> +static bool vmci_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
> +{
> +	return vmci_ctx_exists(cid);
> +}
> +
>  static struct vsock_transport vmci_transport = {
>  	.module = THIS_MODULE,
>  	.init = vmci_transport_socket_init,
> @@ -2074,6 +2079,7 @@ static struct vsock_transport vmci_transport = {
>  	.notify_send_post_enqueue = vmci_transport_notify_send_post_enqueue,
>  	.shutdown = vmci_transport_shutdown,
>  	.get_local_cid = vmci_transport_get_local_cid,
> +	.has_remote_cid = vmci_transport_has_remote_cid,
>  };
>  
>  static bool vmci_check_transport(struct vsock_sock *vsk)
> -- 
> 2.47.1
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


