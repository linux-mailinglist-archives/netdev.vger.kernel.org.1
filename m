Return-Path: <netdev+bounces-289642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIpLrXoDGpnpwUAu9opvQ
	(envelope-from <netdev+bounces-289642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF4585D16
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 013D130036EA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E233D515;
	Tue, 19 May 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIoGyJ1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E67233924;
	Tue, 19 May 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230787; cv=none; b=KTZTqdfn9OosGFq6LJ3v+RojAp9KmHHPLAK1eju8G5jOeZaWVgzDyG8vyoqHKSu9FbyZEDMD4X5cbJG6dSBydbv2DomyA9fJ/zR2m/TJS1f/H3n8krQMMSi8l1j21PDfuQiewi9AXAC4HNKiCPEdAYAc/6U6OVqU76YWU5jyRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230787; c=relaxed/simple;
	bh=CCPmPTbfFv5he77EFc/fjGyY6j6WEa645ygiEI0mMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFdl9Qu+zznFQidMiydTfEJITsYWO61+8LBH0b3y7D0UEhQ6/ptSzFu5O6YcXXY10njyS72UnAxW7HdKLvmT/Gh1VCFgKRkARhiMbUFka0WsKGhKS01gn3lfl16hFWyzhMzMuiQfCSRcrAHmGVShRlAHttULc1AJLL8ThAMQDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIoGyJ1Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61891F000E9;
	Tue, 19 May 2026 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779230786;
	bh=9dxkO42r5a+IWZjuGgvUPHesx13P6vVGJsquyNsJLyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gIoGyJ1ZP7MOqHD05kodIcTJaOWhFpxJygkgkE4y0wUtgmRaixFCq5u9L8dPAHqwc
	 5JLeNUIimJIyAbrQ/CebvSc7//r04PwUmaa/axybfnFDDHGoAulfx2sNs7sIxI1Pvw
	 9QovZc0gFdW7w4HekBIlv5FPhaTTAph0pswSwLO/yhWZVMGGx/JcM5i5ZM3V1QdW0o
	 95QG2FD1ph7d+jw4Mv7UHAeNynJ76BVqrtGl4w4ugQF9kECPdXACL+aHBsA59+wSyf
	 oXiH2tWBoDfvY7AnXTkiUkPE05uHyzDm1iLSKXeW1+BCrQYngLM+LxQis8R2AqzOL/
	 YJKoBaaHoJfIg==
Date: Tue, 19 May 2026 15:46:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop obsolete 3C509 NETWORK DRIVER section
Message-ID: <20260519154624.109b6ffd@kernel.org>
In-Reply-To: <20260519142345.GA2451985@electric-eye.fr.zoreil.com>
References: <20260519040532.277078-1-lukas.bulwahn@redhat.com>
	<20260519142345.GA2451985@electric-eye.fr.zoreil.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-289642-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44EF4585D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 16:23:45 +0200 Francois Romieu wrote:
> Lukas Bulwahn <lbulwahn@redhat.com> :
> > Commit 91f3a27ae9f66 ("drivers: net: 3com: 3c509: Remove this driver")
> > removes the 3c509 network driver, but misses to also remove the MAINTAINERS
> > section 3C509 NETWORK DRIVER.
> > 
> > Simply drop the obsolete 3C509 NETWORK DRIVER section.  
> 
> Actually, the maintainer section was recently added.

Yes, the driver is coming back.

