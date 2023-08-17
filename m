Return-Path: <netdev+bounces-28430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E738077F68F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF54A1C213BD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2D134BA;
	Thu, 17 Aug 2023 12:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFA2907
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:42:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E62D5F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VO4EpR2CS4ifSa9fZSZIQ7o7gsJKZ/yPTTtnlb4VJiI=; b=HO0PeURfwQmoli1LTkWnuaGife
	co1q/CUebcnuEEyLfJaK/wsJU0LnesouQuVR5W2YQOO6dNF3ou06i6qZuOFbAjXbHzPBjIK43uOHm
	eZyWgmDapmFEOn0+jSyJNcMZzMaaWQ0qrWjSvnO6mNMpBnckfczLtxw9hqJLyd4u1KI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWcK0-004NHv-B9; Thu, 17 Aug 2023 14:41:52 +0200
Date: Thu, 17 Aug 2023 14:41:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bryan.whitehead@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, mdf@kernel.org, pgynther@google.com,
	Pavithra.Sathyanarayanan@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: bgmac: Fix return value check for
 fixed_phy_register()
Message-ID: <039324dd-96ae-41df-974a-6519ff8f8983@lunn.ch>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817121631.1878897-3-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 08:16:29PM +0800, Ruan Jinjie wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> And it also returns -EPROBE_DEFER, -EINVAL and -EBUSY, etc, in addition to
> -ENODEV, just return -ENODEV is not sensible, use
> PTR_ERR to fix the issue.

I would recommend changing not sensible to best practice, as i
suggested in one of your other patches.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
pw-bot: cr

