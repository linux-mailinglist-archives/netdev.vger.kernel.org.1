Return-Path: <netdev+bounces-292914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNS9GXLmGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:05:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD45FBCEB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD633007E14
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562DE34D3B5;
	Fri, 29 May 2026 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nS0mF+YZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93C34A3DB;
	Fri, 29 May 2026 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016486; cv=none; b=tP/GjYKHvDw6+0KIRDIsjlnXSspWzY5Jg0wFyHyd6FVUuyiUIUlVJz2/1YXJejjXTMRWMaAl9zA3LA//5nyI6EeH9/QyRZMCmLk3FXfdUZtXnA7E6d4P+RxvSZxHzsmFVzAJS1gsDoqG1I6xi2z87JX8lYDHEi7Oq0Dm/1ffWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016486; c=relaxed/simple;
	bh=EJ01cKr/89oMLtmbN78nUH9ErQBEQHZIcsh1NaagPh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0IZl+tfahLXXpI6OrbtJsWlISA3YIk9zGlGHZxhSgmoTSjiiwOweOAG2wanhnjb6M8ishUta3eJZaYxquEg57qvz/E6nGYKWwtjsKmqic5GHNlefBSYCi+Q5uUHF/xB+45RwE0B+onmDRpA/6K7lhm+luUwYbclZTDynAM1PIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nS0mF+YZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k2yuPMgp4eg9h09XEn29ipnMVEerGE4h/JXzPrSMF74=; b=nS0mF+YZ8Rx297bAUqcFdgyshO
	L1IXv0JGpgy+aDp9NUNxXiVsB+3vyDrnshFfk6N6UVY+EplsAeaMQOKTTA2NRc77kqA258CZ+LBO7
	xsdja1rJg5i5Srjze5yfzagbIWKpLMmz66uwJYuDsYW9TsJSmXYFAsR5VYT4/fFquTOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlb8-004zHx-Ts; Fri, 29 May 2026 03:01:14 +0200
Date: Fri, 29 May 2026 03:01:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: realtek: load firmware for
 RTL8261C
Message-ID: <6c5f5fd4-5ab9-4a0a-96e6-bd7b7bee34ed@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075226.1054-3-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292914-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBDD45FBCEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +struct rtl8261x_fw_header {
> +	__le32 main_magic;	/* Main magic number 0x52544C38 ("RTL8") */
> +	__le32 sub_magic;	/* Sub magic number */
> +	__le16 version_major;	/* Major version */
> +	__le16 version_minor;	/* Minor version */
> +	__le16 num_entries;	/* Number of entries */
> +	__le16 reserved;	/* Reserved */
> +	__le32 crc32;		/* CRC32 checksum */
> +} __packed;
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
> +} __packed;

It looks like __packed should not be needed in both of
these. Everything is aligned so the compiler will naturally pack
them.

> +	sub_magic = le32_to_cpu(hdr->sub_magic);
> +	if (sub_magic != FW_SUB_MAGIC_8261C && sub_magic != FW_SUB_MAGIC_8261D) {
> +		phydev_err(phydev, "Invalid sub magic: 0x%08x\n", sub_magic);
> +		return -EINVAL;
> +	}

Should there be validation you are not trying to install C firmware on
D hardware? And visa versa?

> +static int rtl_phy_write_mmd_bits(struct phy_device *phydev, int devnum,
> +				  u16 reg, u8 msb, u8 lsb, u16 val)
> +{
> +	int ret;
> +	u32 reg_val;
> +
> +	if (msb > 15 || lsb > msb)
> +		return -EINVAL;
> +
> +	ret = phy_read_mmd(phydev, devnum, reg);
> +	if (ret < 0)
> +		return ret;
> +	reg_val = ret;
> +
> +	reg_val &= ~GENMASK(msb, lsb);
> +	reg_val |= (val << lsb) & GENMASK(msb, lsb);

The logic here is not very obvious. Please could you add some kdoc to
explain what this function does.

	Andrew

