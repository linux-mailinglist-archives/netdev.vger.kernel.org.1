Return-Path: <netdev+bounces-17874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EEC7535B3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22E928215E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3F79C0;
	Fri, 14 Jul 2023 08:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF04A14
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:52:33 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927012683
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YdUm2T9XfnFj/uq0gYO35yBpS6Gaw+TGvwhJai5G2ek=; b=qbGnwdfvp+RYjGKHeq4wwDaoyK
	A3LGH4xbkhZxTtS+GwK6tXqacPKJGkj+HvIKQPNyBZqhUp2uSy9nJOf4wG4j4RTEpVGrKwWzkNy11
	euokT9iaByt4/cA1m95YsP8JrB8v4tyNiBVr/8qvfSzg+iYhSPDR5cpyr8AAys9tVbXRljD8y6Yxu
	zJh+ItY8yp5b/EstcW+75gF2CUlZJYDzKwmdrXEkPMvbhgAXP2phr9JCkb4IFdVnk6JoS8RqsyCwm
	9ucPWCcHmlaomogewehAHx3izAdQzDQZeHeIoNLCoGnDys1PvxNaY2WzAKEADz8oTUy/kUsxHPqiv
	VplvxEPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qKEXE-0000Kh-0D;
	Fri, 14 Jul 2023 09:52:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qKEXB-00074X-8Z; Fri, 14 Jul 2023 09:52:17 +0100
Date: Fri, 14 Jul 2023 09:52:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chris.chenfeiyang@gmail.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
Message-ID: <ZLEMwUjqXXoWslU+@shell.armlinux.org.uk>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <e491227b-81a1-4363-b810-501511939f1b@lunn.ch>
 <CACWXhKmLRK5aGNwDyt5uc0TK8ZXZKuDQuSXW6jku+Ofh73GUvw@mail.gmail.com>
 <f50469a6-74ed-44bc-a2aa-fafdec717cc3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f50469a6-74ed-44bc-a2aa-fafdec717cc3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 06:26:14AM +0200, Andrew Lunn wrote:
> On Fri, Jul 14, 2023 at 10:24:37AM +0800, Feiyang Chen wrote:
> > On Thu, Jul 13, 2023 at 12:07 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> > > > Add GNET support. Use the fix_mac_speed() callback to workaround
> > > > issues with the Loongson PHY.
> > >
> > > What are the issues?
> > >
> > 
> > Hi, Andrew,
> > 
> > There is an issue with the synchronization between the network card
> > and the PHY. In the case of gigabit operation, if the PHY's speed
> > changes, the network card's speed remains unaffected. Hence, it is
> > necessary to initiate a re-negotiation process with the PHY to align
> > the link speeds properly.
> 
> When the line side speed changes, the PHY will first report link down
> via the adjust_link callback in the MAC driver. Once the PHY has
> determined the new speed, the adjust_link callback will be called
> again with the new speed and pause parameters.

Or in the case of stmmac, phylink is involved, so .mac_link_down will
get called and then .mac_link_up with the new parameters.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

