Return-Path: <netdev+bounces-300245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wd1KJ/0OM2re8wUAu9opvQ
	(envelope-from <netdev+bounces-300245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0369C813
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:17:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UIfZSsqk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300245-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300245-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B05530548AC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE63FD131;
	Wed, 17 Jun 2026 21:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5718871F;
	Wed, 17 Jun 2026 21:17:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731029; cv=none; b=kblu7RdJwMDvrVmlB6mvK637r51GAzaCwnK2HNVVFeCIFvJHkqbheBeNj3PBuVGnhKRgy2b6VyDyG4BOnUbRCW3atYVF+7vlYZyjpspO+WTdPZWuejjeCi2Y0fHJA2Zv0mt/ACVJQvLygXazdxNsaFCAHwhXB7Tg6dxDBVCJMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731029; c=relaxed/simple;
	bh=x/nhyE4L/Sy1lDkey1p6FbadOEpfyHK4GdK5pMqLCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyUF07e9m4+6Yb9Q3zyECUchvF7mYH5YynPN4f1CdYq2ajoJsRMF3YpYgL/94YWzAIO99eMszlqLlyCstRt1EDPuOXz5DzkN9jvB9LxI2rai/ZijsgyoMXRw2Yuean/FmXs3/HQgM7Bu0ozEE3I5/BwVaiAt74v6gDZn+lKRSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIfZSsqk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C8A1F000E9;
	Wed, 17 Jun 2026 21:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781731027;
	bh=YiY6/DUiKym01gTg/k7ZNmI26ZSUVWZpNWqMLBrw3ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UIfZSsqkXdVoxO6UgpKJZ7JIudjLXxmHoyXNdy1vY4wSR+9xnkpndP9CefdbX+l7P
	 KNRZfGPi5lFxsu9irADs/s41QWlBOmnFA5Ey8QvjwE7L1Ei/cBJqYeEbLm7Q10BTb3
	 I8anIjC95EOacYltkNyn7iC+6MOCspNLbK8i6EHkrlUKfauOvQOIXWYU/w6a8pKJCl
	 edgabzoTOhd6l6+9YFqPt42QnQjhBplkbXdcuBAh9McuoTgWjjUhROsBXJbKRAeqUz
	 Rg/AFsH7IRgUi/qiVz3V0wlq8DR7XlPPS8AdgzeqNGNt43bSS4GWYROuFOGxC8kgkt
	 ymnnHvL0f/Pxg==
Date: Wed, 17 Jun 2026 14:17:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bryan.whitehead@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/2] net: lan743x: add RMII support for
 PCI11x1x
Message-ID: <20260617141706.5ec34d49@kernel.org>
In-Reply-To: <20260617053241.157932-1-thangaraj.s@microchip.com>
References: <20260617053241.157932-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thangaraj.s@microchip.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9B0369C813

On Wed, 17 Jun 2026 11:02:39 +0530 Thangaraj Samynathan wrote:
> This series adds RMII interface support for the Microchip PCI11x1x
> Ethernet controller.
> 
> The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
> selected via the STRAP_READ software strap register. Patch 1 reads the
> RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
> uses this flag to configure the PHY interface mode, phylink supported
> interfaces, and enables RMII in hardware via the RMII_CTL register.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


