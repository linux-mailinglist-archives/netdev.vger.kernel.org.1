Return-Path: <netdev+bounces-286361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJmmG8/BAGppMQEAu9opvQ
	(envelope-from <netdev+bounces-286361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01E50571F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805EF30067B3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C13B5302;
	Sun, 10 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPCTJTEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23E3B52EB;
	Sun, 10 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434500; cv=none; b=ZcpiCSwY637ZpHP8bHXaUNXre0k7V1Q473aNU5xJSn625cOL47xuhbd+BDDyLmDefLzukCG8jts7bqTowyXhaaBDxBLyTh2cf6fcKbTD6zQ/7qMaRgHDB9Hlm+KkBK+l213DnXVKpoT8M+79E+vhUC6GbpVscHbJQpSX541VIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434500; c=relaxed/simple;
	bh=goYYYC72MZWf3WRhq1lKVZuXosZxeUv0H6r7pTepPKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePZm9LqrxkXMUJigYpNOzyu5E9I6luIP6OJbzCSXvfHLBldOxxJ3AV5J/jyuzOGGRXBuTyi/3SHX9y2lG7DYHLBpgICX4tLFUWtpzkxZPUOLK/pqVsFtM/IK2Ptgeg/jB9SPlEQFnpm5bQpXSbTEXGKN8ZPs8HXPUPZDVUiux8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPCTJTEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D242FC2BCB8;
	Sun, 10 May 2026 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434500;
	bh=goYYYC72MZWf3WRhq1lKVZuXosZxeUv0H6r7pTepPKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPCTJTEuRLWx/m76ox3Hk5bq9YaQqqx5N+wsF0ssum13v+o/UmyY5ZLs5a20hOaht
	 wU+dfaF5vwPGqgAZlj18mcNtzOFTrYPogXIPUkwLyukbWai5NIm6GWzXXXM4bk6PEt
	 JsdO2P8TUzh4nBxJnU+pOzNCUdxbIux4ivnZsO3++zZDhBw46IT4W4weZR6rwtnY88
	 2tUMMAajk+VyMyWgAD5bixsJUXkOK2hElJF7y//lYB6QKPWAaginJmPCP2IfW7Jlb+
	 CYuonWU+81g+OLY7N1WCsurbMyZBmrqRHrihp8rNXZTXIXV6kR1cf0V95D/8vLCD7c
	 4aeEaYaL7gLUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 8/8] net: dsa: realtek: rtl8365mb: add bridge port flags
Date: Sun, 10 May 2026 10:34:58 -0700
Message-ID: <20260510173458.3919914-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-8-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-8-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F01E50571F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add bridge port flags

This patch adds support for bridge port flags (BR_LEARNING, BR_FLOOD,
BR_MCAST_FLOOD, BR_BCAST_FLOOD) for rtl8365mb, adds new ops to the shared
realtek_ops structure, and introduces rtl83xx_port_bridge_flags and
rtl83xx_setup_port_flood_control helpers in the shared rtl83xx module.
All flooding types are enabled by default at port setup time.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 1b8034311b17..7c296f6a0a05 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -304,6 +304,21 @@
>  #define   RTL8365MB_MSTI_CTRL_PORT_STATE_MASK(_physport) \
>  		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
>  
> +/* Unknown unicast DA flooding port mask */
> +#define RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG		0x0890
> +#define   RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_MASK		0x07FF
> +
> +/* Unknown multicast DA flooding port mask */
> +#define RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_REG		0x0891
> +#define   RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_MASK	0x07FF
> +
> +/* Broadcast flooding port mask */
> +#define RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_REG		0x0892
> +#define   RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_MASK	0x07FF

[Low]
The three _PMASK_MASK defines (all 0x07FF) describing the 11-bit valid
port-mask field are introduced here, but the helpers below pass BIT(port)
directly as the regmap_update_bits mask and never reference these macros.
There is also no BUILD_BUG_ON or bounds guard relating BIT(port) to the
hardware field width.

Should these _MASK macros be dropped, or used in something like a
BUILD_BUG_ON asserting BIT(RTL8365MB_MAX_NUM_PORTS - 1) fits within the
valid field?

> +
> +#define RTL8365MB_SUPPORTED_BRIDGE_FLAGS \
> +	    (BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD)
> +
>  /* Miscellaneous port configuration register, incl. VLAN egress mode */
>  #define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
>  #define RTL8365MB_PORT_MISC_CFG_REG(_p) \
> @@ -1450,6 +1465,49 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
>  			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
>  }
>  
> +static int rtl8365mb_port_set_ucast_flood(struct realtek_priv *priv, int port,
> +					  bool enable)
> +{
> +	/* Frames with unknown unicast DA will be flooded to a programmable
> +	 * port mask that by default includes all ports. Add or remove
> +	 * the specified port from this port mask accordingly.
> +	 */
> +	return regmap_update_bits(priv->map,
> +				  RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG,
> +				  BIT(port), enable ? BIT(port) : 0);
> +}

[ ... ]

> +static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +					   struct switchdev_brport_flags flags,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +
> +	dev_dbg(priv->dev, "pre_bridge_flags port:%d flags:%lx supported:%lx",
> +		port, flags.mask, RTL8365MB_SUPPORTED_BRIDGE_FLAGS);
> +
> +	if (flags.mask & ~RTL8365MB_SUPPORTED_BRIDGE_FLAGS)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Low]
Is there a reason the supported-mask lives in the per-chip driver while the
apply path in the shared module independently decides support by NULL-checking
each ops pointer at runtime?

The pre_bridge_flags contract in DSA/switchdev is that pre_bridge_flags must
reject any flag that bridge_flags cannot later apply. Today rtl8365mb
populates all four port_set_* ops and the hardcoded mask agrees, so there is
no user-visible bug.

However, a future sibling driver reusing the exported
rtl83xx_port_bridge_flags with a mismatched per-chip pre_bridge_flags could
violate that contract, since rtl83xx_port_bridge_flags still returns
-EOPNOTSUPP for a missing ops pointer:

drivers/net/dsa/realtek/rtl83xx.c:rtl83xx_port_bridge_flags() {
    ...
    if (flags.mask & BR_LEARNING) {
        if (!priv->ops->port_set_learning)
            return -EOPNOTSUPP;
        ...
    }
    ...
}

Would it be cleaner to have the shared module own a common pre_bridge_flags
(or a helper that computes the supported mask from the ops vector) so the
two paths cannot drift?

> +
>  static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
>  				   u32 efid)
>  {

[ ... ]

