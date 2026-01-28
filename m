Return-Path: <netdev+bounces-254083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDbFGXl7eWldxQEAu9opvQ
	(envelope-from <netdev+bounces-254083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:59:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53DD9C713
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78CC6300B12A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4592C1594;
	Wed, 28 Jan 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czi83NqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589425332E;
	Wed, 28 Jan 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569138; cv=none; b=ozFolpUaHpVeCxzPw+Bwp9Dixx3eH3wJ9CSkwUz8Xo3L6GpDUpkrbSIDvmj+5dPIj52mPsuLnz2JQPkdIkUsN8NTeRGYr4iZqg+YCBgSR4GZkERIj0Zm/rAeMaTwJaK3+s57yRIDMcIWlnXpLvPWpPrtrZmxdne4Op5MoinCfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569138; c=relaxed/simple;
	bh=Ac37IbqyWcca/4SCl1e9MinT7q6JQCs4TTXGSBDTQSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gq/M7Mbv5DSY6kRBqzhRvKjMbVtXoE/WnpIov+2KKkG7elkSeM+UHQ1W0jmcJzfxj+3gfn8ll48XEzVjQqz37yt/xmf8p4OztSuvkTSIr+AJDBcndHJs8ddspEP00h9nk3heLhRIs6+Hr2kwQ2ZbUBkWYV7XqhdPvbwKDGCKh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czi83NqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B749C116C6;
	Wed, 28 Jan 2026 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769569138;
	bh=Ac37IbqyWcca/4SCl1e9MinT7q6JQCs4TTXGSBDTQSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Czi83NqYSNKrxmRgX372KLBq4N0q6ZYGNnWp0xDVFG4P7X8GrGke0CJ4zqsE8BxEN
	 LDLPZY/w41T0q3kYeCNtejzOfiGaQ9Zadgsmxx5jVg6R5ufjKA/AMyL6j2zHFWpBtE
	 cKgBDoV3wKRbB8PZUdjM7GwnByl8AifblS1CDl1P9NxJXJxM7yWqb3jXJsQ1fWjk0D
	 4TXdhbMv14oimt5km2iT5d6Lm7jecy0Jiscwm2IGAXtcCaXB5jflJUmA9llI8Cid+m
	 sISGBjqanyJFIlpOGRBFDHhwLhw1fC31F01vo6Q0hDRSKngFZdqU/ZMp+PeRZC+JK3
	 yBy1gmfRyG+ag==
Date: Tue, 27 Jan 2026 18:58:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Peter Korsgaard
 <peter@korsgaard.com>, Petko Manolov <petkan@nucleusys.com>, Steve
 Glendinning <steve.glendinning@shawell.net>, UNGLinuxDriver@microchip.com,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Oliver Neukum
 <oneukum@suse.com>, Krzysztof =?UTF-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
 Deepanshu Kartikey <kartikey406@gmail.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Max Schulze <max.schulze@online.de>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Eric Biggers
 <ebiggers@google.com>
Subject: Re: [PATCH net-next v3] net: usb: remove unnecessary get_drvinfo
 code and driver versions
Message-ID: <20260127185856.7ff5d1a2@kernel.org>
In-Reply-To: <20260127060534.51206-1-enelsonmoore@gmail.com>
References: <20260127060534.51206-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,lunn.ch,davemloft.net,google.com,redhat.com,korsgaard.com,nucleusys.com,shawell.net,microchip.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53DD9C713
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 22:04:38 -0800 Ethan Nelson-Moore wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.

I slightly lost track of the conversations on your patches so forgive
a possibly obvious statement :) - but this did not apply cleanly to
net-next at the time of posting. So it needs a respin.
-- 
pw-bot: cr

