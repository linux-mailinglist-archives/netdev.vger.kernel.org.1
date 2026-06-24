Return-Path: <netdev+bounces-301787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPYNJ51TPGrxmggAu9opvQ
	(envelope-from <netdev+bounces-301787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:01:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188C6C1AA0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:01:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iAg8OWHA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301787-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B7C530AB0E9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007D1A5B8C;
	Wed, 24 Jun 2026 21:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0D301471
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338245; cv=none; b=jBL7uO6UQxFNBMTHBONtS7r6n67iA9OcQhEVYpLlQEe6qkzftggnHsRQBsIoqQlTx791D/4tS9VPLB0nG8+VOPfiZ/gksf/ECe1IAcv4iz/UB3/2RV0b3B7/QFd86wTbpAscSjYx2F0fy02mMGcOPbZqk+yhlJhFhHxPWYl5/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338245; c=relaxed/simple;
	bh=4mfVEXiH3zGibiAacdrBHs1v9yulRE/XswRrmGjcdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJr06deHGkHhFEul3kPFM/zidK91H9k4f14ED+vvnEEbyrqsotRVObKE+y4ENG7+FqyIGskV4oM4NaDiyjwun29CNimm16YXKrCfei38CdHmVJpIb5IWzmqOf3obcly1D2lJ7aM30VNlf6gvKTHx0Q21XfHSkyl6RfcGnmPYpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAg8OWHA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA961F000E9;
	Wed, 24 Jun 2026 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782338244;
	bh=pzJlB/+ezaC7skZc6CnxUZMP37jpO4NWfrQxjOzHX1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iAg8OWHA06okxMKaAXkKAqrS7jJxOM0PQBLjZ+PuLjNI/RM0Gv026eNqYzMDlJQ/B
	 NQvBL3jcwszIy4gI3MKf5r8OcN3aWCSmPE1EsHOy0soADtplY4Kt3lzcMfcgbJP0Xa
	 dpnIfgP0pi41jxhPWQoj2uOWOoNs9sBp4HcB1xnysWkLxixnSYxTfZUsS35zvGTk9C
	 T2wxslJwPU/Yx7ec5CB/aeWIBHHYkHGxWEJJ/wRge59iURLrAUXv7/uqQ2/ciI1bL6
	 gLSD9mn32Pc9BeD+5eRdqwGKkQfNkIB56CQ3XYXls6LC14cj3qVgZtAYGZLQsnGxEV
	 YgmgbCk2VIFSg==
Date: Wed, 24 Jun 2026 14:57:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Yue Sun
 <samsun1006219@gmail.com>
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting
 udp_tunnel_nic
Message-ID: <20260624145722.083632b6@kernel.org>
In-Reply-To: <20260624171034.4117423-1-edumazet@google.com>
References: <20260624171034.4117423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1188C6C1AA0

On Wed, 24 Jun 2026 17:10:34 +0000 Eric Dumazet wrote:
> Yue Sun reported a use-after-free and debugobjects warning in
> udp_tunnel_nic_device_sync_work() during concurrent device operations.
> 
> The state flags of struct udp_tunnel_nic were originally bitfields
> sharing a byte, modified concurrently without locking (RCU vs worker).

Can you clarify the path where the bits are modified without locks??
My mental model is that this is basically all under rtnl_lock, and 
Stan added _another_ lock so that drivers can call "sync" / reply
without needing rtnl lock, but any changes are still under rtnl_lock.

The gap seems to be that we don't check pending under Stan's new lock,
since commit 1ead7501094c6 ("udp_tunnel: remove rtnl_lock dependency")
did:

+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -112,12 +112,10 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
        struct net_device *dev = file->private_data;
        struct netdevsim *ns = netdev_priv(dev);
 
-       rtnl_lock();
        if (dev->reg_state == NETREG_REGISTERED) {
                memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
                udp_tunnel_nic_reset_ntf(dev);
        }
-       rtnl_unlock();


so we just need:

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddf..d7db89a222f8 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -863,6 +863,7 @@ static void
 udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
        const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
+       bool pending;
 
        udp_tunnel_nic_lock(dev);
 
@@ -899,12 +900,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
         * from the work which we will boot immediately.
         */
        udp_tunnel_nic_flush(dev, utn);
+
+       pending = utn->work_pending;
        udp_tunnel_nic_unlock(dev);
 
        /* Wait for the work to be done using the state, netdev core will
         * retry unregister until we give up our reference on this device.
         */
-       if (utn->work_pending)
+       if (pending)
                return;
 
        udp_tunnel_nic_free(utn);



> Even after converting to atomic bitops, a single WORK_PENDING flag
> races: the workqueue core clears the pending bit before running the
> worker. A concurrent queueing sets the flag, but the running worker
> clears it, leading to premature freeing in unregister() while the
> re-queued work is still active.

> +	if (utn->dev)
> +		dev_put(utn->dev);

nit: cocci complains that null check is not needed here.

