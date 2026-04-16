Return-Path: <netdev+bounces-279164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKRWDedN4WmargAAu9opvQ
	(envelope-from <netdev+bounces-279164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF73414C12
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2797B307A43F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2D257423;
	Thu, 16 Apr 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lEjrMKUR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733713B293;
	Thu, 16 Apr 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373220; cv=none; b=uRku3Q4Z6gPLQBNVaI8PmB1ZiO0Nc5t8vbzMW0wRyQyttAoxGNHq04XKGUnjbNUu8DfpdadlcIk5yqOCT/yL7e+SvjE5olehbgjnKFwQGGypEAvLlrNE5+LpMcdXd3doCGkfKgjc+WYvL9DQU4CkiRiqDu3xXHlMNstEfigWzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373220; c=relaxed/simple;
	bh=l6tWonJhNRitEZUM0aO2ED7tdvgNhAQDcKG1h6PhP4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocJoili8RvRreg5IU5eWWyvHhPeg0BPRUZTtUhOgD9vB4gu41hhlnch1afSjYo8FjFwS7Y6LgXW/DuluvzPLC6rlcRLXnAH9roLzfbQZI9WJVsRzLi0k41fC+bPnoapoMUjL4+a9ZUQ/iIyFAtBDy88P7FOdSSuTS1K8gfdfH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lEjrMKUR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gXgn6eoujwLv7Iy7kfejXZL9tjhkIHMNFB/0XoP3Qso=; b=lEjrMKURpfOzzAu05stPV9BZ2M
	mcH0Kkw7YVgYUBlfZ3l7jIzsZJ7vnFNvUyIGABcZsw1n4Kn/AiOcZ2TMW+ZgUMCWHkxf31cYU2giL
	2wrsdIKl7VYS/MtBR5Y2m5JFAK/BkA8ieVBZwk5YLfswHctPbnh/5J0QEzpz57Kt2FkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDTof-00GKZq-DN; Thu, 16 Apr 2026 23:00:01 +0200
Date: Thu, 16 Apr 2026 23:00:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <1873b5ba-419f-4247-ab92-1b5e899458e8@lunn.ch>
References: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279164-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 7BF73414C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:31:39PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs before
> calling phylink_create(). When phylink_create() fails the error path
> calls xpcs_destroy_pcs(pcs) to release the PCS, but neglects to clear
> fbn->pcs.
> 
> The caller, fbnic_netdev_alloc(), responds to the failure by calling
> fbnic_netdev_free() which in turn calls fbnic_phylink_destroy().

Isn't the real problem here? fbnic_phylink_create() failed, and it
correctly did its cleanup. Because it failed, you should not be
calling fbnic_phylink_destroy(). You only call the _destroy() if the
previous _create() was successful.

    Andrew

---
pw-bot: cr

