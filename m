Return-Path: <netdev+bounces-20858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E9761978
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EFD28110A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45931F18C;
	Tue, 25 Jul 2023 13:12:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C051F16B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:12:20 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1FE3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LD0iD1VRWc9FfRtkG7bWW6KgUZYaqv7XY+vRMbei1gM=; b=OcPWtWyHkH4vGIPHN3qLDpcJ0s
	Em3uKk8pBMjvlJShj0EzBgEqC1SnlfCf5ZvX5UowHGbrojVjL9opUPyppuyN2h5OwKr7vdtrkMdhA
	9/Aa/9hwpGaKqAPONfson9IEnlMWAndpKoJNOycX82UoVQA5D8DV9D5ZSmrvMCF7wQ9n5tfVZ/1zx
	cREks6tlG9XyXYInldy96xXJyQUjaUC/63Xlf7aaIuqc7iOhguq02Qnqw905WWcsbx37S/QwL2rMw
	dkmLwQYB30jjWoLK7SBoL5aM8FUYdmXIA7Id/MpWTk0xyOkfPfW+WxjfKupWeFO0fmggI0OnYuIGo
	sh5M9e/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOHpi-00023x-19;
	Tue, 25 Jul 2023 14:12:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOHpa-0001re-Ny; Tue, 25 Jul 2023 14:12:02 +0100
Date: Tue, 25 Jul 2023 14:12:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL+6kMqETdYL7QNF@corigine.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Thanks for spotting that this wasn't sent to those who should have
been.

Mengyuan Lou, please ensure that you address your patches to
appropriate recipients.

On Tue, Jul 25, 2023 at 02:05:36PM +0200, Simon Horman wrote:
> > + * @keep_data_connection: Set to true if the PHY or the attached MAC need
> > + *                        physical connection to receive packets.

Having had a brief read through, this comment seems to me to convey
absolutely no useful information what so ever.

In order to receive packets, a physical connection between the MAC and
PHY is required. So, based on that comment, keep_data_connection must
always be true!

So, the logic in phylib at the moment is:

        phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
        /* If the device has WOL enabled, we cannot suspend the PHY */
        if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
                return -EBUSY;

wol_enabled will be true if the PHY driver reports that WoL is
enabled at the PHY, or the network device marks that WoL is
enabled at the network device. netdev->wol_enabled should be set
when the network device is looking for the wakeup packets.

Then, the PHY_ALWAYS_CALL_SUSPEND flag basically says that "even
in these cases, we want to suspend the PHY".

This patch appears to drop netdev->wol_enabled, replacing it with
netdev->ncsi_enabled, whatever that is - and this change alone is
probably going to break drivers, since they will already be
expecting that netdev->wol_enabled causes the PHY _not_ to be
suspended.

Therefore, I'm not sure this patch makes much sense.

Since the phylib maintainers were not copied with the original
patch, that's also a reason to NAK it.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

