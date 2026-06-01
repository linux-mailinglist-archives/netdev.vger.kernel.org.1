Return-Path: <netdev+bounces-293735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KLTJih7HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBEB61F47B
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79D7C300B9E7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD9377EAF;
	Mon,  1 Jun 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T8Gpi6UG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA313769F2;
	Mon,  1 Jun 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316956; cv=none; b=QJhzFdRyo+1fg7kLVvx3Qlam7nBI9eeXXboe1m2Z37UVit8lGFoh6s8tTNK+CC00zT2DlvZN9+KInwBd72ByyxIKTiw4CVBGg1zgs1gVyoL4zja+TPU2ZtUWENnK3DhGbMr/nQqerZN/ATwKZdHFBQjw8LMnJPuhpmFv93qc06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316956; c=relaxed/simple;
	bh=JPpYKXlBa4RFvW7actu/k5nlkmsuW6+Ne4hRxI8dc78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aijmv5IhknaXmB8EVmdH926u26D/y01lZoVekSrcwngETFijcg0TgiyfKRUAwSsu4Z+67nJbinruQAbvztt13Z3EBD7IpM9froV2XD8Q0nkrY2vM30fFaATlTeZdEUuUgoQY9rLYS/+OwBu6Dg+fvERmlVJ/XD8gd3jOJMfpE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T8Gpi6UG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iUNcxP5vUlsQw11K7iw0C8/gbeiciIxg4PjeApBK+Jo=; b=T8
	Gpi6UGVu9AekjAumqqzMy7OkcbToxxlkqLfNI+lDKx5ijWT96PNJ3sKmBJrssAm7nDzvsSobk2Y7b
	0eF5hrE0Npnc63i4+vJSmgWtkOwMoUrKqhweKPtkoI1c4SszjTn43MelZI5LNcQ5+Olrtzv502npz
	zhd2vutXPkvjPuk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU1lP-005V96-1j; Mon, 01 Jun 2026 14:29:03 +0200
Date: Mon, 1 Jun 2026 14:29:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Grewstad <dogestad24@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, jacobsfeder@gmail.com,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
 <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293735-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:url]
X-Rspamd-Queue-Id: 5BBEB61F47B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 11:35:14AM +0530, Grewstad wrote:
> On Mon, Jun 1, 2026 at 1:22 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> >
> > In addition to what GregKH said, look at the vendor information:
> >
> > https://docs.amd.com/r/en-US/pg080-axi-fifo-mm-s/Core-Overview
> >
> >   The AXI4-Stream FIFO core was designed to provide memory-mapped
> >   access to an AXI4-Stream interface connected to other IP (such as
> >   the AXI Ethernet core). Systems must be built through the AMD
> >   Vivado™ Design Suite to attach the AXI4-Stream FIFO core, AXI
> >   Ethernet core ...
> >
> > when used for Ethernet, a uAPI is not needed. The FIFO driver would
> > just expose an kernel internal API the Ethernet driver would use. Are
> > there any Ethernet devices using it? Is there a driver for the AXI
> > Ethernet core?
> 
> As I said to Greg K-H, it's 'chameleon' hardware because we don't know
> what it'll be used for. It could be SDR or Ethernet or whatever it is
> programmed for. The main thing is that it is a streaming interface.
> But we cannot assume the use case.

Flip that around. What is it actually used for today? Make sure it has
the correct APIs needed for what it does now. New APIs can always be
added latter, especially if they are in-kernel, code to glue it to an
Ethernet driver for example. 

However, a grep for XIL_AXIS_FIFO suggests nothing in-kernel actually
uses it.

Are there any real users from user space? You talk about SDR, does GNU
Radio use it? Using what hardware?

If you have no idea how the code is used, you cannot say what the
correct interface is....

	Andrew

