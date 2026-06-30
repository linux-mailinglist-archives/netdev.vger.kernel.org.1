Return-Path: <netdev+bounces-303383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VdDsALk+RGoXrQoAu9opvQ
	(envelope-from <netdev+bounces-303383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB36E852C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Gmq94SnA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303383-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D76E23023A7E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E011631E846;
	Tue, 30 Jun 2026 22:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E068233958;
	Tue, 30 Jun 2026 22:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857397; cv=none; b=OLUjOiX7YwSbStLoDIUYBhJYN3YTAYabK7UqjF4UGuLWiGn2kC5OPUUa8ca9W5XykA8P4JljHz2lrIf00WvR1t6VL+qn7N1C9cvqjy2EArGiTDR0YaSiCFFkhfU0v4sSCWdE4oWuNBEvdwMtJuzaC02E/MYwFw2l7OC1scYwf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857397; c=relaxed/simple;
	bh=E7XbFqPtX8oY5xQ4JTaTzCT5F3nO7FI2AGSrk/3nF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez1T2/TUtJa3wPlWjQfV45Mk3Iv9edtLzmiJCJns/Cz69ebgZP9Dr3LnAcpIFGPJz7DjI9MrwpD4Y8C1uFtt8X85BLbiO4S79OALFkTTT3jmUa6/oGwMoEhNehudY1FEZ4P0hVT0fHpXEB2NcOY4iQ2LGDXQd/Td5eT8UAxUkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gmq94SnA; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Mx3yAYryVx2HMKoybiqMF1I096DhHL2HkocxlL6IyY=; b=Gmq94SnAnGJWfGZbUzk9Ala5Zd
	JXg0VhXTbQnP17uRg1uw2IlmOJ7IhhgtI4RalvtkUJe4/PhLybGMgANRSrn/ClSdBy294PVtYYHDC
	ZhJCnsXI7U/rR+6sXo79oRglqsHpFELHyZdh8Bz60yc/PF0rlU4OuMkeohYHFzF693Cc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegeJ-00A3De-6l; Wed, 01 Jul 2026 00:09:47 +0200
Date: Wed, 1 Jul 2026 00:09:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v7 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Message-ID: <1ac195f7-29c2-45a3-84a9-cfc5366aee6f@lunn.ch>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064718.1349-5-javen_xu@realsil.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:nic_swsd@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com,realtek.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realsil.com.cn:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3EB36E852C

On Mon, Jun 29, 2026 at 02:47:18PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will not pad
>  - reverse xmas tree for some definition
>  - add explanation on rtl_phy_write_mmd_bits()
> 
> Changes in v3:
>  - add struct rtl8261x_priv
> 
> Changes in v4:
>  - add struct device *dev
> 
> Changes in v5:
>  - no changes
> 
> Changes in v6:
>  - replace rtl_phy_write_mmd_bits with phy_modify_mmd, keep mdio lock
>  - check msb and lsb at the beginning of rtl8261x_fw_execute_entry()
>  - add comments on rtl8261x_config_init()
> 
> Changes in v7:
>  - no changes
> ---
>  drivers/net/phy/realtek/realtek_main.c | 220 +++++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index ef3700894ebf..bf7bc19fb44c 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -8,7 +8,9 @@
>   * Copyright (c) 2004 Freescale Semiconductor, Inc.
>   */
>  #include <linux/bitops.h>
> +#include <linux/crc32.h>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/firmware.h>
>  #include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/pm_wakeirq.h>
> @@ -281,6 +283,42 @@
>  					 RTL8261X_INT_ALDPS_CHG | \
>  					 RTL8261X_INT_JABBER)
>  
> +#define FW_MAIN_MAGIC			0x52544C38
> +#define FW_SUB_MAGIC_8261C		0x32363143
> +#define RTL8261X_POLL_TIMEOUT_MS	100
> +
> +#define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
> +MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
> +
> +enum rtl8261x_fw_op {
> +	OP_WRITE = 0x00,	/* Write */
> +	OP_POLL  = 0x02,	/* Polling */
> +};
> +
> +struct rtl8261x_fw_header {
> +	__le32 main_magic;	/* Main magic number 0x52544C38 ("RTL8") */
> +	__le32 sub_magic;	/* Sub magic number */
> +	__le16 version_major;	/* Major version */
> +	__le16 version_minor;	/* Minor version */
> +	__le16 num_entries;	/* Number of entries */
> +	__le16 reserved;	/* Reserved */
> +	__le32 crc32;		/* CRC32 checksum */
> +};
> +
> +struct rtl8261x_fw_entry {
> +	__u8  type;		/* Operation type (OP_*) */
> +	__u8  dev;		/* MMD device */
> +	__le16 addr;		/* Register address */
> +	__u8  msb;		/* MSB bit position */
> +	__u8  lsb;		/* LSB bit position */
> +	__le16 value;		/* Value to write/compare */
> +	__le16 timeout_ms;	/* Poll timeout in milliseconds */
> +	__u8  poll_set;		/* Poll for set (1) or clear (0) */
> +	__u8  reserved;		/* Reserved */
> +};

Are there other devices which need firmware download? Do they use the
same header? I'm just wondering if this will be reused by other
devices?

	Andrew

