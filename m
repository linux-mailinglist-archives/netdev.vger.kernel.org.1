Return-Path: <netdev+bounces-252403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMUxCglAcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:19:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905886896B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B661530027C3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760F36AB53;
	Thu, 22 Jan 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="o+IZLkUH"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D7346A04;
	Thu, 22 Jan 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094809; cv=pass; b=FYelQl5AKyanm08zgd4ipCbLJg9kP8PnuwJfbwVGtHjgAnqHKot59PmIZJU7TBB1fvIc1lcLxNypmSGEMvXgcRozDnU16zXVmpViVUpto4UmvdV14t6ue7wCm0I1/ucNJvioz91K3lO0aMvofZ+uvb3LX4X+Wk9QDaVuIIQ+HsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094809; c=relaxed/simple;
	bh=lqw9kCO+PlKCQmoZym5Am+vYG9C8G+3knV/qvRKbq88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpMw0IycCoOD6pWzcIiioJraIMeJUnbExpzcoZRmBJ8ar16ua8vPmvsT4Vy44VO36jJYHr//k6PbKy2Tc6SbN00wSW5KKLqKkn5xkXWsHMuKVgyFYWbz4JMg/rd97sLU8Bg35YhN+e9FCmGv3uB/LJFz1L0q8RPQ54XGNo8om+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=o+IZLkUH; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769094778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lEoIOIMYjotqF6pMogdQeeX3MKr4ENlCiD/zwjVHEz7oX/aBkcYEGsE/b+AyEz9/qHammd5PwkwUTjHgxSm4xUXMdfvKKymDrKfMO7XVkqxZwi0eFOFpycTX3Ph2VfjoBn2jh/PONyeioR4e3509GRDmI2FA+Je/43/yldSCFMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769094778; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Eo/IUXScxtTqfsnFKhZ0cMjvhBNV94SAmIf3IWc0PYg=; 
	b=AZzM73oOqgb/shBUa24qmbpxOMWgTlo1reLo+3afbd9Xl7CJMIRkBrYmPkdk2CdcDFwLdwbYH74ZtI+L0KF7ytTXDaUDxoTHzgoOcZUfzYExAF5bEEHSigbE2A63ghwesaif6vIXyb2O824EsoihePPHqysB3lNJrcO/mtWQ/qs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769094778;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Eo/IUXScxtTqfsnFKhZ0cMjvhBNV94SAmIf3IWc0PYg=;
	b=o+IZLkUHaUjCBLwjbbYzPaDnbsyf4n4RhgWAG2Yid5tjpLPXo8AzAvbFBQ/tDCoQ
	bpWF7sPLiJvteO0izmqf5tShsN/HlmNc/nFEa9bui9aQ2xILgsJQCEHu/zBdQxeznix
	ZOv63McBSVkhandjj20A1es/cJW+yfpOD64EoQ+4=
Received: by mx.zohomail.com with SMTPS id 1769094776105810.6311707654235;
	Thu, 22 Jan 2026 07:12:56 -0800 (PST)
Date: Thu, 22 Jan 2026 15:12:36 +0000
From: Yao Zi <me@ziyao.cc>
To: Chukun Pan <amadeus@jmu.edu.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
	Yixun Lan <dlan@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: spacemit: display phy driver information
Message-ID: <aXI-ZMbwXHBX4XiT@pie>
References: <20260122080001.73921-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122080001.73921-1-amadeus@jmu.edu.cn>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252403-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziyao.cc:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jmu.edu.cn:email]
X-Rspamd-Queue-Id: 905886896B
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 04:00:01PM +0800, Chukun Pan wrote:
> Print the PHY driver used and interrupt status after connection.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index c85dc742c404..afb5b6a61c2c 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -1568,6 +1568,7 @@ static int emac_phy_connect(struct net_device *ndev)
>  	struct device *dev = &priv->pdev->dev;
>  	struct phy_device *phydev;
>  	struct device_node *np;
> +	char *irq_str;
>  	int ret;
>  
>  	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
> @@ -1610,6 +1611,11 @@ static int emac_phy_connect(struct net_device *ndev)
>  		goto err_node_put;
>  	}
>  
> +	irq_str = phy_attached_info_irq(phydev);
> +	netdev_info(ndev, "PHY driver [%s] (irq=%s)\n",
> +		    phydev->drv->name, irq_str);
> +	kfree(irq_str);

Would phy_attached_print() simplify the code?

Regards,
Yao Zi

