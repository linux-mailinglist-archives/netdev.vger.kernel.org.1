Return-Path: <netdev+bounces-293476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YErqFceSHGpdPQkAu9opvQ
	(envelope-from <netdev+bounces-293476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92044617C8D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCCE303A50C
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B0317145;
	Sun, 31 May 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nWz3USfi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2D21ADC7;
	Sun, 31 May 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257164; cv=none; b=usAvK0qzJAgk3bIz+oyjKSCBqxZiZEPVfECtVNIw7d2H8RwI35umwW0D3wiOlux3UgTkG4xsK6fg2eUk/Ei0ICL6ywm0K6vdwD1taH34IZxbZjfG8AjNmHpavi49k4SBAjjJ4xNfvKcqcnue7Y2dD2uA4zNkzuXl+CW03pmkYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257164; c=relaxed/simple;
	bh=X3sWxmN+JBpebowhRIsiAvs2OAAhmtv4eqLpOL3rWHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkqwqJaIh2m88a9GA8zBpqan0tOpYHY8Cf4xalpBfwZTIKWIW3LNZHhvHrIt0eH4XVi4Vv9Uv5yhlHyrHnI7c+JmSrIDaAlWRfu8QoHRKECJvYpeL48xkKbOFvPSF9tDujRfWeaVufgC1JSo/zJYc+hMeiiFQMJPE1/iyjQz4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nWz3USfi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=usD25Mn+KtR/YRU4TNAHsdvTdHQnYeqEpZh1u/Q0X98=; b=nW
	z3USfiBx3GvO1i1+RWdPGGt/FWdjUQZ23dST/1Y7m+DlxgFl5AMdbxsJrgcRjL0ZrP1S6qrF1XGBo
	vddpOIjRFe9O8SZe0zd2iog2EIBzKS9WTfOIbtYX5eCQpDh45loIq6XVU3E3+2sbeThP/oILK/puc
	nJDcjX0+MsbMNSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTmD6-005OXP-Cl; Sun, 31 May 2026 21:52:36 +0200
Date: Sun, 31 May 2026 21:52:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Grewstad <dogestad24@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, jacobsfeder@gmail.com,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293476-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 92044617C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 08:20:35PM +0530, Grewstad wrote:
> Dear Maintainers,
> 
> I am interested in contributing to the Xilinx AXI-Stream FIFO driver
> located in drivers/staging/axis-fifo.
> 
> While reviewing the driver, I noticed that it does not currently
> contain a TODO file describing the work required for graduation from
> staging. I would like to create such a file, but before doing so I
> would appreciate guidance on the expected long-term direction for the
> driver.
> 
> The driver currently exposes a custom userspace ABI through a
> miscdevice. While this provides a generic interface to the FIFO, it
> does not integrate with existing kernel subsystem tooling. One possible
> incremental improvement in this area could be a transition from
> miscdevice to a proper character device (cdev) interface, to allow for
> a more clearly defined and maintainable userspace ABI.

In addition to what GregKH said, look at the vendor information:

https://docs.amd.com/r/en-US/pg080-axi-fifo-mm-s/Core-Overview

  The AXI4-Stream FIFO core was designed to provide memory-mapped
  access to an AXI4-Stream interface connected to other IP (such as
  the AXI Ethernet core). Systems must be built through the AMD
  Vivado™ Design Suite to attach the AXI4-Stream FIFO core, AXI
  Ethernet core ...

when used for Ethernet, a uAPI is not needed. The FIFO driver would
just expose an kernel internal API the Ethernet driver would use. Are
there any Ethernet devices using it? Is there a driver for the AXI
Ethernet core? Does drivers/net/ethernet/xilinx/* duplicate the same
code? xilinx_axienet_main.c says:

 * TODO:
 *  - Add Axi Fifo support.

which could be this.

As GregKH said, find some hardware using these IP cores, or synthesise
your own, and then work on the driver.

	Andrew

