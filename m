Return-Path: <netdev+bounces-17435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE888751938
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5619A281C0C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD4568C;
	Thu, 13 Jul 2023 07:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523747FC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:00:27 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F792118
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4a+XIF4K1JX+wrzTYu1QFMwWwu5xV/qXJuW25VLGPXY=; b=S7ilTLD0YI/XIgikSuO0gLr0VQ
	Y4yUd4vvmNRObHCVNSLt7H+Nz6/nwfc9WMGTg5iI98Po2LKz9xGt5CnodR7VhqGQDLtG/DS777h6C
	pWfJzzUIn6dUxTjdjrX9iB6jdC7gyXJDiSQszcAxjYs+nGl4yAVdrb/0GifsFKjr5vpqlHN4grPZH
	8T/qCnu4ZQNJpjxm3B2jLTF1QzaPCvEmgX310wj9/CMe6FX7cxZWEed6XAxoFtFJX+mmoZnW6pYQM
	f/os4q1tyXEC/sAtrBZgjhiHUdZAtDQhmR8qzt4RlM16dW4an9i5CXgPqhX9Zf9H5iFd43s6dPsYv
	ninakwXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35604)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJqJL-0005nn-1h;
	Thu, 13 Jul 2023 08:00:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJqJK-0005ud-N2; Thu, 13 Jul 2023 08:00:22 +0100
Date: Thu, 13 Jul 2023 08:00:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZK+hBhMCAxLb7RgV@shell.armlinux.org.uk>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-5-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710205900.52894-5-eichest@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:59:00PM +0200, Stefan Eichenberger wrote:
> +	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
> +	 * therefore we need to read the link status from the vendor specific
> +	 * registers.
> +	 */
> +	if (phydev->speed == SPEED_1000) {
> +		/* Read twice to clear the latched status */
> +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);

Please address my comment on this from v1, sent today.

(Sorry it's late, but I've been on vacation since the start of July...
which has now been disrupted. Presently "stuck" out on the English
canals in beautiful countryside due to a lock failure, waiting for it
to be repaired! :D Then I'll be taking the remainder of the vacation
because I'll again be moving the boat!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

