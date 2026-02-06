Return-Path: <netdev+bounces-257389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BEBN3RQhWn5/gMAu9opvQ
	(envelope-from <netdev+bounces-257389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:22:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392FF93AD
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A955302F7F6
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7523F422;
	Fri,  6 Feb 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwqTcEMx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B3273F9;
	Fri,  6 Feb 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344497; cv=none; b=ZAFYLnjI2anLGhewA+aXF7pUGo7MVeaP9gGx2wdCHdRUvNV6r65CQWS0bNqKl7oVqVFrwfVjOWQsIMP8nDt3X5WFJdadDz8nu/h4iuhATMqOvHcKaVErk/qBeUfiZJy/eFFrF/1VciMInSyn88eTUpFKfdOanZfrA3lZOxDLlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344497; c=relaxed/simple;
	bh=rvqyduOqokC08DWEusOCUed+bZfyYnjh9mnglnbEpMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeJ6kAsSycOke/9tD0SOMMGE4TJf6R/FoyJhcO9dsaTUa0JxCC0XGFWQs0FmuRsY8G55ZqfGaioNrdZoM8Jn88SWuJP1crbwj8Zl2BMyk8Z0ZYBfUBKErPyxQXMP75NUKyJN18eKiOPwXpXMWVnxdHTrSN1v3/8xW1GhhgRJg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwqTcEMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2348C4CEF7;
	Fri,  6 Feb 2026 02:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344496;
	bh=rvqyduOqokC08DWEusOCUed+bZfyYnjh9mnglnbEpMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwqTcEMxr1dz8BXa8NkluEUYCu0mMX0IcyhmpLf39wgEf6LhDa98u46O6zQPRiEZR
	 8G1OeftPJoX+iXQ8KPDGvQOxPqV3/iy8FRayEfasp/dYTc0qvOhVdW4VJl72BfDEL7
	 HEv3AjF6zNZdpgVP3iv7XQwA89Uuq3/GOlJ91mKujvwvN6aohjE4tiBIABdcr9HPWI
	 c+sW2/ddIGM5pRxDwU2w/hoqSxg2n5jex/1yoD7rn3e2g6BCpa45wzurF/1weaYGM8
	 MIt+psM+TaTbW4NmmjL12vlzlzv3+Evs2quDo6EC9GZ0TptBbaBjY+5MoGk8bzsv4z
	 RDfORNJciv4eg==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	chad@monroe.io,
	devicetree@vger.kernel.org,
	lxu@maxlinear.com,
	frankwu@gmx.de,
	linux@armlinux.org.uk,
	john@phrozen.org,
	robh@kernel.org,
	cezary.wilmanski@adtran.com,
	hkallweit1@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	olteanv@gmail.com
Subject: Re: [net-next,v13,2/4] net: dsa: add tag format for MxL862xx switches
Date: Thu,  5 Feb 2026 18:21:34 -0800
Message-ID: <20260206022134.3185316-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <82706bbd489b5c68699060630ec6577f9aefb849.1770211259.git.daniel@makrotopia.org>
References: <82706bbd489b5c68699060630ec6577f9aefb849.1770211259.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,davemloft.net,monroe.io,maxlinear.com,gmx.de,armlinux.org.uk,phrozen.org,adtran.com,gmail.com,google.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-257389-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5392FF93AD
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: add tag format for MxL862xx switches

This patch adds a DSA tag driver for MaxLinear MxL862xx switches. The
tag format uses an 8-byte header with an ethertype marker that is shared
with GSW1xx switches, though the format itself differs.

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -104,6 +104,13 @@

[ ... ]

> +config NET_DSA_TAG_MXL_862XX
> +	tristate "Tag driver for MxL862xx switches"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte
          ^^^^^^^^^

This isn't a bug, but there's inconsistent capitalization here. The help
text uses "Maxlinear" while the adjacent NET_DSA_TAG_MXL_GSW1XX entry uses
"MaxLinear" (with capital L). The MODULE_DESCRIPTION in tag_mxl862xx.c also
uses "MaxLinear".

> +	  tagging protocol.

> diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> --- /dev/null
> +++ b/net/dsa/tag_mxl862xx.c
> @@ -0,0 +1,110 @@

[ ... ]

> +static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	unsigned int cpu_port, sub_interface;
> +	__be16 *mxl862_tag;
> +
> +	cpu_port = cpu_dp->index;
> +
> +	/* target port sub-interface ID relative to the CPU port */
> +	sub_interface = dp->index + 16 - cpu_port;
                        ^^^^^^^^^^^^^^^^^^^^^^^^

Can sub_interface overflow the 5-bit MXL862_SUBIF_ID field here? With
dp->index = 16 and cpu_port = 0, the calculation would yield 32 which
exceeds the valid range (0-31) for GENMASK(4, 0). FIELD_PREP would silently
truncate this to 0 via masking. Is there a constraint on port configurations
that prevents this from occurring?

> +
> +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> +	skb_push(skb, MXL862_HEADER_LEN);

[ ... ]

> +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> +
> +	/* special tag ingress */
                      ^^^^^^^

This comment says "ingress" but mxl862_tag_xmit() is the TX/egress path.
Should this say "egress" instead?

> +	mxl862_tag = dsa_etype_header_pos_tx(skb);
-- 
pw-bot: cr

