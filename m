Return-Path: <netdev+bounces-258661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJGnBkNvj2m3QwEAu9opvQ
	(envelope-from <netdev+bounces-258661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:36:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A814138F8B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCD903004690
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522727BF93;
	Fri, 13 Feb 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="emu0VDIb"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABB27A904;
	Fri, 13 Feb 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007256; cv=pass; b=Qe3IdyhV8dEkibiN5IdK7XLh4wzBVplwcZ5uvaNXrLZMVB9VNV23NUIlEpW5qax8IXXBBcQsynL5URh/eb2seg06f9NNoW00qM6PEnN+Zr8J0EwIyc+3gvOuHbSwrLp1yHkPMRVgX9G5cB92kb6ohtrX9ZutTaN29JYlHladNts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007256; c=relaxed/simple;
	bh=ChO7JIjhGGMGIGBUuZxKK3ZgSisOlB673T4nFLjBGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f94DAK8CoEGy+XwrqoXk6uSXc7qDYMAh7QzzQKVC9FKIjqZhx/glnEs8rOAcgehHRmLWB2eCJsqWWiPepYmpev8KJ3IGjHuaE3ax5MeeOb0hydRj4MHkfmQrbwxacHXqqovsAvYDxSu8k3oNLE5+mEkKjEHzOtbgXs0IHRPa+94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=emu0VDIb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1771007223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AzE9jYI3jHPtw3O8eJ+jhLILfMg2IbWH8pow8bZ7nAtg7VUBUjCGEBgnQqdpXWEZ9bvCm48cwwmaNEI+N1W8zAFHorCk55GA0dqo55mPy3sEDbX4WfYW5IwwDnKRffBjrAzv4rFdybZZNJfBJhPAcl48O3V+TwEZ3E6cBI9bN+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771007223; h=Content-Type:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mY3KvVQTMdhlwCwGfxZ8paH0e/fwTPQdmCblgG7lpwo=; 
	b=I2lNyBs2W6XPUaVCHM7VGzGgWmN2+prqvI786acCyDDdxTOP9xfTFPEI7WcZLsTtMXE3ZsgFx1YDhILEfGiC0qAxoKXmOYX3yQP6BgmtQvcW6Kc/SU97u2rTxhJPt15zQ/IASDLo6ioP1aBN5wUk/VBQwYcxwfDFvkFhISXKhGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771007223;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=mY3KvVQTMdhlwCwGfxZ8paH0e/fwTPQdmCblgG7lpwo=;
	b=emu0VDIbvKpft0jaGTu82LjXNrUP9yxq0fM/SdxZsQcUHRK1EQKRKGlF7QIKpL/B
	C5NrAoTaCsc6Nxdsi2O8aU/l61uGAfFLq4E6sDl86ZPvj6ECJwnnbOrOYAdXgAuQeCU
	IdS3AeASN4s9jsHbzjC0jnYhIKk4RKk7WKwpw11k=
Received: by mx.zohomail.com with SMTPS id 1771007221343248.33202963816166;
	Fri, 13 Feb 2026 10:27:01 -0800 (PST)
Date: Fri, 13 Feb 2026 18:26:44 +0000
From: Yao Zi <me@ziyao.cc>
To: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <me@ziyao.cc>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <aY9s5PXP4zZ7R6fa@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sntech.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258661-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziyao.cc:dkim]
X-Rspamd-Queue-Id: 2A814138F8B
X-Rspamd-Action: add header
X-Spam: Yes

Hi folks,

I was looking through the RGMII delay setup logic found in
rk_gmac_powerup() of dwmac-rk.c, and found its behavior is strange,

	switch (bsp_priv->phy_iface) {
	case PHY_INTERFACE_MODE_RGMII:
		dev_info(dev, "init for RGMII\n");
		if (bsp_priv->ops->set_to_rgmii)
			bsp_priv->ops->set_to_rgmii(bsp_priv,
						    bsp_priv->tx_delay,
						    bsp_priv->rx_delay);
		break;
	case PHY_INTERFACE_MODE_RGMII_ID:
		dev_info(dev, "init for RGMII_ID\n");
		if (bsp_priv->ops->set_to_rgmii)
			bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
		break;
	case PHY_INTERFACE_MODE_RGMII_RXID:
		dev_info(dev, "init for RGMII_RXID\n");
		if (bsp_priv->ops->set_to_rgmii)
			bsp_priv->ops->set_to_rgmii(bsp_priv,
						    bsp_priv->tx_delay, 0);
		break;
	case PHY_INTERFACE_MODE_RGMII_TXID:
		dev_info(dev, "init for RGMII_TXID\n");
		if (bsp_priv->ops->set_to_rgmii)
			bsp_priv->ops->set_to_rgmii(bsp_priv,
						    0, bsp_priv->rx_delay);
		break;
	case PHY_INTERFACE_MODE_RMII:
		dev_info(dev, "init for RMII\n");
		if (bsp_priv->ops->set_to_rmii)
			bsp_priv->ops->set_to_rmii(bsp_priv);
		break;
	default:
		dev_err(dev, "NO interface defined!\n");
	}

I don't think dwmac-rk.c does any fixup for phy_interface, so the MAC
driver always connects the PHY with unmodified phy-mode.

ethernet-controller.yaml states,

> # Device Tree describes hardware, and in this case, it describes the
> # PCB between the MAC and the PHY, if the PCB implements delays or
> # not.

So let's assume this is true for Rockchip's DWMAC glue, then the
driver's behavior could be summarized as,

phy-mode	PCB delay	Rockchip MAC delay	PHY delay[1]
rgmii		TX & RX		TX & RX			TX & RX
rgmii-id	None		None			TX & RX
rgmii-rxid	TX		TX			RX
rgmii-txid	RX		RX			TX
[1]: if available

where only the "rgmii-id" case makes sense. Other cases come with 2ns
delays added more than once, and would cause broken link.

It looks like dwmac-rk.c considers "phy-mode" to represent MAC's delay
configuration. If so, the table would look like,

phy-mode	PCB delay	Rockchip MAC delay	PHY delay[1]
rgmii		N/A		TX & RX			None
rgmii-id	N/A		None			TX & RX
rgmii-txid	N/A		TX			RX
rgmii-rxid	N/A		RX			TX

all cases have the necessary 2ns delay provided for both TX and RX
signals, however on-PCB delays made by traces couldn't be described
at all. This idea is also proved by comments in Rockchip devicetrees,
for example, rk3576-roc-pc.dts,

	&gmac0 {
		...
		/* Use rgmii-rxid mode to disable rx delay inside Soc */
		phy-mode = "rgmii-rxid";
	};

It seems for Rockchip DWMAC driver, "phy-mode" doesn't follow the
generic definition. Should we annotate in rockchip-dwmac.yaml to mention
the different usage of the property, or update both the driver and
devicetrees to align with ethernet-controller.yaml? The later would
break compatibility with existing devicetrees since there are already 15
instances of "rgmii-rxid" found in arch/arm64/boot/dts/rockchip, but
luckily most boards make use of "rgmii-id".

I only did a brief search in lore but find no related discussion, please
point out if there has already been messages around it, thanks.

Best regards,
Yao Zi

