Return-Path: <netdev+bounces-264807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN/xHzHeqmlqXwEAu9opvQ
	(envelope-from <netdev+bounces-264807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2ED222383
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36ADC308387B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EF3A1A41;
	Fri,  6 Mar 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1gd/RKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC539FCB8;
	Fri,  6 Mar 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805565; cv=none; b=TR86d0yc9ljUZNkyq/UvOvKfj3NYSdlJy8ZDUbBMBuGOg8XMenYWOEw0pzvPRJWDwfFy8szFNB8rSpv/xm5OqYzpv9dkfGpPiZSy0ASXoSOGB1okBDGCMSRvjio+nbTjdV7c3XZcm2CWrUZArAdBuch2BVLY+pPm4CmBSMHsGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805565; c=relaxed/simple;
	bh=L+C/yxI/+etFxuIlEkwUn0ShwIG0/HWx8nzupbNnVJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIfdYwDTqWjbAq/JBg85sZf7jLa2AGhJMh5R0vOc5bqSGePe4EZOVIzgSoehXC2xPluVfx7MswmxLJ4DMhueUH3KrC3a557MSHmehVW/9gctVLF0QVUlGkgzNWe/qUHJREanqtWsDt9lgYO/YioiAvXlfpCG5H11ERlTZ6TvPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1gd/RKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D5C4CEF7;
	Fri,  6 Mar 2026 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772805564;
	bh=L+C/yxI/+etFxuIlEkwUn0ShwIG0/HWx8nzupbNnVJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1gd/RKeM4sdrNXUr/lCJ5EWR7owv6TF5MkpQLZsCLvrwW5cGgh4RwojYMHit9I2q
	 8ZeiES0HmpPdBUbIYiPIfuJXaYA9Oh28MX7Wdn915AZur6s8EaEEhJSA8IWBv92nBQ
	 OfyiRtRgNWX/4xI3FQ8zRmwELNuD/zuEG9g3fz1MiSduY669/8wFaWB2JNKrysrKHV
	 6Dk6HRqjECK/ZfRRuBq06WCFjgwPlSz53UXklzEUhaazIKcBT6A3XjgTOvcetzeF7V
	 GNokxVMxg/6XV+D8WJ+M5opjrJNy4THnA6D8iKQ9EH7ITffpSVcA9+X88o5DxMaFY5
	 loNRQBBUcv5Cg==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	daniel@makrotopia.org,
	kabel@kernel.org,
	nicveronese@gmail.com,
	mwojtas@chromium.org,
	romain.gantois@bootlin.com,
	herve.codina@bootlin.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	dimitri.fedrau@liebherr.com,
	andrew@lunn.ch,
	o.rempel@pengutronix.de,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	kory.maincent@bootlin.com,
	hkallweit1@gmail.com,
	thomas.petazzoni@bootlin.com,
	christophe.leroy@csgroup.eu,
	f.fainelli@gmail.com
Subject: Re: [net-next,v6,10/10] net: ethtool: Introduce ethtool command to list ports
Date: Fri,  6 Mar 2026 13:58:54 +0000
Message-ID: <20260306135854.492356-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304145444.442334-11-maxime.chevallier@bootlin.com>
References: <20260304145444.442334-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE2ED222383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,nxp.com,makrotopia.org,gmail.com,chromium.org,bootlin.com,vger.kernel.org,liebherr.com,lunn.ch,pengutronix.de,armlinux.org.uk,csgroup.eu];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-264807-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: ethtool: Introduce ethtool command to list ports

This commit introduces a new ethtool netlink command to expose phy_port
information to userspace, allowing enumeration of available ports and
their capabilities on a given interface.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2265e2c9bfbe..668af8739c21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18421,6 +18421,7 @@ F:	Documentation/devicetree/bindings/net/ethernet-connector.yaml
>  F:	Documentation/networking/phy-port.rst
>  F:	drivers/net/phy/phy_port.c
>  F:	include/linux/phy_port.h
> +F:	net/ethtool/port.c
>  K:	struct\s+phy_port|phy_port_
>
>  NETWORKING [GENERAL]

[ ... ]

> diff --git a/net/ethtool/port.c b/net/ethtool/port.c
> new file mode 100644
> index 000000000000..d870ed70769e
> --- /dev/null
> +++ b/net/ethtool/port.c
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2026 Bootlin
> + *
> + */
> +#include "common.h"
> +#include "bitset.h"
> +#include "netlink.h"
> +
> +#include <linux/phy.h>
> +#include <linux/phy_link_topology.h>
> +#include <linux/phy_port.h>
> +#include <net/netdev_lock.h>

[ ... ]

> +static int port_dump_one(struct sk_buff *skb, struct net_device *dev,
> +			 struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	void *ehdr;
> +	int ret;
> +
> +	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_A_PORT_HEADER);
> +	if (!ehdr)
> +		return -EMSGSIZE;

Is ETHTOOL_A_PORT_HEADER the correct constant here?

The third parameter to ethnl_dump_put() should be the genetlink command
ID that gets stored in the message header's cmd field. Looking at other
dump implementations in net/ethtool/:

net/ethtool/tunnels.c:
    ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY);

net/ethtool/tsinfo.c:
    ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_TSINFO_GET_REPLY);

net/ethtool/rss.c:
    ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_RSS_GET_REPLY);

These all pass ETHTOOL_MSG_*_GET_REPLY command constants, not
ETHTOOL_A_* attribute constants.

ETHTOOL_A_PORT_HEADER is a netlink attribute with value 1 (from
include/uapi/linux/ethtool_netlink.h). Meanwhile, this file's
ethnl_port_request_ops structure correctly uses
ETHTOOL_MSG_PORT_GET_REPLY for .reply_cmd, suggesting the same
constant should be used here. Can this cause the wrong command ID
to be sent in every dump response message?

> +
> +	memset(ctx->reply_data, 0, sizeof(struct port_reply_data));
> +	ctx->reply_data->base.dev = dev;
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +
> +	ret = port_prepare_data(&ctx->req_info->base, &ctx->reply_data->base,
> +				genl_info_dump(cb));
> +
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PORT_HEADER);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = port_fill_reply(skb, &ctx->req_info->base, &ctx->reply_data->base);
> +
> +out:
> +	ctx->reply_data->base.dev = NULL;
> +	if (ret < 0)
> +		genlmsg_cancel(skb, ehdr);
> +	else
> +		genlmsg_end(skb, ehdr);
> +
> +	return ret;
> +}

[ ... ]

> +const struct ethnl_request_ops ethnl_port_request_ops = {
> +	.request_cmd		= ETHTOOL_MSG_PORT_GET,
> +	.reply_cmd		= ETHTOOL_MSG_PORT_GET_REPLY,
> +	.hdr_attr		= ETHTOOL_A_PORT_HEADER,
> +	.req_info_size		= sizeof(struct port_req_info),
> +	.reply_data_size	= sizeof(struct port_reply_data),
> +
> +	.parse_request		= port_parse_request,
> +	.prepare_data		= port_prepare_data,
> +	.reply_size		= port_reply_size,
> +	.fill_reply		= port_fill_reply,
> +};

