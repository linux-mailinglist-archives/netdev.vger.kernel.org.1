Return-Path: <netdev+bounces-275898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP9KLpe+1GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169363AB3DC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1317A3004C42
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F703A1A26;
	Tue,  7 Apr 2026 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ysWfdzIf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8081F91E3;
	Tue,  7 Apr 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549922; cv=none; b=n660jYw0bilJZX5j6ySdQlTVfLHV/dgUWsG2mKSNwqnVXUvnIg7lcnX0iJWncNC0+kHEC38gONXLjf9baX7pWd0PU+AZoIHkwpgeLVUQd4CwmU04q1qTyegaOKJ3xZs7xlHcNzijh8SKxuu12P9kuF6nz+7Y9Ez55/DNqbTSchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549922; c=relaxed/simple;
	bh=gFdj9+rDNA8fr0sfWbBStFrVzZVxclvSmUZsvjB3WDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6Gzwqf5bXxeasX0c7EP5CAPJP4E7KeSiji+rkY2XuCxn4PkI0yPWiP5r7bPjDMYy4q0NFgx0rpF4VnEykc398OfabCEf8H3kkEgQpoiHUQSHFqo6E5Z4gilc/Q4Zk4Rvj2XRYvCPxw3X3MA95PyC37GzHMSLWUQm7a9ZCBnL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ysWfdzIf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9EWGHv5SJ17hrSeizpzhVcw/zqcjIOpBT6a6HCx8CG8=; b=ysWfdzIfV5PDGgrs6HbO+s2mZ3
	AED+MsKAFrnCu2WLA9i8ADfCxbMn6og0p/vvW5zkznhirY/O+5rb7Ne8tRj+gECW8iqg2Co/SdcU3
	IlEsSzpHWJZVIbyen42s0Sl104nwjVTchkawzcEJbBsHtAiIERSf3Fo1EbI5htI5saE/pi5oh6lTu
	aAYrKrQS2leVqfMzkNAOcmmB3u6Q21nJpZeIRiLeOXghrYV0za/c5rP+f+YCdQRNSrLc0J6FkdOpi
	LncM6T8rbfD7Wa7sEapf+trBJFWapY0G2Iojfo4aJD8KRtSWDPaZ4hCQF0JnYRJ2cwXetcNF0fmCz
	kNF3cUeA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA1dr-000000000dE-2Dsj;
	Tue, 07 Apr 2026 09:18:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA1dp-0000000027C-0CR0;
	Tue, 07 Apr 2026 09:18:33 +0100
Date: Tue, 7 Apr 2026 09:18:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: John Pavlick <jspavlick@posteo.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcin Nita <marcin.nita@leolabs.pl>
Subject: Re: [PATCH v2] net: sfp: add quirks for GPON ONT SFP sticks
Message-ID: <adS92LVr5_rnBzMv@shell.armlinux.org.uk>
References: <20260406121716.69854-1-jspavlick@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406121716.69854-1-jspavlick@posteo.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,leolabs.pl];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275898-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.887];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.net:email,leolabs.pl:email,armlinux.org.uk:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 169363AB3DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 12:17:21PM +0000, John Pavlick wrote:
> Several GPON ONT SFP sticks based on Realtek RTL960x report
> 1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
> On hosts with serdes fixed at 2.5Gbase-X (e.g. Banana Pi R3 / MT7986),
> the kernel rejects them with 'no common interface modes'.
> 
> Add quirks for:
> - Hisense-Leox LXT-010S-H
> - Hisense ZNID-GPON-2311NA
> - HSGQ HSGQ-XPON-Stick
> 
> Each quirk advertises 2500base-X and ignores TX_FAULT during the
> module's ~40s Linux boot time.
> 
> Tested on Banana Pi R3 (MT7986) with OpenWrt 25.12.1, confirmed
> 2.5Gbps link and full throughput with flow offloading.
> 
> Suggested-by: Marcin Nita <marcin.nita@leolabs.pl>
> Signed-off-by: John Pavlick <jspavlick@posteo.net>
> ---
> Changes in v2:
>   - Add Suggested-by tag for Marcin Nita <marcin.nita@leolabs.pl>, who
>     suggested investigating sfp.c quirks as a solution rather than
>     attempting to edit the EEPROM data directly on the module.

Please read the maintainer-netdev documentation, particularly on
submisison of patches. You need to specify the tree and also avoid
resending within 24 ours.

Patch looks fine.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

