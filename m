Return-Path: <netdev+bounces-289559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNklLGCjDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:52:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDF58354D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70943300D152
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBF3ACEE2;
	Tue, 19 May 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="01cVRIBY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D233B6D3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213116; cv=none; b=q6vnfDTiwdpCqSgqR/hnDYj/ILFnJnGRylbxKz3d2/zw+MkuBJTxrulNDJLACUPjLvDkQbG9fyDvCvu1nQQP3DbYyamZSjBrtuf4UtzbXccI3PVlzV+m/CCQruD0SA62+PAujp8pqfA6K+UbFSaO6ul1mMNqanwXHtOqOEgoFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213116; c=relaxed/simple;
	bh=ovV0RcXSMFP2tYIHhrk7RUkyZKE68UaMybO3dOcj++8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsSXsz7WwJd7aWvqOIk+swPaJTZ2vnC0kVnBRYcmKx+F/RdygfZ7cAxsB5+aIc0RqdFgV3/icIZH4GpnxuzeW+ro5OqEFwk8zSDIuLCvCU/oBKL8abHEBfqrwfux8KvBmK2zerJYO/DDJh6PvaTO94Lf5qEjxRU29gzvR78uncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=01cVRIBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2l6PmBb93mcM1YhRHnyUBzfYP18yeHzSvT8pTQFVGuE=; b=01cVRIBYnFkVcYANoH34PB5Rst
	ZE70y2IDbu56ZYda1J2Elm0bIIs/CtJEFLbDy8WVLLlA/xf5uPfZNAnkLTMmLCMFKPO5E+47JSz+m
	seStNXAIDo4gEKa15RzMiJ5aKFfU1xkw0j2VK/ym6FsL2lJJY1N5wzbOJoXxXUFBIj8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPObM-003i42-5H; Tue, 19 May 2026 19:51:32 +0200
Date: Tue, 19 May 2026 19:51:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH 1/9] net: mdio: realtek-rtl9300: Convert to generic prefix
Message-ID: <fefc0bf7-ffa8-493d-94d3-7fe997b0f196@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-2-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BFDF58354D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:57:39PM +0200, Markus Stockhausen wrote:
> The Realtek MDIO driver currently only serves SOCs from the Realtek
> RTL930x series. This is only one lineup of the Realtek Otto switch
> series that also knows RTL838x, RTL839x, RTL931x devices.
> 
> All of these share the same MDIO logic but have individual properties.
> To make clear what is devic specific and what is device independent
> split the function/structure prefix as follows:
> 
> - for device specific helpers keep rtl9300_
> - Rename generic functions and structures to rtl_

Renaming makes sense, but maybe rtl_ is too generic. There are other
realtek MDIO implementation which this driver does not support.

How about putting otto into the name? rotto_ or rtlotto_ ?

	Andrew

