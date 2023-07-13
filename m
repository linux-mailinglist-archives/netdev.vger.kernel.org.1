Return-Path: <netdev+bounces-17542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E9751F35
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241B71C212EA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC676124;
	Thu, 13 Jul 2023 10:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD4100A0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:46:21 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B11FC0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TF0bJap6iKwBGPVUt0G5h/2lz6JhAk46FqhiRHsellE=; b=HRlG1j/VRU2HA0CjHUfB6vKiw0
	OfMi1z6ZwHJAdXs9vebxxsDouGrLv9107gS5Fq51nnqN+MbcCvh/RJ0dfnXIWSGzN4Xg6qw40X6mj
	vDf0AZRsFCTrGHZu4X23bqjyh1xWH+TkAoR19YtllaH2ur32cfXFqylfn34+RSXGaRmQqreeYFz3G
	5OuPH4I76MkD8ZbwllETwGYO+q8RVUPHTXDpQdH3zgDW2QFcIizbVpy3OaZSJCxjCVIw8d99gVyLd
	6H9COempN7BFlxEOCOHx31tQ215+MSV+Gmo9ux/sGnp6jRgOhRu+FShYRAiEi6SpSKSl9F30WzWQi
	3I03CI+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42468)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJtpp-0006cG-20;
	Thu, 13 Jul 2023 11:46:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJtpo-00065c-Bw; Thu, 13 Jul 2023 11:46:08 +0100
Date: Thu, 13 Jul 2023 11:46:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: kabel@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/V8NyFw+SWUF3V@shell.armlinux.org.uk>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712062634.21288-1-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> it sometimes does not take effect immediately. This will cause
> mv3310_reset() to time out, which will fail the config initialization.
> So add to poll PHY power up.

Can you check how long it takes for the PWRDOWN bit to clear? The
datasheet says that hardware reset or a MDIO write to this register
can clear this bit. It doesn't say that it needs to be polled or
that it takes time to clear before reset is possible.

So, I think a little more explanation and investigation would be
useful.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

