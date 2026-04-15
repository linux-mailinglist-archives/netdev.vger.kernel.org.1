Return-Path: <netdev+bounces-278774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ98O6WQ32nMVwAAu9opvQ
	(envelope-from <netdev+bounces-278774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B55404BC7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDBD2300B9F8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5C38AC71;
	Wed, 15 Apr 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SUkJ4I8N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29931A07F;
	Wed, 15 Apr 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259233; cv=none; b=HJRvdibO4/0V+I6jC8JEBe/YA4B9f75zPhbs6LW2SKeVhWaWCZeGzWkioTmvWaUwQ/EqBNzHbt8MCP+kbe5ERF7aSThTo90N1ShyOLYWTYm+hR58jEpBcUO0AbvXEov2TbvbFcfvWfVbfEvUyFunxKgxTOXq+QpCD00D633hWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259233; c=relaxed/simple;
	bh=MLG+Z4NqlIN5BGGq47ucjjciOP2BfxX8z4mbXvHcucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWcgZVUPs/KrGyZfiBEBWmmh15WS4FcDN7voC6T/EhIM2TSab2cuuiP7uj/yJQkRstXPQgrprb5Z51l13sBXX1bFxx42pZsybL/Twf1QoO4cC5eVlXvajLT7QuaGEhORysm/pxqCiBcIyx0BvAILuafKvp/luklKYtc+WF/tzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SUkJ4I8N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XpCgTRBV5J7XvcLi4O24HkEUhUxDuDGfv6278pjc9X8=; b=SU
	kJ4I8NDfY6h6lU525gwbExcU/Zf35fTocljMOPZIRxRCgrR91zdrC+ZBLHFEwY/YidpNXnW05ql8Q
	m/OxYW7HMfrfw474Nwtb0DrRhP96L6yJLAjB6AmDsaf4SQJb0WXIgSRLxT5HhLyG+kFUccT788CzX
	Gf1mUwQHt5SMtIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD0AA-00GAjC-HB; Wed, 15 Apr 2026 15:20:14 +0200
Date: Wed, 15 Apr 2026 15:20:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: hkallweit1@gmail.com, fujita.tomonori@gmail.com, linux@armlinux.org.uk,
	tmgross@umich.edu, ojeda@kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: rust: net: phy: intent for MAE0621A (out-of-tree C -> Rust),
 request for target guidance
Message-ID: <d45d7880-c7c3-4adf-8807-acd3c89c5e3c@lunn.ch>
References: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,umich.edu,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278774-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 90B55404BC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:59:58PM +0800, wenzhaoliao wrote:
> 
> Hello PHY and Rust maintainers,
> 
> 
> I am a PhD student working on a C-to-Rust migration tool for systems code.
> We would like to validate it in Linux with one concrete PHY target and would
> like to confirm direction before posting a larger RFC series.
> 
> 
> Scope of this intent:
> - Initial target: MAE0621A (currently out-of-tree C driver).
> - We do NOT intend to submit a duplicate Rust rewrite of an existing in-tree C PHY driver.
> - Goal: evaluate a semi-automatic abstraction completion workflow:
>   reuse existing Rust PHY abstractions where possible, and add only minimal missing abstractions.
> 
> 
> Planned deliverables:
> - A gap analysis between MAE0621A C callbacks and current rust/kernel/net/phy.rs coverage.
> - A small RFC patch series with minimal abstraction additions (if needed).
> - A MAE0621A Rust driver prototype on top of those abstractions for linux-next/rust-next evaluation.

When done correctly, this sounds reasonable. However, i do have some
further questions.

Do you have hardware? What board do you intent to test this on. Does
the board boot using Mainline?

Do you have the datasheet?

What out of tree C driver do you intend to start from. I had a quick
look around and the first one i found is:

https://github.com/CoreELEC/linux-amlogic/blob/amlogic-5.4.210/drivers/net/phy/maxio.c

As is often the case of an out of tree driver, it is not up to the
quality of a Mainline driver. Doing a tool based C to Rust migration
based on this code will just give you a poor quality Rust driver,
which will not be accepted. Do you have the knowledge to fix all the
issues?

Maybe you can tell us what C driver you are plan to use, and do a
review of it, list all the issues you see with it, what needs
fixing. That will give us an idea if you can produce a Mainline
quality driver.

	Andrew

