Return-Path: <netdev+bounces-248580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18DD0BD8A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5F5301D5BA
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDB21D00A;
	Fri,  9 Jan 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="COcIW6ip"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EB1F5842;
	Fri,  9 Jan 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983482; cv=none; b=utF9SVrq0g2Xg+GMefEOFh1UflrE09+x1QpblVoTcNyM3yJBFUWDdiLi9nQQAxe2uqcJ72f6CY637Dg+JRLgUg+AvFUXqHpX+3ujUWJFC5v18A7/yeUZGXtr1OAmHrvxu9uFAP6WyVnRDDCn/bxglTQiUdqfJJ7+qRoINmDPl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983482; c=relaxed/simple;
	bh=XAAGKCd5MnY6NfG+WnqQP/TWOdF5dooFnJtvLTdRyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUjOAn70ZtLo0SPkUiC1+ZdcarhXGTffzQ5+22jbWYnrMPO5NIKX3GKxZJbF0cDG/ZANjYayEsEgwUL5Xt6SnnObcJoKrMX9n6dULSSgQc69LVUIGK2uSmp1J0v2ZYvwNzNf97T9WO8y3snclpfwY9RuNxHPercositpE9WYI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=COcIW6ip; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EwGYOeRaxC8r7KLQ5MPQHRQIWLWbUCt3JTk1jKiuCXI=; b=COcIW6ipe3pNW3FLUndl9lxole
	p8kA6IAipiGel0bGPkZFc3iT9DHRMCYDVlPe/BHwmOlsOZHjg3xxIW3w7TXTZou1tIeT2KcsH3x0V
	FnOnenbGbAWs4NA4n7Dq5nWHLvTRDKIjGvMGZRm65GhmpmKvcfr4F2WOsA+Eq5U6LJts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veHGP-0029bk-2U; Fri, 09 Jan 2026 19:31:09 +0100
Date: Fri, 9 Jan 2026 19:31:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v1 2/2] net: stmmac: eic7700: enable clocks before syscon
 access and correct RX sampling timing
Message-ID: <1f553a6e-ca95-45e2-be14-96557a35e618@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080929.1308-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109080929.1308-1-lizhi2@eswincomputing.com>

> +	dwc_priv->eic7700_hsp_regmap =
> +			syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +							"eswin,hsp-sp-csr");
> +	if (IS_ERR(dwc_priv->eic7700_hsp_regmap))
>  		return dev_err_probe(&pdev->dev,
> -				PTR_ERR(eic7700_hsp_regmap),
> +				PTR_ERR(dwc_priv->eic7700_hsp_regmap),
>  				"Failed to get hsp-sp-csr regmap\n");

In order to be backwards compatible, you cannot error out here,
because old DT blobs won't have this property.

	Andrew

