Return-Path: <netdev+bounces-20821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B8761527
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824B92810E9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE51ED46;
	Tue, 25 Jul 2023 11:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80A1ED38
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:26:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4B19F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RbJRV8Wf5saGhMX+P3VQMMs1ukU5TwjpBHioDN2UWdA=; b=akmC2Rz31mrSkTLeVUbzi+fzJK
	NHYkk9tPfP5DEu7ry0qHYv2JKDxkoyYdXeXPdc0EKXb/wybvIVCYu9JcDami0rgvUbYXhv8uStNRJ
	YY6f0j1CWbT+Cy2Zy1KcyCOo5p3Hk5opnoRjFoZ7Ugj+1BCzidEF46vKCib+V6bKnUgjUqnsD2Fr1
	jUKMX5g7xBGBQhILoDRNLZMZ45ldZx2ZPrsU1EC5kahy2peV25l/IYl30g9fxVX4qAIDawtP73XUI
	j/K3ihYiObT/PqXDaJqJeqSqMZEOSW6ED7uyme4nsCZaXv/eumHD3pellzNRy/DtIlyGnUeHJE3D3
	KA7pMIdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOGAy-0001yG-28;
	Tue, 25 Jul 2023 12:26:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOGAy-0001mu-D4; Tue, 25 Jul 2023 12:26:00 +0100
Date: Tue, 25 Jul 2023 12:26:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Vladimir Oltean <olteanv@gmail.com>, Sergei Antonov <saproj@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <ZL+xSJh4pJArnaLU@shell.armlinux.org.uk>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <ZLATb/obklRDT3KW@shell.armlinux.org.uk>
 <9e584314-cb54-1dd4-1686-572973777580@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e584314-cb54-1dd4-1686-572973777580@leemhuis.info>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 12:58:31PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> On 13.07.23 17:08, Russell King (Oracle) wrote:
> > On Mon, Jul 10, 2023 at 03:35:56PM +0300, Vladimir Oltean wrote:
> >> On Tue, Jul 04, 2023 at 05:28:47PM +0300, Sergei Antonov wrote:
> >>> This commit seems to break the mv88e6060 dsa driver:
> >>> de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
> >>> supported_interfaces to be filled"
> >>>
> >>> The driver does not fill 'supported_interfaces'. What is the proper
> >>> way to fix it? I managed to fix it by the following quick code.
> >>> Comments? Recommendations?
> >>
> >> Ok, it seems that commit de5c9bf40c45 ("net: phylink: require
> >> supported_interfaces to be filled") was based on a miscalculation.
> > 
> > Yes, it seems so. I'm not great with dealing with legacy stuff - which
> > is something I've stated time and time again when drivers fall behind
> > with phylink development. There's only so much that I can hold in my
> > head, and I can't runtime test the legacy stuff.
> > 
> > I suspect two other DSA drivers are also broken by this:
> > 
> > drivers/net/dsa/dsa_loop.c
> > drivers/net/dsa/realtek/rtl8366rb.c
> > 
> > based upon:
> > 
> > $ grep -lr dsa_switch_ops drivers/net/dsa | xargs grep -L '\.phylink_get_caps.*=' | xargs grep -L '\.adjust_link'
> 
> What happened to this regression? From here it looks like things
> stalled, but I might have missed something, hence allow me to ask:
> 
> Is this still happening? Is anyone still working on fixing this?

I think the discussion got side-tracked into whether mv88e6060 should
be merged into mv88e6xxx, and then just petered out with no further
patch(es) - plus I was on holiday so obviously wasn't paying much
attention.

I suppose the sane thing to do would be to fix all drivers in one
go - maybe something like this:

-	if (ds->ops->phylink_get_caps)
+	if (ds->ops->phylink_get_caps) {
 		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
+	} else {
+		/* For legacy drivers */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  &dp->pl_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  &dp->pl_config.supported_interfaces);
+	}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

