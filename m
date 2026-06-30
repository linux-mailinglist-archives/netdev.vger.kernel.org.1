Return-Path: <netdev+bounces-303187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQO6NCrIQ2rphgoAu9opvQ
	(envelope-from <netdev+bounces-303187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF716E4FC8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:44:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=POwvNRo9;
	dkim=pass header.d=redhat.com header.s=google header.b=O8iDckx2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C72306FD60
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82DE38236E;
	Tue, 30 Jun 2026 13:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F7346E57
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826818; cv=none; b=cXdaxqiatlG4oqpnmmytfpuwIbyPtT5FNi9FYFNyXE9fxYHKbWdUj4D8lL2EgUeeu872xoOxTALaYUn3kOM1YWB3u5HWFOnPvuWsotaoBC8A8901pyesqDGf2UL5MOzIYJmJMrBn7y+jqAcTxI3kFqMlcaUfyjFmYwzm4nCcPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826818; c=relaxed/simple;
	bh=+uAe7+vHveJ9Xr7bLTlrloHySuIi1wTIpGjyEF60J/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqdqhkdpULSWpMPd6tbPZNJGySM0243dviURf3AhyhHMLegtsmbJSrqlpORF/1o8xMOhlMMlmIw2JtitOrYIephS/dnMPoYkKD82OuwFnSEx3wVr9BYLBWgCWftRznaHNbb3eUqJ/3mCMalmmT0RM2vfdO7zCs6GwTs52WVHWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POwvNRo9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8iDckx2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782826816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
	b=POwvNRo9kk0jwef3bP/qV41SpRKSTN0P/LzAP8JEfKBuVXI5D7eIY/0ekwJ6LqbkIG3uH+
	dBBSn//GOM3HOlBgusa+HG3fkGkA9MhlGhmn9xun+fi5L1aby2J855yqB487L2vM3zMRUt
	KJOSZ9O6huqpi3aH+nPqQd/g9O4rdcA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-aFuhRXKgPiKqc6WSknt9IQ-1; Tue, 30 Jun 2026 09:40:13 -0400
X-MC-Unique: aFuhRXKgPiKqc6WSknt9IQ-1
X-Mimecast-MFC-AGG-ID: aFuhRXKgPiKqc6WSknt9IQ_1782826812
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-472a798fc7cso1558621f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782826812; x=1783431612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
        b=O8iDckx2zgI6tlFnSTYgIu/ISUk0PehAz/seSGxqw0E2VqRIggAXAZN69zmQMYD8E6
         Ka6/UgoC8EdzW5z8LbXZpQfhiL/wN7PetWCt85dR4yNp7R7tn1Q7s5EmUGNvoeAJ2hRd
         Qv8PRBaF/mpD2TXl5K5tcvgVnAeqxrI7yNRvkSNAruM2UpOc3vDoc4AxMDRlIkpMyD+7
         zxObV9SS6VgmJAFZb5lQhybdb4ttbvMwCnGPkxy4zMHuR9jlkd2vb5BGkvWXP/xc1S8O
         1rjQ20+8sTxTCy6yfkVKlJ440bL63AZ6r1Nb8QCTJLyxHLmS2+HxkFCBfX55Dft4c3i4
         9Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826812; x=1783431612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
        b=RAQbctLOXJeJAIdlhJnX74bYHV2R8UuF6J31tdKvIDOGmNIdRmPKiXUEjbtgbvTfBI
         GzjR3YF0iCFDe0KV4ReN0Vo3w8hO+OiYhLqomZ3nihi9l4sGB7OQz+EQiiuXT8NWPVqj
         OVvBy4Oqgli6/WoFBjrfqodb+c6TXI4/Pga6cMCfCZIc2ba6kjAMXmGNnKe5sKdy2Fyk
         De3Ya66mfT9B9OTcYXXET/Q0hc1hXFOJSyzOF/HT183WRZVOz2o4yeMw2xQgvKHx+SKk
         W/5f7FpwDhXI0WxBoWhaqKJY2vHFINBsWDUQIPsJAx53R58aJuNkervBn98tgzkdiMIW
         sY2w==
X-Forwarded-Encrypted: i=1; AHgh+RqBNNbshg4Eqy6y3THMnsh7MH3rrTzPQ5I1yuaph7n86bCyIgevY2NF/E0Xpzfqdv1sUKbzBII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/ojxaoVQBVKj2Rg3YB78szzJqC9bAVogMoHas/X/Cnm4Hyz4
	Y5lcIvRh7p12zF2CnJxS7+8xAerte6pK083HYZlo5sFJu06rGixBTtH6U9krNwk/64+kFGlMlva
	QC9jKhMjUoy5gNMk9D4lIkmEsDruoTVVZgwXk7/gVlRjFlkCoicOPjPgFLQ==
X-Gm-Gg: AfdE7cn+MplWcIr37rkEJdh3BDO4yuOyZ5ZYSEkJXMuYxq8mlhgTvYilOesda/2YJ4R
	zf97CUtTZp8n3ikMXXjCaafT4UEectxO7/290O3wJl7QE4kSkumlWwkct9moXmp2LtOSi1PScQF
	H3Opu1mS3fX7R5lOBVtV6PKjWymuDQmbC2DLNo9fzufpcuJfVQgxPVRImBty8LgssCQhlu6olXi
	wgkOyyZFE4aRTZMCUtkSKX+NEXbhW9r/zBmiRlBuhwyYBJHhXLCT7bjrf8n2LujW2R++NYqCw2j
	8McraTRj4ssdG3XUNaxaKb7Zsfl9yHjWItiG18SyGbRTJeKuurXvivJk1ZF1oJUG15sghryDXLy
	Ek1ARGMkzx36x36SSx0ow8+gT1ZRQuA9ukdqoeDNxMeoDh8LEWorpxcauPxvQ
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841839f8f.49.1782826812369;
        Tue, 30 Jun 2026 06:40:12 -0700 (PDT)
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841772f8f.49.1782826811836;
        Tue, 30 Jun 2026 06:40:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm8461092f8f.35.2026.06.30.06.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:10 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <akO6tps94iFxCAWv@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303187-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF716E4FC8

On Thu, Jun 25, 2026 at 06:54:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>RESET_OWNER keeps the guest CID hashed, so that connections survive. That
>leaves the device reachable by a lockless send/cancel path while the worker
>is being torn down: a concurrent vhost_transport_send_pkt() or
>vhost_transport_cancel_pkt() can call vhost_vq_work_queue() as
>vhost_workers_free() frees the worker.  That might cause a use-after-free
>of vq->worker.  In addition, any work queued onto the dying worker leaves
>VHOST_WORK_QUEUED stuck, stalling send_pkt_queue after resume.
>
>Fence the send/cancel paths around the teardown: send_pkt()/cancel_pkt()
>only kick the worker while the backend is alive.  And reset_owner() calls
>synchronize_rcu() after drop_backends() so in-flight send/cancel finish
>before the worker is freed.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 51 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 49 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 81d4f7209719..f0a0aa7d3200 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		atomic_inc(&vsock->queued_replies);
>
> 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>+
>+	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
>+	 * stays queued and vhost_vsock_start() drains it. Pairs with the
>+	 * synchronize_rcu() in vhost_vsock_reset_owner().
>+	 */

Please explain better (as done by commit bb26ed5f3a8b ("vhost/vsock: 
Refuse the connection immediately when guest isn't ready") in the 
comment removed by this seris) why we can use vhost_vq_get_backend() 
without vq->mutex held.

>+	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
>+		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
>+				    &vsock->send_pkt_work);

BTW I'm now confused about what we are preventing here. A better
explanation should be added both in the commit and in the comment,
because it's hard to understand what we're preventing.

That said, if there is a problem, perhaps it should be fixed in vhost.c,
because it seems more like a generic issue.

vhost_vq_work_queue() has `worker = rcu_dereference(vq->worker);` so
should already prevent UAF, no?

Or maybe vhost_workers_free() is missing a synchronize_rcu()?

>
> 	rcu_read_unlock();
> 	return len;
>@@ -346,7 +353,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 		int new_cnt;
>
> 		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
>-		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
>+
>+		/* Skip the kick once the backend is gone (stop/RESET_OWNER):
>+		 * vhost_poll_queue() would touch the worker which is being freed
>+		 * by teardown, e.g. on RESET_OWNER.  Pairs with the
>+		 * synchronize_rcu() in vhost_vsock_reset_owner().  The TX VQ is

Ditto about the comment.

>+		 * re-kicked by vhost_vsock_start().
>+		 */
>+		if (data_race(vhost_vq_get_backend(tx_vq)) &&
>+		    new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
> 			vhost_poll_queue(&tx_vq->poll);
> 	}
>
>@@ -903,6 +918,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)

Why returning int?

We are defining err as long here, also the caller vhost_vsock_dev_ioctl()
returns long, so it is not clear to me why here we are not just
returning long.

>+{
>+	struct vhost_iotlb *umem;
>+	long err;
>+
>+	mutex_lock(&vsock->dev.mutex);
>+	err = vhost_dev_check_owner(&vsock->dev);
>+	if (err)
>+		goto done;
>+	umem = vhost_dev_reset_owner_prepare();
>+	if (!umem) {
>+		err = -ENOMEM;
>+		goto done;
>+	}
>+	vhost_vsock_drop_backends(vsock);
>+
>+	/* Let in-flight send_pkt() callers stop touching the worker before the
>+	 * flush + free below. Pairs with the backend check in
>+	 * vhost_transport_send_pkt().

This is also paired with vhost_transport_cancel_pkt(), so please update
this comment.

>+	 */
>+	synchronize_rcu();
>+
>+	vhost_vsock_flush(vsock);
>+	vhost_dev_stop(&vsock->dev);
>+	vhost_dev_reset_owner(&vsock->dev, umem);
>+done:
>+	mutex_unlock(&vsock->dev.mutex);
>+	return err;
>+}
>+
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 				  unsigned long arg)
> {
>@@ -946,6 +991,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&vsock->dev, features);
> 		return 0;
>+	case VHOST_RESET_OWNER:
>+		return vhost_vsock_reset_owner(vsock);
> 	default:
> 		mutex_lock(&vsock->dev.mutex);
> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>-- 
>2.47.1
>


