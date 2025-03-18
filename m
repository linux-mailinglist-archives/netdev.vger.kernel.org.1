Return-Path: <netdev+bounces-175742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2ABA6759A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057373BBB06
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520520D4F2;
	Tue, 18 Mar 2025 13:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77871527B4;
	Tue, 18 Mar 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305986; cv=none; b=c+hg3vBrhNOlkp/gHhFXYM0CjcvItOXm+GEfUtOAzDH6STserxtkvbyIxjI7fvtsmLKZ4YMPr3pZlVz5x8WF99JTuG2lLocM1dOflDYzoDgGrmsamm9pllZ3fxk4Pof9WGLVDPKDzI8ynRwkF3PPe4wuRMNKLFnQe7s6yPEKYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305986; c=relaxed/simple;
	bh=l3JKXpTCpEGuWJTOUW3X+jpij2L89IKZhk2R0bF8KXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIIXl4t4Rls+liysZrwQoQ+cXo2RQLrmJi0LxNjNGxXJ28VlNQZfGSxPLfLiofgE+y5K7CY7Qv/7LdJ1rI25geGRBfxrpIJVjjohbW0apknIRLth32unmPfSHD5B1AXuWu9wYq9CaZysVvdXQyaXKbEwcK2gVrC/0ie9FLsP1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tuXNJ-000000003ch-2uom;
	Tue, 18 Mar 2025 13:52:57 +0000
Date: Tue, 18 Mar 2025 13:52:45 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: linux-clk@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com, wenshin.chung@airoha.com,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v5 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <Z9l6rWJkE2ALmfzM@makrotopia.org>
References: <20250318133105.28801-1-lucienX123@gmail.com>
 <20250318133105.28801-2-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318133105.28801-2-lucienX123@gmail.com>

On Tue, Mar 18, 2025 at 09:31:05PM +0800, Lucien.Jheng wrote:
> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
> CKO clock operates continuously from power-up through md32 loading.
> Implement clk provider driver so we can disable the clock output in case
> it isn't needed, which also helps to reduce EMF noise
> 
> Signed-off-by: Lucien.Jheng <lucienX123@gmail.com>

White-space (tabs vs. spaces) could still be improved. See inline below.
However, I don't think it's worth another iteration just for that, so
only should there be comments from other reviewers and you anyway send
another version, then you can fix that as well.

Other than that:
Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index e9fd24cb7270..47ace7fac1d3 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -16,6 +16,7 @@
>  #include <linux/property.h>
>  #include <linux/wordpart.h>
>  #include <linux/unaligned.h>
> +#include <linux/clk-provider.h>
>  
>  #define EN8811H_PHY_ID		0x03a2a411
>  
> @@ -112,6 +113,11 @@
>  #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
>  #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
>  
> +#define EN8811H_CLK_CGM     0xcf958
> +#define EN8811H_CLK_CGM_CKO     BIT(26)
> +#define EN8811H_HWTRAP1     0xcf914
> +#define EN8811H_HWTRAP1_CKO     BIT(12)
> +

Existing precompiler macro definitions use tab characters between the
macro name and the assigned value, your newly added ones use spaces.

>  #define EN8811H_GPIO_OUTPUT		0xcf8b8
>  #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
>  
> @@ -142,10 +148,15 @@ struct led {
>  	unsigned long state;
>  };
>  
> +#define clk_hw_to_en8811h_priv(_hw)			\
> +	container_of(_hw, struct en8811h_priv, hw)
> +
>  struct en8811h_priv {
>  	u32		firmware_version;
>  	bool		mcu_needs_restart;
>  	struct led	led[EN8811H_LED_COUNT];
> +	struct clk_hw        hw;
> +	struct phy_device *phydev;

The existing struct members are indented with tabs, your newly added
members use spaces. Not a big deal, but it'd be better to use the same
style.

