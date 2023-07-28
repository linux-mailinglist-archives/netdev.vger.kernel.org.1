Return-Path: <netdev+bounces-22242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C164B766AD7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BF328272C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4807710795;
	Fri, 28 Jul 2023 10:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B77D304
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:37:52 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E5365AC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qvq2RX6u6WvLzV3gssA3ABKKEpbpLQK5MeiPtS4IUuo=; b=dHWe/v5xB4e83FmxSdTeu3RmNA
	VxS1O6WjjJGS7zi5yFv8kIFfSk2lZAp514N+hcJaTjpDp0VTqxpNKIoFUAuGQqVNhzf+np7mVJ8dJ
	HICo3BWWXyVQv2qjVZyXTv0aahWkn+BtATa+W2YVZh7gwrN7O2yrRuKxrv4zXocarzv0BdZkUHdA2
	lX1CTi3tx2jJpD7u5sE9BW6YGXcfRBntcW2XHg5lYXBFAX7FzG3LHblZqqtJjsUI9sSTGdxwbOuCz
	HKPwkBTIwhXMRW0V3Wd/SAza2D2dQ/L1hUYGfL65GHeBwaJvt68iJi69nDH3PABMk3euoOyo+Atsv
	retfs4Lg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40614)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qPKqd-00077v-1M;
	Fri, 28 Jul 2023 11:37:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qPKqb-0004qF-C3; Fri, 28 Jul 2023 11:37:25 +0100
Date: Fri, 28 Jul 2023 11:37:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink -
 manual merge
Message-ID: <ZMOaZdDVkN4bq66C@shell.armlinux.org.uk>
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
 <5d240ea8-3fd9-5e43-1bcf-2923bfddee72@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d240ea8-3fd9-5e43-1bcf-2923bfddee72@tessares.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 12:23:25PM +0200, Matthieu Baerts wrote:
> Hi Russell,
> 
> On 26/07/2023 16:45, Russell King (Oracle) wrote:
> > Older DSA drivers that do not provide an dsa_ops adjust_link method end
> > up using phylink. Unfortunately, a recent phylink change that requires
> > its supported_interfaces bitmap to be filled breaks these drivers
> > because the bitmap remains empty.
> > 
> > Rather than fixing each driver individually, fix it in the core code so
> > we have a sensible set of defaults.
> > 
> > Reported-by: Sergei Antonov <saproj@gmail.com>
> > Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
> 
>   9945c1fb03a3 ("net: dsa: fix older DSA drivers using phylink")
> 
> and this one from 'net-next':
> 
>   a88dd7538461 ("net: dsa: remove legacy_pre_march2020 detection")

It was unavoidable.

> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.

Given that this is a trivial context-based conflict, it wasn't worth it.
If it was a conflict that actually involved two changes touching the
same lines of code, then yes, that would be sensible.

Note that I don't get these messages from the netdev maintainers when
they update net-next (as they did last night.)

>   
> - 	if (ds->ops->phylink_get_caps)
>  -	/* Presence of phylink_mac_link_state or phylink_mac_an_restart is
>  -	 * an indicator of a legacy phylink driver.
>  -	 */
>  -	if (ds->ops->phylink_mac_link_state ||
>  -	    ds->ops->phylink_mac_an_restart)
>  -		dp->pl_config.legacy_pre_march2020 = true;
>  -
> + 	if (ds->ops->phylink_get_caps) {
>   		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
> + 	} else {
> + 		/* For legacy drivers */
> + 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> + 			  dp->pl_config.supported_interfaces);
> + 		__set_bit(PHY_INTERFACE_MODE_GMII,
> + 			  dp->pl_config.supported_interfaces);
> + 	}

Of course, being a purely context-based conflict, that is correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

