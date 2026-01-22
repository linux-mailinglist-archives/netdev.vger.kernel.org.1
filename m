Return-Path: <netdev+bounces-252156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGZvK8SWcWngJgAAu9opvQ
	(envelope-from <netdev+bounces-252156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:17:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8BA613E3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F55A4F5322
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875334EEE6;
	Thu, 22 Jan 2026 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNwxF89h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3A13AD05;
	Thu, 22 Jan 2026 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051825; cv=none; b=MGwsaoA5i+fsIrp5gZPx9lpppVLLpqS+xjmwv0/X+cX81V7GAczjyxFDM5LKJN37lIfh5BrO2s5rbrXGr6lltkYeBxSdUmRr71mdjEfG3oZDg5tDGcJQZhICg7pF0vYo+difPGefSHKi5ZJrLyu4wepyf+0/6HyEUCroGvKO7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051825; c=relaxed/simple;
	bh=SWPVOU1qh+cVkn6DzqhtvPHonOwPBpCoTSwIVjoqKDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGvHwOMMys05pS8xBGlmsggk5BNYg0gk2TRsFoTWjdwueCaIX2JX3zOSzYJnAmhft7XDor//IhBnjcyGktMtHioUlvGfYhQiPtI+zE9sGN6hDa18BcZh8NVvNeWYQtoeVr1BMhFREgAlisv5E1f0W+m7kaMvzrhsDnogIyxj4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNwxF89h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27285C116C6;
	Thu, 22 Jan 2026 03:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769051823;
	bh=SWPVOU1qh+cVkn6DzqhtvPHonOwPBpCoTSwIVjoqKDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vNwxF89huX2VYYhT5LLTpIb0TMbgSxOSPNeDFUPEtlAtiN28EvJs61kugfJmyB2DF
	 +XhvG3HU1NmDOjJw2mM8E+svlRK/ENjhAZvWbxKqRtGGA225Zi+Ah86fq4VaAQduxY
	 Eqs9QE0LnMnhGfqBhLxl/TqtY6y7mmNSplhI49zxU7fl1liCJs6RWl3YEGRJc6ixea
	 /UD/iS+Fe7BzDZWmhCfAsslSDL9z8C8ai7rWnBVZlMHpvGkLuj2iNtqJRzcAi3Km/J
	 sQql5rU+M3AxZW8SnBDYLRZutJURjwWuRTk/vN7yPCmXKq66uJ0GKPJ9CcND/kqwRh
	 F2/cpDXUZP7WQ==
Date: Wed, 21 Jan 2026 19:17:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Divya.Koppera@microchip.com, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v9 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20260121191701.25725ed5@kernel.org>
In-Reply-To: <20260115140712.2866991-1-o.rempel@pengutronix.de>
References: <20260115140712.2866991-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bootlin.com,denx.de,lwn.net,linux.dev,resnulli.us,nxp.com,iogearbox.net,pengutronix.de,vger.kernel.org,armlinux.org.uk,microchip.com,queasysnail.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6A8BA613E3
X-Rspamd-Action: no action

On Thu, 15 Jan 2026 15:07:11 +0100 Oleksij Rempel wrote:
> changes v9:
> - Rewrote "Kernel Policy" section in Documentation/networking/flow_control.rst
>   to explicitly distinguish between "Administrative State" (User Intent) and
>   "Operational State".
> - Added definitions for "Resolution Mode" and "Forced Mode", and
>   disambiguated Pause Autonegotiation from Generic Link Autonegotiation.
> - Updated include/linux/ethtool.h kernel-doc to define @autoneg as a
>   selector for Resolution vs. Forced mode.
> - Added "Constraint Checking" section to UAPI documentation: clarified that
>   drivers should generally accept pause autoneg preferences even if link
>   autoneg is currently disabled, while acknowledging strict hardware
>   limitations.
> - Added recommendation for new drivers to use
>   phylink_ethtool_{get,set}_pauseparam().

AFAICT the new recommendation still contradicts kdoc of struct
ethtool_pauseparam? If there's consensus that the new recommendation 
is better please remove the old one.
-- 
pw-bot: cr

