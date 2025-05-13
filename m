Return-Path: <netdev+bounces-190230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA9AB5C98
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5141B607B4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A12BF98D;
	Tue, 13 May 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJ6nDT00"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F047DA95
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161902; cv=none; b=a7puDHFBf0hzE4rFjNc2Hpz7Pa8pxDp2LpktHAjFbsCvkZDi5EUTfgSOwE5MIwJJnT9UUNXHS62u0bYzpmQTNpkRka/3fjXGl6VtVG+GVPR4Bh1lGZx2rmAdXDUGAKZaiHRmZ2FXHFZaK3chdw2Zq6QenS0dkJSvpLDCfxkb05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161902; c=relaxed/simple;
	bh=WGMe5h5gpDaOx6b4s7hIfYdfZRqiF+ZmTxyxQHN1eUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+/EEicK5t4oNdWH3EEsjPdrajygzEyXrj/ArZK2jujyXwEPuluXottClxjJOGDpYaAS+q29011aimKBRQuIBWApUVCI2fbBVWfi5jR18PXBKqzQU9nOC1WYn7PyKn17LexMehjAkkg5OTTQ7JYNoUXrFkl7BC0WMbo7WFHYDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJ6nDT00; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb2a379e-c701-4b50-932a-20dcfbb0ebea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747161888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v02MlTjPuKP4Y2/Qe6D/comJgBivOdHhNOC4o8MeDjc=;
	b=vJ6nDT005BmhxrNYGRvgIO27rdBpIdn0ygjz1B3IGq9kYoPpRsGiZ3iVRFkTdKnew/D7s8
	1V3JyVzOhj77HQPocNG+eJ6pyuGYyGTQTqkojHPO1hGqkRtik13SSX2567/RPy+PoULIJ5
	ENGe3Fe1y2vg27H+ZLguzuobLSOW51k=
Date: Tue, 13 May 2025 14:44:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 08/11] net: phylink: add .pcs_link_down PCS OP
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-9-ansuelsmth@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250511201250.3789083-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/11/25 16:12, Christian Marangi wrote:
> Permit for PCS driver to define specific operation to torn down the link
> between the MAC and the PCS.
> 
> This might be needed for some PCS that reset counter

Counters must be preserved across link u/down.

> or require special
> reset to correctly work if the link needs to be restored later.

Can you describe this in more detail?

> On phylink_link_down() call, the additional phylink_pcs_link_down() will
> be called before .mac_link_down to torn down the link.

tear

> PCS driver will need to define .pcs_link_down to make use of this.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phylink.c | 8 ++++++++
>  include/linux/phylink.h   | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 1a4df0d24aa2..39cd15e30598 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1009,6 +1009,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
>  }
>  
> +static void phylink_pcs_link_down(struct phylink_pcs *pcs)
> +{
> +	if (pcs && pcs->ops->pcs_link_down)
> +		pcs->ops->pcs_link_down(pcs);
> +}
> +
>  static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
>  {
>  	if (pcs && pcs->ops->pcs_disable_eee)
> @@ -1686,6 +1692,8 @@ static void phylink_link_down(struct phylink *pl)
>  
>  	phylink_deactivate_lpi(pl);
>  
> +	phylink_pcs_link_down(pl->pcs);
> +
>  	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
>  				   pl->cur_interface);
>  	phylink_info(pl, "Link is Down\n");
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index c5496c063b6a..8b3d1dfb83a1 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -494,6 +494,7 @@ struct phylink_pcs {
>   * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
>   * @pcs_link_up: program the PCS for the resolved link configuration
>   *               (where necessary).
> + * @pcs_link_down: torn down link between MAC and PCS.

ops documentation should use imperative verbs.

You are also missing the longer documentation below.

>   * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
>   *		     at the MAC.
>   * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
> @@ -521,6 +522,7 @@ struct phylink_pcs_ops {
>  	void (*pcs_an_restart)(struct phylink_pcs *pcs);
>  	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
>  			    phy_interface_t interface, int speed, int duplex);
> +	void (*pcs_link_down)(struct phylink_pcs *pcs);
>  	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
>  	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
>  	int (*pcs_pre_init)(struct phylink_pcs *pcs);


