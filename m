Return-Path: <netdev+bounces-303572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WY5tJf/nRGqf2woAu9opvQ
	(envelope-from <netdev+bounces-303572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B426C6EBF46
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=szZmprIo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303572-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303572-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D5E330551B4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6678409131;
	Wed,  1 Jul 2026 10:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776783921DC;
	Wed,  1 Jul 2026 10:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900251; cv=none; b=ET+fhoxklICeeqktnkAOLnvY0s0z5LgQD8iVsO7BD0yedUlK49nXeGQNcpFQFWZ2lAnAz5kIvNcegu1pUghKdHZajrFteX/HgMoX8UgVllKBzi8L33nVWMracnSY5tQucBhCwAWvhFildv1/4+AA2E6cWzXXXlSg/1KPWehbFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900251; c=relaxed/simple;
	bh=LVaroLwSaEIBs/G5Lnk+N6jwRSDQX02r3wTcYNHvDd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk8RnzThTS6VyEVGkqFmq/0BNoRUPaE7rCHSzeMS+X3Sts6U8UQeLIGK/++x31v3/GCOCVMjuTXON2dHja/sznblY9P4UCcJuJ3FItpZp8DREcfFxCY08W4h3dqWhC17SFGROzrtSC0icJkMaLHiPdVqaGONVsI1yilpitq6JG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=szZmprIo; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F0407C79AB1;
	Wed,  1 Jul 2026 10:04:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1325A60288;
	Wed,  1 Jul 2026 10:04:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5AD54104C9A80;
	Wed,  1 Jul 2026 12:04:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rS3XJGlccH+dLXbiW6ODSZ7p0h3tz4Kqf5bCznH1MNo=;
	b=szZmprIodXQOQ7GtfxI63myhYLZzmv6n6+oXrtRBCkyN9mMkFV+hmR3MC4iGk5olV6+OkP
	FzTiB99e7yITq0LBkkONbRISKrixM6g6j2bZjwnUt7oS06BaZgTHvF3q1o8unEmpOLgPnQ
	AyXQN2Nq/My40o+Y5bcm/3aPRpNzZvNus+/dJhtbAFe+biZAoFV4BRwsCfp95hHKVwz7BK
	btWD0B4W6JDEokWQoCkFqZMnuZZcI8YRToUDpldJulJW28+PqgMROp1xFUUlyc0KLcgpWQ
	CMBiARhROgTmarALkP9gdE9nHxT2Ghg22cYz5g2fTyZGmhI5cQ9xG0k49olnKg==
Message-ID: <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
Date: Wed, 1 Jul 2026 12:04:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,birger-koblitz.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B426C6EBF46

Hi

On 7/1/26 07:42, Birger Koblitz wrote:
> The AX179A-based chips support pause parameter configuration.
> Make it available through ethtool ops.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/ax88179_178a.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 16528d873e804fde5dcc27659048882eee1c3eaa..586c049c6f7422a853aeae5e9372ead3a6d106c5 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -956,6 +956,71 @@ static int ax88179_set_link_ksettings(struct net_device *net,
>  	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
>  }
>  
> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +	u16 bmcr, lcladv, rmtadv;
> +	u8 cap;
> +
> +	data = dev->driver_priv;
> +
> +	if (data->chip_version < AX_VERSION_AX88179A)
> +		return;
> +
> +	bmcr = ax88179_mdio_read(net, dev->mii.phy_id, MII_BMCR);
> +	lcladv = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
> +	rmtadv = ax88179_mdio_read(net, dev->mii.phy_id, MII_LPA);
> +
> +	if (!(bmcr & BMCR_ANENABLE)) {
> +		pause->autoneg = 0;
> +		pause->rx_pause = 0;
> +		pause->tx_pause = 0;
> +		return;
> +	}
> +
> +	pause->autoneg = 1;

pause autoneg is not the same as link-wide autoneg. If link autoneg is disabled,
you have to keep track on how pause autoneg was configured by user, so that this
can be re-applied when link aneg gets re-enabled.

The best way to have this correct is to use phylink, but for that you'd need to
have a proper PHY driver instead of using the mii_ API here.

> +
> +	cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
> +
> +	if (cap & FLOW_CTRL_RX)
> +		pause->rx_pause = 1;
> +
> +	if (cap & FLOW_CTRL_TX)
> +		pause->tx_pause = 1;
> +}
> +
> +static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +	u16 old, new1, bmcr;
> +	u8 cap = 0;
> +
> +	data = dev->driver_priv;
> +
> +	if (data->chip_version < AX_VERSION_AX88179A)
> +		return -EOPNOTSUPP;
> +
> +	bmcr = ax88179_mdio_read(net, dev->mii.phy_id, MII_BMCR);
> +	if (pause->autoneg && !(bmcr & BMCR_ANENABLE))
> +		return -EINVAL;

As I said, pause autoneg can be on while linke autoneg is off. of course, the
device doesn't advertise pause, but the driver needs to keep track of what's
the pause aneg flag.

Maxime

