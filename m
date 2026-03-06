Return-Path: <netdev+bounces-264803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFMPH43aqmkZXwEAu9opvQ
	(envelope-from <netdev+bounces-264803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:45:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85B222004
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4941A305615B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F930E858;
	Fri,  6 Mar 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Ptfgiv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AF21D3F3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804552; cv=none; b=rLBNln6tb0Hkbnbe8r4/j1W4bgYLzIrbVLVICw/rlmsW0+A5E1rd3UJoapvRWzxDBaEn9kw9lqM7uzXBn5lxAqB+c6SGFAbOVLp92NUa+FJA3sz42lhfpbEquh8RJn7mVJT0vrvsAdDqLqQ5QZzfZ3eFJJrdIDr7kF6RRX7TaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804552; c=relaxed/simple;
	bh=23e2vXZ+LPwii7CBOaBMLFQqrS73W1YmdWJ9Cli7Hoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QydY929oZiGi6hmS/OmmPiZ/71o+/Bmfi3+AsRdkBJh88tfuBa7Ol9DTrWBZI35HCHUNjqbftCRqvreUqEJFuJIjPMwcipGdNErk1ND2Lf/gCjmP8x1jCgn4LqYcDvxY41iCICm96MpAEZzThTOXL3AVJ4ru+j6unWttyQ6951Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Ptfgiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC650C4CEF7;
	Fri,  6 Mar 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772804551;
	bh=23e2vXZ+LPwii7CBOaBMLFQqrS73W1YmdWJ9Cli7Hoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4PtfgivqSO5bHN27uUYAlkze4+GpA/mYQUgJt6cysLhk4fsgavBVcy+Xq/leZGJI
	 5o7/W0LUJlHfqv6NSPHW1eRcG+V9hfNCHqGQ505gLC69LYx2ADuhnWZ0Z3xk2d7HCs
	 /Vlo+yScz7BRLVL+7Ss185bjTw3t9BFolWKrezoVn0yQkg7TTZL7sKOMrtirFi1sd9
	 8UqAIzLo6ETemq294i3zODWwk6StVn0Akv7H8hHNV2L3C0Kh/19qdfn/XuZGBOhpBm
	 97pdm1PhFlfFUpsg4wVEyUvZCl9b4gOXeYLiIUb7gjwkbjjnDdcct9rGV9OJ4oKL3e
	 xd0hIyxGBEwUg==
Date: Fri, 6 Mar 2026 13:42:26 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix GDM2 loopback configuration
 for USB serdes
Message-ID: <20260306134226.GD461701@kernel.org>
References: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
 <20260303141624.GD71509@kernel.org>
 <aaftUXaSD0u5ZhO7@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaftUXaSD0u5ZhO7@lore-desk>
X-Rspamd-Queue-Id: 3A85B222004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264803-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:29:05AM +0100, Lorenzo Bianconi wrote:
> > On Sat, Feb 28, 2026 at 01:20:33PM +0100, Lorenzo Bianconi wrote:
> > > Flow Control source port mapping for USB serdes needs to be configured
> > > according to the GDM port nbd parameter. This is a preliminary patch
> > > since nbd parameter is specific for the given port serdes and needs to
> > > be read from the DTS (in the current codebase is assigned statically).
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Hi Lorenzo,
> > 
> > Is this a fix? If so, should it have a fixes tag? And be targeted at net?
> > Otherwise, perhaps drop the "Fix" from the subject.
> 
> Hi Simon,
> 
> This is a preliminary patch in order to completely fix the loopback
> configuration for USB serdes but the point is we are not supporting
> USB serdes upstream yet (there is only OpenWrt support available at
> the moment). Do you think we should target net-next or net in this
> case?

If there is no bug in net - given the way net can be used with in-tree code
- then I would not tag this as a fix.

> 
> > 
> > Also, I think it would be worth explaining the situation
> > before and after this patch.

...


