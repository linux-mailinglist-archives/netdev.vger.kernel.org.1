Return-Path: <netdev+bounces-53115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8E280163A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7186281D98
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF39619A5;
	Fri,  1 Dec 2023 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IQgfbDp4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD518F9;
	Fri,  1 Dec 2023 14:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0YeKe38MCrbQesPsJdegEblZNIUseQAaYdflCSTF2gM=; b=IQgfbDp4m3ZyPvsfgRB2D+yjWW
	Rz3b1zgPqlfs80ee3EJ5GHZZSagdO1MrgHfK8YS6nq553KR6VPnJ//r7UXdMcol/5gHMxwaLPIPuK
	hDQ2WmX/aoeKAUG64YY9ckJDYVyIgCj6dn6hyvaOe063HZ2Fhh2ALMpyM0wDa/zDzACY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9BtT-001o3B-5Y; Fri, 01 Dec 2023 23:21:55 +0100
Date: Fri, 1 Dec 2023 23:21:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/2] net: phy: micrel: allow usage of generic
 ethernet-phy clock
Message-ID: <6e806ed2-cca9-4b88-882f-16961a56c87b@lunn.ch>
References: <20231201150131.326766-1-heiko@sntech.de>
 <20231201150131.326766-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201150131.326766-3-heiko@sntech.de>

On Fri, Dec 01, 2023 at 04:01:31PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The generic ethernet-phy binding allows describing an external clock since
> commit 350b7a258f20 ("dt-bindings: net: phy: Document support for external PHY clk")
> for cases where the phy is not supplied by an oscillator but instead
> by a clock from the host system.
> 
> And the old named "rmii-ref" clock from 2014 is only specified for phys
> of the KSZ8021, KSZ8031, KSZ8081, KSZ8091 types.
> 
> So allow retrieving and enabling the optional generic clock on phys that
> do not provide a rmii-ref clock.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

