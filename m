Return-Path: <netdev+bounces-21241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F7762F5C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7671C21154
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A625A959;
	Wed, 26 Jul 2023 08:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F6AD22
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:11:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F405B132
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ipSDKjf8aWICQwTKGMW/CPVUz6BniY6Kc/UbNgl/ZGg=; b=Puhw7lh5Ce+2+cG0KadpOArLBn
	Oiaysb92Edeu8wuyIXG6ikutYuha3c+xo4pEZ5Pi5RkvF7P1Zoey+KWnaOqFWUFkwWssUa+aguvnc
	tmGK3CNo1cAptfyZ4Qr3HR9voNnwj2Cb+K3Cngj29Vp1oVC1v6gxKOtCiyhM8TKVZo56m+Zlp0rvg
	/M6VTL9861lM0q6hUcROEX4JJ/7UlOVdOwk/3y6BTpKorG1g/rgjijU7RP0z/ynS6AcUfOHZ2wUgU
	NXewKzV+Mq4EJkCeIfPmbOB7yI2WsbJZ2P55k2oj8TtY8CMUJCT3fGllnonRAkKi11DNBtiU+Uljd
	Lv+Z9Rlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35568)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOZbu-00048s-0n;
	Wed, 26 Jul 2023 09:11:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOZbn-0002i0-8w; Wed, 26 Jul 2023 09:10:59 +0100
Date: Wed, 26 Jul 2023 09:10:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <ZMDVE1Ju4c6NMrLJ@shell.armlinux.org.uk>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com>
 <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
 <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 10:35:32AM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2023年7月25日 21:12，Russell King (Oracle) <linux@armlinux.org.uk> 写道：
> > 
> > Hi Simon,
> > 
> > Thanks for spotting that this wasn't sent to those who should have
> > been.
> > 
> > Mengyuan Lou, please ensure that you address your patches to
> > appropriate recipients.
> > 
> > On Tue, Jul 25, 2023 at 02:05:36PM +0200, Simon Horman wrote:
> >>> + * @keep_data_connection: Set to true if the PHY or the attached MAC need
> >>> + *                        physical connection to receive packets.
> > 
> > Having had a brief read through, this comment seems to me to convey
> > absolutely no useful information what so ever.
> > 
> > In order to receive packets, a physical connection between the MAC and
> > PHY is required. So, based on that comment, keep_data_connection must
> > always be true!
> > 
> > So, the logic in phylib at the moment is:
> > 
> >        phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
> >        /* If the device has WOL enabled, we cannot suspend the PHY */
> >        if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> >                return -EBUSY;
> > 
> > wol_enabled will be true if the PHY driver reports that WoL is
> > enabled at the PHY, or the network device marks that WoL is
> > enabled at the network device. netdev->wol_enabled should be set
> > when the network device is looking for the wakeup packets.
> > 
> > Then, the PHY_ALWAYS_CALL_SUSPEND flag basically says that "even
> > in these cases, we want to suspend the PHY".
> > 
> > This patch appears to drop netdev->wol_enabled, replacing it with
> > netdev->ncsi_enabled, whatever that is - and this change alone is
> > probably going to break drivers, since they will already be
> > expecting that netdev->wol_enabled causes the PHY _not_ to be
> > suspended.
> > 
> > Therefore, I'm not sure this patch makes much sense.
> > 
> > Since the phylib maintainers were not copied with the original
> > patch, that's also a reason to NAK it.
> > 
> > Thanks.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> 
> 
> Now Mac and phy in kernel is separated into two parts.
> There are some features need to keep data connection.
> 
> Phy ——— Wake-on-Lan —— magic packets
> 
> When NIC as a ethernet in host os and it also supports ncsi as a bmc network port at same time.
> Mac/mng —— LLDP/NCSI —— ncsi packtes
> I think it need a way to notice phy modules.

Right, so this is _in addtion_ to WoL. Therefore, when adding support
for it, you need to _keep_ the existing WoL support, not remove it in
preference for NCSI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

