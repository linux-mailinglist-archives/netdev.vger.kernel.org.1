Return-Path: <netdev+bounces-25527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD111774721
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C971C20430
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCB15ADC;
	Tue,  8 Aug 2023 19:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0B1802F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:29 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399F15C7E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hli3rFTfKAz+ImzEL5wW+OG4wZcmBU9SMiIfdHQMLOk=; b=cvOx2yXAbNAxDf4d086UadYFBS
	m1JGgziLIQssk3XoyL+/w0Zq1xzGDmkgAIDHXLmFKMo43D3/YTFeE9W0STnHCM4W4k4XAkrKpIabf
	O5l35IIP1ctYn8cItL2HTDxB2Eq97LnMJ/w+g83Ei9gRUT+iUTxxNOX5uj5eHcQlLNXFndOB5qAcF
	DcQqYdtS4GG3UY/kMrBvNAa1ir0ljrC8+nkFbs5K1s3piJRQJwMY3BBueddRml0FoD9AGUhpKvJqn
	WfDE6+lfqDiYbYdLk7D8kQ335Y6nlblEE1bzYmAem+WNMdYbtR8SPSDvh1W3tQnOtPRRoIhCRe1pp
	FODfQ3qA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTHxq-0006jE-36;
	Tue, 08 Aug 2023 09:21:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTHxi-0007uo-Ig; Tue, 08 Aug 2023 09:21:06 +0100
Date: Tue, 8 Aug 2023 09:21:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	hkallweit1@gmail.com, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 3/7] net: pcs: xpcs: add 1000BASE-X AN
 interrupt support
Message-ID: <ZNH68qtZvaXp5c5j@shell.armlinux.org.uk>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
 <20230808021708.196160-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808021708.196160-4-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 10:17:04AM +0800, Jiawen Wu wrote:
> Enable CL37 AN complete interrupt for DW XPCS. It requires to clear the
> bit(0) [CL37_ANCMPLT_INTR] of VR_MII_AN_INTR_STS after AN completed.
> 
> And there is a quirk for Wangxun devices to enable CL37 AN in backplane
> configurations because of the special hardware design.

Where is the interrupt handler?

> @@ -759,6 +762,8 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
>  		return ret;
>  
>  	ret &= ~DW_VR_MII_PCS_MODE_MASK;
> +	if (!xpcs->pcs.poll)
> +		ret |= DW_VR_MII_AN_INTR_EN;

Does this interrupt only work in 1000baseX mode?

>  	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
>  	if (ret < 0)
>  		return ret;
> @@ -1012,6 +1017,17 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
>  		if (bmsr < 0)
>  			return bmsr;
>  
> +		/* Clear AN complete interrupt */
> +		if (!xpcs->pcs.poll) {
> +			int an_intr;
> +
> +			an_intr = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
> +			if (an_intr & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
> +				an_intr &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
> +				xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, an_intr);
> +			}
> +		}
> +

get_state isn't supposed to be used as a way to acknowledge interrupts,
because that will get called quite a bit later after the interrupt has
been received.

As an example of PCS that use interrupts, please see the converted
mv88e6xxx PCS, for example:

 drivers/net/dsa/mv88e6xxx/pcs-6352.c

If the interrupt handler for the PCS is threaded, then it can access
the DW_VR_MII_AN_INTR_STS register to acknowledge the interrupt and
call phylink_pcs_change() or phylink_mac_change().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

