Return-Path: <netdev+bounces-180332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83AA80FC6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9402E17AF02
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84A22ACE3;
	Tue,  8 Apr 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i77/t7ZE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961C22A4D6;
	Tue,  8 Apr 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125544; cv=none; b=jn3X+HXsKYKj50oairkaBU/S7iIK9Iq/0p7UYrCEbm/uaqwZRP/6j+a9csLWjGnrOt2H1PXjGoceZ/q67hX3SwQmWtzioOZJXBB2jZJZXavxHlELdau8GTQ6v+MeQuCztNTMTRmZWinxRcG2f/g16flJ/6ZFAGrjOQqNnpgSydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125544; c=relaxed/simple;
	bh=muzGjO6WVJ7RFBCN3eTmJV8m55muVdlhk1Ebh/yVj5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4OScmpF3GJ3cOQS+H9kLZpP1XTe4PvlH3qpnWsMM2IAJJ6Ok7hcnHoW+IcG0hsTztVHZHJNqzLTnty0o9GVOEnp+9GMyv/9azzFfMo+yiq70+1+w7a681/2ozKxR7TewmOUqCM0YZ10ui6IiaP/BWyuo+Qr0lkrvqbECzwgh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i77/t7ZE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+vt9+VZDiPwgZiCaktIzImIK5YgSg2O6izIQtC6HzeY=; b=i77/t7ZEtZtab+fE0SvLKoYiBY
	cIQe0n5eHBmEaS+eBHGSsieAtJVc06yqZqGXOdZrroshp0+D+GdK+mY2/v+0gFTxj/dcakyj/Q9zn
	CgTxXoWUnXUT1Tg+IXwpvi1V/lQdArGz4S09lXqjtQrn3sFMZxfg/duxsdgdrLJvhl20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2Ais-008PgN-Vu; Tue, 08 Apr 2025 17:18:46 +0200
Date: Tue, 8 Apr 2025 17:18:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: linux-clk@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@makrotopia.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com, wenshin.chung@airoha.com,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v7 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <29710c4e-b106-4922-8278-c19159c16756@lunn.ch>
References: <20250408150118.54478-1-lucienx123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408150118.54478-1-lucienx123@gmail.com>

On Tue, Apr 08, 2025 at 11:01:18PM +0800, Lucien.Jheng wrote:
> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
> CKO clock operates continuously from power-up through md32 loading.
> Implement clk provider driver so we can disable the clock output in case
> it isn't needed, which also helps to reduce EMF noise
> 
> Signed-off-by: Lucien.Jheng <lucienx123@gmail.com>
>  #include <linux/property.h>
>  #include <linux/wordpart.h>
>  #include <linux/unaligned.h>
> +#include <linux/clk-provider.h>

We try to keep thinks sorted in order. The includes are not quite
correct, but still clk-provider.h should be first.

>  #define EN8811H_PHY_ID		0x03a2a411
> 
> @@ -112,6 +113,11 @@
>  #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
>  #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
> 
> +#define EN8811H_CLK_CGM		0xcf958
> +#define   EN8811H_CLK_CGM_CKO		BIT(26)
> +#define EN8811H_HWTRAP1		0xcf914
> +#define   EN8811H_HWTRAP1_CKO		BIT(12)
> +
>  #define EN8811H_GPIO_OUTPUT		0xcf8b8
>  #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))

and registers should be in order, so 0xcf958 goes after 0xcf8b8.

> +static int en8811h_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +	int ret;
> +	u32 pbus_value;

Reverse Christmas tree please. Sort them longest to shortest.

	Andrew

