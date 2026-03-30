Return-Path: <netdev+bounces-273384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COVlNGUKy2kNDQYAu9opvQ
	(envelope-from <netdev+bounces-273384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7510B362630
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7476300DF4B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81053B774B;
	Mon, 30 Mar 2026 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1VSOtlx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A53876B9
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914145; cv=none; b=J/ObKFnCWkbyim2y6DPUm7pJR+I6mjnnvo0COxUrukZsbJrI/mE3EruTeio88fXdz6KAkhnfP8Wb2IlHHt6+eADhZzg272h23+OTfrJvu6fmKvMRaHNd6tUnBWzvQ0OezUY5pigIZ+N+hncayttw29YeRzW0R+A5C1o6ZDeK7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914145; c=relaxed/simple;
	bh=aHrIbDCRF2C63qxAWklCYHcqyfF0RZoSgHISzrHOz9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLCP3EvH79WV9yh9Ygs0q59wkqPxVCyut2+MRQBX+MZiAcA97ctSvemM3uA7ejLhiVxvcr3An+axlnsOzlyH4kseAoDWYUbb7faIY3EgrW0gJErhh3tdM/isKYqK2Utg1DgVwe2+3Aw6AuH9wF1ON3xjsdrvvEGXmaXQVkRVz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1VSOtlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A5C4CEF7;
	Mon, 30 Mar 2026 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914145;
	bh=aHrIbDCRF2C63qxAWklCYHcqyfF0RZoSgHISzrHOz9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1VSOtlxR4oiyc2fLxazcaNC8M5IhUGTkgAvRrzVAWCqhFe4l8xQDBgzerxWvD0KA
	 yWFBZmBbHzI/fd2pbIxl+bGHyTikCvjZHZl/nhqo+sGe8MHIPYc8TeJuxZncvbUi0a
	 htsWUlWRkufWs4hN76gc2I3zO+jpCDDc6+FMCQZfDXX/tFu+rnlL5DoIEBT5OzYfSv
	 m4zXgSftUzB24MCIvy6YBxjiiFWih0qFSd2xUGU0/tt0ItYtavVyNGIH1kbtXsT3Rz
	 RsDSZ7wtmzNqH3qpLb2GhuYJ1XdMZZl0I02CawjX5SopRiB7etyHl9+kaTKSDv8g+o
	 0ffNP2TE7Zh/w==
Date: Mon, 30 Mar 2026 16:42:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Ong Boon
 Leong <boon.leong.ong@intel.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: stmmac: TSO fixes/cleanups
Message-ID: <20260330164224.0b75f251@kernel.org>
In-Reply-To: <acl0pTqJ97o0PRxY@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
	<20260329111123.740bada9@kernel.org>
	<acl0pTqJ97o0PRxY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273384-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7510B362630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 19:51:17 +0100 Russell King (Oracle) wrote:
> > While I have you - you have a significantly negative "reviewer score".
> > You post much more than you review. Which should earn you extra 24h
> > of delay in our system. I've been trying to ignore that and prioritize
> > applying your patches but it'd be great if you could review a bit more.  
> 
> Sorry, but given the effort that stmmac is taking, I don't have much
> capacity to extend mental cycles elsewhere.
> 
> This two patch series wouldn't have exploded into ten (or maybe even
> more) patches had someone not pointed out the problem with
> suspend/resume interacting with disabling TSO... which prompted me to
> look deeper and discover a multitude of other problems. Should I
> instead ignore these bugs and not bother trying to fix this stuff?
> 
> Honestly, I'm getting tired of stmmac with it sucking lots of my time,
> and I suspect you're getting tired of the constant stream of patches
> for it - but the reason there's a constant stream is because there's
> so much that's wrong or broken in this driver.
> 
> So either we let the driver rot, or... what?

I was hoping to nudge you towards reviewing more rather than have you
slow down TBH :) Your patches are generally excellent so not a burden
for my PoV. And stmmac is a toilet, a very popular one at that, so
efforts to clean it up are most appreciated. If you could review a
couple of series every time you post - the balance should be restored
to our tooling universe.

