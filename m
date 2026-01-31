Return-Path: <netdev+bounces-255314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v04+GrxgfWkDRwIAu9opvQ
	(envelope-from <netdev+bounces-255314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:54:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFDC020E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8281303A271
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A6332EB2;
	Sat, 31 Jan 2026 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj4yejpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0903321A1;
	Sat, 31 Jan 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824405; cv=none; b=ixjahOLCBG1gvlQXcSCgR6gQAihoy5/C54Uc9xN8YI4M26kEi/uwR0SJB8/OtRy+/yZzHb4EkAgmHAvIYvq+XW42Gb8R5MO3MeGE04LiSBNHD9v9xlHS3vAxUNLlDCJ5XfYFNg/k4EUncAahq839xXd7g0x0D6zcNNBXG1wR2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824405; c=relaxed/simple;
	bh=kCGxsi2+JY8xh6UHx8+M4HV0AZO5admbAEMLEA/ZfZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7U3SoMudtlGZXLyg6c/jBR0xl+6UQIWJreh891SSPcjopCqoNfNUQrYwV2CL2s7fzWCVaoqfy3W81Wwo13GNpXXwRyOyEjespAdiRDPg8AxmPdLPdcqhWs779hvFdHZliCh35U9LsJ20a7SndzLAZw5cxMZ+q4JRQgO2BciGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj4yejpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F53C4CEF7;
	Sat, 31 Jan 2026 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824404;
	bh=kCGxsi2+JY8xh6UHx8+M4HV0AZO5admbAEMLEA/ZfZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cj4yejpNHhZjG5SroqoZ0N6bcXKEak8FmuuJpZfAK70jtM+1mVRPBwyqXrwpH26MO
	 PMJyAXAdC2O0MPYX5S7iWrr9oFNgdRdRHWjRiopLAKbJ9nxYGzydVmH1+k1cVowMFH
	 vt+xubBnLfbsjyCkEP5eERhExCVOMgJ+9xNDSlq/5UpqoKbKZSzjbIYEMYqB9Ma/0a
	 iID5davmNLKo757/dHuIYCgiqC4TgeNW8Up+OPAJntv/5Kx3T5XXPhPho7z8A/QyrV
	 3C8t2i8IZnSdETEoEyvWlF2vre4TIDFcK6urIdpxp4+1PDrdK+EMpSm/xVH5SU7SvG
	 ar5+5evoTBnpg==
From: Jakub Kicinski <kuba@kernel.org>
To: dam.dejean@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [v4,4/4] net: phy: realtek: add RTL8224 polarity support
Date: Fri, 30 Jan 2026 17:53:22 -0800
Message-ID: <20260131015322.971509-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129101606.33972-4-dam.dejean@gmail.com>
References: <20260129101606.33972-4-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255314-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,gmail.com,vger.kernel.org,redhat.com,google.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CBDFDC020E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: realtek: add RTL8224 polarity support

This patch adds MDI polarity swap support for RTL8224. The polarity
configuration uses 4 bits per port (one for each pair A-D) and is read
from the device tree property enet-phy-lane-polarity.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> +static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u8 port_offset = phydev->mdio.addr & 3;
> +	u32 polarity = 0;
> +	int ret, val;
> +
> +	ret = of_property_read_u32(np, "enet-phy-lane-polarity", &polarity);
> +
> +	/* Do nothing if the property is not present */
> +	if (ret == -EINVAL)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	if (polarity & ~0xf)
> +		return -EINVAL;
> +
> +	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				     RTL8224_VND1_MDI_POLARITY_SWAP);
> +	if (val < 0)
> +		return val;
> +
> +	val &= ~(0xf << port_offset);
> +	val |= polarity << port_offset;
            ^^^^^^^^^^^^^^^^^^^^^^^^

The shift amount appears incorrect for a 4-bit-per-port register layout.
Since polarity uses 4 bits (for pairs A-D) and port_offset ranges from
0 to 3, should the shift be (port_offset * 4) rather than just port_offset?

With the current code:
  - Port 0 (offset=0): writes to bits 0-3 (correct)
  - Port 1 (offset=1): writes to bits 1-4 (overlaps port 0)
  - Port 2 (offset=2): writes to bits 2-5 (overlaps ports 0-1)
  - Port 3 (offset=3): writes to bits 3-6 (overlaps ports 0-2)

The earlier v1 patch posted to lore used "(phydev->mdio.addr & 3) * 4"
for the offset calculation. Was the multiplication by 4 accidentally
dropped during refactoring?

For comparison, rtl8224_mdi_config_order() uses "1 << port_offset" which
is correct for a 1-bit-per-port layout, but the polarity register needs
4 bits per port.

> +	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				       RTL8224_VND1_MDI_POLARITY_SWAP, val);
> +}

