Return-Path: <netdev+bounces-134429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736C999592
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7C2B24158
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093D1BE857;
	Thu, 10 Oct 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e0hZNGTQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B25178372;
	Thu, 10 Oct 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601276; cv=none; b=mHkdpsNbS9+4cx42Zvoqv9uBONsKNAntf299jwd6stacWFAMx2vYU1HbVduTdD7M+fBR4gKqc3E+7F79aKXOrI1PqFvGaYjmKSfjwHsGSby+JTRR8ZRxOlF0zEXtrt9gsj5gtZ6nW0dfO2UysRIjVlGkBh8wvG/CyGPVOHeAVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601276; c=relaxed/simple;
	bh=4Pf1hIXPptEQQWOvIgmxJcPTeFp27a6eBCiRx1Sqbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av3tK+uLgfLCy9O75omepeBlnuJnNF9JWS3np4aQQuI6oepHxLNzY9s6NhK/0pBNzz8IK/vn1NKlYGQ3eNyRwI0LrM0X/J2wTTSQ+bGTBSpAyIAVXctPJYmsg2V5obQAPxOZthOi2MMBazXdsXTOZikwGC8+2+lg0RMz3uUkchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e0hZNGTQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DSLyJomB4Fj4o53QLNL/LpU1x+NLQf/zPGSHGTpKNjs=; b=e0hZNGTQe2JzThbjXmnQNIgEqP
	QWM9lSm3HoFTfnuPC/ndKk/TBnD9vifg0s2SukwC+QlXTBHIZyz9VUiWTs65vdL48M4NME22Akdyp
	GxRd0sGprcUVekB2n9pIU44+9xaunxgdzuCrRVaiaiqF7PQ4lKp6DU00a2XF69qQP21c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sz29O-009fBb-4a; Fri, 11 Oct 2024 01:00:54 +0200
Date: Fri, 11 Oct 2024 01:00:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Iulian Gilca <igilca1980@gmail.com>
Cc: igilca@outlook.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: net: Add option for random mac address
Message-ID: <c176cabc-36fc-4c87-bfc3-403feceff41f@lunn.ch>
References: <3287d9dd-94c2-45a8-b1e7-e4f895b75754@lunn.ch>
 <20241010215417.332801-1-igilca1980@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010215417.332801-1-igilca1980@gmail.com>

On Thu, Oct 10, 2024 at 05:54:17PM -0400, Iulian Gilca wrote:
> Embedded devices that don't have a fixed mac address may want
> to use this property. For example dsa switch ports may use this property in
> order avoid setting this from user space. Sometimes, in case of DSA switch
> ports is desirable to use a random mac address rather than using the 
> conduit interface mac address.
> 
> example device tree config :
> 
> 	....
> 	netswitch: swdev@5f {
> 		compatible = "microchip,ksz9897";
> 		...
> 		ports {
> 			port@0 {
> 				reg = <0>;
> 				label = "eth0";
> 				random-address;
> 			}
> 			...
> 		}
> 	}
> 
> 	...
> 
> This way the switch ports that have the "random-address" property 
> will use a random mac address rather than the conduit mac address.
> 
> PS. Sorry for the previous malformed patch

In addition to Russells emai:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and it is much better to answer questions asked than post yet another
patch. Yes, the commit message is better, but it still does not fully
explain 'Why?' and convince us this is the correct solution to your
problem. What _is_ the problem you are trying to solve?

    Andrew

---
pw-bot: cr

