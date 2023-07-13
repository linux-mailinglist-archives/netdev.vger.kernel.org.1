Return-Path: <netdev+bounces-17540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC84751EE8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54F1281E0C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72BD11CB1;
	Thu, 13 Jul 2023 10:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB341ED53
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:35:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702E1BEB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=43upU6EwrOJ/ayBVL8avYJ2gGxFwgzHO+Gp/s0xlDAI=; b=1OPArRkJpo9hvsoZZQkUML3E51
	CGsN2Nf2xSoGkkTQ77MJUzgFmiqxurIToDvUzYOrImw7b36UVDsp9yBLfVYYh1mWfb0TvtVt0gMro
	U70a6PFxa4CLOIgK9LcpxbXzCCbbpzlCva74+XC4TNtifQVl0gJimk8/n06E9xBX79h/ezSJLnpXM
	QV59u3uRUPiRpjJscwuqqSsM4yerMbUfpZyE9VpRTPTsbqPvzSKTYqNirNyNBf9hRPyQ+kIaSdc+q
	E7Mz4KqqXIbVNvxKX1OHp8yUA7myozQmWXhKMlNkVL+C9FTSnw+gkeb1wqC+EZqJnihl2yLi++P0B
	QkU2QAwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53516)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJtfE-0006VY-03;
	Thu, 13 Jul 2023 11:35:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJtf7-00064Z-Hu; Thu, 13 Jul 2023 11:35:05 +0100
Date: Thu, 13 Jul 2023 11:35:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/RYFBjI5OypfTB@corigine.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > it sometimes does not take effect immediately. This will cause
> > mv3310_reset() to time out, which will fail the config initialization.
> > So add to poll PHY power up.
> > 
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> Hi Jiawen Wu,
> 
> should this have the following?
> 
> Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")

What is that commit? It doesn't appear to be in Linus' tree, it doesn't
appear to be in the net tree, nor the net-next tree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

