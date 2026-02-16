Return-Path: <netdev+bounces-258932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFXZJGZSk2nA3QEAu9opvQ
	(envelope-from <netdev+bounces-258932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:22:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4342146AE7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB16B300998F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68CF2DB785;
	Mon, 16 Feb 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q0qmOIcr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DA248F72;
	Mon, 16 Feb 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262563; cv=none; b=K8Ke7BnX5q0VAqy08MYDkhdgyggb62iaikQYecPQYeXPsVMx3oJ/fSFZKvaoDduv2OPe2OzfM6ucfziW+rKk0bAif4/+l8DOaUjQ9mBFaWjRzBC9SsyrRYUzn4f/vEcY3zEEmmFXRf0XRFSIWeMg5Ph93y3MjayIH7GAot0ef4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262563; c=relaxed/simple;
	bh=fmlF0NMaVT0ig16kt49VUZapla1ucbqKUNHq4rFsz0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojNxbquNix8GsRqeTGrVqMaf1a4Or3zlJQ8kW1SS17SIy7rHFB6n27+0pKp8ivaThmoGCJnSTsEy5wXk7Hh4ufNR55icjxKsdnVmBaOja4tbV+garvKV5p1G+U1V5FxFsGW9uSl1dZQI7kokCyAY4KP4LtLLi12mtMHkLSmFFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q0qmOIcr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7DQxdqziardc+OZPmGjtY1tESmJOcZ5z8aQdMKQpw4U=; b=Q0
	qmOIcrZmhZYhHQBVbacLE3j09L+G2o4Eyj5aJHPa6BjxOqAgmgsIFDNP8IYwS73wvPiravo+FGsyN
	IKJ5TK23+BAY11sh9EKmUnfjf9QLl1qICbQbEswcbMj2znIlyFS7rNjeau9AlhVWhtPk8jOQEa3Hd
	LgctWmW3JZMVnKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs2In-007WSI-8q; Mon, 16 Feb 2026 18:22:29 +0100
Date: Mon, 16 Feb 2026 18:22:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: cleverline1mc@gmail.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miroslav Ondra <ondra@faster.cz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add support for PHY LEDs on
 RTL8211F-VD
Message-ID: <dcd931da-6252-47b9-92c5-375774b497cd@lunn.ch>
References: <20260216-rtl8211fvd-add-leds-v1-1-a2b8617bbf80@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-rtl8211fvd-add-leds-v1-1-a2b8617bbf80@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,faster.cz,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4342146AE7
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 06:11:09PM +0100, Kryštof Černý via B4 Relay wrote:
> From: Kryštof Černý <cleverline1mc@gmail.com>
> 
> Realtek RTL8211F-VD has the same LED configuration
> and registers as RTL8211F.
> Use the existing LED related functions for this chip,
> so it is possible to also use the netdev trigger.
> 
> Tested on ROCK Pi E.
> 
> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>

net-next is closed for the merge window. Please repost in two weeks
time.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please also set the subject line to indicate which tree this is for.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

