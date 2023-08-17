Return-Path: <netdev+bounces-28440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0977F758
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63316281F59
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6F1401D;
	Thu, 17 Aug 2023 13:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5B14005
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:11:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BBC35A1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5JBS5zda+QNvxuZGCGM0+RgefiwveEjkmZFLvztBmOs=; b=KFh5ioyXzvmrIGbDbCy/keGSKG
	AMX8Vc0DLLQqqr+5WgxGaWw65tblIGI5+32vAqsHg/3iEase8DxcWX9YqaQR1rnWLMgeX5pDFFmA1
	xd43+w6YB+AHVV6d1saZzRreXo8Y3WXLIrB9az7BJSADdiG/f+z+flR19rNGGCl0/Z4h6d+sDBtTe
	qEK/XsKPcDRwcQjxIOBwjZoqu5i7hpYKIgX6RAJbGVHaApZLrTcQr9jdgDRTLQWEhauN3rNQTMEMV
	fPre8CuP/e8cSj1xoezoSDAxLIYCwJy/NjtvfMOJlAcpPK0c/fISd2+Vw16EpDsqAmLq5bKVfANvT
	vzUNQMjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qWclQ-0004Ct-1N;
	Thu, 17 Aug 2023 14:10:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qWclP-0000dC-2v; Thu, 17 Aug 2023 14:10:11 +0100
Date: Thu, 17 Aug 2023 14:10:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bryan.whitehead@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
	mdf@kernel.org, pgynther@google.com,
	Pavithra.Sathyanarayanan@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: phy: fixed_phy: Fix return value
 check for fixed_phy_get_gpiod
Message-ID: <ZN4cM+EvXUtTqNwH@shell.armlinux.org.uk>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817121631.1878897-2-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 08:16:28PM +0800, Ruan Jinjie wrote:
> Since fixed_phy_get_gpiod() return NULL instead of ERR_PTR(),
> if it fails, the IS_ERR() can never return the error. So check NULL
> and return ERR_PTR(-EINVAL) if fails.

No, this is totally and utterly wrong, and this patch introduces a new
bug. The original code is _correct_.

> Fixes: 71bd106d2567 ("net: fixed-phy: Add fixed_phy_register_with_gpiod() API")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/phy/fixed_phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index aef739c20ac4..4e7406455b6e 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -239,8 +239,8 @@ static struct phy_device *__fixed_phy_register(unsigned int irq,
>  	/* Check if we have a GPIO associated with this fixed phy */
>  	if (!gpiod) {
>  		gpiod = fixed_phy_get_gpiod(np);
> -		if (IS_ERR(gpiod))
> -			return ERR_CAST(gpiod);
> +		if (!gpiod)
> +			return ERR_PTR(-EINVAL);

Let's look at fixed_phy_get_gpiod():

        gpiod = fwnode_gpiod_get_index(of_fwnode_handle(fixed_link_node),
                                       "link", 0, GPIOD_IN, "mdio");
        if (IS_ERR(gpiod) && PTR_ERR(gpiod) != -EPROBE_DEFER) {
...
		gpiod = NULL;
	}
...
	return gpiod;

If fwnode_gpiod_get_index() returns -EPROBE_DEFER, _then_ we return an
error pointer. So it _does_ return an error pointer.

It also returns NULL when there is no device node passed to it, or
if there is no fixed-link specifier, or there is some other error
from fwnode_gpiod_get_index().

Otherwise, it returns a valid pointer to a gpio descriptor.

The gpio is optional. The device node is optional. When
fixed_phy_get_gpiod() returns NULL, it is _not_ an error, it means
that we don't have a GPIO. Just because something returns NULL does
_not_ mean it's an error - please get out of that thinking, because
if you don't your patches will introduce lots of new bugs.

Only when fwnode_gpiod_get_index() wants to defer probe do we return
an error.

So, sorry but NAK to this patch, it is incorrect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

