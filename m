Return-Path: <netdev+bounces-121763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F495E698
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 04:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224741F212E2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810C4C96;
	Mon, 26 Aug 2024 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j6K1YGVw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF4635;
	Mon, 26 Aug 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637918; cv=none; b=VYnI+5h2wHsgkunAmqKET3qN2N8vM5JTHawjm6aYv64/A8kw1Ki0pRHW1T4VUWHjEn16xdMxoen5CQzRvs8LR6wcbLgD+tYbg2m2W5ynoLsKtSebixe2Wa+Cjkg0tD7H4Sy4ON4Iu4xEb9Zv5zKIKkHAnWBFRkHU5AcxyPkSw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637918; c=relaxed/simple;
	bh=Iey7yeyaQj6ptLm1QBQDpUccEkDyLTrwDNyhGPSYuLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAibXUvsEcyrHQ3QDPyAR/DMgvxZj/xhQz8fUNvN8CRritkJ2EUC+A0jsBVdYH8guTzOd4ZnmkbkQ4SvUgzIGURtV97rVRj8ft9ASJHoi8WD3Szn2wyCFcUxfZV/RXiC6JYl4x++HLRf3nd1gMZtbifpbzoJHxsfqTPfvZEHW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j6K1YGVw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Ca4XiGR4v9kBA7uHWFe3RMvWHjyE3MOAhmgNisyXYA=; b=j6K1YGVwi115YD2Ehup1tkFvcC
	L1bTK8dlQJv0Uq5JkFYJKuM55OirrcfFPuzdBjzW29Y7oItd817d+rWKW54hqG7U+hH+DmX2dDbaE
	qXfNDiQqpXP4FHxEZPuaWBs2YSpaz2M5DDhPJ0re2jTF6FYbiJdvQUsp5KhL9r+x6Ycg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siP6S-005fK0-Mg; Mon, 26 Aug 2024 04:05:08 +0200
Date: Mon, 26 Aug 2024 04:05:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v3 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Message-ID: <b64f3ec3-4497-4185-bea2-fdcb5f3f9403@lunn.ch>
References: <20240822114701.61967-1-Frank.Sae@motor-comm.com>
 <20240822114701.61967-3-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822114701.61967-3-Frank.Sae@motor-comm.com>

> +	ret = ytphy_modify_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG, mask,
> +			       set);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}

> +
> +	ret = ytphy_modify_ext(phydev,
> +			       YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG,
> +			       mask, set);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}

> +	ret = ytphy_modify_ext(phydev,
> +			       YT8521_EXTREG_SLEEP_CONTROL1_REG,
> +			       YT8521_ESC1R_SLEEP_SW,
> +			       enable ? 1 : 0);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}

Please could you remove all these pointless goto err_restore_page;

	Andrew

