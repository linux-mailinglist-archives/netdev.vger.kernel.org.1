Return-Path: <netdev+bounces-44428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF817D7F55
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C9D281EE7
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1526E20;
	Thu, 26 Oct 2023 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MrXr1v46"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997726E17
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:09:05 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01C189;
	Thu, 26 Oct 2023 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eYK3GRIg/s9mJg4qHyC381LOxT1vf4BqjfRhCEkWWsE=; b=MrXr1v46CA82i+sCjIdkB7Lj29
	bUVE9jYnscY7uhm2zq3n+PejuOxqt4IxiHMkTlsKrzsXc3O8aoIamrRUghAJg8iWFHPMZu//Alp2n
	au6kcsCxvBGqkbehRLdjQxsbeWxcTB4MYm5lE8Z5NZZjMBK6Nq4ECiPkqZ6ZJlYyYsruk2RL6Cekj
	u8kinyBS0Kk1RDzT06OVVtMnW3+kDSrB9xm15bbIAlVsB8Dek/DinuEn2nFnZxg/HMP+x3lzIQ1No
	RCjcVFvzT4y7vGJnRedlo0Wbmm18e4bCCB45HnUStkzilVgHjOenehFzgGdGVgqWD0CsJLucYNiZo
	OtUUrISQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52710)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qvwMN-0006VY-2q;
	Thu, 26 Oct 2023 10:08:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qvwMO-0007yO-Ks; Thu, 26 Oct 2023 10:09:00 +0100
Date: Thu, 26 Oct 2023 10:09:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch,
	Jose.Abreu@synopsys.com, fancer.lancer@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V1] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZTosrAStdie0T+8n@shell.armlinux.org.uk>
References: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 26, 2023 at 11:13:05AM +0530, Raju Lakkaraju wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Change List:
> ============
> V0 -> V1:
>   - Remove the auto-negotiation check due to currently the DW_2500BASEX mode 
>     doesn't imply any auto-negotiation 

So I just thought why hadn't I picked up on the link-down code setting
->speed, ->duplex and ->pause in the previous patch. Looking back at
what you call V0, which I guess is:

https://lore.kernel.org/r/20230925075142.266026-1-Raju.Lakkaraju@microchip.com

it's because the code wasn't there, and neither is its addition listed
in the above change list. That makes the change list rather misleading.

If you're going to provide a list of changes, please ensure it
describes all the changes from the previous iteration, or don't bother
including a list of changes. No list of changes is better than an
incomplete and thus misleading list of changes.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

