Return-Path: <netdev+bounces-47424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F77EA28C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B3A280E4D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D922333;
	Mon, 13 Nov 2023 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wyJHSjP6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD622EF1
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:06:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE07C2;
	Mon, 13 Nov 2023 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GH8IazR1v7qVjUSKdKqHHQQ/JD0K6htrT3oATBABphA=; b=wyJHSjP6kK0K51o3ZozRkmibs+
	LynV2BZGYmm0A4/J6heS7/S5F6kLgsSY7PxIiRDpsF2lIgbfQKgMi6LGjELaZD+rNTFiYD7hzHFY2
	9v+obL+elgPt9nnjmI+FWPzEnKVvB2KiIp3lnIrYhcxwmGNT6l47/AYAOofoCuCWZ0Vw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2bKV-0005pW-Fd; Mon, 13 Nov 2023 19:06:35 +0100
Date: Mon, 13 Nov 2023 19:06:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing
 ETH_P_REALTEK constant
Message-ID: <9aa9ca94-9c77-4369-9c11-987c058f0750@lunn.ch>
References: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113165030.2440083-1-florian.fainelli@broadcom.com>

On Mon, Nov 13, 2023 at 08:50:30AM -0800, Florian Fainelli wrote:
> No functional change, uses the existing ETH_P_REALTEK constant already
> defined in if_ether.h.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

