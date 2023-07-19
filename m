Return-Path: <netdev+bounces-18893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C318759034
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF34281185
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B76101E3;
	Wed, 19 Jul 2023 08:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA4C2E9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:27:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AA1723
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N6+akn0phQziho/EEIuyUoRqe176z1tkVAjC0tqL/uA=; b=zG6HJnwySxIOsmwC7+CMKFn3mh
	9jAihdxKWN4o3d8Evgb3v5tEHQ/Lof+oFODK4TD+SiSpPO53cpTJDeuYmAnFdk7lK2MkK84KnJWzC
	VumqNsK4JfMQoy2G0X+IXC1oLEHxRLMQW75E4NhhQ2fVcSgT7ef/e6aDZZ2MbpN4fVSNdMaKzpK8d
	A3CmRo777SRDyvdROYiAjfuZkM1NF6q7zfmqdrsUyPTMHw3bZ9pNyC4qCKwAwbrygcnlj2D89GpV3
	tdgiXq5kf5yLufftL/5ZAdIkJWdFehSVZe2XhM4Hp2vQk5wjukf8mPMEg7IpwLnhra890B09hrRxf
	StpYJTqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qM2Wm-0007Ac-2g;
	Wed, 19 Jul 2023 09:27:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qM2Wj-0003v5-15; Wed, 19 Jul 2023 09:27:17 +0100
Date: Wed, 19 Jul 2023 09:27:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <simon.horman@corigine.com>, kabel@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZLeeZMU4HeiHthQ2@shell.armlinux.org.uk>
References: <043501d9b580$31798870$946c9950$@trustnetic.com>
 <011201d9b89c$a9a93d30$fcfbb790$@trustnetic.com>
 <ZLUymspsQlJL1k8n@shell.armlinux.org.uk>
 <013701d9b957$fc66f740$f534e5c0$@trustnetic.com>
 <ZLZgHRNMVws//QEZ@shell.armlinux.org.uk>
 <013e01d9b95e$66c10350$344309f0$@trustnetic.com>
 <ZLZ70F74dPKCIdtK@shell.armlinux.org.uk>
 <017401d9b9e8$ddd1dd90$997598b0$@trustnetic.com>
 <ZLeHyzsRqxAj4ZGO@shell.armlinux.org.uk>
 <01b401d9ba16$aacf75f0$006e61d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b401d9ba16$aacf75f0$006e61d0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 03:57:30PM +0800, Jiawen Wu wrote:
> > According to this read though (which is in get_mactype), the write
> > didn't take effect.
> > 
> > If you place a delay of 1ms after phy_clear_bits_mmd() in
> > mv3310_power_up(), does it then work?
> 
> Yes, I just experimented, it works well.

Please send a patch adding it, with a comment along the lines of:

	/* Sometimes, the power down bit doesn't clear immediately, and
	 * a read of this register causes the bit not to clear. Delay
	 * 1ms to allow the PHY to come out of power down mode before
	 * the next access.
	 */

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

