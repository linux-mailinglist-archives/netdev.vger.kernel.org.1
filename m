Return-Path: <netdev+bounces-274834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD9eIrgVz2k2swYAu9opvQ
	(envelope-from <netdev+bounces-274834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:19:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D37F38FF75
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D4B30A7664
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF0029A9C8;
	Fri,  3 Apr 2026 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBRbUbgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9027A907;
	Fri,  3 Apr 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179068; cv=none; b=TB8VPlx0O6CFEXs/OCX1BuAe07rJwP/Nv1Sz5YRhvYyKgnL0mVvplp9+vuhHahL9lnoSbsL/NQ/jK9v4jzcgDpeIgs+LpjUUtEha4DWNWAgBkTEie4DlFIKwU8doXqAAlw6uokzzEealzG9SwWBdQhaUZLqtQ9wnUCNxCz8aLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179068; c=relaxed/simple;
	bh=Rg13dO41JuHb3wyGXv+CMSlZCAw+nSPFyVhUygIx8Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls5UNFFVDd/7+yt5UnUJ5+wkGZME00Q3R0hZDkAKh81xxXqIvjAMk5yYpA2bg2AWnp/k/uf6O2OtSPUgV+dcDZz4yi5fCh1ZJUlZeNGGakafz/pzFYuOzuts9uDSE3DPTz/sbsNP645mfC4Fj1u7COg5zgSjLANExEkqv16+gnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBRbUbgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7FAC2BCB0;
	Fri,  3 Apr 2026 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179067;
	bh=Rg13dO41JuHb3wyGXv+CMSlZCAw+nSPFyVhUygIx8Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBRbUbgk+bgMpenm2PErPtlkiQ/rZme/dpiQyoIhg3+DqVf0+OSNzpbAxKMpXCC3p
	 ZrxFUhlyAI22ZzXD8J8+n1t8F6Yq8ePqyxvLAqCn9ZangWFa4SWSiaBnPZqDyT/xJr
	 NhiwEFrprH+XoPogoimKWIoo1LmRXzS/fu8x/bwhO5F99a7XKsYWsyf+CIbF5wa8sF
	 Hylqd+NfeB0bEMnAmxTXmOlAvWbAWyoKvR4XA4Y2CoO3CrY8Ym38vHHYzVVw0nyJ8N
	 0GVmzGLC5p458zzb7GGrHVUANijvaFvFuXjUqqTqgZmlIFsk0u+lUUveqv+OMXpRuT
	 3Ji4GDB7LngOg==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Thu,  2 Apr 2026 18:17:45 -0700
Message-ID: <20260403011745.1795759-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-14-wei.fang@nxp.com>
References: <20260331113025.1566878-14-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274834-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D37F38FF75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: netc: initialize buffer bool table and implement flow-control

This commit adds buffer pool initialization and flow control support for the
NXP netc switch. It maps frame priorities to specific buffer pools and
configures transmission pause thresholds.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 3609d83ac363..688dceb486c2 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> @@ -386,6 +388,15 @@ static void netc_port_fixed_config(struct netc_port *np)
>  	/* Enable L2 and L3 DOS */
>  	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
>  		      PCR_L2DOSE | PCR_L3DOSE);
> +
> +	/* Set the quanta value of TX PAUSE frame */
> +	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), pqnt);
> +
> +	/* When a quanta timer counts down and reaches this value,
> +	 * the MAC sends a refresh PAUSE frame with the programmed
> +	 * full quanta value if a pause condition still exists.
> +	 */
> +	netc_mac_port_wr(np, NETC_PM_PAUSE_TRHESH(0), qth);

This isn't a bug, but there's a typo in the macro name (TRHESH instead of
THRESH).

[ ... ]
> +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> +{
> +	/* The BPCAPR register is a read only register, the hardware
> +	 * guarantees that the BPCAPR_NUM_BP field will not be 0.
> +	 */
> +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> +}
[ ... ]
> +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> +{
> +	int bp_per_port = priv->num_bp / priv->info->num_ports;
> +	int q = NETC_IPV_NUM / bp_per_port;
> +	int r = NETC_IPV_NUM % bp_per_port;

If the hardware register read in netc_get_buffer_pool_num() returns a value
smaller than priv->info->num_ports (for instance, during a bus error or
reset state), bp_per_port will evaluate to 0.

Can this lead to a division by zero panic here?

Should priv->num_bp be validated against the number of ports before
performing this calculation to ensure the driver fails gracefully if the
hardware returns an unexpected value?

[ ... ]
> diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
> index c6a0c0a8ff8a..1e1c0d279a21 100644
> --- a/drivers/net/dsa/netc/netc_switch_hw.h
> +++ b/drivers/net/dsa/netc/netc_switch_hw.h
[ ... ]
> @@ -145,6 +152,12 @@ enum netc_stg_stage {
>  #define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
>  #define  PM_IEVENT_RX_EMPTY		BIT(6)
>  
> +#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
> +#define  PAUSE_QUANTA_PQNT		GENMASK(15, 0)
> +
> +#define NETC_PM_PAUSE_TRHESH(a)		(0x1064 + (a) * 0x400)
> +#define  PAUSE_TRHESH_QTH		GENMASK(15, 0)

This isn't a bug, but there's a typo in the macro names here as well
(TRHESH instead of THRESH).

