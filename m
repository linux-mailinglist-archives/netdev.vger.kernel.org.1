Return-Path: <netdev+bounces-25896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B7776198
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3441D1C20A35
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397318C34;
	Wed,  9 Aug 2023 13:48:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD03182BE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:48:44 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F991986
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v6ingy5n03LTh9JgTGE0t3F+3HPp1JrDHgv9OMxMzUQ=; b=o5+Y5Zv/x4aD4QsrhXbYXuy4DN
	/EmzNMKKyvhD7pRfu4lZGgBuEoK0c/xtXc7IYgsYCoCHZk/sZa5FJW+dbE5MSUE1JX4VYNsqyYl34
	9CDOLAdLCrjX7liLrlH3fGOJgwFq3UpvC/clD3XHdlzYi5eV72PwAB3SLpSYbqqPmhKxLPK9xAslS
	nQB2HSLDl8KmsDBOKyPQay1plgtazd0uNsO/vXv2jjWbpe4oeEpySfJjwa0FJ5y+Fc0FB+nKaTxri
	VaMCN+xaxy8gN3Vb2WCt9RuCfWDiHoQu1JoEXP+wlSlBkd4W/cM42b7fdY2gB1Dgtufd2042U57IO
	8k2aCaRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41036)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTjYB-0002al-2H;
	Wed, 09 Aug 2023 14:48:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTjYA-0000mK-JD; Wed, 09 Aug 2023 14:48:34 +0100
Date: Wed, 9 Aug 2023 14:48:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <ZNOZMoipjmZJkJTd@shell.armlinux.org.uk>
References: <E1qTiMC-003FJP-V3@rmk-PC.armlinux.org.uk>
 <c3102ba1-61a1-4b03-837a-a77dcfff157b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3102ba1-61a1-4b03-837a-a77dcfff157b@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 03:45:29PM +0200, Andrew Lunn wrote:
> On Wed, Aug 09, 2023 at 01:32:08PM +0100, Russell King (Oracle) wrote:
> > Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> > This is a fast ethernet switch, with internal PHYs for ports 0 through
> > 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> > MII, REVMII, REVRMII and SNI without an internal PHY.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Looks sensible, and fits with the limited knowledge i have of this
> device.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks. I have to change the PTR_ERR to ERR_PTR - I often get those
the wrong way around. :/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

