Return-Path: <netdev+bounces-194401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BAAC93B8
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D861B7AC3A5
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A41C6FE8;
	Fri, 30 May 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uHJFaY3o"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3413635E;
	Fri, 30 May 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623095; cv=none; b=HmhiaVy8iFbnvbUc/TgIjfEKKDyQDFB0+sBmkGK8bdC/EDqD3ohxrWZD6HbjShwpMgm0Yo3MOgp3ZvzGkjgzM/5SHjnaCeCzVhhLB4ufJEL2Hdytu9YgMH/Rxt0VwfYKLUENoG5RGZQPbRPqGxCxqrV4YN2VSj+i440cJPluNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623095; c=relaxed/simple;
	bh=+jp3st4HoIUjB7GR39tDAkYlvgYMFPVzN2cCi5ne6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAynEMUK42ijtXVJiu3kArplbJHfmvjBgVD2gAI5rWdiIQwQURnU7waVv0g4aeD/xdEiuwRXKN5lsJQV/x1QfIFfnN+G0SzB5ZFw+c/q6D7/24NFYpsOnzs4yXhRWzV90hvH0z4AhgNkr9svCjrWu+yuDOvZAVazz/MubXENcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uHJFaY3o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TFob6bHbt9evz3lA1lPRqmDyommaykyRcKttnYjRsmk=; b=uHJFaY3ojfDQ39JRVwhAlbj8t8
	1Y5rFZax7qQUv5Cij4StrfieciR/Co5CJwpK5qF7VQia1udFwAObBb4qN3q7xzZrUMhYZKK97F+JZ
	xjy8OW2hrcSbn/lwTqXuqrjDYtD7Qvp8DGUssryzW86/rd7piheZNH9yUJ7jlZ4jRyGfi1ReXW6+F
	t4Z2rO9xKJvT+KUrMh8aVEecqXkGTx4Bha4rvpaiIkf05EZQviIhjAfB05PimgT93oP8nju4ugggV
	8EDDqj05B1X/blg87CNyQ0wwusKrU6SDEvUe4DBaWgx8vE6gcqFMD2DwsfwLZ158BF/lxdGqRGGAI
	cwgA5dgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uL2js-0002Yx-2v;
	Fri, 30 May 2025 17:37:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uL2jl-0004kI-2u;
	Fri, 30 May 2025 17:37:41 +0100
Date: Fri, 30 May 2025 17:37:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jonas@kwiboo.se,
	david.wu@rock-chips.com, jan.petrous@oss.nxp.com,
	detlev.casanova@collabora.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwmac-rk: No need to check the return value of the
 phy_power_on()
Message-ID: <aDne1Ybuvbk0AwG0@shell.armlinux.org.uk>
References: <20250530162017.3661-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530162017.3661-1-sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 30, 2025 at 09:20:17AM -0700, 李哲 wrote:
> phy_power_on() is a local scope one within the driver, since the return
> value of the phy_power_on() function is always 0, checking its return
> value is redundant.
> 
> Signed-off-by: 李哲 <sensor1010@163.com>

Patch looks generally good, nice to see the reverse christmas tree
ordering of local variables resulting from this patch. However, the
subject line needs to be adjusted to meet netdev requirements. Please
see
https://www.kernel.org/doc/html/v5.1/networking/netdev-FAQ.html#q-how-do-i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in
Please wait a minimum of one day before sending an updated version.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Please can you also follow up with a patch to change the function name
from "phy_power_on()" as this may conflict with the PHY subsystems
"int phy_power_on(struct phy *phy);"

"rk_phy_power_set()" would probably be a good alternative name,
especially as when the 2nd argument is false, the function turns the
PHY off.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

