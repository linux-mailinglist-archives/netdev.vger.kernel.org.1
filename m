Return-Path: <netdev+bounces-195956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6309AD2E4F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD01891714
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86027A934;
	Tue, 10 Jun 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ogi8jU2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BP/rvpYc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97E21FF25
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539193; cv=none; b=gzQFKhD6tG99GnowA8CdPBOeHicylENEx5PpNKZCQg+0Ef45fvT/K94OCbRuEAYnTTAhda8APWCn90DI5ETiuDUlwWoh0vioEfQdqFpXNP7wlC3WmfMH/J9mo4VyUTYvDVz54xkijO+zu+3tyD4SkO3k0Pvf8VipzXNvTw6hIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539193; c=relaxed/simple;
	bh=5A7yoNMBU/3l93xf4bWDmIF5qqXXDKgIC7o2ZHyyrDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXvpcS4XVkjfOUHtswLn/RfnN3jNjs6S3CcJbgg9zERGqPLWJvlNzZaroOqmnSypdSQqcjRGy6tWHqiJa6nASg5IIMgCBL6j5gvAr/ENnAUQ+Q/bH5oOv4XvXOV9gcVR+aXkyqT0q+aQAu/bS4NWe/vPOFxrXqpcDGfYXFRGs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ogi8jU2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BP/rvpYc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 09:06:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749539190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/JznsC2LZTvIFkK/TkzEnYTa0HK32ohVNVqmfs+TpQ=;
	b=Ogi8jU2NZk+VKRI1vGv3jbJOrzp+fkVz519CKZBcUrG/Em/7C3YjKBCH6s0WqfpWQL+rQR
	v69I2N/UoCAOPmxEOocr+IfMqcy6AC2tqbnPt2QptNxw0+HmT+1Mku31F17IrNWgIAiNMD
	cvNgWOlZUxdM/touoggrCiH9rLcJ2xv/rsuSRgU0M4qQa1Fopix8iGUayI/LvuUOjWlfcM
	hlG/XCLzirDkO9XIMOBuYhJSZ7cv9FG6TgEleEpjKnAZzJRimOd8cU7ALH6xAB55ofHjJS
	+B15eyapeL3sQC08SAperQD4wWKRP33XmVPnqE41jiS73tcbqqQdskucBI+d2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749539190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/JznsC2LZTvIFkK/TkzEnYTa0HK32ohVNVqmfs+TpQ=;
	b=BP/rvpYc10sqdgIJgGINyz9b9Xb99M/V1Bphb57fKx4qw9WxUwQtNomrwN3klZezgdA7pA
	APFKsQrKyiwZZoBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, dev@openvswitch.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/3] Revert openvswitch per-CPU storage
Message-ID: <20250610070629.0ShU8LLr@linutronix.de>
References: <20250610062631.1645885-1-gal@nvidia.com>
 <20250610064316.JbrCJTuL@linutronix.de>
 <63dcf1ff-7690-4300-8f76-30595c14fec1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63dcf1ff-7690-4300-8f76-30595c14fec1@nvidia.com>

On 2025-06-10 10:03:08 [+0300], Gal Pressman wrote:
> On 10/06/2025 9:43, Sebastian Andrzej Siewior wrote:
> > On 2025-06-10 09:26:28 [+0300], Gal Pressman wrote:
> >> This patch series reverts a set of changes that consolidated per-CPU
> >> storage structures in the openvswitch module.
> >>
> >> The original changes were intended to improve performance and reduce
> >> complexity by merging three separate per-CPU structures into one, but
> >> they have changed openvswitch to use static percpu allocations, and
> >> exhausted the reserved chunk on module init.
> >> This results in allocation of struct ovs_pcpu_storage (6488 bytes)
> >> failure on ARM.
> >>
> >> The reverts are applied in reverse order of the original commits.
> > 
> > Is the limited per-CPU storage the only problem? If so I would towards a
> > different solution rather than reverting everything.
> 
> I don't know if this is the only problem, we can't load the module
> starting with these patches.
> 
> I suggest continuing with the reverts as I assume your new solution will
> be net-next material, no?

It is a regression in -rc1 so I would try to fix this on top of -rc1
instead of reverting everything.

Sebastian

