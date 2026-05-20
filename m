Return-Path: <netdev+bounces-290143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPTGCyZNDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628959D2BF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459E630B7EA9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8F13CF049;
	Wed, 20 May 2026 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJUV95c0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E13BCD00;
	Wed, 20 May 2026 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321269; cv=none; b=pesu44N2T5IjDcAcrnC5dhuZERp1tSvk2bLax8Cu8ol7H1WE+hlb4MaLwRVWx2NFPm91sC6v0CpxXuYG67koPA4Y5+TBM3xk48T4XyFM+FWKJbayT6L2bwOlfwPWk3iUde0n9ihrEwsaPCyZ9BjNtNMcUN0hvwaspyfUM5f27C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321269; c=relaxed/simple;
	bh=c7t6Qwp2D8+0c78isgsa64lENxyi5QL1pDHjf80d3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0ZJ55F77xsHVZNCJuZnzULME8o4sLmtxb9MZLHmsDJfMf5AH8P3OI24m/0JCcx7sh0MYlSvCVqFTR4EM/ig/Nh45rzeVHOHIiGHPM6pxOnXbA0mQwH/Ts0kdexwQ1cYI1qSxxwlfy3ospS7XXf3s0XH+t+qigf+q1MauePpxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJUV95c0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F11F000E9;
	Wed, 20 May 2026 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321265;
	bh=MJ4ZIc3h7zLPBENuUh7n9d+K8WTHsOChznzwVtzycgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HJUV95c0m74sx/DOnX4PUsnGWXV7rjPlF2zaip0373+uZcW2rL43j7oLeOxY0FUrf
	 5NA61rD/Lqrot2MKbp5ad7VoksChn3zYHe82d4x0an3BXfrBlKKlMkhihnEv7cmU5I
	 CsBvL4wfIHMmofXJ+m67p6Om6gAtfpv7FcgjeM7CADedk0apJNCj2ssRB2qMst1VM+
	 mxSwO4mZqBXYY4EhMVIrGjRPECOttVD377EfkcRwKzdTbmyKE7xukbYGcLhLyGiQEo
	 kKNwJqBdXDoBXG1KQnmSSqWf0oPX17v9bKiqhQP2G+5cwWKr4WKddFqkmR58+NaXdd
	 o22/If+FhQOJA==
Date: Wed, 20 May 2026 16:54:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v5] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <20260520165424.5e61d5d9@kernel.org>
In-Reply-To: <20260517065041.50155-1-lucienzx159@gmail.com>
References: <20260517065041.50155-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8628959D2BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 14:50:41 +0800 Lucien.Jheng wrote:
> +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
> +				u32 pbus_reg, u32 pbus_data)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
> +			      upper_16_bits(pbus_reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
> +			      (pbus_reg & GENMASK(5, 2)) >> 2,
> +			      lower_16_bits(pbus_data));

Please add proper defines for these GENMASK'ed fields and use
FIELD_GET() to access the fields?

> +	if (ret < 0)
> +		return ret;
> +
> +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
> +			       upper_16_bits(pbus_data));
> +}

> @@ -1175,10 +1281,21 @@ static int an8811hb_probe(struct phy_device *phydev)
>  		return -ENOMEM;
>  	phydev->priv = priv;
> 
> +	mdiodev = mdio_device_create(phydev->mdio.bus,
> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
AI says:

What happens when phydev->mdio.addr is in the range 24..31?
MDIO addresses 0..31 are all valid 5-bit hardware addresses, so a
strap-selected AN8811HB at address >= 24 makes
phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS land in 32..39. struct
mii_bus has mdio_map[PHY_MAX_ADDR] with PHY_MAX_ADDR == 32, and
mdiobus_register_device() does:
	if (mdiodev->bus->mdio_map[mdiodev->addr])
		return -EBUSY;
	...
	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
with no bounds check on mdiodev->addr. The OOB read from
mdio_map[32..39] may return garbage that happens to be non-NULL
(probe fails with -EBUSY) or NULL (the OOB store overwrites adjacent
fields of struct mii_bus such as phy_mask, phy_ignore_ta_mask, or
the irq[] array).
Even without corruption, every later __air_pbus_reg_write() goes
through __mdiobus_write(), which has:
	if (addr >= PHY_MAX_ADDR)
		return -ENXIO;
so each MCU assert/deassert silently fails with -ENXIO, which seems
to contradict the commit message:
    so every firmware load or MCU restart on AN8811HB correctly
    sequences the reset control registers.
Should an8811hb_probe() reject configurations where
phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS >= PHY_MAX_ADDR, or
otherwise enforce the assumed strap-pin constraint?
-- 
pw-bot: cr

