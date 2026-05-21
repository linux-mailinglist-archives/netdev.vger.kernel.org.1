Return-Path: <netdev+bounces-290392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCavNTz5DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:23:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A75A4B80
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A869130E609C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882E31690E;
	Thu, 21 May 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5n04J1WS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30833CE092;
	Thu, 21 May 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365838; cv=none; b=ZPT1/GoiqU2LlrOLEYEwFaP2LzX+btQMfDQb6EtXXtMvwYI6slQnNBH9T79HfZi97D3wdrIgo3Po6/6INexv2mPrEZNxhO6+/ThMR/VeMo4V9svHX1llgYoYqscW2nCL3aAgJ/xcLZQDSxm8lhti4tG1RDL/lRJxoLhIZPoyYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365838; c=relaxed/simple;
	bh=Jk4+rfMKZ8lHig7foj3594eaY2uM2QAv6kp+lRHbTjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGmuxxjQiA7LAQwSzEZUiK5Rvh/415osYaxASIzdSM3lauevTD5YmRLA3UAPa/amOqu39li0jGSWx+2evWr6P/Crel/okK90eiexGeMzTqO6U0vmCyqoFBLgTMbeCuYcj+idXlOqYAHoYM6ystAGDF0CS9NDOIyBnfCEGYibUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5n04J1WS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iB4Yuhl6oOgylFRmPc9Zztfa4P8W39unwT+VZ9BG5f4=; b=5n04J1WSsJpFNg+aZpa3fPCKmy
	cpnlbpfQQPZU9jtDMlKXJQu28Mf90D4557Mj9BIKZ6SoJxeuAkHsfIuXfFoXA/4NGXrXf5+ZZrx8o
	6VzFD/2jXDwMDVUZIg7POICh8twp9ARhBmVTyWRCElkHR6nWaiALRg6SkUgQrFkt7s88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQ2Kq-0040wQ-NC; Thu, 21 May 2026 14:17:08 +0200
Date: Thu, 21 May 2026 14:17:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
Message-ID: <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290392-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F6A75A4B80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:18:44PM +0100, Maciej W. Rozycki wrote:
> Hi,
> 
>  As per the previous discussions[1][2] this patch series brings the 3c509 
> driver back.  Picking up net rather than net-next as I consider it a fix 
> to accidental removal and so that any downstream users do not suffer from 
> disruption when using released kernels.
> 
>  In the course of making the coding style changes requested I have come 
> across an actual bug in transceiver type selection code, where the old 
> setting is not masked out before ORing in the new one, causing no change 
> to be actually made in a requested transition from BNC to AUI.  I guess 
> this code must have been executed exceedingly rarely, as it's always been 
> wrong ever since it was added in 2.5.42 back in 2002.
> 
>  Therefore I find it not worth backporting to stable branches, however for 
> the sake of appropriateness, in case someone downstream does want to have 
> the fix, I chose to apply it second in the series, right after the actual 
> revert and before code clean-ups.
> 
>  The remaining patches of the series should be obvious; see the respective 
> commit descriptions for details.

You need to split this up. Patches to net are likely to get back
ported, even if they don't have Fixes tags. So please add the driver
back in net, but fixup the issues you have found in net-next.

There is also an question of if we want the coding style patch or not.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

  1.7.4. Clean-up patches

  Netdev discourages patches which perform simple clean-ups, which are
  not in the context of other work. For example:

  * Addressing checkpatch.pl, and other trivial coding style warnings

The problem with these sorts of patches is that they often break
stuff. This driver has been stable for a long time. Do we care about
coding style issues enough that we are happy to possibly break it? Do
we want to spend time on debugging it? Probably more time than it took
to fix the checkpatch issues?

       Andrew

