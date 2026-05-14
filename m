Return-Path: <netdev+bounces-287958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ExeLiXIBWqEbQIAu9opvQ
	(envelope-from <netdev+bounces-287958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0354214C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2819030095FB
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A063DF012;
	Thu, 14 May 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YVWbBMN9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A63C09FE;
	Thu, 14 May 2026 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763794; cv=none; b=KrY2rf4kgVxrYLCvin/Egsr+RbNAWzcgjSCraP+qDj4DM3k/c92OIrIoTE/DwLyS1LF5cPjb4Shyr5Nh8r+xWdoqd3hHjm04ErZP5IRGmZl/3ScNzSJfcGCpxI5UtFT6zJz/rita1O9b8ZQPfggPzk9AAS2YEnpvOVrrvPGSUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763794; c=relaxed/simple;
	bh=o3ZohSxRXTbmgrWS4XZhwFPK1MazBVyCKXH0CitwV+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKj44KjITYbcGX7mAWPtzwxsg2Q54oyR9HvnecNC/j1QEpKTnIhRG5k8c/MKNX5yjBfafDe2MYMmlxbb+uetQNGYe99cH5asum1mjutlDT3Qd7OsFlEnmwHP+Ec/PU64JQqX1AZR3raNpfhzCzX8wSP0zndyhtr4OtKgi3dyfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YVWbBMN9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZBoeZ/sB2vsw+24jLWZrz4nb+HsgIbUmCNrMODsxQAM=; b=YVWbBMN9ugLjZJA+gpXCtESJDQ
	GJGQ9I+dzTPLdD0RRQjREIs5Ef3Inmkv1iqgLvhtpPYSewNUjgP0tvoA72Z7iT+bJ4I2/e6xhsueD
	E41M3K9pfUtw6AjTttwxoesoouN3zEorRvZEbeqao/og137nIors76ZLHtSqV12Gbg8I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNViN-002uJ8-4i; Thu, 14 May 2026 15:02:59 +0200
Date: Thu, 14 May 2026 15:02:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for
 SFP
Message-ID: <9775fb06-db4b-48a7-a7ee-fa70ecdd0096@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-4-thangaraj.s@microchip.com>
 <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
X-Rspamd-Queue-Id: 09A0354214C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287958-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[lunn.ch:query timed out];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 02:57:31PM +0200, Andrew Lunn wrote:
> > +#define PCI11X1X_TX_FAULT_GPIO		46
> > +#define PCI11X1X_TX_DIS_GPIO		47
> > +#define PCI11X1X_RATE_SEL0_GPIO		48
> > +#define PCI11X1X_LOS_GPIO		49
> > +#define PCI11X1X_MOD_DEF0_GPIO		51
> 
> How do you know these values?

https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationNotes/ApplicationNotes/AN2948-LAN743x-Functional-Description-and-Configuration-Registers-DS00002948.pdf

  The GPIO controller is comprised of 4 (for the LAN7430) or 12 (for
  the LAN7431) programmable input/output pins.

So i could use the LAN7430 and don't connect TX_FAULT. phylink will be
happy with the subset.

	Andrew

