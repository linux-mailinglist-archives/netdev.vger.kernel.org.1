Return-Path: <netdev+bounces-283420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFpWHKEF9mnTRgIAu9opvQ
	(envelope-from <netdev+bounces-283420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC14B242B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC3C300877B
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BFB2C11D7;
	Sat,  2 May 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vIZz3jWw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785F23B61B;
	Sat,  2 May 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730972; cv=none; b=oOAwkTLaHSQy8mn2H+AC97ylJiB6Y/CHXNV4o/SI6owcVxznJu+go93DOhkMpN15aZjTqC8nn54yRZtzKpg3H/j8pheHwt45/PAXnQEt5Q4e37+aH0UNsJzDIB0zN/qnPfdULx/W5LrzUkN4sEGLj/5F8k83uqbRpFXsgjbWxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730972; c=relaxed/simple;
	bh=B09zwj7cryl3QPErKbMRwXR3ybLh+M73vHQWw8AI+2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kua4nWSWXiobKuayvy8viWiAmVOyuLyyHSgekp5HnEpYa8ty0EFAcJEq4S54MpEJY5O3bIysMO5h38sQbTleA3ueQTAvO7ZNh0B2vAtXmef6j5FYdbadDA+CVhpmv5oKSElWX/MiU0BX7v0Colp7TJcwXoQWpf20NdHVYQtvWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vIZz3jWw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FQRQm1nnOTDCbfgDwi70nyakDXzEsbpSrbRp+qcYmUk=; b=vI
	Zz3jWw1obj85mCF3jW4RGVVAARYwG19G9saNncADM/mdZ30//sU9Sille6m+nbSj/EeA5a42ifVfu
	BD+Kjtc1u4YFQtH6dhWdoN4Aj4tNJE9+aVS8Seeod5m0rgw5hWQnebyitjTet7ytV6PvQPMsgCif7
	2qaDvC+uSze/hRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJB24-0011UD-Ei; Sat, 02 May 2026 16:09:24 +0200
Date: Sat, 2 May 2026 16:09:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F6rn?= Persson <Bjorn@xn--rombobjrn-67a.se>
Cc: Wang Zihan <jiyu03@qq.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v2] net: switchdev: fix duplicate word in documentation
Message-ID: <a5482c59-2a35-44ce-b112-9c07e8ca7892@lunn.ch>
References: <tencent_93F8CA2FB714A80C571AC978F39E51D6E506@qq.com>
 <20260502132446.5b2c51cf@tag.xn--rombobjrn-67a.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502132446.5b2c51cf@tag.xn--rombobjrn-67a.se>
X-Rspamd-Queue-Id: ACEC14B242B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 01:24:46PM +0200, Björn Persson wrote:
> Wang Zihan wrote:
> > @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
> >  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
> >  bond will see its upper master change.  If that bond is moved into a bridge,
> >  the bond's upper master will change.  And so on.  The driver will track such
> > -movements to know what position a port is in in the overall topology by
> > +movements to know what position a port is in the overall topology by
> >  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
> >  
> >  L2 Forwarding Offload
> 
> This change claims that a port is a position. The preceding sentences,
> talking about "a particular port's position" and a port being moved,
> make it clear that a port is *in* a position *in* the topology. The
> port is not itself a position.

I assume this is a fix to make a bot happy, without actually checking
if the bot is correct.

Maybe to prevent a recurrence of the bot driver not validating the bot
output, a ',' should be added?

    Andrew

---
pw-bot: cr

