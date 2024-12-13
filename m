Return-Path: <netdev+bounces-151868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAD9F16B1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9601B18879B5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC55187555;
	Fri, 13 Dec 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0UV6EKHn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1383383;
	Fri, 13 Dec 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119138; cv=none; b=ATDo58JdcwI+9/3v0EPeB2cZdJyo8G4a6qLlhneKws+CfqstSnlu+0sjbPDAVsQyXAa4qQthwfAOztzdMHcJdBqqM51Z6/1XAbasuP+AmhTuZQhGsbqZ5dMN2VZo8QBiLjH361rL0y8f6nZx8wYKVRBCb11dXql1u0Qo1Y2dk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119138; c=relaxed/simple;
	bh=/NGVVzayzEEZuxZAoyNwRjkMZVsgtmClsk+jQ6Ass9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi/54WYQie9UptyDT0VRlQKJvVolv2qSvu8LyYGthykbjSZ3eKz9mkCFBk590TBP5YjS/y5duHNHHB957khoHmaWpkmTgTWGzzsY7t7tGbpsshbXM8ii0rrNPEvZKaZ+FPk+SwT2h3sGOveNYK23hdw5Hd8kel+L5wYeM/1Vw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0UV6EKHn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2OKWWGal3o7LbTV2TO3uDGVhmx9PqnQujifRZi9s2So=; b=0UV6EKHnRYzDrMqVxlBYCouvTp
	FlYRRMm0syDARUJNEYq7CGX0KQCnszoZMQCtZ93d0oGy7OGL2t/a7f+uCcGXMRSfRGqILVSZRp2yJ
	cWNVXNCKl3yRizT26AuIaDtOmNIuUjKOLkGpJB87Vc0gO+15C9lxkb0sDboR+eAg2sjyfghav+OBi
	9O3VJBM9xERg6lUmPOIBWUvYpf6SgbEowi/FuHczwpBcWEEPUXjY0yHyONW6nCIUqc4K/ivQe9sOJ
	cou9JA3e/M2lKQPihGgaFbz8YFBZrKZvOjP0bvdNRmTl2G/bM/NVXXWWlWqY98O558A8vs+K1u+fx
	RVOYHXiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tMBbE-0007Fd-2S;
	Fri, 13 Dec 2024 19:45:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tMBbC-0006Yr-0S;
	Fri, 13 Dec 2024 19:45:18 +0000
Date: Fri, 13 Dec 2024 19:45:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robert.marko@sartura.hr
Subject: Re: [PATCH net-next v4 5/9] net: sparx5: only return PCS for modes
 that require it
Message-ID: <Z1yOzaL-gwXIE94O@shell.armlinux.org.uk>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
 <20241213-sparx5-lan969x-switch-driver-4-v4-5-d1a72c9c4714@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-5-d1a72c9c4714@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 02:41:04PM +0100, Daniel Machon wrote:
> The RGMII ports have no PCS to configure. Make sure we only return the
> PCS for port modes that require it.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

