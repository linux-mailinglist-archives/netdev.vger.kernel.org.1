Return-Path: <netdev+bounces-275764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PxlIdMz1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F43A7DD1
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256DE301D0A8
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D339F16E;
	Mon,  6 Apr 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPGFD3UX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5E39E16B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514565; cv=none; b=t9P2YE/28VOzJRD7KOHqSogPIQSEw/yy70Z4ueyqt7Klg3hbCCmn8IsyDOP1olptgSTrsM7U+OPjbLEYDVzOZG5P855ONXIT1BHfBrqHeTOSofxo6PcdK3xSZtfpYRe36Moth+o5jfY5IkNR4mS3c4BU4jqoc6h9m88vt95OlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514565; c=relaxed/simple;
	bh=Ac1l6PCYlaOpQPtsc4BOfIozfTrQgEPIItTYL5JqsRM=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=L240MxiFWDVe1baCHr/a10q3so4P+9XJ1KpGBrwoQTxup4bkMuoUPHC+/hZSmxGLxyT8oWxBFilSk9+Ct+CmB4t2AB9TbVPunPw5LK5eZYY0vGmyTzkjzWFlbQIR6AhdBDiA5po3xetOgjtuPVr74e/lAERTJPkHGIWGtC0tkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPGFD3UX; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4710c186d8aso473853b6e.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514563; x=1776119363; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmQZqTXyDK0XMBr0sE1cCiBEnu+y/thLc3GWNyri0ck=;
        b=RPGFD3UXZWGUcbIvBQDdOndkrVptv1qJ4GH90qj3+YD+7pvHBLjzpzhGX2jWf49327
         gohRvcVO6TtN8MCIdhAnmhMAoZ88uH+a4IgSkksMPnTB9cCdTcbkha0dUb0r48iDfV7D
         k4RIGejumHtLKiUjbcni2aUfaNhP1mj6ZOwJwUK/+ln/7vLDyD/X6QaD/iHTxCaf+xPC
         77n5eLcjUj2w1dLRIRO6oiHymaHnZuXRAGnkFRcSoDJNLWRolZnCIKDfJigY+Hg27Z54
         DoI6MQJ+oNAzAqsox4+9UKTfheunIV/bnrA2S6n3yTdvjIGpjcAPKg7Zj9QTRw62RxUQ
         ey4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514563; x=1776119363;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmQZqTXyDK0XMBr0sE1cCiBEnu+y/thLc3GWNyri0ck=;
        b=rcaKuSbTFnRj2I06//jtHxcE2bayDBNokZ8MZYm47G4wk8Ohbh5h2hWyybG2fmvOFE
         HjBG8SYt4oclgnTUOGA5NcoW749/nemhHvNdK3PNbcmbK3IhprJqs0X1zQ4WVNBCKB8G
         fBm2rPtE3qsib9WSBwsAPAu63M5+gsZViR97AvmqH5OcC7nPYE5axvq5zSV141RFzzbr
         5a493Rmq5tTCOF0Def539a11yNkmZ3G+wLkp+JI0gdJmWs1p0CxMi0+uGRykzvjik/Jw
         nfOkqE8Zc2nyjszizzNPRD7AGAUzVxD3FGUUPX0vQjLQhh6iBnV8dZMbXjNfsC39OqQl
         ckRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCG4mT+Qh47ldaY9mAUwdcC5foWAFWek1wyXHYihP+kcaUBTCbgYVsXlF7zCEoxc0EWfiqKrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIE/8Hk/vzOp+C2psTqAeIV26bqhNP0KNDZmV7B+jtrdRhyd/
	Eg5yqigQfCAWmhiNqelQETDV9OTBFXvOhCxbpM+AAk9UyyvAcN6q/Luv24kLOs6MD0o=
X-Gm-Gg: AeBDievjfHG5ZHTdpjzdjSnupl4jtSMXxYEjL35htvHZx2gFH23Q7Vb27cFSiVDdn20
	ifVmRFNC5X+7seMHV4Y+cmA9/1BJKeuGHCGE+tQjrUFCJpHKq6DSFFViLv349hAC48Y1KKzh+Jg
	l2yRVz75hwMyEonTFBUMkMVvyl1HAgSY81XXrjb1gyrb6TGr/+qiord8XjpDIIfAzfVImlC7DLH
	5/dtw1hih0J+YR2zcRcK6zrLdF4M1WtkdLJsDhXZonftOpvJL1ICBbOjOCzedHuH5j/4HguJBXf
	qkmMBB60Sw+hAX7y7R+X9R0Xwt4gK5k1VHmfMXBD70717Q+xeATEMdA56ioyFexgBD9KAEv/uIp
	apoOTF5KXsbBFseQ5KBs/weouV9Lu56BTQwjVfWDuiQzy2BhlYB2EfS3ne1e3tAZgjo6CaWuTh0
	MXZMOE0wW3OI/HPNaDkA==
X-Received: by 2002:a05:6808:1511:b0:467:3f4:9073 with SMTP id 5614622812f47-46ef59f3b78mr7509562b6e.16.1775514563325;
        Mon, 06 Apr 2026 15:29:23 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25a55asm12873299fac.10.2026.04.06.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:23 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:22 -0700
Message-ID: <cb163dc696c885556acea5f6fe2879ac.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000604.2413879-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 02/14] net: introduce ndo_set_rx_mode_async
 and netdev_rx_mode_work (61d75e67dcd2)
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275764-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 367F43A7DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
> 
> This commit introduces an async variant of ndo_set_rx_mode that runs from a
> workqueue, allowing drivers to sleep during RX mode changes. It also adds
> netif_rx_mode_sync() to opportunistically flush pending updates before
> returning to userspace.
> 
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> [ ... ]
> > @@ -12217,6 +12178,9 @@ void free_netdev(struct net_device *dev)
> >  
> >  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
> >  
> > +	if (netif_rx_mode_clean(dev))
> > +		dev_put(dev);
> > +
> >  	/* Flush device addresses */
> >  	dev_addr_flush(dev);
>
> Is this cleanup reachable during normal shutdown?
>
> When a device is queued to rx_mode_list, netif_rx_mode_queue() elevates its
> reference count via dev_hold(). During unregistration, netdev_wait_allrefs()
> blocks the system until all references are dropped.
>
> Because of this wait, the system shouldn't be able to reach free_netdev()
> until the worker thread has already dequeued the device and called
> dev_put(). It seems the device is guaranteed to not be on the list by the
> time this code executes.

I guess, yeah, we can drop this. netdev_wait_allrefs waits for all refs
to go away, so this is not needed.

> 
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> [ ... ]
> > +static void netdev_rx_mode_work(struct work_struct *work)
> > +{
> > +	struct net_device *dev;
> > +
> > +	rtnl_lock();
> > +
> > +	while (true) {
> > +		spin_lock_bh(&rx_mode_lock);
> > +		if (list_empty(&rx_mode_list)) {
> > +			spin_unlock_bh(&rx_mode_lock);
> > +			break;
> > +		}
> > +		dev = list_first_entry(&rx_mode_list, struct net_device,
> > +				       rx_mode_node);
> > +		list_del_init(&dev->rx_mode_node);
> > +		spin_unlock_bh(&rx_mode_lock);
> > +
> > +		netdev_lock_ops(dev);
> 
> Can this while loop starve the system of the rtnl lock?
>
> Since userspace can trigger RX mode updates via ioctls like SIOCADDMULTI
> while holding only netdev_lock_ops() and not the rtnl lock, a continuous
> stream of these operations could repeatedly add devices to rx_mode_list.
>
> Because the loop releases rx_mode_lock while processing but retains the rtnl
> lock, could it run indefinitely if the list is continually replenished?

Idk, this seems overly paranoid, the same work would happen under rtnl
on the main thread if we don't do a async callback.

> Additionally, does the order of list_del_init() and netdev_lock_ops() create
> a race condition with netif_rx_mode_sync()?
>
> If the worker thread dequeues the device and drops the spinlock, it might
> then block waiting for netdev_lock_ops(). Meanwhile, an ioctl thread
> holding netdev_lock_ops() might call netif_rx_mode_sync().
>
> The ioctl thread would call netif_rx_mode_clean(), which checks
> list_empty(). Since the worker already removed the device from the list,
> clean returns false. This causes netif_rx_mode_sync() to act as a no-op,
> allowing the ioctl to return to userspace before the hardware update
> actually completes.

The worst thing that can happen is we re-queue empty work. I don't see
how we can return to userspace without having a sync update.

> 
> > --- a/net/core/dev_api.c
> > +++ b/net/core/dev_api.c
> [ ... ]
> > @@ -311,6 +313,7 @@ int dev_set_allmulti(struct net_device *dev, int inc)
> >  
> >  	netdev_lock_ops(dev);
> >  	ret = netif_set_allmulti(dev, inc, true);
> > +	netif_rx_mode_sync(dev);
> >  	netdev_unlock_ops(dev);
> >  
> >  	return ret;
> 
> Does this correctly handle cascaded updates for stacked devices?
>
> When operating on a stacked device like a VLAN, the RX mode update cascades
> to the underlying physical device, queuing the physical device to the
> rx_mode_list via __dev_set_rx_mode().
>
> Since netif_rx_mode_sync() is only called on the stacked device here, and
> the stacked device itself is not on the rx_mode_list, will the physical
> device's update be left on the workqueue? This seems to bypass the
> synchronous update guarantee.

Yes, this assessment is correct in general. Not sure we want some new
netif_rx_mode_deep_sync or (probably better?) add some netif_rx_mode_sync
calls where appropriate. For now, leaving netif_rx_mode_sync in a few
places and planning to add more netif_rx_mode_sync if/when issues with
deep hierarchy syncing arise.

