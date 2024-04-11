Return-Path: <netdev+bounces-86886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C898A09AE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C7E1C21A85
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5013E8AB;
	Thu, 11 Apr 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XW1MO6zJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6A13E04A
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820333; cv=none; b=MM1RkQVtu1sxeRf3iJ5itCh+OdRkerE8h7fVrTOlUCHyphKULXw3IxS4sk41ajA8slx0l+8v/hfH4GRs0YmMgk4AzKdTu6M3w+5jxzfQtZ+353RwKqqaVi54dax6f+NB3Am86AFHpuzp8ovVxNCizbkXeYF5L2jZb6+6a+I281M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820333; c=relaxed/simple;
	bh=ADi7AIJR4AKcuBOk6kdeYdOkglNNdFD7S4RXiaOzzMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kQGCp4PP+yazd3ideIIAJoTTs7yh23VkLw/N8iQv9MAmvj5ZZLngM+t8VcieZBxM/mgeM1BmupjQZqQWQOOLrorXXLUDcdY6FSb9Phr9u8yCUdljtj37p787AdNOoZmP+I3KwWuh6QovZzuKvu7gXY+KcH7v4MKQIhkeUoqLGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XW1MO6zJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 327761C000A;
	Thu, 11 Apr 2024 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712820328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdzc9AsfgZ9Ovhl+3KsoJesmE9lkARyzNmBu+Gx88PY=;
	b=XW1MO6zJgx/cbAvJgjb0cN2A5LEDW9HHdhT2pc+nzAnxBOFwSP3bUJsdh+F9/bmzkn+Drs
	98nEsSkM6v/ocTDW0nMXrPfVsJdxa6XLzpWSyox8lQDrD3sZ3pByXXjJXOlw9bEky/HkXz
	SiCNscmq+hKwJ2G4LCqeCJvSBXuw4baDFTE6kUbg0xBSdVrxx8yR6keam6Ced4ARAST1bx
	VBpe2N5FPlJSffAnwJhBF3JQZIxfGGTmziQKPr+e2/NZe3kBnvQMY8k46O0lpFwh3heYzt
	qQ+W2bFuOu2DhmIn7k2MF+UvR1aUa7g2DwVp+ulYByEww6PR6CAB4YulHpqb6Q==
Date: Thu, 11 Apr 2024 09:26:04 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Yanteng Si <siyanteng@loongson.cn>
cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
    alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
    fancer.lancer@gmail.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, 
    linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
    chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v9 1/6] net: stmmac: Add multi-channel support
In-Reply-To: <e293a30532ef3e567e6236f6b643430036ea7e09.1712407009.git.siyanteng@loongson.cn>
Message-ID: <6fd50d0f-862f-5aa1-700c-a2a4fe01854f@bootlin.com>
References: <cover.1712407009.git.siyanteng@loongson.cn> <e293a30532ef3e567e6236f6b643430036ea7e09.1712407009.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Yanteng,

On Sat, 6 Apr 2024, Yanteng Si wrote:

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index e1537a57815f..e94faa72f30e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  		return 0;
>  	}
>  
> +	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
> +		if (cmd->base.speed == SPEED_1000 &&
> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> +			return -EOPNOTSUPP;
> +	}
> +
>  	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }

This doesn't seem like it belongs with the rest of the changes in this patch. 
Maybe you could move it to a separate patch?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

