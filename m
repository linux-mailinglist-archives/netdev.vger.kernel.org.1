Return-Path: <netdev+bounces-25525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75485774712
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD71281889
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796B171DC;
	Tue,  8 Aug 2023 19:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD296171D8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CAB196F2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Ds7p/gA/xFdBBXr45JuhHHWA6RLYVLGnCUIhZAPDD0=; b=W+lLEQOCOrxTp3hae0/zE74Kk2
	30XDLLhH4UB9SqV4Qfa1zxf41TyQxCLpSclTKM88w+AY5oXASHUX4fhVBFUxTcWsuQMkpacV6eyAe
	RmcDUwMAi6q4f2g+pCcy5Vi00NTZWL82UrqcQIHwQCIQvvaDbmOSdjP5wySaMxtkvZpu6z8pvZmRG
	hL/nrmWnHc/nFAsWEwtZ/2deVjdTZc40Psm/s+7RgFQwtJe4xwnknFg6YxbR8g1hnpybBfTWTaRrf
	sF5vOEwJkYdnk4If4J7siG4YTk6+rL3EyOBNDGW8B68HA073mKquwSM2sohpwXpmdvBaHFcRYXEpQ
	TMGSEEnw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTIu3-0006x1-1r;
	Tue, 08 Aug 2023 10:21:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTItw-0007y0-OH; Tue, 08 Aug 2023 10:21:16 +0100
Date: Tue, 8 Aug 2023 10:21:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	hkallweit1@gmail.com, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor
 supoprt for Wangxun 10Gb NICs
Message-ID: <ZNIJDMwlBa/LRJ0C@shell.armlinux.org.uk>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
 <20230808021708.196160-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808021708.196160-2-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 10:17:02AM +0800, Jiawen Wu wrote:
> Since Wangxun 10Gb NICs require some special configuration on the IP of
> Synopsys Designware XPCS, introduce dev_flag for different vendors. The
> vendor identification of wangxun devices is added by comparing the name
> of mii bus.
> 
> And interrupt mode is used in Wangxun devices, so make it to be the first
> specific configuration.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Does the XPCS in Wangxun devices have the device identifiers (registers
2 and 3) and the package identifiers (registers 14 and 15) implemented,
and would they be set to an implementation specific value that would
allow their integration into Wangxun devices to be detected?

If the answer to that is yes, it would be preferable to use that
rather than adding a bitarray of flags to indicate various "quirks".

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

