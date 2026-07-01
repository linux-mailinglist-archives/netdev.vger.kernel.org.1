Return-Path: <netdev+bounces-303564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzphAbfjRGqY2goAu9opvQ
	(envelope-from <netdev+bounces-303564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:53:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559D6EBC1E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=k+6F003K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA5C330104B0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429C3F822C;
	Wed,  1 Jul 2026 09:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32925DB1A;
	Wed,  1 Jul 2026 09:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899606; cv=none; b=nRc4zidnrCaNCi/fnNutxlbo6hCKUylDYJ6SzLewCDqP9UQfoEIoo3eZZwCGQpSBDXBWngj0MmeYXcB7PES1Y4xOpOotBUBtBr9Uqi1QFghRzvV+nnGaF1hmmlUOylFWO6F1Uxv/7YVd6TJ9U+4bI4zqw57nqYsXjD0RLBpZeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899606; c=relaxed/simple;
	bh=4yWx7+wWKll8LfStxFYdc1EZsluomfflESdjuaJGmP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH2TAHUESWM9W2cOakbL8UKCcy/L1jGwv/nt61tH3muDiD4BNdGoN1qmjl3FNEjgGXd7cxwR+i7kDE/LwwdnN05E1SSdldwTR3TnmcE+AR+9k7aB7wx8U9nSJrbrAdaFm+FYHQufwmu+JzEF+jCLznWvmzIp7Geif7nIIlYX4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k+6F003K; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC39BC5CD64;
	Wed,  1 Jul 2026 09:53:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C4460288;
	Wed,  1 Jul 2026 09:53:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A4C8104C94A5;
	Wed,  1 Jul 2026 11:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782899601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IEWJEb3JrdbjQ+gEU1Bac3pMIwncFv4u+WEahNukHjs=;
	b=k+6F003KBfLXoimOLdZd07YO1FK/iseBVjlu4mt6RCKoWI59xnq9L2QLghBgHWzUXbs8WA
	rPLOt+yNpLaOWTFTDbwuPGHQBztswCxWWMyTPay4YeCXx/5qWc616eAYZBnTCcWtMDiNgX
	+7axuyepSH2vxcOtoY8/9EKF0jpXSWzAj7Pfpcw78KqhCxi7XnNXhdwm6tU9FCedGP0rkq
	l8te4UcTTuhT6ChSyRuBOc7Wld+YyPv9T/r3vg1IQ2GWgquxmziYUhht821vwFP2UagEjJ
	NrJUuFH46GmDv4mx7R40W91K5MgsoADVgw7uf8VjhyHP38NhAJjyqN9YqQF4Uw==
Message-ID: <b01b4c18-bb2d-413b-a993-4a9cf4d50549@bootlin.com>
Date: Wed, 1 Jul 2026 11:53:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ax88179_178a: Add support for AX88179A MMD access
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5559D6EBC1E

Hi,

On 7/1/26 07:42, Birger Koblitz wrote:
> The AX88179A uses a much simpler Clause-45 MMD access interface,
> make use of this interface and abstract MMD read/write operations
> for the AX88179 and AX88179A architecture by introducing
> ax_read_mmd() and ax_write_mmd(), which in turn call the chips'
> respective implementation.
> 
> Make use of the MMD read/write functions in the link-speed and EEE
> configuration settings via ethtool in order to support the
> AX179A-based chips. The AX88279 supports EEE only at 1000MBit speed,
> the other chips require full duplex.

Please split this into smaller patches, one for the mmd accessor conversion,
one for eee, one for the new chip support, etc.

> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

[...]

> @@ -866,34 +924,63 @@ static int ax88179_set_link_ksettings(struct net_device *net,
>  				      const struct ethtool_link_ksettings *cmd)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +	int v;
> +
> +	data = dev->driver_priv;
> +
> +	/* mii_ethtool_set_link_ksettings handles unknown bits in MII_ADVERTISE
> +	 * transparently, so for the 2.5GBit link speed of the AX_VERSION_AX88279
> +	 * we just set up ADVERTISE_RESV before calling mii_ethtool_set_link_ksettings
> +	 * at least for speeds < 2500
> +	 */

ADVERTISE_RESV isn't an unknown bit, it's been added in 802.3 as ADVERTISE_XNP
for Extended Next Page, see :

commit e7a62edd34b1 ("net: phy: qcom: at803x: Use the correct bit to disable extended next page")

we shoudln't use ADVERTISE_RESV anymore in-kernel (there are a few callsites left).

As this seems to be a vendor-specific behaviour for that bit, please add a
local #define for it in this driver, to make it clear that this is a device-specific
value.

Thanks,

Maxime

