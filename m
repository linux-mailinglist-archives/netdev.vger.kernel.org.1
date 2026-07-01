Return-Path: <netdev+bounces-303773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQLQE+lFRWp89woAu9opvQ
	(envelope-from <netdev+bounces-303773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:52:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8F6F0039
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WrpsmCrQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303773-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303773-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AD9C304C6C6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE06363C51;
	Wed,  1 Jul 2026 16:52:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7C74C14
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924774; cv=none; b=HjNCvHewcfPTvUppU9KvCiR0Z+SuMBiPYzKE22XesEJGzKrES6TIIwSulcmjZw6iVM3ICkuuT2xpD8wmlbKxVepVIHQ/pae4/q7wZGfl7tl/FDwu8yKE5vgNI15uK424I6kPuhvloSJD0maGKrAY6IG8AbWUa0SpoBfQXYBL1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924774; c=relaxed/simple;
	bh=Dz8kTN70W3L+Sk+HAaubQUYve70cutY2iRqakMGIShI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B92KsInN+Q++i80TkaBMy/0sJkNFGXtbpLhwpOH2/cQq6htc58eths3GLuWzzCSHK2NqoL1fzW/yQVqXOkGwfDIg5cKC6sgjaV6bgnU/aO9FxxKXFapySjkZ7kMr/SZlysmq1ncaFTWtVAcDE9NfDZwlsmlGm7fqD8PF+SC6RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrpsmCrQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1731F000E9;
	Wed,  1 Jul 2026 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782924772;
	bh=9f3HsoZhegQkvZD4sAPGBQcit7uabQJZUSLKyvMV5oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WrpsmCrQkS3yPEsZ4yE1ldUagMmb6y/nDU1LATuI64LVBF6dJgMdyvBKXlBW90nba
	 3SQJtweYPm+GfP7W7+b2doM6dPVn/xL/pgJQJTVxw9ISunpbm0qSI05DayVAo/STqO
	 MkcN2HgIu+zjgaA/mgbV7/P2WcZxC27VUqC0K+9CWUUrtvflZqYk4FaV61/RMILLz+
	 bqwlLqkSME0cvlrpeH81Cs2tYg1uAqFtphcUbmVRjQgdodcGSvNRXgo1h254GVNRrG
	 2nBoLhDTP+MXkx6lIg0I/1GJaP0arUrLqMKmXtp/EHTDEcj9qxFcoin3CPdCd4Hmnl
	 3qcdkCh3QCVuw==
Date: Wed, 1 Jul 2026 09:52:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked
 rationale
Message-ID: <20260701095251.11ec675b@kernel.org>
In-Reply-To: <akU2Hupq1wlJ-5T3@devvm7509.cco0.facebook.com>
References: <20260630182129.1601784-1-sdf@fomichev.me>
	<20260630182129.1601784-7-sdf@fomichev.me>
	<20260630164336.1350403f@kernel.org>
	<akU2Hupq1wlJ-5T3@devvm7509.cco0.facebook.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-303773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6E8F6F0039

On Wed, 1 Jul 2026 09:02:27 -0700 Stanislav Fomichev wrote:
> On 06/30, Jakub Kicinski wrote:
> > On Tue, 30 Jun 2026 11:21:29 -0700 Stanislav Fomichev wrote:  
> > > +Many ``NETDEV_UNREGISTER`` handlers release their lowers with
> > > +``dev_close()``, which takes the instance lock itself. Holding
> > > +the lock across UNREGISTER would deadlock.
> > > +
> > > +Moving UNREGISTER under the lock is mechanical: switch those
> > > +callers to the ``netif_*()`` lock-held variants. Deferred to
> > > +limit churn.  
> 
> > Doing anything with the device that is sending the UNREGISTER
> > sounds odd, since it's going away..  
> 
> Looking at __bond_release_one, it does try to restore a few original
> settings, mostly mtu, I think? (And it does call dev_close unconditionally,
> that's fixable).
> 
> bond_netdev_event
>   bond_slave_netdev_event(slave_dev=event_dev)
>     __bond_release_one
>       {__netif,dev}_set_mtu(slave_dev, slave->original_mtu)
> 
> Or am I misreading this part?

Oh, I see. I guess it's pointless to restore on unregistered
device but I guess it's not illegal so maybe not worth the
complexity of a skip..

> > Not following TBH. Let's say there's a UNREGISTER ntf for eth0.
> > Are you saying that eg. vlan which closes their own vlan0 devices
> > on top of eth0 needs to be switched to netif_ ? That wouldn't make
> > sense since the notification is holding netdev_lock(eth0) and
> > we're talking about netif_close(vlan0)?  
> 
> Maybe rewording it to `... UNREGISTER handlers interact with their
> lowers using dev_xxx handlers which take the instance lock` ?
> 
> I'm mainly looking for an excuse/explanation on why UNREGISTER
> is not converted in this series. Or should I bite the bullet and
> add a few patches to make UNREGISTER ops locked as well?

The documentation is fine. Just need a better phrasing, I guess.

